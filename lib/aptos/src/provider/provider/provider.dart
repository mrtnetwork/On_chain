import 'dart:async';
import 'package:blockchain_utils/blockchain_utils.dart';
import 'package:on_chain/aptos/src/provider/core/core.dart';

class AptosProvider<SERVICE extends IServiceProvider>
    implements IProvider<SERVICE, AptosRequestDetails> {
  @override
  final SERVICE service;

  AptosProvider(this.service);

  static SERVICERESPONSE _findError<SERVICERESPONSE>({
    required BaseServiceResponse response,
    required AptosRequestDetails params,
    required bool isDynamicRequest,
  }) {
    RPCError err(Map<String, dynamic> error) {
      String? message = error.valueAsString("message");
      List<String>? messages = [];
      if (error.containsKey("errors")) {
        messages =
            error
                .valueEnsureAsList<Map<String, dynamic>>("errors")
                .map((e) => e.valueAsString("message"))
                .whereType<String>()
                .toList()
                .emptyAsNull;
        message = messages?.join(", ");
      }
      return RPCError(
        message:
            message ??
            ServiceProviderUtils.getDefaultError(response.statusCode),
        relatedNetwork: BlockchainNetwork.aptos,
        errorCode: error.valueAs("vm_error_code"),
        statusCode: response.statusCode,
        jsonRpcErrpr: error,
      );
    }

    if (response.type == ServiceResponseType.error) {
      final error = response.cast<BaseServiceErrorResponse>();
      if (!error.validate) throw error.defaultError();
      final errorJson = error.tryToJson();
      if (errorJson == null) throw error.defaultError();
      throw err(errorJson);
    }
    final result = params.toEncodingResponse<SERVICERESPONSE>(response);
    switch (params.api) {
      case AptosRequestType.graphQl:
        if (isDynamicRequest) return result;
        final Map<String, dynamic> data =
            ServiceProviderUtils.toResponse<Map<String, dynamic>>(
              object: result,
              params: params,
            );

        final successData = data["data"];
        if (successData != null) {
          return ServiceProviderUtils.toResponse<SERVICERESPONSE>(
            object: successData,
            params: params,
          );
        }
        throw err(data);

      default:
        return result;
    }
  }

  int _id = 0;

  /// Sends a request to the Aptos network using the specified [request] parameter.
  ///
  /// The [timeout] parameter, if provided, sets the maximum duration for the request.
  /// Whatever is received will be returned
  @override
  Future<RESULT> request<RESULT, SERVICERESPONSE>(
    IServiceRequest<RESULT, SERVICERESPONSE, AptosRequestDetails> request, {
    Duration? timeout,
  }) async {
    final r = await _requestDynamic<RESULT, SERVICERESPONSE>(
      request,
      false,
      timeout: timeout,
    );
    return request.onResponse(r);
  }

  /// Sends a request to the Aptos network using the specified [request] parameter.
  ///
  /// The [timeout] parameter, if provided, sets the maximum duration for the request.
  /// Whatever is received will be returned
  @override
  Future<SERVICERESPONSE> requestDynamic<RESULT, SERVICERESPONSE>(
    IServiceRequest<RESULT, SERVICERESPONSE, AptosRequestDetails> request, {
    Duration? timeout,
  }) async {
    return _requestDynamic<RESULT, SERVICERESPONSE>(
      request,
      true,
      timeout: timeout,
    );
  }

  Future<SERVICERESPONSE> _requestDynamic<RESULT, SERVICERESPONSE>(
    IServiceRequest<RESULT, SERVICERESPONSE, AptosRequestDetails> request,
    bool isDynamic, {
    Duration? timeout,
  }) async {
    final id = ++_id;
    final params = await request.buildRequest(id);
    final response = await service.doRequest(params, timeout: timeout);
    return _findError<SERVICERESPONSE>(
      params: params,
      response: response,
      isDynamicRequest: isDynamic,
    );
  }
}
