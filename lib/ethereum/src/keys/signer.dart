import 'package:blockchain_utils/blockchain_utils.dart';

/// Interface for Ethereum signing operations.
abstract mixin class EthereumSigner {
  /// Asynchronously signs a message digest.
  ///
  /// If [hashMessage] is true (default), hashes the message before signing.
  Future<IECDSASignature> signAsync(
    List<int> message, {
    bool hashMessage = true,
  });

  /// Asynchronously signs a personal message.
  ///
  /// Optional [payloadLength] specifies the message payload length.
  Future<BuBytes> signPersonalMessageAsync(
    List<int> message, {
    int? payloadLength,
  });
}
