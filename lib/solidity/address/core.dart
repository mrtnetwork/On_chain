import 'package:blockchain_utils/blockchain_utils.dart';
import 'package:on_chain/solidity/abi/exception/abi_exception.dart';

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
class SolidityAddress with Equality, CborTagSerializable implements IAddress {
  final String _hexAddress;
  const SolidityAddress.unsafe(this._hexAddress);
  factory SolidityAddress(String address, {bool skipChecksum = true}) {
    address = StringUtils.normalizeHex(address);
    if (address.length > EthAddrConst.addrLen && address.startsWith('41')) {
      address = address.substring(2);
    }
    if (address.length != EthAddrConst.addrLen) {
      throw SolidityAbiException("Invalid address bytes length.");
    }

    return SolidityAddress.unsafe(EthAddrUtils.toChecksumAddress(address));
  }
  factory SolidityAddress.fromBytes(List<int> bytes) {
    return SolidityAddress(BytesUtils.toHexString(bytes));
  }
  factory SolidityAddress.deserializeIAddress({
    List<int>? bytes,
    CborObject? object,
  }) {
    final values = CborTagSerializable.decodeTaggedValue(
      identifier: BlockchainNetwork.ethereum.identifier,
      cborBytes: bytes,
      cborObject: object,
    );
    return SolidityAddress.fromBytes(values.rawValueAt(0));
  }

  // /// Converts the hexadecimal address to a bytes.
  List<int> toSolidtyBytes() {
    return BytesUtils.fromHexString(_hexAddress);
  }

  String toSolidityHex() => _hexAddress;

  @override
  String toString() {
    return _hexAddress;
  }

  @override
  BlockchainNetwork get blockchainNetwork => BlockchainNetwork.ethereum;

  @override
  List<int> encodeAsIAddress() {
    return toCbor().encode();
  }

  @override
  SerializationIdentifier get serializationIdentifier =>
      blockchainNetwork.identifier;

  @override
  List<CborObject?> get serializationItems => [
    CborBytesValue(toSolidtyBytes()),
  ];

  @override
  List<dynamic> get variables => [_hexAddress];

  @override
  String get address => _hexAddress;

  @override
  String? get viewType => null;
}
