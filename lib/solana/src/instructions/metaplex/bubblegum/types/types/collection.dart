import 'package:on_chain/solana/src/address/sol_address.dart';
import 'package:blockchain_utils/layout/layout.dart';
import 'package:on_chain/solana/src/borsh_serialization/program_layout.dart';
import 'package:on_chain/solana/src/utils/layouts.dart';

class Collection extends LayoutSerializable {
  final bool verified;
  final SolAddress key;
  const Collection({required this.verified, required this.key});
  factory Collection.fromJson(Map<String, dynamic> json) {
    return Collection(verified: json['verified'], key: json['key']);
  }
  static final StructLayout staticLayout = LayoutConst.struct([
    LayoutConst.boolean(property: 'verified'),
    SolanaLayoutUtils.publicKey('key')
  ], property: 'collection');

  @override
  StructLayout get layout => staticLayout;

  @override
  Map<String, dynamic> serialize() {
    return {'verified': verified, 'key': key};
  }

  @override
  String toString() {
    return 'Collection${serialize()}';
  }
}
