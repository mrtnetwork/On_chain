import 'package:blockchain_utils/exception/exception.dart';
import 'package:on_chain/solana/src/layout/layout.dart';

class DefaultAccountStateInstruction extends LayoutSerializable {
  const DefaultAccountStateInstruction._(this.name);
  final String name;

  /// Initialize a new mint with the default state for new Accounts.
  static const DefaultAccountStateInstruction initialize =
      DefaultAccountStateInstruction._("Initialize");

  /// Update the default state for new Accounts. Only supported for mints that
  /// include the [DefaultAccountState] extension.
  static const DefaultAccountStateInstruction update =
      DefaultAccountStateInstruction._("Update");
  static const List<DefaultAccountStateInstruction> values = [
    initialize,
    update
  ];

  static Structure staticLayout = LayoutUtils.struct([
    LayoutUtils.rustEnum(
        values.map((e) => LayoutUtils.none(e.name)).toList(), LayoutUtils.u8(),
        property: "defaultAccountState")
  ]);
  @override
  Structure get layout => staticLayout;

  @override
  Map<String, dynamic> serialize() {
    return {
      "defaultAccountState": {name: null}
    };
  }

  factory DefaultAccountStateInstruction.fromJson(Map<String, dynamic> json) {
    return fromName(json["defaultAccountState"]["key"]);
  }
  static DefaultAccountStateInstruction fromName(String? value) {
    return values.firstWhere(
      (element) => element.name == value,
      orElse: () => throw MessageException(
          "No DefaultAccountState found matching the specified value",
          details: {"value": value}),
    );
  }

  @override
  String toString() {
    return "DefaultAccountState${serialize()}";
  }
}
