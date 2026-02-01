import 'package:on_chain/solana/src/exception/exception.dart';
import 'package:blockchain_utils/layout/layout.dart';
import 'package:on_chain/solana/src/borsh_serialization/program_layout.dart';
import 'concurrent_merkle_tree_header_data_v1.dart';

class ConcurrentMerkleTreeHeader extends BorshLayoutSerializable {
  const ConcurrentMerkleTreeHeader._(this.name, this.value, this.field);
  final String name;
  final int value;
  final ConcurrentMerkleTreeHeaderDataV1 field;
  factory ConcurrentMerkleTreeHeader.fromJson(Map<String, dynamic> json) {
    final key = json['concurrentMerkleTreeHeader']['key'];
    final Map<String, dynamic> value =
        Map<String, dynamic>.from(json['concurrentMerkleTreeHeader']['value']);
    switch (key) {
      case 'V1':
        return ConcurrentMerkleTreeHeader.v1(
            header: ConcurrentMerkleTreeHeaderDataV1.fromJson(value));
      default:
        throw SolanaPluginException(
            'Invalid ConcurrentMerkleTreeHeader version.',
            details: {'version': key});
    }
  }

  factory ConcurrentMerkleTreeHeader.v1(
      {required ConcurrentMerkleTreeHeaderDataV1 header}) {
    return ConcurrentMerkleTreeHeader._('V1', 0, header);
  }

  static StructLayout staticLayout = LayoutConst.struct([
    LayoutConst.rustEnum([
      LayoutConst.wrap(ConcurrentMerkleTreeHeaderDataV1.staticLayout,
          property: 'V1')
    ], property: 'concurrentMerkleTreeHeader')
  ]);

  @override
  StructLayout get layout => staticLayout;

  @override
  Map<String, dynamic> serialize() {
    return {
      'concurrentMerkleTreeHeader': {name: field.serialize()}
    };
  }

  @override
  String toString() {
    return 'ConcurrentMerkleTreeHeader${serialize()}';
  }
}
