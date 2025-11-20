import 'package:blockchain_utils/cbor/cbor.dart';

import 'package:on_chain/ada/src/exception/exception.dart';
import 'package:on_chain/serialization/cbor_serialization.dart';

/// Represents the type of data included in a transaction option with serialization support.
class TransactionDataOptionType with InternalCborSerialization {
  /// The numeric value of the option type.
  final int value;

  /// The name of the option type.
  final String name;

  /// Constructs a TransactionDataOptionType object with the specified value and name.
  const TransactionDataOptionType._(this.value, this.name);

  /// Option type for data hash.
  static const TransactionDataOptionType dataHash =
      TransactionDataOptionType._(0, 'DataHash');

  /// Option type for data.
  static const TransactionDataOptionType data =
      TransactionDataOptionType._(1, 'Data');

  /// List of all available option types.
  static const List<TransactionDataOptionType> values = [dataHash, data];

  @override
  String toString() {
    return 'TransactionDataOptionType.$name';
  }

  @override
  CborObject toCbor() {
    return CborIntValue(value);
  }

  /// Deserializes a TransactionDataOptionType object from its CBOR representation.
  factory TransactionDataOptionType.deserialize(CborIntValue cbor,
      {TransactionDataOptionType? validate}) {
    final type = fromValue(cbor.value);
    if (validate != null && validate != type) {
      throw ADAPluginException('Invalid TransactionDataOptionType.',
          details: {'expected': validate, 'Type': type});
    }
    return type;
  }

  /// Returns the TransactionDataOptionType corresponding to the specified value.
  static TransactionDataOptionType fromValue(int? value) {
    return values.firstWhere(
      (element) => element.value == value,
      orElse: () => throw ADAPluginException(
          'No TransactionDataOptionType found matching the specified value',
          details: {'value': value}),
    );
  }

  static TransactionDataOptionType fromName(String? name) {
    return values.firstWhere(
      (element) => element.name == name,
      orElse: () => throw ADAPluginException(
          'No TransactionDataOptionType found matching the specified name',
          details: {'name': name}),
    );
  }

  @override
  String toJson() {
    return name;
  }
}
