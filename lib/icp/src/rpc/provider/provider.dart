import 'dart:async';
import 'package:blockchain_utils/blockchain_utils.dart';
import 'package:on_chain/icp/src/rpc/core/core.dart';

class ICPProvider<SERVICE extends IServiceProvider>
    extends IProvider<SERVICE, ICPRequestDetails> {
  @override
  final SERVICE service;

  ICPProvider(this.service);

  Object? _findError({
    required BaseServiceResponse response,
    required ICPRequestDetails params,
  }) {
    return params.toEncodingResponse<List<int>>(response);
  }

  /// The unique identifier for each request.
  int _id = 0;

  /// Sends a request to the ICP node and returns the result after
  /// processing the response.
  ///
  /// [request]: The request to be sent.
  /// [timeout]: The maximum duration for waiting for the response.
  /// changed value to request class template
  @override
  Future<RESULT> request<RESULT, SERVICERESPONSE>(
    IServiceRequest<RESULT, SERVICERESPONSE, ICPRequestDetails> request, {
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

  /// Sends a request to the ICP node and returns the result after
  /// processing the response.
  ///
  /// [request]: The request to be sent.
  /// [timeout]: The maximum duration for waiting for the response.
  Future<SERVICERESPONSE> _requestDynamic<RESULT, SERVICERESPONSE>(
    IServiceRequest<RESULT, SERVICERESPONSE, ICPRequestDetails> request,
    ICPRequestDetails params, {
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
    IServiceRequest<RESULT, SERVICERESPONSE, ICPRequestDetails> request, {
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
