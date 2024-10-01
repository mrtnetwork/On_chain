import 'package:blockchain_utils/exception/exceptions.dart';

class SolanaPluginException extends BlockchainUtilsException {
  const SolanaPluginException(String message, {Map<String, dynamic>? details})
      : super(message, details: details);
}
