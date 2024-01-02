import 'package:on_chain/tron/provider/core/request.dart';

/// A mixin defining the service provider contract for interacting with the Tron network.
mixin TronServiceProvider {
  /// The base URL of the Tron network endpoint.
  String get url;

  /// Makes an HTTP POST request to the Tron network with the specified [params].
  ///
  /// The optional [timeout] parameter sets the maximum duration for the request.
  Future<Map<String, dynamic>> post(TronRequestDetails params,
      [Duration? timeout]);

  /// Makes an HTTP GET request to the Tron network with the specified [params].
  ///
  /// The optional [timeout] parameter sets the maximum duration for the request.
  Future<Map<String, dynamic>> get(TronRequestDetails params,
      [Duration? timeout]);
}
