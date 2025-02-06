import 'package:blockchain_utils/blockchain_utils.dart';

/// Custom exception for errors related to the Move codec.
class BcsSerializationException extends BlockchainUtilsException {
  /// Constructor for [BcsSerializationException] with a message and optional details.
  const BcsSerializationException(super.message, {super.details});
}
