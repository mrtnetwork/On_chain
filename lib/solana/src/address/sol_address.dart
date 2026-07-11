import 'package:blockchain_utils/blockchain_utils.dart';
import 'package:on_chain/solana/src/exception/exception.dart';
import 'package:on_chain/solana/src/keypair/public_key.dart';

/// Represents a Solana address.
class SolAddress with CborTagSerializable, Equality implements IAddress {
  static const defaultPubKey = SolAddress.unchecked(
    '11111111111111111111111111111111',
  );

  @override
  final String address;
  const SolAddress._(this.address);

  /// Constructs a Solana address without performing validation.
  const SolAddress.unchecked(this.address);

  /// Constructs a Solana address without checking the curve.
  factory SolAddress.uncheckCurve(String address) {
    final decode = Base58Decoder.decode(address);
    return SolAddress.uncheckBytes(decode);
  }
  factory SolAddress.deserializeIAddress({
    List<int>? bytes,
    CborObject? object,
  }) {
    final values = CborTagSerializable.decodeTaggedValue(
      identifier: BlockchainNetwork.solana.identifier,
      cborBytes: bytes,
      cborObject: object,
    );
    return SolAddress.uncheckBytes(values.rawValueAt(0));
  }

  /// Constructs a Solana address without checking the curve of the bytes.
  factory SolAddress.uncheckBytes(List<int> keyBytes) {
    if (keyBytes.length != 32) {
      throw const SolanaPluginException(
        'The public key must have a length of 32 bytes.',
      );
    }
    return SolAddress._(Base58Encoder.encode(keyBytes));
  }

  /// Constructs a Solana address with checking curve.
  factory SolAddress(String address) {
    SolAddrDecoder().decodeAddr(address);
    return SolAddress._(address);
  }

  /// Constructs a Solana address from a public key.
  factory SolAddress.fromPublicKey(List<int> pubKeyBytes) {
    final address = SolAddrEncoder().encodeKey(pubKeyBytes);
    return SolAddress._(address);
  }

  /// Constructs a Solana address with a seed.
  factory SolAddress.withSeed({
    required SolAddress fromPublicKey,
    required String seed,
    required SolAddress programId,
  }) {
    final toBytes = List<int>.from([
      ...fromPublicKey.toBytes(),
      ...StringUtils.encode(seed),
      ...programId.toBytes(),
    ]);
    return SolAddress.uncheckBytes(QuickCrypto.sha256Hash(toBytes));
  }

  /// Converts the address to bytes.
  List<int> toBytes() {
    return List.from(SolAddrDecoder().decodeAddr(address));
  }

  /// Converts the address to a Solana public key.
  SolanaPublicKey toPublicKey() {
    return SolanaPublicKey.fromBytes(toBytes());
  }

  bool get isOnCurve => Ed25519PublicKey.isValidBytes(toBytes());

  @override
  String toString() {
    return address;
  }

  @override
  BlockchainNetwork get blockchainNetwork => BlockchainNetwork.solana;

  @override
  List<int> encodeAsIAddress() {
    return toCbor().encode();
  }

  @override
  SerializationIdentifier get serializationIdentifier =>
      blockchainNetwork.identifier;

  @override
  List<CborObject?> get serializationItems => [CborBytesValue(toBytes())];

  @override
  List<dynamic> get variables => [address];

  @override
  String? get viewType => null;
}
