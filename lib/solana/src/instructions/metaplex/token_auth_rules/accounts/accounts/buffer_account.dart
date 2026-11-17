import 'package:blockchain_utils/blockchain_utils.dart';

/// Token Authorization Rules buffer PDA. Accumulates serialized
/// RuleSet chunks via `writeToBuffer`; travels raw.
class TokenAuthRulesBufferAccount {
  /// Raw buffer PDA bytes.
  final List<int> rawBytes;

  TokenAuthRulesBufferAccount({required List<int> rawBytes})
    : rawBytes = rawBytes.asImmutableBytes;

  factory TokenAuthRulesBufferAccount.fromBuffer(List<int> data) {
    if (data.isEmpty) {
      throw BuError(
        DefaultErrorType.invalidArgument,
        'Token Auth Rules buffer account data empty.',
      );
    }
    return TokenAuthRulesBufferAccount(rawBytes: data);
  }
}
