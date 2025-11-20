import 'package:on_chain/serialization/cbor/cbor_serialization.dart';
import 'package:on_chain/serialization/cbor/extension.dart';
import 'package:on_chain/solidity/abi/abi.dart';
import 'package:blockchain_utils/blockchain_utils.dart';

import 'fragments.dart';

/// Represents the ABI (Application Binary Interface) of a smart contract.
///
/// This class provides methods to create a ContractABI instance from JSON,
/// as well as access to different fragments of the contract ABI, such as
/// functions, events, fallbacks, constructors, and errors.
class ContractABI with InternalCborSerialization {
  ContractABI._(List<AbiBaseFragment> fragments)
      : fragments = fragments.immutable,
        functions = fragments.whereType<AbiFunctionFragment>().toImutableList,
        events = fragments.whereType<AbiEventFragment>().toImutableList,
        fallBacks = fragments.whereType<AbiFallbackFragment>().toImutableList,
        constractors =
            fragments.whereType<AbiConstructorFragment>().toImutableList,
        errors = fragments.whereType<AbiErrorFragment>().toImutableList;

  /// Factory method to create a ContractABI instance from JSON.
  factory ContractABI.fromJson(List<Map<String, dynamic>> abi) {
    try {
      final fragments = abi.map((e) {
        return AbiBaseFragment.fromJson(e);
      }).toList();
      return ContractABI._(fragments);
    } catch (e) {
      throw MessageException('invalid contract abi',
          details: {'error': e.toString()});
    }
  }
  factory ContractABI.deserialize({List<int>? cborBytes, CborObject? cbor}) {
    final values = QuickCborObject.cborTagValue(
        cborBytes: cborBytes,
        object: cbor,
        tags: InternalCborSerializationConst.defaultTag);
    return ContractABI._(
      values
          .elementAsListOf<CborTagValue>(0)
          .map((e) => AbiBaseFragment.deserialize(cbor: e))
          .toList(),
    );
  }

  final List<AbiBaseFragment> fragments;

  /// List of function fragments defined in the contract ABI.
  final List<AbiFunctionFragment> functions;

  /// List of event fragments defined in the contract ABI.
  final List<AbiEventFragment> events;

  /// List of fallback function fragments defined in the contract ABI.
  final List<AbiFallbackFragment> fallBacks;

  /// List of constructor fragments defined in the contract ABI.
  final List<AbiConstructorFragment> constractors;

  /// List of error fragments defined in the contract ABI.
  final List<AbiErrorFragment> errors;

  AbiReceiveFragment? get receiveFragment {
    return fragments.firstWhereNullable(
            (element) => element.type == FragmentTypes.receive)
        as AbiReceiveFragment?;
  }

  /// Retrieves a function fragment from the contract ABI based on its name.
  AbiFunctionFragment functionFromName(String name) =>
      functions.singleWhere((element) => element.name == name);

  /// Retrieves a function fragment from the contract ABI based on its name.
  AbiFunctionFragment? findFunctionFromName(String name) {
    try {
      return functions.singleWhere((element) => element.name == name);
    } on StateError {
      return null;
    }
  }

  /// Retrieves a function fragment from the contract ABI based from selector.
  AbiFunctionFragment functionFromSelector(List<int> selectorBytes) {
    final selector = selectorBytes.sublist(0, ABIConst.selectorLength);
    return functions.singleWhere(
        (element) => BytesUtils.bytesEqual(selector, element.selector));
  }

  /// Retrieves a function fragment from the contract ABI based from selector.
  AbiFunctionFragment functionFromSelectorHex(String selectorHex) {
    return functionFromSelector(BytesUtils.fromHexString(selectorHex));
  }

  AbiFunctionFragment? findFunctionFromSelector(List<int> selectorBytes) {
    try {
      final selector = selectorBytes.sublist(0, ABIConst.selectorLength);
      return functions.singleWhere(
          (element) => BytesUtils.bytesEqual(selector, element.selector));
    } on StateError {
      return null;
    }
  }

  /// Retrieves an error fragment from the contract ABI from selector.
  AbiErrorFragment errorFromSelector(String selectorHex) {
    final selector = BytesUtils.fromHexString(selectorHex)
        .sublist(0, ABIConst.selectorLength);
    return errors.singleWhere(
        (element) => BytesUtils.bytesEqual(selector, element.selector));
  }

  /// Retrieves a event fragment from the contract ABI based from selector.
  AbiEventFragment eventFromName(String name) {
    return events.singleWhere((element) => element.name == name);
  }

  /// Retrieves a event fragment from the contract ABI based from selector.
  AbiEventFragment? tryEventFromName(String name) {
    try {
      return events.singleWhere((element) => element.name == name);
    } on StateError {
      return null;
    }
  }

  /// Retrieves a event fragment from the contract ABI based from selector.
  AbiEventFragment eventFromSignature(String singature) {
    return events.singleWhere(
        (element) => StringUtils.hexEqual(singature, element.signatureHex));
  }

  /// Retrieves a event fragment from the contract ABI based from selector.
  AbiEventFragment? tryEventFromSignature(String singature) {
    try {
      return events.singleWhere(
          (element) => StringUtils.hexEqual(singature, element.signatureHex));
    } on StateError {
      return null;
    }
  }

  /// solidity revert Error fragment
  static final revert = AbiErrorFragment(
      name: 'Error',
      inputs: [const AbiParameter(name: 'message', type: 'string')]);

  /// Decodes the error data based on the error fragment in the contract ABI.
  List<dynamic>? decodeError(dynamic error) {
    try {
      if (error is String) {
        final inBytes = BytesUtils.fromHexString(error);
        final errorSelector = inBytes.sublist(0, ABIConst.selectorLength);
        if (BytesUtils.bytesEqual(errorSelector, revert.selector)) {
          return revert.decodeError(inBytes);
        }
        final errorFragment = errors.singleWhere((element) =>
            BytesUtils.bytesEqual(element.selector, errorSelector));

        return errorFragment.decodeError(inBytes);
      }
    } catch (e) {
      return null;
    }
    return null;
  }

  @override
  List<Map<String, dynamic>> toJson() {
    return fragments.map((e) => e.toJson()).toList();
  }

  @override
  CborTagValue<CborListValue> toCbor() {
    return CborTagValue(
        CborListValue.definite([
          CborListValue.definite(fragments.map((e) => e.toCbor()).toList())
        ].cast()),
        InternalCborSerializationConst.defaultTag);
  }
}
