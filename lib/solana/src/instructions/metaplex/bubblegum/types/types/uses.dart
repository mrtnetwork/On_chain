import 'package:blockchain_utils/layout/layout.dart';
import 'package:on_chain/solana/src/borsh_serialization/program_layout.dart';
import 'uses_method.dart';

class Uses extends LayoutSerializable {
  final UseMethod useMethod;
  final BigInt remaining;
  final BigInt total;
  const Uses(
      {required this.useMethod, required this.remaining, required this.total});
  factory Uses.fromJson(Map<String, dynamic> json) {
    return Uses(
        useMethod: UseMethod.fromValue(json['useMethod']),
        remaining: json['remaining'],
        total: json['total']);
  }
  static final StructLayout staticLayout = LayoutConst.struct([
    LayoutConst.u8(property: 'useMethod'),
    LayoutConst.u64(property: 'remaining'),
    LayoutConst.u64(property: 'total')
  ], property: 'uses');
  @override
  StructLayout get layout => staticLayout;
  @override
  Map<String, dynamic> serialize() {
    return {
      'useMethod': useMethod.value,
      'remaining': remaining,
      'total': total
    };
  }

  @override
  String toString() {
    return 'Uses${serialize()}';
  }
}
