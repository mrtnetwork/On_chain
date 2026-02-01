import 'package:blockchain_utils/blockchain_utils.dart';
import 'package:on_chain/on_chain.dart';
import 'package:test/test.dart';

void main() {
  _test();
}

void _test() {
  test("MoveVector serialization", () {
    MoveVector type = MoveVector.u8([1]);
    expect(
        type.toBcs(), LayoutConst.bcsVector(LayoutConst.u8()).serialize([1]));
    type = MoveVector.u32([(1 << 31) - 1]);
    expect(
        type.toBcs(),
        LayoutConst.bcsVector(LayoutConst.u32())
            .serialize(<int>[((BigInt.one << 31) - BigInt.one).toInt()]));
    type = MoveVector.string(["MRTNETWORK"]);
    expect(
        type.toBcs(),
        LayoutConst.bcsVector(LayoutConst.bcsString())
            .serialize(["MRTNETWORK"]));
    type = MoveVector([MoveOption(MoveString("MRTNETWORK"))]);
    expect(
        type.toBcs(),
        LayoutConst.bcsVector(LayoutConst.optional(LayoutConst.bcsString()))
            .serialize(["MRTNETWORK"]));
    type = MoveVector([
      MoveOption(MoveString("MRTNETWORK")),
      MoveOption(null),
      MoveOption(MoveString("MRT"))
    ]);
    expect(
        type.toBcs(),
        LayoutConst.bcsVector(LayoutConst.optional(LayoutConst.bcsString()))
            .serialize(["MRTNETWORK", null, "MRT"]));
  });

  test("MoveU8 serialization", () {
    MoveType type = MoveU8(1);
    expect(type.toBcs(), LayoutConst.u8().serialize(1));
    type = MoveU8(50);
    expect(type.toBcs(), LayoutConst.u8().serialize(50));
    expect(
        () => MoveU8(256), throwsA(TypeMatcher<BcsSerializationException>()));
    expect(() => MoveU8(-1), throwsA(TypeMatcher<BcsSerializationException>()));
  });
  test("MoveU16 serialization", () {
    MoveType type = MoveU16(1);
    expect(type.toBcs(), LayoutConst.u16().serialize(1));
    type = MoveU16(50);
    expect(type.toBcs(), LayoutConst.u16().serialize(50));
    expect(() => MoveU16(1 << 16),
        throwsA(TypeMatcher<BcsSerializationException>()));
    expect(
        () => MoveU16(-1), throwsA(TypeMatcher<BcsSerializationException>()));
  });
  test("MoveU32 serialization", () {
    MoveType type = MoveU32(1);
    expect(type.toBcs(), LayoutConst.u32().serialize(1));
    type = MoveU32(50);
    expect(type.toBcs(), LayoutConst.u32().serialize(50));
    expect(() => MoveU32((BigInt.one << 32).toInt()),
        throwsA(TypeMatcher<BcsSerializationException>()));
    expect(
        () => MoveU32(-1), throwsA(TypeMatcher<BcsSerializationException>()));
  });
  test("MoveU64 serialization", () {
    MoveType type = MoveU64.parse(1);
    expect(type.toBcs(), LayoutConst.u64().serialize(BigInt.one));
    type = MoveU64((BigInt.one << 64) - BigInt.one);
    expect(type.toBcs(),
        LayoutConst.u64().serialize((BigInt.one << 64) - BigInt.one));
    expect(() => MoveU64(BigInt.one << 64),
        throwsA(TypeMatcher<BcsSerializationException>()));
    expect(() => MoveU64.parse(-1),
        throwsA(TypeMatcher<BcsSerializationException>()));
  });
  test("MoveU128 serialization", () {
    MoveType type = MoveU128.parse(1);
    // type.setValue(1);
    expect(type.toBcs(), LayoutConst.u128().serialize(BigInt.one));
    type = MoveU128((BigInt.one << 128) - BigInt.one);
    expect(type.toBcs(),
        LayoutConst.u128().serialize((BigInt.one << 128) - BigInt.one));
    expect(() => MoveU128(BigInt.one << 128),
        throwsA(TypeMatcher<BcsSerializationException>()));
    expect(() => MoveU128.parse(-1),
        throwsA(TypeMatcher<BcsSerializationException>()));
  });
  test("MoveU256 serialization", () {
    MoveType type = MoveU256.parse(1);

    expect(type.toBcs(), LayoutConst.u256().serialize(BigInt.one));
    type = MoveU256((BigInt.one << 256) - BigInt.one);
    expect(type.toBcs(),
        LayoutConst.u256().serialize((BigInt.one << 256) - BigInt.one));
    expect(() => MoveU256(BigInt.one << 256),
        throwsA(TypeMatcher<BcsSerializationException>()));
    expect(() => MoveU256.parse(-1),
        throwsA(TypeMatcher<BcsSerializationException>()));
  });
  test("MoveBool serialization", () {
    MoveType type = MoveBool.parse(1);
    expect(type.toBcs(), LayoutConst.boolean().serialize(true));
    type = MoveBool(false);
    expect(type.toBcs(), LayoutConst.boolean().serialize(false));
    type = MoveBool.parse(0);
    expect(type.toBcs(), LayoutConst.boolean().serialize(false));
    type = MoveBool(true);
    expect(type.toBcs(), LayoutConst.boolean().serialize(true));
    type = MoveBool.parse('true');
    expect(type.toBcs(), LayoutConst.boolean().serialize(true));
    type = MoveBool.parse('false');
    expect(type.toBcs(), LayoutConst.boolean().serialize(false));
    expect(() => MoveBool.parse(2),
        throwsA(TypeMatcher<BcsSerializationException>()));
    expect(() => MoveBool.parse(-1),
        throwsA(TypeMatcher<BcsSerializationException>()));
    expect(() => MoveBool.parse('Fals'),
        throwsA(TypeMatcher<BcsSerializationException>()));
    expect(() => MoveBool.parse('TRU'),
        throwsA(TypeMatcher<BcsSerializationException>()));
  });
  test("MoveString serialization", () {
    MoveType type = MoveString('MRTNETWORK');
    expect(type.toBcs(), LayoutConst.bcsString().serialize("MRTNETWORK"));
    type = MoveString("a");
    expect(type.toBcs(), LayoutConst.bcsString().serialize("a"));
    type = MoveString("123123123123123");
    expect(type.toBcs(), LayoutConst.bcsString().serialize("123123123123123"));

    expect(() => MoveString.parse(2),
        throwsA(TypeMatcher<BcsSerializationException>()));
    expect(() => MoveString.parse(-1),
        throwsA(TypeMatcher<BcsSerializationException>()));
    expect(() => MoveString.parse(false),
        throwsA(TypeMatcher<BcsSerializationException>()));
    expect(() => MoveString.parse(true),
        throwsA(TypeMatcher<BcsSerializationException>()));
  });

  test("MoveVecOption serialization", () {
    MoveType type = MoveOption(MoveU8(0x00));
    expect(type.toBcs(), LayoutConst.optional(LayoutConst.u8()).serialize(0));
    type = MoveOption(null);
    expect(
        type.toBcs(), LayoutConst.optional(LayoutConst.u8()).serialize(null));
    type = MoveOption(MoveU32(1 << 31));
    expect(type.toBcs(),
        LayoutConst.optional(LayoutConst.u32()).serialize(1 << 31));
    expect(() => MoveOption(MoveU32((BigInt.one << 32).toInt())),
        throwsA(TypeMatcher<BcsSerializationException>()));
    type = MoveOption(MoveString('MRTNETWORK'));
    expect(type.toBcs(),
        LayoutConst.optional(LayoutConst.bcsString()).serialize("MRTNETWORK"));
    type = MoveOption(null);
    expect(type.toBcs(), [0]);
    type = MoveOption(MoveVector.u8(List<int>.filled(32, 1)));
    expect(
        type.toBcs(),
        LayoutConst.optional(LayoutConst.bcsBytes())
            .serialize(List<int>.filled(32, 1)));

    type = MoveOption(MoveVector([MoveU128(BigInt.one << 127)]));
    expect(
        type.toBcs(),
        LayoutConst.optional(LayoutConst.bcsVector(LayoutConst.u128()))
            .serialize([BigInt.one << 127]));
  });
}
