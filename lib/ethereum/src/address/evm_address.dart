import 'package:on_chain/ethereum/src/exception/exception.dart';
import 'package:on_chain/solidity/address/core.dart';
import 'package:blockchain_utils/blockchain_utils.dart';

extension ExtToEthereumAddress on SolidityAddress {
  ETHAddress toEthereumAddress() {
    if (this is ETHAddress) return this as ETHAddress;
    return ETHAddress.fromBytes(toSolidtyBytes());
  }
}

/// Class representing an Ethereum address, implementing the [SolidityAddress] interface.
class ETHAddress extends SolidityAddress
    with CborTagSerializable, Equality
    implements IAddress {
  @override
  final String address;

  /// Private constructor for creating an instance of [ETHAddress] with a given Ethereum address
  const ETHAddress._(this.address) : super.unsafe(address);

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

  /// deserializeIAddress

  static const ETHAddress zero = ETHAddress._(
    "0x0000000000000000000000000000000000000000",
  );
  static const ETHAddress one = ETHAddress._(
    "0x0000000000000000000000000000000000000001",
  );

  /// Creates an [ETHAddress] instance from a public key represented as a bytes.
  factory ETHAddress.fromPublicKey(List<int> keyBytes) {
    try {
      final toAddress = EthAddrEncoder().encodeKey(keyBytes);
      return ETHAddress._(toAddress);
    } catch (e) {
      throw ETHPluginException(
        'invalid ethreum public key',
        details: {'input': BytesUtils.toHexString(keyBytes)},
      );
    }
  }

  /// Creates an [ETHAddress] instance from an Ethereum address string.
  ///
  /// Optionally, [skipChecksum] can be set to true to skip the address checksum validation.
  factory ETHAddress(String address, {bool skipChecksum = true}) {
    try {
      EthAddrDecoder().decodeAddr(address, skipChecksum: skipChecksum);
      return ETHAddress._(EthAddrUtils.toChecksumAddress(address));
    } catch (e) {
      throw ETHPluginException(
        'invalid ethereum address',
        details: {'input': address},
      );
    }
  }

  /// Creates an [ETHAddress] instance from a bytes representing the address.
  factory ETHAddress.fromBytes(List<int> addrBytes) {
    return ETHAddress(BytesUtils.toHexString(addrBytes, prefix: '0x'));
  }

  /// Constant representing the length of the ETH address in bytes
  static const int lengthInBytes = 20;

  List<int> toBytes() {
    return toSolidtyBytes();
  }

  String toHex() => address;

  BigInt toBigInt() {
    return BigintUtils.fromBytes(toBytes());
  }

  @override
  String toString() {
    return address;
  }

  @override
  BlockchainNetwork get blockchainNetwork => BlockchainNetwork.ethereum;

  @override
  SerializationIdentifier get serializationIdentifier =>
      blockchainNetwork.identifier;

  @override
  List<CborObject?> get serializationItems => [CborBytesValue(toBytes())];

  @override
  List<dynamic> get variables => [address];

  @override
  List<int> encodeAsIAddress() {
    return toCbor().encode();
  }
}
