import 'package:blockchain_utils/utils/utils.dart';
import 'package:blockchain_utils/blockchain_utils.dart';
import 'package:on_chain/on_chain.dart';

class ParsedContractRequest {
  ParsedContractRequest._(this.respose, this.transactionRaw);
  factory ParsedContractRequest.fromJson(Map<String, dynamic> json) {
    if (json["Error"] != null) {
      return ParsedContractRequest._(json, null);
    }
    return ParsedContractRequest._(
        json, TransactionRaw.fromJson(json["raw_data"]));
  }
  final TransactionRaw? transactionRaw;
  final Map<String, dynamic> respose;

  bool get isSuccess => transactionRaw != null;

  String? get error => (respose["Error"] as String?)?.split(":").last.trim();
  @override
  String toString() {
    return "ParsedTransactionResult{$respose}";
  }
}

class ParsedSmartContractRequest {
  ParsedSmartContractRequest._(
      {required this.respose,
      this.transactionRaw,
      this.energyUsed,
      this.outputResult});
  ParsedSmartContractRequest._error(this.respose)
      : energyUsed = null,
        transactionRaw = null,
        outputResult = null;
  factory ParsedSmartContractRequest.fromJson(
      Map<String, dynamic> json, AbiFunctionFragment? fragment) {
    if (json["Error"] != null) {
      return ParsedSmartContractRequest._error(json);
    }
    final result = Map<String, dynamic>.from(json["result"]);
    if (!result.containsKey("result") || result["result"] != true) {
      return ParsedSmartContractRequest._error(json);
    }
    final List<Map<String, dynamic>> contractRevertErrors =
        List<Map<String, dynamic>>.from(json["transaction"]["ret"]);
    for (final i in contractRevertErrors) {
      if (i.isNotEmpty) {
        return ParsedSmartContractRequest._error(json);
      }
    }
    List<dynamic>? decodeResult;
    if (json.containsKey("constant_result") && fragment != null) {
      final outputs = List.from(json["constant_result"]);
      if (outputs.isEmpty) {
        decodeResult = [];
      } else {
        decodeResult =
            fragment.decodeOutput(BytesUtils.fromHexString(outputs.first));
      }
    }

    return ParsedSmartContractRequest._(
        respose: json,
        transactionRaw:
            TransactionRaw.fromJson(json["transaction"]["raw_data"]),
        energyUsed: json["energy_used"],
        outputResult: decodeResult);
  }
  final TransactionRaw? transactionRaw;
  final int? energyUsed;
  final Map<String, dynamic> respose;

  final List<dynamic>? outputResult;

  bool get isSuccess => transactionRaw != null;

  String? get error => isSuccess
      ? null
      : (respose["result"]["message"] as String?) ??
          "${respose["transaction"]?["ret"]}";
  @override
  String toString() {
    return "ParsedTransactionResult{$respose}";
  }
}

class ParsedBroadcastTransactionResult {
  ParsedBroadcastTransactionResult._(this.respose);
  factory ParsedBroadcastTransactionResult.fromJson(Map<String, dynamic> json) {
    return ParsedBroadcastTransactionResult._(json);
  }

  final Map<String, dynamic> respose;

  bool get isSuccess => respose["result"] == true;

  String? get error {
    if (isSuccess) return null;
    if (respose.containsKey("Error")) {
      return (respose["Error"] as String).split(":").last.trim();
    }
    return respose["message"];
  }

  String? get txId => respose["txid"];

  @override
  String toString() {
    return "ParsedTransactionResult{$respose}";
  }
}
