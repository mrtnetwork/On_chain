import 'package:on_chain/ethereum/src/exception/exception.dart';
import 'package:on_chain/solidity/address/core.dart';
import 'package:blockchain_utils/bip/address/eth_addr.dart';
import 'package:blockchain_utils/blockchain_utils.dart';

extension ToEthereumAddress on SolidityAddress {
  ETHAddress toEthereumAddress() {
    if (this is ETHAddress) return this as ETHAddress;
    return ETHAddress(toHex());
  }
}

/// Class representing an Ethereum address, implementing the [SolidityAddress] interface.
class ETHAddress extends SolidityAddress {
  final String address;

  /// Private constructor for creating an instance of [ETHAddress] with a given Ethereum address
  const ETHAddress._(this.address) : super.unsafe(address);

  /// Creates an [ETHAddress] instance from a public key represented as a bytes.
  factory ETHAddress.fromPublicKey(List<int> keyBytes) {
    try {
      final toAddress = EthAddrEncoder().encodeKey(keyBytes);
      return ETHAddress._(toAddress);
    } catch (e) {
      throw ETHPluginException("invalid ethreum public key",
          details: {"input": BytesUtils.toHexString(keyBytes)});
    }
  }

  /// Creates an [ETHAddress] instance from an Ethereum address string.
  ///
  /// Optionally, [skipChecksum] can be set to true to skip the address checksum validation.
  factory ETHAddress(String address, {bool skipChecksum = true}) {
    try {
      EthAddrDecoder().decodeAddr(address, {"skip_chksum_enc": skipChecksum});
      return ETHAddress._(EthAddrUtils.toChecksumAddress(address));
    } catch (e) {
      throw ETHPluginException("invalid ethereum address",
          details: {"input": address});
    }
  }

  /// Creates an [ETHAddress] instance from a bytes representing the address.
  factory ETHAddress.fromBytes(List<int> addrBytes) {
    return ETHAddress(BytesUtils.toHexString(addrBytes, prefix: "0x"));
  }

  /// Constant representing the length of the ETH address in bytes
  static const int lengthInBytes = 20;

  @override
  String toString() {
    return address;
  }

  @override
  operator ==(other) {
    if (other is! ETHAddress) return false;
    return address == other.address;
  }

  @override
  int get hashCode => address.hashCode;
}
