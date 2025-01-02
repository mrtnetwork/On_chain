import 'package:blockchain_utils/blockchain_utils.dart';
import 'package:on_chain/ada/ada.dart';
import 'package:test/test.dart';

void main() {
  group('plutus', () {
    _constrPlutusDataHash();
    _plutusData();
    _witnessSetWithPlutus();
    _plutusDataBasicJson();
    _plutusDataDetailedSerialization();
    _costModelViewEncoding();
    _scriptHash();
    _redeemer();
    _plutusDataHash();
    _plutusDataFromAddress();
  });
}

void _constrPlutusDataHash() {
  test('ConstrPlutusData hash', () {
    final constr =
        ConstrPlutusData(alternative: BigInt.zero, data: PlutusList([]));
    expect(BytesUtils.toHexString(constr.toHash().data),
        '923918e403bf43c34b4ef6b48eb2ee04babed17320d8d1b9ff9ad086e86f44ec');
  });
}

void _plutusData() {
  test('PlutusData_Serialization_1', () {
    final plutusBytes = BytesUtils.fromHexString(
        'd8799f4100d8799fd8799fd8799f581cffffffffffffffffffffffffffffffffffffffffffffffffffffffffffd8799fd8799fd8799f581cffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffd87a80ff1a002625a0d8799fd879801a000f4240d87a80ffff');
    final plutus = PlutusData.fromCborBytes(plutusBytes);
    expect(plutus.serialize(), plutusBytes);
    final decode = PlutusData.fromCborBytes(plutus.serialize());
    expect(decode.serialize(), plutus.serialize());
  });
  test('PlutusData_2', () {
    final plutus = PlutusList([]);
    expect(plutus.serializeHex(), '80');
  });
  test('PlutusData_3', () {
    final plutus = PlutusList([PlutusInteger(BigInt.one)]);
    expect(plutus.serializeHex(), '9f01ff');
    final decode = PlutusData.fromCborBytes(plutus.serialize());
    expect(decode.serialize(), plutus.serialize());
  });
  test('PlutusData_4', () {
    final plutusBytes = BytesUtils.fromHexString(
        '81d8799f581ce1cbb80db89e292269aeb93ec15eb963dda5176b66949fe1c2a6a38da140a1401864ff');
    final plutus = PlutusData.fromCborBytes(plutusBytes);
    expect(plutus.serialize(), plutusBytes);
    final decode = PlutusData.fromCborBytes(plutus.serialize());
    expect(decode.serialize(), plutusBytes);
  });
  test('PlutusData_5', () {
    final plutusData = PlutusList([
      ConstrPlutusData(
          alternative: BigInt.zero,
          data: PlutusList([
            ConstrPlutusData(
                alternative: BigInt.zero,
                data: PlutusList([
                  PlutusBytes(
                      value: BytesUtils.fromHexString(
                          'A183BF86925F66C579A3745C9517744399679B090927B8F6E2F2E1BB')),
                  PlutusBytes(
                      value: BytesUtils.fromHexString(
                          '6164617065416D616E734576616E73')),
                ])),
            ConstrPlutusData(
                alternative: BigInt.zero,
                data: PlutusList([
                  PlutusBytes(
                      value: BytesUtils.fromHexString(
                          '9A4E855293A0B9AF5E50935A331D83E7982AB5B738EA0E6FC0F9E656')),
                  PlutusBytes(
                      value: BytesUtils.fromHexString(
                          '4652414D455F38333030325F4C30')),
                ])),
            PlutusBytes(
                value: BytesUtils.fromHexString(
                    'BEA1C521DF58F4EEEF60C647E5EBD88C6039915409F9FD6454A476B9')),
          ]))
    ]);
    expect(plutusData.serializeHex(),
        '9fd8799fd8799f581ca183bf86925f66c579a3745c9517744399679b090927b8f6e2f2e1bb4f6164617065416d616e734576616e73ffd8799f581c9a4e855293a0b9af5e50935a331d83e7982ab5b738ea0e6fc0f9e6564e4652414d455f38333030325f4c30ff581cbea1c521df58f4eeef60c647e5ebd88c6039915409f9fd6454a476b9ffff');
    final decode = PlutusData.fromCborBytes(plutusData.serialize());
    expect(decode.serialize(), plutusData.serialize());
  });
}

void _witnessSetWithPlutus() {
  test('TransactionWitnessSet with plutus data serialization', () {
    PlutusList plutusList = PlutusList([PlutusInteger(BigInt.one)]);
    TransactionWitnessSet witness =
        TransactionWitnessSet(plutusData: plutusList);
    expect(witness.serializeHex(), 'a1049f01ff');
    final plutusBytes = BytesUtils.fromHexString(
        'd8799f4100d8799fd8799fd8799f581cffffffffffffffffffffffffffffffffffffffffffffffffffffffffffd8799fd8799fd8799f581cffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffd87a80ff1a002625a0d8799fd879801a000f4240d87a80ffff');
    final plutus = PlutusData.fromCborBytes(plutusBytes);
    plutusList = PlutusList([plutus]);
    witness = TransactionWitnessSet(plutusData: plutusList);
    expect(witness.serializeHex(),
        'a1049fd8799f4100d8799fd8799fd8799f581cffffffffffffffffffffffffffffffffffffffffffffffffffffffffffd8799fd8799fd8799f581cffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffd87a80ff1a002625a0d8799fd879801a000f4240d87a80ffffff');
    final decode = TransactionWitnessSet.fromCborBytes(witness.serialize());
    expect(decode.serialize(), witness.serialize());
  });
}

void _plutusDataBasicJson() {
  test('PlutusData_BasicJson_Serialization_1', () {
    final plutusJson = StringUtils.toJson('''{
            "5": "some utf8 string",
            "0xdeadbeef": [
                {"reg string": {}},
                -9
            ]
        }''');
    final fromJson = PlutusData.fromJsonSchema(
        json: plutusJson, schema: PlutusJsonSchema.basicConversions);
    expect(
        fromJson.toJsonSchema(
            config: const PlutusSchemaConfig(
                jsonSchema: PlutusJsonSchema.basicConversions)),
        plutusJson);
    expect(fromJson.serializeHex(),
        'a244deadbeef9fa14a72656720737472696e67a028ff0550736f6d65207574663820737472696e67');
  });
}

void _plutusDataDetailedSerialization() {
  test('PlutusData_Detailed_Serialization_1', () {
    final plutusJson = StringUtils.toJson('''{"list": [
            {"map": [
                {"k": {"bytes": "deadbeef"}, "v": {"int": 42}},
                {"k": {"map" : [
                    {"k": {"int": 9}, "v": {"int": -5}}
                ]}, "v": {"list": []}}
            ]},
            {"bytes": "cafed00d"},
            {"constructor": 0, "fields": [
                {"map": []},
                {"int": 23}
            ]}
        ]}''');
    final PlutusList fromJson = PlutusData.fromJsonSchema(
        json: plutusJson,
        schema: PlutusJsonSchema.detailedSchema) as PlutusList;
    expect(
        fromJson.toJsonSchema(
            config: const PlutusSchemaConfig(
                jsonSchema: PlutusJsonSchema.detailedSchema)),
        plutusJson);
    expect(fromJson.serializeHex(),
        '9fa244deadbeef182aa109248044cafed00dd8799fa017ffff');
    final deserialize = PlutusData.fromCborBytes(fromJson.serialize());
    expect(
        deserialize.toJsonSchema(
            config: const PlutusSchemaConfig(
                jsonSchema: PlutusJsonSchema.detailedSchema)),
        plutusJson);
    expect(deserialize.serializeHex(), fromJson.serializeHex());
  });
}

void _costModelViewEncoding() {
  test('cont model view encoding', () {
    final List<int> costModelValues = [
      197209,
      0,
      1,
      1,
      396231,
      621,
      0,
      1,
      150000,
      1000,
      0,
      1,
      150000,
      32,
      2477736,
      29175,
      4,
      29773,
      100,
      29773,
      100,
      29773,
      100,
      29773,
      100,
      29773,
      100,
      29773,
      100,
      100,
      100,
      29773,
      100,
      150000,
      32,
      150000,
      32,
      150000,
      32,
      150000,
      1000,
      0,
      1,
      150000,
      32,
      150000,
      1000,
      0,
      8,
      148000,
      425507,
      118,
      0,
      1,
      1,
      150000,
      1000,
      0,
      8,
      150000,
      112536,
      247,
      1,
      150000,
      10000,
      1,
      136542,
      1326,
      1,
      1000,
      150000,
      1000,
      1,
      150000,
      32,
      150000,
      32,
      150000,
      32,
      1,
      1,
      150000,
      1,
      150000,
      4,
      103599,
      248,
      1,
      103599,
      248,
      1,
      145276,
      1366,
      1,
      179690,
      497,
      1,
      150000,
      32,
      150000,
      32,
      150000,
      32,
      150000,
      32,
      150000,
      32,
      150000,
      32,
      148000,
      425507,
      118,
      0,
      1,
      1,
      61516,
      11218,
      0,
      1,
      150000,
      32,
      148000,
      425507,
      118,
      0,
      1,
      1,
      148000,
      425507,
      118,
      0,
      1,
      1,
      2477736,
      29175,
      4,
      0,
      82363,
      4,
      150000,
      5000,
      0,
      1,
      150000,
      32,
      197209,
      0,
      1,
      1,
      150000,
      32,
      150000,
      32,
      150000,
      32,
      150000,
      32,
      150000,
      32,
      150000,
      32,
      150000,
      32,
      3345831,
      1,
      1,
    ];
    final CostModel costModel =
        CostModel(costModelValues.map((e) => BigInt.from(e)).toList());
    final Costmdls model = Costmdls({Language.plutusV1: costModel});
    expect(BytesUtils.toHexString(model.languageViewEncoding().encode()),
        'a141005901d59f1a000302590001011a00060bc719026d00011a000249f01903e800011a000249f018201a0025cea81971f70419744d186419744d186419744d186419744d186419744d186419744d18641864186419744d18641a000249f018201a000249f018201a000249f018201a000249f01903e800011a000249f018201a000249f01903e800081a000242201a00067e2318760001011a000249f01903e800081a000249f01a0001b79818f7011a000249f0192710011a0002155e19052e011903e81a000249f01903e8011a000249f018201a000249f018201a000249f0182001011a000249f0011a000249f0041a000194af18f8011a000194af18f8011a0002377c190556011a0002bdea1901f1011a000249f018201a000249f018201a000249f018201a000249f018201a000249f018201a000249f018201a000242201a00067e23187600010119f04c192bd200011a000249f018201a000242201a00067e2318760001011a000242201a00067e2318760001011a0025cea81971f704001a000141bb041a000249f019138800011a000249f018201a000302590001011a000249f018201a000249f018201a000249f018201a000249f018201a000249f018201a000249f018201a000249f018201a00330da70101ff');
    final decode =
        Costmdls.fromCborBytes(model.languageViewEncoding().encode());
    expect(decode.serialize(), model.serialize());
  });
  test('cost model encoding', () {
    final List<int> costModelValues = [
      197209,
      0,
      1,
      1,
      396231,
      621,
      0,
      1,
      150000,
      1000,
      0,
      1,
      150000,
      32,
      2477736,
      29175,
      4,
      29773,
      100,
      29773,
      100,
      29773,
      100,
      29773,
      100,
      29773,
      100,
      29773,
      100,
      100,
      100,
      29773,
      100,
      150000,
      32,
      150000,
      32,
      150000,
      32,
      150000,
      1000,
      0,
      1,
      150000,
      32,
      150000,
      1000,
      0,
      8,
      148000,
      425507,
      118,
      0,
      1,
      1,
      150000,
      1000,
      0,
      8,
      150000,
      112536,
      247,
      1,
      150000,
      10000,
      1,
      136542,
      1326,
      1,
      1000,
      150000,
      1000,
      1,
      150000,
      32,
      150000,
      32,
      150000,
      32,
      1,
      1,
      150000,
      1,
      150000,
      4,
      103599,
      248,
      1,
      103599,
      248,
      1,
      145276,
      1366,
      1,
      179690,
      497,
      1,
      150000,
      32,
      150000,
      32,
      150000,
      32,
      150000,
      32,
      150000,
      32,
      150000,
      32,
      148000,
      425507,
      118,
      0,
      1,
      1,
      61516,
      11218,
      0,
      1,
      150000,
      32,
      148000,
      425507,
      118,
      0,
      1,
      1,
      148000,
      425507,
      118,
      0,
      1,
      1,
      2477736,
      29175,
      4,
      0,
      82363,
      4,
      150000,
      5000,
      0,
      1,
      150000,
      32,
      197209,
      0,
      1,
      1,
      150000,
      32,
      150000,
      32,
      150000,
      32,
      150000,
      32,
      150000,
      32,
      150000,
      32,
      150000,
      32,
      3345831,
      1,
      1,
    ];
    final CostModel costModel =
        CostModel(costModelValues.map((e) => BigInt.from(e)).toList());
    final Costmdls model = Costmdls({Language.plutusV1: costModel});
    expect(model.serializeHex(),
        'a10098a61a000302590001011a00060bc719026d00011a000249f01903e800011a000249f018201a0025cea81971f70419744d186419744d186419744d186419744d186419744d186419744d18641864186419744d18641a000249f018201a000249f018201a000249f018201a000249f01903e800011a000249f018201a000249f01903e800081a000242201a00067e2318760001011a000249f01903e800081a000249f01a0001b79818f7011a000249f0192710011a0002155e19052e011903e81a000249f01903e8011a000249f018201a000249f018201a000249f0182001011a000249f0011a000249f0041a000194af18f8011a000194af18f8011a0002377c190556011a0002bdea1901f1011a000249f018201a000249f018201a000249f018201a000249f018201a000249f018201a000249f018201a000242201a00067e23187600010119f04c192bd200011a000249f018201a000242201a00067e2318760001011a000242201a00067e2318760001011a0025cea81971f704001a000141bb041a000249f019138800011a000249f018201a000302590001011a000249f018201a000249f018201a000249f018201a000249f018201a000249f018201a000249f018201a000249f018201a00330da70101');
  });

  test('cost model encoding 2', () {
    final contModelValues = [
      205665,
      812,
      1,
      1,
      1000,
      571,
      0,
      1,
      1000,
      24177,
      4,
      1,
      1000,
      32,
      117366,
      10475,
      4,
      23000,
      100,
      23000,
      100,
      23000,
      100,
      23000,
      100,
      23000,
      100,
      23000,
      100,
      100,
      100,
      23000,
      100,
      19537,
      32,
      175354,
      32,
      46417,
      4,
      221973,
      511,
      0,
      1,
      89141,
      32,
      497525,
      14068,
      4,
      2,
      196500,
      453240,
      220,
      0,
      1,
      1,
      1000,
      28662,
      4,
      2,
      245000,
      216773,
      62,
      1,
      1060367,
      12586,
      1,
      208512,
      421,
      1,
      187000,
      1000,
      52998,
      1,
      80436,
      32,
      43249,
      32,
      1000,
      32,
      80556,
      1,
      57667,
      4,
      1000,
      10,
      197145,
      156,
      1,
      197145,
      156,
      1,
      204924,
      473,
      1,
      208896,
      511,
      1,
      52467,
      32,
      64832,
      32,
      65493,
      32,
      22558,
      32,
      16563,
      32,
      76511,
      32,
      196500,
      453240,
      220,
      0,
      1,
      1,
      69522,
      11687,
      0,
      1,
      60091,
      32,
      196500,
      453240,
      220,
      0,
      1,
      1,
      196500,
      453240,
      220,
      0,
      1,
      1,
      806990,
      30482,
      4,
      1927926,
      82523,
      4,
      265318,
      0,
      4,
      0,
      85931,
      32,
      205665,
      812,
      1,
      1,
      41182,
      32,
      212342,
      32,
      31220,
      32,
      32696,
      32,
      43357,
      32,
      32247,
      32,
      38314,
      32,
      57996947,
      18975,
      10,
    ];

    final costModel =
        CostModel(contModelValues.map((e) => BigInt.from(e)).toList());
    final model = Costmdls({Language.plutusV1: costModel});
    expect(model.serializeHex(),
        'a10098a61a0003236119032c01011903e819023b00011903e8195e7104011903e818201a0001ca761928eb041959d818641959d818641959d818641959d818641959d818641959d81864186418641959d81864194c5118201a0002acfa182019b551041a000363151901ff00011a00015c3518201a000797751936f404021a0002ff941a0006ea7818dc0001011903e8196ff604021a0003bd081a00034ec5183e011a00102e0f19312a011a00032e801901a5011a0002da781903e819cf06011a00013a34182019a8f118201903e818201a00013aac0119e143041903e80a1a00030219189c011a00030219189c011a0003207c1901d9011a000330001901ff0119ccf3182019fd40182019ffd5182019581e18201940b318201a00012adf18201a0002ff941a0006ea7818dc0001011a00010f92192da7000119eabb18201a0002ff941a0006ea7818dc0001011a0002ff941a0006ea7818dc0001011a000c504e197712041a001d6af61a0001425b041a00040c660004001a00014fab18201a0003236119032c010119a0de18201a00033d7618201979f41820197fb8182019a95d1820197df718201995aa18201a0374f693194a1f0a');
    // final decode = Costmdls.fromCborBytes(model.serialize());
    // expect(decode.serialize(), model.serialize());
  });
}

void _scriptHash() {
  test('PlutusData_Script hash', () {
    final addr = ADAEnterpriseAddress(
        'addr1w896t6qnpsjs32xhw8jl3kw34pqz69kgd72l8hqw83w0k3qahx2sv');

    final plutusScript = PlutusScript.fromCborBytes(BytesUtils.fromHexString(
        '590e6f590e6c0100003323332223322333222332232332233223232333222323332223233333333222222223233322232333322223232332232323332223232332233223232333332222233223322332233223322332222323232232232325335303233300a3333573466e1cd55cea8042400046664446660a40060040026eb4d5d0a8041bae35742a00e66a05046666ae68cdc39aab9d37540029000102b11931a982599ab9c04f04c04a049357426ae89401c8c98d4c124cd5ce0268250240239999ab9a3370ea0089001102b11999ab9a3370ea00a9000102c11931a982519ab9c04e04b0490480473333573466e1cd55cea8012400046601a64646464646464646464646666ae68cdc39aab9d500a480008cccccccccc06ccd40a48c8c8cccd5cd19b8735573aa0049000119810981c9aba15002302e357426ae8940088c98d4c164cd5ce02e82d02c02b89aab9e5001137540026ae854028cd40a40a8d5d0a804999aa8183ae502f35742a010666aa060eb940bcd5d0a80399a8148211aba15006335029335505304b75a6ae854014c8c8c8cccd5cd19b8735573aa0049000119a8119919191999ab9a3370e6aae7540092000233502b33504175a6ae854008c118d5d09aba25002232635305d3357380c20bc0b80b626aae7940044dd50009aba150023232323333573466e1cd55cea80124000466a05266a082eb4d5d0a80118231aba135744a004464c6a60ba66ae7018417817016c4d55cf280089baa001357426ae8940088c98d4c164cd5ce02e82d02c02b89aab9e5001137540026ae854010cd40a5d71aba15003335029335505375c40026ae854008c0e0d5d09aba2500223263530553357380b20ac0a80a626ae8940044d5d1280089aba25001135744a00226ae8940044d5d1280089aba25001135744a00226aae7940044dd50009aba150023232323333573466e1d4005200623020303a357426aae79400c8cccd5cd19b875002480108c07cc110d5d09aab9e500423333573466e1d400d20022301f302f357426aae7940148cccd5cd19b875004480008c088dd71aba135573ca00c464c6a60a066ae7015014413c13813413012c4d55cea80089baa001357426ae8940088c98d4c124cd5ce026825024023882489931a982419ab9c4910350543500049047135573ca00226ea80044d55ce9baa001135744a00226aae7940044dd50009109198008018011000911111111109199999999980080580500480400380300280200180110009109198008018011000891091980080180109000891091980080180109000891091980080180109000909111180200290911118018029091111801002909111180080290008919118011bac0013200135503c2233335573e0024a01c466a01a60086ae84008c00cd5d100101811919191999ab9a3370e6aae75400d200023330073232323333573466e1cd55cea8012400046601a605c6ae854008cd404c0a8d5d09aba25002232635303433573807006a06606426aae7940044dd50009aba150033335500b75ca0146ae854008cd403dd71aba135744a004464c6a606066ae700d00c40bc0b84d5d1280089aab9e5001137540024442466600200800600440024424660020060044002266aa002eb9d6889119118011bab00132001355036223233335573e0044a012466a01066aa05c600c6aae754008c014d55cf280118021aba200302b1357420022244004244244660020080062400224464646666ae68cdc3a800a400046a05e600a6ae84d55cf280191999ab9a3370ea00490011281791931a981399ab9c02b028026025024135573aa00226ea80048c8c8cccd5cd19b8735573aa004900011980318039aba15002375a6ae84d5d1280111931a981219ab9c028025023022135573ca00226ea80048848cc00400c00880048c8cccd5cd19b8735573aa002900011bae357426aae7940088c98d4c080cd5ce01201080f80f09baa00112232323333573466e1d400520042500723333573466e1d4009200223500a3006357426aae7940108cccd5cd19b87500348000940288c98d4c08ccd5ce01381201101081000f89aab9d50011375400224244460060082244400422444002240024646666ae68cdc3a800a4004400c46666ae68cdc3a80124000400c464c6a603666ae7007c0700680640604d55ce9baa0011220021220012001232323232323333573466e1d4005200c200b23333573466e1d4009200a200d23333573466e1d400d200823300b375c6ae854014dd69aba135744a00a46666ae68cdc3a8022400c46601a6eb8d5d0a8039bae357426ae89401c8cccd5cd19b875005480108cc048c050d5d0a8049bae357426ae8940248cccd5cd19b875006480088c050c054d5d09aab9e500b23333573466e1d401d2000230133016357426aae7940308c98d4c080cd5ce01201080f80f00e80e00d80d00c80c09aab9d5004135573ca00626aae7940084d55cf280089baa00121222222230070082212222222330060090082122222223005008122222220041222222200322122222223300200900822122222223300100900820012323232323333573466e1d400520022333008375a6ae854010dd69aba15003375a6ae84d5d1280191999ab9a3370ea00490001180518059aba135573ca00c464c6a602266ae7005404804003c0384d55cea80189aba25001135573ca00226ea80048488c00800c888488ccc00401401000c80048c8c8cccd5cd19b875001480088c018dd71aba135573ca00646666ae68cdc3a80124000460106eb8d5d09aab9e5004232635300b33573801e01801401201026aae7540044dd5000909118010019091180080190008891119191999ab9a3370e6aae75400920002335500b300635742a004600a6ae84d5d1280111931a980419ab9c00c009007006135573ca00226ea800526120012001112212330010030021120014910350543100222123330010040030022001121223002003112200112001120012001122002122001200111232300100122330033002002001332323233322233322233223332223322332233322233223322332233223233322232323322323232323333222232332232323222323222325335301a5335301a333573466e1cc8cccd54c05048004c8cd406488ccd406400c004008d4058004cd4060888c00cc008004800488cdc0000a40040029000199aa98068900091299a980e299a9a81a1a98169a98131a9812001110009110019119a98188011281c11a81c8009080f880e899a8148010008800a8141a981028009111111111005240040380362038266ae712413c53686f756c642062652065786163746c79206f6e652073637269707420696e70757420746f2061766f696420646f75626c65207361742069737375650001b15335303500315335301a5335301a333573466e20ccc064ccd54c03448005402540a0cc020d4c0c00188880094004074074cdc09a9818003111001a80200d80e080e099ab9c49010f73656c6c6572206e6f7420706169640001b15335301a333573466e20ccc064cc88ccd54c03c48005402d40a8cc028004009400401c074075401006c07040704cd5ce24810d66656573206e6f7420706169640001b101b15335301a3322353022002222222222253353503e33355301f1200133502322533535040002210031001503f253353027333573466e3c0300040a40a04d41040045410000c840a4409d4004d4c0c001888800840704cd5ce2491c4f6e6c792073656c6c65722063616e2063616e63656c206f666665720001b101b135301d00122002153353016333573466e2540040d406005c40d4540044cdc199b8235302b001222003480c920d00f2235301a0012222222222333553011120012235302a002222353034003223353038002253353026333573466e3c0500040a009c4cd40cc01401c401c801d40b0024488cd54c02c480048d4d5408c00488cd54098008cd54c038480048d4d5409800488cd540a4008ccd4d540340048cc0e12000001223303900200123303800148000004cd54c02c480048d4d5408c00488cd54098008ccd4d540280048cd54c03c480048d4d5409c00488cd540a8008d5404400400488ccd5540200580080048cd54c03c480048d4d5409c00488cd540a8008d5403c004004ccd55400c044008004444888ccd54c018480054080cd54c02c480048d4d5408c00488cd54098008d54034004ccd54c0184800488d4d54090008894cd4c05cccd54c04048004c8cd405488ccd4d402c00c88008008004d4d402400488004cd4024894cd4c064008406c40040608d4d5409c00488cc028008014018400c4cd409001000d4084004cd54c02c480048d4d5408c00488c8cd5409c00cc004014c8004d540d8894cd4d40900044d5403400c884d4d540a4008894cd4c070cc0300080204cd5404801c0044c01800c00848848cc00400c00848004c8004d540b488448894cd4d40780044008884cc014008ccd54c01c480040140100044484888c00c01044884888cc0080140104484888c004010448004c8004d540a08844894cd4d406000454068884cd406cc010008cd54c01848004010004c8004d5409c88448894cd4d40600044d401800c884ccd4024014c010008ccd54c01c4800401401000448d4d400c0048800448d4d40080048800848848cc00400c0084800488ccd5cd19b8f002001006005222323230010053200135502522335350130014800088d4d54060008894cd4c02cccd5cd19b8f00200900d00c13007001130060033200135502422335350120014800088d4d5405c008894cd4c028ccd5cd19b8f00200700c00b10011300600312200212200120014881002212330010030022001222222222212333333333300100b00a009008007006005004003002200122123300100300220012221233300100400300220011122002122122330010040031200111221233001003002112001221233001003002200121223002003212230010032001222123330010040030022001121223002003112200112001122002122001200122337000040029040497a0088919180080091198019801001000a4411c28f07a93d7715db0bdc1766c8bd5b116602b105c02c54fc3bcd0d4680001'));
    expect(plutusScript.toHash().data, addr.paymentCredential.data);
  });
}

void _redeemer() {
  test('Redeemer_serialization', () {
    final redeemer = Redeemer(
        tag: RedeemerTag.spend,
        index: BigInt.one,
        data: ConstrPlutusData(alternative: BigInt.zero, data: PlutusList([])),
        exUnits:
            ExUnits(mem: BigInt.from(7000000), steps: BigInt.from(3000000000)));

    expect(redeemer.serializeHex(), '840001d87980821a006acfc01ab2d05e00');
    final decode = Redeemer.fromCborBytes(redeemer.serialize());
    expect(decode.serialize(), redeemer.serialize());
  });
}

void _plutusDataHash() {
  test('plutusDataHash', () {
    final plutusData = PlutusData.fromCborBytes(BytesUtils.fromHexString(
        'd8799fd8799f581ca183bf86925f66c579a3745c9517744399679b090927b8f6e2f2e1bb4f616461706541696c656e416d61746fffd8799f581c9a4e855293a0b9af5e50935a331d83e7982ab5b738ea0e6fc0f9e6564e4652414d455f36353030335f4c30ff581cbea1c521df58f4eeef60c647e5ebd88c6039915409f9fd6454a476b9ff'));
    final hash = plutusData.toHash();
    final decode = PlutusData.fromCborBytes(plutusData.serialize());
    expect(decode.serialize(), plutusData.serialize());
    expect(BytesUtils.toHexString(hash.data),
        'ec3028f46325b983a470893a8bdc1b4a100695b635fb1237d301c3490b23e89b');
  });
  test('plutusDataHash_2', () {
    final plutusData = PlutusData.fromCborBytes(BytesUtils.fromHexString(
        'd87983d87982581ca183bf86925f66c579a3745c9517744399679b090927b8f6e2f2e1bb4f616461706541696c656e416d61746fd87982581c9a4e855293a0b9af5e50935a331d83e7982ab5b738ea0e6fc0f9e6564e4652414d455f36353030335f4c30581cbea1c521df58f4eeef60c647e5ebd88c6039915409f9fd6454a476b9'));
    final hash = plutusData.toHash();
    final decode = PlutusData.fromCborBytes(plutusData.serialize());
    expect(decode.serialize(), plutusData.serialize());
    expect(BytesUtils.toHexString(hash.data),
        '816cdf6d4d8cba3ad0188ca643db95ddf0e03cdfc0e75a9550a72a82cb146222');
  });
  test('PlutusScriptHash', () {
    final contModelValues = [
      205665,
      812,
      1,
      1,
      1000,
      571,
      0,
      1,
      1000,
      24177,
      4,
      1,
      1000,
      32,
      117366,
      10475,
      4,
      23000,
      100,
      23000,
      100,
      23000,
      100,
      23000,
      100,
      23000,
      100,
      23000,
      100,
      100,
      100,
      23000,
      100,
      19537,
      32,
      175354,
      32,
      46417,
      4,
      221973,
      511,
      0,
      1,
      89141,
      32,
      497525,
      14068,
      4,
      2,
      196500,
      453240,
      220,
      0,
      1,
      1,
      1000,
      28662,
      4,
      2,
      245000,
      216773,
      62,
      1,
      1060367,
      12586,
      1,
      208512,
      421,
      1,
      187000,
      1000,
      52998,
      1,
      80436,
      32,
      43249,
      32,
      1000,
      32,
      80556,
      1,
      57667,
      4,
      1000,
      10,
      197145,
      156,
      1,
      197145,
      156,
      1,
      204924,
      473,
      1,
      208896,
      511,
      1,
      52467,
      32,
      64832,
      32,
      65493,
      32,
      22558,
      32,
      16563,
      32,
      76511,
      32,
      196500,
      453240,
      220,
      0,
      1,
      1,
      69522,
      11687,
      0,
      1,
      60091,
      32,
      196500,
      453240,
      220,
      0,
      1,
      1,
      196500,
      453240,
      220,
      0,
      1,
      1,
      806990,
      30482,
      4,
      1927926,
      82523,
      4,
      265318,
      0,
      4,
      0,
      85931,
      32,
      205665,
      812,
      1,
      1,
      41182,
      32,
      212342,
      32,
      31220,
      32,
      32696,
      32,
      43357,
      32,
      32247,
      32,
      38314,
      32,
      57996947,
      18975,
      10,
    ];
    final plutusData = PlutusList([
      ConstrPlutusData(
          alternative: BigInt.zero,
          data: PlutusList([
            ConstrPlutusData(
                alternative: BigInt.zero,
                data: PlutusList([
                  PlutusBytes(
                      value: BytesUtils.fromHexString(
                          'A183BF86925F66C579A3745C9517744399679B090927B8F6E2F2E1BB')),
                  PlutusBytes(
                      value: BytesUtils.fromHexString(
                          '6164617065416D616E734576616E73')),
                ])),
            ConstrPlutusData(
                alternative: BigInt.zero,
                data: PlutusList([
                  PlutusBytes(
                      value: BytesUtils.fromHexString(
                          '9A4E855293A0B9AF5E50935A331D83E7982AB5B738EA0E6FC0F9E656')),
                  PlutusBytes(
                      value: BytesUtils.fromHexString(
                          '4652414D455F38333030325F4C30')),
                ])),
            PlutusBytes(
                value: BytesUtils.fromHexString(
                    'BEA1C521DF58F4EEEF60C647E5EBD88C6039915409F9FD6454A476B9')),
          ]))
    ]);

    final redeemer = Redeemer(
        tag: RedeemerTag.spend,
        index: BigInt.one,
        data: ConstrPlutusData(alternative: BigInt.zero, data: PlutusList([])),
        exUnits:
            ExUnits(mem: BigInt.from(7000000), steps: BigInt.from(3000000000)));
    final costModel =
        CostModel(contModelValues.map((e) => BigInt.from(e)).toList());
    final model = Costmdls({Language.plutusV1: costModel});
    final hash = PlutusDataUtils.scriptDatahash(
        costmdls: model, redeemers: [redeemer], datums: plutusData);
    expect(BytesUtils.toHexString(hash.data),
        '2fd8b7e248b376314d02989c885c278796ab0e1d6e8aa0cb91f562ff5f7dbd70');
  });

  test('PlutusScriptHash_2', () {
    final contModelValues = [
      205665,
      812,
      1,
      1,
      1000,
      571,
      0,
      1,
      1000,
      24177,
      4,
      1,
      1000,
      32,
      117366,
      10475,
      4,
      23000,
      100,
      23000,
      100,
      23000,
      100,
      23000,
      100,
      23000,
      100,
      23000,
      100,
      100,
      100,
      23000,
      100,
      19537,
      32,
      175354,
      32,
      46417,
      4,
      221973,
      511,
      0,
      1,
      89141,
      32,
      497525,
      14068,
      4,
      2,
      196500,
      453240,
      220,
      0,
      1,
      1,
      1000,
      28662,
      4,
      2,
      245000,
      216773,
      62,
      1,
      1060367,
      12586,
      1,
      208512,
      421,
      1,
      187000,
      1000,
      52998,
      1,
      80436,
      32,
      43249,
      32,
      1000,
      32,
      80556,
      1,
      57667,
      4,
      1000,
      10,
      197145,
      156,
      1,
      197145,
      156,
      1,
      204924,
      473,
      1,
      208896,
      511,
      1,
      52467,
      32,
      64832,
      32,
      65493,
      32,
      22558,
      32,
      16563,
      32,
      76511,
      32,
      196500,
      453240,
      220,
      0,
      1,
      1,
      69522,
      11687,
      0,
      1,
      60091,
      32,
      196500,
      453240,
      220,
      0,
      1,
      1,
      196500,
      453240,
      220,
      0,
      1,
      1,
      1159724,
      392670,
      0,
      2,
      806990,
      30482,
      4,
      1927926,
      82523,
      4,
      265318,
      0,
      4,
      0,
      85931,
      32,
      205665,
      812,
      1,
      1,
      41182,
      32,
      212342,
      32,
      31220,
      32,
      32696,
      32,
      43357,
      32,
      32247,
      32,
      38314,
      32,
      35892428,
      10,
      57996947,
      18975,
      10,
      38887044,
      32947,
      10
    ];

    final redeemer = Redeemer(
        tag: RedeemerTag.spend,
        index: BigInt.zero,
        data: ConstrPlutusData(alternative: BigInt.zero, data: PlutusList([])),
        exUnits:
            ExUnits(mem: BigInt.from(842996), steps: BigInt.from(246100241)));
    final costModel =
        CostModel(contModelValues.map((e) => BigInt.from(e)).toList());
    final model = Costmdls({Language.plutusV2: costModel});
    final hash =
        PlutusDataUtils.scriptDatahash(costmdls: model, redeemers: [redeemer]);
    expect(BytesUtils.toHexString(hash.data),
        '6b244f15f895fd458a02bef3a8b56f17f24150fddcb06be482f8790a600578a1');
  });
  test('PlutusScriptHash_3', () {
    final contModelValues = [
      205665,
      812,
      1,
      1,
      1000,
      571,
      0,
      1,
      1000,
      24177,
      4,
      1,
      1000,
      32,
      117366,
      10475,
      4,
      23000,
      100,
      23000,
      100,
      23000,
      100,
      23000,
      100,
      23000,
      100,
      23000,
      100,
      100,
      100,
      23000,
      100,
      19537,
      32,
      175354,
      32,
      46417,
      4,
      221973,
      511,
      0,
      1,
      89141,
      32,
      497525,
      14068,
      4,
      2,
      196500,
      453240,
      220,
      0,
      1,
      1,
      1000,
      28662,
      4,
      2,
      245000,
      216773,
      62,
      1,
      1060367,
      12586,
      1,
      208512,
      421,
      1,
      187000,
      1000,
      52998,
      1,
      80436,
      32,
      43249,
      32,
      1000,
      32,
      80556,
      1,
      57667,
      4,
      1000,
      10,
      197145,
      156,
      1,
      197145,
      156,
      1,
      204924,
      473,
      1,
      208896,
      511,
      1,
      52467,
      32,
      64832,
      32,
      65493,
      32,
      22558,
      32,
      16563,
      32,
      76511,
      32,
      196500,
      453240,
      220,
      0,
      1,
      1,
      69522,
      11687,
      0,
      1,
      60091,
      32,
      196500,
      453240,
      220,
      0,
      1,
      1,
      196500,
      453240,
      220,
      0,
      1,
      1,
      806990,
      30482,
      4,
      1927926,
      82523,
      4,
      265318,
      0,
      4,
      0,
      85931,
      32,
      205665,
      812,
      1,
      1,
      41182,
      32,
      212342,
      32,
      31220,
      32,
      32696,
      32,
      43357,
      32,
      32247,
      32,
      38314,
      32,
      57996947,
      18975,
      10,
    ];
    final plutusData = PlutusList([
      ConstrPlutusData(
          alternative: BigInt.zero,
          data: PlutusList([
            PlutusBytes(
                value: BytesUtils.fromHexString(
                    '45F6A506A49A38263C4A8BBB2E1E369DD8732FB1F9A281F3E8838387')),
            PlutusInteger(BigInt.from(60000000)),
            PlutusBytes(
                value: BytesUtils.fromHexString(
                    'EE8E37676F6EBB8E031DFF493F88FF711D24AA68666A09D61F1D3FB3')),
            PlutusBytes(
                value:
                    BytesUtils.fromHexString('43727970746F44696E6F3036333039')),
          ]))
    ]);

    final redeemer = Redeemer(
        tag: RedeemerTag.spend,
        index: BigInt.one,
        data: ConstrPlutusData(alternative: BigInt.one, data: PlutusList([])),
        exUnits:
            ExUnits(mem: BigInt.from(61300), steps: BigInt.from(18221176)));
    final costModel =
        CostModel(contModelValues.map((e) => BigInt.from(e)).toList());
    final model = Costmdls({Language.plutusV1: costModel});
    final hash = PlutusDataUtils.scriptDatahash(
        costmdls: model, redeemers: [redeemer], datums: plutusData);
    expect(BytesUtils.toHexString(hash.data),
        '0a076247a05aacbecf72ea15b94e3d0331b21295a08d9ab7b8675c13840563a6');
  });
}

void _plutusDataFromAddress() {
  test('PlutusDataFromAddress_1', () {
    final ADAShellyAddress addr = ADAShellyAddress.fromAddress(
        'addr1w8wrk560wcsldjpnqjamn8s0gn9pdrplpyetrdfpacqrpfs3xezd8');
    final plutusData = PlutusData.fromAddress(addr);
    expect(
        plutusData.toJsonSchema(
            config: const PlutusSchemaConfig(
                jsonSchema: PlutusJsonSchema.detailedSchema)),
        StringUtils.toJson(
            '{"constructor": 0, "fields": [{"constructor": 1, "fields": [{"bytes": "dc3b534f7621f6c83304bbb99e0f44ca168c3f0932b1b521ee0030a6"}]}, {"constructor": 1, "fields": []}]}'));
  });
  test('PlutusDataFromAddress_2', () {
    final addr = ADAShellyAddress.fromAddress(
        'addr1qxy2c673nsdp0mvgq5d3tpjndngucsytug00k7k6xwlx4lvg434ar8q6zlkcspgmzkr9xmx3e3qghcs7ldad5va7dt7s5efyer');
    final plutusData = PlutusData.fromAddress(addr);
    expect(
        plutusData.toJsonSchema(
            config: const PlutusSchemaConfig(
                jsonSchema: PlutusJsonSchema.detailedSchema)),
        StringUtils.toJson(
            '{"constructor": 0, "fields": [{"constructor": 0, "fields": [{"bytes": "88ac6bd19c1a17ed88051b1586536cd1cc408be21efb7ada33be6afd"}]}, {"constructor": 0, "fields": [{"constructor": 0, "fields": [{"constructor": 0, "fields": [{"bytes": "88ac6bd19c1a17ed88051b1586536cd1cc408be21efb7ada33be6afd"}]}]}]}]}'));
  });
  test('PlutusDataFromAddress_3', () {
    final addr = ADAShellyAddress.fromAddress(
        'addr1x8wrk560wcsldjpnqjamn8s0gn9pdrplpyetrdfpacqrpfku8df57a3p7myrxp9mhx0q73x2z6xr7zfjkx6jrmsqxznqh8u5dz');
    final plutusData = PlutusData.fromAddress(addr);
    expect(
        plutusData.toJsonSchema(
            config: const PlutusSchemaConfig(
                jsonSchema: PlutusJsonSchema.detailedSchema)),
        StringUtils.toJson(
            '{"constructor": 0, "fields": [{"constructor": 1, "fields": [{"bytes": "dc3b534f7621f6c83304bbb99e0f44ca168c3f0932b1b521ee0030a6"}]}, {"constructor": 0, "fields": [{"constructor": 0, "fields": [{"constructor": 1, "fields": [{"bytes": "dc3b534f7621f6c83304bbb99e0f44ca168c3f0932b1b521ee0030a6"}]}]}]}]}'));
  });
  test('PlutusDataFromAddress_4', () {
    final addr = ADAShellyAddress.fromAddress(
        'addr1z8wrk560wcsldjpnqjamn8s0gn9pdrplpyetrdfpacqrpf5g434ar8q6zlkcspgmzkr9xmx3e3qghcs7ldad5va7dt7sqx2wxh');
    final plutusData = PlutusData.fromAddress(addr);
    expect(
        plutusData.toJsonSchema(
            config: const PlutusSchemaConfig(
                jsonSchema: PlutusJsonSchema.detailedSchema)),
        StringUtils.toJson(
            '{"constructor": 0, "fields": [{"constructor": 1, "fields": [{"bytes": "dc3b534f7621f6c83304bbb99e0f44ca168c3f0932b1b521ee0030a6"}]}, {"constructor": 0, "fields": [{"constructor": 0, "fields": [{"constructor": 0, "fields": [{"bytes": "88ac6bd19c1a17ed88051b1586536cd1cc408be21efb7ada33be6afd"}]}]}]}]}'));
  });
  test('PlutusDataFromAddress_5', () {
    final addr = ADAShellyAddress.fromAddress(
        'addr1yxy2c673nsdp0mvgq5d3tpjndngucsytug00k7k6xwlx4lwu8df57a3p7myrxp9mhx0q73x2z6xr7zfjkx6jrmsqxznqrcl7jk');
    final plutusData = PlutusData.fromAddress(addr);
    expect(
        plutusData.toJsonSchema(
            config: const PlutusSchemaConfig(
                jsonSchema: PlutusJsonSchema.detailedSchema)),
        StringUtils.toJson(
            '{"constructor": 0, "fields": [{"constructor": 0, "fields": [{"bytes": "88ac6bd19c1a17ed88051b1586536cd1cc408be21efb7ada33be6afd"}]}, {"constructor": 0, "fields": [{"constructor": 0, "fields": [{"constructor": 1, "fields": [{"bytes": "dc3b534f7621f6c83304bbb99e0f44ca168c3f0932b1b521ee0030a6"}]}]}]}]}'));
  });
}
