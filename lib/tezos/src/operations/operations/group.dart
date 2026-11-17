import 'package:blockchain_utils/blockchain_utils.dart';

import 'package:on_chain/exception/onchain_error.dart';
import 'package:on_chain/tezos/src/address/address.dart';
import 'package:on_chain/tezos/src/serialization/src/octez.dart';
import 'package:on_chain/tezos/src/utils/utils.dart';
import 'package:on_chain/tezos/src/crypto/crypto.dart';
import 'package:on_chain/tezos/src/operations/layouts/signatures.dart';
import 'package:on_chain/tezos/src/operations/operations/content.dart';

/// A Tezos operation group: a branch plus the contents to forge and sign.
/// Supports manager, consensus, and evidence contents sharing one signature.
class TezosOperationGroup extends OctezSerializable<TezosOperationGroup> {
  /// Block hash (branch) the operations are based on.
  final String branch;

  /// Ordered list of operation contents.
  final List<TezosOperationContent> contents;

  /// Group signature (null until signed).
  final TezosSignature? signature;

  const TezosOperationGroup({
    required this.branch,
    required this.contents,
    this.signature,
  });

  static Layout<TezosOperationGroup> layout() =>
      ObjSeqLayout<TezosOperationGroup>(
        [
          LayoutConst.fixedBlobN(32),
          RemainderListLayout(LazyLayout(() => TezosOperationContent.layout())),
          TezosSignatureLayout(),
        ],
        build:
            (v) => TezosOperationGroup(
              branch: TezosUtils.encodeBlockHash(v[0]),
              contents: v[1] as List<TezosOperationContent>,
              signature: v[2] as TezosSignature?,
            ),
        unbuild:
            (v) => [
              TezosUtils.decodeBlockHash(v.branch),
              v.contents,
              v.signature,
            ],
      );

  TezosOperationGroup copyWith({
    String? branch,
    List<TezosOperationContent>? contents,
    TezosSignature? signature,
  }) {
    return TezosOperationGroup(
      branch: branch ?? this.branch,
      contents: contents ?? this.contents,
      signature: signature ?? this.signature,
    );
  }

  @override
  Map<String, dynamic> toJson() {
    return {
      "branch": branch,
      "contents": contents.map((e) => e.toVariantJson()).toList(),
      "signature": signature?.toJson(),
    }.notNullValue;
  }

  List<int> signedDigest({bool hash = true}) {
    TezosOperationGroup op = this;
    if (op.signature != null) {
      op = TezosOperationGroup(branch: branch, contents: contents);
    }
    final contentBytes = [
      TezosSigningWatermark.operation.tag,
      ...op.serializeBytes(),
    ];
    if (hash) {
      return QuickCrypto.blake2b256Hash(contentBytes);
    }
    return contentBytes;
  }

  @override
  Layout<TezosOperationGroup> toLayot() {
    return layout();
  }

  TezosAddress? getSource() =>
      contents.whereType<TezosManagerOperationContent>().firstOrNull?.source;

  int simulateSize() {
    final size = signedDigest(hash: false).length - 1;
    final source = getSource();
    final sigSize = switch (source?.type) {
      XtzAddrPrefixes.tz4 => TezosKeyType.bls.signatureLength,
      XtzAddrPrefixes.tz5 => TezosKeyType.mlDsa.signatureLength,
      _ => TezosKeyType.ed25519.signatureLength,
    };
    return size + sigSize;
  }

  int operationIndex(TezosOperationKind operation) {
    final index = contents.indexWhere((e) => e.type == operation);
    if (index.isNegative) {
      throw OnChainErrors.tezosPlugin(
        "operationIndex",
        reason: "Operation not found in operation group.",
        details: {"kind": operation.operationName},
      );
    }
    return index;
  }
}
