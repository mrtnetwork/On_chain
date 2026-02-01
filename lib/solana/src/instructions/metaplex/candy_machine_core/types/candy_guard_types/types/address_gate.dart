import 'package:on_chain/solana/src/address/sol_address.dart';
import 'package:blockchain_utils/layout/layout.dart';
import 'package:on_chain/solana/src/borsh_serialization/program_layout.dart';
import 'package:on_chain/solana/src/utils/layouts.dart';

class AddressGate extends BorshLayoutSerializable {
  final SolAddress address;

  const AddressGate({required this.address});
  factory AddressGate.fromJson(Map<String, dynamic> json) {
    return AddressGate(address: json['address']);
  }

  static StructLayout get staticLayout => LayoutConst.struct([
        SolanaLayoutUtils.publicKey('address'),
      ], property: 'addressGate');

  @override
  StructLayout get layout => staticLayout;
  @override
  Map<String, dynamic> serialize() {
    return {'address': address};
  }

  @override
  String toString() {
    return 'AddressGate${serialize()}';
  }
}
