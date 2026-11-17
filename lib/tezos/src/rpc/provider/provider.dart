import 'dart:async';

import 'package:blockchain_utils/blockchain_utils.dart';
import 'package:on_chain/tezos/src/rpc/core/core.dart';

/// HTTP provider for Octez / Tezos node REST APIs (shell + protocol).
///
/// Octez returns the resource body directly and uses
/// HTTP status codes for errors. Point [service] at a base such as:
/// `https://<host>/` or `https://<host>/chains/main/blocks/head` depending on
/// whether request paths already include the chain/block prefix.
class OctezProvider<SERVICE extends IServiceProvider>
    implements IProvider<SERVICE, OctezRequestDetails> {
  @override
  final SERVICE service;

  OctezProvider(this.service);

  int _id = 0;

  static SERVICERESPONSE _decode<SERVICERESPONSE>({
    required BaseServiceResponse response,
    required OctezRequestDetails params,
  }) {
    if (response.type == ServiceResponseType.error) {
      final error = response.cast<BaseServiceErrorResponse>();
      throw error.defaultError();
    }
    try {
      return params.toEncodingResponse<SERVICERESPONSE>(response);
    } catch (e) {
      // Some Octez endpoints return a bare number (e.g. counter as JSON int).
      // Retry as string encoding when the expected type is String.
      if (SERVICERESPONSE == String) {
        try {
          final asStr = params.toEncodingResponse<dynamic>(
            response,
            encoding: ServiceReponseEncoding.string,
          );
          return asStr.toString() as SERVICERESPONSE;
        } catch (_) {}
      }
      rethrow;
    }
  }

  @override
  Future<RESULT> request<RESULT, SERVICERESPONSE>(
    IServiceRequest<RESULT, SERVICERESPONSE, OctezRequestDetails> request, {
    Duration? timeout,
  }) async {
    final r = await requestDynamic<RESULT, SERVICERESPONSE>(
      request,
      timeout: timeout,
    );
    return request.onResponse(r);
  }

  @override
  Future<SERVICERESPONSE> requestDynamic<RESULT, SERVICERESPONSE>(
    IServiceRequest<RESULT, SERVICERESPONSE, OctezRequestDetails> request, {
    Duration? timeout,
  }) async {
    final params = await request.buildRequest(_id++);
    final response = await service.doRequest(params, timeout: timeout);
    return _decode<SERVICERESPONSE>(response: response, params: params);
  }
}
