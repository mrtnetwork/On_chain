import 'package:on_chain/exception/exception.dart';

/// Custom exception for errors related to the Move codec.
class BcsSerializationException extends OnChainPluginException {
  /// Constructor for [BcsSerializationException] with a message and optional details.
  const BcsSerializationException(super.message, {super.details});
}
