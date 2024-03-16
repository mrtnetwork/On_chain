import 'dart:async';
import 'package:on_chain/ada/src/provider/blockfrost/core/core.dart';
import 'package:on_chain/ada/src/provider/exception/blockfrost_api_error.dart';
import 'package:on_chain/ada/src/provider/service/service.dart';
import 'package:on_chain/global_types/provider_request.dart';

/// Facilitates communication with the blockfrost by making requests using a provided [BlockforestProvider].
class BlockforestProvider {
  /// The underlying blockfrost service provider used for network communication.
  final BlockfrostServiceProvider rpc;

  /// Constructs a new [BlockforestProvider] instance with the specified [rpc] service provider.
  BlockforestProvider(this.rpc);

  int _id = 0;

  static void _findError(dynamic val) {
    if (val is Map) {
      if (val.containsKey("status_code") && val.containsKey("error")) {
        final String error = val["error"];
        final int statusCode = int.tryParse(val["status_code"].toString()) ?? 0;
        final String message = val["message"];
        throw BlockfrostError(
            message: message, statusCode: statusCode, error: error);
      }
    }
  }

  /// Sends a request to the blockfrost network using the specified [request] parameter.
  ///
  /// The [timeout] parameter, if provided, sets the maximum duration for the request.
  /// Whatever is received will be returned
  Future<dynamic> requestDynamic(BlockforestRequestParam request,
      [Duration? timeout]) async {
    final id = ++_id;
    final params = request.toRequest(id);
    final data = params.requestType == HTTPRequestType.post
        ? await rpc.post(params, timeout)
        : await rpc.get(params, timeout);
    _findError(data);
    return data;
  }

  /// Sends a request to the blockfrost network using the specified [request] parameter.
  ///
  /// The [timeout] parameter, if provided, sets the maximum duration for the request.
  Future<T> request<T, E>(BlockforestRequestParam<T, E> request,
      [Duration? timeout]) async {
    final data = await requestDynamic(request, timeout);
    final Object result;
    if (E == List<Map<String, dynamic>>) {
      result = (data as List).map((e) => Map<String, dynamic>.from(e)).toList();
    } else {
      result = data;
    }
    return request.onResonse(result as E);
  }
}
