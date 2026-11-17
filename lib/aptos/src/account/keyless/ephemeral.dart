import 'package:blockchain_utils/blockchain_utils.dart';
import 'package:on_chain/aptos/src/account/keyless/poseidon_pack.dart';

import 'package:on_chain/serialization/bcs/serialization/serialization.dart';

/// Ephemeral keypair for Aptos keyless (AIP-61).
///
/// Ed25519 only (matches the TS SDK): holds the secret key, expiry,
/// 31-byte blinder and the OIDC `nonce` committing to all three.
class AptosEphemeralKeyPair extends BcsSerialization with Equality {
  /// Blinder length in bytes.
  static const int blinderLength = 31;

  /// Max BCS bytes of the ephemeral public key packed into the nonce.
  static const int maxCommittedEpkBytes = 93;

  /// Default lifetime: two weeks, floored to the hour (TS SDK default).
  static const int defaultLifetimeSecs = 1209600;

  final ED25519PrivateKey privateKey;
  final int expiryDateSecs;
  final BuBytes blinder;

  /// OIDC nonce: decimal Poseidon hash over the packed ephemeral public
  /// key, expiry and blinder. Sent to the IdP, embedded in the JWT.
  final String nonce;

  AptosEphemeralKeyPair._({
    required this.privateKey,
    required this.expiryDateSecs,
    required List<int> blinder,
    required this.nonce,
  }) : blinder = blinder.asImmutableBytes {
    if (blinder.length != blinderLength) {
      throw BuError(
        DefaultErrorType.invalidLength,
        'Invalid ephemeral blinder length.',
        details: {
          'expected': blinderLength.toString(),
          'length': blinder.length.toString(),
        },
      );
    }
  }

  /// Ephemeral public key BCS: `uleb128(0) ++ bcsBytes(32-byte key)`.
  BuBytes get ephemeralPublicKeyBcs {
    return [
      ...LayoutConst.lebU32().serialize(0),
      ...LayoutConst.bcsBytes().serialize(
        List<int>.from(privateKey.publicKey.toBytes()),
      ),
    ].asImmutableBytes;
  }

  static String _computeNonce({
    required List<int> epkBcs,
    required int expiryDateSecs,
    required List<int> blinder,
  }) {
    final fields = AptosKeylessPoseidon.padAndPackBytesWithLen(
      epkBcs,
      maxCommittedEpkBytes,
    );
    fields.add(BigintUtils.parse(expiryDateSecs));
    fields.add(AptosKeylessPoseidon.bytesToBigIntLE(blinder));
    return AptosKeylessPoseidon.hashFields(fields).toString();
  }

  factory AptosEphemeralKeyPair({
    ED25519PrivateKey? privateKey,
    int? expiryDateSecs,
    List<int>? blinder,
  }) {
    final sk = privateKey ?? ED25519PrivateKey.random();
    final exp =
        expiryDateSecs ??
        (() {
          final now = DateTime.now().toUtc().millisecondsSinceEpoch ~/ 1000;
          return (now + defaultLifetimeSecs) ~/ 3600 * 3600;
        })();
    final bl = blinder ?? QuickCrypto.generateRandom(length: blinderLength);
    final epkBcs = [
      ...LayoutConst.lebU32().serialize(0),
      ...LayoutConst.bcsBytes().serialize(
        List<int>.from(sk.publicKey.toBytes()),
      ),
    ];
    return AptosEphemeralKeyPair._(
      privateKey: sk,
      expiryDateSecs: exp,
      blinder: bl,
      nonce: _computeNonce(epkBcs: epkBcs, expiryDateSecs: exp, blinder: bl),
    );
  }

  bool isExpired() {
    final now = DateTime.now().toUtc().millisecondsSinceEpoch ~/ 1000;
    return now > expiryDateSecs;
  }

  /// Signs with the ephemeral secret key (fails past expiry).
  ED25519Signature sign(List<int> digest) {
    if (isExpired()) {
      throw BuError(
        DefaultErrorType.invalidState,
        'Ephemeral keypair has expired.',
        details: {'expiry': expiryDateSecs.toString()},
      );
    }
    return ED25519Signer(privateKey).sign(digest).signature;
  }

  static Layout<Map<String, dynamic>> layout({String? property}) {
    return LayoutConst.struct([
      LayoutConst.u8(property: "variant"),
      LayoutConst.bcsBytes(property: "privateKey"),
      LayoutConst.u64(property: "expiryDateSecs"),
      LayoutConst.bcsBytes(property: "blinder"),
    ], property: property);
  }

  @override
  Layout<Map<String, dynamic>> createLayout({String? property}) {
    return layout(property: property);
  }

  @override
  Map<String, dynamic> toLayoutStruct() {
    return {
      "variant": 0,
      "privateKey": privateKey.toBytes(),
      "expiryDateSecs": expiryDateSecs,
      "blinder": blinder,
    };
  }

  @override
  List<dynamic> get variables => [nonce, expiryDateSecs];
}
