import 'package:blockchain_utils/blockchain_utils.dart';
import 'package:on_chain/algorand/src/crypto/keypair/public_key/ed25519.dart';
import 'package:on_chain/algorand/src/address/address.dart';
import 'package:on_chain/algorand/src/utils/utils.dart';

/// Abstract Algorand public key with domain-separated verification helpers.
///
/// Concrete implementations (e.g. [AlgoEd25519PublicKey]) provide the raw
/// [verify] primitive; this base class adds "MX" bytes and "ProgData" TEAL
/// verification matching the corresponding [AlgoSecretKey] sign helpers.
abstract class AlgoPublicKey with Equality {
  const AlgoPublicKey();

  /// Serializes the public key to its raw byte representation (32 bytes for Ed25519).
  BuBytes toBytes();

  /// Reconstructs a public key from raw bytes.
  /// Currently resolves to an Ed25519 public key.
  factory AlgoPublicKey.fromBytes(List<int> keyBytes) {
    return AlgoEd25519PublicKey.fromBytes(keyBytes);
  }

  /// Derives the Algorand address for this public key.
  AlgoAddress toAddress();

  /// Verifies a signature over an arbitrary message with the underlying scheme.
  /// Domain separation (prefixes) is applied by the higher-level helpers.
  bool verify(List<int> message, List<int> signature);

  /// Verifies a signature produced by [AlgoSecretKey.signBytes].
  /// Message = "MX" || message.
  bool verifyBytes(List<int> message, List<int> signature) {
    final data = [...AlgoUtils.bytesPrefix, ...message];
    return verify(data, signature);
  }

  /// Verifies a signature produced by [AlgoSecretKey.tealSign].
  /// Message = "ProgData" || contractAddr || data.
  bool tealVerify(
    List<int> data,
    AlgoAddress contractAddr,
    List<int> signature,
  ) {
    final message = [
      ...AlgoUtils.programDataPrefix,
      ...contractAddr.toBytes(),
      ...data,
    ];
    return verify(message, signature);
  }
}
