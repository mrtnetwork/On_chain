import 'package:on_chain/solana/src/address/sol_address.dart';
import 'package:on_chain/solana/src/layout/layout.dart';

class RuleSetToggle extends LayoutSerializable {
  const RuleSetToggle._(this.name, this.value, this.fileds);
  final String name;
  final int value;
  final List<SolAddress>? fileds;
  factory RuleSetToggle.fromJson(Map<String, dynamic> json) {
    final key = json["ruleSetToggle"]["key"];
    final List<dynamic> value = json["ruleSetToggle"]["value"];
    switch (key) {
      case "None":
        return none;
      case "Clear":
        return clear;
      default:
        return RuleSetToggle.set(address: value[0]);
    }
  }
  static const RuleSetToggle none = RuleSetToggle._("None", 0, null);
  static const RuleSetToggle clear = RuleSetToggle._("Clear", 1, null);
  factory RuleSetToggle.set({required SolAddress address}) {
    return RuleSetToggle._("Set", 2, [address]);
  }

  static Structure staticLayout = LayoutUtils.struct([
    LayoutUtils.rustEnum([
      LayoutUtils.none("None"),
      LayoutUtils.none("Clear"),
      LayoutUtils.tuple([LayoutUtils.publicKey()], property: "Set"),
    ], LayoutUtils.u8(), property: "ruleSetToggle")
  ]);

  @override
  Structure get layout => staticLayout;

  @override
  Map<String, dynamic> serialize() {
    return {
      "ruleSetToggle": {name: fileds}
    };
  }
}
