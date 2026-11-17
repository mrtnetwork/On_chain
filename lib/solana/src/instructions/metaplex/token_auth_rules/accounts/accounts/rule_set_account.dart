import 'package:blockchain_utils/blockchain_utils.dart';

/// Token Authorization Rules RuleSet PDA. Stores the
/// caller-serialized RuleSet (MessagePack or Bytemuck); travels raw until
/// the full RuleSet header struct is typed.
class TokenAuthRulesRuleSetAccount {
  /// Raw RuleSet PDA bytes.
  final List<int> rawBytes;

  TokenAuthRulesRuleSetAccount({required List<int> rawBytes})
    : rawBytes = rawBytes.asImmutableBytes;

  factory TokenAuthRulesRuleSetAccount.fromBuffer(List<int> data) {
    if (data.isEmpty) {
      throw BuError(
        DefaultErrorType.invalidArgument,
        'Token Auth Rules RuleSet account data empty.',
      );
    }
    return TokenAuthRulesRuleSetAccount(rawBytes: data);
  }
}
