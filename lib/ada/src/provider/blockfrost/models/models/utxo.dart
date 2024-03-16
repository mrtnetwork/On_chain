import 'amount.dart';

class ADAAccountUTXOResponse {
  /// Bech32 encoded address - useful when querying by payment_cred
  final String address;

  /// Transaction hash of the UTXO
  final String txHash;

  final List<ADAAmountResponse> amount;

  /// UTXO index in the transaction
  /// deprecated
  final int? txIndex;

  /// UTXO index in the transaction
  final int outputIndex;

  /// Block hash of the UTXO
  final String block;

  /// The hash of the transaction output datum
  final String? dataHash;

  /// CBOR encoded inline datum
  final String? inlineDatum;

  /// The hash of the reference script of the output
  final String? referenceScriptHash;

  ADAAccountUTXOResponse({
    required this.address,
    required this.txHash,
    required this.txIndex,
    required this.outputIndex,
    required this.block,
    required this.dataHash,
    required this.inlineDatum,
    required this.referenceScriptHash,
    required this.amount,
  });

  factory ADAAccountUTXOResponse.fromJson(Map<String, dynamic> json) {
    return ADAAccountUTXOResponse(
        address: json['address'],
        txHash: json['tx_hash'],
        txIndex: json['tx_index'],
        outputIndex: json['output_index'],
        block: json['block'],
        dataHash: json['data_hash'],
        inlineDatum: json['inline_datum'],
        referenceScriptHash: json['reference_script_hash'],
        amount: (json["amount"] as List)
            .map((e) => ADAAmountResponse.fromJson(e))
            .toList());
  }

  Map<String, dynamic> toJson() => {
        'address': address,
        'tx_hash': txHash,
        'tx_index': txIndex,
        'output_index': outputIndex,
        'block': block,
        'data_hash': dataHash,
        'inline_datum': inlineDatum,
        'reference_script_hash': referenceScriptHash,
        "amount": amount.map((e) => e.toJson()).toList()
      };
  @override
  String toString() {
    return "ADAAccountUTXOResponse${toJson()}";
  }
}
