import 'package:on_chain/solana/src/borsh_serialization/program_layout.dart';
import 'package:on_chain/solana/src/instructions/metaplex/token_auth_rules/layouts/instruction/instructions.dart';
import 'package:on_chain/solana/src/instructions/metaplex/token_auth_rules/layouts/layouts/token_auth_rules_layouts.dart';

/// Decode dispatch for Token Authorization Rules.
abstract class TokenAuthRulesProgramLayoutDispatch extends ProgramLayout {
  const TokenAuthRulesProgramLayoutDispatch();

  /// Decode any Token Auth Rules instruction (0-3).
  static ProgramLayout fromBytes(List<int> data) {
    TokenAuthRulesProgramInstruction? instruction;
    if (data.isNotEmpty) {
      instruction = TokenAuthRulesProgramInstruction.getInstruction(data[0]);
    }
    switch (instruction) {
      case TokenAuthRulesProgramInstruction.createOrUpdate:
        return TokenAuthRulesCreateOrUpdateLayout.fromBuffer(data);
      case TokenAuthRulesProgramInstruction.validate:
        return TokenAuthRulesValidateLayout.fromBuffer(data);
      case TokenAuthRulesProgramInstruction.writeToBuffer:
        return TokenAuthRulesWriteToBufferLayout.fromBuffer(data);
      case TokenAuthRulesProgramInstruction.puffRuleSet:
        return TokenAuthRulesPuffRuleSetLayout.fromBuffer(data);
      default:
        return UnknownProgramLayout(data);
    }
  }
}
