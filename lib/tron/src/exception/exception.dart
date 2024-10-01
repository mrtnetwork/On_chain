import 'package:blockchain_utils/exception/exceptions.dart';

class TronPluginException extends BlockchainUtilsException {
  const TronPluginException(String message, {Map<String, dynamic>? details})
      : super(message, details: details);
}
