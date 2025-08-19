import 'package:blockchain_utils/cbor/cbor.dart';
import 'package:on_chain/ada/src/exception/exception.dart';
import 'package:on_chain/ada/src/serialization/cbor_serialization.dart';

/// Represents a type of transaction metadata with serialization support.
class TransactionMetadataType with ADASerialization {
  /// The integer value representing the metadata type.
  final int value;

  /// The name of the metadata type.
  final String name;

  /// Constructs a TransactionMetadataType object with the given value and name.
  const TransactionMetadataType._(this.value, this.name);

  /// Represents metadata type for a metadata map.
  static const TransactionMetadataType metadataMap =
      TransactionMetadataType._(0, 'Map');

  /// Represents metadata type for a metadata list.
  static const TransactionMetadataType metadataList =
      TransactionMetadataType._(1, 'List');

  /// Represents metadata type for an integer metadata.
  static const TransactionMetadataType metadataInt =
      TransactionMetadataType._(2, 'Int');

  /// Represents metadata type for a metadata bytes.
  static const TransactionMetadataType metadataBytes =
      TransactionMetadataType._(3, 'Bytes');

  /// Represents metadata type for a metadata text.
  static const TransactionMetadataType metadataText =
      TransactionMetadataType._(4, 'String');

  static const List<TransactionMetadataType> values = [
    metadataMap,
    metadataList,
    metadataInt,
    metadataBytes,
    metadataText
  ];

  static TransactionMetadataType fromName(String? name) {
    return values.firstWhere(
      (element) => element.name == name,
      orElse: () => throw ADAPluginException(
          'No TransactionMetadataType found matching the specified name',
          details: {'name': name}),
    );
  }

  @override
  String toString() {
    return 'TransactionMetadataType.$name';
  }

  @override
  CborObject toCbor() {
    return CborSignedValue.i32(value);
  }

  @override
  String toJson() {
    return name;
  }
}
