import 'package:on_chain/solana/src/exception/exception.dart';
import 'package:blockchain_utils/layout/layout.dart';
import 'package:on_chain/solana/src/borsh_serialization/program_layout.dart';

class CandyMachineAccountVersion extends LayoutSerializable {
  final String name;
  const CandyMachineAccountVersion._(this.name);
  static const CandyMachineAccountVersion v1 =
      CandyMachineAccountVersion._('V1');
  static const CandyMachineAccountVersion v2 =
      CandyMachineAccountVersion._('V2');

  static const List<CandyMachineAccountVersion> values = [v1, v2];
  static StructLayout staticLayout = LayoutConst.struct([
    LayoutConst.rustEnum(
        values.map((e) => LayoutConst.none(property: e.name)).toList(),
        property: 'candyMachineAccountVersion')
  ]);

  static CandyMachineAccountVersion fromName(String? value) {
    return values.firstWhere(
      (element) => element.name == value,
      orElse: () => throw SolanaPluginException(
          'No CandyMachineAccountVersion found matching the specified value',
          details: {'value': value}),
    );
  }

  factory CandyMachineAccountVersion.fromJson(Map<String, dynamic> json) {
    return fromName(json['candyMachineAccountVersion']['key']);
  }

  @override
  StructLayout get layout => staticLayout;

  @override
  Map<String, dynamic> serialize() {
    return {
      'candyMachineAccountVersion': {name: null}
    };
  }

  @override
  String toString() {
    return 'CandyMachineAccountVersion.$name';
  }
}
