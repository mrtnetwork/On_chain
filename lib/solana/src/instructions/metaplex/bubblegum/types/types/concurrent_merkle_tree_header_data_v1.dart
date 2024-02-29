import 'package:blockchain_utils/blockchain_utils.dart';
import 'package:on_chain/solana/src/address/sol_address.dart';
import 'package:on_chain/solana/src/layout/layout.dart';

class ConcurrentMerkleTreeHeaderDataV1 extends LayoutSerializable {
  final int maxBufferSize;
  final int maxDepth;
  final SolAddress authority;
  final BigInt creationSlot;
  final List<int> padding;
  ConcurrentMerkleTreeHeaderDataV1(
      {required this.maxBufferSize,
      required this.maxDepth,
      required this.authority,
      required this.creationSlot,
      required List<int> padding})
      : padding = BytesUtils.toBytes(padding, unmodifiable: true);
  factory ConcurrentMerkleTreeHeaderDataV1.fromJson(Map<String, dynamic> json) {
    return ConcurrentMerkleTreeHeaderDataV1(
        maxBufferSize: json["maxBufferSize"],
        maxDepth: json["maxDepth"],
        authority: json["authority"],
        creationSlot: json["creationSlot"],
        padding: (json["padding"] as List).cast());
  }
  static Structure staticLayout = LayoutUtils.struct([
    LayoutUtils.u32("maxBufferSize"),
    LayoutUtils.u32("maxDepth"),
    LayoutUtils.publicKey("authority"),
    LayoutUtils.u64("creationSlot"),
    LayoutUtils.blob(6, property: "padding")
  ], "concurrentMerkleTreeHeaderDataV1");

  @override
  Structure get layout => staticLayout;

  @override
  Map<String, dynamic> serialize() {
    return {
      "maxBufferSize": maxBufferSize,
      "maxDepth": maxDepth,
      "authority": authority,
      "creationSlot": creationSlot,
      "padding": padding
    };
  }

  @override
  String toString() {
    return "ConcurrentMerkleTreeHeaderDataV1${serialize()}";
  }
}
