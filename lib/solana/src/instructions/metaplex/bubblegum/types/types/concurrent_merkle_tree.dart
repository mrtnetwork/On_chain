import 'package:on_chain/solana/src/instructions/metaplex/bubblegum/types/types/change_log.dart';
import 'package:on_chain/solana/src/instructions/metaplex/bubblegum/types/types/path.dart';
import 'package:on_chain/solana/src/layout/layout.dart';

class ConcurrentMerkleTree extends LayoutSerializable {
  final BigInt sequenceNumber;
  final BigInt activeIndex;
  final BigInt bufferSize;
  final List<ChangeLog> changeLogs;
  final Path rightMostPath;

  ConcurrentMerkleTree(
      {required this.sequenceNumber,
      required this.activeIndex,
      required this.bufferSize,
      required List<ChangeLog> changeLogs,
      required this.rightMostPath})
      : changeLogs = List<ChangeLog>.unmodifiable(changeLogs);
  factory ConcurrentMerkleTree.fromJson(Map<String, dynamic> json) {
    return ConcurrentMerkleTree(
        sequenceNumber: json["sequenceNumber"],
        activeIndex: json["activeIndex"],
        bufferSize: json["bufferSize"],
        changeLogs: (json["changeLogs"] as List)
            .map((e) => ChangeLog.fromJson(e))
            .toList(),
        rightMostPath: Path.fromJson(json["rightMostPath"]));
  }
  static Structure staticLayout(
          {required int maxBufferSize, required int maxDepth}) =>
      LayoutUtils.struct([
        LayoutUtils.u64("sequenceNumber"),
        LayoutUtils.u64("activeIndex"),
        LayoutUtils.u64("bufferSize"),
        LayoutUtils.array(
            ChangeLog.staticLayout(maxDepth: maxDepth), maxBufferSize,
            property: "changeLogs"),
        LayoutUtils.wrap(Path.staticLayout(maxDepth: maxDepth),
            property: "rightMostPath"),
      ], "concurrentMerkleTree");

  @override
  Structure get layout => staticLayout(
      maxBufferSize: changeLogs.length, maxDepth: rightMostPath.proof.length);

  @override
  Map<String, dynamic> serialize() {
    return {
      "sequenceNumber": sequenceNumber,
      "activeIndex": activeIndex,
      "bufferSize": bufferSize,
      "changeLogs": changeLogs.map((e) => e.serialize()).toList(),
      "rightMostPath": rightMostPath.serialize()
    };
  }

  @override
  String toString() {
    return "ConcurrentMerkleTree${serialize()}";
  }
}
