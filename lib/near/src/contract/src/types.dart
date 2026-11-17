import 'package:blockchain_utils/blockchain_utils.dart';
import 'package:on_chain/near/src/rpc/models/types/types.dart';
import 'package:on_chain/near/src/transaction/src/action.dart';

class NearContractJsonFunction<T extends Object?>
    extends NearContractFunction<Map<String, dynamic>?, T> {
  @override
  final String name;
  const NearContractJsonFunction(this.name);

  @override
  List<int> encode(Map<String, dynamic>? args) {
    if (args == null) return [];
    return StringUtils.encodeJson(args);
  }

  @override
  T decode(List<int> response) {
    if (response.isEmpty && null is T) return null as T;
    return StringUtils.decodeJson<T>(response);
  }
}

abstract class NearContractFunction<
  ENCODE extends Object?,
  DECODE extends Object?
> {
  const NearContractFunction();
  String get name;
  List<int> encode(ENCODE args);
  DECODE decode(List<int> response);
  NearFunctionCall createFunctionCall({
    required ENCODE args,
    required BigInt gas,
    BigInt? deposit,
  }) => NearFunctionCall(
    methodName: name,
    args: encode(args),
    gas: gas,
    deposit: deposit ?? BigInt.zero,
  );
}

class ExecuteContractResult<T extends Object?> {
  final T? result;
  final NearRpcFinalExecutionStatus? status;
  final NearRpcRpcTransactionResponse txResponse;
  const ExecuteContractResult({
    this.result,
    required this.status,
    required this.txResponse,
  });
}

class ContractMetadata {
  final String name;
  final String spec;
  const ContractMetadata({required this.name, required this.spec});
  factory ContractMetadata.fromJson(Map<String, dynamic> json) {
    return ContractMetadata(
      name: json.valueAs("name"),
      spec: json.valueAs("spec"),
    );
  }
}
