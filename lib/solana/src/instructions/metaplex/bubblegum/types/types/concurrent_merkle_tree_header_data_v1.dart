import 'package:blockchain_utils/utils/utils.dart';
import 'package:on_chain/solana/src/address/sol_address.dart';
import 'package:blockchain_utils/layout/layout.dart';
import 'package:on_chain/solana/src/borsh_serialization/program_layout.dart';
import 'package:on_chain/solana/src/utils/layouts.dart';

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
        maxBufferSize: json['maxBufferSize'],
        maxDepth: json['maxDepth'],
        authority: json['authority'],
        creationSlot: json['creationSlot'],
        padding: (json['padding'] as List).cast());
  }
  static StructLayout staticLayout = LayoutConst.struct([
    LayoutConst.u32(property: 'maxBufferSize'),
    LayoutConst.u32(property: 'maxDepth'),
    SolanaLayoutUtils.publicKey('authority'),
    LayoutConst.u64(property: 'creationSlot'),
    LayoutConst.blob(6, property: 'padding')
  ], property: 'concurrentMerkleTreeHeaderDataV1');

  @override
  StructLayout get layout => staticLayout;

  @override
  Map<String, dynamic> serialize() {
    return {
      'maxBufferSize': maxBufferSize,
      'maxDepth': maxDepth,
      'authority': authority,
      'creationSlot': creationSlot,
      'padding': padding
    };
  }

  @override
  String toString() {
    return 'ConcurrentMerkleTreeHeaderDataV1${serialize()}';
  }
}
