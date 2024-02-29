import 'package:on_chain/solana/solana.dart';
import 'package:test/test.dart';

void main() {
  group('stake pool accounts', () {
    _stakePoolAccount();
  });
}

void _stakePoolAccount() {
  test("StakePoolAccount", () {
    final acc = StakePoolAccount(
      address: SystemProgramConst.programId,
      accountType: StakePoolAccountType.stakePool,
      manager: SolAddress("55555555555555555555555555555555555555555555"),
      staker: SolAddress("55555555555555555555555555555555555555555555"),
      stakeDepositAuthority:
          SolAddress("55555555555555555555555555555555555555555555"),
      stakeWithdrawBumpSeed: 255,
      validatorList: SolAddress("55555555555555555555555555555555555555555555"),
      reserveStake: SolAddress("55555555555555555555555555555555555555555555"),
      poolMint: SolAddress("55555555555555555555555555555555555555555555"),
      managerFeeAccount:
          SolAddress("55555555555555555555555555555555555555555555"),
      tokenProgramId:
          SolAddress("55555555555555555555555555555555555555555555"),
      totalLamports: BigInt.from(999),
      poolTokenSupply: BigInt.from(100),
      lastUpdateEpoch: BigInt.from(100),
      lockup: StakeLockup(
        timestamp: BigInt.from(111111111111111),
        epoch: BigInt.from(1),
        custodian: SolAddress("55555555555555555555555555555555555555555555"),
      ),
      epochFee: StakePoolFee(
        denominator: BigInt.from(0),
        numerator: BigInt.from(0),
      ),
      nextEpochFee: StakePoolFee(
        denominator: BigInt.from(0),
        numerator: BigInt.from(0),
      ),
      preferredDepositValidatorVoteAddress:
          SolAddress("55555555555555555555555555555555555555555555"),
      preferredWithdrawValidatorVoteAddress:
          SolAddress("55555555555555555555555555555555555555555555"),
      stakeDepositFee: StakePoolFee(
        denominator: BigInt.from(0),
        numerator: BigInt.from(0),
      ),
      stakeWithdrawalFee: StakePoolFee(
        denominator: BigInt.from(0),
        numerator: BigInt.from(0),
      ),
      nextStakeWithdrawalFee: StakePoolFee(
        denominator: BigInt.from(0),
        numerator: BigInt.from(0),
      ),
      stakeReferralFee: 0,
      solDepositAuthority:
          SolAddress("55555555555555555555555555555555555555555555"),
      solDepositFee: StakePoolFee(
        denominator: BigInt.from(0),
        numerator: BigInt.from(0),
      ),
      solReferralFee: 0,
      solWithdrawalFee: StakePoolFee(
        denominator: BigInt.from(0),
        numerator: BigInt.from(0),
      ),
      lastEpochPoolTokenSupply: BigInt.from(0),
      lastEpochTotalLamports: BigInt.from(0),
    );
    expect(acc.toHex(),
        "013c79ac508701281c10c499706716efb8664aeba2bf47341e3be2bdc11f7047dc3c79ac508701281c10c499706716efb8664aeba2bf47341e3be2bdc11f7047dc3c79ac508701281c10c499706716efb8664aeba2bf47341e3be2bdc11f7047dcff3c79ac508701281c10c499706716efb8664aeba2bf47341e3be2bdc11f7047dc3c79ac508701281c10c499706716efb8664aeba2bf47341e3be2bdc11f7047dc3c79ac508701281c10c499706716efb8664aeba2bf47341e3be2bdc11f7047dc3c79ac508701281c10c499706716efb8664aeba2bf47341e3be2bdc11f7047dc3c79ac508701281c10c499706716efb8664aeba2bf47341e3be2bdc11f7047dce70300000000000064000000000000006400000000000000c7f14e120e65000001000000000000003c79ac508701281c10c499706716efb8664aeba2bf47341e3be2bdc11f7047dc000000000000000000000000000000000100000000000000000000000000000000013c79ac508701281c10c499706716efb8664aeba2bf47341e3be2bdc11f7047dc013c79ac508701281c10c499706716efb8664aeba2bf47341e3be2bdc11f7047dc0000000000000000000000000000000000000000000000000000000000000000010000000000000000000000000000000000013c79ac508701281c10c499706716efb8664aeba2bf47341e3be2bdc11f7047dc000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000");
    final decode = StakePoolAccount.fromBuffer(
        data: acc.toBytes(), address: SystemProgramConst.programId);
    expect(decode.toBytes(), acc.toBytes());
  });
  test("StakePoolAccount_2", () {
    final acc = StakePoolAccount(
      address: SystemProgramConst.programId,
      accountType: StakePoolAccountType.stakePool,
      manager: SolAddress("55555555555555555555555555555555555555555555"),
      staker: SolAddress("55555555555555555555555555555555555555555555"),
      stakeDepositAuthority:
          SolAddress("55555555555555555555555555555555555555555555"),
      stakeWithdrawBumpSeed: 255,
      validatorList: SolAddress("55555555555555555555555555555555555555555555"),
      reserveStake: SolAddress("55555555555555555555555555555555555555555555"),
      poolMint: SolAddress("55555555555555555555555555555555555555555555"),
      managerFeeAccount:
          SolAddress("55555555555555555555555555555555555555555555"),
      tokenProgramId:
          SolAddress("55555555555555555555555555555555555555555555"),
      totalLamports: BigInt.from(999),
      poolTokenSupply: BigInt.from(100),
      lastUpdateEpoch: BigInt.from(100),
      lockup: StakeLockup(
        timestamp: BigInt.from(111111111111111),
        epoch: BigInt.from(1),
        custodian: SolAddress("55555555555555555555555555555555555555555555"),
      ),
      epochFee: StakePoolFee(
        denominator: BigInt.from(0),
        numerator: BigInt.from(0),
      ),
      solWithdrawAuthority:
          SolAddress("55555555555555555555555555555555555555555555"),
      solWithdrawalFee: StakePoolFee(
        denominator: BigInt.from(0),
        numerator: BigInt.from(0),
      ),
      nextSolWithdrawalFee: StakePoolFee(
        denominator: BigInt.from(0),
        numerator: BigInt.from(0),
      ),
      nextEpochFee: StakePoolFee(
        denominator: BigInt.from(0),
        numerator: BigInt.from(0),
      ),
      preferredDepositValidatorVoteAddress:
          SolAddress("55555555555555555555555555555555555555555555"),
      preferredWithdrawValidatorVoteAddress:
          SolAddress("55555555555555555555555555555555555555555555"),
      stakeDepositFee: StakePoolFee(
        denominator: BigInt.from(0),
        numerator: BigInt.from(0),
      ),
      stakeWithdrawalFee: StakePoolFee(
        denominator: BigInt.from(0),
        numerator: BigInt.from(0),
      ),
      nextStakeWithdrawalFee: StakePoolFee(
        denominator: BigInt.from(0),
        numerator: BigInt.from(0),
      ),
      stakeReferralFee: 0,
      solDepositAuthority:
          SolAddress("55555555555555555555555555555555555555555555"),
      solDepositFee: StakePoolFee(
        denominator: BigInt.from(0),
        numerator: BigInt.from(0),
      ),
      solReferralFee: 0,
      lastEpochPoolTokenSupply: BigInt.from(0),
      lastEpochTotalLamports: BigInt.from(0),
    );
    expect(acc.toHex(),
        "013c79ac508701281c10c499706716efb8664aeba2bf47341e3be2bdc11f7047dc3c79ac508701281c10c499706716efb8664aeba2bf47341e3be2bdc11f7047dc3c79ac508701281c10c499706716efb8664aeba2bf47341e3be2bdc11f7047dcff3c79ac508701281c10c499706716efb8664aeba2bf47341e3be2bdc11f7047dc3c79ac508701281c10c499706716efb8664aeba2bf47341e3be2bdc11f7047dc3c79ac508701281c10c499706716efb8664aeba2bf47341e3be2bdc11f7047dc3c79ac508701281c10c499706716efb8664aeba2bf47341e3be2bdc11f7047dc3c79ac508701281c10c499706716efb8664aeba2bf47341e3be2bdc11f7047dce70300000000000064000000000000006400000000000000c7f14e120e65000001000000000000003c79ac508701281c10c499706716efb8664aeba2bf47341e3be2bdc11f7047dc000000000000000000000000000000000100000000000000000000000000000000013c79ac508701281c10c499706716efb8664aeba2bf47341e3be2bdc11f7047dc013c79ac508701281c10c499706716efb8664aeba2bf47341e3be2bdc11f7047dc0000000000000000000000000000000000000000000000000000000000000000010000000000000000000000000000000000013c79ac508701281c10c499706716efb8664aeba2bf47341e3be2bdc11f7047dc0000000000000000000000000000000000013c79ac508701281c10c499706716efb8664aeba2bf47341e3be2bdc11f7047dc00000000000000000000000000000000010000000000000000000000000000000000000000000000000000000000000000");
    final decode = StakePoolAccount.fromBuffer(
        address: SystemProgramConst.programId, data: acc.toBytes());
    expect(decode.toBytes(), acc.toBytes());
  });
}
