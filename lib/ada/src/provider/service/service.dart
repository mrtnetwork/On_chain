import 'package:on_chain/ada/src/provider/blockfrost/core/core.dart';

/// A mixin defining the service provider contract for interacting with the Tron network.
mixin BlockfrostServiceProvider {
  /// The base URL of the Tron network endpoint.
  String get url;

  /// Makes an HTTP POST request to the Tron network with the specified [params].
  ///
  /// The optional [timeout] parameter sets the maximum duration for the request.
  Future<dynamic> post(BlockforestRequestDetails params, [Duration? timeout]);

  /// Makes an HTTP GET request to the Tron network with the specified [params].
  ///
  /// The optional [timeout] parameter sets the maximum duration for the request.
  Future<dynamic> get(BlockforestRequestDetails params, [Duration? timeout]);
}
