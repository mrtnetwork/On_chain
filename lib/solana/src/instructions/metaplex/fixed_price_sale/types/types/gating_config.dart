import 'package:on_chain/solana/src/address/sol_address.dart';
import 'package:blockchain_utils/layout/layout.dart';
import 'package:on_chain/solana/src/borsh_serialization/program_layout.dart';
import 'package:on_chain/solana/src/utils/layouts.dart';

class GatingConfig extends BorshLayoutSerializable {
  final SolAddress collection;
  final bool expireOnUse;
  final BigInt? gatingTime;
  const GatingConfig(
      {required this.collection, required this.expireOnUse, this.gatingTime});
  factory GatingConfig.fromJson(Map<String, dynamic> json) {
    return GatingConfig(
        collection: json['collection'],
        expireOnUse: json['expireOnUse'],
        gatingTime: json['gatingTime']);
  }

  static StructLayout get staticLayout => LayoutConst.struct([
        SolanaLayoutUtils.publicKey('collection'),
        LayoutConst.boolean(property: 'expireOnUse'),
        LayoutConst.optional(LayoutConst.u64(), property: 'gatingTime')
      ], property: 'gatingConfig');

  @override
  StructLayout get layout => staticLayout;
  @override
  Map<String, dynamic> serialize() {
    return {
      'collection': collection,
      'expireOnUse': expireOnUse,
      'gatingTime': gatingTime
    };
  }

  @override
  String toString() {
    return 'GatingConfig${serialize()}';
  }
}
