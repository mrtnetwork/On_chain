import 'package:on_chain/solana/src/address/sol_address.dart';
import 'package:blockchain_utils/layout/layout.dart';
import 'package:on_chain/solana/src/borsh_serialization/program_layout.dart';
import 'package:on_chain/solana/src/utils/layouts.dart';

class RuleSetToggle extends LayoutSerializable {
  const RuleSetToggle._(this.name, this.value, this.fileds);
  final String name;
  final int value;
  final List<SolAddress>? fileds;
  factory RuleSetToggle.fromJson(Map<String, dynamic> json) {
    final key = json['ruleSetToggle']['key'];
    final List<dynamic> value = json['ruleSetToggle']['value'];
    switch (key) {
      case 'NoneLayout':
        return none;
      case 'Clear':
        return clear;
      default:
        return RuleSetToggle.set(address: value[0]);
    }
  }
  static const RuleSetToggle none = RuleSetToggle._('NoneLayout', 0, null);
  static const RuleSetToggle clear = RuleSetToggle._('Clear', 1, null);
  factory RuleSetToggle.set({required SolAddress address}) {
    return RuleSetToggle._('Set', 2, [address]);
  }

  static StructLayout staticLayout = LayoutConst.struct([
    LayoutConst.rustEnum([
      LayoutConst.none(property: 'NoneLayout'),
      LayoutConst.none(property: 'Clear'),
      LayoutConst.tuple([SolanaLayoutUtils.publicKey()], property: 'Set'),
    ], property: 'ruleSetToggle')
  ]);

  @override
  StructLayout get layout => staticLayout;

  @override
  Map<String, dynamic> serialize() {
    return {
      'ruleSetToggle': {name: fileds}
    };
  }
}
