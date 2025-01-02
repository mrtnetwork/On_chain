import 'package:on_chain/solana/src/address/sol_address.dart';
import 'package:blockchain_utils/layout/layout.dart';
import 'package:on_chain/solana/src/borsh_serialization/program_layout.dart';
import 'package:on_chain/solana/src/utils/layouts.dart';

class ProgramGate extends LayoutSerializable {
  final List<SolAddress> additional;

  const ProgramGate({required this.additional});
  factory ProgramGate.fromJson(Map<String, dynamic> json) {
    return ProgramGate(additional: (json['additional'] as List).cast());
  }

  static final StructLayout staticLayout = LayoutConst.struct(
      [LayoutConst.vec(SolanaLayoutUtils.publicKey(), property: 'additional')],
      property: 'programGate');

  @override
  StructLayout get layout => staticLayout;
  @override
  Map<String, dynamic> serialize() {
    return {'additional': additional};
  }

  @override
  String toString() {
    return 'ProgramGate${serialize()}';
  }
}
