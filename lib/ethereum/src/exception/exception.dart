import 'package:blockchain_utils/exception/exceptions.dart';

class ETHPluginException extends BlockchainUtilsException {
  const ETHPluginException(String message, {Map<String, dynamic>? details})
      : super(message, details: details);
}
