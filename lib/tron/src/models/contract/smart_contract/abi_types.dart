import 'package:on_chain/tron/src/exception/exception.dart';
import 'package:on_chain/tron/src/models/contract/base_contract/common.dart';

/// Enum representing different types of entries in a smart contract's ABI (Application Binary Interface).
///
/// Each entry type has a unique [value] associated with it and a [name] for identification.
/// The available entry types are:
/// - [unknownEntryType]: Represents an unknown entry type with a value of 0 and an empty name.
/// - [constructor]: Represents a constructor entry type with a value of 1 and the name "Constructor".
/// - [function]: Represents a function entry type with a value of 2 and the name "Function".
/// - [event]: Represents an event entry type with a value of 3 and the name "Event".
/// - [fallback]: Represents a fallback entry type with a value of 4 and the name "Fallback".
/// - [receive]: Represents a receive entry type with a value of 5 and the name "Receive".
/// - [error]: Represents an error entry type with a value of 6 and the name "Error".
///
class SmartContractAbiEntryType implements TronEnumerate {
  /// Internal constructor to create a [SmartContractAbiEntryType] instance.
  const SmartContractAbiEntryType._(this.value, this.name);
  @override
  final int value;

  /// The name associated with the ABI entry type.
  final String name;

  /// Represents an unknown entry type.
  static const SmartContractAbiEntryType unknownEntryType =
      SmartContractAbiEntryType._(0, '');

  /// Represents a constructor entry type.
  static const SmartContractAbiEntryType constructor =
      SmartContractAbiEntryType._(1, 'Constructor');

  /// Represents a function entry type.
  static const SmartContractAbiEntryType function =
      SmartContractAbiEntryType._(2, 'Function');

  /// Represents an event entry type.
  static const SmartContractAbiEntryType event =
      SmartContractAbiEntryType._(3, 'Event');

  /// Represents a fallback entry type.
  static const SmartContractAbiEntryType fallback =
      SmartContractAbiEntryType._(4, 'Fallback');

  /// Represents a receive entry type.
  static const SmartContractAbiEntryType receive =
      SmartContractAbiEntryType._(5, 'Receive');

  /// Represents an error entry type.
  static const SmartContractAbiEntryType error =
      SmartContractAbiEntryType._(6, 'Error');

  /// List of all available ABI entry types.
  static const List<SmartContractAbiEntryType> values =
      <SmartContractAbiEntryType>[
    unknownEntryType,
    constructor,
    function,
    event,
    fallback,
    receive,
    error,
  ];

  /// Returns the [SmartContractAbiEntryType] associated with the given [name].
  ///
  /// Case-insensitive matching is performed.
  static SmartContractAbiEntryType fromName(String name) {
    return values.firstWhere(
      (element) => element.name.toLowerCase() == name.toLowerCase(),
      orElse: () => throw const TronPluginException(
          "SmartContractAbiEntryType was not found."),
    );
  }

  static SmartContractAbiEntryType fromValue(int? value,
      {SmartContractAbiEntryType? orElese}) {
    return values.firstWhere((element) => element.value == value, orElse: () {
      if (orElese != null) return orElese;
      throw const TronPluginException(
          "SmartContractAbiEntryType was not found.");
    });
  }

  @override
  String toString() {
    return name;
  }
}

/// Enum representing different state mutability types in a smart contract's ABI (Application Binary Interface).
///
/// Each mutability type has a unique [value] associated with it and a [name] for identification.
/// The available mutability types are:
/// - [unknownMutabilityType]: Represents an unknown state mutability type with a value of 0 and the name "UnknownMutabilityType".
/// - [pure]: Represents a pure state mutability type with a value of 1 and the name "Pure".
/// - [view]: Represents a view state mutability type with a value of 2 and the name "View".
/// - [nonpayable]: Represents a nonpayable state mutability type with a value of 3 and the name "Nonpayable".
/// - [payable]: Represents a payable state mutability type with a value of 4 and the name "Payable".
class SmartContractAbiStateMutabilityType implements TronEnumerate {
  /// Internal constructor to create a [SmartContractAbiStateMutabilityType] instance.
  const SmartContractAbiStateMutabilityType._(this.value, this.name);

  /// The name associated with the state mutability type.
  final String name;

  @override
  final int value;

  /// Represents an unknown state mutability type.
  static const SmartContractAbiStateMutabilityType unknownMutabilityType =
      SmartContractAbiStateMutabilityType._(0, 'UnknownMutabilityType');

  /// Represents a pure state mutability type.
  static const SmartContractAbiStateMutabilityType pure =
      SmartContractAbiStateMutabilityType._(1, 'Pure');

  /// Represents a view state mutability type.
  static const SmartContractAbiStateMutabilityType view =
      SmartContractAbiStateMutabilityType._(2, 'View');

  /// Represents a nonpayable state mutability type.
  static const SmartContractAbiStateMutabilityType nonpayable =
      SmartContractAbiStateMutabilityType._(3, 'Nonpayable');

  /// Represents a payable state mutability type.
  static const SmartContractAbiStateMutabilityType payable =
      SmartContractAbiStateMutabilityType._(4, 'Payable');

  /// List of all available state mutability types.
  static const List<SmartContractAbiStateMutabilityType> values =
      <SmartContractAbiStateMutabilityType>[
    unknownMutabilityType,
    pure,
    view,
    nonpayable,
    payable,
  ];

  /// Returns the [SmartContractAbiStateMutabilityType] associated with the given [name].
  ///
  /// Case-insensitive matching is performed.
  static SmartContractAbiStateMutabilityType fromName(String name) {
    return values.firstWhere(
        (element) => element.name.toLowerCase() == name.toLowerCase(),
        orElse: () {
      throw const TronPluginException(
          "SmartContractAbiStateMutabilityType was not found.");
    });
  }

  static SmartContractAbiStateMutabilityType fromValue(int? value,
      {SmartContractAbiStateMutabilityType? orElese}) {
    return values.firstWhere((element) => element.value == value, orElse: () {
      if (orElese != null) return orElese;
      throw const TronPluginException(
          "SmartContractAbiStateMutabilityType was not found.");
    });
  }

  @override
  String toString() {
    return name;
  }
}
