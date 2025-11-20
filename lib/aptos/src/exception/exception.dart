import 'package:on_chain/exception/exception.dart';

/// A custom exception for handling errors related to the Aptos plugin.
class DartAptosPluginException extends OnChainPluginException {
  const DartAptosPluginException(super.message, {super.details});
}
