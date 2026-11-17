import 'package:blockchain_utils/blockchain_utils.dart';

import 'package:on_chain/exception/onchain_error.dart';
import 'package:on_chain/sui/src/account/account.dart';
import 'package:on_chain/sui/src/address/address/address.dart';
import 'package:on_chain/sui/src/keypair/keys/zklogin.dart';
import 'package:on_chain/sui/src/zklogin/jwt.dart';
import 'package:on_chain/sui/src/zklogin/jwks.dart';
import 'package:on_chain/sui/src/zklogin/prover.dart';
import 'package:on_chain/sui/src/zklogin/utils.dart';

/// An established zkLogin session: signed JWT claims bound to an ephemeral
/// key, with prover inputs and a ready-to-sign account.
class SuiZkLoginSession {
  final SuiZkLoginAccount account;
  final SuiAddress address;
  final SuiJwtParts jwt;
  final SuiZkLoginInputs inputs;
  final BigInt maxEpoch;
  final BigInt salt;

  const SuiZkLoginSession({
    required this.account,
    required this.address,
    required this.jwt,
    required this.inputs,
    required this.maxEpoch,
    required this.salt,
  });

  /// Raw ephemeral key bytes (without scheme flag).
  static List<int> ephemeralKeyBytes(SuiAccount account) {
    final publicKey = account.publicKey;
    if (publicKey is SuiEd25519AccountPublicKey) {
      return publicKey.publicKey.toBytes().toList();
    } else if (publicKey is SuiSecp256k1AccountPublicKey) {
      return publicKey.publicKey.toBytes().toList();
    } else if (publicKey is SuiSecp256r1AccountPublicKey) {
      return publicKey.publicKey.toBytes().toList();
    }
    throw BuError(
      DefaultErrorType.unsupported,
      'Unsupported ephemeral account type.',
      details: {'type': '${publicKey.runtimeType}'},
    );
  }

  /// `flag || key` bytes used for nonces, prover requests and splitting.
  /// k1/r1 keys must be 33-byte compressed (`base` mode below); longer keys
  /// are rejected with a clear error instead of silently breaking.
  static List<int> extendedEphemeralKey(SuiAccount account) {
    final key = ephemeralKeyBytes(account);
    final extended = [account.scheme.value, ...key];
    if (extended.length < 33 || extended.length > 47) {
      throw BuError(
        DefaultErrorType.invalidLength,
        'Ephemeral key has wrong length for zkLogin (need 33..47 with flag).',
        details: {'length': extended.length.toString()},
      );
    }
    return extended;
  }

  /// Creates a session:
  /// 1. parses + validates the JWT,
  /// 2. optionally verifies its RSA signature ([jwks] required then),
  /// 3. checks the JWT nonce binds (`ephemeralAccount`, `maxEpoch`,
  ///    `jwtRandomness`) — the OAuth-time values,
  /// 4. derives the address seed and address,
  /// 5. fetches the proof and assembles the account.
  static Future<SuiZkLoginSession> create({
    required SuiAccount ephemeralAccount,
    required String jwt,
    required BigInt salt,
    required BigInt maxEpoch,
    required BigInt jwtRandomness,
    required SuiZkLoginProverClient prover,
    String keyClaimName = 'sub',
    SuiJwksCache? jwks,
  }) async {
    final parts = SuiJwtParts.parse(jwt);
    if (jwks != null) {
      final key = await jwks.getKey(parts);
      if (!SuiZkLoginUtils.verifyJwtRsaSignature(parts: parts, jwk: key)) {
        throw BuError(
          OnChainErrorType.suiPlugin,
          'JWT signature does not verify.',
          details: {'kid': parts.kid, 'iss': parts.iss},
        );
      }
    }
    final extendedKey = extendedEphemeralKey(ephemeralAccount);
    final expectedNonce = SuiZkLoginUtils.generateNonce(
      ephemeralPublicKey: extendedKey,
      maxEpoch: maxEpoch.toInt(),
      randomness: jwtRandomness,
    );
    if (parts.nonce != expectedNonce) {
      throw BuError(
        OnChainErrorType.suiPlugin,
        'JWT nonce does not bind this session (wrong key/epoch/randomness).',
        details: {'jwtNonce': parts.nonce},
      );
    }
    final claimValue = parts.claimAsString(keyClaimName);
    if (claimValue.isEmpty) {
      throw BuError(
        OnChainErrorType.suiPlugin,
        'JWT is missing the key claim.',
        details: {'claim': keyClaimName},
      );
    }
    final addressSeed = SuiZkLoginUtils.genAddressSeed(
      salt: salt,
      name: keyClaimName,
      value: claimValue,
      aud: parts.aud,
    );
    final proof = await prover.getProof(
      jwt: jwt,
      extendedEphemeralPublicKey: StringUtils.decode(
        extendedKey,
        encoding: StringEncoding.base64,
      ),
      maxEpoch: maxEpoch,
      jwtRandomness: jwtRandomness.toString(),
      salt: salt.toString(),
      keyClaimName: keyClaimName,
    );
    final inputs = SuiZkLoginInputs(
      proofPoints: proof.proofPoints,
      issBase64Details: proof.issBase64Details,
      headerBase64: parts.headerBase64,
      addressSeed: addressSeed,
    );
    final account = SuiZkLoginAccount.fromClaims(
      ephemeralAccount: ephemeralAccount,
      inputs: inputs,
      maxEpoch: maxEpoch,
      iss: parts.iss,
    );
    return SuiZkLoginSession(
      account: account,
      address: account.toAddress(),
      jwt: parts,
      inputs: inputs,
      maxEpoch: maxEpoch,
      salt: salt,
    );
  }
}
