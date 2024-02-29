import 'package:on_chain/solana/src/models/transaction/compiled_instructon.dart';

class CompiledInnerInstruction {
  final int index;
  final List<CompiledInstruction> instructions;
  const CompiledInnerInstruction(
      {required this.index, required this.instructions});
  factory CompiledInnerInstruction.fromJson(Map<String, dynamic> json) {
    return CompiledInnerInstruction(
        index: json["index"],
        instructions: (json["instructions"] as List)
            .map((e) => CompiledInstruction.fromJson(e))
            .toList());
  }
}
