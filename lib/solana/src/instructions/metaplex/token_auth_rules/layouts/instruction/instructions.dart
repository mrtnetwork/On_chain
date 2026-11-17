import 'package:on_chain/solana/src/address/sol_address.dart';
import 'package:on_chain/solana/src/borsh_serialization/program_layout.dart';
import 'package:on_chain/solana/src/instructions/metaplex/token_auth_rules/constant.dart';

/// Token Authorization Rules instructions (Borsh u8 0-3).
/// Args are V1 versioned enums (variant 0); complex rule payloads travel as
/// raw Borsh produced by the caller.
class TokenAuthRulesProgramInstruction implements ProgramLayoutInstruction {
  @override
  final int instruction;
  @override
  final String name;
  const TokenAuthRulesProgramInstruction(this.instruction, this.name);

  /// Store a caller-serialized RuleSet into the rule-set PDA.
  static const TokenAuthRulesProgramInstruction createOrUpdate =
      TokenAuthRulesProgramInstruction(0, 'CreateOrUpdate');

  /// Execute the RuleSet stored in the rule-set PDA.
  static const TokenAuthRulesProgramInstruction validate =
      TokenAuthRulesProgramInstruction(1, 'Validate');

  /// Append serialized RuleSet bytes into the buffer PDA.
  static const TokenAuthRulesProgramInstruction writeToBuffer =
      TokenAuthRulesProgramInstruction(2, 'WriteToBuffer');

  /// Resize the rule-set PDA down after shrinking the RuleSet.
  static const TokenAuthRulesProgramInstruction puffRuleSet =
      TokenAuthRulesProgramInstruction(3, 'PuffRuleSet');

  static const List<TokenAuthRulesProgramInstruction> values = [
    createOrUpdate,
    validate,
    writeToBuffer,
    puffRuleSet,
  ];

  static TokenAuthRulesProgramInstruction? getInstruction(dynamic value) {
    for (final e in values) {
      if (e.instruction == value) return e;
    }
    return null;
  }

  @override
  String get programName => 'TokenAuthRules';

  @override
  SolAddress get programAddress => TokenAuthRulesProgramConst.programId;
}
