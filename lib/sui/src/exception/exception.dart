import 'package:on_chain/exception/exception.dart';

/// Custom exception for handling errors specific to the Dart Sui plugin.
class DartSuiPluginException extends OnChainPluginException {
  const DartSuiPluginException(super.message, {super.details});
}
