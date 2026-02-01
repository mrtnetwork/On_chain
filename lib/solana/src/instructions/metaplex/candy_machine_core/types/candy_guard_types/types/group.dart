import 'package:on_chain/solana/src/instructions/metaplex/candy_machine_core/types/candy_guard_types/types/guard_set.dart';
import 'package:blockchain_utils/layout/layout.dart';
import 'package:on_chain/solana/src/borsh_serialization/program_layout.dart';

class Group extends BorshLayoutSerializable {
  final String label;
  final GuardSet guards;

  const Group({required this.label, required this.guards});
  factory Group.fromJson(Map<String, dynamic> json) {
    return Group(label: json['label'], guards: json['guards']);
  }

  static StructLayout get staticLayout => LayoutConst.struct([
        LayoutConst.string(property: 'label'),
        GuardSet.staticLayout,
      ], property: 'group');

  @override
  StructLayout get layout => staticLayout;
  @override
  Map<String, dynamic> serialize() {
    return {'label': label, 'guards': guards.serialize()};
  }

  @override
  String toString() {
    return 'Group${serialize()}';
  }
}
