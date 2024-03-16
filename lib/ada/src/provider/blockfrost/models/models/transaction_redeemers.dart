class ADATransactionRedeemerResponse {
  /// Index of the redeemer within the transaction
  final int txIndex;

  /// Validation purpose
  final String purpose;

  /// Script hash
  final String scriptHash;

  /// Redeemer data hash
  final String redeemerDataHash;

  /// Deprecated: Datum hash
  final String? datumHash;

  /// The budget in Memory to run a script
  final String unitMem;

  /// The budget in CPU steps to run a script
  final String unitSteps;

  /// The fee consumed to run the script
  final String fee;

  ADATransactionRedeemerResponse({
    required this.txIndex,
    required this.purpose,
    required this.scriptHash,
    required this.redeemerDataHash,
    this.datumHash,
    required this.unitMem,
    required this.unitSteps,
    required this.fee,
  });

  factory ADATransactionRedeemerResponse.fromJson(Map<String, dynamic> json) {
    return ADATransactionRedeemerResponse(
      txIndex: json['tx_index'],
      purpose: json['purpose'],
      scriptHash: json['script_hash'],
      redeemerDataHash: json['redeemer_data_hash'],
      datumHash: json['datum_hash'],
      unitMem: json['unit_mem'],
      unitSteps: json['unit_steps'],
      fee: json['fee'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'tx_index': txIndex,
      'purpose': purpose,
      'script_hash': scriptHash,
      'redeemer_data_hash': redeemerDataHash,
      'unit_mem': unitMem,
      'unit_steps': unitSteps,
      'fee': fee,
      "datum_hash": datumHash
    };
  }

  @override
  String toString() {
    return "ADATransactionRedeemerResponse${toJson()}";
  }
}
