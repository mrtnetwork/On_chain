import 'package:blockchain_utils/blockchain_utils.dart';
import 'package:on_chain/ada/ada.dart';
import 'package:test/test.dart';
import 'package:on_chain/serialization/cbor_serialization.dart';

void main() {
  _outputs();
}

void _outputs() {
  test('legacy with data hash', () {
    final address = ADAAddress.fromAddress(
        'addr1qyxwnq9kylzrtqprmyu35qt8gwylk3eemq53kqd38m9kyduv2q928esxmrz4y5e78cvp0nffhxklfxsqy3vdjn3nty9s8zygkm');
    final txo = TransactionOutput(
        serializationConfig: TransactionOutputSerializationConfig(
            encoding: TransactionOutputCborEncoding.shellyEra),
        address: address,
        amount: Value(coin: BigInt.from(435464757)));
    final txo2 = TransactionOutput(
        serializationConfig: TransactionOutputSerializationConfig(
            encoding: TransactionOutputCborEncoding.shellyEra),
        address: address,
        amount: Value(coin: BigInt.from(435464757)),
        plutusData: DataOptionDataHash.fromBytes(List<int>.filled(32, 47)));
    final List<TransactionOutput> txos = [];
    txos.add(txo);
    txos.add(txo2);
    txos.add(txo2);
    txos.add(txo);
    txos.add(txo);
    txos.add(txo2);
    final encode = CborListValue.definite(txos.map((e) => e.toCbor()).toList());
    expect(encode.toCborHex(),
        '86825839010ce980b627c4358023d9391a01674389fb4739d8291b01b13ecb62378c500aa3e606d8c552533e3e1817cd29b9adf49a002458d94e33590b1a19f4aa35835839010ce980b627c4358023d9391a01674389fb4739d8291b01b13ecb62378c500aa3e606d8c552533e3e1817cd29b9adf49a002458d94e33590b1a19f4aa3558202f2f2f2f2f2f2f2f2f2f2f2f2f2f2f2f2f2f2f2f2f2f2f2f2f2f2f2f2f2f2f2f835839010ce980b627c4358023d9391a01674389fb4739d8291b01b13ecb62378c500aa3e606d8c552533e3e1817cd29b9adf49a002458d94e33590b1a19f4aa3558202f2f2f2f2f2f2f2f2f2f2f2f2f2f2f2f2f2f2f2f2f2f2f2f2f2f2f2f2f2f2f2f825839010ce980b627c4358023d9391a01674389fb4739d8291b01b13ecb62378c500aa3e606d8c552533e3e1817cd29b9adf49a002458d94e33590b1a19f4aa35825839010ce980b627c4358023d9391a01674389fb4739d8291b01b13ecb62378c500aa3e606d8c552533e3e1817cd29b9adf49a002458d94e33590b1a19f4aa35835839010ce980b627c4358023d9391a01674389fb4739d8291b01b13ecb62378c500aa3e606d8c552533e3e1817cd29b9adf49a002458d94e33590b1a19f4aa3558202f2f2f2f2f2f2f2f2f2f2f2f2f2f2f2f2f2f2f2f2f2f2f2f2f2f2f2f2f2f2f2f');

    final CborListValue<CborObject> decode =
        CborObject.fromCbor(encode.encode()).as();
    final decodeTxos =
        decode.value.map((e) => TransactionOutput.deserialize(e)).toList();
    final newBytes =
        CborListValue.definite(decodeTxos.map((e) => e.toCbor()).toList())
            .encode();
    expect(newBytes, encode.encode());
  });
  test('alonzo', () {
    final address = ADAAddress.fromAddress(
        'addr1qyxwnq9kylzrtqprmyu35qt8gwylk3eemq53kqd38m9kyduv2q928esxmrz4y5e78cvp0nffhxklfxsqy3vdjn3nty9s8zygkm');
    final txo = TransactionOutput(
        serializationConfig: TransactionOutputSerializationConfig(
            encoding: TransactionOutputCborEncoding.shellyEra),
        address: address,
        amount: Value(coin: BigInt.from(435464757)));
    final txo2 = TransactionOutput(
        serializationConfig: TransactionOutputSerializationConfig(
            encoding: TransactionOutputCborEncoding.alonzoEra),
        address: address,
        amount: Value(coin: BigInt.from(435464757)),
        plutusData: DataOptionData(PlutusBytes(value: [
          11,
          239,
          181,
          120,
          142,
          135,
          19,
          200,
          68,
          223,
          211,
          43,
          46,
          145,
          222,
          30,
          48,
          159,
          239,
          255,
          213,
          85,
          248,
          39,
          204,
          158,
          225,
          100,
          1,
          2,
          3,
          4,
        ])));
    final List<TransactionOutput> txos = [];
    txos.add(txo);
    txos.add(txo2);
    txos.add(txo2);
    txos.add(txo);
    txos.add(txo);
    txos.add(txo2);
    final encode = CborListValue.definite(txos.map((e) => e.toCbor()).toList());
    expect(encode.toCborHex(),
        '86825839010ce980b627c4358023d9391a01674389fb4739d8291b01b13ecb62378c500aa3e606d8c552533e3e1817cd29b9adf49a002458d94e33590b1a19f4aa35a3005839010ce980b627c4358023d9391a01674389fb4739d8291b01b13ecb62378c500aa3e606d8c552533e3e1817cd29b9adf49a002458d94e33590b011a19f4aa35028201d818582258200befb5788e8713c844dfd32b2e91de1e309fefffd555f827cc9ee16401020304a3005839010ce980b627c4358023d9391a01674389fb4739d8291b01b13ecb62378c500aa3e606d8c552533e3e1817cd29b9adf49a002458d94e33590b011a19f4aa35028201d818582258200befb5788e8713c844dfd32b2e91de1e309fefffd555f827cc9ee16401020304825839010ce980b627c4358023d9391a01674389fb4739d8291b01b13ecb62378c500aa3e606d8c552533e3e1817cd29b9adf49a002458d94e33590b1a19f4aa35825839010ce980b627c4358023d9391a01674389fb4739d8291b01b13ecb62378c500aa3e606d8c552533e3e1817cd29b9adf49a002458d94e33590b1a19f4aa35a3005839010ce980b627c4358023d9391a01674389fb4739d8291b01b13ecb62378c500aa3e606d8c552533e3e1817cd29b9adf49a002458d94e33590b011a19f4aa35028201d818582258200befb5788e8713c844dfd32b2e91de1e309fefffd555f827cc9ee16401020304');

    final CborListValue<CborObject> decode =
        CborObject.fromCbor(encode.encode()).as();
    final decodeTxos =
        decode.value.map((e) => TransactionOutput.deserialize(e)).toList();
    final newBytes =
        CborListValue.definite(decodeTxos.map((e) => e.toCbor()).toList())
            .encode();
    expect(newBytes, encode.encode());
  });
  test('script ref', () {
    final address = ADAAddress.fromAddress(
        'addr1qyxwnq9kylzrtqprmyu35qt8gwylk3eemq53kqd38m9kyduv2q928esxmrz4y5e78cvp0nffhxklfxsqy3vdjn3nty9s8zygkm');
    final txo = TransactionOutput(
        serializationConfig: TransactionOutputSerializationConfig(
            encoding: TransactionOutputCborEncoding.shellyEra),
        address: address,
        amount: Value(coin: BigInt.from(435464757)));
    final txo2 = TransactionOutput(
        serializationConfig: TransactionOutputSerializationConfig(
            encoding: TransactionOutputCborEncoding.alonzoEra),
        address: address,
        amount: Value(coin: BigInt.from(435464757)),
        scriptRef: ScriptRefPlutusScript(PlutusScript(
            bytes: List<int>.filled(29, 61), language: Language.plutusV1)));
    final List<TransactionOutput> txos = [];
    txos.add(txo);
    txos.add(txo2);
    txos.add(txo2);
    txos.add(txo);
    txos.add(txo);
    txos.add(txo2);
    final encode = CborListValue.definite(txos.map((e) => e.toCbor()).toList());
    expect(encode.toCborHex(),
        '86825839010ce980b627c4358023d9391a01674389fb4739d8291b01b13ecb62378c500aa3e606d8c552533e3e1817cd29b9adf49a002458d94e33590b1a19f4aa35a3005839010ce980b627c4358023d9391a01674389fb4739d8291b01b13ecb62378c500aa3e606d8c552533e3e1817cd29b9adf49a002458d94e33590b011a19f4aa3503d81858218201581d3d3d3d3d3d3d3d3d3d3d3d3d3d3d3d3d3d3d3d3d3d3d3d3d3d3d3d3d3da3005839010ce980b627c4358023d9391a01674389fb4739d8291b01b13ecb62378c500aa3e606d8c552533e3e1817cd29b9adf49a002458d94e33590b011a19f4aa3503d81858218201581d3d3d3d3d3d3d3d3d3d3d3d3d3d3d3d3d3d3d3d3d3d3d3d3d3d3d3d3d3d825839010ce980b627c4358023d9391a01674389fb4739d8291b01b13ecb62378c500aa3e606d8c552533e3e1817cd29b9adf49a002458d94e33590b1a19f4aa35825839010ce980b627c4358023d9391a01674389fb4739d8291b01b13ecb62378c500aa3e606d8c552533e3e1817cd29b9adf49a002458d94e33590b1a19f4aa35a3005839010ce980b627c4358023d9391a01674389fb4739d8291b01b13ecb62378c500aa3e606d8c552533e3e1817cd29b9adf49a002458d94e33590b011a19f4aa3503d81858218201581d3d3d3d3d3d3d3d3d3d3d3d3d3d3d3d3d3d3d3d3d3d3d3d3d3d3d3d3d3d');

    final CborListValue<CborObject> decode =
        CborObject.fromCbor(encode.encode()).as();
    final decodeTxos =
        decode.value.map((e) => TransactionOutput.deserialize(e)).toList();
    final newBytes =
        CborListValue.definite(decodeTxos.map((e) => e.toCbor()).toList())
            .encode();
    expect(newBytes, encode.encode());
  });
  test('alonzo with native script', () {
    final address = ADAAddress.fromAddress(
        'addr1qyxwnq9kylzrtqprmyu35qt8gwylk3eemq53kqd38m9kyduv2q928esxmrz4y5e78cvp0nffhxklfxsqy3vdjn3nty9s8zygkm');
    final txo = TransactionOutput(
        serializationConfig: TransactionOutputSerializationConfig(
            encoding: TransactionOutputCborEncoding.shellyEra),
        address: address,
        amount: Value(coin: BigInt.from(435464757)));
    final txo2 = TransactionOutput(
        serializationConfig: TransactionOutputSerializationConfig(
            encoding: TransactionOutputCborEncoding.alonzoEra),
        address: address,
        amount: Value(coin: BigInt.from(435464757)),
        scriptRef:
            ScriptRefNativeScript(NativeScriptTimelockStart(BigInt.from(20))),
        plutusData: DataOptionData(PlutusBytes(value: [
          11,
          239,
          181,
          120,
          142,
          135,
          19,
          200,
          68,
          223,
          211,
          43,
          46,
          145,
          222,
          30,
          48,
          159,
          239,
          255,
          213,
          85,
          248,
          39,
          204,
          158,
          225,
          100,
          1,
          2,
          3,
          4,
        ])));
    final List<TransactionOutput> txos = [];
    txos.add(txo);
    txos.add(txo2);
    txos.add(txo2);
    txos.add(txo);
    txos.add(txo);
    txos.add(txo2);
    final encode = CborListValue.definite(txos.map((e) => e.toCbor()).toList());
    expect(encode.toCborHex(),
        '86825839010ce980b627c4358023d9391a01674389fb4739d8291b01b13ecb62378c500aa3e606d8c552533e3e1817cd29b9adf49a002458d94e33590b1a19f4aa35a4005839010ce980b627c4358023d9391a01674389fb4739d8291b01b13ecb62378c500aa3e606d8c552533e3e1817cd29b9adf49a002458d94e33590b011a19f4aa35028201d818582258200befb5788e8713c844dfd32b2e91de1e309fefffd555f827cc9ee1640102030403d818458200820414a4005839010ce980b627c4358023d9391a01674389fb4739d8291b01b13ecb62378c500aa3e606d8c552533e3e1817cd29b9adf49a002458d94e33590b011a19f4aa35028201d818582258200befb5788e8713c844dfd32b2e91de1e309fefffd555f827cc9ee1640102030403d818458200820414825839010ce980b627c4358023d9391a01674389fb4739d8291b01b13ecb62378c500aa3e606d8c552533e3e1817cd29b9adf49a002458d94e33590b1a19f4aa35825839010ce980b627c4358023d9391a01674389fb4739d8291b01b13ecb62378c500aa3e606d8c552533e3e1817cd29b9adf49a002458d94e33590b1a19f4aa35a4005839010ce980b627c4358023d9391a01674389fb4739d8291b01b13ecb62378c500aa3e606d8c552533e3e1817cd29b9adf49a002458d94e33590b011a19f4aa35028201d818582258200befb5788e8713c844dfd32b2e91de1e309fefffd555f827cc9ee1640102030403d818458200820414');

    final CborListValue<CborObject> decode =
        CborObject.fromCbor(encode.encode()).as();
    final decodeTxos =
        decode.value.map((e) => TransactionOutput.deserialize(e)).toList();
    final newBytes =
        CborListValue.definite(decodeTxos.map((e) => e.toCbor()).toList())
            .encode();
    expect(newBytes, encode.encode());
  });
  test('native script with script hash', () {
    final address = ADAAddress.fromAddress(
        'addr1qyxwnq9kylzrtqprmyu35qt8gwylk3eemq53kqd38m9kyduv2q928esxmrz4y5e78cvp0nffhxklfxsqy3vdjn3nty9s8zygkm');
    final txo = TransactionOutput(
        serializationConfig: TransactionOutputSerializationConfig(
            encoding: TransactionOutputCborEncoding.shellyEra),
        address: address,
        amount: Value(coin: BigInt.from(435464757)));
    final txo2 = TransactionOutput(
        serializationConfig: TransactionOutputSerializationConfig(
            encoding: TransactionOutputCborEncoding.alonzoEra),
        address: address,
        amount: Value(coin: BigInt.from(435464757)),
        scriptRef:
            ScriptRefNativeScript(NativeScriptTimelockStart(BigInt.from(20))),
        plutusData: DataOptionDataHash(DataHash([
          201,
          202,
          203,
          204,
          205,
          206,
          207,
          208,
          209,
          210,
          211,
          212,
          213,
          214,
          215,
          216,
          217,
          218,
          219,
          220,
          221,
          222,
          223,
          224,
          225,
          226,
          227,
          228,
          229,
          230,
          231,
          232,
        ])));
    final List<TransactionOutput> txos = [];
    txos.add(txo);
    txos.add(txo2);
    txos.add(txo2);
    txos.add(txo);
    txos.add(txo);
    txos.add(txo2);
    final encode = CborListValue.definite(txos.map((e) => e.toCbor()).toList());
    expect(encode.toCborHex(),
        '86825839010ce980b627c4358023d9391a01674389fb4739d8291b01b13ecb62378c500aa3e606d8c552533e3e1817cd29b9adf49a002458d94e33590b1a19f4aa35a4005839010ce980b627c4358023d9391a01674389fb4739d8291b01b13ecb62378c500aa3e606d8c552533e3e1817cd29b9adf49a002458d94e33590b011a19f4aa350282005820c9cacbcccdcecfd0d1d2d3d4d5d6d7d8d9dadbdcdddedfe0e1e2e3e4e5e6e7e803d818458200820414a4005839010ce980b627c4358023d9391a01674389fb4739d8291b01b13ecb62378c500aa3e606d8c552533e3e1817cd29b9adf49a002458d94e33590b011a19f4aa350282005820c9cacbcccdcecfd0d1d2d3d4d5d6d7d8d9dadbdcdddedfe0e1e2e3e4e5e6e7e803d818458200820414825839010ce980b627c4358023d9391a01674389fb4739d8291b01b13ecb62378c500aa3e606d8c552533e3e1817cd29b9adf49a002458d94e33590b1a19f4aa35825839010ce980b627c4358023d9391a01674389fb4739d8291b01b13ecb62378c500aa3e606d8c552533e3e1817cd29b9adf49a002458d94e33590b1a19f4aa35a4005839010ce980b627c4358023d9391a01674389fb4739d8291b01b13ecb62378c500aa3e606d8c552533e3e1817cd29b9adf49a002458d94e33590b011a19f4aa350282005820c9cacbcccdcecfd0d1d2d3d4d5d6d7d8d9dadbdcdddedfe0e1e2e3e4e5e6e7e803d818458200820414');

    final CborListValue<CborObject> decode =
        CborObject.fromCbor(encode.encode()).as();
    final decodeTxos =
        decode.value.map((e) => TransactionOutput.deserialize(e)).toList();
    final newBytes =
        CborListValue.definite(decodeTxos.map((e) => e.toCbor()).toList())
            .encode();
    expect(newBytes, encode.encode());
  });
  test('legacy', () {
    final address = ADAAddress.fromAddress(
        'addr1qyxwnq9kylzrtqprmyu35qt8gwylk3eemq53kqd38m9kyduv2q928esxmrz4y5e78cvp0nffhxklfxsqy3vdjn3nty9s8zygkm');
    final txo = TransactionOutput(
        serializationConfig: TransactionOutputSerializationConfig(
            encoding: TransactionOutputCborEncoding.shellyEra),
        address: address,
        amount: Value(coin: BigInt.from(435464757)));
    final txo2 = TransactionOutput(
        serializationConfig: TransactionOutputSerializationConfig(
            encoding: TransactionOutputCborEncoding.shellyEra),
        address: address,
        amount: Value(coin: BigInt.from(435464757)),
        plutusData: DataOptionDataHash(DataHash(List<int>.filled(32, 47))));
    final List<TransactionOutput> txos = [];
    txos.add(txo);
    txos.add(txo2);
    txos.add(txo2);
    txos.add(txo);
    txos.add(txo);
    txos.add(txo2);
    final encode = CborListValue.definite(txos.map((e) => e.toCbor()).toList());
    expect(encode.toCborHex(),
        '86825839010ce980b627c4358023d9391a01674389fb4739d8291b01b13ecb62378c500aa3e606d8c552533e3e1817cd29b9adf49a002458d94e33590b1a19f4aa35835839010ce980b627c4358023d9391a01674389fb4739d8291b01b13ecb62378c500aa3e606d8c552533e3e1817cd29b9adf49a002458d94e33590b1a19f4aa3558202f2f2f2f2f2f2f2f2f2f2f2f2f2f2f2f2f2f2f2f2f2f2f2f2f2f2f2f2f2f2f2f835839010ce980b627c4358023d9391a01674389fb4739d8291b01b13ecb62378c500aa3e606d8c552533e3e1817cd29b9adf49a002458d94e33590b1a19f4aa3558202f2f2f2f2f2f2f2f2f2f2f2f2f2f2f2f2f2f2f2f2f2f2f2f2f2f2f2f2f2f2f2f825839010ce980b627c4358023d9391a01674389fb4739d8291b01b13ecb62378c500aa3e606d8c552533e3e1817cd29b9adf49a002458d94e33590b1a19f4aa35825839010ce980b627c4358023d9391a01674389fb4739d8291b01b13ecb62378c500aa3e606d8c552533e3e1817cd29b9adf49a002458d94e33590b1a19f4aa35835839010ce980b627c4358023d9391a01674389fb4739d8291b01b13ecb62378c500aa3e606d8c552533e3e1817cd29b9adf49a002458d94e33590b1a19f4aa3558202f2f2f2f2f2f2f2f2f2f2f2f2f2f2f2f2f2f2f2f2f2f2f2f2f2f2f2f2f2f2f2f');

    final CborListValue<CborObject> decode =
        CborObject.fromCbor(encode.encode()).as();
    final decodeTxos =
        decode.value.map((e) => TransactionOutput.deserialize(e)).toList();
    final newBytes =
        CborListValue.definite(decodeTxos.map((e) => e.toCbor()).toList())
            .encode();
    expect(newBytes, encode.encode());
  });
}
