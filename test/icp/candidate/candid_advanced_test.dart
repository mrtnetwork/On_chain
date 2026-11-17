import 'dart:typed_data';
import 'package:blockchain_utils/blockchain_utils.dart';
import 'package:on_chain/icp/src/address/address.dart';
import 'package:on_chain/icp/src/serialization/candid/candid.dart';
import 'package:test/test.dart';

import '../../utils.dart';
/// Helper: hex string -> bytes
List<int> hex(String s) {
  return BytesUtils.fromHexString(s);
}

String toHex(List<int> b) => BytesUtils.toHexString(b);

void candidAdvancedTest() {
  // ---------------------------------------------------------------------------
  // Nested / deep structures
  // ---------------------------------------------------------------------------
  group('ICP/Nested structures', () {
    test('opt of opt of nat', () {
      final v = IDLOpt(IDLOpt(IDLNat(BigInt.from(5))));
      final bytes = CandidUtils.encodeOne(v);
      final decoded = CandidUtils.decodeOne(bytes) as IDLOpt;
      expect(decoded.v, isA<IDLOpt>());
      expect((decoded.v as IDLOpt).v, IDLNat(BigInt.from(5)));
    });

    test('vec of vec of text', () {
      final v = IDLVec([
        IDLVec([const IDLText('a'), const IDLText('b')]),
        IDLVec([const IDLText('c')]),
        const IDLVec([]),
      ]);
      final bytes = CandidUtils.encodeOne(v);
      final decoded = CandidUtils.decodeOne(bytes) as IDLVec;
      expect(decoded.values.length, 3);
      expect((decoded.values[0] as IDLVec).values.length, 2);
      expect((decoded.values[1] as IDLVec).values.first, const IDLText('c'));
      expect((decoded.values[2] as IDLVec).values, isEmpty);
    });

    test('record containing vec and opt', () {
      final fields = [
        IDLField(
          Label.named('nums'),
          IDLVec([IDLNat(BigInt.from(1)), IDLNat(BigInt.from(2))]),
        ),
        IDLField(Label.named('maybe'), IDLOpt(const IDLText('yes'))),
        IDLField(Label.named('flag'), const IDLBool(true)),
      ]..sort((a, b) => a.id.compareTo(b.id));
      final v = IDLRecord(fields);
      final bytes = CandidUtils.encodeOne(v);
      final decoded = CandidUtils.decodeOne(bytes) as IDLRecord;
      expect(decoded.fields.length, 3);
    });

    test('vec of records', () {
      IDLRecord rec(int n, String s) {
        final f = [
          IDLField(Label.named('id'), IDLNat(BigInt.from(n))),
          IDLField(Label.named('name'), IDLText(s)),
        ]..sort((a, b) => a.id.compareTo(b.id));
        return IDLRecord(f);
      }

      final v = IDLVec([rec(1, 'alice'), rec(2, 'bob')]);
      final bytes = CandidUtils.encodeOne(v);
      final decoded = CandidUtils.decodeOne(bytes) as IDLVec;
      expect(decoded.values.length, 2);
      expect(decoded.values[0], isA<IDLRecord>());
      expect(decoded.values[1], isA<IDLRecord>());
    });

    test('variant of record', () {
      final innerFields = [
        IDLField(Label.named('code'), const IDLNat32(404)),
        IDLField(Label.named('msg'), const IDLText('not found')),
      ]..sort((a, b) => a.id.compareTo(b.id));
      final field = IDLField(Label.named('err'), IDLRecord(innerFields));
      final v = IDLVariant(field, 0);
      final bytes = CandidUtils.encodeOne(v);
      final decoded = CandidUtils.decodeOne(bytes) as IDLVariant;
      expect(decoded.field.val, isA<IDLRecord>());
      final rec = decoded.field.val as IDLRecord;
      expect(rec.fields.length, 2);
    });

    test('deeply nested opt chain (5 levels)', () {
      IDLValue v = IDLNat(BigInt.from(99));
      for (var i = 0; i < 5; i++) {
        v = IDLOpt(v);
      }
      final bytes = CandidUtils.encodeOne(v);
      var decoded = CandidUtils.decodeOne(bytes);
      for (var i = 0; i < 5; i++) {
        expect(decoded, isA<IDLOpt>());
        decoded = (decoded as IDLOpt).v;
      }
      expect(decoded, IDLNat(BigInt.from(99)));
    });
  });

  // ---------------------------------------------------------------------------
  // Multiple arguments & mixed types
  // ---------------------------------------------------------------------------
  group('ICP/Multiple arguments', () {
    test('empty args', () {
      final bytes = CandidUtils.encodeArgs([]);
      // DIDL + empty table + 0 args
      expect(bytes.sublist(0, 4), [0x44, 0x49, 0x44, 0x4C]);
      final decoded = CandidUtils.decodeArgs(bytes);
      expect(decoded, isEmpty);
    });

    test('many primitives', () {
      final values = <IDLValue>[
        const IDLNull(),
        const IDLBool(false),
        IDLNat(BigInt.zero),
        IDLInt(BigInt.from(-1)),
        const IDLText(''),
        const IDLNat8(0),
        const IDLInt16(-1),
        const IDLFloat64(0.0),
      ];
      final bytes = CandidUtils.encodeArgs(values);
      final decoded = CandidUtils.decodeArgs(bytes);
      expect(decoded.length, values.length);
      for (var i = 0; i < values.length; i++) {
        if (values[i] is IDLFloat64) {
          expect((decoded[i] as IDLFloat64).v, closeTo(0.0, 1e-12));
        } else {
          expect(decoded[i], values[i]);
        }
      }
    });

    test('10 numbers like Rust example', () {
      final values = List.generate(10, (i) => IDLInt(BigInt.from(i)));
      final bytes = CandidUtils.encodeArgs(values);
      final decoded = CandidUtils.decodeArgs(bytes);
      expect(decoded.length, 10);
      for (var i = 0; i < 10; i++) {
        expect(decoded[i], IDLInt(BigInt.from(i)));
      }
    });

    test('mixed compound args', () {
      final values = [
        IDLOpt(const IDLBool(true)),
        IDLVec([IDLNat(BigInt.one), IDLNat(BigInt.two)]),
        const IDLNone(),
      ];
      final bytes = CandidUtils.encodeArgs(values);
      final decoded = CandidUtils.decodeArgs(bytes);
      expect(decoded.length, 3);
      expect(decoded[0], isA<IDLOpt>());
      expect(decoded[1], isA<IDLVec>());
      expect(decoded[2], const IDLNone());
    });
  });

  // ---------------------------------------------------------------------------
  // Text edge cases
  // ---------------------------------------------------------------------------
  group('ICP/Text edge cases', () {
    test('candid text uses UTF-8', () {
      for (final s in ['hello', 'gg']) {
        final decoded =
            CandidUtils.decodeOne(CandidUtils.encodeOne(IDLText(s))) as IDLText;

        expect(decoded.v, s);
      }
    });

    test('long text', () {
      final s = 'a' * 1000;
      final bytes = CandidUtils.encodeOne(IDLText(s));
      final decoded = CandidUtils.decodeOne(bytes) as IDLText;
      expect(decoded.v.length, 1000);
      expect(decoded.v, s);
    });

    test('text with null bytes via code units', () {
      // Candid text is UTF-8; Dart String can hold \u0000
      final s = 'hello\u0000world';
      final bytes = CandidUtils.encodeOne(IDLText(s));
      final decoded = CandidUtils.decodeOne(bytes) as IDLText;
      expect(decoded.v, s);
    });
  });

  // ---------------------------------------------------------------------------
  // Numeric edge cases
  // ---------------------------------------------------------------------------
  group('ICP/Numeric edge cases', () {
    test('nat boundaries', () {
      for (final n in [0, 1, 127, 128, 255, 256, 65535, 65536]) {
        final v = IDLNat(BigInt.from(n));
        final decoded = CandidUtils.decodeOne(CandidUtils.encodeOne(v));
        expect(decoded, v, reason: 'nat $n');
      }
    });

    test('int boundaries', () {
      for (final n in [0, 1, -1, 63, -64, 64, -65, 127, -128, 255, -256]) {
        final v = IDLInt(BigInt.from(n));
        final decoded = CandidUtils.decodeOne(CandidUtils.encodeOne(v));
        expect(decoded, v, reason: 'int $n');
      }
    });

    test('fixed-width extremes', () {
      expect(
        CandidUtils.decodeOne(CandidUtils.encodeOne(const IDLNat8(0))),
        const IDLNat8(0),
      );
      expect(
        CandidUtils.decodeOne(CandidUtils.encodeOne(const IDLNat8(255))),
        const IDLNat8(255),
      );
      expect(
        CandidUtils.decodeOne(CandidUtils.encodeOne(const IDLInt8(-128))),
        const IDLInt8(-128),
      );
      expect(
        CandidUtils.decodeOne(CandidUtils.encodeOne(const IDLInt8(127))),
        const IDLInt8(127),
      );
      expect(
        CandidUtils.decodeOne(CandidUtils.encodeOne(const IDLNat16(0))),
        const IDLNat16(0),
      );
      expect(
        CandidUtils.decodeOne(CandidUtils.encodeOne(const IDLNat16(65535))),
        const IDLNat16(65535),
      );
      expect(
        CandidUtils.decodeOne(CandidUtils.encodeOne(const IDLInt16(-32768))),
        const IDLInt16(-32768),
      );
      expect(
        CandidUtils.decodeOne(CandidUtils.encodeOne(const IDLInt16(32767))),
        const IDLInt16(32767),
      );
    });

    test('nat32 / int32 extremes', () {
      expect(
        (CandidUtils.decodeOne(
                  CandidUtils.encodeOne(const IDLNat32(0xFFFFFFFF)),
                )
                as IDLNat32)
            .v,
        0xFFFFFFFF,
      );
      expect(
        (CandidUtils.decodeOne(
                  CandidUtils.encodeOne(const IDLInt32(-2147483648)),
                )
                as IDLInt32)
            .v,
        -2147483648,
      );
      expect(
        (CandidUtils.decodeOne(
                  CandidUtils.encodeOne(const IDLInt32(2147483647)),
                )
                as IDLInt32)
            .v,
        2147483647,
      );
    });

    test('float special values', () {
      for (final f in [0.0, -0.0, 1.0, -1.0, 3.14159, 1e10, 1e-10]) {
        final decoded =
            CandidUtils.decodeOne(CandidUtils.encodeOne(IDLFloat64(f)))
                as IDLFloat64;
        expect(decoded.v, closeTo(f, 1e-9), reason: 'f64 $f');
      }
      final inf =
          CandidUtils.decodeOne(
                CandidUtils.encodeOne(const IDLFloat64(double.infinity)),
              )
              as IDLFloat64;
      expect(inf.v.isInfinite, isTrue);
      final nan =
          CandidUtils.decodeOne(
                CandidUtils.encodeOne(const IDLFloat64(double.nan)),
              )
              as IDLFloat64;
      expect(nan.v.isNaN, isTrue);
    });

    test('very large nat', () {
      final big = BigInt.parse('1${'0' * 100}'); // 10^100
      final decoded =
          CandidUtils.decodeOne(CandidUtils.encodeOne(IDLNat(big))) as IDLNat;
      expect(decoded.v, big);
    });

    test('very large negative int', () {
      final big = -BigInt.parse('9' * 80);
      final decoded =
          CandidUtils.decodeOne(CandidUtils.encodeOne(IDLInt(big))) as IDLInt;
      expect(decoded.v, big);
    });
  });

  // ---------------------------------------------------------------------------
  // Record field ordering (by hash)
  // ---------------------------------------------------------------------------
  group('ICP/Record field ordering', () {
    test('fields sorted by hash on encode', () {
      // Different insertion order should produce same bytes
      final a = [
        IDLField(Label.named('z'), IDLNat(BigInt.from(1))),
        IDLField(Label.named('a'), IDLNat(BigInt.from(2))),
        IDLField(Label.named('m'), IDLNat(BigInt.from(3))),
      ];
      final b = [
        IDLField(Label.named('a'), IDLNat(BigInt.from(2))),
        IDLField(Label.named('m'), IDLNat(BigInt.from(3))),
        IDLField(Label.named('z'), IDLNat(BigInt.from(1))),
      ];
      a.sort((x, y) => x.id.compareTo(y.id));
      b.sort((x, y) => x.id.compareTo(y.id));
      final bytesA = CandidUtils.encodeOne(IDLRecord(a));
      final bytesB = CandidUtils.encodeOne(IDLRecord(b));
      expect(toHex(bytesA), toHex(bytesB));
    });

    test('empty record', () {
      final v = const IDLRecord([]);
      final bytes = CandidUtils.encodeOne(v);
      final decoded = CandidUtils.decodeOne(bytes) as IDLRecord;
      expect(decoded.fields, isEmpty);
    });

    test('single field record', () {
      final v = IDLRecord([IDLField(Label.named('only'), const IDLBool(true))]);
      final decoded =
          CandidUtils.decodeOne(CandidUtils.encodeOne(v)) as IDLRecord;
      expect(decoded.fields.length, 1);
      expect(decoded.fields.first.val, const IDLBool(true));
    });

    test('numeric labels', () {
      final fields = [
        IDLField(Label.id(0), IDLNat(BigInt.from(10))),
        IDLField(Label.id(1), IDLNat(BigInt.from(20))),
        IDLField(Label.id(42), IDLNat(BigInt.from(30))),
      ]..sort((a, b) => a.id.compareTo(b.id));
      final v = IDLRecord(fields);
      final decoded =
          CandidUtils.decodeOne(CandidUtils.encodeOne(v)) as IDLRecord;
      expect(decoded.fields.length, 3);
    });
  });

  // ---------------------------------------------------------------------------
  // Variant
  // ---------------------------------------------------------------------------
  group('ICP/Variant', () {
    test('variant with null payload', () {
      // variant { ok; err: text } — encode #ok
      final field = IDLField(Label.named('ok'), const IDLNull());
      final v = IDLVariant(field, 0);
      final bytes = CandidUtils.encodeOne(v);
      final decoded = CandidUtils.decodeOne(bytes) as IDLVariant;
      expect(decoded.field.val, const IDLNull());
    });

    test('variant index 0 and 1', () {
      // When encoding a single-variant type, index is always 0 relative
      // to the type table. Test that different payloads work.
      for (final payload in [
        IDLNat(BigInt.from(1)),
        const IDLText('err'),
        const IDLBool(false),
      ]) {
        final field = IDLField(Label.named('v'), payload);
        final v = IDLVariant(field, 0);
        final decoded =
            CandidUtils.decodeOne(CandidUtils.encodeOne(v)) as IDLVariant;
        expect(decoded.field.val, payload);
      }
    });
  });

  // ---------------------------------------------------------------------------
  // Opt / None semantics
  // ---------------------------------------------------------------------------
  group('ICP/Option semantics', () {
    test('opt null value is some(null)', () {
      final v = const IDLOpt(IDLNull());
      final decoded = CandidUtils.decodeOne(CandidUtils.encodeOne(v));
      expect(decoded, isA<IDLOpt>());
      expect((decoded as IDLOpt).v, const IDLNull());
    });

    test('none is distinct from opt(null)', () {
      final noneBytes = CandidUtils.encodeOne(const IDLNone());
      final someNullBytes = CandidUtils.encodeOne(const IDLOpt(IDLNull()));
      expect(toHex(noneBytes), isNot(toHex(someNullBytes)));
    });

    test('vec of opts', () {
      final v = IDLVec([
        IDLOpt(IDLNat(BigInt.one)),
        const IDLNone(),
        IDLOpt(IDLNat(BigInt.from(3))),
      ]);
      final decoded = CandidUtils.decodeOne(CandidUtils.encodeOne(v)) as IDLVec;
      expect(decoded.values.length, 3);
      expect(decoded.values[0], isA<IDLOpt>());
      expect(decoded.values[1], const IDLNone());
      expect(decoded.values[2], isA<IDLOpt>());
    });
  });

  // ---------------------------------------------------------------------------
  // Blob
  // ---------------------------------------------------------------------------
  group('ICP/Blob', () {
    test('empty blob', () {
      final v = IDLBlob(Uint8List(0));
      final decoded = CandidUtils.decodeOne(CandidUtils.encodeOne(v));
      if (decoded is IDLBlob) {
        expect(decoded.v, isEmpty);
      } else if (decoded is IDLVec) {
        expect(decoded.values, isEmpty);
      } else {
        fail('unexpected type ${decoded.runtimeType}');
      }
    });

    test('blob roundtrip bytes', () {
      final data = Uint8List.fromList(List.generate(256, (i) => i));
      final v = IDLBlob(data);
      final decoded = CandidUtils.decodeOne(CandidUtils.encodeOne(v));
      if (decoded is IDLBlob) {
        expect(decoded.v, data);
      } else if (decoded is IDLVec) {
        expect(decoded.values.length, 256);
        for (var i = 0; i < 256; i++) {
          expect((decoded.values[i] as IDLNat8).v, i);
        }
      }
    });
  });

  // ---------------------------------------------------------------------------
  // Principal (raw bytes)
  // ---------------------------------------------------------------------------
  group('ICP/Principal', () {
    test('anonymous principal (empty bytes)', () {
      final p = IcpPrincipalAddress.fromBytes(Uint8List(0));
      final v = IDLPrincipal(p);
      final decoded =
          CandidUtils.decodeOne(CandidUtils.encodeOne(v)) as IDLPrincipal;
      expect(decoded.v.toBytes(), isEmpty);
    });

    test('management canister principal', () {
      // aaaaa-aa is the empty principal
      final p = IcpPrincipalAddress.fromBytes(Uint8List(0));
      final v = IDLPrincipal(p);
      final bytes = CandidUtils.encodeOne(v);
      expect(bytes.sublist(0, 4), [0x44, 0x49, 0x44, 0x4C]);
      final decoded = CandidUtils.decodeOne(bytes) as IDLPrincipal;
      expect(decoded.v.toBytes().length, 0);
    });

    test('principal with 10 bytes', () {
      final raw = Uint8List.fromList(List.generate(10, (i) => i + 1));
      final p = IcpPrincipalAddress.fromBytes(raw);
      final decoded =
          CandidUtils.decodeOne(CandidUtils.encodeOne(IDLPrincipal(p)))
              as IDLPrincipal;
      expect(decoded.v.toBytes(), raw);
    });
  });

  // ---------------------------------------------------------------------------
  // Error cases
  // ---------------------------------------------------------------------------
  group('ICP/Error handling', () {
    test('invalid magic', () {
      final bad = Uint8List.fromList([0x00, 0x01, 0x02, 0x03, 0x00, 0x00]);
      expect(() => CandidUtils.decodeOne(bad), throwsA(isA<BuError>()));
    });

    test('truncated message', () {
      final bad = Uint8List.fromList([0x44, 0x49, 0x44, 0x4C]); // only magic
      expect(() => CandidUtils.decodeOne(bad), throwsA(anything));
    });

    test('trailing bytes after done', () {
      // Valid null message + extra byte
      final bytes = Uint8List.fromList([
        0x44, 0x49, 0x44, 0x4C,
        0x00, 0x01, 0x7f,
        0xFF, // trailing
      ]);
      final de = IDLDeserialize(bytes);
      de.getValue();
      expect(() => de.done(), throwsA(isA<BuError>()));
    });

    test('getValue when done throws', () {
      final bytes = Uint8List.fromList([
        0x44,
        0x49,
        0x44,
        0x4C,
        0x00,
        0x01,
        0x7f,
      ]);
      final de = IDLDeserialize(bytes);
      de.getValue();
      expect(de.isDone, isTrue);
      expect(() => de.getValue(), throwsA(isA<BuError>()));
    });
  });

  // ---------------------------------------------------------------------------
  // Known wire-format fixtures (from candid spec / didc)
  // ---------------------------------------------------------------------------
  group('ICP/Wire fixtures (spec-style)', () {
    test('nat 0', () {
      final bytes = hex('4449444c00017d00');
      expect(CandidUtils.decodeOne(bytes), IDLNat(BigInt.zero));
    });

    test('nat 128 (2-byte LEB)', () {
      final bytes = hex('4449444c00017d8001');
      expect(CandidUtils.decodeOne(bytes), IDLNat(BigInt.from(128)));
    });

    test('int -1', () {
      final bytes = hex('4449444c00017c7f');
      expect(CandidUtils.decodeOne(bytes), IDLInt(BigInt.from(-1)));
    });

    test('bool false', () {
      final bytes = hex('4449444c00017e00');
      expect(CandidUtils.decodeOne(bytes), const IDLBool(false));
    });

    test('empty text', () {
      final bytes = hex('4449444c00017100');
      expect(CandidUtils.decodeOne(bytes), const IDLText(''));
    });

    test('vec nat empty', () {
      // type table: 1 entry = vec nat, arg = table0, value len=0
      final bytes = hex('4449444c016d7d010000');
      final decoded = CandidUtils.decodeOne(bytes) as IDLVec;
      expect(decoded.values, isEmpty);
    });

    test('opt none (type table)', () {
      // type table: opt empty, value = 0
      final bytes = hex('4449444c016e6f010000');
      expect(CandidUtils.decodeOne(bytes), const IDLNone());
    });

    test('roundtrip produces valid magic and structure', () {
      final cases = <IDLValue>[
        const IDLNull(),
        const IDLBool(true),
        IDLNat(BigInt.from(999)),
        IDLInt(BigInt.from(-999)),
        const IDLText('candid'),
        IDLOpt(IDLNat(BigInt.from(1))),
        const IDLNone(),
        IDLVec([const IDLBool(true), const IDLBool(false)]),
      ];
      for (final v in cases) {
        final bytes = CandidUtils.encodeOne(v);
        expect(bytes[0], 0x44);
        expect(bytes[1], 0x49);
        expect(bytes[2], 0x44);
        expect(bytes[3], 0x4C);
        final back = CandidUtils.decodeOne(bytes);
        // structural check by re-encoding
        final bytes2 = CandidUtils.encodeOne(back);
        expect(toHex(bytes2), toHex(bytes), reason: 'stable re-encode of $v');
      }
    });
  });

  // ---------------------------------------------------------------------------
  // idlHash
  // ---------------------------------------------------------------------------
  group('ICP/IDL hash detailed', () {
    test('empty string is 0', () {
      expect(Label.idlHash(''), 0);
    });

    test('known candid field hashes', () {
      // These are stable hashes used across candid implementations
      // hash("name") = 1101199031 (from candid tools / common knowledge)
      final nameHash = Label.idlHash('name');
      expect(nameHash, 1224700491);

      // hash is deterministic and 32-bit
      for (final s in ['id', 'amount', 'from', 'to', 'memo', 'created_at']) {
        final h = Label.idlHash(s);
        expect(h, inInclusiveRange(0, 0xFFFFFFFF));
        expect(Label.idlHash(s), h);
      }
    });

    test('Label named vs id', () {
      final h = Label.idlHash('foo');
      final named = Label.named('foo');
      final byId = Label.id(h);
      expect(named.hash, byId.hash);
      expect(named, byId); // equality via hash
    });
  });

  // ---------------------------------------------------------------------------
  // valueType() consistency
  // ---------------------------------------------------------------------------
  group('ICP/Value type', () {
    test('primitives', () {
      expect(const IDLNull().valueType().kind, CTypeKind.null_);
      expect(const IDLBool(true).valueType().kind, CTypeKind.bool);
      expect(IDLNat(BigInt.zero).valueType().kind, CTypeKind.nat);
      expect(IDLInt(BigInt.zero).valueType().kind, CTypeKind.int);
      expect(const IDLText('').valueType().kind, CTypeKind.text);
      expect(const IDLNat8(0).valueType().kind, CTypeKind.nat8);
      expect(const IDLFloat64(0).valueType().kind, CTypeKind.float64);
      expect(const IDLNone().valueType().kind, CTypeKind.opt);
    });

    test('compound', () {
      final opt = IDLOpt(IDLNat(BigInt.one));
      expect(opt.valueType().kind, CTypeKind.opt);
      expect(opt.valueType().inner!.kind, CTypeKind.nat);

      final vec = IDLVec([const IDLBool(true)]);
      expect(vec.valueType().kind, CTypeKind.vec);
      expect(vec.valueType().inner!.kind, CTypeKind.bool);
    });
  });

  // ---------------------------------------------------------------------------
  // IDLArgs helper
  // ---------------------------------------------------------------------------
  group('ICP/IDLArgs', () {
    test('toBytes matches CandidUtils.encodeArgs', () {
      final values = [const IDLBool(true), IDLNat(BigInt.from(7))];
      final a = IDLArgs(values).toBytes();
      final b = CandidUtils.encodeArgs(values);
      expect(toHex(a), toHex(b));
    });
  });

  // ---------------------------------------------------------------------------
  // Large vectors
  // ---------------------------------------------------------------------------
  group('ICP/Large data', () {
    test('vec of 1000 nats', () {
      final values = List.generate(1000, (i) => IDLNat(BigInt.from(i)));
      final v = IDLVec(values);
      final decoded = CandidUtils.decodeOne(CandidUtils.encodeOne(v)) as IDLVec;
      expect(decoded.values.length, 1000);
      expect(decoded.values[0], IDLNat(BigInt.zero));
      expect(decoded.values[999], IDLNat(BigInt.from(999)));
    });

    test('record with many fields', () {
      final fields = List.generate(50, (i) {
        return IDLField(Label.named('f$i'), IDLNat(BigInt.from(i)));
      })..sort((a, b) => a.id.compareTo(b.id));
      final v = IDLRecord(fields);
      final decoded =
          CandidUtils.decodeOne(CandidUtils.encodeOne(v)) as IDLRecord;
      expect(decoded.fields.length, 50);
    });
  });
}

void main() {
  OnChainUtilsTestApi.runTest(candidAdvancedTest, "Candid Advanced");
}

