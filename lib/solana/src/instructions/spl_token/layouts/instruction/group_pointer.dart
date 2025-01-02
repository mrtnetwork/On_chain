import 'package:on_chain/solana/src/exception/exception.dart';
import 'package:blockchain_utils/layout/layout.dart';
import 'package:on_chain/solana/src/borsh_serialization/program_layout.dart';

class GroupPointerInstruction extends LayoutSerializable {
  const GroupPointerInstruction._(this.name);
  final String name;
  static const GroupPointerInstruction initialize =
      GroupPointerInstruction._('Initialize');
  static const GroupPointerInstruction update =
      GroupPointerInstruction._('Update');

  static const List<GroupPointerInstruction> values = [initialize, update];

  static StructLayout staticLayout = LayoutConst.struct([
    LayoutConst.rustEnum(
        values.map((e) => LayoutConst.none(property: e.name)).toList(),
        property: 'groupPointer')
  ]);
  @override
  StructLayout get layout => staticLayout;

  @override
  Map<String, dynamic> serialize() {
    return {
      'groupPointer': {name: null}
    };
  }

  factory GroupPointerInstruction.fromJson(Map<String, dynamic> json) {
    return fromName(json['groupMemberPointer']['key']);
  }
  static GroupPointerInstruction fromName(String? value) {
    return values.firstWhere(
      (element) => element.name == value,
      orElse: () => throw SolanaPluginException(
          'No GroupPointerInstruction found matching the specified value',
          details: {'value': value}),
    );
  }

  @override
  String toString() {
    return 'GroupPointerInstruction${serialize()}';
  }
}
