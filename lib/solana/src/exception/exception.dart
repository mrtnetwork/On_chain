import 'package:blockchain_utils/exception/exceptions.dart';

class SolanaPluginException extends BlockchainUtilsException {
  const SolanaPluginException(this.message, {this.details});

  @override
  final String message;

  @override
  final Map<String, dynamic>? details;

  @override
  String toString() {
    String msg = message;
    if (details?.isNotEmpty ?? false) {
      msg += ' Details: $details';
    }
    return msg;
  }
}
