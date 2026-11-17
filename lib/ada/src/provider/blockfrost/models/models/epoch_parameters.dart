import 'package:blockchain_utils/utils/utils.dart';

class ADAEpochParametersResponse {
  /// Epoch number
  final int epoch;

  /// The linear factor for the minimum fee calculation for given epoch
  final int minFeeA;

  /// The constant factor for the minimum fee calculation
  final int minFeeB;

  /// Maximum block body size in Bytes
  final int maxBlockSize;

  /// Maximum transaction size
  final int maxTxSize;

  /// Maximum block header size
  final int maxBlockHeaderSize;

  /// The amount of a key registration deposit in Lovelaces
  final BigInt keyDeposit;

  /// The amount of a pool registration deposit in Lovelaces
  final BigInt poolDeposit;

  /// Epoch bound on pool retirement
  final int eMax;

  /// Desired number of pools
  final int nOpt;

  /// Pool pledge influence
  final double a0;

  /// Monetary expansion
  final double rho;

  /// Treasury expansion
  final double tau;

  /// Percentage of blocks produced by federated nodes
  final int decentralisationParam;

  /// Seed for extra entropy
  final String? extraEntropy;

  /// Accepted protocol major version
  final int protocolMajorVer;

  /// Accepted protocol minor version
  final int protocolMinorVer;

  /// Minimum UTXO value
  final BigInt minUtxo;

  /// Minimum stake cost forced on the pool
  final String minPoolCost;

  /// Epoch number only used once
  final String nonce;

  /// Cost models
  final Map<String, dynamic> costModels;

  final int coinsPerUtxoSize;

  /// Raw cost models (list form)
  final Map<String, dynamic>? costModelsRaw;

  /// Plutus script price per memory unit
  final double? priceMem;

  /// Plutus script price per step
  final double? priceStep;

  /// Max execution memory per transaction
  final BigInt? maxTxExMem;

  /// Max execution steps per transaction
  final BigInt? maxTxExSteps;

  /// Max execution memory per block
  final BigInt? maxBlockExMem;

  /// Max execution steps per block
  final BigInt? maxBlockExSteps;

  /// Maximum value size
  final BigInt? maxValSize;

  /// Collateral percentage
  final int? collateralPercent;

  /// Maximum collateral inputs
  final int? maxCollateralInputs;

  /// Coins per UTXO word (sibling of coins_per_utxo_size)
  final BigInt? coinsPerUtxoWord;

  /// Governance thresholds (Conway); null when not set
  final double? pvtMotionNoConfidence;
  final double? pvtCommitteeNormal;
  final double? pvtCommitteeNoConfidence;
  final double? pvtHardForkInitiation;
  final double? dvtMotionNoConfidence;
  final double? dvtCommitteeNormal;
  final double? dvtCommitteeNoConfidence;
  final double? dvtUpdateToConstitution;
  final double? dvtHardForkInitiation;
  final double? dvtPPNetworkGroup;
  final double? dvtPPEconomicGroup;
  final double? dvtPPTechnicalGroup;
  final double? dvtPPGovGroup;
  final double? dvtTreasuryWithdrawal;
  final double? pvtppSecurityGroup;
  final double? pvtPPSecurityGroup;

  /// Committee / governance parameters (Conway); u64 as strings
  final BigInt? committeeMinSize;
  final BigInt? committeeMaxTermLength;
  final BigInt? govActionLifetime;
  final BigInt? govActionDeposit;
  final BigInt? drepDeposit;
  final BigInt? drepActivity;

  /// Minimum fee per byte for reference scripts
  final double? minFeeRefScriptCostPerByte;

  ADAEpochParametersResponse({
    required this.epoch,
    required this.minFeeA,
    required this.minFeeB,
    required this.maxBlockSize,
    required this.maxTxSize,
    required this.maxBlockHeaderSize,
    required this.keyDeposit,
    required this.poolDeposit,
    required this.eMax,
    required this.nOpt,
    required this.a0,
    required this.rho,
    required this.tau,
    required this.decentralisationParam,
    required this.protocolMajorVer,
    required this.protocolMinorVer,
    required this.minUtxo,
    required this.minPoolCost,
    required this.nonce,
    required this.coinsPerUtxoSize,
    this.extraEntropy,
    required this.costModels,
    this.costModelsRaw,
    this.priceMem,
    this.priceStep,
    this.maxTxExMem,
    this.maxTxExSteps,
    this.maxBlockExMem,
    this.maxBlockExSteps,
    this.maxValSize,
    this.collateralPercent,
    this.maxCollateralInputs,
    this.coinsPerUtxoWord,
    this.pvtMotionNoConfidence,
    this.pvtCommitteeNormal,
    this.pvtCommitteeNoConfidence,
    this.pvtHardForkInitiation,
    this.dvtMotionNoConfidence,
    this.dvtCommitteeNormal,
    this.dvtCommitteeNoConfidence,
    this.dvtUpdateToConstitution,
    this.dvtHardForkInitiation,
    this.dvtPPNetworkGroup,
    this.dvtPPEconomicGroup,
    this.dvtPPTechnicalGroup,
    this.dvtPPGovGroup,
    this.dvtTreasuryWithdrawal,
    this.pvtppSecurityGroup,
    this.pvtPPSecurityGroup,
    this.committeeMinSize,
    this.committeeMaxTermLength,
    this.govActionLifetime,
    this.govActionDeposit,
    this.drepDeposit,
    this.drepActivity,
    this.minFeeRefScriptCostPerByte,
  });

  static double? _asDouble(dynamic v) =>
      v == null ? null : (v as num).toDouble();
  static BigInt? _asBigInt(dynamic v) =>
      v == null ? null : BigintUtils.parse(v);

  factory ADAEpochParametersResponse.fromJson(Map<String, dynamic> json) {
    return ADAEpochParametersResponse(
      epoch: json['epoch'],
      minFeeA: json['min_fee_a'],
      minFeeB: json['min_fee_b'],
      maxBlockSize: json['max_block_size'],
      maxTxSize: json['max_tx_size'],
      maxBlockHeaderSize: json['max_block_header_size'],
      keyDeposit: BigintUtils.parse(json['key_deposit']),
      poolDeposit: BigintUtils.parse(json['pool_deposit']),
      eMax: json['e_max'],
      nOpt: json['n_opt'],
      a0: json['a0'],
      rho: json['rho'],
      tau: json['tau'],
      decentralisationParam: json['decentralisation_param'],
      extraEntropy: json['extra_entropy'],
      protocolMajorVer: json['protocol_major_ver'],
      protocolMinorVer: json['protocol_minor_ver'],
      minUtxo: BigintUtils.parse(json['min_utxo']),
      minPoolCost: json['min_pool_cost'],
      nonce: json['nonce'],
      costModels: Map<String, dynamic>.from(json['cost_models'] ?? {}),
      coinsPerUtxoSize: IntUtils.parse(json['coins_per_utxo_size']),
      costModelsRaw:
          json['cost_models_raw'] == null
              ? null
              : Map<String, dynamic>.from(json['cost_models_raw']),
      priceMem: _asDouble(json['price_mem']),
      priceStep: _asDouble(json['price_step']),
      maxTxExMem: _asBigInt(json['max_tx_ex_mem']),
      maxTxExSteps: _asBigInt(json['max_tx_ex_steps']),
      maxBlockExMem: _asBigInt(json['max_block_ex_mem']),
      maxBlockExSteps: _asBigInt(json['max_block_ex_steps']),
      maxValSize: _asBigInt(json['max_val_size']),
      collateralPercent: json['collateral_percent'],
      maxCollateralInputs: json['max_collateral_inputs'],
      coinsPerUtxoWord: _asBigInt(json['coins_per_utxo_word']),
      pvtMotionNoConfidence: _asDouble(json['pvt_motion_no_confidence']),
      pvtCommitteeNormal: _asDouble(json['pvt_committee_normal']),
      pvtCommitteeNoConfidence: _asDouble(json['pvt_committee_no_confidence']),
      pvtHardForkInitiation: _asDouble(json['pvt_hard_fork_initiation']),
      dvtMotionNoConfidence: _asDouble(json['dvt_motion_no_confidence']),
      dvtCommitteeNormal: _asDouble(json['dvt_committee_normal']),
      dvtCommitteeNoConfidence: _asDouble(json['dvt_committee_no_confidence']),
      dvtUpdateToConstitution: _asDouble(json['dvt_update_to_constitution']),
      dvtHardForkInitiation: _asDouble(json['dvt_hard_fork_initiation']),
      dvtPPNetworkGroup: _asDouble(json['dvt_p_p_network_group']),
      dvtPPEconomicGroup: _asDouble(json['dvt_p_p_economic_group']),
      dvtPPTechnicalGroup: _asDouble(json['dvt_p_p_technical_group']),
      dvtPPGovGroup: _asDouble(json['dvt_p_p_gov_group']),
      dvtTreasuryWithdrawal: _asDouble(json['dvt_treasury_withdrawal']),
      pvtppSecurityGroup: _asDouble(json['pvtpp_security_group']),
      pvtPPSecurityGroup: _asDouble(json['pvt_p_p_security_group']),
      committeeMinSize: _asBigInt(json['committee_min_size']),
      committeeMaxTermLength: _asBigInt(json['committee_max_term_length']),
      govActionLifetime: _asBigInt(json['gov_action_lifetime']),
      govActionDeposit: _asBigInt(json['gov_action_deposit']),
      drepDeposit: _asBigInt(json['drep_deposit']),
      drepActivity: _asBigInt(json['drep_activity']),
      minFeeRefScriptCostPerByte: _asDouble(
        json['min_fee_ref_script_cost_per_byte'],
      ),
    );
  }

  Map<String, dynamic> toJson() => {
    'epoch': epoch,
    'min_fee_a': minFeeA,
    'min_fee_b': minFeeB,
    'max_block_size': maxBlockSize,
    'max_tx_size': maxTxSize,
    'max_block_header_size': maxBlockHeaderSize,
    'key_deposit': keyDeposit.toString(),
    'pool_deposit': poolDeposit.toString(),
    'e_max': eMax,
    'n_opt': nOpt,
    'a0': a0,
    'rho': rho,
    'tau': tau,
    'decentralisation_param': decentralisationParam,
    'extra_entropy': extraEntropy,
    'protocol_major_ver': protocolMajorVer,
    'protocol_minor_ver': protocolMinorVer,
    'min_utxo': minUtxo,
    'min_pool_cost': minPoolCost,
    'nonce': nonce,
    'cost_models': costModels,
    'coins_per_utxo_size': coinsPerUtxoSize,
    'cost_models_raw': costModelsRaw,
    'price_mem': priceMem,
    'price_step': priceStep,
    'max_tx_ex_mem': maxTxExMem?.toString(),
    'max_tx_ex_steps': maxTxExSteps?.toString(),
    'max_block_ex_mem': maxBlockExMem?.toString(),
    'max_block_ex_steps': maxBlockExSteps?.toString(),
    'max_val_size': maxValSize?.toString(),
    'collateral_percent': collateralPercent,
    'max_collateral_inputs': maxCollateralInputs,
    'coins_per_utxo_word': coinsPerUtxoWord?.toString(),
    'pvt_motion_no_confidence': pvtMotionNoConfidence,
    'pvt_committee_normal': pvtCommitteeNormal,
    'pvt_committee_no_confidence': pvtCommitteeNoConfidence,
    'pvt_hard_fork_initiation': pvtHardForkInitiation,
    'dvt_motion_no_confidence': dvtMotionNoConfidence,
    'dvt_committee_normal': dvtCommitteeNormal,
    'dvt_committee_no_confidence': dvtCommitteeNoConfidence,
    'dvt_update_to_constitution': dvtUpdateToConstitution,
    'dvt_hard_fork_initiation': dvtHardForkInitiation,
    'dvt_p_p_network_group': dvtPPNetworkGroup,
    'dvt_p_p_economic_group': dvtPPEconomicGroup,
    'dvt_p_p_technical_group': dvtPPTechnicalGroup,
    'dvt_p_p_gov_group': dvtPPGovGroup,
    'dvt_treasury_withdrawal': dvtTreasuryWithdrawal,
    'pvtpp_security_group': pvtppSecurityGroup,
    'pvt_p_p_security_group': pvtPPSecurityGroup,
    'committee_min_size': committeeMinSize?.toString(),
    'committee_max_term_length': committeeMaxTermLength?.toString(),
    'gov_action_lifetime': govActionLifetime?.toString(),
    'gov_action_deposit': govActionDeposit?.toString(),
    'drep_deposit': drepDeposit?.toString(),
    'drep_activity': drepActivity?.toString(),
    'min_fee_ref_script_cost_per_byte': minFeeRefScriptCostPerByte,
  };

  @override
  String toString() {
    return 'ADAEpochParametersResponse${toJson()}';
  }

  /// Fees are constructed around two constants (a and b).
  /// The formula for calculating minimal fees for a transaction (tx) is a * size(tx) + b, where:
  /// a/b are protocol parameters
  /// size(tx) is the transaction size in bytes
  /// https://docs.cardano.org/explore-cardano/fee-structure/#:~:text=Fees%20are%20constructed%20around%20two,the%20transaction%20size%20in%20bytes
  BigInt calculateFee(int size) {
    return BigInt.from((minFeeA * size) + minFeeB);
  }
}
