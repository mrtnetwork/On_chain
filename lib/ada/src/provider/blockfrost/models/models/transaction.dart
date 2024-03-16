import 'amount.dart';

class ADATransactionInfoResponse {
  /// Transaction hash
  final String hash;

  /// Block hash
  final String block;

  /// Block number
  final int blockHeight;

  /// Block creation time in UNIX time
  final int blockTime;

  /// Slot number
  final int slot;

  /// Transaction index within the block
  final int index;

  /// Array of output amounts
  final List<ADAAmountResponse> outputAmount;

  /// Fees of the transaction in Lovelaces
  final String fees;

  /// Deposit within the transaction in Lovelaces
  final String deposit;

  /// Size of the transaction in Bytes
  final int size;

  /// Left (included) endpoint of the timelock validity intervals
  final String? invalidBefore;

  /// Right (excluded) endpoint of the timelock validity intervals
  final String? invalidHereafter;

  /// Count of UTXOs within the transaction
  final int utxoCount;

  /// Count of the withdrawals within the transaction
  final int withdrawalCount;

  /// Count of the MIR certificates within the transaction
  final int mirCertCount;

  /// Count of the delegations within the transaction
  final int delegationCount;

  /// Count of the stake keys (de)registration within the transaction
  final int stakeCertCount;

  /// Count of the stake pool registration and update certificates within the transaction
  final int poolUpdateCount;

  /// Count of the stake pool retirement certificates within the transaction
  final int poolRetireCount;

  /// Count of asset mints and burns within the transaction
  final int assetMintOrBurnCount;

  /// Count of redeemers within the transaction
  final int redeemerCount;

  /// True if contract script passed validation
  final bool validContract;

  ADATransactionInfoResponse({
    required this.hash,
    required this.block,
    required this.blockHeight,
    required this.blockTime,
    required this.slot,
    required this.index,
    required this.outputAmount,
    required this.fees,
    required this.deposit,
    required this.size,
    this.invalidBefore,
    this.invalidHereafter,
    required this.utxoCount,
    required this.withdrawalCount,
    required this.mirCertCount,
    required this.delegationCount,
    required this.stakeCertCount,
    required this.poolUpdateCount,
    required this.poolRetireCount,
    required this.assetMintOrBurnCount,
    required this.redeemerCount,
    required this.validContract,
  });

  factory ADATransactionInfoResponse.fromJson(Map<String, dynamic> json) {
    return ADATransactionInfoResponse(
      hash: json['hash'],
      block: json['block'],
      blockHeight: json['block_height'],
      blockTime: json['block_time'],
      slot: json['slot'],
      index: json['index'],
      outputAmount: (json['output_amount'] as List)
          .map((e) => ADAAmountResponse.fromJson(e))
          .toList(),
      fees: json['fees'],
      deposit: json['deposit'],
      size: json['size'],
      invalidBefore: json['invalid_before'],
      invalidHereafter: json['invalid_hereafter'],
      utxoCount: json['utxo_count'],
      withdrawalCount: json['withdrawal_count'],
      mirCertCount: json['mir_cert_count'],
      delegationCount: json['delegation_count'],
      stakeCertCount: json['stake_cert_count'],
      poolUpdateCount: json['pool_update_count'],
      poolRetireCount: json['pool_retire_count'],
      assetMintOrBurnCount: json['asset_mint_or_burn_count'],
      redeemerCount: json['redeemer_count'],
      validContract: json['valid_contract'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'hash': hash,
      'block': block,
      'block_height': blockHeight,
      'block_time': blockTime,
      'slot': slot,
      'index': index,
      'output_amount': outputAmount.map((e) => e.toJson()),
      'fees': fees,
      'deposit': deposit,
      'size': size,
      'invalid_before': invalidBefore,
      'invalid_hereafter': invalidHereafter,
      'utxo_count': utxoCount,
      'withdrawal_count': withdrawalCount,
      'mir_cert_count': mirCertCount,
      'delegation_count': delegationCount,
      'stake_cert_count': stakeCertCount,
      'pool_update_count': poolUpdateCount,
      'pool_retire_count': poolRetireCount,
      'asset_mint_or_burn_count': assetMintOrBurnCount,
      'redeemer_count': redeemerCount,
      'valid_contract': validContract,
    };
  }

  @override
  String toString() {
    return "ADATransactionInfoResponse${toJson()}";
  }
}
