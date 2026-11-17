import 'package:on_chain/solana/src/models/transaction/compiled_instruction.dart';
import 'package:on_chain/solana/src/models/transaction/parsed_instruction.dart';

class CompiledInnerInstruction {
  final int index;
  final List<CompiledInstruction> instructions;
  final List<ParsedInstruction> parsedInstructions;
  const CompiledInnerInstruction({
    required this.index,
    required this.instructions,
    this.parsedInstructions = const [],
  });
  factory CompiledInnerInstruction.fromJson(Map<String, dynamic> json) {
    final List<CompiledInstruction> instructions = [];
    final List<ParsedInstruction> parsed = [];
    for (final e in (json['instructions'] as List)) {
      final entry = (e as Map).cast<String, dynamic>();
      if (entry.containsKey('programIdIndex')) {
        instructions.add(CompiledInstruction.fromJson(entry));
      } else {
        parsed.add(ParsedInstruction.fromJson(entry));
      }
    }
    return CompiledInnerInstruction(
      index: json['index'],
      instructions: instructions,
      parsedInstructions: parsed,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'index': index,
      'instructions': [
        ...instructions.map((e) => e.toJson()),
        ...parsedInstructions.map((e) => e.toJson()),
      ],
    };
  }
}
