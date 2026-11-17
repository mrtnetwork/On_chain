import 'package:on_chain/algorand/src/abi/src/abi_type.dart';
import 'package:on_chain/algorand/src/abi/src/types.dart';
import 'package:on_chain/algorand/src/abi/src/method.dart';
import 'package:on_chain/algorand/src/abi/src/contract.dart';
import 'package:test/test.dart';

import '../../utils.dart';

void contractAbiTest() {
  group('Algorand/ABIType From Parsing', () {
    test('scalar and alias types', () {
      expect(ABIType.from('uint64'), isA<ABIUintType>());
      expect(ABIType.from('uint8').getName(), 'uint8');
      expect(ABIType.from('byte'), isA<ABIByteType>());
      expect(ABIType.from('bool'), isA<ABIBoolType>());
      expect(ABIType.from('address'), isA<ABIAddressType>());
      expect(ABIType.from('string'), isA<ABIStringType>());
      expect(ABIType.from('ufixed128x10').getName(), 'ufixed128x10');
    });

    test('array and tuple type strings round-trip via toString', () {
      expect(ABIType.from('uint64[]').getName(), 'uint64[]');
      expect(ABIType.from('uint64[5]').getName(), 'uint64[5]');
      expect(ABIType.from('(uint64,string)').getName(), '(uint64,string)');
      // nested: array of tuples
      expect(ABIType.from('(uint64,string)[]').getName(), '(uint64,string)[]');
      // nested: tuple containing a dynamic array
      expect(ABIType.from('(uint64,byte[])').getName(), '(uint64,byte[])');
    });

    test('rejects malformed type strings', () {
      expect(() => ABIType.from('uint7'), throwsA(anything)); // not %8==0
      expect(() => ABIType.from('notatype'), throwsA(anything));
      expect(() => ABIType.from('uint64[abc]'), throwsA(anything));
    });
  });

  group('Algorand/Scalar Encode/Decode Round Trips', () {
    test('uint8 boundaries', () {
      final t = ABIType.from('uint8');
      expect(t.decode(t.encode(0)), BigInt.zero);
      expect(t.decode(t.encode(255)), BigInt.from(255));
      expect(() => t.encode(256), throwsA(anything));
      expect(() => t.encode(-1), throwsA(anything));
    });

    test('uint64 boundaries', () {
      final t = ABIType.from('uint64');
      final max64 = (BigInt.one << 64) - BigInt.one;
      expect(t.decode(t.encode(0)), BigInt.zero);
      expect(t.decode(t.encode(max64)), max64);
      expect(t.encode(0).length, 8);
    });

    test('uint256 boundaries', () {
      final t = ABIType.from('uint256');
      final max256 = (BigInt.one << 256) - BigInt.one;
      expect(t.decode(t.encode(max256)), max256);
      expect(t.encode(max256).length, 32);
    });

    test('ufixed round trip (raw integer representation)', () {
      final t = ABIType.from('ufixed64x4');
      expect(t.decode(t.encode(12345)), BigInt.from(12345));
    });

    test('bool encodes to 0x80 / 0x00 exactly', () {
      final t = ABIType.from('bool');
      expect(t.encode(true), [0x80]);
      expect(t.encode(false), [0x00]);
      expect(t.decode([0x80]), true);
      expect(t.decode([0x00]), false);
      expect(() => t.decode([0x01]), throwsA(anything));
    });

    test('byte round trip and range check', () {
      final t = ABIType.from('byte');
      expect(t.decode(t.encode(0)), 0);
      expect(t.decode(t.encode(255)), 255);
      expect(() => t.encode(256), throwsA(anything));
    });

    test('address round trip using the all-zero address', () {
      final t = ABIType.from('address');
      const zeroAddr =
          'AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAY5HFKQ';
      final encoded = t.encode(zeroAddr);
      expect(encoded.length, 32);
      expect(encoded.every((b) => b == 0), true);
      expect(t.decode(encoded), zeroAddr);
    });

    test('string round trip: empty, ascii, and unicode', () {
      final t = ABIType.from('string');
      expect(t.decode(t.encode('')), '');
      expect(t.decode(t.encode('Hello, Algorand')), 'Hello, Algorand');
      expect(t.decode(t.encode('héllo 🚀')), 'héllo 🚀');
    });
  });

  group('Algorand/Array Types', () {
    test('dynamic array of uint64: empty and populated', () {
      final t = ABIType.from('uint64[]');
      expect(t.decode(t.encode(<int>[])), <BigInt>[]);
      final decoded = t.decode(t.encode([1, 2, 3]));
      expect(decoded, [BigInt.one, BigInt.two, BigInt.from(3)]);
    });

    test(
      'static array of uint64: correct length passes, wrong length throws',
      () {
        final t = ABIType.from('uint64[3]');
        final decoded = t.decode(t.encode([10, 20, 30]));
        expect(decoded, [BigInt.from(10), BigInt.from(20), BigInt.from(30)]);
        expect(() => t.encode([1, 2]), throwsA(anything));
      },
    );

    test('static array of bool packs into ceil(n/8) bytes', () {
      final t = ABIType.from('bool[9]') as ABIArrayStaticType;
      expect(t.byteLen(), 2); // 9 bools -> 2 bytes
      final values = [
        true, false, true, false, true, false, true, false, // byte 1
        true, // byte 2, bit 0
      ];
      final encoded = t.encode(values);
      expect(encoded.length, 2);
      expect(t.decode(encoded), values);
    });
  });

  group('Algorand/Tuple Types', () {
    test('mixed static + dynamic fields round trip', () {
      final t = ABIType.from('(uint64,string)');
      final decoded = t.decode(t.encode([42, 'hi']));
      expect(decoded, [BigInt.from(42), 'hi']);
    });

    test('tuple with a dynamic array child', () {
      final t = ABIType.from('(uint64,byte[])') as ABITupleType;
      final decoded = t.decode(
        t.encode([
          7,
          [1, 2, 3],
        ]),
      );
      expect(decoded[0], BigInt.from(7));
      expect(decoded[1], [1, 2, 3]);
    });

    test('tuple wrong arity throws', () {
      final t = ABIType.from('(uint64,string)');
      expect(() => t.encode([1]), throwsA(anything));
      expect(() => t.encode([1, 'a', 'b']), throwsA(anything));
    });

    test('consecutive bools inside a tuple compress correctly', () {
      final t = ABIType.from('(bool,bool,bool,uint64)');
      final decoded = t.decode(t.encode([true, false, true, 99]));
      expect(decoded, [true, false, true, BigInt.from(99)]);
      // 3 bools should pack into 1 leading byte, then 8 bytes for uint64
      expect((t as ABITupleType).byteLen(), 1 + 8);
    });

    test('nested tuple-in-tuple round trip', () {
      final t = ABIType.from('(uint64,(uint64,uint64))') as ABITupleType;
      final decoded = t.decode(
        t.encode([
          1,
          [2, 3],
        ]),
      );

      expect(decoded[0], BigInt.from(1));
      expect(decoded[1], [BigInt.from(2), BigInt.from(3)]);
    });
  });

  group('Algorand/ABITransactionType / ABIReferenceType', () {
    test('transaction type string classification', () {
      expect(ABITransactionType.tryFrom('pay'), ABITransactionType.pay);
      expect(ABITransactionType.tryFrom('axfer'), ABITransactionType.axfer);
      expect(ABITransactionType.tryFrom('acfg'), ABITransactionType.acfg);
      expect(ABITransactionType.tryFrom('afrz'), ABITransactionType.afrz);
      expect(ABITransactionType.tryFrom('appl'), ABITransactionType.appl);
      expect(ABITransactionType.tryFrom('keyreg'), ABITransactionType.keyreg);
      expect(ABITransactionType.tryFrom('txn'), ABITransactionType.any);
      expect(ABITransactionType.tryFrom('uint64'), isNull);
    });

    test('reference type string classification', () {
      expect(ABIReferenceType.tryFrom('account'), ABIReferenceType.account);
      expect(ABIReferenceType.tryFrom('asset'), ABIReferenceType.asset);
      expect(
        ABIReferenceType.tryFrom('application'),
        ABIReferenceType.application,
      );
      expect(ABIReferenceType.tryFrom('pay'), isNull);
    });

    test(
      'abiCheckTransactionType: any matches everything, others are exact',
      () {
        expect(
          ABITypeUtils.abiCheckTransactionType(ABITransactionType.any, 'pay'),
          true,
        );
        expect(
          ABITypeUtils.abiCheckTransactionType(ABITransactionType.any, null),
          true,
        );
        expect(
          ABITypeUtils.abiCheckTransactionType(ABITransactionType.pay, 'pay'),
          true,
        );
        expect(
          ABITypeUtils.abiCheckTransactionType(ABITransactionType.pay, 'axfer'),
          false,
        );
        expect(
          ABITypeUtils.abiCheckTransactionType(ABITransactionType.pay, null),
          false,
        );
      },
    );
  });

  group('Algorand/ABIMethod', () {
    test('signature round trip for a plain-value method', () {
      final m = ABIMethod.fromSignature('add(uint64,uint64)uint64');
      expect(m.getSignature(), 'add(uint64,uint64)uint64');
      expect(m.args.length, 2);
      expect(m.args.every((a) => a.type is ABIUintType), true);
      expect(m.returns.type, isA<ABIUintType>());
    });

    test('void return produces null return type', () {
      final m = ABIMethod.fromSignature('opt_in_to_asset(asset)void');
      expect(m.returns.type, isNull);
      expect(m.args.single.type, ABIReferenceType.asset);
    });

    test(
      'reference-type args are classified as ABIReferenceType, not ABIType',
      () {
        final m = ABIMethod.fromSignature('get_account_balance(account)uint64');
        expect(m.args.single.type, isA<ABIReferenceType>());
        expect(m.args.single.type, ABIReferenceType.account);
      },
    );

    test('transaction-type args are classified as ABITransactionType', () {
      final m = ABIMethod.fromSignature('verify_payment(pay,account)bool');
      expect(m.args[0].type, ABITransactionType.pay);
      expect(m.args[1].type, ABIReferenceType.account);
      expect(m.returns.type, isA<ABIBoolType>());
    });

    test('generic txn arg classification', () {
      final m = ABIMethod.fromSignature('accept_any_txn(txn)uint64');
      expect(m.args.single.type, ABITransactionType.any);
    });

    test('txnCount counts 1 (app call) + 1 per txn-typed arg', () {
      expect(ABIMethod.fromSignature('add(uint64,uint64)uint64').txnCount(), 1);
      expect(
        ABIMethod.fromSignature('verify_payment(pay,account)bool').txnCount(),
        2,
      );
      expect(
        ABIMethod.fromSignature('accept_any_txn(txn)uint64').txnCount(),
        2,
      );
    });

    test('getSelector is deterministic and 4 bytes', () {
      final a = ABIMethod.fromSignature('hello(string)string');
      final b = ABIMethod.fromSignature('hello(string)string');
      expect(a.getSelector(), b.getSelector());
      expect(a.getSelector().length, 4);
    });

    test('getSelector differs for different signatures', () {
      final a = ABIMethod.fromSignature('hello(string)string');
      final b = ABIMethod.fromSignature('add(uint64,uint64)uint64');
      expect(a.getSelector(), isNot(equals(b.getSelector())));
    });

    test('struct-shaped tuple return parses like any other tuple', () {
      // algopy's Coordinates(arc4.Struct) compiles down to (uint64,uint64)
      // on the wire — there's no separate "struct" ABI type.
      final m = ABIMethod.fromSignature(
        'make_struct(uint64,uint64)(uint64,uint64)',
      );
      expect(m.returns.type, isA<ABITupleType>());
      final decoded = m.returns.type!.decode(m.returns.type!.encode([5, 9]));
      expect(decoded, [BigInt.from(5), BigInt.from(9)]);
    });
  });

  group('Algorand/ABIContract FromJson', () {
    // Mirrors the ARC-4 methods your algopy `Hello` contract compiles to.
    final specJson = {
      'name': 'Hello',
      'desc': null,
      'methods': [
        {
          'name': 'hello',
          'args': [
            {'type': 'string', 'name': 'name'},
          ],
          'returns': {'type': 'string'},
        },
        {
          'name': 'add',
          'args': [
            {'type': 'uint64', 'name': 'a'},
            {'type': 'uint64', 'name': 'b'},
          ],
          'returns': {'type': 'uint64'},
        },
        {
          'name': 'negate',
          'args': [
            {'type': 'bool', 'name': 'flag'},
          ],
          'returns': {'type': 'bool'},
        },
        {
          'name': 'sum_dynamic_array',
          'args': [
            {'type': 'uint64[]', 'name': 'values'},
          ],
          'returns': {'type': 'uint64'},
        },
        {
          'name': 'sum_static_array',
          'args': [
            {'type': 'uint64[3]', 'name': 'values'},
          ],
          'returns': {'type': 'uint64'},
        },
        {
          'name': 'make_tuple',
          'args': [
            {'type': 'uint64', 'name': 'a'},
            {'type': 'string', 'name': 'b'},
          ],
          'returns': {'type': '(uint64,string)'},
        },
        {
          'name': 'make_struct',
          'args': [
            {'type': 'uint64', 'name': 'x'},
            {'type': 'uint64', 'name': 'y'},
          ],
          'returns': {'type': '(uint64,uint64)'},
        },
        {
          'name': 'get_account_balance',
          'args': [
            {'type': 'account', 'name': 'acct'},
          ],
          'returns': {'type': 'uint64'},
        },
        {
          'name': 'get_asset_total',
          'args': [
            {'type': 'asset', 'name': 'asset'},
          ],
          'returns': {'type': 'uint64'},
        },
        {
          'name': 'get_app_creator',
          'args': [
            {'type': 'application', 'name': 'app'},
          ],
          'returns': {'type': 'address'},
        },
        {
          'name': 'verify_payment',
          'args': [
            {'type': 'pay', 'name': 'payment'},
            {'type': 'account', 'name': 'expected_receiver'},
          ],
          'returns': {'type': 'bool'},
        },
        {
          'name': 'verify_asset_transfer',
          'args': [
            {'type': 'axfer', 'name': 'axfer'},
          ],
          'returns': {'type': 'uint64'},
        },
        {
          'name': 'accept_any_txn',
          'args': [
            {'type': 'txn', 'name': 'txn'},
          ],
          'returns': {'type': 'uint64'},
        },
        {
          'name': 'create_asset',
          'args': [
            {'type': 'uint64', 'name': 'total'},
            {'type': 'string', 'name': 'unit_name'},
            {'type': 'string', 'name': 'asset_name'},
          ],
          'returns': {'type': 'uint64'}, // asset id on the wire
        },
        {
          'name': 'opt_in_to_asset',
          'args': [
            {'type': 'asset', 'name': 'asset'},
          ],
          'returns': {'type': 'void'},
        },
        {
          'name': 'send_asset',
          'args': [
            {'type': 'asset', 'name': 'asset'},
            {'type': 'account', 'name': 'receiver'},
            {'type': 'uint64', 'name': 'amount'},
          ],
          'returns': {'type': 'void'},
        },
      ],
    };

    late ABIContract contract;

    setUp(() {
      contract = ABIContract.fromJson(specJson);
    });

    test('parses all methods and preserves count', () {
      expect(contract.methods.length, 16);
    });

    test('methodByName resolves a known method', () {
      final m = contract.methodByName('add');
      expect(m.getSignature(), 'add(uint64,uint64)uint64');
    });

    test('methodByName throws for an unknown method', () {
      expect(() => contract.methodByName('nope'), throwsA(anything));
    });

    test('reference-typed args are ABIReferenceType across the contract', () {
      final m = contract.methodByName('get_account_balance');
      expect(m.args.single.type, ABIReferenceType.account);

      final m2 = contract.methodByName('send_asset');
      expect(m2.args[0].type, ABIReferenceType.asset);
      expect(m2.args[1].type, ABIReferenceType.account);
      expect(m2.args[2].type, isA<ABIUintType>());
    });

    test(
      'transaction-typed args are ABITransactionType across the contract',
      () {
        final m = contract.methodByName('verify_payment');
        expect(m.args[0].type, ABITransactionType.pay);
        final m2 = contract.methodByName('verify_asset_transfer');
        expect(m2.args.single.type, ABITransactionType.axfer);
        final m3 = contract.methodByName('accept_any_txn');
        expect(m3.args.single.type, ABITransactionType.any);
      },
    );

    test('void-returning methods decode as null return type', () {
      expect(contract.methodByName('opt_in_to_asset').returns.type, isNull);
      expect(contract.methodByName('send_asset').returns.type, isNull);
    });

    test('round trip through toJson preserves method shape', () {
      final reparsed = ABIContract.fromJson(contract.toJson());
      expect(reparsed.methods.length, contract.methods.length);
      expect(
        reparsed.methodByName('hello').getSignature(),
        contract.methodByName('hello').getSignature(),
      );
    });

    test('end-to-end: encode args for add, decode return value', () {
      final m = contract.methodByName('add');
      final argA = (m.args[0].type as ABIType).encode(4);
      final argB = (m.args[1].type as ABIType).encode(5);
      expect(argA.length, 8);
      expect(argB.length, 8);
      final ret = m.returns.type!;
      expect(ret.decode(ret.encode(9)), BigInt.from(9));
    });
  });
}

void main() {
  OnChainUtilsTestApi.runTest(contractAbiTest, "Abi");
}
