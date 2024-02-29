import 'package:on_chain/solana/src/address/sol_address.dart';
import 'package:on_chain/solana/src/layout/layout.dart';

class AddressGate extends LayoutSerializable {
  final SolAddress address;

  const AddressGate({required this.address});
  factory AddressGate.fromJson(Map<String, dynamic> json) {
    return AddressGate(address: json["address"]);
  }

  static final Structure staticLayout = LayoutUtils.struct([
    LayoutUtils.publicKey("address"),
  ], "addressGate");

  @override
  Structure get layout => staticLayout;
  @override
  Map<String, dynamic> serialize() {
    return {"address": address};
  }

  @override
  String toString() {
    return "AddressGate${serialize()}";
  }
}
