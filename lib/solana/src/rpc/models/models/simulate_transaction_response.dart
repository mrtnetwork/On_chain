import 'package:blockchain_utils/utils/utils.dart';
import 'package:on_chain/solana/src/address/sol_address.dart';

import 'account_info.dart';
import 'compiled_inner_instruction.dart';

class SimulateTransactionReturnDataResponse {
  final SolAddress programId;
  final dynamic data;
  const SimulateTransactionReturnDataResponse({
    required this.programId,
    required this.data,
  });
  factory SimulateTransactionReturnDataResponse.fromJson(
    Map<String, dynamic> json,
  ) {
    return SimulateTransactionReturnDataResponse(
      programId: json['programId'],
      data: json['data'],
    );
  }
  Map<String, dynamic> toJson() {
    return {'programId': programId, 'data': data};
  }
}

class SimulateTransactionResponse {
  final dynamic err;
  final List<String>? logs;
  final List<SolanaAccountInfo?>? accounts;
  final BigInt? unitsConsumed;
  final SimulateTransactionReturnDataResponse? returnData;
  final CompiledInnerInstruction? innerInstructions;

  Map<String, dynamic> toJson() {
    return {
      'err': err,
      'logs': logs,
      'accounts': accounts?.map((e) => e?.toJson()).toList(),
      'unitsConsumed': unitsConsumed?.toString(),
      'returnData': returnData?.toJson(),
      'innerInstructions': innerInstructions?.toJson(),
    }..removeWhere((k, v) => v == null);
  }

  const SimulateTransactionResponse({
    this.err,
    this.logs,
    this.accounts,
    this.unitsConsumed,
    this.returnData,
    this.innerInstructions,
  });
  factory SimulateTransactionResponse.fromJson(Map<String, dynamic> json) {
    return SimulateTransactionResponse(
      err: json['err'],
      logs: (json['logs'] as List?)?.map((e) => e.toString()).toList(),
      accounts:
          (json['accounts'] as List?)?.map((e) {
            if (e == null) return null;
            return SolanaAccountInfo.fromJson((e as Map).cast());
          }).toList(),
      unitsConsumed: BigintUtils.tryParse(json['unitsConsumed']),
      returnData:
          json['returnData'] == null
              ? null
              : SimulateTransactionReturnDataResponse.fromJson(
                json['returnData'],
              ),
      innerInstructions:
          json['innerInstructions'] == null
              ? null
              : CompiledInnerInstruction.fromJson(json['innerInstructions']),
    );
  }
}
