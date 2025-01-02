import 'package:blockchain_utils/layout/layout.dart';
import 'package:on_chain/solana/src/borsh_serialization/program_layout.dart';

class BotTax extends LayoutSerializable {
  final BigInt lamports;
  final bool lastInstruction;

  const BotTax({required this.lamports, required this.lastInstruction});
  factory BotTax.fromJson(Map<String, dynamic> json) {
    return BotTax(
        lamports: json['lamports'], lastInstruction: json['lastInstruction']);
  }

  static final StructLayout staticLayout = LayoutConst.struct([
    LayoutConst.u64(property: 'lamports'),
    LayoutConst.boolean(property: 'lastInstruction')
  ], property: 'botTax');

  @override
  StructLayout get layout => staticLayout;
  @override
  Map<String, dynamic> serialize() {
    return {'lastInstruction': lastInstruction, 'lamports': lamports};
  }

  @override
  String toString() {
    return 'BotTax${serialize()}';
  }
}
