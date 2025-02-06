import 'dart:async';
import 'package:blockchain_utils/blockchain_utils.dart';
import 'package:on_chain/aptos/src/provider/core/core.dart';
import 'package:on_chain/aptos/src/provider/service/service.dart';

class AptosProvider implements BaseProvider<AptosRequestDetails> {
  final AptosServiceProvider rpc;

  AptosProvider(this.rpc);

  static SERVICERESPONSE _findError<SERVICERESPONSE>(
      {required BaseServiceResponse<SERVICERESPONSE> response,
      required AptosRequestDetails params}) {
    if (response.type == ServiceResponseType.error) {
      final error = response.cast<ServiceErrorResponse>();
      final errorJson =
          StringUtils.tryToJson<Map<String, dynamic>>(error.error);
      final String message = errorJson?["message"] ?? ServiceConst.defaultError;
      errorJson?.removeWhere((k, v) => k == "message");
      throw RPCError(
          message: message,
          details: errorJson,
          errorCode: IntUtils.tryParse(errorJson?["vm_error_code"]));
    }
    return response.getResult(params);
  }

  int _id = 0;

  /// Sends a request to the cardano network (BlockFrost) using the specified [request] parameter.
  ///
  /// The [timeout] parameter, if provided, sets the maximum duration for the request.
  /// Whatever is received will be returned
  @override
  Future<RESULT> request<RESULT, SERVICERESPONSE>(
      BaseServiceRequest<RESULT, SERVICERESPONSE, AptosRequestDetails> request,
      {Duration? timeout}) async {
    final r = await requestDynamic(request, timeout: timeout);
    return request.onResonse(r);
  }

  /// Sends a request to the cardano network (BlockFrost) using the specified [request] parameter.
  ///
  /// The [timeout] parameter, if provided, sets the maximum duration for the request.
  /// Whatever is received will be returned
  @override
  Future<SERVICERESPONSE> requestDynamic<RESULT, SERVICERESPONSE>(
      BaseServiceRequest<RESULT, SERVICERESPONSE, AptosRequestDetails> request,
      {Duration? timeout}) async {
    final id = ++_id;
    final params = request.buildRequest(id);
    final response =
        await rpc.doRequest<SERVICERESPONSE>(params, timeout: timeout);
    return _findError(params: params, response: response);
  }
}
