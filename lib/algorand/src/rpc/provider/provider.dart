import 'dart:async';
import 'package:blockchain_utils/blockchain_utils.dart';
import 'package:on_chain/algorand/src/rpc/core/core.dart';

/// Represents an interface to interact with Algorand nodes
/// using REST requests.
class AlgoProvider<SERVICE extends IServiceProvider>
    extends IProvider<SERVICE, AlgoRequestDetails> {
  /// The REST service used for communication with the Algorand node.
  @override
  final SERVICE service;

  /// Creates a new instance of the [AlgoProvider] class with the specified [service].
  AlgoProvider(this.service);

  Object? _findError({
    required BaseServiceResponse response,
    required AlgoRequestDetails params,
  }) {
    final data = params.toEncodingResponse(response);
    if (params.responseEncoding == ServiceReponseEncoding.binary) {
      final List<int> binary = JsonParser.valueAsBytes(data);
      final decode = MsgPackAnyLayout().deserialize(binary).value;
      return ServiceProviderUtils.ecodeResponse(
        body: decode,
        encoding: params.finalResponseEncoding,
      );
    }
    return data;
  }

  /// The unique identifier for each request.
  int _id = 0;

  /// Sends a REST request to the Algorand node and returns the result after
  /// processing the response.
  ///
  /// [request]: The REST request to be sent.
  /// [timeout]: The maximum duration for waiting for the response.
  /// changed value to request class template
  @override
  Future<RESULT> request<RESULT, SERVICERESPONSE>(
    IServiceRequest<RESULT, SERVICERESPONSE, AlgoRequestDetails> request, {
    Duration? timeout,
  }) async {
    final params = await request.buildRequest(_id++);
    final response = await _requestDynamic<RESULT, SERVICERESPONSE>(
      request,
      params,
      timeout: timeout,
    );
    return request.onResponse(response);
  }

  /// Sends a REST request to the Algorand node and returns the result after
  /// processing the response.
  ///
  /// [request]: The REST request to be sent.
  /// [timeout]: The maximum duration for waiting for the response.
  Future<SERVICERESPONSE> _requestDynamic<RESULT, SERVICERESPONSE>(
    IServiceRequest<RESULT, SERVICERESPONSE, AlgoRequestDetails> request,
    AlgoRequestDetails params, {
    Duration? timeout,
  }) async {
    final response = await service.doRequest(params, timeout: timeout);
    final result = _findError(params: params, response: response);
    return ServiceProviderUtils.toResponse<SERVICERESPONSE>(
      object: result,
      params: params,
    );
  }

  @override
  Future<SERVICERESPONSE> requestDynamic<RESULT, SERVICERESPONSE>(
    IServiceRequest<RESULT, SERVICERESPONSE, AlgoRequestDetails> request, {
    Duration? timeout,
  }) async {
    final params = await request.buildRequest(_id++);
    return await _requestDynamic<RESULT, SERVICERESPONSE>(
      request,
      params,
      timeout: timeout,
    );
  }
}
