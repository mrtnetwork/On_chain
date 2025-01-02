class ADATransactionUTXOSResponse {
  /// Transaction hash
  final String hash;

  /// List of inputs
  final List<ADATransactionInput> inputs;

  /// List of outputs
  final List<ADATransactionOutput> outputs;

  const ADATransactionUTXOSResponse({
    required this.hash,
    required this.inputs,
    required this.outputs,
  });

  factory ADATransactionUTXOSResponse.fromJson(Map<String, dynamic> json) {
    return ADATransactionUTXOSResponse(
        hash: json['hash'],
        inputs: List<ADATransactionInput>.from((json['inputs'] as List)
            .map((inputJson) => ADATransactionInput.fromJson(inputJson))),
        outputs: List<ADATransactionOutput>.from((json['outputs'] as List)
            .map((outputJson) => ADATransactionOutput.fromJson(outputJson))));
  }

  Map<String, dynamic> toJson() {
    return {
      'hash': hash,
      'inputs': inputs.map((input) => input.toJson()).toList(),
      'outputs': outputs.map((output) => output.toJson()).toList(),
    };
  }

  @override
  String toString() {
    return 'ADATransactionUTXOSResponse${toJson()}';
  }
}

class ADATransactionInput {
  /// Input address
  final String address;

  /// Transaction hash of the UTXO
  final String txHash;

  /// UTXO index in the transaction
  final int outputIndex;

  /// The hash of the transaction output datum
  final String? dataHash;

  /// CBOR encoded inline datum
  final String? inlineDatum;

  /// The hash of the reference script of the input
  final String? referenceScriptHash;

  /// Whether the input is a collateral consumed on script validation failure
  final bool collateral;

  /// Whether the input is a reference transaction input
  final bool reference;

  /// inputs amounts
  final List<ADATransactionAmount> amount;

  ADATransactionInput({
    required this.address,
    required this.txHash,
    required this.outputIndex,
    required this.amount,
    this.dataHash,
    this.inlineDatum,
    this.referenceScriptHash,
    required this.collateral,
    required this.reference,
  });

  factory ADATransactionInput.fromJson(Map<String, dynamic> json) {
    return ADATransactionInput(
      address: json['address'],
      txHash: json['tx_hash'],
      outputIndex: json['output_index'],
      dataHash: json['data_hash'],
      inlineDatum: json['inline_datum'],
      referenceScriptHash: json['reference_script_hash'],
      collateral: json['collateral'],
      reference: json['reference'],
      amount: (json['amount'] as List?)
              ?.map((e) => ADATransactionAmount.fromJson(e))
              .toList() ??
          [],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'address': address,
      'tx_hash': txHash,
      'output_index': outputIndex,
      'data_hash': dataHash,
      'inline_datum': inlineDatum,
      'reference_script_hash': referenceScriptHash,
      'collateral': collateral,
      'reference': reference,
      'amount': amount.map((e) => e.toJson()).toList()
    };
  }

  @override
  String toString() {
    return 'ADATransactionInput${toJson()}';
  }
}

class ADATransactionOutput {
  /// Output address
  final String address;

  /// UTXO index in the transaction
  final int outputIndex;

  /// The hash of the transaction output datum
  final String? dataHash;

  /// CBOR encoded inline datum
  final String? inlineDatum;

  /// Whether the output is a collateral output
  final bool collateral;

  /// The hash of the reference script of the output
  final String? referenceScriptHash;

  /// output amounts
  final List<ADATransactionAmount> amount;

  ADATransactionOutput({
    required this.address,
    required this.outputIndex,
    required this.amount,
    this.dataHash,
    this.inlineDatum,
    required this.collateral,
    this.referenceScriptHash,
  });

  factory ADATransactionOutput.fromJson(Map<String, dynamic> json) {
    return ADATransactionOutput(
      address: json['address'],
      outputIndex: json['output_index'],
      dataHash: json['data_hash'],
      inlineDatum: json['inline_datum'],
      collateral: json['collateral'],
      referenceScriptHash: json['reference_script_hash'],
      amount: (json['amount'] as List?)
              ?.map((e) => ADATransactionAmount.fromJson(e))
              .toList() ??
          [],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'address': address,
      'output_index': outputIndex,
      'data_hash': dataHash,
      'inline_datum': inlineDatum,
      'collateral': collateral,
      'reference_script_hash': referenceScriptHash,
      'amount': amount.map((e) => e.toJson()).toList()
    };
  }

  @override
  String toString() {
    return 'ADATransactionOutput${toJson()}';
  }
}

class ADATransactionAmount {
  final String unit;
  final String quantity;
  const ADATransactionAmount({required this.unit, required this.quantity});
  factory ADATransactionAmount.fromJson(Map<String, dynamic> json) {
    return ADATransactionAmount(unit: json['unit'], quantity: json['quantity']);
  }
  Map<String, dynamic> toJson() {
    return {'unit': unit, 'quantity': quantity};
  }
}
