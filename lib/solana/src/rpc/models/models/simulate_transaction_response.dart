import 'package:blockchain_utils/utils/numbers/utils/bigint_utils.dart';
import 'package:on_chain/solana/src/address/sol_address.dart';

import 'account_info.dart';
import 'compiled_inner_instruction.dart';

class SimulateTranasctionReturnDataResponse {
  final SolAddress programId;
  final dynamic data;
  const SimulateTranasctionReturnDataResponse(
      {required this.programId, required this.data});
  factory SimulateTranasctionReturnDataResponse.fromJson(
      Map<String, dynamic> json) {
    return SimulateTranasctionReturnDataResponse(
        programId: json["programId"], data: json["data"]);
  }
  Map<String, dynamic> toJson() {
    return {"programId": programId, "data": data};
  }
}

class SimulateTranasctionResponse {
  final String? err;
  final List<String>? logs;
  final List<SolanaAccountInfo>? accounts;
  final BigInt? unitsConsumed;
  final SimulateTranasctionReturnDataResponse? returnData;
  final CompiledInnerInstruction? innerInstructions;

  Map<String, dynamic> toJson() {
    return {
      "err": err,
      "logs": logs,
      "accounts": accounts?.map((e) => e.toJson()).toList(),
      "unitsConsumed": unitsConsumed?.toString(),
      "returnData": returnData?.toJson(),
      "innerInstructions": innerInstructions?.toJson()
    }..removeWhere((k, v) => v == null);
  }

  const SimulateTranasctionResponse(
      {this.err,
      this.logs,
      this.accounts,
      this.unitsConsumed,
      this.returnData,
      this.innerInstructions});
  factory SimulateTranasctionResponse.fromJson(Map<String, dynamic> json) {
    return SimulateTranasctionResponse(
        err: json["err"],
        logs: (json["logs"] as List?)?.map((e) => e.toString()).toList(),
        accounts: (json["accounts"] as List?)
            ?.map((e) => SolanaAccountInfo.fromJson((e as Map).cast()))
            .toList(),
        unitsConsumed: BigintUtils.tryParse(json["unitsConsumed"]),
        returnData: json["returnData"] == null
            ? null
            : SimulateTranasctionReturnDataResponse.fromJson(
                json["returnData"]),
        innerInstructions: json["innerInstructions"] == null
            ? null
            : CompiledInnerInstruction.fromJson(json["innerInstructions"]));
  }
}
