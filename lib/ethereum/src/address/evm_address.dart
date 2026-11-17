import 'package:on_chain/solidity/address/core.dart';
import 'package:blockchain_utils/blockchain_utils.dart';

extension ExtToEthereumAddress on SolidityAddress {
  /// Converts a SolidityAddress to an ETHAddress.
  ETHAddress toEthereumAddress() {
    if (this is ETHAddress) return this as ETHAddress;
    return ETHAddress.fromBytes(toSolidtyBytes());
  }
}

/// Represents an Ethereum address with checksum support.
class ETHAddress extends SolidityAddress
    with CborTagSerializable, Equality
    implements IAddress {
  @override
  final String address;

  /// Creates an instance with the given checksummed [address].
  const ETHAddress._(this.address) : super.unsafe(address);

  /// Creates an instance without checksum validation.
  const ETHAddress.unsafe(this.address) : super.unsafe(address);

  /// Deserializes an address from CBOR bytes or object.
  factory ETHAddress.deserializeIAddress({
    List<int>? bytes,
    CborObject? object,
  }) {
    final values = CborTagSerializable.decodeTaggedValue(
      identifier: BlockchainNetwork.ethereum.identifier,
      cborBytes: bytes,
      cborObject: object,
    );
    return ETHAddress.fromBytes(values.rawValueAt(0));
  }

  /// Zero address constant.
  static const ETHAddress zero = ETHAddress._(
    '0x0000000000000000000000000000000000000000',
  );

  /// One address constant.
  static const ETHAddress one = ETHAddress._(
    '0x0000000000000000000000000000000000000001',
  );

  /// Creates an address from a public key bytes.
  factory ETHAddress.fromPublicKey(List<int> keyBytes) {
    try {
      final toAddress = EthAddrEncoder().encodeKey(keyBytes);
      return ETHAddress._(toAddress);
    } catch (e) {
      throw BuError(
        DefaultErrorType.invalidArgument,
        'Invalid Ethereum public key.',
        details: {'input': BytesUtils.toHexString(keyBytes)},
      );
    }
  }

  /// Creates an address from a string with optional checksum validation.
  ///
  /// If [skipChecksum] is true (default), skips checksum validation.
  factory ETHAddress(String address, {bool skipChecksum = true}) {
    try {
      EthAddrDecoder().decodeAddr(address, skipChecksum: skipChecksum);
      return ETHAddress._(EthAddrUtils.toChecksumAddress(address));
    } catch (e) {
      throw BuError(
        DefaultErrorType.invalidAddress,
        'Invalid Ethereum address.',
        details: {'input': address},
      );
    }
  }

  /// Creates an address from raw bytes.
  factory ETHAddress.fromBytes(List<int> addrBytes) {
    return ETHAddress(BytesUtils.toHexString(addrBytes, prefix: '0x'));
  }

  /// Ethereum address length in bytes.
  static const int lengthInBytes = 20;

  /// Returns the address as bytes.
  BuBytes toBytes() {
    return toSolidtyBytes();
  }

  /// Returns the checksummed address as hex string.
  String toHex() => address;

  /// Returns the address as a BigInt.
  BigInt toBigInt() {
    return BigintUtils.fromBytes(toBytes());
  }

  @override
  String toString() => address;

  @override
  BlockchainNetwork get blockchainNetwork => BlockchainNetwork.ethereum;

  @override
  SerializationIdentifier get serializationIdentifier =>
      blockchainNetwork.identifier;

  @override
  List<CborObject?> get serializationItems => [CborBytesValue(toBytes())];

  @override
  List<dynamic> get variables => [StringUtils.normalizeHex(address)];

  @override
  BuBytes encodeAsIAddress() {
    return toCbor().encode();
  }
}
