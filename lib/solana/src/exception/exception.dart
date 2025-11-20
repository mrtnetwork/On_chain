import 'package:on_chain/exception/exception.dart';

class SolanaPluginException extends OnChainPluginException {
  const SolanaPluginException(super.message, {super.details});
}
