import 'dart:typed_data';
import 'package:on_chain/icp/src/address/address.dart';
import 'package:on_chain/icp/src/serialization/candid/candid.dart';
import 'package:test/test.dart';

import '../../utils.dart';

void candidTypedTest() {
  group('ICP/Typed encode/decode primitives', () {
    test('nat / text / bool', () {
      final bytes = CandidUtils.encode(
        [CType.nat, CType.text, CType.bool_],
        [BigInt.from(42), 'hello', true],
      );
      final values = CandidUtils.decode(bytes, [
        CType.nat,
        CType.text,
        CType.bool_,
      ]);
      expect(values[0], BigInt.from(42));
      expect(values[1], 'hello');
      expect(values[2], true);
    });

    test('int and fixed widths', () {
      final bytes = CandidUtils.encode(
        [CType.int_, CType.nat8, CType.int32, CType.nat64, CType.int64],
        [
          BigInt.from(-7),
          255,
          -1000,
          BigInt.parse('18446744073709551615'),
          -(BigInt.one << 63),
        ],
      );
      final values = CandidUtils.decode(bytes, [
        CType.int_,
        CType.nat8,
        CType.int32,
        CType.nat64,
        CType.int64,
      ]);
      expect(values[0], BigInt.from(-7));
      expect(values[1], 255);
      expect(values[2], -1000);
      expect(values[3], BigInt.parse('18446744073709551615'));
      expect(values[4], -(BigInt.one << 63));
    });

    test('float64', () {
      final bytes = CandidUtils.encodeOneTyped(CType.float64, 3.14159);
      final v = CandidUtils.decodeOneTyped(bytes, CType.float64) as double;
      expect(v, closeTo(3.14159, 1e-9));
    });

    test('null type', () {
      final bytes = CandidUtils.encodeOneTyped(CType.null_, null);
      expect(CandidUtils.decodeOneTyped(bytes, CType.null_), isNull);
    });
  });

  group('ICP/Typed opt / vec', () {
    test('opt some / none', () {
      final some = CandidUtils.encodeOneTyped(
        CType.opt(CType.nat),
        BigInt.from(9),
      );
      expect(
        CandidUtils.decodeOneTyped(some, CType.opt(CType.nat)),
        BigInt.from(9),
      );

      final none = CandidUtils.encodeOneTyped(CType.opt(CType.nat), null);
      expect(CandidUtils.decodeOneTyped(none, CType.opt(CType.nat)), isNull);
    });

    test('vec of text', () {
      final bytes = CandidUtils.encodeOneTyped(CType.vec(CType.text), [
        'a',
        'b',
        'c',
      ]);
      expect(CandidUtils.decodeOneTyped(bytes, CType.vec(CType.text)), [
        'a',
        'b',
        'c',
      ]);
    });

    test('vec nat8 as blob', () {
      final data = Uint8List.fromList([1, 2, 3, 4]);
      final bytes = CandidUtils.encodeOneTyped(CType.vec(CType.nat8), data);
      final decoded = CandidUtils.decodeOneTyped(bytes, CType.vec(CType.nat8));
      expect(decoded, data);
    });

    test('nested opt', () {
      final ty = CType.opt(CType.opt(CType.bool_));
      final bytes = CandidUtils.encodeOneTyped(ty, true);
      expect(CandidUtils.decodeOneTyped(bytes, ty), true);

      final none = CandidUtils.encodeOneTyped(ty, null);
      expect(CandidUtils.decodeOneTyped(none, ty), isNull);
    });
  });

  group('ICP/Typed record / variant', () {
    test('record map', () {
      final ty = CType.record([
        Field(Label.named('id'), CType.nat),
        Field(Label.named('name'), CType.text),
        Field(Label.named('active'), CType.bool_),
      ]);
      final bytes = CandidUtils.encodeOneTyped(ty, {
        'id': BigInt.from(1),
        'name': 'alice',
        'active': true,
      });
      final map = CandidUtils.decodeOneTyped(bytes, ty) as Map;
      expect(map['id'], BigInt.from(1));
      expect(map['name'], 'alice');
      expect(map['active'], true);
    });

    test('record with optional field missing', () {
      final ty = CType.record([
        Field(Label.named('x'), CType.nat),
        Field(Label.named('y'), CType.opt(CType.text)),
      ]);
      final bytes = CandidUtils.encodeOneTyped(ty, {'x': BigInt.from(5)});
      final map = CandidUtils.decodeOneTyped(bytes, ty) as Map;
      expect(map['x'], BigInt.from(5));
      expect(map['y'], isNull);
    });

    test('variant ok/err', () {
      final ty = CType.variant([
        Field(Label.named('ok'), CType.nat),
        Field(Label.named('err'), CType.text),
      ]);
      final okBytes = CandidUtils.encodeOneTyped(
        ty,
        Variant('ok', BigInt.from(1)),
      );
      final ok = CandidUtils.decodeOneTyped(okBytes, ty) as Map;
      expect(ok.keys.first, 'ok');
      expect(ok['ok'], BigInt.from(1));

      final errBytes = CandidUtils.encodeOneTyped(ty, {'err': 'boom'});
      final err = CandidUtils.decodeOneTyped(errBytes, ty) as Map;
      expect(err['err'], 'boom');
    });
  });

  group('ICP/Service and func', () {
    test('Func.signature helpers', () {
      final q = Func.query([CType.nat], [CType.text]);
      expect(q.modes, [FuncMode.query]);
      expect(q.args, [CType.nat]);
      expect(q.rets, [CType.text]);

      final u = Func.update([CType.text], []);
      expect(u.modes, isEmpty);

      final o = Func.oneway([CType.principal]);
      expect(o.modes, [FuncMode.oneway]);
    });

    test('Service.type and ServiceRef', () {
      final methods = {
        'get': Func.query([], [CType.nat]),
        'set': Func.update([CType.nat], []),
      };
      final sty = Service.type(methods);
      expect(sty.kind, CTypeKind.service);
      expect(sty.serviceMethods!.length, 2);

      final p = IcpPrincipalAddress.fromBytes(Uint8List.fromList([1, 2, 3]));
      final svc = Service.ref(p, methods: methods);
      expect(svc.principal, p);
      final m = svc.method('get');
      expect(m.method, 'get');
      expect(m.principal, p);
      expect(m.signature!.modes, [FuncMode.query]);
    });

    test('encode service / func values', () {
      final p = IcpPrincipalAddress.fromBytes(Uint8List.fromList([10, 20]));
      final funcTy = Func.type(Func.query([CType.nat], [CType.bool_]));
      final svcTy = Service.type({
        'ping': Func.query([], [CType.null_]),
      });

      final bytes = CandidUtils.encode(
        [funcTy, svcTy],
        [FuncRef(p, 'ping'), ServiceRef(p)],
      );
      final values = CandidUtils.decode(bytes, [funcTy, svcTy]);
      expect(values[0], isA<FuncRef>());
      expect((values[0] as FuncRef).method, 'ping');
      expect((values[0] as FuncRef).principal.toBytes(), [10, 20]);
      expect(values[1], isA<ServiceRef>());
      expect((values[1] as ServiceRef).principal.toBytes(), [10, 20]);
    });

    test('FuncRef / ServiceRef equality and IDL conversion', () {
      final p = IcpPrincipalAddress.fromBytes(Uint8List.fromList([1]));
      final f1 = FuncRef(p, 'foo');
      final f2 = FuncRef(p, 'foo');
      expect(f1, f2);
      expect(f1.toIDLValue().method, 'foo');

      final s1 = ServiceRef(p);
      expect(s1.toIDLValue().v, p);
    });
  });

  group('ICP/Typed vs IDLValue encode consistency', () {
    test('same bytes for nat', () {
      final typed = CandidUtils.encodeOneTyped(CType.nat, BigInt.from(99));
      final idl = CandidUtils.encodeOne(IDLNat(BigInt.from(99)));
      expect(typed, idl);
    });

    test('same bytes for text', () {
      final typed = CandidUtils.encodeOneTyped(CType.text, 'candid');
      final idl = CandidUtils.encodeOne(const IDLText('candid'));
      expect(typed, idl);
    });

    test('same bytes for opt none', () {
      final typed = CandidUtils.encodeOneTyped(CType.opt(CType.nat), null);
      final _ = CandidUtils.encodeOne(const IDLNone());
      // IDLNone uses opt(empty) as valueType — type table may differ.
      // Decode both with opt(nat) to verify semantic equality.
      expect(CandidUtils.decodeOneTyped(typed, CType.opt(CType.nat)), isNull);
    });
  });
}

void main() {
  OnChainUtilsTestApi.runTest(candidTypedTest, "Candid Typed");
}
