import 'package:blockchain_utils/blockchain_utils.dart';

class TronChainParameters {
  const TronChainParameters(
      {this.getMaintenanceTimeInterval,
      this.getAccountUpgradeCost,
      this.getCreateAccountFee,
      this.getTransactionFee,
      this.getAssetIssueFee,
      this.getWitnessPayPerBlock,
      this.getWitnessStandbyAllowance,
      this.getCreateNewAccountFeeInSystemContract,
      this.getCreateNewAccountBandwidthRate,
      this.getAllowCreationOfContracts,
      this.getRemoveThePowerOfTheGr,
      this.getEnergyFee,
      this.getExchangeCreateFee,
      this.getMaxCpuTimeOfOneTx,
      this.getAllowUpdateAccountName,
      this.getAllowSameTokenName,
      this.getAllowDelegateResource,
      this.getTotalEnergyLimit,
      this.getAllowTvmTransferTrc10,
      this.getTotalEnergyCurrentLimit,
      this.getAllowMultiSign,
      this.getAllowAdaptiveEnergy,
      this.getTotalEnergyTargetLimit,
      this.getTotalEnergyAverageUsage,
      this.getUpdateAccountPermissionFee,
      this.getMultiSignFee,
      this.getAllowAccountStateRoot,
      this.getAllowProtoFilterNum,
      this.getAllowTvmConstantinople,
      this.getAllowTvmSolidity059,
      this.getAllowTvmIstanbul,
      this.getAllowShieldedTRC20Transaction,
      this.getForbidTransferToContract,
      this.getAdaptiveResourceLimitTargetRatio,
      this.getAdaptiveResourceLimitMultiplier,
      this.getChangeDelegation,
      this.getWitness127PayPerBlock,
      this.getAllowMarketTransaction,
      this.getMarketSellFee,
      this.getMarketCancelFee,
      this.getAllowPBFT,
      this.getAllowTransactionFeePool,
      this.getMaxFeeLimit,
      this.getAllowOptimizeBlackHole,
      this.getAllowNewResourceModel,
      this.getAllowTvmFreeze,
      this.getAllowTvmVote,
      this.getAllowTvmLondon,
      this.getAllowTvmCompatibleEvm,
      this.getAllowAccountAssetOptimization,
      this.getFreeNetLimit,
      this.getTotalNetLimit,
      this.getAllowHigherLimitForMaxCpuTimeOfOneTx,
      this.getAllowAssetOptimization,
      this.getAllowNewReward,
      this.getMemoFee,
      this.getAllowDelegateOptimization,
      this.getUnfreezeDelayDays,
      this.getAllowOptimizedReturnValueOfChainId,
      this.getAllowDynamicEnergy,
      this.getDynamicEnergyThreshold,
      this.getDynamicEnergyIncreaseFactor,
      this.getDynamicEnergyMaxFactor,
      this.getAllowTvmShangHai,
      this.getAllowCancelAllUnfreezeV2,
      this.getMaxDelegateLockPeriod});
  factory TronChainParameters.fromJson(Map<String, dynamic> json) {
    return TronChainParameters(
      getMaintenanceTimeInterval:
          BigintUtils.tryParse(json["getMaintenanceTimeInterval"]),
      getAccountUpgradeCost:
          BigintUtils.tryParse(json["getAccountUpgradeCost"]),
      getCreateAccountFee: IntUtils.tryParse(json["getCreateAccountFee"]),
      getTransactionFee: IntUtils.tryParse(json["getTransactionFee"]),
      getAssetIssueFee: BigintUtils.tryParse(json["getAssetIssueFee"]),
      getWitnessPayPerBlock:
          BigintUtils.tryParse(json["getWitnessPayPerBlock"]),
      getWitnessStandbyAllowance:
          BigintUtils.tryParse(json["getWitnessStandbyAllowance"]),
      getCreateNewAccountFeeInSystemContract:
          IntUtils.tryParse(json["getCreateNewAccountFeeInSystemContract"]),
      getCreateNewAccountBandwidthRate:
          IntUtils.tryParse(json["getCreateNewAccountBandwidthRate"]),
      getAllowCreationOfContracts:
          IntUtils.tryParse(json["getAllowCreationOfContracts"]),
      getRemoveThePowerOfTheGr:
          IntUtils.tryParse(json["getRemoveThePowerOfTheGr"]),
      getEnergyFee: IntUtils.tryParse(json["getEnergyFee"]),
      getExchangeCreateFee: BigintUtils.tryParse(json["getExchangeCreateFee"]),
      getMaxCpuTimeOfOneTx: IntUtils.tryParse(json["getMaxCpuTimeOfOneTx"]),
      getAllowUpdateAccountName:
          IntUtils.tryParse(json["getAllowUpdateAccountName"]),
      getAllowSameTokenName: IntUtils.tryParse(json["getAllowSameTokenName"]),
      getAllowDelegateResource:
          IntUtils.tryParse(json["getAllowDelegateResource"]),
      getTotalEnergyLimit: BigintUtils.tryParse(json["getTotalEnergyLimit"]),
      getAllowTvmTransferTrc10:
          IntUtils.tryParse(json["getAllowTvmTransferTrc10"]),
      getTotalEnergyCurrentLimit:
          BigintUtils.tryParse(json["getTotalEnergyCurrentLimit"]),
      getAllowMultiSign: IntUtils.tryParse(json["getAllowMultiSign"]),
      getAllowAdaptiveEnergy: IntUtils.tryParse(json["getAllowAdaptiveEnergy"]),
      getTotalEnergyTargetLimit:
          BigintUtils.tryParse(json["getTotalEnergyTargetLimit"]),
      getTotalEnergyAverageUsage:
          BigintUtils.tryParse(json["getTotalEnergyAverageUsage"]),
      getUpdateAccountPermissionFee:
          BigintUtils.tryParse(json["getUpdateAccountPermissionFee"]),
      getMultiSignFee: IntUtils.tryParse(json["getMultiSignFee"]),
      getAllowAccountStateRoot:
          IntUtils.tryParse(json["getAllowAccountStateRoot"]),
      getAllowProtoFilterNum: IntUtils.tryParse(json["getAllowProtoFilterNum"]),
      getAllowTvmConstantinople:
          IntUtils.tryParse(json["getAllowTvmConstantinople"]),
      getAllowTvmSolidity059: IntUtils.tryParse(json["getAllowTvmSolidity059"]),
      getAllowTvmIstanbul: BigintUtils.tryParse(json["getAllowTvmIstanbul"]),
      getAllowShieldedTRC20Transaction:
          IntUtils.tryParse(json["getAllowShieldedTRC20Transaction"]),
      getForbidTransferToContract:
          BigintUtils.tryParse(json["getForbidTransferToContract"]),
      getAdaptiveResourceLimitTargetRatio:
          IntUtils.tryParse(json["getAdaptiveResourceLimitTargetRatio"]),
      getAdaptiveResourceLimitMultiplier:
          IntUtils.tryParse(json["getAdaptiveResourceLimitMultiplier"]),
      getChangeDelegation: IntUtils.tryParse(json["getChangeDelegation"]),
      getWitness127PayPerBlock:
          BigintUtils.tryParse(json["getWitness127PayPerBlock"]),
      getAllowMarketTransaction:
          IntUtils.tryParse(json["getAllowMarketTransaction"]),
      getMarketSellFee: BigintUtils.tryParse(json["getMarketSellFee"]),
      getMarketCancelFee: BigintUtils.tryParse(json["getMarketCancelFee"]),
      getAllowPBFT: IntUtils.tryParse(json["getAllowPBFT"]),
      getAllowTransactionFeePool:
          IntUtils.tryParse(json["getAllowTransactionFeePool"]),
      getMaxFeeLimit: BigintUtils.tryParse(json["getMaxFeeLimit"]),
      getAllowOptimizeBlackHole:
          IntUtils.tryParse(json["getAllowOptimizeBlackHole"]),
      getAllowNewResourceModel:
          IntUtils.tryParse(json["getAllowNewResourceModel"]),
      getAllowTvmFreeze: IntUtils.tryParse(json["getAllowTvmFreeze"]),
      getAllowTvmVote: IntUtils.tryParse(json["getAllowTvmVote"]),
      getAllowTvmLondon: IntUtils.tryParse(json["getAllowTvmLondon"]),
      getAllowTvmCompatibleEvm:
          IntUtils.tryParse(json["getAllowTvmCompatibleEvm"]),
      getAllowAccountAssetOptimization:
          IntUtils.tryParse(json["getAllowAccountAssetOptimization"]),
      getFreeNetLimit: BigintUtils.tryParse(json["getFreeNetLimit"]),
      getTotalNetLimit: BigintUtils.tryParse(json["getTotalNetLimit"]),
      getAllowHigherLimitForMaxCpuTimeOfOneTx:
          IntUtils.tryParse(json["getAllowHigherLimitForMaxCpuTimeOfOneTx"]),
      getAllowAssetOptimization:
          IntUtils.tryParse(json["getAllowAssetOptimization"]),
      getAllowNewReward: IntUtils.tryParse(json["getAllowNewReward"]),
      getMemoFee: IntUtils.tryParse(json["getMemoFee"]),
      getAllowDelegateOptimization:
          IntUtils.tryParse(json["getAllowDelegateOptimization"]),
      getUnfreezeDelayDays: IntUtils.tryParse(json["getUnfreezeDelayDays"]),
      getAllowOptimizedReturnValueOfChainId:
          IntUtils.tryParse(json["getAllowOptimizedReturnValueOfChainId"]),
      getAllowDynamicEnergy: IntUtils.tryParse(json["getAllowDynamicEnergy"]),
      getDynamicEnergyThreshold:
          BigintUtils.tryParse(json["getDynamicEnergyThreshold"]),
      getDynamicEnergyIncreaseFactor:
          IntUtils.tryParse(json["getDynamicEnergyIncreaseFactor"]),
      getDynamicEnergyMaxFactor:
          IntUtils.tryParse(json["getDynamicEnergyMaxFactor"]),
      getAllowTvmShangHai: IntUtils.tryParse(json["getAllowTvmShangHai"]),
      getAllowCancelAllUnfreezeV2:
          IntUtils.tryParse(json["getAllowCancelAllUnfreezeV2"]),
      getMaxDelegateLockPeriod:
          IntUtils.tryParse(json["getMaxDelegateLockPeriod"]),
    );
  }
  // TronChainParameters.fromJson(Map<String, dynamic> json) {}

  final BigInt? getMaintenanceTimeInterval;
  final BigInt? getAccountUpgradeCost;
  final int? getCreateAccountFee;
  final int? getTransactionFee;
  final BigInt? getAssetIssueFee;
  final BigInt? getWitnessPayPerBlock;
  final BigInt? getWitnessStandbyAllowance;
  final int? getCreateNewAccountFeeInSystemContract;
  final int? getCreateNewAccountBandwidthRate;
  final int? getAllowCreationOfContracts;
  final int? getRemoveThePowerOfTheGr;
  final int? getEnergyFee;
  final BigInt? getExchangeCreateFee;
  final int? getMaxCpuTimeOfOneTx;
  final int? getAllowUpdateAccountName;
  final int? getAllowSameTokenName;
  final int? getAllowDelegateResource;
  final BigInt? getTotalEnergyLimit;
  final int? getAllowTvmTransferTrc10;
  final BigInt? getTotalEnergyCurrentLimit;
  final int? getAllowMultiSign;
  final int? getAllowAdaptiveEnergy;
  final BigInt? getTotalEnergyTargetLimit;
  final BigInt? getTotalEnergyAverageUsage;
  final BigInt? getUpdateAccountPermissionFee;
  final int? getMultiSignFee;
  final int? getAllowAccountStateRoot;
  final int? getAllowProtoFilterNum;
  final int? getAllowTvmConstantinople;
  final int? getAllowTvmSolidity059;
  final BigInt? getAllowTvmIstanbul;
  final int? getAllowShieldedTRC20Transaction;
  final BigInt? getForbidTransferToContract;
  final int? getAdaptiveResourceLimitTargetRatio;
  final int? getAdaptiveResourceLimitMultiplier;
  final int? getChangeDelegation;
  final BigInt? getWitness127PayPerBlock;
  final int? getAllowMarketTransaction;
  final BigInt? getMarketSellFee;
  final BigInt? getMarketCancelFee;
  final int? getAllowPBFT;
  final int? getAllowTransactionFeePool;
  final BigInt? getMaxFeeLimit;
  final int? getAllowOptimizeBlackHole;
  final int? getAllowNewResourceModel;
  final int? getAllowTvmFreeze;
  final int? getAllowTvmVote;
  final int? getAllowTvmLondon;
  final int? getAllowTvmCompatibleEvm;
  final int? getAllowAccountAssetOptimization;
  final BigInt? getFreeNetLimit;
  final BigInt? getTotalNetLimit;
  final int? getAllowHigherLimitForMaxCpuTimeOfOneTx;
  final int? getAllowAssetOptimization;
  final int? getAllowNewReward;
  final int? getMemoFee;
  final int? getAllowDelegateOptimization;
  final int? getUnfreezeDelayDays;
  final int? getAllowOptimizedReturnValueOfChainId;
  final int? getAllowDynamicEnergy;
  final BigInt? getDynamicEnergyThreshold;
  final int? getDynamicEnergyIncreaseFactor;
  final int? getDynamicEnergyMaxFactor;
  final int? getAllowTvmShangHai;
  final int? getAllowCancelAllUnfreezeV2;
  final int? getMaxDelegateLockPeriod;

  @override
  String toString() {
    return '''
      TronChainParameters {
        getMaintenanceTimeInterval: $getMaintenanceTimeInterval,
        getAccountUpgradeCost: $getAccountUpgradeCost,
        getCreateAccountFee: $getCreateAccountFee,
        getTransactionFee: $getTransactionFee,
        getAssetIssueFee: $getAssetIssueFee,
        getWitnessPayPerBlock: $getWitnessPayPerBlock,
        getWitnessStandbyAllowance: $getWitnessStandbyAllowance,
        getCreateNewAccountFeeInSystemContract: $getCreateNewAccountFeeInSystemContract,
        getCreateNewAccountBandwidthRate: $getCreateNewAccountBandwidthRate,
        getAllowCreationOfContracts: $getAllowCreationOfContracts,
        getRemoveThePowerOfTheGr: $getRemoveThePowerOfTheGr,
        getEnergyFee: $getEnergyFee,
        getExchangeCreateFee: $getExchangeCreateFee,
        getMaxCpuTimeOfOneTx: $getMaxCpuTimeOfOneTx,
        getAllowUpdateAccountName: $getAllowUpdateAccountName,
        getAllowSameTokenName: $getAllowSameTokenName,
        getAllowDelegateResource: $getAllowDelegateResource,
        getTotalEnergyLimit: $getTotalEnergyLimit,
        getAllowTvmTransferTrc10: $getAllowTvmTransferTrc10,
        getTotalEnergyCurrentLimit: $getTotalEnergyCurrentLimit,
        getAllowMultiSign: $getAllowMultiSign,
        getAllowAdaptiveEnergy: $getAllowAdaptiveEnergy,
        getTotalEnergyTargetLimit: $getTotalEnergyTargetLimit,
        getTotalEnergyAverageUsage: $getTotalEnergyAverageUsage,
        getUpdateAccountPermissionFee: $getUpdateAccountPermissionFee,
        getMultiSignFee: $getMultiSignFee,
        getAllowAccountStateRoot: $getAllowAccountStateRoot,
        getAllowProtoFilterNum: $getAllowProtoFilterNum,
        getAllowTvmConstantinople: $getAllowTvmConstantinople,
        getAllowTvmSolidity059: $getAllowTvmSolidity059,
        getAllowTvmIstanbul: $getAllowTvmIstanbul,
        getAllowShieldedTRC20Transaction: $getAllowShieldedTRC20Transaction,
        getForbidTransferToContract: $getForbidTransferToContract,
        getAdaptiveResourceLimitTargetRatio: $getAdaptiveResourceLimitTargetRatio,
        getAdaptiveResourceLimitMultiplier: $getAdaptiveResourceLimitMultiplier,
        getChangeDelegation: $getChangeDelegation,
        getWitness127PayPerBlock: $getWitness127PayPerBlock,
        getAllowMarketTransaction: $getAllowMarketTransaction,
        getMarketSellFee: $getMarketSellFee,
        getMarketCancelFee: $getMarketCancelFee,
        getAllowPBFT: $getAllowPBFT,
        getAllowTransactionFeePool: $getAllowTransactionFeePool,
        getMaxFeeLimit: $getMaxFeeLimit,
        getAllowOptimizeBlackHole: $getAllowOptimizeBlackHole,
        getAllowNewResourceModel: $getAllowNewResourceModel,
        getAllowTvmFreeze: $getAllowTvmFreeze,
        getAllowTvmVote: $getAllowTvmVote,
        getAllowTvmLondon: $getAllowTvmLondon,
        getAllowTvmCompatibleEvm: $getAllowTvmCompatibleEvm,
        getAllowAccountAssetOptimization: $getAllowAccountAssetOptimization,
        getFreeNetLimit: $getFreeNetLimit
        getTotalNetLimit: $getTotalNetLimit
        getAllowHigherLimitForMaxCpuTimeOfOneTx: $getAllowHigherLimitForMaxCpuTimeOfOneTx
        getAllowAssetOptimization: $getAllowAssetOptimization
        getMemoFee: $getMemoFee
        getAllowDelegateOptimization: $getAllowDelegateOptimization
        getUnfreezeDelayDays: $getUnfreezeDelayDays
        getAllowOptimizedReturnValueOfChainId: $getAllowOptimizedReturnValueOfChainId
        getAllowDynamicEnergy: $getAllowDynamicEnergy
        getDynamicEnergyIncreaseFactor: $getDynamicEnergyIncreaseFactor
        getDynamicEnergyThreshold: $getDynamicEnergyThreshold
        getDynamicEnergyMaxFactor: $getDynamicEnergyMaxFactor
        getAllowTvmShangHai: $getAllowTvmShangHai
        getAllowCancelAllUnfreezeV2: $getAllowCancelAllUnfreezeV2
        getMaxDelegateLockPeriod: $getMaxDelegateLockPeriod

''';
  }
}
