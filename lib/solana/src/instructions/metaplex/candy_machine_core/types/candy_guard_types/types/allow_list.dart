import 'package:blockchain_utils/helper/extensions/extensions.dart';
import 'package:blockchain_utils/layout/layout.dart';
import 'package:on_chain/solana/src/borsh_serialization/program_layout.dart';

class AllowList extends LayoutSerializable {
  final List<int> merkleRoot;

  AllowList({required List<int> merkleRoot})
      : merkleRoot = merkleRoot.asImmutableBytes;
  factory AllowList.fromJson(Map<String, dynamic> json) {
    return AllowList(merkleRoot: (json['merkleRoot'] as List).cast());
  }

  static final StructLayout staticLayout = LayoutConst.struct([
    LayoutConst.blob(32, property: 'merkleRoot'),
  ], property: 'allowList');

  @override
  StructLayout get layout => staticLayout;
  @override
  Map<String, dynamic> serialize() {
    return {'merkleRoot': merkleRoot};
  }

  @override
  String toString() {
    return 'AllowList${serialize()}';
  }
}
