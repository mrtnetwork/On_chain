import 'package:blockchain_utils/blockchain_utils.dart';
import 'package:on_chain/solana/src/address/sol_address.dart';
import 'package:on_chain/solana/src/layout/layout.dart';

class EscrowAuthority extends LayoutSerializable {
  final String name;
  final dynamic fields;
  const EscrowAuthority._(this.name, this.fields);
  static const EscrowAuthority tokenOwner =
      EscrowAuthority._("TokenOwner", null);
  factory EscrowAuthority.creator({required SolAddress creator}) {
    return EscrowAuthority._("Creator", [creator]);
  }
  factory EscrowAuthority.fromJson(Map<String, dynamic> json) {
    final name = json["escrowAuthority"]["key"];
    final value = json["escrowAuthority"]["value"];
    if (name != "Creator" && name != "TokenOwner") {}
    switch (name) {
      case "TokenOwner":
        return tokenOwner;
      case "Creator":
        return EscrowAuthority.creator(creator: (value as List)[0]);
      default:
        throw MessageException("Invalid escrowAuthority version");
    }
  }
  static Structure staticLayout = LayoutUtils.struct([
    LayoutUtils.rustEnum([
      LayoutUtils.none("TokenOwner"),
      LayoutUtils.tuple([LayoutUtils.publicKey()], property: "Creator")
    ], LayoutUtils.u8(), property: "escrowAuthority")
  ]);

  @override
  Structure get layout => staticLayout;
  @override
  Map<String, dynamic> serialize() {
    return {
      "escrowAuthority": {name: fields}
    };
  }
}
