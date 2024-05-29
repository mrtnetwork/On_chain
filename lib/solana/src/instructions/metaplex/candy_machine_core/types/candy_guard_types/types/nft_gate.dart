import 'package:on_chain/solana/src/address/sol_address.dart';
import 'package:blockchain_utils/layout/layout.dart';
import 'package:on_chain/solana/src/borsh_serialization/program_layout.dart';
import 'package:on_chain/solana/src/utils/layouts.dart';

class NftGate extends LayoutSerializable {
  final SolAddress requiredCollection;

  const NftGate({required this.requiredCollection});
  factory NftGate.fromJson(Map<String, dynamic> json) {
    return NftGate(requiredCollection: json["requiredCollection"]);
  }

  static final StructLayout staticLayout = LayoutConst.struct([
    SolanaLayoutUtils.publicKey("requiredCollection"),
  ], property: "nftGate");

  @override
  StructLayout get layout => staticLayout;
  @override
  Map<String, dynamic> serialize() {
    return {"requiredCollection": requiredCollection};
  }

  @override
  String toString() {
    return "NftGate${serialize()}";
  }
}
