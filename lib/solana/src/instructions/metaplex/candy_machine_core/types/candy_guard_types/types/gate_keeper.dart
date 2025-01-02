import 'package:on_chain/solana/src/address/sol_address.dart';
import 'package:blockchain_utils/layout/layout.dart';
import 'package:on_chain/solana/src/borsh_serialization/program_layout.dart';
import 'package:on_chain/solana/src/utils/layouts.dart';

class Gatekeeper extends LayoutSerializable {
  final bool expireOnUse;
  final SolAddress gatekeeperNetwork;

  const Gatekeeper(
      {required this.expireOnUse, required this.gatekeeperNetwork});
  factory Gatekeeper.fromJson(Map<String, dynamic> json) {
    return Gatekeeper(
        expireOnUse: json['expireOnUse'],
        gatekeeperNetwork: json['gatekeeperNetwork']);
  }

  static final StructLayout staticLayout = LayoutConst.struct([
    SolanaLayoutUtils.publicKey('gatekeeperNetwork'),
    LayoutConst.boolean(property: 'expireOnUse')
  ], property: 'gatekeeper');

  @override
  StructLayout get layout => staticLayout;
  @override
  Map<String, dynamic> serialize() {
    return {'gatekeeperNetwork': gatekeeperNetwork, 'expireOnUse': expireOnUse};
  }

  @override
  String toString() {
    return 'Gatekeeper${serialize()}';
  }
}
