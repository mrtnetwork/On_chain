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
class SolidityAddress with Equality, CborTagSerializable implements IAddress {
  final String _hexAddress;
  const SolidityAddress.unsafe(this._hexAddress);
  factory SolidityAddress(String address, {bool skipChecksum = true}) {
    address = StringUtils.normalizeHex(address);
    if (address.length > EthAddrConst.addrLen && address.startsWith('41')) {
      address = address.substring(2);
    }
    if (address.length != EthAddrConst.addrLen) {
      throw BuError(
        DefaultErrorType.invalidLength,
        "Invalid address bytes length.",
      );
    }

    return SolidityAddress.unsafe(
      StringUtils.normalizeHex(address, with0x: true),
    );
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
  BuBytes toSolidtyBytes() {
    return BytesUtils.fromHexString(_hexAddress);
  }

  String toSolidityHex() => StringUtils.normalizeHex(_hexAddress, with0x: true);

  @override
  String toString() {
    return toSolidityHex();
  }

  @override
  BlockchainNetwork get blockchainNetwork => BlockchainNetwork.ethereum;

  @override
  BuBytes encodeAsIAddress() {
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
  List<dynamic> get variables => [toSolidityHex()];

  @override
  String get address => toSolidityHex();

  @override
  String? get viewType => null;
}
