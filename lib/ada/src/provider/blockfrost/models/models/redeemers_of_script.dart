class ADAScriptRedeemerInfoResponse {
  /// Hash of the transaction
  final String txHash;

  /// The index of the redeemer pointer in the transaction
  final int txIndex;

  /// Validation purpose
  /// Possible values: [spend, mint, cert, reward]
  final String purpose;

  /// Datum hash of the redeemer
  final String redeemerDataHash;

  /// Datum hash (deprecated)
  // @Deprecated('Use redeemerDataHash instead')
  final String datumHash;

  /// The budget in Memory to run a script
  final String unitMem;

  /// The budget in CPU steps to run a script
  final String unitSteps;

  /// The fee consumed to run the script
  final String fee;

  ADAScriptRedeemerInfoResponse({
    required this.txHash,
    required this.txIndex,
    required this.purpose,
    required this.redeemerDataHash,
    required this.unitMem,
    required this.unitSteps,
    required this.fee,
    String? datumHash,
  }) : datumHash = datumHash ?? redeemerDataHash;

  factory ADAScriptRedeemerInfoResponse.fromJson(Map<String, dynamic> json) {
    return ADAScriptRedeemerInfoResponse(
      txHash: json['tx_hash'],
      txIndex: json['tx_index'],
      purpose: json['purpose'],
      redeemerDataHash: json['redeemer_data_hash'],
      datumHash: json['datum_hash'],
      unitMem: json['unit_mem'],
      unitSteps: json['unit_steps'],
      fee: json['fee'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'tx_hash': txHash,
      'tx_index': txIndex,
      'purpose': purpose,
      'redeemer_data_hash': redeemerDataHash,
      'datum_hash': datumHash,
      'unit_mem': unitMem,
      'unit_steps': unitSteps,
      'fee': fee,
    };
  }

  @override
  String toString() {
    return "ADAScriptRedeemerInfoResponse${toJson()}";
  }
}
