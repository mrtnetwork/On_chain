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
    if (response.type == ServiceResponseType.error) {
      final error = response.cast<BaseServiceErrorResponse>();
      if (!error.validate) throw error.defaultError();
      final errorJson = error.tryToJson();
      if (errorJson == null) throw error.defaultError();
      final message = errorJson["message"];
      errorJson.removeWhere((k, v) => k == "message");
      throw RPCError(
        message: (message is String ? message : ServiceConst.defaultError),
        relatedNetwork: BlockchainNetwork.aptos,
        errorCode: errorJson.valueAs("vm_error_code"),
        statusCode: error.statusCode,
        jsonRpcErrpr: errorJson,
      );
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
        final List<Map<String, dynamic>> errors =
            (data["errors"] as List?)?.cast() ?? [];
        if (errors.isEmpty) {
          throw RPCError(
            relatedNetwork: BlockchainNetwork.aptos,
            message: ServiceConst.defaultError,
            jsonRpcErrpr: data,
            statusCode: response.statusCode,
          );
        }
        final List<String> messages = data.valueEnsureAsList<String>("message");
        throw RPCError(
          relatedNetwork: BlockchainNetwork.aptos,
          message: messages.join(", "),
          jsonRpcErrpr: data,
          statusCode: response.statusCode,
        );

      default:
        return result;
    }
  }

  int _id = 0;

  /// Sends a request to the cardano network (BlockFrost) using the specified [request] parameter.
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
    return request.onResonse(r);
  }

  /// Sends a request to the cardano network (BlockFrost) using the specified [request] parameter.
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
    final params = request.buildRequest(id);
    final response = await service.doRequest(params, timeout: timeout);
    return _findError<SERVICERESPONSE>(
      params: params,
      response: response,
      isDynamicRequest: isDynamic,
    );
  }
}
