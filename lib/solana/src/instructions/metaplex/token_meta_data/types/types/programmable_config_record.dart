import 'package:blockchain_utils/blockchain_utils.dart';
import 'package:on_chain/solana/src/address/sol_address.dart';
import 'package:on_chain/solana/src/layout/layout.dart';

class ProgrammableConfigRecord extends LayoutSerializable {
  final String name;
  final dynamic fields;
  const ProgrammableConfigRecord._(this.name, this.fields);
  factory ProgrammableConfigRecord.v1({SolAddress? ruleSet}) {
    return ProgrammableConfigRecord._("V1", ruleSet);
  }
  factory ProgrammableConfigRecord.fromJson(Map<String, dynamic> json) {
    final name = json["programmableConfigRecord"]["key"];
    if (name != "V1") {
      throw MessageException(
          "Invalid ProgrammableConfigRecord version: $name. Expected version: V1");
    }
    return ProgrammableConfigRecord._(json["programmableConfigRecord"]["key"],
        json["programmableConfigRecord"]["value"]);
  }
  static Structure staticLayout = LayoutUtils.struct([
    LayoutUtils.rustEnum(
        [LayoutUtils.optionPubkey(property: "V1")], LayoutUtils.u8(),
        property: "programmableConfigRecord")
  ]);

  @override
  Structure get layout => staticLayout;
  @override
  Map<String, dynamic> serialize() {
    return {
      "programmableConfigRecord": {name: fields}
    };
  }
}
