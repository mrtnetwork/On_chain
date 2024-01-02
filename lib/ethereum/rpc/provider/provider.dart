import 'dart:async';
import 'package:on_chain/ethereum/rpc/core/core.dart';
import 'package:on_chain/ethereum/rpc/core/service.dart';
import 'package:on_chain/ethereum/rpc/exception/exception.dart';
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
      final code = int.parse(((data["error"]?['code']?.toString()) ?? "0"));
      final message = data["error"]?['message'] ?? "";
      throw RPCException(
        code: code,
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
}
