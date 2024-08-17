part of "package:on_chain/solidity/abi/abi.dart";

class SolidityAbiException extends BlockchainUtilsException {
  @override
  final Map<String, dynamic>? details;

  @override
  final String message;

  const SolidityAbiException(this.message, {this.details});
}
