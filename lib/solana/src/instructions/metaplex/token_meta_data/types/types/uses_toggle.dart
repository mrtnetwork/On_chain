import 'package:on_chain/solana/src/instructions/metaplex/bubblegum/bubblegum.dart';
import 'package:blockchain_utils/layout/layout.dart';
import 'package:on_chain/solana/src/borsh_serialization/program_layout.dart';

class UsesToggle extends LayoutSerializable {
  const UsesToggle._(this.name, this.value, this.fileds);
  final String name;
  final int value;
  final List<Uses>? fileds;
  factory UsesToggle.fromJson(Map<String, dynamic> json) {
    final key = json['usesToggle']['key'];
    final List<dynamic> value = json['usesToggle']['value'];
    switch (key) {
      case 'NoneLayout':
        return none;
      case 'Clear':
        return clear;
      default:
        return UsesToggle.set(uses: Uses.fromJson(value[0]));
    }
  }
  static const UsesToggle none = UsesToggle._('NoneLayout', 0, null);
  static const UsesToggle clear = UsesToggle._('Clear', 1, null);
  factory UsesToggle.set({required Uses uses}) {
    return UsesToggle._('Set', 2, [uses]);
  }

  static StructLayout staticLayout = LayoutConst.struct([
    LayoutConst.rustEnum([
      LayoutConst.none(property: 'NoneLayout'),
      LayoutConst.none(property: 'Clear'),
      LayoutConst.tuple([Uses.staticLayout], property: 'Set'),
    ], property: 'usesToggle')
  ]);

  @override
  StructLayout get layout => staticLayout;

  @override
  Map<String, dynamic> serialize() {
    return {
      'usesToggle': {name: fileds?.map((e) => e.serialize()).toList()}
    };
  }
}
