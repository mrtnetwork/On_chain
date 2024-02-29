import 'package:blockchain_utils/exception/exception.dart';
import 'package:on_chain/solana/src/layout/layout.dart';

class GroupPointerInstruction extends LayoutSerializable {
  const GroupPointerInstruction._(this.name);
  final String name;
  static const GroupPointerInstruction initialize =
      GroupPointerInstruction._("Initialize");
  static const GroupPointerInstruction update =
      GroupPointerInstruction._("Update");

  static const List<GroupPointerInstruction> values = [initialize, update];

  static Structure staticLayout = LayoutUtils.struct([
    LayoutUtils.rustEnum(
        values.map((e) => LayoutUtils.none(e.name)).toList(), LayoutUtils.u8(),
        property: "groupPointer")
  ]);
  @override
  Structure get layout => staticLayout;

  @override
  Map<String, dynamic> serialize() {
    return {
      "groupPointer": {name: null}
    };
  }

  factory GroupPointerInstruction.fromJson(Map<String, dynamic> json) {
    return fromName(json["groupMemberPointer"]["key"]);
  }
  static GroupPointerInstruction fromName(String? value) {
    return values.firstWhere(
      (element) => element.name == value,
      orElse: () => throw MessageException(
          "No GroupPointerInstruction found matching the specified value",
          details: {"value": value}),
    );
  }

  @override
  String toString() {
    return "GroupPointerInstruction${serialize()}";
  }
}
