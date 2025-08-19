import 'dart:async';
import 'package:blockchain_utils/blockchain_utils.dart';
import 'package:on_chain/ada/src/provider/blockfrost/core/core.dart';
import 'package:on_chain/ada/src/provider/exception/blockfrost_api_error.dart';
import 'package:on_chain/ada/src/provider/service/service.dart';

/// Facilitates communication with the blockfrost by making requests using a provided [BlockFrostProvider].
class BlockFrostProvider implements BaseProvider<BlockFrostRequestDetails> {
  /// The underlying blockfrost service provider used for network communication.
  final BlockFrostServiceProvider rpc;

  /// Constructs a new [BlockFrostProvider] instance with the specified [rpc] service provider.
  BlockFrostProvider(this.rpc);

  static void _paraseError(Map err, BlockFrostRequestDetails params) {
    final String error = err['error'].toString();
    final int? errorCode = IntUtils.tryParse(err['status_code'].toString());
    final String? msg = err['message']?.toString();
    String message = error;
    if (msg != null) {
      message = '$message: $msg';
    }
    throw RPCError(
      message: message,
      errorCode: errorCode,
      request: params.toJson(),
    );
  }

  static SERVICERESPONSE _findError<SERVICERESPONSE>(
      {required BaseServiceResponse<SERVICERESPONSE> response,
      required BlockFrostRequestDetails params}) {
    if (response.type == ServiceResponseType.error) {
      final error = response.cast<ServiceErrorResponse>();
      final toJson = StringUtils.tryToJson<Map<String, dynamic>>(error.error);
      if (toJson != null &&
          toJson.containsKey('status_code') &&
          toJson.containsKey('error')) {
        _paraseError(toJson, params);
      }
      throw RPCError(
        message: error.error ??
            BlockfrostStatusCode.getErrorMessage(response.statusCode),
      );
    }
    final SERVICERESPONSE r = response.getResult(params);
    if (r is Map) {
      if (r.containsKey('status_code') && r.containsKey('error')) {
        _paraseError(r, params);
      }
    }
    return r;
  }

  int _id = 0;

  /// Sends a request to the cardano network (BlockFrost) using the specified [request] parameter.
  ///
  /// The [timeout] parameter, if provided, sets the maximum duration for the request.
  /// Whatever is received will be returned
  @override
  Future<RESULT> request<RESULT, SERVICERESPONSE>(
      BaseServiceRequest<RESULT, SERVICERESPONSE, BlockFrostRequestDetails>
          request,
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
      BaseServiceRequest<RESULT, SERVICERESPONSE, BlockFrostRequestDetails>
          request,
      {Duration? timeout}) async {
    final id = ++_id;
    final params = request.buildRequest(id);
    final response =
        await rpc.doRequest<SERVICERESPONSE>(params, timeout: timeout);
    return _findError(params: params, response: response);
  }
}
