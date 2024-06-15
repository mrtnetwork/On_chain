import 'package:blockchain_utils/exception/exceptions.dart';

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
