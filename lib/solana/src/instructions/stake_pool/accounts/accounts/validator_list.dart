import 'package:on_chain/solana/src/instructions/stake_pool/types/types.dart';
import 'package:blockchain_utils/layout/layout.dart';
import 'package:on_chain/solana/src/borsh_serialization/program_layout.dart';

class _Utils {
  static StructLayout layout = LayoutConst.struct([
    LayoutConst.u8(property: 'accountType'),
    LayoutConst.u32(property: 'maxValidators'),
    LayoutConst.vec(ValidatorStakeInfo.staticLayout, property: 'validators'),
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
    final decode = _Utils.layout.deserialize(data).value;
    return StakeValidatorListAccount(
        accountType: StakePoolAccountType.fromValue(decode['accountType']),
        validators: (decode['validators'] as List)
            .map((e) => ValidatorStakeInfo.fromJson(e))
            .toList(),
        maxValidators: decode['maxValidators']);
  }

  @override
  StructLayout get layout => _Utils.layout;

  @override
  Map<String, dynamic> serialize() {
    return {
      'accountType': accountType.value,
      'maxValidators': maxValidators,
      'validators': validators.map((e) => e.serialize()).toList()
    };
  }

  @override
  String toString() {
    return 'StakeValidatorListAccount${serialize()}';
  }
}
