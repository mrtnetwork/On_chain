import 'package:on_chain/solana/src/instructions/metaplex/bubblegum/bubblegum.dart';
import 'package:on_chain/solana/src/layout/layout.dart';

class UsesToggle extends LayoutSerializable {
  const UsesToggle._(this.name, this.value, this.fileds);
  final String name;
  final int value;
  final List<Uses>? fileds;
  factory UsesToggle.fromJson(Map<String, dynamic> json) {
    final key = json["usesToggle"]["key"];
    final List<dynamic> value = json["usesToggle"]["value"];
    switch (key) {
      case "None":
        return none;
      case "Clear":
        return clear;
      default:
        return UsesToggle.set(uses: Uses.fromJson(value[0]));
    }
  }
  static const UsesToggle none = UsesToggle._("None", 0, null);
  static const UsesToggle clear = UsesToggle._("Clear", 1, null);
  factory UsesToggle.set({required Uses uses}) {
    return UsesToggle._("Set", 2, [uses]);
  }

  static Structure staticLayout = LayoutUtils.struct([
    LayoutUtils.rustEnum([
      LayoutUtils.none("None"),
      LayoutUtils.none("Clear"),
      LayoutUtils.tuple([Uses.staticLayout], property: "Set"),
    ], LayoutUtils.u8(), property: "usesToggle")
  ]);

  @override
  Structure get layout => staticLayout;

  @override
  Map<String, dynamic> serialize() {
    return {
      "usesToggle": {name: fileds?.map((e) => e.serialize()).toList()}
    };
  }
}
