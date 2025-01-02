import 'package:on_chain/tron/src/models/block/block.dart';

class TronBlock {
  TronBlock._({required this.blockHeader, required this.blockID});
  factory TronBlock.fromJson(Map<String, dynamic> json) {
    return TronBlock._(
        blockHeader: BlockHeader.fromJson(json['block_header']),
        blockID: json['blockID']);
  }
  final String blockID;
  final BlockHeader blockHeader;
  @override
  String toString() {
    return 'TronBlock { blockID: $blockID, blockHeader: $blockHeader }';
  }
}
