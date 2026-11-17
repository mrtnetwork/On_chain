import 'package:blockchain_utils/blockchain_utils.dart';

import 'package:on_chain/exception/onchain_error.dart';
import 'package:on_chain/tezos/src/crypto/types/types.dart';
import 'package:on_chain/tezos/src/operations/layouts/utils.dart';
import 'package:on_chain/tezos/src/operations/layouts/signatures.dart';
import 'package:on_chain/tezos/src/serialization/serialization.dart';
import 'package:on_chain/tezos/src/utils/utils.dart';

class TezosSignatureConst {
  static const int blsSignaturePrefixWidth = 32;
  static const int mldsa44SignaturePrefixWidth = 2356;
  static const int signaturePrefixMarkerTag = 0xff;
}

sealed class TezosSignature extends OctezSerializable<TezosSignature>
    with Equality {
  List<int> get bytes;
  const TezosSignature();
  @override
  List<dynamic> get variables => [bytes];

  String encode();

  /// Decode a 64/96/2420-byte raw signature.
  ///
  factory TezosSignature.fromBytes(List<int> bytes) {
    final length = bytes.length;
    if (length == TezosKeyType.ed25519.signatureLength) {
      return TezosGenericSignature(bytes);
    } else if (length == TezosKeyType.bls.signatureLength) {
      return TezosBlsSignature(bytes);
    } else {
      if (length == TezosKeyType.mlDsa.signatureLength) {
        return TezosMlDsa44Signature(bytes);
      }
      throw OnChainErrors.tezosPlugin(
        "TezosSignature",
        reason: "Invalid signature bytes length.",
      );
    }
  }
  factory TezosSignature.decode(String signature) {
    final bytes = TezosUtils.decodeSignature(signature);
    return TezosSignature.fromBytes(bytes);
  }

  static Layout<TezosSignature> layout() => ObjSeqLayout<TezosSignature>(
    [TezosSignatureLayout()],
    build: (values) => values[0] as TezosSignature,
    unbuild: (value) => [value],
  );

  @override
  Layout<TezosSignature> toLayot() {
    return layout();
  }

  @override
  String toJson() {
    return encode();
  }
}

/// 64-byte Ed25519/Secp256k1/P256 signature (raw, untagged, no split).
class TezosGenericSignature extends TezosSignature {
  @override
  final BuBytes bytes;
  TezosGenericSignature(List<int> bytes)
    : bytes =
          bytes
              .exc(
                length: TezosKeyType.ed25519.signatureLength,
                operation: "TezosGenericSignature",
                reason: "Invalid generic signature bytes length.",
              )
              .asImmutableBytes;
  factory TezosGenericSignature.dummy() => TezosGenericSignature(
    List.filled(TezosKeyType.ed25519.signatureLength, 0),
  );
  @override
  String encode() {
    return TezosUtils.encodeSignature(null, bytes);
  }

  @override
  String toJson() => encode();
}

/// BLS signature: 96 bytes total (32-byte prefix + 64-byte suffix).
class TezosBlsSignature extends TezosSignature {
  @override
  final BuBytes bytes;
  TezosBlsSignature(List<int> bytes)
    : bytes =
          bytes
              .exc(
                length: TezosKeyType.bls.signatureLength,
                operation: "TezosBlsSignature",
                reason: "Invalid BLS signature bytes length.",
              )
              .asImmutableBytes;
  factory TezosBlsSignature.decode(String base58) => TezosBlsSignature(
    TezosUtils.decodeSignature(base58, type: TezosKeyType.bls),
  );
  @override
  String encode() {
    return TezosUtils.encodeSignature(TezosKeyType.bls, bytes);
  }
}

/// ML-DSA-44 -- 2420 bytes total (2356-byte prefix + 64-byte suffix).
class TezosMlDsa44Signature extends TezosSignature {
  @override
  final BuBytes bytes;
  TezosMlDsa44Signature(List<int> bytes)
    : bytes =
          bytes
              .exc(
                length: TezosKeyType.mlDsa.signatureLength,
                operation: "TezosMlDsa44Signature",
                reason: "Invalid ML-DSA-44 signature bytes length.",
              )
              .asImmutableBytes;

  @override
  String encode() {
    return TezosUtils.encodeSignature(TezosKeyType.mlDsa, bytes);
  }
}

class TezosSignaturePrefix {
  /// Curve tag of the split signature (3 = BLS, 4 = ML-DSA-44).
  final TezosKeyType algoTag; // 3 = Bls, 4 = MlDsa44
  final BuBytes bytes;
  TezosSignaturePrefix(this.algoTag, List<int> bytes)
    : bytes = bytes.asImmutableBytes;

  static Layout<TezosSignaturePrefix> layout() =>
      TaggedUnionLayout<TezosSignaturePrefix>(
        tagLayout: TezosLayoutUtils.tzUint8,
        tagFor: (p) => p.algoTag.tag,
        cases: [
          UnionCase<TezosSignaturePrefix>(
            TezosKeyType.bls.tag,
            TezosLayoutUtils.signaturePrefixCase(
              TezosKeyType.bls,
              TezosSignatureConst.blsSignaturePrefixWidth,
            ),
          ),
          UnionCase<TezosSignaturePrefix>(
            TezosKeyType.mlDsa.tag,
            TezosLayoutUtils.signaturePrefixCase(
              TezosKeyType.mlDsa,
              TezosSignatureConst.mldsa44SignaturePrefixWidth,
            ),
          ),
        ],
      );
}
