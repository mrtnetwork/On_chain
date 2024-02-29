import 'package:blockchain_utils/exception/exception.dart';
import 'package:on_chain/solana/src/layout/layout.dart';

class GroupMemberPointerInstruction extends LayoutSerializable {
  const GroupMemberPointerInstruction._(this.name);
  final String name;
  static const GroupMemberPointerInstruction initialize =
      GroupMemberPointerInstruction._("Initialize");
  static const GroupMemberPointerInstruction update =
      GroupMemberPointerInstruction._("Update");

  static const List<GroupMemberPointerInstruction> values = [
    initialize,
    update
  ];

  static Structure staticLayout = LayoutUtils.struct([
    LayoutUtils.rustEnum(
        values.map((e) => LayoutUtils.none(e.name)).toList(), LayoutUtils.u8(),
        property: "groupMemberPointer")
  ]);
  @override
  Structure get layout => staticLayout;

  @override
  Map<String, dynamic> serialize() {
    return {
      "groupMemberPointer": {name: null}
    };
  }

  factory GroupMemberPointerInstruction.fromJson(Map<String, dynamic> json) {
    return fromName(json["groupMemberPointer"]["key"]);
  }
  static GroupMemberPointerInstruction fromName(String? value) {
    return values.firstWhere(
      (element) => element.name == value,
      orElse: () => throw MessageException(
          "No GroupMemberPointerInstruction found matching the specified value",
          details: {"value": value}),
    );
  }

  @override
  String toString() {
    return "GroupMemberPointerInstruction${serialize()}";
  }
}
