import 'package:on_chain/ada/src/models/metadata/core/metadata_json_schame.dart';

/// Configuration for metadata schema, specifying JSON schema and whether to use integers instead of big integers.
class MetadataSchemaConfig {
  /// The JSON schema to be used for metadata.
  final MetadataJsonSchema jsonSchema;

  /// Determines whether to use integers instead of big integers.
  final bool useIntInsteadBigInt;

  /// Constructs a MetadataSchemaConfig with the given JSON schema and integer preference.
  const MetadataSchemaConfig(
      {required this.jsonSchema, this.useIntInsteadBigInt = true});
}
