import 'package:blockchain_utils/blockchain_utils.dart';
import 'package:on_chain/ada/ada.dart';
import 'package:test/test.dart';

void main() {
  _metadataFromJson();
  _basicConvertion();
  _detailedSchema();
  _auxiliaryData();
}

String _encodeDecodeCheck(List<PlutusScript> scripts,
    {AuxiliaryDataCborEncoding encoding =
        AuxiliaryDataCborEncoding.conwayEra}) {
  final metadata = GeneralTransactionMetadata(metadata: {
    BigInt.from(42): TransactionMetadata.fromJsonSchema(
        json: StringUtils.toJson('{ "test": 148 }'),
        jsonSchema: MetadataJsonSchema.basicConversions)
  });
  final aux = AuxiliaryData(
      metadata: metadata,
      nativeScripts: [NativeScriptTimelockStart(BigInt.from(1234556))],
      plutusScripts: scripts,
      encoding: encoding);
  expect(aux.serializeHex(),
      AuxiliaryData.fromCborBytes(aux.serialize()).serializeHex());
  return aux.serializeHex();
}

void _metadataFromJson() {
  test('TransactionMetadata_noConversions', () {
    final decode = StringUtils.toJson(
        '{"receiver_id": "SJKdj34k3jjKFDKfjFUDfdjkfd","sender_id": "jkfdsufjdk34h3Sdfjdhfduf873","comment": "happy birthday","tags": [0, 264, -1024, 32]}');
    final metadata = TransactionMetadata.fromJsonSchema(
        json: decode, jsonSchema: MetadataJsonSchema.noConversions);
    expect(
        metadata.toJsonSchema(
            config: const MetadataSchemaConfig(
                jsonSchema: MetadataJsonSchema.noConversions)),
        decode);
    expect(metadata.toCbor(sort: true).toCborHex(),
        'a467636f6d6d656e746e68617070792062697274686461796b72656365697665725f6964781a534a4b646a33346b336a6a4b46444b666a46554466646a6b66646973656e6465725f6964781b6a6b66647375666a646b333468335364666a646866647566383733647461677384001901083903ff1820');

    final deserialize = TransactionMetadata.fromCborBytes(metadata.serialize());
    expect(deserialize.serializeHex(), metadata.serializeHex());
  });
}

void _basicConvertion() {
  test('TransactionMetadata_basicConversions', () {
    final decode = StringUtils.toJson(
        '{"0x8badf00d": "0xdeadbeef","9": 5,"obj": {"a":[{"5": 2},{}]}}');
    final metadata = TransactionMetadata.fromJsonSchema(
        json: decode, jsonSchema: MetadataJsonSchema.basicConversions);
    expect(
        metadata.toJsonSchema(
            config: const MetadataSchemaConfig(
                jsonSchema: MetadataJsonSchema.basicConversions)),
        decode);
    expect(
        metadata.toCbor(sort: true).toCborHex(),

        /// a30905448badf00d44deadbeef636f626aa1616182a10502a0
        'a3448badf00d44deadbeef0905636f626aa1616182a10502a0');

    // final deserialize = TransactionMetadata.fromCborBytes(metadata.serialize());
    // expect(deserialize.serializeHex(), metadata.serializeHex());
  });
}

void _detailedSchema() {
  test('TransactionMetadata_detailedSchema', () {
    final decode = StringUtils.toJson('''{"map":[
            {
                "k":{"bytes":"8badf00d"},
                "v":{"bytes":"deadbeef"}
            },
            {
                "k":{"int":9},
                "v":{"int":5}
            },
            {
                "k":{"string":"obj"},
                "v":{"map":[
                    {
                        "k":{"string":"a"},
                        "v":{"list":[
                        {"map":[
                            {
                                "k":{"int":5},
                                "v":{"int":2}
                            }
                            ]},
                            {"map":[
                            ]}
                        ]}
                    }
                ]}
            }
        ]}''');
    final metadata = TransactionMetadata.fromJsonSchema(
        json: decode, jsonSchema: MetadataJsonSchema.detailedSchema);
    expect(
        decode,
        metadata.toJsonSchema(
            config: const MetadataSchemaConfig(
                jsonSchema: MetadataJsonSchema.detailedSchema)));

    expect(metadata.serializeHex(),
        'a3448badf00d44deadbeef0905636f626aa1616182a10502a0');

    final deserialize = TransactionMetadata.fromCborBytes(metadata.serialize());
    expect(deserialize.serializeHex(), metadata.serializeHex());
  });
  test('TransactionMetadata_detailedSchema', () {
    final decode = StringUtils.toJson('''{"map":[
            {
            "k":{"list":[
                {"map": [
                    {
                        "k": {"int": 5},
                        "v": {"int": -7}
                    },
                    {
                        "k": {"string": "hello"},
                        "v": {"string": "world"}
                    }
                ]},
                {"bytes": "ff00ff00"}
            ]},
            "v":{"int":5}
            }
        ]}''');
    final metadata = TransactionMetadata.fromJsonSchema(
        json: decode, jsonSchema: MetadataJsonSchema.detailedSchema);
    expect(
        decode,
        metadata.toJsonSchema(
            config: const MetadataSchemaConfig(
                jsonSchema: MetadataJsonSchema.detailedSchema)));

    expect(metadata.serializeHex(),
        'a182a205266568656c6c6f65776f726c6444ff00ff0005');

    final deserialize = TransactionMetadata.fromCborBytes(metadata.serialize());
    expect(deserialize.serializeHex(), metadata.serializeHex());
  });
}

void _auxiliaryData() {
  test('AuxiliaryData', () {
    final gmd = GeneralTransactionMetadata(metadata: {
      BigInt.from(100): const TransactionMetadataText(value: 'string md')
    });
    AuxiliaryData aux = AuxiliaryData();
    // expect(aux.serializeHex(), 'd90103a0');

    expect(AuxiliaryData.fromCborBytes(aux.serialize()).serializeHex(),
        aux.serializeHex());

    aux = AuxiliaryData(
        metadata: gmd, encoding: AuxiliaryDataCborEncoding.shellyEra);

    expect(aux.serializeHex(), 'a1186469737472696e67206d64');
    expect(AuxiliaryData.fromCborBytes(aux.serialize()).serializeHex(),
        aux.serializeHex());

    final native = NativeScriptTimelockStart(BigInt.from(20));
    aux = AuxiliaryData(
        metadata: gmd,
        nativeScripts: [native],
        encoding: AuxiliaryDataCborEncoding.alonzoEra);
    expect(aux.serializeHex(), '82a1186469737472696e67206d6481820414');
    expect(AuxiliaryData.fromCborBytes(aux.serialize()).serializeHex(),
        aux.serializeHex());
    final plutusScript = PlutusScript(
        bytes: List<int>.filled(29, 61), language: Language.plutusV1);
    aux = AuxiliaryData(
        metadata: gmd,
        nativeScripts: [native],
        plutusScripts: [plutusScript],
        encoding: AuxiliaryDataCborEncoding.conwayEra);
    expect(aux.serializeHex(),
        'd90103a300a1186469737472696e67206d6401818204140281581d3d3d3d3d3d3d3d3d3d3d3d3d3d3d3d3d3d3d3d3d3d3d3d3d3d3d3d3d3d');
    expect(AuxiliaryData.fromCborBytes(aux.serialize()).serializeHex(),
        aux.serializeHex());
    final plutusScriptv2 = PlutusScript(
        bytes: List<int>.filled(29, 61), language: Language.plutusV2);
    aux = AuxiliaryData(
        metadata: gmd,
        nativeScripts: [native],
        plutusScripts: [plutusScript, plutusScriptv2],
        encoding: AuxiliaryDataCborEncoding.alonzoEra);
    expect(AuxiliaryData.fromCborBytes(aux.serialize()).serializeHex(),
        aux.serializeHex());
  });
  test('AuxiliaryData_2', () {
    AuxiliaryData aux = AuxiliaryData.fromCborBytes(
        BytesUtils.fromHexString('d90103a100a1186469737472696e67206d64'));
    expect(aux.serializeHex(), 'd90103a100a1186469737472696e67206d64');
    aux = AuxiliaryData.fromCborBytes(
        BytesUtils.fromHexString('a1186469737472696e67206d64'));
    expect(aux.serializeHex(), 'a1186469737472696e67206d64');
  });
  test('TransactionMetadata_1', () {
    final bytes = BytesUtils.fromHexString('4e4d01000033222220051200120011');
    final plutusV1 =
        PlutusScript.deserialize(CborObject.fromCbor(bytes) as CborBytesValue);
    final plutusV2 = PlutusScript.deserialize(
        CborObject.fromCbor(bytes) as CborBytesValue,
        language: Language.plutusV2);
    final auxOne = _encodeDecodeCheck([]);
    expect(auxOne, 'd90103a300a1182aa164746573741894018182041a0012d67c0280');
    final auxTwo = _encodeDecodeCheck([plutusV1]);
    expect(auxTwo,
        'd90103a300a1182aa164746573741894018182041a0012d67c02814e4d01000033222220051200120011');
    final auxThree = _encodeDecodeCheck([plutusV2]);
    expect(auxThree,
        'd90103a400a1182aa164746573741894018182041a0012d67c028003814e4d01000033222220051200120011');
    final auxFour = _encodeDecodeCheck([plutusV1, plutusV2]);
    expect(auxFour,
        'd90103a400a1182aa164746573741894018182041a0012d67c02814e4d0100003322222005120012001103814e4d01000033222220051200120011');
  });
}
