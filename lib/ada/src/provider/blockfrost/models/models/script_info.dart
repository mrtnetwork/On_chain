class ADAScriptInfoResponse {
  /// Script hash
  final String scriptHash;

  /// Type of the script language
  /// Possible values: [timelock, plutusV1, plutusV2]
  final String type;

  /// The size of the CBOR serialised script, if a Plutus script
  final int? serialisedSize;

  ADAScriptInfoResponse({
    required this.scriptHash,
    required this.type,
    this.serialisedSize,
  });

  factory ADAScriptInfoResponse.fromJson(Map<String, dynamic> json) {
    return ADAScriptInfoResponse(
      scriptHash: json['script_hash'],
      type: json['type'],
      serialisedSize: json['serialised_size'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'script_hash': scriptHash,
      'type': type,
      'serialised_size': serialisedSize,
    };
  }

  @override
  String toString() {
    return "ADAScriptInfoResponse${toJson()}";
  }
}
