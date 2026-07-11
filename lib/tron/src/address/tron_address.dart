import 'package:on_chain/ethereum/src/address/evm_address.dart';
import 'package:on_chain/solidity/address/core.dart';
import 'package:blockchain_utils/blockchain_utils.dart';
import 'package:on_chain/tron/src/exception/exception.dart';

extension ExtToTronAddress on SolidityAddress {
  TronAddress toTronAddress() {
    if (this is TronAddress) return this as TronAddress;
    return TronAddress.fromEthAddress(toSolidtyBytes());
  }
}

/// Class representing a Tron address, implementing the BaseHexAddress interface
class TronAddress extends SolidityAddress
    with CborTagSerializable, Equality
    implements IAddress {
  /// Private fields to store the address and its hexadecimal representation
  @override
  final String address;

  /// Private constructor for internal use, initializing with address and hexAddress
  const TronAddress._(this.address, String hexAddress)
    : super.unsafe(hexAddress);

  /// Factory method to create a TronAddress from a Tron public key represented as a list of integers
  factory TronAddress.fromPublicKey(List<int> keyBytes) {
    try {
      final toAddress = TrxAddrEncoder().encodeKey(keyBytes);
      final decode = TrxAddrDecoder().decodeAddr(toAddress);
      return TronAddress._(toAddress, BytesUtils.toHexString(decode));
    } catch (e) {
      throw TronPluginException(
        'invalid tron public key',
        details: {'input': BytesUtils.toHexString(keyBytes)},
      );
    }
  }

  factory TronAddress.deserializeIAddress({
    List<int>? bytes,
    CborObject? object,
  }) {
    final values = CborTagSerializable.decodeTaggedValue(
      identifier: BlockchainNetwork.tron.identifier,
      cborBytes: bytes,
      cborObject: object,
    );
    return TronAddress.fromBytes(values.rawValueAt(0));
  }

  /// Factory method to create a TronAddress from a Tron address string
  factory TronAddress(String address, {bool? visible}) {
    try {
      if (visible == null) {
        if (StringUtils.isHexBytes(address)) {
          return TronAddress.fromBytes(BytesUtils.fromHexString(address));
        }
        final decode = TrxAddrDecoder().decodeAddr(address);
        return TronAddress._(address, BytesUtils.toHexString(decode));
      } else {
        if (visible) {
          final decode = TrxAddrDecoder().decodeAddr(address);
          return TronAddress._(address, BytesUtils.toHexString(decode));
        } else {
          return TronAddress.fromBytes(BytesUtils.fromHexString(address));
        }
      }
    } catch (e) {
      throw TronPluginException(
        'invalid tron address',
        details: {'input': address, 'visible': visible?.toString()},
      );
    }
  }

  /// Factory method to create a TronAddress from hex bytes
  factory TronAddress.fromBytes(List<int> addrBytes) {
    if (addrBytes.length != lengthInBytes) {
      throw TronPluginException("Invalid ethereum address bytes length.");
    }
    final addr = TrxAddressUtils.fromHexBytes(addrBytes);
    return TronAddress._(addr, BytesUtils.toHexString(addrBytes.sublist(1)));
  }

  /// Factory method to create a TronAddress from an Ethereum address represented as bytes
  factory TronAddress.fromEthAddress(List<int> addrBytes) {
    if (addrBytes.length != ETHAddress.lengthInBytes) {
      throw TronPluginException("Invalid ethereum address bytes length.");
    }
    final addr = TrxAddressUtils.fromHexBytes([
      ...TrxAddressUtils.prefix,
      ...addrBytes,
    ]);
    return TronAddress._(addr, BytesUtils.toHexString(addrBytes));
  }

  List<int> toBytes() {
    return [...TrxAddressUtils.prefix, ...toSolidtyBytes()];
  }

  String toHex() => "41${StringUtils.normalizeHex(super.toSolidityHex())}";

  /// Method to get the Tron address as a string, with an option to visible address (base58) or hex address
  String toAddress([bool visible = true]) {
    if (visible) {
      return address;
    }
    return toHex();
  }

  /// Method to get the Tron address as a string, with an option to visible address (base58) or hex address
  @override
  String toString([bool visible = true]) {
    return toAddress(visible);
  }

  /// Constant representing the length of the Tron address in bytes
  static const int lengthInBytes = 21;

  @override
  BlockchainNetwork get blockchainNetwork => BlockchainNetwork.tron;

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
}
