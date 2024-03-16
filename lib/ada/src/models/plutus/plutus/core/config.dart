import 'package:on_chain/ada/src/models/plutus/plutus/core/plutus_json_schame.dart';

/// Configuration for Plutus schema.
class PlutusSchemaConfig {
  /// The JSON schema for Plutus.
  final PlutusJsonSchema jsonSchema;

  /// Determines whether to use integers instead of big integers.
  final bool useIntInsteadBigInt;

  /// Constructs a [PlutusSchemaConfig].
  const PlutusSchemaConfig({
    required this.jsonSchema,
    this.useIntInsteadBigInt = true,
  });
}
