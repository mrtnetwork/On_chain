import 'dart:async';
import 'package:blockchain_utils/blockchain_utils.dart';
import 'package:on_chain/solana/src/rpc/rpc.dart';

/// Represents an interface to interact with Solana nodes
/// using JSON-RPC requests.
class SolanaRPC {
  /// The JSON-RPC service used for communication with the solana node.
  final SolanaJSONRPCService rpc;

  /// Creates a new instance of the [SolanaRPC] class with the specified [rpc].
  SolanaRPC(this.rpc);

  /// Finds the result in the JSON-RPC response data or throws an [RPCError]
  /// if an error is encountered.
  dynamic _findResult(Map<String, dynamic> data, SolanaRequestDetails request) {
    final error = data["error"];
    if (error != null) {
      final code = int.tryParse(error['code']?.toString() ?? "");
      final message = error['message'] ?? "";
      throw RPCError(
          errorCode: code,
          message: message,
          request:
              data["request"] ?? StringUtils.toJson(request.toRequestBody()),
          details: error);
    }
    return data["result"];
  }

  /// The unique identifier for each JSON-RPC request.
  int _id = 0;

  /// Sends a JSON-RPC request to the solana node and returns the result after
  /// processing the response.
  ///
  /// [request]: The JSON-RPC request to be sent.
  /// [timeout]: The maximum duration for waiting for the response.
  /// result without any changes
  Future<dynamic> requestDynamic<T>(SolanaRPCRequest<T> request,
      [Duration? timeout]) async {
    final id = ++_id;
    final params = request.toRequest(id);
    final data = await rpc.call(params, timeout);
    final response = _findResult(data, params);
    return response;
  }

  T _fetchRequest<T>(SolanaRPCRequest<T> request, dynamic response) {
    if (response is Map &&
        response.containsKey("context") &&
        response.containsKey("value")) {
      return request.onResonse(response["value"]);
    }
    return request.onResonse(response);
  }

  Context? _fetchContext(dynamic response) {
    if (response is Map &&
        response.containsKey("context") &&
        response.containsKey("value")) {
      return Context.fromJson(response["context"]);
    }
    return null;
  }

  /// Sends a JSON-RPC request to the solana node and returns the result after
  /// processing the response.
  ///
  /// [request]: The JSON-RPC request to be sent.
  /// [timeout]: The maximum duration for waiting for the response.
  /// changed value to request class template
  Future<T> request<T>(SolanaRPCRequest<T> request, [Duration? timeout]) async {
    final response = await requestDynamic(request, timeout);
    return _fetchRequest<T>(request, response);
  }

  /// Sends a JSON-RPC request to the solana node and returns the result after
  /// processing the response.
  ///
  /// [request]: The JSON-RPC request to be sent.
  /// [timeout]: The maximum duration for waiting for the response.
  /// return value with context if response contains context
  Future<ResultWithContext> requestWithContext<T>(SolanaRPCRequest<T> request,
      [Duration? timeout]) async {
    final response = await requestDynamic(request, timeout);
    final result = _fetchRequest<T>(request, response);
    final context = _fetchContext(response);
    return ResultWithContext(result: result, context: context);
  }
}
