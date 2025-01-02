import 'package:on_chain/solana/src/exception/exception.dart';
import 'package:blockchain_utils/layout/layout.dart';
import 'package:on_chain/solana/src/address/sol_address.dart';
import 'package:on_chain/solana/src/borsh_serialization/program_layout.dart';
import 'package:on_chain/solana/src/utils/layouts.dart';

class ProgrammableConfigRecord extends LayoutSerializable {
  final String name;
  final dynamic fields;
  const ProgrammableConfigRecord._(this.name, this.fields);
  factory ProgrammableConfigRecord.v1({SolAddress? ruleSet}) {
    return ProgrammableConfigRecord._('V1', ruleSet);
  }
  factory ProgrammableConfigRecord.fromJson(Map<String, dynamic> json) {
    final name = json['programmableConfigRecord']['key'];
    if (name != 'V1') {
      throw SolanaPluginException(
          'Invalid ProgrammableConfigRecord version: $name. Expected version: V1');
    }
    return ProgrammableConfigRecord._(json['programmableConfigRecord']['key'],
        json['programmableConfigRecord']['value']);
  }
  static StructLayout staticLayout = LayoutConst.struct([
    LayoutConst.rustEnum([SolanaLayoutUtils.optionPubkey(property: 'V1')],
        property: 'programmableConfigRecord')
  ]);

  @override
  StructLayout get layout => staticLayout;
  @override
  Map<String, dynamic> serialize() {
    return {
      'programmableConfigRecord': {name: fields}
    };
  }
}
