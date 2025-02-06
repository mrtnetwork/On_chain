import 'package:blockchain_utils/blockchain_utils.dart';

/// A custom exception for handling errors related to the Aptos plugin.
class DartAptosPluginException extends BlockchainUtilsException {
  const DartAptosPluginException(super.message, {super.details});
}
