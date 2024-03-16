import 'package:blockchain_utils/exception/exceptions.dart';

class BlockfrostError implements BlockchainUtilsException {
  const BlockfrostError(
      {required this.message, required this.statusCode, required this.error});
  @override
  final String message;
  final int statusCode;
  final String error;
  @override
  String toString() {
    return "Error: $error, Message: $message, StatusCode: $statusCode";
  }
}
