import 'package:blockchain_utils/blockchain_utils.dart';
import 'package:on_chain/exception/onchain_error.dart';

class TokenProgramVersion {
  final String name;
  final int value;
  const TokenProgramVersion._(this.name, this.value);

  static const TokenProgramVersion orginal = TokenProgramVersion._(
    'Original',
    0,
  );
  static const TokenProgramVersion token2022 = TokenProgramVersion._(
    'Token2022',
    1,
  );
  static const List<TokenProgramVersion> values = [orginal, token2022];
  static TokenProgramVersion fromValue(int? value) {
    return values.firstWhere(
      (element) => element.value == value,
      orElse:
          () =>
              throw BuError(
                OnChainErrorType.solanaPlugin,
                'No TokenProgramVersion found matching the specified value',
                details: {'value': value?.toString()},
              ),
    );
  }

  @override
  String toString() {
    return 'TokenProgramVersion.$name';
  }
}
