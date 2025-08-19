import 'package:blockchain_utils/blockchain_utils.dart';
import 'package:on_chain/ada/ada.dart';
import 'package:test/test.dart';

void main() {
  group('AuxiliaryData Serialization', () {
    _auxiliaryDataSerialization();
    _transactionWithAuxiliaryDataHash();
    _serialization();
  });
}

void _auxiliaryDataSerialization() {
  test('AuxiliaryData_1', () {
    final List<NativeScript> pubkeyNativeScripts = [
      NativeScriptScriptPubkey.fromPubKey(BytesUtils.fromHexString(
          '0071325e6664401e5fffcbce46bd522822e6aa485145b78a6fe556de6b5ec03ec5')),
    ];
    final List<NativeScript> onOfNativeScripts = [
      NativeScriptScriptNOfK(n: 1, nativeScripts: pubkeyNativeScripts)
    ];

    final auxiliaryData = AuxiliaryData(nativeScripts: onOfNativeScripts);
    expect(auxiliaryData.serializeHex(),
        'd90103a10181830301818200581c2a157a27a0621faa83844a697b347cfb40dad3a140f3440be48b3834');
    AuxiliaryData decode =
        AuxiliaryData.fromCborBytes(auxiliaryData.serialize());
    decode = decode.copyWith();
    expect(decode.serialize(), auxiliaryData.serialize());
    final fromJson = AuxiliaryData.fromJson(decode.toJson());
    expect(decode.serialize(), fromJson.serialize());
  });
}

void _transactionWithAuxiliaryDataHash() {
  test('transaction with AuxiliaryDataHash', () {
    final addrOutput = ADABaseAddress(
        'addr_test1qrq9aq9aeun8ull8ha9gv7h72jn95ds9kv42aqcw6plcu8yput3kqejrzx0lt0p49mwq76x8wjm8y7erh0rg0q36cr0sp0wtcr');
    final input = TransactionInput(
        transactionId: TransactionHash(List<int>.filled(32, 0)), index: 0);

    final output = TransactionOutput(
        address: addrOutput,
        amount: Value(coin: BigInt.from(999000)),
        serializationConfig: TransactionOutputSerializationConfig(
            encoding: TransactionOutputCborEncoding.shellyEra));

    final ttl = BigInt.from(1000);
    final fee = BigInt.from(1000);

    final List<NativeScript> pubkeyNativeScripts = [
      NativeScriptScriptPubkey.fromPubKey(BytesUtils.fromHexString(
          '0071325e6664401e5fffcbce46bd522822e6aa485145b78a6fe556de6b5ec03ec5'))
    ];
    final List<NativeScript> onOfNativeScripts = [
      NativeScriptScriptNOfK(n: 1, nativeScripts: pubkeyNativeScripts)
    ];

    // print("on ${onOfNativeScripts.}")

    final auxiliaryData = AuxiliaryData(nativeScripts: onOfNativeScripts);
    final transaction = TransactionBody(
        inputs: TransactionInputs([input],
            serializationConfig: TransactionInputSerializationConfig(
                encoding: CborIterableEncodingType.definite)),
        outputs: TransactionOutputs([output],
            serializationConfig: TransactionOutputsSerializationConfig(
                encoding: CborIterableEncodingType.definite)),
        fee: fee,
        ttl: ttl,
        auxiliaryDataHash: auxiliaryData.toHash());
    expect(transaction.serializeHex(),
        'a50081825820000000000000000000000000000000000000000000000000000000000000000000018182583900c05e80bdcf267e7fe7bf4a867afe54a65a3605b32aae830ed07f8e1c81e2e3606643119ff5bc352edc0f68c774b6727b23bbc687823ac0df1a000f3e58021903e8031903e8075820405971305492ca6a973e13494fa78ffb03d745e78ecc9b8050783e645e95e1a3');
    final fromJson = TransactionBody.fromJson(transaction.toJson());
    expect(fromJson.serializeHex(), transaction.serializeHex());
    final decode = TransactionBody.fromCborBytes(transaction.serialize());
    expect(decode.serializeHex(), fromJson.serializeHex());
  });
}

void _serialization() {
  test('decode encode auxiliaryData', () {
    final au = AuxiliaryData.fromCborBytes(
        BytesUtils.fromHexString('a1182aa163717765187b'));
    expect(au.serializeHex(), 'a1182aa163717765187b');
    final AuxiliaryData fromJson = AuxiliaryData.fromJson(au.toJson());
    expect(fromJson.serializeHex(), 'a1182aa163717765187b');
  });
}
