/// An abstract class representing an enumeration in the Tron protocol.
///
/// Classes extending this abstract class should implement the [value] property,
/// which represents the unique value associated with each enumeration instance.
abstract class TronEnumerate {
  /// The unique value associated with each enumeration instance.
  abstract final int value;
}

/// Enum representing different resource codes within the Tron protocol.
///
/// Each resource code has a unique [value] associated with it and a [name] for identification.
/// The available resource codes are:
/// - [bandWidth]: Represents bandwidth as a resource code.
/// - [energy]: Represents energy as a resource code.
/// - [tronPower]: Represents Tron Power as a resource code.
///
class ResourceCode implements TronEnumerate {
  /// Internal constructor to create a [ResourceCode] instance.
  const ResourceCode._(this.name, this.value);
  @override
  final int value;

  /// The name associated with the resource code.
  final String name;

  /// Represents bandwidth as a resource code.
  static const ResourceCode bandWidth = ResourceCode._("BANDWIDTH", 0);

  /// Represents energy as a resource code.
  static const ResourceCode energy = ResourceCode._("ENERGY", 1);

  /// Represents Tron Power as a resource code.
  static const ResourceCode tronPower = ResourceCode._("TRON_POWER", 2);

  /// List of all available resource codes.
  static const List<ResourceCode> values = [bandWidth, energy, tronPower];

  /// Returns the [ResourceCode] associated with the given [name].
  ///
  /// Returns `null` if no match is found.
  static ResourceCode? fromName(String? name, {ResourceCode? orElse}) {
    try {
      return values.firstWhere(
        (element) => element.name == name,
        orElse: orElse == null ? null : () => orElse,
      );
    } on StateError {
      return null;
    }
  }

  /// Returns the [ResourceCode] associated with the given [value].
  ///
  /// Throws an error if no match is found.
  static ResourceCode fromValue(int val) {
    return values.firstWhere((element) => element.value == val);
  }

  @override
  String toString() {
    return name;
  }
}
