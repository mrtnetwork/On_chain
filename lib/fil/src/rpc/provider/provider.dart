import 'dart:async';
import 'package:blockchain_utils/blockchain_utils.dart';
import 'package:on_chain/fil/src/rpc/core/core.dart';

class LotusProvider<SERVICE extends IServiceProvider>
    implements IProvider<SERVICE, BaseLotusServiceRequestParams> {
  @override
  final SERVICE service;

  /// Constructs a new [LotusProvider] instance with the specified [service] service provider.
  LotusProvider(this.service);

  static SERVICERESPONSE _findError<SERVICERESPONSE>({
    required IServiceRequest request,
    required BaseServiceResponse response,
    required BaseLotusServiceRequestParams params,
  }) {
    final result = params.toEncodingResponse<Map<String, dynamic>>(response);
    if (result.hasValue("error")) {
      final Map<String, dynamic>? err = StringUtils.tryToJson(result["error"]);
      throw RPCError(
        message:
            err?.valueAsString<String?>("message") ??
            ServiceProviderUtils.getDefaultError(response.statusCode),
        errorCode: err?.valueAsInt<int?>("code", onError: (err) => null),
        request: params.toJson(),
        jsonRpcErrpr: err,
        relatedNetwork: BlockchainNetwork.filecoin,
        statusCode: response.statusCode,
      );
    }
    return ServiceProviderUtils.toResponse<SERVICERESPONSE>(
      object: result["result"],
      params: params,
    );
  }

  /// Sends a request to the lotus using the specified [request] parameter.
  ///
  /// The [timeout] parameter, if provided, sets the maximum duration for the request.
  @override
  Future<RESULT> request<RESULT, SERVICERESPONSE>(
    IServiceRequest<RESULT, SERVICERESPONSE, BaseLotusServiceRequestParams>
    request, {
    Duration? timeout,
  }) async {
    final r = await requestDynamic<RESULT, SERVICERESPONSE>(
      request,
      timeout: timeout,
    );
    return request.onResponse(r);
  }

  int _id = 0;

  /// Sends a request to the lotus using the specified [request] parameter.
  ///
  /// The [timeout] parameter, if provided, sets the maximum duration for the request.
  /// Whatever is received will be returned
  @override
  Future<SERVICERESPONSE> requestDynamic<RESULT, SERVICERESPONSE>(
    IServiceRequest<RESULT, SERVICERESPONSE, BaseLotusServiceRequestParams>
    request, {
    Duration? timeout,
  }) async {
    final params = await request.buildRequest(_id++);
    final response = await service.doRequest(params, timeout: timeout);
    return _findError<SERVICERESPONSE>(
      params: params,
      response: response,
      request: request,
    );
  }
}
