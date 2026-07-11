import 'dart:async';
import 'package:blockchain_utils/blockchain_utils.dart';
import 'package:on_chain/ada/src/provider/blockfrost/core/core.dart';
import 'package:on_chain/ada/src/provider/exception/blockfrost_api_error.dart';

class BlockFrostProvider<SERVICE extends IServiceProvider>
    implements IProvider<SERVICE, BlockFrostRequestDetails> {
  @override
  final SERVICE service;
  BlockFrostProvider(this.service);
  static void _paraseError(
    Map err,
    BlockFrostRequestDetails params,
    int statusCode,
  ) {
    final String error = err['error'].toString();
    final int? errorCode = err.valueAs("status_code");
    final String? msg = err['message']?.toString();
    String message = error;
    if (msg != null) {
      message = '$message: $msg';
    }
    throw RPCError(
      message: message,
      errorCode: errorCode,
      relatedNetwork: BlockchainNetwork.cardano,
      request: params.toJson(),
      statusCode: statusCode,
    );
  }

  static SERVICERESPONSE _findError<SERVICERESPONSE>({
    required BaseServiceResponse response,
    required BlockFrostRequestDetails params,
  }) {
    if (response.type == ServiceResponseType.error) {
      final error = response.cast<BaseServiceErrorResponse>();

      if (!error.validate) throw error.defaultError();
      final toJson = error.tryToJson();
      if (toJson != null &&
          toJson.hasValue('status_code') &&
          toJson.hasValue('error')) {
        _paraseError(toJson, params, response.statusCode);
      }
      throw RPCError(
        relatedNetwork: BlockchainNetwork.cardano,
        message:
            BlockfrostStatusCode.getErrorMessage(response.statusCode) ??
            error.findErrorMessage(),
        statusCode: response.statusCode,
      );
    }
    final SERVICERESPONSE result = params.toEncodingResponse(response);
    if (result is Map) {
      if (result.hasValue('status_code') && result.hasValue('error')) {
        _paraseError(result, params, response.statusCode);
      }
    }
    return result;
  }

  int _id = 0;

  /// Sends a request to the cardano network (BlockFrost) using the specified [request] parameter.
  ///
  /// The [timeout] parameter, if provided, sets the maximum duration for the request.
  /// Whatever is received will be returned

  @override
  Future<RESULT> request<RESULT, SERVICERESPONSE>(
    IServiceRequest<RESULT, SERVICERESPONSE, BlockFrostRequestDetails>
    request, {
    Duration? timeout,
  }) async {
    final r = await requestDynamic<RESULT, SERVICERESPONSE>(
      request,
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
    IServiceRequest<RESULT, SERVICERESPONSE, BlockFrostRequestDetails>
    request, {
    Duration? timeout,
  }) async {
    final id = ++_id;
    final params = request.buildRequest(id);
    final response = await service.doRequest(params, timeout: timeout);
    return _findError<SERVICERESPONSE>(params: params, response: response);
  }
}
