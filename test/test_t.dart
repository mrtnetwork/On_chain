import 'package:blockchain_utils/binary/utils.dart';
import 'package:on_chain/ada/src/models/metadata/core/config.dart';
import 'package:on_chain/ada/src/models/metadata/core/metadata_json_schame.dart';
import 'package:on_chain/ada/src/models/metadata/core/tranasction_metadata.dart';

void main() {


  final deserialize = TransactionMetadata.fromCborBytes(
      BytesUtils.fromHexString(
          "a182a205266568656c6c6f65776f726c6444ff00ff0005"));

  /// {map: [{k: {list: [{map: [{k: {int: 5}, v: {int: 4294967289}}, {k: {string: hello}, v: {string: world}}]}, {bytes: ff00ff00}]}, v: {int: 5}}]}
  /// {map: [{k: {list: [{map: [{k: {int: 5}, v: {int: -7}}, {k: {string: hello}, v: {string: world}}]}, {bytes: ff00ff00}]}, v: {int: 5}}]}

  print(deserialize.toJsonSchema(
      config:
          MetadataSchemaConfig(jsonSchema: MetadataJsonSchema.detailedSchema)));
}
