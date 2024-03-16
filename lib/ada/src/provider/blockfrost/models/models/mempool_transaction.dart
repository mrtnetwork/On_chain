class ADAMempoolTransactionResponse {
  final String hash;
  final List<Map<String, dynamic>> outputAmount;
  final String fees;
  final String deposit;
  final int size;
  final String? invalidBefore;
  final String? invalidHereafter;
  final int utxoCount;
  final int withdrawalCount;
  final int mirCertCount;
  final int delegationCount;
  final int stakeCertCount;
  final int poolUpdateCount;
  final int poolRetireCount;
  final int assetMintOrBurnCount;
  final int redeemerCount;
  final bool validContract;
  final List<ADAInput> inputs;
  final List<ADAOutput> outputs;
  final List<ADARedeemer>? redeemers;

  ADAMempoolTransactionResponse({
    required this.hash,
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
    required this.inputs,
    required this.outputs,
    this.redeemers,
  });

  factory ADAMempoolTransactionResponse.fromJson(Map<String, dynamic> json) {
    return ADAMempoolTransactionResponse(
      hash: json['hash'],
      outputAmount: List<Map<String, dynamic>>.from(json['output_amount']),
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
      inputs:
          List<ADAInput>.from(json['inputs'].map((x) => ADAInput.fromJson(x))),
      outputs: List<ADAOutput>.from(
          json['outputs'].map((x) => ADAOutput.fromJson(x))),
      redeemers: json['redeemers'] != null
          ? List<ADARedeemer>.from(
              json['redeemers'].map((x) => ADARedeemer.fromJson(x)))
          : null,
    );
  }

  Map<String, dynamic> toJson() => {
        'hash': hash,
        'output_amount': outputAmount,
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
        'inputs': inputs,
        'outputs': outputs,
        'redeemers': redeemers,
      };
}

class ADAInput {
  final String address;
  final String txHash;
  final int outputIndex;
  final bool collateral;
  final bool reference;

  ADAInput({
    required this.address,
    required this.txHash,
    required this.outputIndex,
    required this.collateral,
    required this.reference,
  });

  factory ADAInput.fromJson(Map<String, dynamic> json) {
    return ADAInput(
      address: json['address'],
      txHash: json['tx_hash'],
      outputIndex: json['output_index'],
      collateral: json['collateral'],
      reference: json['reference'] ?? false,
    );
  }

  Map<String, dynamic> toJson() => {
        'address': address,
        'tx_hash': txHash,
        'output_index': outputIndex,
        'collateral': collateral,
        'reference': reference,
      };
}

class ADAOutput {
  final String address;
  final List<Map<String, dynamic>> amount;
  final int outputIndex;
  final String? dataHash;
  final String? inlineDatum;
  final bool collateral;
  final String? referenceScriptHash;

  ADAOutput({
    required this.address,
    required this.amount,
    required this.outputIndex,
    this.dataHash,
    this.inlineDatum,
    required this.collateral,
    this.referenceScriptHash,
  });

  factory ADAOutput.fromJson(Map<String, dynamic> json) {
    return ADAOutput(
      address: json['address'],
      amount: List<Map<String, dynamic>>.from(json['amount']),
      outputIndex: json['output_index'],
      dataHash: json['data_hash'],
      inlineDatum: json['inline_datum'],
      collateral: json['collateral'],
      referenceScriptHash: json['reference_script_hash'],
    );
  }

  Map<String, dynamic> toJson() => {
        'address': address,
        'amount': amount,
        'output_index': outputIndex,
        'data_hash': dataHash,
        'inline_datum': inlineDatum,
        'collateral': collateral,
        'reference_script_hash': referenceScriptHash,
      };
}

class ADARedeemer {
  final int txIndex;
  final String purpose;
  final String unitMem;
  final String unitSteps;

  ADARedeemer({
    required this.txIndex,
    required this.purpose,
    required this.unitMem,
    required this.unitSteps,
  });

  factory ADARedeemer.fromJson(Map<String, dynamic> json) {
    return ADARedeemer(
      txIndex: json['tx_index'],
      purpose: json['purpose'],
      unitMem: json['unit_mem'],
      unitSteps: json['unit_steps'],
    );
  }

  Map<String, dynamic> toJson() => {
        'tx_index': txIndex,
        'purpose': purpose,
        'unit_mem': unitMem,
        'unit_steps': unitSteps,
      };
}
