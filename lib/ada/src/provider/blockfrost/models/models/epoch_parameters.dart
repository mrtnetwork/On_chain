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
  final String minUtxo;

  /// Minimum stake cost forced on the pool
  final String minPoolCost;

  /// Epoch number only used once
  final String nonce;

  /// Cost models
  final Map<String, dynamic> costModels;

  final int coinsPerUtxoSize;

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
  });

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
        minUtxo: json['min_utxo'],
        minPoolCost: json['min_pool_cost'],
        nonce: json['nonce'],
        costModels: Map<String, dynamic>.from(json['cost_models'] ?? {}),
        coinsPerUtxoSize: int.parse(json['coins_per_utxo_size'].toString()));
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
        'coins_per_utxo_size': coinsPerUtxoSize
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
