import 'dart:async';
import 'package:on_chain/tron/provider/core/request.dart';
import 'package:on_chain/tron/provider/service/service.dart';

/// Facilitates communication with the Tron network by making requests using a provided [TronServiceProvider].
class TronProvider {
  /// The underlying Tron service provider used for network communication.
  final TronServiceProvider rpc;

  /// Constructs a new [TronProvider] instance with the specified [rpc] service provider.
  TronProvider(this.rpc);

  int _id = 0;

  /// Sends a request to the Tron network using the specified [request] parameter.
  ///
  /// The [timeout] parameter, if provided, sets the maximum duration for the request.
  Future<T> request<T>(TVMRequestParam<T, Map<String, dynamic>> request,
      [Duration? timeout]) async {
    final id = ++_id;
    final params = request.toRequest(id);
    final data = request.method.isPost
        ? await rpc.post(params, timeout)
        : await rpc.get(params, timeout);
    return request.onResonse(data);
  }
}
