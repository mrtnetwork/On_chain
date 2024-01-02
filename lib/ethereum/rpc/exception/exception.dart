/// Exception class representing errors encountered during RPC (Remote Procedure Call) requests.
class RPCException implements Exception {
  /// Constructs an instance of [RPCException] with the provided details.
  const RPCException(
      {required this.message,
      required this.code,
      required this.data,
      required this.request});

  /// The error code associated with the error.
  final int code;

  /// A human-readable error message describing the issue.
  final String message;

  /// Additional data providing more context about the error (nullable).
  final dynamic data;

  /// The original request that triggered the error.
  final Map<String, dynamic> request;

  @override
  String toString() {
    return 'RPC Error: Received code $code with message  "$message".';
  }

  /// Converts the exception details to a JSON-formatted representation.
  Map<String, dynamic> toJson() {
    final error = {"message": message, "code": code};
    if (data != null) {
      error["data"] = data;
    }
    final toJson = {
      "jsonrpc": "2.0",
      "error": error,
    };
    if (request.isNotEmpty) {
      if (request.containsKey("id")) {
        toJson["id"] = request["id"];
      }
      if (request.containsKey("params") && request.containsKey("method")) {
        toJson["params"] = request["params"];
        toJson["method"] = request["method"];
      }
    }
    return toJson;
  }
}
