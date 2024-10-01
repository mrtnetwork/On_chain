part of "package:on_chain/solidity/abi/abi.dart";

class SolidityAbiException extends BlockchainUtilsException {
  const SolidityAbiException(String message, {Map<String, dynamic>? details})
      : super(message, details: details);
}
