import 'package:on_chain/solana/src/address/sol_address.dart';
import 'package:on_chain/solana/src/instructions/stake/types/types.dart';
import 'package:on_chain/solana/src/instructions/stake_pool/types/types.dart';
import 'package:blockchain_utils/layout/layout.dart';
import 'package:on_chain/solana/src/borsh_serialization/program_layout.dart';
import 'package:on_chain/solana/src/utils/layouts.dart';

class _Utils {
  static StructLayout layout = LayoutConst.struct([
    LayoutConst.u8(property: 'accountType'),
    SolanaLayoutUtils.publicKey('manager'),
    SolanaLayoutUtils.publicKey('staker'),
    SolanaLayoutUtils.publicKey('stakeDepositAuthority'),
    LayoutConst.u8(property: 'stakeWithdrawBumpSeed'),
    SolanaLayoutUtils.publicKey('validatorList'),
    SolanaLayoutUtils.publicKey('reserveStake'),
    SolanaLayoutUtils.publicKey('poolMint'),
    SolanaLayoutUtils.publicKey('managerFeeAccount'),
    SolanaLayoutUtils.publicKey('tokenProgramId'),
    LayoutConst.u64(property: 'totalLamports'),
    LayoutConst.u64(property: 'poolTokenSupply'),
    LayoutConst.u64(property: 'lastUpdateEpoch'),
    StakeLockup.staticLayout,
    LayoutConst.wrap(StakePoolFee.staticLayout, property: 'epochFee'),
    LayoutConst.optional(StakePoolFee.staticLayout, property: "nextEpochFee"),
    SolanaLayoutUtils.optionPubkey(
        property: 'preferredDepositValidatorVoteAddress'),
    SolanaLayoutUtils.optionPubkey(
        property: 'preferredWithdrawValidatorVoteAddress'),
    LayoutConst.wrap(StakePoolFee.staticLayout, property: 'stakeDepositFee'),
    LayoutConst.wrap(StakePoolFee.staticLayout, property: 'stakeWithdrawalFee'),
    LayoutConst.optional(StakePoolFee.staticLayout,
        property: "nextStakeWithdrawalFee"),
    LayoutConst.u8(property: 'stakeReferralFee'),
    SolanaLayoutUtils.optionPubkey(property: 'solDepositAuthority'),
    LayoutConst.wrap(StakePoolFee.staticLayout, property: 'solDepositFee'),
    LayoutConst.u8(property: 'solReferralFee'),
    LayoutConst.optional(SolanaLayoutUtils.publicKey(),
        property: "solWithdrawAuthority"),
    LayoutConst.wrap(StakePoolFee.staticLayout, property: 'solWithdrawalFee'),
    LayoutConst.optional(StakePoolFee.staticLayout,
        property: "nextSolWithdrawalFee"),
    LayoutConst.u64(property: 'lastEpochPoolTokenSupply'),
    LayoutConst.u64(property: 'lastEpochTotalLamports'),
  ]);
}

/// Initialized program details.
class StakePoolAccount extends LayoutSerializable {
  final SolAddress address;

  /// Account type, must be StakePool currently
  final StakePoolAccountType accountType;

  /// Manager authority, allows for updating the staker, manager, and fee
  /// account
  final SolAddress manager;

  /// Staker authority, allows for adding and removing validators, and
  /// managing stake distribution
  final SolAddress staker;

  /// Stake deposit authority
  ///
  /// If a depositor pubkey is specified on initialization, then deposits must
  /// be signed by this authority.
  final SolAddress stakeDepositAuthority;

  /// Stake withdrawal authority bump seed
  final int stakeWithdrawBumpSeed;

  /// Validator stake list storage account
  final SolAddress validatorList;

  /// Reserve stake account, holds deactivated stake
  final SolAddress reserveStake;

  /// Pool Mint
  final SolAddress poolMint;

  /// Manager fee account
  final SolAddress managerFeeAccount;

  /// Pool token program id
  final SolAddress tokenProgramId;

  /// Total stake under management.
  /// Note that if [lastUpdateEpoch] does not match the current epoch then
  /// this field may not be accurate
  final BigInt totalLamports;

  /// Total supply of pool tokens (should always match the supply in the Pool
  /// Mint)
  final BigInt poolTokenSupply;

  /// Last epoch the [totalLamports] field was updated
  final BigInt lastUpdateEpoch;

  /// Lockup that all stakes in the pool must have
  final StakeLockup lockup;

  /// Fee taken as a proportion of rewards each epoch
  final StakePoolFee epochFee;

  /// Fee for next epoch
  final StakePoolFee? nextEpochFee;

  /// Preferred deposit validator vote account pubkey
  final SolAddress? preferredDepositValidatorVoteAddress;

  /// Preferred withdraw validator vote account pubkey
  final SolAddress? preferredWithdrawValidatorVoteAddress;

  /// Fee assessed on stake deposits
  final StakePoolFee stakeDepositFee;

  /// Fee assessed on withdrawals
  final StakePoolFee stakeWithdrawalFee;

  /// Future stake withdrawal fee, to be set for the following epoch
  final StakePoolFee? nextStakeWithdrawalFee;

  /// Fees paid out to referrers on referred stake deposits.
  /// Expressed as a percentage (0 - 100) of deposit fees.
  /// i.e. [stakeDepositFee]% of stake deposited is collected as deposit
  /// fees for every deposit and `stake_referral_fee`% of the collected
  /// stake deposit fees is paid out to the referrer
  final int stakeReferralFee;

  /// Toggles whether the [DepositSol] instruction requires a signature from
  /// this [solDepositAuthority]
  final SolAddress? solDepositAuthority;

  /// Fee assessed on SOL deposits
  final StakePoolFee solDepositFee;

  /// Fees paid out to referrers on referred SOL deposits.
  /// Expressed as a percentage (0 - 100) of SOL deposit fees.
  /// i.e. [solDepositFee]% of SOL deposited is collected as deposit fees
  /// for every deposit and [solReferralFee]% of the collected SOL
  /// deposit fees is paid out to the referrer
  final int solReferralFee;

  /// Toggles whether the [WithdrawSol] instruction requires a signature from
  /// the deposit_authority
  final SolAddress? solWithdrawAuthority;

  /// Fee assessed on SOL withdrawals
  final StakePoolFee solWithdrawalFee;

  /// Future SOL withdrawal fee, to be set for the following epoch
  final StakePoolFee? nextSolWithdrawalFee;

  /// Last epoch's total pool tokens, used only for APR estimation
  final BigInt lastEpochPoolTokenSupply;

  /// Last epoch's total lamports, used only for APR estimation
  final BigInt lastEpochTotalLamports;
  const StakePoolAccount(
      {required this.accountType,
      required this.manager,
      required this.staker,
      required this.stakeDepositAuthority,
      required this.stakeWithdrawBumpSeed,
      required this.validatorList,
      required this.reserveStake,
      required this.poolMint,
      required this.managerFeeAccount,
      required this.tokenProgramId,
      required this.totalLamports,
      required this.poolTokenSupply,
      required this.lastUpdateEpoch,
      required this.lockup,
      required this.epochFee,
      this.nextEpochFee,
      this.preferredDepositValidatorVoteAddress,
      this.preferredWithdrawValidatorVoteAddress,
      required this.stakeDepositFee,
      required this.stakeWithdrawalFee,
      required this.nextStakeWithdrawalFee,
      required this.stakeReferralFee,
      this.solDepositAuthority,
      required this.solDepositFee,
      required this.solReferralFee,
      this.solWithdrawAuthority,
      required this.solWithdrawalFee,
      this.nextSolWithdrawalFee,
      required this.lastEpochPoolTokenSupply,
      required this.lastEpochTotalLamports,
      required this.address});

  factory StakePoolAccount.fromBuffer(
      {required List<int> data, required SolAddress address}) {
    final decode = _Utils.layout.deserialize(data).value;
    return StakePoolAccount(
        address: address,
        accountType: StakePoolAccountType.fromValue(decode["accountType"]),
        manager: decode["manager"],
        staker: decode["staker"],
        stakeDepositAuthority: decode["stakeDepositAuthority"],
        stakeWithdrawBumpSeed: decode["stakeWithdrawBumpSeed"],
        validatorList: decode["validatorList"],
        reserveStake: decode["reserveStake"],
        poolMint: decode["poolMint"],
        managerFeeAccount: decode["managerFeeAccount"],
        tokenProgramId: decode["tokenProgramId"],
        totalLamports: decode["totalLamports"],
        poolTokenSupply: decode["poolTokenSupply"],
        lastUpdateEpoch: decode["lastUpdateEpoch"],
        lockup: StakeLockup.fromJson(decode["lockup"]),
        epochFee: StakePoolFee.fromJson(decode["epochFee"]),
        nextEpochFee: decode["nextEpochFee"] == null
            ? null
            : StakePoolFee.fromJson(decode["nextEpochFee"]),
        preferredDepositValidatorVoteAddress:
            decode["preferredDepositValidatorVoteAddress"],
        preferredWithdrawValidatorVoteAddress:
            decode["preferredWithdrawValidatorVoteAddress"],
        stakeDepositFee: StakePoolFee.fromJson(decode["stakeDepositFee"]),
        stakeWithdrawalFee: StakePoolFee.fromJson(decode["stakeWithdrawalFee"]),
        nextStakeWithdrawalFee: decode["nextStakeWithdrawalFee"] == null
            ? null
            : StakePoolFee.fromJson(decode["nextStakeWithdrawalFee"]),
        nextSolWithdrawalFee: decode["nextSolWithdrawalFee"] == null
            ? null
            : StakePoolFee.fromJson(decode["nextSolWithdrawalFee"]),
        stakeReferralFee: decode["stakeReferralFee"],
        solDepositAuthority: decode["solDepositAuthority"],
        solDepositFee: StakePoolFee.fromJson(decode["solDepositFee"]),
        solReferralFee: decode["solReferralFee"],
        solWithdrawAuthority: decode["solWithdrawAuthority"],
        solWithdrawalFee: StakePoolFee.fromJson(decode["solWithdrawalFee"]),
        lastEpochPoolTokenSupply: decode["lastEpochPoolTokenSupply"],
        lastEpochTotalLamports: decode["lastEpochTotalLamports"]);
  }

  @override
  StructLayout get layout => _Utils.layout;

  @override
  Map<String, dynamic> serialize() {
    return {
      "accountType": accountType.value,
      "manager": manager,
      "staker": staker,
      "stakeDepositAuthority": stakeDepositAuthority,
      "stakeWithdrawBumpSeed": stakeWithdrawBumpSeed,
      "validatorList": validatorList,
      "reserveStake": reserveStake,
      "poolMint": poolMint,
      "managerFeeAccount": managerFeeAccount,
      "tokenProgramId": tokenProgramId,
      "totalLamports": totalLamports,
      "poolTokenSupply": poolTokenSupply,
      "lastUpdateEpoch": lastUpdateEpoch,
      "lockup": lockup.serialize(),
      "epochFee": epochFee.serialize(),
      "nextEpochFee": nextEpochFee?.serialize(),
      "preferredDepositValidatorVoteAddress":
          preferredDepositValidatorVoteAddress,
      "preferredWithdrawValidatorVoteAddress":
          preferredWithdrawValidatorVoteAddress,
      "stakeDepositFee": stakeDepositFee.serialize(),
      "stakeWithdrawalFee": stakeWithdrawalFee.serialize(),
      "nextStakeWithdrawalFee": nextStakeWithdrawalFee?.serialize(),
      "stakeReferralFee": stakeReferralFee,
      "solDepositAuthority": solDepositAuthority,
      "solDepositFee": solDepositFee.serialize(),
      "solReferralFee": solReferralFee,
      "solWithdrawAuthority": solWithdrawAuthority,
      "solWithdrawalFee": solWithdrawalFee.serialize(),
      "nextSolWithdrawalFee": nextSolWithdrawalFee?.serialize(),
      "lastEpochPoolTokenSupply": lastEpochPoolTokenSupply,
      "lastEpochTotalLamports": lastEpochTotalLamports
    };
  }

  @override
  String toString() {
    return "StakeAccount${serialize()}";
  }
}
