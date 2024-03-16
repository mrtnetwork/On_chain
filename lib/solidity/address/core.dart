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
abstract class SolidityAddress {
  /// Converts the hexadecimal address to a bytes.
  List<int> toBytes();

  String toHex();
}
