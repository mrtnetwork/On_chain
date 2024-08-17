import 'package:blockchain_utils/exception/exceptions.dart';

/// https://blockfrost.dev/api/blockfrost-io-api-documentation
class BlockfrostStatusCode {
  static const int invalidRequest = 400;
  static const int exceedRequestLimit = 402;
  static const int inValidAuthenticated = 403;
  static const int resourceDoesNotExist = 404;
  static const int rateLimit = 429;
  static const int bannedToMuchRequest = 418;
}

class BlockfrostError implements BlockchainUtilsException {
  @override
  final String message;
  final int statusCode;
  final String error;
  @override
  final Map<String, dynamic>? details;
  const BlockfrostError(
      {required this.message,
      required this.statusCode,
      required this.error,
      this.details});

  @override
  String toString() {
    return "Error: $error, Message: $message, StatusCode: $statusCode";
  }
}
// HTTP 418 return code is used when the user has been auto-banned for flooding too much after previously receiving error code 402 or 429.
// HTTP 500 return code is used when our endpoints are having a problem.
