import 'package:on_chain/on_chain.dart';
import 'package:test/test.dart';

void main() {
  _serializationScript();
}

void _serializationScript() {
  test("Serialization script", () {
    final script = AptosScript(
        byteCode: List<int>.filled(12, 32),
        typeArgs: [AptosTypeTagBoolean()],
        arguments: [MoveU8(12)]);
    expect(script.toBcsHex(), "0c202020202020202020202020010001000c");
    final decode = AptosScript.deserialize(script.toBcs());
    expect(decode.toBcsHex(), script.toBcsHex());
    expect(decode, script);
  });
  test("Serialization script 2", () {
    final script = AptosScript(byteCode: List<int>.filled(12, 32), typeArgs: [
      AptosTypeTagBoolean(),
      AptosTypeTagNumeric.u8(),
      AptosTypeTagNumeric.u16(),
      AptosTypeTagNumeric.u32(),
      AptosTypeTagNumeric.u64(),
      AptosTypeTagNumeric.u128(),
      AptosTypeTagNumeric.u256(),
      AptosTypeTagGeneric(32),
    ], arguments: [
      MoveU8(12)
    ]);
    expect(script.toBcsHex(),
        "0c202020202020202020202020080001080902030aff012000000001000c");
    final decode = AptosScript.deserialize(script.toBcs());
    expect(decode.toBcsHex(), script.toBcsHex());
    expect(decode, script);
  });
  test("Serialization script 3", () {
    final script = AptosScript(byteCode: List<int>.filled(12, 32), typeArgs: [
      AptosTypeTagBoolean(),
      AptosTypeTagNumeric.u8(),
      AptosTypeTagNumeric.u16(),
      AptosTypeTagNumeric.u32(),
      AptosTypeTagNumeric.u64(),
      AptosTypeTagNumeric.u128(),
      AptosTypeTagNumeric.u256(),
      AptosTypeTagGeneric(32),
      AptosTypeTagVector(AptosTypeTagVector(AptosTypeTagGeneric(12))),
      AptosTypeTagSigner(),
      AptosTypeTagAddress()
    ], arguments: [
      MoveU8(12)
    ]);
    expect(script.toBcsHex(),
        "0c2020202020202020202020200b0001080902030aff01200000000606ff010c000000050401000c");
    final decode = AptosScript.deserialize(script.toBcs());
    expect(decode.toBcsHex(), script.toBcsHex());
    expect(decode, script);
  });
  test("Serialization script 4", () {
    final script = AptosScript(byteCode: List<int>.filled(12, 32), typeArgs: [
      AptosTypeTagBoolean(),
      AptosTypeTagNumeric.u8(),
      AptosTypeTagNumeric.u16(),
      AptosTypeTagNumeric.u32(),
      AptosTypeTagNumeric.u64(),
      AptosTypeTagNumeric.u128(),
      AptosTypeTagNumeric.u256(),
      AptosTypeTagGeneric(32),
      AptosTypeTagVector(AptosTypeTagVector(AptosTypeTagGeneric(12))),
      AptosTypeTagSigner(),
      AptosTypeTagAddress(),
      AptosTypeTagStruct(AptosStructTag(
          address: AptosAddress.one,
          moduleName: "account",
          name: "coin",
          typeArgs: [
            AptosTypeTagAddress(),
          ]))
    ], arguments: [
      MoveU8(12),
      MoveU32(1 << 30),
      MoveU64(BigInt.parse("2500000000000")),
      MoveU128(BigInt.parse("2500000000000")),
      MoveU256(BigInt.parse("2500000000000")),
      MoveAddress(AptosAddress.one.toBcs()),
      MoveSerialized.fromHex("0x01ff0120000000")
    ]);
    expect(script.toBcsHex(),
        "0c2020202020202020202020200c0001080902030aff01200000000606ff010c0000000504070000000000000000000000000000000000000000000000000000000000000001076163636f756e7404636f696e010407000c07000000400100a89c13460200000200a89c134602000000000000000000000800a89c1346020000000000000000000000000000000000000000000000000000030000000000000000000000000000000000000000000000000000000000000001090701ff0120000000");
    final decode = AptosScript.deserialize(script.toBcs());
    expect(decode.toBcsHex(), script.toBcsHex());
    expect(decode, script);
  });
  test("Serialization transcation payload script", () {
    final script = AptosScript(byteCode: List<int>.filled(12, 32), typeArgs: [
      AptosTypeTagBoolean(),
      AptosTypeTagNumeric.u8(),
      AptosTypeTagNumeric.u16(),
      AptosTypeTagNumeric.u32(),
      AptosTypeTagNumeric.u64(),
      AptosTypeTagNumeric.u128(),
      AptosTypeTagNumeric.u256(),
      AptosTypeTagGeneric(32),
      AptosTypeTagVector(AptosTypeTagVector(AptosTypeTagGeneric(12))),
      AptosTypeTagSigner(),
      AptosTypeTagAddress(),
      AptosTypeTagStruct(AptosStructTag(
          address: AptosAddress.one,
          moduleName: "account",
          name: "coin",
          typeArgs: [
            AptosTypeTagAddress(),
          ]))
    ], arguments: [
      MoveU8(12),
      MoveU32(1 << 30),
      MoveU64(BigInt.parse("2500000000000")),
      MoveU128(BigInt.parse("2500000000000")),
      MoveU256(BigInt.parse("2500000000000")),
      AptosAddress.one,
      MoveSerialized.fromHex("0x01ff0120000000")
    ]);
    final payload = AptosTransactionPayloadScript(script: script);
    expect(payload.toVariantBcsHex(),
        "000c2020202020202020202020200c0001080902030aff01200000000606ff010c0000000504070000000000000000000000000000000000000000000000000000000000000001076163636f756e7404636f696e010407000c07000000400100a89c13460200000200a89c134602000000000000000000000800a89c1346020000000000000000000000000000000000000000000000000000030000000000000000000000000000000000000000000000000000000000000001090701ff0120000000");
    final decode = AptosTransactionPayloadScript.deserialize(payload.toBcs());
    expect(decode.toBcsHex(), payload.toBcsHex());
    expect(payload, decode);
  });
}
