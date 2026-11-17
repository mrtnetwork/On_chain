import 'package:blockchain_utils/blockchain_utils.dart';
import 'package:on_chain/algorand/src/utils/utils.dart';

/// Algorand account address (32-byte Ed25519 public key, base32-encoded with checksum).
///
/// Implements [IAddress] for cross-chain address handling and CBOR serialization.
class AlgoAddress with Equality, CborTagSerializable implements IAddress {
  /// Base32-encoded address string (58 characters including checksum).
  @override
  final String address;

  /// Constructs without validation. Prefer the validated [AlgoAddress()] factory.
  const AlgoAddress.unsafe(this.address);

  /// Public-key / address payload length in bytes (32).
  static const int bytesLength = Ed25519KeysConst.pubKeyByteLen;

  /// Zero address: all-zero public key, encoded as
  /// `AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAY5HFKQ`.
  static const AlgoAddress zero = AlgoAddress.unsafe(
    "AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAY5HFKQ",
  );

  /// Creates an address from a base32 string, validating checksum and length.
  /// Throws if [address] is malformed.
  factory AlgoAddress(String address) {
    AlgoAddrDecoder().decodeAddr(address);
    return AlgoAddress.unsafe(address);
  }

  /// Deserializes from a CBOR-tagged IAddress blob for the Algorand network.
  factory AlgoAddress.deserializeIAddress({
    List<int>? bytes,
    CborObject? object,
  }) {
    final values = CborTagSerializable.decodeTaggedValue(
      identifier: BlockchainNetwork.algorand.identifier,
      cborBytes: bytes,
      cborObject: object,
    );
    return AlgoAddress.fromBytes(values.rawValueAt(0));
  }

  /// Creates an address from a raw 32-byte Ed25519 public key.
  factory AlgoAddress.fromBytes(List<int> pubKeyBytes) {
    final addr = AlgoAddrEncoder().encodeKey(pubKeyBytes);
    return AlgoAddress.unsafe(addr);
  }

  /// Derives a contract-account address from a TEAL program.
  /// Address = encode(SHA-512/256("Program" || program)).
  factory AlgoAddress.fromProgram(List<int> program) {
    final addr = AlgoAddrEncoder().encodeKey(
      AlgoUtils.hashData(AlgoUtils.programToSign(program)),
    );
    return AlgoAddress.unsafe(addr);
  }

  /// Derives an application address from an application ID.
  /// Address = encode(SHA-512/256("appID" || u64be(appId))).
  factory AlgoAddress.fromAppId(BigInt appId) {
    final addr = AlgoAddrEncoder().encodeKey(
      AlgoUtils.getApplicationChecksum(appId),
    );
    return AlgoAddress.unsafe(addr);
  }

  /// Decodes the address to its 32-byte public-key payload.
  List<int> toBytes() => AlgoAddrDecoder().decodeAddr(address);

  @override
  BlockchainNetwork get blockchainNetwork => BlockchainNetwork.algorand;

  /// Encodes this address as a CBOR-tagged IAddress blob.
  @override
  BuBytes encodeAsIAddress() {
    return toCbor().encode();
  }

  @override
  List<dynamic> get variables => [address];

  @override
  final String? viewType = null;

  @override
  String toString() => address;

  @override
  SerializationIdentifier get serializationIdentifier =>
      blockchainNetwork.identifier;

  /// CBOR serialization payload: the raw 32-byte public key.
  @override
  List<CborObject<Object?>?> get serializationItems => [
    toBytes().toCborBytes(),
  ];
}
