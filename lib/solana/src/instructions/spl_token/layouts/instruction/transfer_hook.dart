import 'package:blockchain_utils/exception/exception.dart';
import 'package:on_chain/solana/src/layout/layout.dart';

class TransferHookInstruction extends LayoutSerializable {
  final String name;
  const TransferHookInstruction._(this.name);

  /// Initialize a new mint with a transfer hook program.
  static const TransferHookInstruction initialize =
      TransferHookInstruction._("Initialize");

  /// Update the transfer hook program id. Only supported for mints that
  /// include the `TransferHook` extension.
  static const TransferHookInstruction update =
      TransferHookInstruction._("Update");
  static const List<TransferHookInstruction> values = [initialize, update];

  static Structure staticLayout = LayoutUtils.struct([
    LayoutUtils.rustEnum(
        values.map((e) => LayoutUtils.none(e.name)).toList(), LayoutUtils.u8(),
        property: "transferHook")
  ]);
  @override
  Structure get layout => staticLayout;

  @override
  Map<String, dynamic> serialize() {
    return {
      "transferHook": {name: null}
    };
  }

  factory TransferHookInstruction.fromJson(Map<String, dynamic> json) {
    return fromName(json["transferHook"]["key"]);
  }
  static TransferHookInstruction fromName(String? value) {
    return values.firstWhere(
      (element) => element.name == value,
      orElse: () => throw MessageException(
          "No TransferHookInstruction found matching the specified value",
          details: {"value": value}),
    );
  }
}
