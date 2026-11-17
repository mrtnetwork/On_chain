// Borsh layouts for Token Authorization Rules (u8 ix + u8 V1 variant).
// Caller-serialized rule sets / validate payloads travel as raw bytes;
// scalar fields are typed.
import 'package:blockchain_utils/blockchain_utils.dart';
import 'package:on_chain/solana/src/borsh_serialization/program_layout.dart';
import 'package:on_chain/solana/src/instructions/metaplex/token_auth_rules/layouts/instruction/instructions.dart';

/// Shared base for Token Auth Rules layouts.
abstract class TokenAuthRulesProgramLayout extends ProgramLayout {
  const TokenAuthRulesProgramLayout();

  /// V1 enum variant used by every instruction.
  static const int v1Variant = 0;
}

/// CreateOrUpdate V1 with a caller-serialized rule set.
class TokenAuthRulesCreateOrUpdateLayout extends TokenAuthRulesProgramLayout {
  final List<int> serializedRuleSet;
  TokenAuthRulesCreateOrUpdateLayout({required List<int> serializedRuleSet})
    : serializedRuleSet = serializedRuleSet.asImmutableBytes;

  static StructLayout get _layout => LayoutConst.struct([
    LayoutConst.u8(property: 'instruction'),
    LayoutConst.u8(property: 'variant'),
    LayoutConst.vecU8(property: 'serializedRuleSet'),
  ]);

  factory TokenAuthRulesCreateOrUpdateLayout.fromBuffer(List<int> bytes) {
    final decode = ProgramLayout.decodeAndValidateStruct(
      layout: _layout,
      bytes: bytes,
      instruction: TokenAuthRulesProgramInstruction.createOrUpdate.instruction,
    );
    return TokenAuthRulesCreateOrUpdateLayout(
      serializedRuleSet: (decode['serializedRuleSet'] as List).cast<int>(),
    );
  }

  @override
  StructLayout get layout => _layout;

  @override
  final TokenAuthRulesProgramInstruction instruction =
      TokenAuthRulesProgramInstruction.createOrUpdate;

  @override
  Map<String, dynamic> serialize() {
    return {
      'variant': TokenAuthRulesProgramLayout.v1Variant,
      'serializedRuleSet': serializedRuleSet,
    };
  }
}

/// WriteToBuffer V1 with overwrite flag.
class TokenAuthRulesWriteToBufferLayout extends TokenAuthRulesProgramLayout {
  final List<int> serializedRuleSet;
  final bool overwrite;
  TokenAuthRulesWriteToBufferLayout({
    required List<int> serializedRuleSet,
    required this.overwrite,
  }) : serializedRuleSet = serializedRuleSet.asImmutableBytes;

  static StructLayout get _layout => LayoutConst.struct([
    LayoutConst.u8(property: 'instruction'),
    LayoutConst.u8(property: 'variant'),
    LayoutConst.vecU8(property: 'serializedRuleSet'),
    LayoutConst.u8(property: 'overwrite'),
  ]);

  factory TokenAuthRulesWriteToBufferLayout.fromBuffer(List<int> bytes) {
    final decode = ProgramLayout.decodeAndValidateStruct(
      layout: _layout,
      bytes: bytes,
      instruction: TokenAuthRulesProgramInstruction.writeToBuffer.instruction,
    );
    return TokenAuthRulesWriteToBufferLayout(
      serializedRuleSet: (decode['serializedRuleSet'] as List).cast<int>(),
      overwrite: decode['overwrite'] == 1,
    );
  }

  @override
  StructLayout get layout => _layout;

  @override
  final TokenAuthRulesProgramInstruction instruction =
      TokenAuthRulesProgramInstruction.writeToBuffer;

  @override
  Map<String, dynamic> serialize() {
    return {
      'variant': TokenAuthRulesProgramLayout.v1Variant,
      'serializedRuleSet': serializedRuleSet,
      'overwrite': overwrite ? 1 : 0,
    };
  }
}

/// PuffRuleSet V1 { rule_set_name: String }.
class TokenAuthRulesPuffRuleSetLayout extends TokenAuthRulesProgramLayout {
  final String ruleSetName;
  const TokenAuthRulesPuffRuleSetLayout({required this.ruleSetName});

  static StructLayout get _layout => LayoutConst.struct([
    LayoutConst.u8(property: 'instruction'),
    LayoutConst.u8(property: 'variant'),
    LayoutConst.string(property: 'ruleSetName'),
  ]);

  factory TokenAuthRulesPuffRuleSetLayout.fromBuffer(List<int> bytes) {
    final decode = ProgramLayout.decodeAndValidateStruct(
      layout: _layout,
      bytes: bytes,
      instruction: TokenAuthRulesProgramInstruction.puffRuleSet.instruction,
    );
    return TokenAuthRulesPuffRuleSetLayout(ruleSetName: decode['ruleSetName']);
  }

  @override
  StructLayout get layout => _layout;

  @override
  final TokenAuthRulesProgramInstruction instruction =
      TokenAuthRulesProgramInstruction.puffRuleSet;

  @override
  Map<String, dynamic> serialize() {
    return {
      'variant': TokenAuthRulesProgramLayout.v1Variant,
      'ruleSetName': ruleSetName,
    };
  }
}

/// Validate V1 body travels raw (operation + Payload +
/// update_rule_state + rule_set_revision), since `Payload` is a large
/// multi-variant type. `validateBody` = Borsh of the V1 fields.
class TokenAuthRulesValidateLayout extends TokenAuthRulesProgramLayout {
  final List<int> validateBody;
  TokenAuthRulesValidateLayout({required List<int> validateBody})
    : validateBody = validateBody.asImmutableBytes;

  static StructLayout get _layout => LayoutConst.struct([
    LayoutConst.u8(property: 'instruction'),
    LayoutConst.u8(property: 'variant'),
  ]);

  factory TokenAuthRulesValidateLayout.fromBuffer(List<int> bytes) {
    ProgramLayout.decodeAndValidateStruct(
      layout: _layout,
      bytes: bytes,
      instruction: TokenAuthRulesProgramInstruction.validate.instruction,
    );
    return TokenAuthRulesValidateLayout(validateBody: bytes.sublist(2));
  }

  @override
  StructLayout get layout => _layout;

  @override
  final TokenAuthRulesProgramInstruction instruction =
      TokenAuthRulesProgramInstruction.validate;

  @override
  Map<String, dynamic> serialize() => {};

  @override
  BuBytes toBytes() {
    final head = _layout.serialize({
      'instruction': instruction.instruction,
      'variant': TokenAuthRulesProgramLayout.v1Variant,
    });
    final data = BuBytes.fill(head.length + validateBody.length, 0);
    data.setAll(0, head);
    data.setAll(head.length, validateBody);
    return data;
  }
}
