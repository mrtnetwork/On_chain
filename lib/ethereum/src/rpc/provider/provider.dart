import 'dart:async';
import 'package:on_chain/ethereum/src/rpc/core/core.dart';
import 'package:on_chain/ethereum/src/rpc/core/service.dart';
import 'package:blockchain_utils/blockchain_utils.dart';

/// Represents an interface to interact with Ethereum Virtual Machine (EVM) nodes
/// using JSON-RPC requests.
class EVMRPC {
  /// The JSON-RPC service used for communication with the EVM node.
  final JSONRPCService rpc;

  /// Creates a new instance of the [EVMRPC] class with the specified [rpc].
  EVMRPC(this.rpc);

  /// Finds the result in the JSON-RPC response data or throws an [RPCException]
  /// if an error is encountered.
  dynamic _findResult(Map<String, dynamic> data, ETHRequestDetails request) {
    if (data["error"] != null) {
      final code = int.tryParse(((data["error"]?['code']?.toString()) ?? "0"));
      final message = data["error"]?['message'] ?? "";
      throw RPCError(
        errorCode: code ?? 0,
        message: message,
        data: data["error"]?["data"],
        request: data["request"] ?? StringUtils.toJson(request.toRequestBody()),
      );
    }

    return data["result"];
  }

  /// The unique identifier for each JSON-RPC request.
  int _id = 0;

  /// Sends a JSON-RPC request to the EVM node and returns the result after
  /// processing the response.
  ///
  /// [request]: The JSON-RPC request to be sent.
  /// [timeout]: The maximum duration for waiting for the response.
  Future<T> request<T>(ETHRPCRequest<T> request, [Duration? timeout]) async {
    final id = ++_id;
    final params = request.toRequest(id);
    final data = await rpc.call(params, timeout);
    return request.onResonse(_findResult(data, params));
  }

  Future<dynamic> requestDynamic(String method, dynamic params,
      [Duration? timeout]) async {
    final id = ++_id;
    final requestParams = {
      "jsonrpc": "2.0",
      "method": method,
      "params": params,
      "id": id
    };
    final ETHRequestDetails request = ETHRequestDetails(
        id: id, method: method, params: StringUtils.fromJson(requestParams));
    final data = await rpc.call(request, timeout);
    return _findResult(data, request);
  }
}
