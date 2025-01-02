import 'package:on_chain/solidity/abi/abi.dart';
import 'package:test/expect.dart';
import 'package:test/scaffolding.dart';

void main() {
  test('encode v1', () {
    final eip = EIP712Legacy([
      Eip712TypedDataV1(name: 'Message', value: 'Hi, Alice!', type: 'string'),
      Eip712TypedDataV1(
          name: 'A number', value: BigInt.from(1337), type: 'uint32'),
    ]);
    expect(eip.encodeHex(),
        '7bcdd3ffeab400ef2294ebf69b2defd370bd29ac576c2569b7ea2c48f49ab1ae');
    EIP712Base json = EIP712Base.fromJson(eip.toJson());
    expect(json.encodeHex(),
        '7bcdd3ffeab400ef2294ebf69b2defd370bd29ac576c2569b7ea2c48f49ab1ae');

    final eip2 = EIP712Legacy.fromJson([
      {'type': 'string', 'name': 'Message', 'value': 'Hi, Alice!'},
      {'type': 'uint32', 'name': 'A number', 'value': '1337'},
      {'type': 'int32', 'name': 'A number', 'value': '-1'},
      {
        'type': 'string[]',
        'name': 'BBBB',
        'value': ['one', 'two', 'three']
      },
    ]);
    expect(eip2.encodeHex(),
        '587de5fa3769d620daa02c842288a6a11279f07cc7d0ada7ed947757206097c2');
    json = EIP712Base.fromJson(eip2.toJson());
    expect(json.encodeHex(),
        '587de5fa3769d620daa02c842288a6a11279f07cc7d0ada7ed947757206097c2');
    final eip3 = EIP712Legacy.fromJson([
      {'type': 'string', 'name': 'Message', 'value': 'Hi, Alice!'},
      {'type': 'bool', 'name': 'bool', 'value': false},
      {'type': 'int32', 'name': 'A number', 'value': '-1'},
      {
        'type': 'string[]',
        'name': 'BBBB',
        'value': ['one', 'two', 'three']
      },
    ]);
    expect(eip3.encodeHex(),
        '276933d1b5ed61a561d7fcc1278954351104dac0531de663ac19b04523477087');
    json = EIP712Base.fromJson(eip3.toJson());
    expect(json.encodeHex(),
        '276933d1b5ed61a561d7fcc1278954351104dac0531de663ac19b04523477087');
    final eip4 = EIP712Legacy.fromJson([
      {'type': 'string', 'name': 'Message', 'value': 'Hi, Alice!'},
      {'type': 'bool', 'name': 'bool', 'value': false},
      {'type': 'int32', 'name': 'A number', 'value': '-1'},
      {
        'type': 'string[]',
        'name': 'BBBB4',
        'value': ['one', 'two', 'three']
      },
      {
        'type': 'bool[]',
        'name': 'BBBB3',
        'value': [false, true, true, false]
      },
      {
        'type': 'uint32[]',
        'name': 'BBBB1',
        'value': [
          BigInt.from(1),
          BigInt.from(2),
          BigInt.from(5000),
          BigInt.from(7000)
        ]
      },
    ]);
    expect(eip4.encodeHex(),
        '8c2f569069fb99db364df030056a376c06015c6753dbab3274fe3a26b0b6e1e9');
    json = EIP712Base.fromJson(eip4.toJson());
    expect(json.encodeHex(),
        '8c2f569069fb99db364df030056a376c06015c6753dbab3274fe3a26b0b6e1e9');
    final eip5 = EIP712Legacy.fromJson([
      {'type': 'string', 'name': 'Message', 'value': 'Hi, Alice!'},
      {'type': 'bool', 'name': 'bool', 'value': false},
      {'type': 'int32', 'name': 'A number', 'value': '-1'},
      {
        'type': 'string[]',
        'name': 'BBBB4',
        'value': ['one', 'two', 'three']
      },
      {
        'type': 'bool[]',
        'name': 'BBBB3',
        'value': [false, true, true, false]
      },
      {
        'type': 'uint32[]',
        'name': 'BBBB1',
        'value': [
          BigInt.from(1),
          BigInt.from(2),
          BigInt.from(5000),
          BigInt.from(7000)
        ]
      },
      {
        'type': 'uint32[]',
        'name': 'BBBBx',
        'value': [
          BigInt.from(1),
          BigInt.from(2),
          BigInt.from(5000),
          BigInt.from(7000)
        ]
      },
    ]);
    expect(eip5.encodeHex(),
        'b404f458127884da5d8987d62ffbed79121d320c898adff167f865ac4f1fe1bf');
    json = EIP712Base.fromJson(eip5.toJson());
    expect(json.encodeHex(),
        'b404f458127884da5d8987d62ffbed79121d320c898adff167f865ac4f1fe1bf');
    final eip6 = EIP712Legacy.fromJson([
      {'type': 'string', 'name': 'Message', 'value': 'Hi, Alice!'},
      {'type': 'bool', 'name': 'bool', 'value': false},
      {'type': 'int32', 'name': 'A number', 'value': '-1'},
      {
        'type': 'string[]',
        'name': 'BBBB4',
        'value': ['one', 'two', 'three']
      },
      {
        'type': 'bool[]',
        'name': 'BBBB3',
        'value': [false, true, true, false]
      },
      {
        'type': 'uint32[]',
        'name': 'BBBB1',
        'value': [
          BigInt.from(1),
          BigInt.from(2),
          BigInt.from(5000),
          BigInt.from(7000)
        ]
      },
      {
        'type': 'uint32[]',
        'name': 'BBBBx',
        'value': [
          BigInt.from(1),
          BigInt.from(2),
          BigInt.from(5000),
          BigInt.from(7000)
        ]
      },
      {
        'type': 'uint256[]',
        'name': 'BBBBx',
        'value': [
          BigInt.from(1000000000000000),
          BigInt.from(20000000000000000),
          BigInt.from(50000000000000),
          BigInt.from(700000000000000000)
        ]
      },
    ]);
    expect(eip6.encodeHex(),
        '3241a9139b03132118b331f536f876b4c5406b91c36f0828ad9dabb6fceff284');
    json = EIP712Base.fromJson(eip6.toJson());
    expect(json.encodeHex(),
        '3241a9139b03132118b331f536f876b4c5406b91c36f0828ad9dabb6fceff284');
    final eip7 = EIP712Legacy.fromJson([
      {'type': 'string', 'name': 'Message', 'value': 'Hi, Alice!'},
      {'type': 'bool', 'name': 'bool', 'value': false},
      {'type': 'int32', 'name': 'A number', 'value': '-1'},
      {
        'type': 'string[]',
        'name': 'BBBB4',
        'value': ['one', 'two', 'three']
      },
      {
        'type': 'bool[]',
        'name': 'BBBB3',
        'value': [false, true, true, false]
      },
      {
        'type': 'uint32[]',
        'name': 'BBBB1',
        'value': [
          BigInt.from(1),
          BigInt.from(2),
          BigInt.from(5000),
          BigInt.from(7000)
        ]
      },
      {
        'type': 'uint32[]',
        'name': 'BBBBx',
        'value': [
          BigInt.from(1),
          BigInt.from(2),
          BigInt.from(5000),
          BigInt.from(7000)
        ]
      },
      {
        'type': 'uint256[]',
        'name': 'BBBBx',
        'value': [
          BigInt.from(1000000000000000),
          BigInt.from(20000000000000000),
          BigInt.from(50000000000000),
          BigInt.from(700000000000000000)
        ]
      },
      {
        'type': 'int32[]',
        'name': 'BBBBx',
        'value': [
          BigInt.from(-1),
          BigInt.from(-2),
          BigInt.from(-5000),
          BigInt.from(7000)
        ]
      },
    ]);
    expect(eip7.encodeHex(),
        'f5d4906262038a59437eef1a975a89669c4feb648556178550b1ab2c35b2eb9c');
    json = EIP712Base.fromJson(eip7.toJson());
    expect(json.encodeHex(),
        'f5d4906262038a59437eef1a975a89669c4feb648556178550b1ab2c35b2eb9c');
    final eip8 = EIP712Legacy.fromJson([
      {'type': 'int256', 'name': 'Message', 'value': '-250000000000'},
      {
        'type': 'uint256',
        'name': 'ONEONEONEONEONEONEONEONEONEONEONEONEONEONEONE',
        'value': '2500000000000'
      },
    ]);
    expect(eip8.encodeHex(),
        '2049bac5b8074309076b343a0fbdb8d021b8312496753e710d970abae91e5d77');
    json = EIP712Base.fromJson(eip8.toJson());
    expect(json.encodeHex(),
        '2049bac5b8074309076b343a0fbdb8d021b8312496753e710d970abae91e5d77');
  });
}
