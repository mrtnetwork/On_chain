import 'package:blockchain_utils/helper/helper.dart';
import 'package:on_chain/aptos/src/address/address/address.dart';
import 'package:on_chain/aptos/src/exception/exception.dart';
import 'package:on_chain/aptos/src/transaction/constants/const.dart';

class AptosTransactionUtils {
  // Generates a signing digest based on the transaction body and an optional flag to include additional data.
  // If 'withData' is true, the digest is appended with a data salt; otherwise, a standard salt is used.
  static List<int> generateSigningDigest(List<int> txBody,
      {bool withData = false}) {
    if (withData) {
      return [...AptosTransactionCost.rawTransactionWithDataSalt, ...txBody]
          .asImmutableBytes;
    }
    return [...AptosTransactionCost.rawTransactionSalt, ...txBody]
        .asImmutableBytes;
  }

  // Validates whether the input string is a valid Aptos identifier.
  // The identifier must start with a letter or underscore and can only contain letters, numbers, and underscores.
  static String validateIdentifier(String input) {
    RegExp regExp = RegExp(r'^[a-zA-Z_][a-zA-Z0-9_]*$');
    if (regExp.hasMatch(input)) return input;
    throw DartAptosPluginException(
        "Invalid Aptos identifier: An Aptos identifier must start with a letter or underscore and can only contain letters, numbers, and underscores.",
        details: {"identifier": input});
  }

  // Splits the input into module address and module name, validating their formats.
  // The input must be in the format 'module_address::module_name'.
  static (AptosAddress, String) getModuleIdPart(String input) {
    final parts = input.split("::");

    try {
      if (parts.length == 2) {
        final moduleAddress = AptosAddress(parts[0]);
        final moduleName = validateIdentifier(parts[1]);
        return (moduleAddress, moduleName);
      }
    } catch (_) {}
    throw DartAptosPluginException(
        "Invalid module ID format. The input must be in the format '0x1::module_name'");
  }

  static String validateFunction(String input) {
    final parts = input.split("::");
    if (parts.length == 3) {
      try {
        AptosAddress(parts[0]);
        validateIdentifier(parts[1]);
        validateFunction(parts[2]);
        return input;
      } catch (_) {}
    }
    throw DartAptosPluginException(
        "Invalid Function string. The input must be in the format '0x1::module_name::function_name'");
  }
}
