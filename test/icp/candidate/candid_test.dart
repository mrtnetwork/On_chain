import 'dart:typed_data';
import 'package:on_chain/icp/src/serialization/candid/candid.dart';
import 'package:test/test.dart';

import '../../utils.dart';

void candidTest() {
  group('ICP/LEB128', () {
    test('unsigned roundtrip', () {
      final cases = [
        BigInt.zero,
        BigInt.one,
        BigInt.from(127),
        BigInt.from(128),
        BigInt.from(255),
        BigInt.from(300),
        BigInt.from(0xFFFF),
        BigInt.from(0x10000),
        BigInt.parse('12345678901234567890'),
      ];
      for (final v in cases) {
        final w = ByteDataWriter();
        LEB128.encodeUnsigned(w, v);
        final bytes = w.toBytes();
        final r = ByteDataReader(bytes);
        final decoded = LEB128.decodeUnsigned(r);
        expect(decoded, v, reason: 'unsigned $v');
        expect(r.remaining, 0);
      }
    });

    test('signed roundtrip', () {
      final cases = [
        BigInt.zero,
        BigInt.one,
        BigInt.from(-1),
        BigInt.from(63),
        BigInt.from(-64),
        BigInt.from(64),
        BigInt.from(-65),
        BigInt.from(127),
        BigInt.from(-128),
        BigInt.from(255),
        BigInt.from(-256),
        BigInt.parse('-12345678901234567890'),
        BigInt.parse('12345678901234567890'),
      ];
      for (final v in cases) {
        final w = ByteDataWriter();
        LEB128.encodeSigned(w, v);
        final bytes = w.toBytes();
        final r = ByteDataReader(bytes);
        final decoded = LEB128.decodeSigned(r);
        expect(decoded, v, reason: 'signed $v');
        expect(r.remaining, 0);
      }
    });
  });

  group('ICP/Primitive encode/decode roundtrip', () {
    void checkRoundtrip(IDLValue value, {dynamic matcher}) {
      final bytes = CandidUtils.encodeOne(value);
      expect(bytes.sublist(0, 4), [
        0x44,
        0x49,
        0x44,
        0x4C,
      ], reason: 'magic for $value');
      final decoded = CandidUtils.decodeOne(bytes);
      if (matcher != null) {
        expect(decoded, matcher);
      } else {
        expect(decoded, value, reason: 'roundtrip $value -> $decoded');
      }
    }

    test('null', () => checkRoundtrip(const IDLNull()));
    test('bool true', () => checkRoundtrip(const IDLBool(true)));
    test('bool false', () => checkRoundtrip(const IDLBool(false)));
    test('text', () => checkRoundtrip(const IDLText('hello')));
    test('text empty', () => checkRoundtrip(const IDLText('')));
    test('nat 0', () => checkRoundtrip(IDLNat(BigInt.zero)));
    test('nat 42', () => checkRoundtrip(IDLNat(BigInt.from(42))));
    test(
      'nat large',
      () => checkRoundtrip(
        IDLNat(BigInt.parse('123456789012345678901234567890')),
      ),
    );
    test('int positive', () => checkRoundtrip(IDLInt(BigInt.from(42))));
    test('int negative', () => checkRoundtrip(IDLInt(BigInt.from(-42))));
    test(
      'int large',
      () => checkRoundtrip(IDLInt(BigInt.parse('-99999999999999999999'))),
    );
    test('nat8', () => checkRoundtrip(const IDLNat8(255)));
    test('nat16', () => checkRoundtrip(const IDLNat16(65535)));
    test('nat32', () => checkRoundtrip(const IDLNat32(0xFFFFFFFF)));
    test('nat64 large', () {
      final bytes = CandidUtils.encodeOne(
        IDLNat64(BigInt.parse('18446744073709551615')),
      ); // max u64
      final decoded = CandidUtils.decodeOne(bytes) as IDLNat64;
      expect(decoded.v, BigInt.parse('18446744073709551615'));
    });
    test('nat64 mid', () {
      final bytes = CandidUtils.encodeOne(
        IDLNat64(BigInt.parse('0x7FFFFFFFFFFFFFFF')),
      );
      final decoded = CandidUtils.decodeOne(bytes) as IDLNat64;
      expect(decoded.v, BigInt.parse('0x7FFFFFFFFFFFFFFF'));
    });
    test('int8', () => checkRoundtrip(const IDLInt8(-128)));
    test('int16', () => checkRoundtrip(const IDLInt16(-32768)));
    test('int32', () => checkRoundtrip(const IDLInt32(-2147483648)));
    test('int64 value', () {
      final bytes = CandidUtils.encodeOne(IDLInt64(BigInt.from(-42)));
      final decoded = CandidUtils.decodeOne(bytes) as IDLInt64;
      expect(decoded.v, BigInt.from(-42));
    });
    test('int64 min', () {
      final min = -(BigInt.one << 63);
      final bytes = CandidUtils.encodeOne(IDLInt64(min));
      final decoded = CandidUtils.decodeOne(bytes) as IDLInt64;
      expect(decoded.v, min);
    });
    test('float32', () {
      final bytes = CandidUtils.encodeOne(const IDLFloat32(3.14));
      final decoded = CandidUtils.decodeOne(bytes) as IDLFloat32;
      expect(decoded.v, closeTo(3.14, 1e-5));
    });
    test('float64', () {
      final bytes = CandidUtils.encodeOne(const IDLFloat64(2.718281828));
      final decoded = CandidUtils.decodeOne(bytes) as IDLFloat64;
      expect(decoded.v, closeTo(2.718281828, 1e-9));
    });
    test('none', () => checkRoundtrip(const IDLNone()));
  });

  group('ICP/Compound types', () {
    test('opt some', () {
      final v = IDLOpt(IDLNat(BigInt.from(7)));
      final bytes = CandidUtils.encodeOne(v);
      final decoded = CandidUtils.decodeOne(bytes);
      expect(decoded, isA<IDLOpt>());
      expect((decoded as IDLOpt).v, IDLNat(BigInt.from(7)));
    });

    test('opt none via IDLNone', () {
      final bytes = CandidUtils.encodeOne(const IDLNone());
      final decoded = CandidUtils.decodeOne(bytes);
      expect(decoded, const IDLNone());
    });

    test('vec of nats', () {
      final v = IDLVec([
        IDLNat(BigInt.from(1)),
        IDLNat(BigInt.from(2)),
        IDLNat(BigInt.from(3)),
      ]);
      final bytes = CandidUtils.encodeOne(v);
      final decoded = CandidUtils.decodeOne(bytes) as IDLVec;
      expect(decoded.values.length, 3);
      expect(decoded.values[0], IDLNat(BigInt.from(1)));
      expect(decoded.values[1], IDLNat(BigInt.from(2)));
      expect(decoded.values[2], IDLNat(BigInt.from(3)));
    });

    test('empty vec', () {
      final v = const IDLVec([]);
      final bytes = CandidUtils.encodeOne(v);
      final decoded = CandidUtils.decodeOne(bytes) as IDLVec;
      expect(decoded.values, isEmpty);
    });

    test('record simple', () {
      final fields = [
        IDLField(Label.named('x'), IDLNat(BigInt.from(10))),
        IDLField(Label.named('y'), const IDLText('hi')),
      ];
      fields.sort((a, b) => a.id.compareTo(b.id));
      final v = IDLRecord(fields);
      final bytes = CandidUtils.encodeOne(v);
      final decoded = CandidUtils.decodeOne(bytes) as IDLRecord;
      expect(decoded.fields.length, 2);
      // values present
      final vals = decoded.fields.map((f) => f.val).toList();
      expect(vals.any((v) => v is IDLNat && (v).v == BigInt.from(10)), isTrue);
      expect(vals.any((v) => v is IDLText && (v).v == 'hi'), isTrue);
    });

    test('variant', () {
      final field = IDLField(Label.named('ok'), IDLNat(BigInt.from(42)));
      final v = IDLVariant(field, 0);
      final bytes = CandidUtils.encodeOne(v);
      final decoded = CandidUtils.decodeOne(bytes) as IDLVariant;
      expect(decoded.field.val, IDLNat(BigInt.from(42)));
    });

    test('blob as vec nat8', () {
      final v = IDLBlob(Uint8List.fromList([1, 2, 3, 4]));
      final bytes = CandidUtils.encodeOne(v);
      final decoded = CandidUtils.decodeOne(bytes);
      expect(decoded is IDLVec || decoded is IDLBlob, isTrue);
      if (decoded is IDLVec) {
        expect(decoded.values.length, 4);
      } else if (decoded is IDLBlob) {
        expect(decoded.v, [1, 2, 3, 4]);
      }
    });
  });

  group('ICP/Multiple args', () {
    test('CandidUtils.encodeArgs / CandidUtils.decodeArgs', () {
      final values = [
        const IDLBool(true),
        IDLNat(BigInt.from(99)),
        const IDLText('candid'),
      ];
      final bytes = CandidUtils.encodeArgs(values);
      final decoded = CandidUtils.decodeArgs(bytes);
      expect(decoded.length, 3);
      expect(decoded[0], const IDLBool(true));
      expect(decoded[1], IDLNat(BigInt.from(99)));
      expect(decoded[2], const IDLText('candid'));
    });
  });

  group('ICP/Known binary fixtures', () {
    test('null value fixture', () {
      final bytes = Uint8List.fromList([
        0x44,
        0x49,
        0x44,
        0x4C,
        0x00,
        0x01,
        0x7f,
      ]);
      final decoded = CandidUtils.decodeOne(bytes);
      expect(decoded, const IDLNull());
    });

    test('bool true fixture', () {
      final bytes = Uint8List.fromList([
        0x44,
        0x49,
        0x44,
        0x4C,
        0x00,
        0x01,
        0x7e,
        0x01,
      ]);
      final decoded = CandidUtils.decodeOne(bytes);
      expect(decoded, const IDLBool(true));
    });

    test('text hello fixture', () {
      final bytes = Uint8List.fromList([
        0x44,
        0x49,
        0x44,
        0x4C,
        0x00,
        0x01,
        0x71,
        0x05,
        0x68,
        0x65,
        0x6c,
        0x6c,
        0x6f,
      ]);
      final decoded = CandidUtils.decodeOne(bytes);
      expect(decoded, const IDLText('hello'));
    });

    test('nat 42 fixture', () {
      final bytes = Uint8List.fromList([
        0x44,
        0x49,
        0x44,
        0x4C,
        0x00,
        0x01,
        0x7d,
        0x2a,
      ]);
      final decoded = CandidUtils.decodeOne(bytes);
      expect(decoded, IDLNat(BigInt.from(42)));
    });
  });

  group('ICP/IDL hash', () {
    test('basic properties', () {
      expect(Label.idlHash(''), 0);
      final h = Label.idlHash('name');
      expect(h, isNonNegative);
      expect(h, lessThanOrEqualTo(0xFFFFFFFF));
      // stable
      expect(Label.idlHash('name'), Label.idlHash('name'));
      expect(Label.idlHash('x') != Label.idlHash('y'), isTrue);
    });
  });
}

void main() {
  OnChainUtilsTestApi.runTest(candidTest, "Candid");
}
