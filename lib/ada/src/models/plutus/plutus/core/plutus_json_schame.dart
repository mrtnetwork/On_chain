/// Represents different types of Plutus JSON schemas.
class PlutusJsonSchema {
  /// The numeric value representing the schema.
  final int value;

  /// The name of the schema.
  final String name;

  /// Constructs a [PlutusJsonSchema].
  const PlutusJsonSchema._(this.value, this.name);

  /// A basic schema for Plutus JSON.
  static const PlutusJsonSchema basicConversions =
      PlutusJsonSchema._(0, "BasicConversions");

  /// A detailed schema for Plutus JSON.
  static const PlutusJsonSchema detailedSchema =
      PlutusJsonSchema._(1, "DetailedSchema");

  @override
  String toString() {
    return "PlutusJsonScheme.$name";
  }
}
