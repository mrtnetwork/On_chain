import 'package:on_chain/solana/src/instructions/stake_pool/types/types.dart';
import 'package:on_chain/solana/src/layout/layout.dart';

class _Utils {
  static Structure layout = LayoutUtils.struct([
    LayoutUtils.u8('accountType'),
    LayoutUtils.u32('maxValidators'),
    LayoutUtils.vec(ValidatorStakeInfo.staticLayout, property: 'validators'),
  ]);
}

class StakeValidatorListAccount extends LayoutSerializable {
  /// Account type, must be ValidatorList currently
  final StakePoolAccountType accountType;

  /// Maximum allowable number of validators
  final int maxValidators;

  /// List of stake info for each validator in the pool
  final List<ValidatorStakeInfo> validators;
  const StakeValidatorListAccount(
      {required this.accountType,
      required this.validators,
      required this.maxValidators});

  factory StakeValidatorListAccount.fromBuffer(List<int> data) {
    final decode = _Utils.layout.decode(data);
    return StakeValidatorListAccount(
        accountType: StakePoolAccountType.fromValue(decode["accountType"]),
        validators: (decode["validators"] as List)
            .map((e) => ValidatorStakeInfo.fromJson(e))
            .toList(),
        maxValidators: decode["maxValidators"]);
  }

  @override
  Structure get layout => _Utils.layout;

  @override
  Map<String, dynamic> serialize() {
    return {
      "accountType": accountType.value,
      "maxValidators": maxValidators,
      "validators": validators.map((e) => e.serialize()).toList()
    };
  }

  @override
  String toString() {
    return "StakeValidatorListAccount${serialize()}";
  }
}
