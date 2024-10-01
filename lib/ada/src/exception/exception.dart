import 'package:blockchain_utils/exception/exceptions.dart';

class ADAPluginException extends BlockchainUtilsException {
  const ADAPluginException(String message, {Map<String, dynamic>? details})
      : super(message, details: details);
}
