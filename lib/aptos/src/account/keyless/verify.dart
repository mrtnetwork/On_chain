import 'dart:typed_data';

import 'package:blockchain_utils/blockchain_utils.dart';
import 'package:on_chain/aptos/src/account/keyless/jwks.dart';
import 'package:on_chain/aptos/src/account/keyless/poseidon_pack.dart';
import 'package:on_chain/aptos/src/account/keyless/public_key.dart';
import 'package:on_chain/aptos/src/account/keyless/signature.dart';
import 'package:on_chain/exception/onchain_error.dart';

/// On-chain keyless configuration (`0x1::keyless_account::Configuration` +
/// `Groth16VerificationKey`), needed for local proof verification.
///
/// Fetch both resources from the fullnode (`accounts/0x1/resource/...`) and
/// build with [AptosKeylessConfiguration.fromChainResources]. The chain
/// remains the authority on submit; this only enables off-chain checks
/// (login flows, pre-submit diagnostics) mirroring TS
/// `verifyKeylessSignatureWithJwkAndConfig`.
class AptosKeylessConfiguration {
  /// Compressed VK points as stored on-chain (hex, `0x`-prefixed).
  final String alphaG1;
  final String betaG2;
  final String gammaG2;
  final String deltaG2;
  final List<String> gammaAbcG1;

  final BigInt maxExpHorizonSecs;
  final int maxCommitedEpkBytes;
  final int maxIssValBytes;
  final int maxExtraFieldBytes;
  final int maxJwtHeaderB64Bytes;

  /// Training-wheels Ed25519 pubkey (32 bytes), null when wheels are off.
  final List<int>? trainingWheelsPubkey;

  const AptosKeylessConfiguration({
    required this.alphaG1,
    required this.betaG2,
    required this.gammaG2,
    required this.deltaG2,
    required this.gammaAbcG1,
    required this.maxExpHorizonSecs,
    required this.maxCommitedEpkBytes,
    required this.maxIssValBytes,
    required this.maxExtraFieldBytes,
    required this.maxJwtHeaderB64Bytes,
    required this.trainingWheelsPubkey,
  });

  /// Parses the `Groth16VerificationKey` + `Configuration` resource data maps.
  factory AptosKeylessConfiguration.fromChainResources({
    required Map<String, dynamic> verificationKey,
    required Map<String, dynamic> configuration,
  }) {
    String hexStr(Object? v) => (v as String?) ?? '';
    final tw = configuration['training_wheels_pubkey'] as Map?;
    final twVec = (tw?['vec'] as List?) ?? const [];
    return AptosKeylessConfiguration(
      alphaG1: hexStr(verificationKey['alpha_g1']),
      betaG2: hexStr(verificationKey['beta_g2']),
      gammaG2: hexStr(verificationKey['gamma_g2']),
      deltaG2: hexStr(verificationKey['delta_g2']),
      gammaAbcG1:
          ((verificationKey['gamma_abc_g1'] as List?) ?? const [])
              .map(hexStr)
              .toList(),
      maxExpHorizonSecs: BigInt.parse(
        '${configuration['max_exp_horizon_secs']}',
      ),
      maxCommitedEpkBytes: int.parse(
        '${configuration['max_commited_epk_bytes']}',
      ),
      maxIssValBytes: int.parse('${configuration['max_iss_val_bytes']}'),
      maxExtraFieldBytes: int.parse(
        '${configuration['max_extra_field_bytes']}',
      ),
      maxJwtHeaderB64Bytes: int.parse(
        '${configuration['max_jwt_header_b64_bytes']}',
      ),
      trainingWheelsPubkey:
          twVec.isEmpty
              ? null
              : BytesUtils.fromHexString(twVec.first as String).toList(),
    );
  }
}

/// RSA JWK as a Poseidon field element (mirrors TS `MoveJWK.toScalar`).
///
/// Only RS256 is supported by the circuit.
extension AptosJwkKeyScalar on AptosJwkKey {
  BigInt toScalar() {
    if (alg != 'RS256') {
      throw BuError(
        OnChainErrorType.aptosPlugin,
        'Only RSA-256 JWKs are supported for keyless verification.',
        details: {'alg': alg},
      );
    }
    final nBytes = AptosKeylessVerifyUtils._base64UrlDecode(n);
    final reversed = nBytes.reversed.toList();
    final scalars = <BigInt>[];
    for (int i = 0; i < reversed.length; i += 24) {
      final end = (i + 24 > reversed.length) ? reversed.length : i + 24;
      final chunk = List<int>.filled(24, 0);
      chunk.setRange(0, end - i, reversed.sublist(i, end));
      scalars.add(AptosKeylessPoseidon.bytesToBigIntLE(chunk));
    }
    scalars.add(BigInt.from(256));
    return AptosKeylessPoseidon.hashFields(scalars);
  }
}

/// Local keyless proof-verification helpers.
abstract final class AptosKeylessVerifyUtils {
  static List<int> _base64UrlDecode(String s) {
    return StringUtils.encode(
      s,
      encoding: StringEncoding.base64UrlSafe,
      validateB64Padding: false,
    );
  }

  /// Groth16 public-inputs hash for a keyless signature.
  ///
  /// Field layout mirrors TS `getPublicInputsHash` (14 Poseidon inputs for the
  /// standard case): padded EPK chunks, idCommitment, expiry, horizon, iss,
  /// extra-field flag + hash, base64url JWT header + ".", aud hash + flag,
  /// JWK scalar.
  static BigInt keylessPublicInputsHash({
    required AptosKeylessAccountPublicKey publicKey,
    required AptosKeylessSignature signature,
    required AptosJwkKey jwk,
    required AptosKeylessConfiguration config,
  }) {
    final proof = signature.ephemeralCertificate.signature;
    final fields = <BigInt>[
      ...AptosKeylessPoseidon.padAndPackBytesWithLen(
        signature.ephemeralPublicKey.toVariantBcs(),
        config.maxCommitedEpkBytes,
      ),
      AptosKeylessPoseidon.bytesToBigIntLE(publicKey.idCommitment),
      BigintUtils.parse(signature.expiryDateSecs),
      proof.expHorizonSecs,
      AptosKeylessPoseidon.hashStrToField(publicKey.iss, config.maxIssValBytes),
    ];
    if (proof.extraField != null) {
      throw BuError(
        DefaultErrorType.unsupported,
        'extraField proofs are not supported for local verification.',
      );
    }
    fields.add(BigInt.zero);
    fields.add(
      AptosKeylessPoseidon.hashStrToField(' ', config.maxExtraFieldBytes),
    );
    final headerB64 = StringUtils.decode(
      StringUtils.encode(signature.jwtHeader),
      encoding: StringEncoding.base64UrlSafe,
      b64NoPadding: true,
    );
    fields.add(
      AptosKeylessPoseidon.hashStrToField(
        '$headerB64.',
        config.maxJwtHeaderB64Bytes,
      ),
    );
    // NOTE: the JWK scalar comes BEFORE the aud fields (matches TS
    // getPublicInputsHash: ..., headerHash, jwkScalar, audHash, audFlag).
    fields.add(jwk.toScalar());
    if (proof.overrideAudVal != null) {
      throw BuError(
        DefaultErrorType.unsupported,
        'overrideAudVal proofs are not supported for local verification.',
      );
    }
    fields.add(AptosKeylessPoseidon.hashStrToField('', 120));
    fields.add(BigInt.zero);
    return AptosKeylessPoseidon.hashFields(fields);
  }

  /// Verifies a keyless signature fully off-chain.
  ///
  /// Checks, in order: expiry, horizon bound, ephemeral Ed25519 signature over
  /// [message], Groth16 proof (via the Rust backend, like Poseidon), training
  /// wheels signature. Throws [BuError] with
  /// `details['check']` naming the failed step; returns true when every check
  /// passes. Mirrors TS `verifyKeylessSignatureWithJwkAndConfig`.
  ///
  /// [message] is the exact bytes the ephemeral key signed: for transactions
  /// use `AptosKeylessMessageUtils.keylessTransactionSigningMessage`, for anything else (e.g. login
  /// challenges) the raw challenge bytes.
  static bool verifyKeylessSignatureLocally({
    required AptosKeylessAccountPublicKey publicKey,
    required AptosKeylessSignature signature,
    required List<int> message,
    required AptosJwkKey jwk,
    required AptosKeylessConfiguration config,
    int? nowSecs,
  }) {
    Never fail(String check, [Map<String, String>? details]) {
      throw BuError(
        DefaultErrorType.cryptoVerifyFailed,
        'Local keyless verification failed.',
        details: {'check': check, ...?details},
      );
    }

    final now =
        nowSecs ?? DateTime.now().toUtc().millisecondsSinceEpoch ~/ 1000;
    if (signature.expiryDateSecs.toInt() < now) {
      fail('expired');
    }
    final zkSig = signature.ephemeralCertificate.signature;
    if (zkSig.expHorizonSecs > config.maxExpHorizonSecs) {
      fail('horizon-exceeded');
    }
    final ephemeralOk = ED25519Verifier(
      ED25519PublicKey.fromBytes(signature.ephemeralPublicKey.keyBytes),
    ).verify(
      message,
      ED25519Signature.fromBytes(signature.ephemeralSignature.signature),
    );
    if (!ephemeralOk) fail('ephemeral-signature');
    final publicInputs = keylessPublicInputsHash(
      publicKey: publicKey,
      signature: signature,
      jwk: jwk,
      config: config,
    );
    _verifyGroth16(
      proof: zkSig.proof.proof,
      publicInputs: publicInputs,
      config: config,
      fail: fail,
    );
    final twPubkey = config.trainingWheelsPubkey;
    if (twPubkey != null) {
      final tws = zkSig.trainingWheelsSignature;
      if (tws == null) fail('training-wheels-missing');
      _verifyTrainingWheels(
        proof: zkSig.proof.proof,
        publicInputs: publicInputs,
        trainingWheelsSignature: tws,
        trainingWheelsPubkey: twPubkey,
        fail: fail,
      );
    }
    return true;
  }

  /// Groth16 verification through the Rust backend (`verifyBn254`).
  static void _verifyGroth16({
    required AptosGroth16Zkp proof,
    required BigInt publicInputs,
    required AptosKeylessConfiguration config,
    required Never Function(String, [Map<String, String>?]) fail,
  }) {
    final inputs = BigintUtils.toBytes(
      publicInputs,
      length: 32,
      byteOrder: Endian.big,
    );
    final result = blockchainUtils.groth16.verifyBn254(
      proof: keylessUncompressedProof(proof).asImmutableBytes,
      vk: keylessVerificationKeyBytes(config, fail: fail).asImmutableBytes,
      publicInputs: inputs.asImmutableBytes,
    );
    if (result.isErr) {
      fail('proof-verification', {'code': '${result.error?.type}'});
    }
  }

  /// Uncompressed Groth16 proof for `verifyBn254`: `a64 ++ b128 ++ c64`
  /// (EIP-197, big-endian), decompressed from the Aptos compressed points.
  static List<int> keylessUncompressedProof(AptosGroth16Zkp proof) {
    return [
      ..._decompressG1(proof.a),
      ..._decompressG2(proof.b),
      ..._decompressG1(proof.c),
    ];
  }

  /// Uncompressed verification key for `verifyBn254`.
  ///
  /// SuiVkBytes layout (shared with the Rust verifier): alpha64 ++
  /// beta/gamma/delta 128 (EIP-197 x1,x0,y1,y0) ++ u32be IC count ++ IC*64.
  static List<int> keylessVerificationKeyBytes(
    AptosKeylessConfiguration config, {
    Never Function(String, [Map<String, String>?])? fail,
  }) {
    Never failWith(String check, [Map<String, String>? details]) {
      if (fail != null) {
        return fail(check, details);
      }
      throw BuError(
        DefaultErrorType.invalidArgument,
        'Invalid keyless verification key.',
        details: {'check': check, ...?details},
      );
    }

    List<int> g1(String hex, String what) {
      final raw = BytesUtils.fromHexString(hex);
      if (raw.length != 32) failWith('vk-point-length', {'point': what});
      return _decompressG1(raw);
    }

    List<int> g2(String hex, String what) {
      final raw = BytesUtils.fromHexString(hex);
      if (raw.length != 64) failWith('vk-point-length', {'point': what});
      return _decompressG2(raw);
    }

    if (config.gammaAbcG1.length != 2) {
      failWith('vk-ic-length');
    }
    List<int> u32be(int v) => [
      (v >> 24) & 0xff,
      (v >> 16) & 0xff,
      (v >> 8) & 0xff,
      v & 0xff,
    ];
    return [
      ...g1(config.alphaG1, 'alpha_g1'),
      ...g2(config.betaG2, 'beta_g2'),
      ...g2(config.gammaG2, 'gamma_g2'),
      ...g2(config.deltaG2, 'delta_g2'),
      ...u32be(config.gammaAbcG1.length),
      ...g1(config.gammaAbcG1[0], 'gamma_abc_g1[0]'),
      ...g1(config.gammaAbcG1[1], 'gamma_abc_g1[1]'),
    ];
  }

  /// Training-wheels check: ed25519 over
  /// `sha3("APTOS::Groth16ProofAndStatement") ++ proofBcs ++ piHashLE`.
  static void _verifyTrainingWheels({
    required AptosGroth16Zkp proof,
    required BigInt publicInputs,
    required List<int> trainingWheelsSignature,
    required List<int> trainingWheelsPubkey,
    required Never Function(String, [Map<String, String>?]) fail,
  }) {
    List<int> tws = trainingWheelsSignature;
    if (tws.length == 66 && tws[0] == 0x00 && tws[1] == 0x40) {
      tws = tws.sublist(2);
    }
    if (tws.length != 64) fail('training-wheels-length');
    final statement = [
      ...proof.a,
      ...proof.b,
      ...proof.c,
      ...BigintUtils.toBytes(
        publicInputs,
        length: 32,
        byteOrder: Endian.little,
      ),
    ];
    final message = [
      ...QuickCrypto.sha3256Hash(
        StringUtils.encode('APTOS::Groth16ProofAndStatement'),
      ),
      ...statement,
    ];
    final ok = ED25519Verifier(
      ED25519PublicKey.fromBytes(trainingWheelsPubkey),
    ).verify(message, ED25519Signature.fromBytes(tws));
    if (!ok) fail('training-wheels-signature');
  }

  /// Decompresses a 32-byte little-endian compressed G1 point (arkworks flags
  /// in the top two bits of the last LE byte) to 64-byte big-endian
  /// uncompressed `x ++ y`, using the repo BN254 tower (`Bn254Fp.sqrt`,
  /// `lexicographicallyLargest` for the y-flag rule).
  static List<int> _decompressG1(List<int> compressed) {
    if (compressed.length != 32) {
      throw BuError(
        DefaultErrorType.invalidLength,
        'Invalid G1 point length.',
        details: {'length': '${compressed.length}'},
      );
    }
    final be = compressed.reversed.toList();
    final yFlag = (be[0] & 0x80) != 0;
    if ((be[0] & 0x40) != 0) {
      throw BuError(
        OnChainErrorType.aptosPlugin,
        'Infinity G1 point has no affine form.',
      );
    }
    be[0] &= 0x3f;
    final x = Bn254Fp.fromBytes(be);
    final y2 = x.square() * x + Bn254Fp.b;
    final r = y2.sqrt();
    if (!r.isSquare) {
      throw BuError(
        DefaultErrorType.invalidArgument,
        'Invalid BN254 G1 point: not on curve.',
      );
    }
    final y =
        (r.result.lexicographicallyLargest() == yFlag) ? r.result : -r.result;
    return Bn254G1AffinePoint(x: x, y: y, infinity: false).toBytes().toList();
  }

  /// Decompresses a 64-byte little-endian compressed G2 point to 128-byte
  /// big-endian uncompressed EIP-197 `x1 ++ x0 ++ y1 ++ y0`, using the repo
  /// BN254 tower (`Bn254Fp2.sqrt`, `lexicographicallyLargest`).
  static List<int> _decompressG2(List<int> compressed) {
    if (compressed.length != 64) {
      throw BuError(
        DefaultErrorType.invalidLength,
        'Invalid G2 point length.',
        details: {'length': '${compressed.length}'},
      );
    }
    final x0be = compressed.sublist(0, 32).reversed.toList();
    final x1be = compressed.sublist(32, 64).reversed.toList();
    final yFlag = (x1be[0] & 0x80) != 0;
    if ((x1be[0] & 0x40) != 0) {
      throw BuError(
        OnChainErrorType.aptosPlugin,
        'Infinity G2 point has no affine form.',
      );
    }
    x0be[0] &= 0x3f;
    x1be[0] &= 0x3f;
    final x = Bn254Fp2(
      c0: Bn254Fp.fromBytes(x0be),
      c1: Bn254Fp.fromBytes(x1be),
    );
    final rhs = x.square() * x + Bn254Fp2.b;
    final r = rhs.sqrt();
    if (!r.isSquare) {
      throw BuError(
        DefaultErrorType.invalidPoint,
        'Invalid BN254 G2 point: not on curve.',
      );
    }
    final y = r.result;
    final yUse = (y.lexicographicallyLargest() == yFlag) ? y : -y;
    final pt = Bn254G2AffinePoint(x: x, y: yUse, infinity: false);
    if (!pt.isOnCurve()) {
      throw BuError(
        DefaultErrorType.invalidPoint,
        'Invalid BN254 G2 point: not on curve.',
      );
    }
    return pt.toBytes().toList();
  }
}
