import 'package:blockchain_utils/bip/address/eth_addr.dart';
import 'package:blockchain_utils/blockchain_utils.dart';

/// An abstract class representing a hexadecimal address in solidity smart conteract system.
/// such as Ethereum and Tron (visible address).
///
/// This class defines common methods for working with hexadecimal addresses,
/// including obtaining the length of the address and converting it to a list
/// of integers.
///
/// Implementations for specific blockchain addresses, such as Ethereum
/// (`ETHAddress`) and Tron (`TronAddress`), will provide concrete
/// implementations for these methods.
class SolidityAddress {
  final String _hexAddress;
  const SolidityAddress.unsafe(this._hexAddress);
  factory SolidityAddress(String address, {bool skipChecksum = true}) {
    address = StringUtils.strip0x(address);
    if (address.length > EthAddrConst.addrLen &&
        address.toLowerCase().startsWith('41')) {
      address = address.substring(2);
    }
    EthAddrDecoder().decodeAddr(
        '${CoinsConf.ethereum.params.addrPrefix}$address',
        {'skip_chksum_enc': skipChecksum});
    return SolidityAddress.unsafe(EthAddrUtils.toChecksumAddress(address));
  }
  factory SolidityAddress.fromBytes(List<int> bytes,
      {bool skipChecksum = true}) {
    return SolidityAddress(BytesUtils.toHexString(bytes));
  }

  /// Converts the hexadecimal address to a bytes.
  List<int> toBytes() {
    return BytesUtils.fromHexString(_hexAddress);
  }

  String toHex() => _hexAddress;

  @override
  String toString() {
    return _hexAddress;
  }
}
