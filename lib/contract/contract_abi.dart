import 'package:on_chain/abi/abi.dart';
import 'package:blockchain_utils/blockchain_utils.dart';

import 'fragments.dart';

/// Represents the ABI (Application Binary Interface) of a smart contract.
///
/// This class provides methods to create a ContractABI instance from JSON,
/// as well as access to different fragments of the contract ABI, such as
/// functions, events, fallbacks, constructors, and errors.
class ContractABI {
  ContractABI._(this.fragments);

  /// Factory method to create a ContractABI instance from JSON.
  factory ContractABI.fromJson(List<Map<String, dynamic>> abi,
      {bool isTron = false}) {
    try {
      final fragments = abi.map((e) {
        return AbiBaseFragment.fromJson(e, isTron);
      }).toList();
      return ContractABI._(fragments);
    } catch (e) {
      throw MessageException("invalid contract abi", details: {"input": abi});
    }
  }

  final List<AbiBaseFragment> fragments;

  /// List of function fragments defined in the contract ABI.
  late final List<AbiFunctionFragment> functions =
      fragments.whereType<AbiFunctionFragment>().toList();

  /// List of event fragments defined in the contract ABI.
  late final List<AbiEventFragment> events =
      fragments.whereType<AbiEventFragment>().toList();

  /// List of fallback function fragments defined in the contract ABI.
  late final List<AbiFallbackFragment> fallBacks =
      fragments.whereType<AbiFallbackFragment>().toList();

  /// List of constructor fragments defined in the contract ABI.
  late final List<AbiConstructorFragment> constractors =
      fragments.whereType<AbiConstructorFragment>().toList();

  /// List of error fragments defined in the contract ABI.
  late final List<AbiErrorFragment> errors =
      fragments.whereType<AbiErrorFragment>().toList();

  AbiReceiveFragment? get receiveFragment {
    try {
      return fragments
              .firstWhere((element) => element.type == FragmentTypes.receive)
          as AbiReceiveFragment?;
    } on StateError {
      return null;
    }
  }

  /// Retrieves a function fragment from the contract ABI based on its name.
  AbiFunctionFragment functionFromName(String name) =>
      functions.singleWhere((element) => element.name == name);

  /// Retrieves a function fragment from the contract ABI based from selector.
  AbiFunctionFragment functionFromSelector(String selectorHex) {
    final selector = BytesUtils.fromHexString(selectorHex)
        .sublist(0, ABIConst.selectorLength);
    return functions
        .singleWhere((element) => bytesEqual(selector, element.selector));
  }

  /// Retrieves an error fragment from the contract ABI from selector.
  AbiErrorFragment errorFromSelector(String selectorHex) {
    final selector = BytesUtils.fromHexString(selectorHex)
        .sublist(0, ABIConst.selectorLength);
    return errors
        .singleWhere((element) => bytesEqual(selector, element.selector));
  }

  /// solidity revert Error fragment
  static final revert = AbiErrorFragment(
      name: "Error",
      inputs: [const AbiParameter(name: "message", type: "string")]);

  /// Decodes the error data based on the error fragment in the contract ABI.
  List<dynamic>? decodeError(dynamic error) {
    try {
      if (error is String) {
        final inBytes = BytesUtils.fromHexString(error);
        final errorSelector = inBytes.sublist(0, ABIConst.selectorLength);
        if (bytesEqual(errorSelector, revert.selector)) {
          return revert.decodeError(inBytes);
        }
        final errorFragment = errors.singleWhere(
            (element) => bytesEqual(element.selector, errorSelector));

        return errorFragment.decodeError(inBytes);
      }
    } catch (e) {
      return null;
    }
    return null;
  }
}
