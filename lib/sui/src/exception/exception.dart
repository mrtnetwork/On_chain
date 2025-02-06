import 'package:blockchain_utils/blockchain_utils.dart';

/// Custom exception for handling errors specific to the Dart Sui plugin.
class DartSuiPluginException extends BlockchainUtilsException {
  const DartSuiPluginException(super.message, {super.details});
}
