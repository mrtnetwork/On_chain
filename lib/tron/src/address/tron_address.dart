import 'package:on_chain/solidity/address/core.dart';
import 'package:blockchain_utils/bip/address/trx_addr.dart';
import 'package:blockchain_utils/blockchain_utils.dart';
import 'package:on_chain/ethereum/src/address/evm_address.dart';

/// Class representing a Tron address, implementing the BaseHexAddress interface
class TronAddress implements SolidityAddress {
  /// Private fields to store the address and its hexadecimal representation
  final String _address;
  final String _hexAddress;

  /// Private constructor for internal use, initializing with address and hexAddress
  const TronAddress._(this._address, this._hexAddress);

  /// Factory method to create a TronAddress from a Tron public key represented as a list of integers
  factory TronAddress.fromPublicKey(List<int> keyBytes) {
    try {
      final toAddress = TrxAddrEncoder().encodeKey(keyBytes);
      final decode = TrxAddrDecoder().decodeAddr(toAddress);
      return TronAddress._(toAddress,
          BytesUtils.toHexString([...TrxAddressUtils.prefix, ...decode]));
    } catch (e) {
      throw MessageException("invalid tron public key",
          details: {"input": BytesUtils.toHexString(keyBytes)});
    }
  }

  /// Factory method to create a TronAddress from a Tron address string
  factory TronAddress(String address, {bool? visible}) {
    try {
      if (visible == null) {
        if (StringUtils.isHexBytes(address)) {
          return TronAddress.fromBytes(BytesUtils.fromHexString(address));
        }
        final decode = TrxAddrDecoder().decodeAddr(address);
        return TronAddress._(address,
            BytesUtils.toHexString([...TrxAddressUtils.prefix, ...decode]));
      } else {
        if (visible) {
          final decode = TrxAddrDecoder().decodeAddr(address);
          return TronAddress._(address,
              BytesUtils.toHexString([...TrxAddressUtils.prefix, ...decode]));
        } else {
          return TronAddress.fromBytes(BytesUtils.fromHexString(address));
        }
      }
    } catch (e) {
      throw MessageException("invalid tron address",
          details: {"input": address, "visible": visible});
    }
  }

  /// Factory method to create a TronAddress from hex bytes
  factory TronAddress.fromBytes(List<int> addrBytes) {
    final addr = TrxAddressUtils.fromHexBytes(addrBytes);
    return TronAddress._(addr, BytesUtils.toHexString(addrBytes));
  }

  /// Factory method to create a TronAddress from an Ethereum address represented as bytes
  factory TronAddress.fromEthAddress(List<int> addrBytes) {
    final addr =
        TrxAddressUtils.fromHexBytes([...TrxAddressUtils.prefix, ...addrBytes]);
    return TronAddress._(addr, BytesUtils.toHexString(addrBytes));
  }

  /// Implementation of the toBytes method from the BaseHexAddress interface
  @override
  List<int> toBytes() {
    return BytesUtils.fromHexString(_hexAddress);
  }

  /// Method to get the Tron address as a string, with an option to visible address (base58) or hex address
  String toAddress([bool visible = true]) {
    if (visible) {
      return _address;
    }
    return _hexAddress;
  }

  /// Method to get the Tron address as a string, with an option to visible address (base58) or hex address
  @override
  String toString([bool visible = true]) {
    return toAddress(visible);
  }

  /// Constant representing the length of the Tron address in bytes
  static const int lengthInBytes = 21;

  /// To Ethereum address
  ETHAddress toETHAddress() {
    final toBytes = BytesUtils.fromHexString(_hexAddress);

    /// remove tron 0x41 prefix from bytes
    return ETHAddress.fromBytes(
        toBytes.sublist(toBytes.length - TronAddress.lengthInBytes));
  }

  @override
  String toHex() {
    return _hexAddress;
  }

  @override
  operator ==(other) {
    if (other is! TronAddress) return false;
    return _address == other._address;
  }

  @override
  int get hashCode => _address.hashCode ^ _hexAddress.hashCode;
}
