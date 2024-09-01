import 'package:on_chain/solana/src/exception/exception.dart';
import 'package:blockchain_utils/layout/layout.dart';
import 'package:on_chain/solana/src/borsh_serialization/program_layout.dart';

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

  static StructLayout staticLayout = LayoutConst.struct([
    LayoutConst.rustEnum(
        values.map((e) => LayoutConst.none(property: e.name)).toList(),
        property: "groupMemberPointer")
  ]);
  @override
  StructLayout get layout => staticLayout;

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
      orElse: () => throw SolanaPluginException(
          "No GroupMemberPointerInstruction found matching the specified value",
          details: {"value": value}),
    );
  }

  @override
  String toString() {
    return "GroupMemberPointerInstruction${serialize()}";
  }
}
