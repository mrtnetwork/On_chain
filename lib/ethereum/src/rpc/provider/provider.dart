import 'dart:async';
import 'package:on_chain/ethereum/src/rpc/core/core.dart';
import 'package:on_chain/ethereum/src/rpc/service/service.dart';
import 'package:blockchain_utils/blockchain_utils.dart';

/// Represents an interface to interact with Ethereum Virtual Machine (ethereum) nodes
/// using JSON-RPC requests.
class EthereumProvider extends BaseProvider<EthereumRequestDetails> {
  /// The JSON-RPC service used for communication with the ethereum node.
  final EthereumServiceProvider rpc;

  /// Creates a new instance of the [EthereumProvider] class with the specified [rpc].
  EthereumProvider(this.rpc);

  /// Finds the result in the JSON-RPC response data or throws an [RPCError]
  /// if an error is encountered.
  static SERVICERESPONSE _findError<SERVICERESPONSE>(
      {required BaseServiceResponse<Map<String, dynamic>> response,
      required EthereumRequestDetails params}) {
    final Map<String, dynamic> r = response.getResult(params);
    final error = r['error'];
    if (error != null) {
      final errorJson = StringUtils.tryToJson<Map<String, dynamic>>(error);
      final errorCode = IntUtils.tryParse(errorJson?['code']);
      final String? message = error['message']?.toString();
      throw RPCError(
          errorCode: errorCode,
          message: message ?? error.toString(),
          request: params.toJson(),
          details: errorJson);
    }
    return ServiceProviderUtils.parseResponse(
        object: r['result'], params: params);
  }

  /// The unique identifier for each JSON-RPC request.
  int _id = 0;

  /// Sends a request to the ethereum network using the specified [request] parameter.
  ///
  /// The [timeout] parameter, if provided, sets the maximum duration for the request.
  @override
  Future<RESULT> request<RESULT, SERVICERESPONSE>(
      BaseServiceRequest<RESULT, SERVICERESPONSE, EthereumRequestDetails>
          request,
      {Duration? timeout}) async {
    final r = await requestDynamic(request, timeout: timeout);
    return request.onResonse(r);
  }

  /// Sends a request to the ethereum network using the specified [request] parameter.
  ///
  /// The [timeout] parameter, if provided, sets the maximum duration for the request.
  /// Whatever is received will be returned
  @override
  Future<SERVICERESPONSE> requestDynamic<RESULT, SERVICERESPONSE>(
      BaseServiceRequest<RESULT, SERVICERESPONSE, EthereumRequestDetails>
          request,
      {Duration? timeout}) async {
    final params = request.buildRequest(_id++);
    final response =
        await rpc.doRequest<Map<String, dynamic>>(params, timeout: timeout);
    return _findError(params: params, response: response);
  }
}
