import 'package:on_chain/solana/src/address/sol_address.dart';
import 'package:blockchain_utils/layout/layout.dart';
import 'package:on_chain/solana/src/borsh_serialization/program_layout.dart';
import 'package:on_chain/solana/src/utils/layouts.dart';
import 'validator_stake_info_status.dart';

/// Information about a validator in the pool
class ValidatorStakeInfo extends LayoutSerializable {
  /// Amount of active stake delegated to this validator
  final BigInt activeStakeLamports;

  /// Amount of transient stake delegated to this validator
  final BigInt transientStakeLamports;

  /// Last epoch the active and transient stake lamports fields were updated
  final BigInt lastUpdateEpoch;

  /// Start of the validator transient account seed suffixes
  final BigInt transientSeedSuffixStart;

  /// End of the validator transient account seed suffixes
  final BigInt transientSeedSuffixEnd;

  /// Status of the validator stake account
  final ValidatorStakeInfoStatus status;

  /// Validator vote account address
  final SolAddress voteAccountAddress;
  const ValidatorStakeInfo(
      {required this.activeStakeLamports,
      required this.transientStakeLamports,
      required this.lastUpdateEpoch,
      required this.transientSeedSuffixStart,
      required this.transientSeedSuffixEnd,
      required this.status,
      required this.voteAccountAddress});
  factory ValidatorStakeInfo.fromJson(Map<String, dynamic> json) {
    return ValidatorStakeInfo(
        activeStakeLamports: json["activeStakeLamports"],
        transientStakeLamports: json["transientStakeLamports"],
        lastUpdateEpoch: json["lastUpdateEpoch"],
        transientSeedSuffixStart: json["transientSeedSuffixStart"],
        transientSeedSuffixEnd: json["transientSeedSuffixEnd"],
        status: ValidatorStakeInfoStatus.fromValue(json["status"]),
        voteAccountAddress: json["voteAccountAddress"]);
  }

  static final staticLayout = LayoutConst.struct([
    LayoutConst.u64(property: 'activeStakeLamports'),
    LayoutConst.u64(property: 'transientStakeLamports'),
    LayoutConst.u64(property: 'lastUpdateEpoch'),
    LayoutConst.u64(property: 'transientSeedSuffixStart'),
    LayoutConst.u64(property: 'transientSeedSuffixEnd'),
    LayoutConst.u8(property: 'status'),
    SolanaLayoutUtils.publicKey('voteAccountAddress'),
  ], property: "validatorStakeInfo");

  @override
  StructLayout get layout => staticLayout;

  @override
  Map<String, dynamic> serialize() {
    return {
      "activeStakeLamports": activeStakeLamports,
      "transientStakeLamports": transientStakeLamports,
      "lastUpdateEpoch": lastUpdateEpoch,
      "transientSeedSuffixStart": transientSeedSuffixStart,
      "transientSeedSuffixEnd": transientSeedSuffixEnd,
      "status": status.value,
      "voteAccountAddress": voteAccountAddress
    };
  }

  @override
  String toString() {
    return "ValidatorStakeInfo${serialize()}";
  }
}
