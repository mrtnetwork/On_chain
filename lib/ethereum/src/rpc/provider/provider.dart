import 'dart:async';

import 'package:blockchain_utils/blockchain_utils.dart';
import 'package:on_chain/ethereum/src/rpc/core/core.dart';

/// Represents an interface to interact with Ethereum Virtual Machine (ethereum) nodes
/// using JSON-RPC requests.
class EthereumProvider<SERVICE extends IServiceProvider>
    extends IProvider<SERVICE, EthereumRequestDetails>
    implements ISubscribtionProvider<SERVICE, EthereumRequestDetails> {
  /// The JSON-RPC service used for communication with the ethereum node.
  @override
  final SERVICE service;

  /// Creates a new instance of the [EthereumProvider] class with the specified [rpc].
  EthereumProvider(this.service);

  /// Finds the result in the JSON-RPC response data or throws an [RPCError]
  /// if an error is encountered.
  static SERVICERESPONSE findError<SERVICERESPONSE>({
    required BaseServiceResponse response,
    required EthereumRequestDetails params,
  }) {
    final Map<String, dynamic> result = params.toEncodingResponse(response);
    final error = result['error'];
    if (error != null) {
      final errorJson = StringUtils.tryToJson<Map<String, dynamic>>(error);
      final errorCode = IntUtils.tryParse(errorJson?['code']);
      final String? message = error['message']?.toString();

      throw RPCError(
        errorCode: errorCode,
        message:
            message ?? (error is String ? error : ServiceConst.defaultError),
        request: params.toJson(),
        relatedNetwork: BlockchainNetwork.ethereum,
        statusCode: response.statusCode,
        jsonRpcErrpr: result,
      );
    }
    return ServiceProviderUtils.toResponse<SERVICERESPONSE>(
      object: result['result'],
      params: params,
    );
  }

  /// The unique identifier for each JSON-RPC request.
  int _id = 0;

  /// Sends a request to the ethereum network using the specified [request] parameter.
  ///
  /// The [timeout] parameter, if provided, sets the maximum duration for the request.
  @override
  Future<RESULT> request<RESULT, SERVICERESPONSE>(
    IServiceRequest<RESULT, SERVICERESPONSE, EthereumRequestDetails> request, {
    Duration? timeout,
  }) async {
    final r = await requestDynamic<RESULT, SERVICERESPONSE>(
      request,
      timeout: timeout,
    );
    return request.onResonse(r);
  }

  /// Sends a request to the ethereum network using the specified [request] parameter.
  ///
  /// The [timeout] parameter, if provided, sets the maximum duration for the request.
  /// Whatever is received will be returned
  @override
  Future<SERVICERESPONSE> requestDynamic<RESULT, SERVICERESPONSE>(
    IServiceRequest<RESULT, SERVICERESPONSE, EthereumRequestDetails> request, {
    Duration? timeout,
  }) async {
    final params = request.buildRequest(_id++);
    final response = await service.doRequest(params, timeout: timeout);
    return findError<SERVICERESPONSE>(params: params, response: response);
  }

  @override
  Future<BaseSubscribtionRequestResponse<IDENTIFIER, EVENT>>
  requestSubscribtion<
    IDENTIFIER,
    EVENT extends BaseSubscribtionEvent<IDENTIFIER>,
    SERVICERESPONSE
  >(
    BaseServiceSubscribtionRequest<
      IDENTIFIER,
      SERVICERESPONSE,
      EVENT,
      EthereumRequestDetails
    >
    request, {
    Duration? timeout,
  }) async {
    final params = request.buildRequest(_id++);
    final response = await service.doSubscribtionRequest(
      params: params,
      request: request,
    );
    final serviceResponse = findError<SERVICERESPONSE>(
      params: params,
      response: response.response,
    );
    final identifier = request.onResonse(serviceResponse);
    return DefaultSubscribtionRequestResponse(
      identifier: identifier,
      stream:
          response.stream.where((e) {
            return switch (e) {
              EVENT event when event.id == identifier => true,
              _ => false,
            };
          }).cast<EVENT>(),
    );
  }
}
