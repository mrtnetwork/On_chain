import 'package:on_chain/solana/src/address/sol_address.dart';
import 'package:blockchain_utils/layout/layout.dart';
import 'package:on_chain/solana/src/borsh_serialization/program_layout.dart';
import 'package:on_chain/solana/src/utils/layouts.dart';

class NftBurn extends LayoutSerializable {
  final SolAddress requiredCollection;

  const NftBurn({required this.requiredCollection});
  factory NftBurn.fromJson(Map<String, dynamic> json) {
    return NftBurn(requiredCollection: json["requiredCollection"]);
  }

  static final StructLayout staticLayout = LayoutConst.struct([
    SolanaLayoutUtils.publicKey("requiredCollection"),
  ], property: "nftBurn");

  @override
  StructLayout get layout => staticLayout;
  @override
  Map<String, dynamic> serialize() {
    return {"requiredCollection": requiredCollection};
  }

  @override
  String toString() {
    return "NftBurn${serialize()}";
  }
}
