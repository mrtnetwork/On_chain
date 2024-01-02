import 'dart:async';
import 'core.dart';

/// A mixin for providing JSON-RPC service functionality.
mixin JSONRPCService {
  /// Represents the URL endpoint for JSON-RPC calls.
  String get url;

  /// Makes a JSON-RPC call with the specified [params] and optional [timeout].
  /// Returns a Future<Map<String, dynamic>> representing the JSON-RPC response.
  Future<Map<String, dynamic>> call(ETHRequestDetails params,
      [Duration? timeout]);
}
