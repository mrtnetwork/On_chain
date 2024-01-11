import 'package:on_chain/address/core.dart';
import 'package:blockchain_utils/bip/address/eth_addr.dart';
import 'package:blockchain_utils/blockchain_utils.dart';

/// Class representing an Ethereum address, implementing the [BaseHexAddress] interface.
class ETHAddress implements BaseHexAddress {
  /// Private constructor for creating an instance of [ETHAddress] with a given Ethereum address
  const ETHAddress._(this.address);

  /// The Ethereum address string.
  final String address;

  /// Creates an [ETHAddress] instance from a public key represented as a bytes.
  factory ETHAddress.fromPublicKey(List<int> keyBytes) {
    try {
      final toAddress = EthAddrEncoder().encodeKey(keyBytes);
      return ETHAddress._(toAddress);
    } catch (e) {
      throw MessageException("invalid ethreum public key",
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
      throw MessageException("invalid ethereum address",
          details: {"input": address});
    }
  }

  /// Creates an [ETHAddress] instance from a bytes representing the address.
  factory ETHAddress.fromBytes(List<int> addrBytes) {
    return ETHAddress(BytesUtils.toHexString(addrBytes, prefix: "0x"));
  }

  /// convert address to bytes
  @override
  List<int> toBytes() {
    return BytesUtils.fromHexString(address);
  }

  @override
  String toString() {
    return address;
  }

  /// Constant representing the length of the ETH address in bytes
  static const int lengthInBytes = 21;

  @override
  String toHex() {
    return address;
  }
}
