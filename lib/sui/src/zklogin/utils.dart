import 'dart:typed_data';

import 'package:blockchain_utils/blockchain_utils.dart';
import 'package:on_chain/exception/onchain_error.dart';
import 'package:on_chain/sui/src/address/address/address.dart';
import 'package:on_chain/sui/src/keypair/core/core.dart';
import 'package:on_chain/sui/src/zklogin/jwks.dart';
import 'package:on_chain/sui/src/zklogin/jwt.dart';

/// Pure helpers for Sui zkLogin (address derivation, nonces, v1 inputs and
/// JWT RSA verification).
///
/// All members are static; this class is not meant to be instantiated.
/// Field arithmetic routes through `blockchainUtils.api` (Dart / native
/// backends), mirroring the TS SDK and fastcrypto.
class SuiZkLoginUtils {
  const SuiZkLoginUtils._();

  /// Max field lengths for address-seed hashing (TS SDK constants).
  static const int maxKeyClaimNameLength = 32;
  static const int maxKeyClaimValueLength = 115;
  static const int maxAudValueLength = 145;

  /// V1 circuit field-length config (fastcrypto `CircuitVersion::V1`).
  static const int v1MaxHeaderLenB64 = 248;

  /// `4 * (1 + 165 / 3)` (V1 `max_iss_len`).
  static const int v1MaxIssLen = 224;

  /// V1 RSA bound used for the modulus hash.
  static const int v1MaxRsaBits = 2048;

  /// Pack width for field packing (fastcrypto `PACK_WIDTH`).
  static const int _packWidth = 248;

  /// DigestInfo prefix for SHA-256 in EMSA-PKCS1-v1_5.
  static const List<int> _sha256DigestInfoPrefix = [
    0x30,
    0x31,
    0x30,
    0x0d,
    0x06,
    0x09,
    0x60,
    0x86,
    0x48,
    0x01,
    0x65,
    0x03,
    0x04,
    0x02,
    0x01,
    0x05,
    0x00,
    0x04,
    0x20,
  ];

  /// circomlib-compatible BN254 Poseidon over [fields], routed through
  /// `blockchainUtils.api` (Dart / native backends).
  static BigInt poseidonHashFields(List<BigInt> fields) {
    return BigintUtils.fromBytes(
      blockchainUtils.api.hash.poseidonBn254Hash([
        for (final f in fields)
          ...BigintUtils.toBytes(f, length: 32, byteOrder: Endian.little),
      ]),
      byteOrder: Endian.little,
    );
  }

  /// `accounts.google.com` (without scheme) normalizes to the full issuer.
  static String normalizeIssuer(String iss) {
    if (iss == 'accounts.google.com') {
      return 'https://accounts.google.com';
    }
    return iss;
  }

  /// Poseidon-BN254 hash of an ASCII string, padded to `maxSize` chars and
  /// packed 31 bytes per field element (matches `hashASCIIStrToField`).
  static BigInt hashAsciiStrToField(String str, int maxSize) {
    for (int i = 0; i < str.length; i++) {
      final code = str.codeUnitAt(i);
      if (code > 0x7e || (code < 0x20 && code != 0)) {
        throw BuError(
          OnChainErrorType.suiPlugin,
          'zkLogin string contains a non-ASCII character.',
          details: {'value': str},
        );
      }
      if (code < 0x20 || code == 0x22 || code == 0x5c) {
        throw BuError(
          OnChainErrorType.suiPlugin,
          'zkLogin claim contains a JSON-escaped character.',
          details: {'value': str},
        );
      }
    }
    if (str.length > maxSize) {
      throw BuError(
        OnChainErrorType.suiPlugin,
        'zkLogin string longer than $maxSize chars.',
        details: {'value': str},
      );
    }
    final padded = List<int>.generate(
      maxSize,
      (i) => i < str.length ? str.codeUnitAt(i) : 0,
    );
    // First chunk is smaller when uneven (mirrors chunkArray).
    final chunks = <List<int>>[];
    final full = padded.length ~/ 31;
    final first = padded.length - full * 31;
    if (first > 0) chunks.add(padded.sublist(0, first));
    for (int i = 0; i < full; i++) {
      chunks.add(padded.sublist(first + i * 31, first + (i + 1) * 31));
    }
    return poseidonHashFields([
      for (final chunk in chunks) BigintUtils.fromBytes(chunk),
    ]);
  }

  /// `genAddressSeed(salt, name, value, aud)` (TS SDK `genAddressSeed`).
  static BigInt genAddressSeed({
    required BigInt salt,
    required String name,
    required String value,
    required String aud,
  }) {
    return poseidonHashFields([
      hashAsciiStrToField(name, maxKeyClaimNameLength),
      hashAsciiStrToField(value, maxKeyClaimValueLength),
      hashAsciiStrToField(aud, maxAudValueLength),
      poseidonHashFields([salt]),
    ]);
  }

  /// Address from a seed. `legacyAddress=false` is the current derivation
  /// (unpadded seeds); `true` keeps the pre-fix minimal-byte form.
  static SuiAddress computeAddressFromSeed({
    required BigInt addressSeed,
    required String iss,
    required bool legacyAddress,
  }) {
    // Fixed 32-byte big-endian form (the seed is a BN254 Fr element, so it
    // always fits); legacy mode keeps the minimal-byte form.
    final seedBytes =
        legacyAddress
            ? BigintUtils.toBytes(addressSeed)
            : BigintUtils.toBytes(addressSeed, length: 32);
    final issBytes = StringUtils.encode(normalizeIssuer(iss));
    final tmp = [
      SuiSigningScheme.zklogin.value,
      issBytes.length,
      ...issBytes,
      ...seedBytes,
    ];
    final digest = QuickCrypto.blake2b256Hash(tmp);
    return SuiAddress.fromBytes(digest);
  }

  /// Full derivation from OIDC claims (TS SDK `computeZkLoginAddress`).
  static SuiAddress computeAddress({
    required String claimName,
    required String claimValue,
    required String iss,
    required String aud,
    required BigInt userSalt,
    required bool legacyAddress,
  }) {
    return computeAddressFromSeed(
      addressSeed: genAddressSeed(
        salt: userSalt,
        name: claimName,
        value: claimValue,
        aud: aud,
      ),
      iss: iss,
      legacyAddress: legacyAddress,
    );
  }

  /// Login nonce for the OAuth request (TS SDK `generateNonce`).
  ///
  /// `ephemeralPublicKey` is the `flag || key` bytes; returns 27-char
  /// base64url (no padding) of the last 20 bytes of the Poseidon digest.
  static String generateNonce({
    required List<int> ephemeralPublicKey,
    required int maxEpoch,
    required BigInt randomness,
  }) {
    final publicKeyBigInt = BigintUtils.fromBytes(ephemeralPublicKey);
    final digest = poseidonHashFields([
      publicKeyBigInt ~/ BigInt.from(2).pow(128),
      publicKeyBigInt % BigInt.from(2).pow(128),
      BigInt.from(maxEpoch),
      randomness,
    ]);
    // Fixed 32-byte big-endian digest; the nonce is the last 20 bytes.
    final bytes = BigintUtils.toBytes(digest, length: 32);
    final last20 = bytes.sublist(bytes.length - 20);
    final nonce = B64Encoder.encode(last20, urlSafe: true, noPadding: true);
    if (nonce.length != 27) {
      throw BuError(
        DefaultErrorType.invalidLength,
        'zkLogin nonce has wrong length.',
        details: {'nonce': nonce},
      );
    }
    return nonce;
  }

  /// Splits `flag || key` (33..47 bytes) into two field elements: everything
  /// but the last 16 bytes, then the last 16 bytes (big-endian). Mirrors
  /// fastcrypto `split_to_two_frs` (both parts always fit in BN254 Fr).
  static (BigInt, BigInt) splitEphemeralKey(List<int> keyBytes) {
    if (keyBytes.length < 33 || keyBytes.length > 47) {
      throw BuError(
        DefaultErrorType.invalidLength,
        'Invalid ephemeral key length for zkLogin.',
        details: {'length': keyBytes.length.toString()},
      );
    }
    return (
      BigintUtils.fromBytes(keyBytes.sublist(0, keyBytes.length - 16)),
      BigintUtils.fromBytes(keyBytes.sublist(keyBytes.length - 16)),
    );
  }

  /// `hash_to_field([modulus], max_rsa_bits, 248)`: the modulus as one
  /// `max_rsa_bits`-wide BigUint, packed into 248-bit field elements
  /// (first chunk smaller when uneven) and Poseidon-hashed. Mirrors
  /// fastcrypto `cached_modulus_hash` (without the cache).
  static BigInt modulusHash(List<int> modulusBytes, {int maxRsaBits = 2048}) {
    final value = BigintUtils.fromBytes(modulusBytes);
    if (value.bitLength > maxRsaBits) {
      throw BuError(
        DefaultErrorType.invalidLength,
        'Modulus exceeds the RSA bit bound.',
        details: {'bits': value.bitLength.toString()},
      );
    }
    // Ascending 248-bit chunks of the maxRsaBits-wide value (first chunk
    // smaller when uneven) — the arithmetic form of bits.rchunks().reversed().
    final totalChunks = (maxRsaBits + _packWidth - 1) ~/ _packWidth;
    int firstSize = maxRsaBits % _packWidth;
    if (firstSize == 0) firstSize = _packWidth;
    final chunks = <BigInt>[];
    int shift = maxRsaBits;
    for (int i = 0; i < totalChunks; i++) {
      final size = i == 0 ? firstSize : _packWidth;
      shift -= size;
      chunks.add((value >> shift) & ((BigInt.one << size) - BigInt.one));
    }
    return poseidonHashFields(chunks);
  }

  /// The v1 Groth16 public input for a zkLogin proof:
  /// `Poseidon(first, second, addressSeed, maxEpoch, issHash, indexMod4,
  /// headerHash, modulusHash)`. All inputs fit BN254 Fr by construction.
  static BigInt calculateAllInputsHashV1({
    required List<int> ephemeralPublicKeyBytes,
    required BigInt addressSeed,
    required BigInt maxEpoch,
    required String issBase64Value,
    required int indexMod4,
    required String headerBase64,
    required List<int> modulusBytes,
  }) {
    final (first, second) = splitEphemeralKey(ephemeralPublicKeyBytes);
    return poseidonHashFields([
      first,
      second,
      addressSeed,
      maxEpoch,
      hashAsciiStrToField(issBase64Value, v1MaxIssLen),
      BigInt.from(indexMod4),
      hashAsciiStrToField(headerBase64, v1MaxHeaderLenB64),
      modulusHash(modulusBytes),
    ]);
  }

  /// Verifies a JWT's RS256 signature against [jwk] (pure Dart RSA:
  /// `s^e mod n == EMSA-PKCS1-v1_5(SHA256(headerB64.payloadB64))`).
  /// Only `alg == 'RS256'` is accepted. Used to fail fast on forged JWTs
  /// before paying the prover; the chain re-verifies everything anyway.
  static bool verifyJwtRsaSignature({
    required SuiJwtParts parts,
    required SuiJwkKey jwk,
  }) {
    if (parts.alg != 'RS256' || jwk.alg.isNotEmpty && jwk.alg != 'RS256') {
      throw BuError(
        DefaultErrorType.unsupported,
        'Unsupported JWT/JWK algorithm (RS256 only).',
        details: {'jwtAlg': parts.alg, 'jwkAlg': jwk.alg},
      );
    }
    if (jwk.kty != 'RSA' || jwk.e.isEmpty || jwk.n.isEmpty) {
      throw BuError(OnChainErrorType.suiPlugin, 'JWK is not a usable RSA key.');
    }
    List<int> b64u(String s) {
      // JWT/JWK base64url carries no padding.
      return StringUtils.encode(
        s,
        encoding: StringEncoding.base64UrlSafe,
        validateB64Padding: false,
      );
    }

    final n = BigintUtils.fromBytes(b64u(jwk.n));
    final e = BigintUtils.fromBytes(b64u(jwk.e));
    final sig = BigintUtils.fromBytes(b64u(parts.signatureBase64));
    final k = (n.bitLength + 7) ~/ 8;
    if (sig >= n) return false;
    final message = StringUtils.encode(
      '${parts.headerBase64}.${parts.payloadBase64}',
    );
    final hash = QuickCrypto.sha256Hash(message);
    final t = [..._sha256DigestInfoPrefix, ...hash];
    final em = [
      0x00,
      0x01,
      ...List<int>.filled(k - t.length - 3, 0xff),
      0x00,
      ...t,
    ];
    if (em.length != k) return false;
    final encoded = BigintUtils.toBytes(sig.modPow(e, n), length: k);
    for (int i = 0; i < k; i++) {
      if (encoded[i] != em[i]) return false;
    }
    return true;
  }

  /// Fixed 32-byte big-endian encoding of a BN254 field element (G1/G2
  /// coordinate limb for uncompressed Groth16 proofs).
  static List<int> fieldToBytes32(BigInt v) {
    return BigintUtils.toBytes(v, length: 32);
  }
}
