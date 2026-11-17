// Factories for Metaplex Token Authorization Rules.
import 'package:on_chain/solana/src/address/sol_address.dart';
import 'package:on_chain/solana/src/borsh_serialization/program_layout.dart';
import 'package:on_chain/solana/src/instructions/metaplex/token_auth_rules/constant.dart';
import 'package:on_chain/solana/src/instructions/metaplex/token_auth_rules/layouts/instruction/program_layout.dart';
import 'package:on_chain/solana/src/instructions/metaplex/token_auth_rules/layouts/layouts/token_auth_rules_layouts.dart';
import 'package:on_chain/solana/src/models/account/account_meta.dart';
import 'package:on_chain/solana/src/models/transaction/instruction.dart';

/// Token Authorization Rules program.
class TokenAuthRulesProgram extends TransactionInstruction {
  TokenAuthRulesProgram._({
    required super.keys,
    required super.programId,
    required ProgramLayout layout,
  }) : super(data: layout.toBytes());

  /// Decode any Token Auth Rules instruction (0-3).
  factory TokenAuthRulesProgram.fromBytes({
    required List<AccountMeta> keys,
    required List<int> instructionBytes,
    SolAddress programId = TokenAuthRulesProgramConst.programId,
  }) {
    return TokenAuthRulesProgram._(
      keys: keys,
      programId: programId,
      layout: TokenAuthRulesProgramLayoutDispatch.fromBytes(instructionBytes),
    );
  }

  /// CreateOrUpdate (0). `serializedRuleSet` is the
  /// caller-serialized RuleSet (MessagePack or Bytemuck).
  factory TokenAuthRulesProgram.createOrUpdate({
    required SolAddress payer,
    required SolAddress ruleSetPda,
    required List<int> serializedRuleSet,
    SolAddress? systemProgram,
    SolAddress? bufferPda,
    SolAddress? programId,
  }) {
    return TokenAuthRulesProgram._(
      keys: [
        payer.toSignerAndWritable(),
        ruleSetPda.toWritable(),
        (systemProgram ?? SystemProgramConstForAuthRules.systemProgram)
            .toReadOnly(),
        if (bufferPda != null) bufferPda.toReadOnly(),
      ],
      programId: programId ?? TokenAuthRulesProgramConst.programId,
      layout: TokenAuthRulesCreateOrUpdateLayout(
        serializedRuleSet: serializedRuleSet,
      ),
    );
  }

  /// Validate (1). `validateBody` = Borsh of ValidateArgs V1
  /// fields. Rule expansion accounts go in `extraAccounts`.
  factory TokenAuthRulesProgram.validate({
    required SolAddress ruleSetPda,
    required SolAddress mint,
    required SolAddress payer,
    required SolAddress ruleAuthority,
    required SolAddress ruleSetStatePda,
    required List<int> validateBody,
    SolAddress? systemProgram,
    List<SolAddress> extraAccounts = const [],
    SolAddress? programId,
  }) {
    return TokenAuthRulesProgram._(
      keys: [
        ruleSetPda.toReadOnly(),
        mint.toReadOnly(),
        (systemProgram ?? SystemProgramConstForAuthRules.systemProgram)
            .toReadOnly(),
        payer.toSignerAndWritable(),
        ruleAuthority.toSigner(),
        ruleSetStatePda.toWritable(),
        ...extraAccounts.map((e) => e.toReadOnly()),
      ],
      programId: programId ?? TokenAuthRulesProgramConst.programId,
      layout: TokenAuthRulesValidateLayout(validateBody: validateBody),
    );
  }

  /// WriteToBuffer (2).
  factory TokenAuthRulesProgram.writeToBuffer({
    required SolAddress payer,
    required SolAddress bufferPda,
    required List<int> serializedRuleSet,
    required bool overwrite,
    SolAddress? systemProgram,
    SolAddress? programId,
  }) {
    return TokenAuthRulesProgram._(
      keys: [
        payer.toSignerAndWritable(),
        bufferPda.toWritable(),
        (systemProgram ?? SystemProgramConstForAuthRules.systemProgram)
            .toReadOnly(),
      ],
      programId: programId ?? TokenAuthRulesProgramConst.programId,
      layout: TokenAuthRulesWriteToBufferLayout(
        serializedRuleSet: serializedRuleSet,
        overwrite: overwrite,
      ),
    );
  }

  /// PuffRuleSet (3).
  factory TokenAuthRulesProgram.puffRuleSet({
    required SolAddress payer,
    required SolAddress ruleSetPda,
    required String ruleSetName,
    SolAddress? systemProgram,
    SolAddress? programId,
  }) {
    return TokenAuthRulesProgram._(
      keys: [
        payer.toSignerAndWritable(),
        ruleSetPda.toWritable(),
        (systemProgram ?? SystemProgramConstForAuthRules.systemProgram)
            .toReadOnly(),
      ],
      programId: programId ?? TokenAuthRulesProgramConst.programId,
      layout: TokenAuthRulesPuffRuleSetLayout(ruleSetName: ruleSetName),
    );
  }
}

/// System program address for Auth Rules factories.
abstract class SystemProgramConstForAuthRules {
  static const SolAddress systemProgram = SolAddress.unchecked(
    '11111111111111111111111111111111',
  );
}
