import 'package:blockchain_utils/blockchain_utils.dart';

import 'package:on_chain/exception/onchain_error.dart';
import 'package:on_chain/tezos/src/address/address.dart';
import 'package:on_chain/tezos/src/crypto/types/signature.dart';
import 'package:on_chain/tezos/src/operations/operations/group.dart';

/// Tezos cryptographic key types with their Base58 prefixes.
///
/// All prefix bytes are taken from the official Octez / PyTezos encoding tables.
enum TezosKeyType {
  ed25519(
    publicKeyPrefix: 'edpk',
    publicKeyPrefixBytes: [0x0d, 0x0f, 0x25, 0xd9],
    publicKeyLength: 32,
    privateKeyPrefix: 'edsk',
    privateKeyPrefixBytes: [0x0d, 0x0f, 0x3a, 0x07],
    privateKeyLength: 32,
    signaturePrefix: 'edsig',
    signaturePrefixBytes: [0x09, 0xf5, 0xcd, 0x86, 0x12],
    signatureLength: 64,
    addrType: XtzAddrPrefixes.tz1,
    tag: 0,
  ),

  /// Secp256k1 curve — addresses start with `tz2`.
  secp256k1(
    publicKeyPrefix: 'sppk',
    publicKeyPrefixBytes: [0x03, 0xfe, 0xe2, 0x56],
    publicKeyLength: 33,
    privateKeyPrefix: 'spsk',
    privateKeyPrefixBytes: [0x11, 0xa2, 0xe0, 0xc9],
    privateKeyLength: 32,
    signaturePrefix: 'spsig1',
    signaturePrefixBytes: [0x0d, 0x73, 0x65, 0x13, 0x3f],
    signatureLength: 64,
    addrType: XtzAddrPrefixes.tz2,
    tag: 1,
  ),

  /// P-256 / Secp256r1 curve — addresses start with `tz3`.
  secp256r1(
    publicKeyPrefix: 'p2pk',
    publicKeyPrefixBytes: [0x03, 0xb2, 0x8b, 0x7f],
    publicKeyLength: 33,
    privateKeyPrefix: 'p2sk',
    privateKeyPrefixBytes: [0x10, 0x51, 0xee, 0xbd],
    privateKeyLength: 32,
    signaturePrefix: 'p2sig',
    signaturePrefixBytes: [0x36, 0xf0, 0x2c, 0x34],
    signatureLength: 64,
    addrType: XtzAddrPrefixes.tz3,
    tag: 2,
  ),

  /// BLS12-381 MinPk curve — addresses start with `tz4`.
  ///
  /// Public keys are compressed G1 points (48 bytes).
  /// Signatures are compressed G2 points (96 bytes).
  bls(
    publicKeyPrefix: 'BLpk',
    publicKeyPrefixBytes: [0x06, 0x95, 0x87, 0xcc],
    publicKeyLength: 48,
    privateKeyPrefix: 'BLsk',
    privateKeyPrefixBytes: [0x03, 0x96, 0xc0, 0x28],
    privateKeyLength: 32,
    signaturePrefix: 'BLsig',
    signaturePrefixBytes: [0x28, 0xab, 0x40, 0xcf],
    signatureLength: 96,
    addrType: XtzAddrPrefixes.tz4,
    tag: 3,
  ),

  /// ML-DSA-44 (Dilithium) post-quantum key — addresses start with `tz5`.
  mlDsa(
    publicKeyPrefix: 'mdpk',
    publicKeyPrefixBytes: [0x0D, 0x07, 0x9F, 0x43],
    publicKeyLength: 1312,

    privateKeyPrefix: 'mdsk',
    privateKeyPrefixBytes: [0x09, 0x39, 0x74, 0x39],
    privateKeyLength: 2560,

    signaturePrefix: 'mdsig',
    signaturePrefixBytes: [0x01, 0x9C, 0x2D, 0xD2, 0x03],
    signatureLength: 2420,

    addrType: XtzAddrPrefixes.tz5,
    tag: 4,
  );

  /// Base58 string prefix for public keys.
  final String publicKeyPrefix;

  /// Raw Base58Check prefix bytes for public keys.
  final List<int> publicKeyPrefixBytes;

  /// Raw public key size after removing Base58 prefix.
  final int publicKeyLength;

  /// Base58 string prefix for secret keys.
  final String privateKeyPrefix;

  /// Raw Base58Check prefix bytes for secret keys.
  final List<int> privateKeyPrefixBytes;

  /// Raw private key size after removing Base58 prefix.
  final int privateKeyLength;

  /// Base58 string prefix for signatures.
  final String signaturePrefix;

  /// Raw Base58Check prefix bytes for signatures.
  final List<int> signaturePrefixBytes;

  /// Raw signature size after removing Base58 prefix.
  final int signatureLength;

  /// Implicit address prefix of this key type (`tz1`-`tz5`).
  final XtzAddrPrefixes addrType;

  /// Binary (`pkh`/`sig` prefix) tag of this key type.
  final int tag;

  const TezosKeyType({
    required this.publicKeyPrefix,
    required this.publicKeyPrefixBytes,
    required this.publicKeyLength,
    required this.privateKeyPrefix,
    required this.privateKeyPrefixBytes,
    required this.privateKeyLength,
    required this.signaturePrefix,
    required this.signaturePrefixBytes,
    required this.signatureLength,
    required this.addrType,
    required this.tag,
  });

  /// Look up a key type by its Base58 public-key string prefix.
  static TezosKeyType fromPublicKeyBase58(String base58) {
    return values.firstWhere(
      (e) => base58.startsWith(e.publicKeyPrefix),
      orElse:
          () =>
              throw OnChainErrors.tezosPlugin(
                "TezosKeyType.fromPublicKeyBase58",
                reason: "Unknown public key prefix.",
                details: {'value': base58},
              ),
    );
  }

  /// Look up a key type by its Base58 secret-key string prefix.
  static TezosKeyType fromSecretKeyBase58(String base58) {
    return values.firstWhere(
      (e) => base58.startsWith(e.privateKeyPrefix),
      orElse:
          () =>
              throw OnChainErrors.tezosPlugin(
                "TezosKeyType.fromSecretKeyBase58",
                reason: "Unknown secret key prefix.",
                details: {'value': base58},
              ),
    );
  }

  static TezosKeyType? fromSignatureOrNull(String base58) {
    return values.firstWhereNullable(
      (e) => base58.startsWith(e.signaturePrefix),
    );
  }

  static const List<int> ed25519ExpandedSecretKeyPrefixBytes = [
    0x2b,
    0xf6,
    0x4e,
    0x07,
  ];

  static TezosKeyType fromAddressType(XtzAddrPrefixes type) {
    return switch (type) {
      XtzAddrPrefixes.tz1 => TezosKeyType.ed25519,
      XtzAddrPrefixes.tz2 => TezosKeyType.secp256k1,
      XtzAddrPrefixes.tz3 => TezosKeyType.secp256r1,
      XtzAddrPrefixes.tz4 => TezosKeyType.bls,
      XtzAddrPrefixes.tz5 => TezosKeyType.mlDsa,
      _ =>
        throw OnChainErrors.tezosPlugin(
          "TezosKeyType.fromAddressType",
          reason: "Unsupported address type.",
        ),
    };
  }
}

enum TezosSigningWatermark {
  operation(0x03),
  failingNoop(0x05),
  blockHeader(0x01),
  endorsement(0x02);

  final int tag;
  const TezosSigningWatermark(this.tag);
}

typedef CbTezosSigner = Future<TezosSigner> Function(TezosAddress addr);

/// Signer interface for Tezos operations.
abstract class TezosSigner {
  TezosSignature sign(List<int> digest);
  Future<TezosSignature> signAsync(List<int> message);
  Future<TezosOperationGroup> signOperation(TezosOperationGroup operation);
}
