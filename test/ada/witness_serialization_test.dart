import 'package:blockchain_utils/blockchain_utils.dart';
import 'package:on_chain/ada/ada.dart';
import 'package:test/test.dart';

void main() {
  group('transaction witness set', () {
    _witnessSerialization();
  });
}

void _witnessSerialization() {
  test('serialization', () {
    final witness = TransactionWitnessSet(vKeys: [
      Vkeywitness(
          vKey: Vkey.fromHex(
              'f9aa3fccb7fe539e471188ccc9ee65514c5961c070b06ca185962484a4813bee'),
          signature: Ed25519Signature.fromHex(
              '9dd4f5014c8a98760295533210bb4e5fbc6f8497769e3efcae6f219d12fc12e306f04878b8e6eb9dd125a9cf713b3631c7812fe9caf0894d51396a7fcba05600')),
    ]);
    expect(witness.serializeHex(),
        'a10081825820f9aa3fccb7fe539e471188ccc9ee65514c5961c070b06ca185962484a4813bee58409dd4f5014c8a98760295533210bb4e5fbc6f8497769e3efcae6f219d12fc12e306f04878b8e6eb9dd125a9cf713b3631c7812fe9caf0894d51396a7fcba05600');
  });
  test('serialization_2', () {
    final witness = TransactionWitnessSet(
        vKeys: [
          Vkeywitness(
            vKey: Vkey.fromHex(
                '4ced1e732e40b5a8abae0b7eb072565d1cb9554dd61ff88510657990a4075308'),
            signature: Ed25519Signature(List<int>.filled(64, 1)),
          ),
        ],
        redeemers: [
          Redeemer(
              tag: RedeemerTag.spend,
              index: BigInt.from(12),
              data: PlutusInteger(BigInt.one),
              exUnits: ExUnits(
                mem: BigInt.from(123),
                steps: BigInt.from(456),
              ))
        ],
        plutusData: PlutusList([PlutusInteger(BigInt.one)]),
        plutusScripts: []);
    expect(witness.serializeHex(),
        'a400818258204ced1e732e40b5a8abae0b7eb072565d1cb9554dd61ff88510657990a40753085840010101010101010101010101010101010101010101010101010101010101010101010101010101010101010101010101010101010101010101010101010101010380049f01ff058184000c0182187b1901c8');
    final decode = TransactionWitnessSet.fromCborBytes(witness.serialize());
    expect(decode.serialize(), witness.serialize());
  });
  test('serialization_3', () {
    final witness = TransactionWitnessSet(
        vKeys: [
          Vkeywitness(
            vKey: Vkey.fromHex(
                'f77f4f25aa91167bfb71ab6b4930de1905559b325c276535128ce9ecee568d8f'),
            signature: Ed25519Signature(List<int>.filled(64, 1)),
          ),
        ],
        redeemers: [
          Redeemer(
              tag: RedeemerTag.spend,
              index: BigInt.from(12),
              data: PlutusInteger(BigInt.one),
              exUnits: ExUnits(
                mem: BigInt.from(123),
                steps: BigInt.from(456),
              ))
        ],
        plutusData: PlutusList([PlutusInteger(BigInt.one)]),
        plutusScripts: [
          PlutusScript.fromCborBytes(
              BytesUtils.fromHexString('4e4d01000033222220051200120011'))
        ]);
    expect(witness.serializeHex(),
        'a40081825820f77f4f25aa91167bfb71ab6b4930de1905559b325c276535128ce9ecee568d8f58400101010101010101010101010101010101010101010101010101010101010101010101010101010101010101010101010101010101010101010101010101010103814e4d01000033222220051200120011049f01ff058184000c0182187b1901c8');
    final decode = TransactionWitnessSet.fromCborBytes(witness.serialize());
    expect(decode.serialize(), witness.serialize());
  });
  test('serialization_4', () {
    final witness = TransactionWitnessSet(
        vKeys: [
          Vkeywitness(
            vKey: Vkey.fromHex(
                '4f40530912b7382c07aaa4505cdd68b368b72534f763cccddd4a333e41d7c50c'),
            signature: Ed25519Signature(List<int>.filled(64, 1)),
          ),
        ],
        redeemers: [
          Redeemer(
              tag: RedeemerTag.spend,
              index: BigInt.from(12),
              data: PlutusInteger(BigInt.one),
              exUnits: ExUnits(
                mem: BigInt.from(123),
                steps: BigInt.from(456),
              ))
        ],
        plutusData: PlutusList([PlutusInteger(BigInt.one)]),
        plutusScripts: [
          PlutusScript.fromCborBytes(
              BytesUtils.fromHexString('4e4d01000033222220051200120011'),
              language: Language.plutusV2)
        ]);
    expect(witness.serializeHex(),
        'a500818258204f40530912b7382c07aaa4505cdd68b368b72534f763cccddd4a333e41d7c50c584001010101010101010101010101010101010101010101010101010101010101010101010101010101010101010101010101010101010101010101010101010101038006814e4d01000033222220051200120011049f01ff058184000c0182187b1901c8');

    final decode = TransactionWitnessSet.fromCborBytes(witness.serialize());
    expect(decode.serialize(), witness.serialize());
  });
  test('serialization_5', () {
    final witness = TransactionWitnessSet(
        vKeys: [
          Vkeywitness(
            vKey: Vkey.fromHex(
                'd5a84d0bd9d9c9aac0339f87b05e2eb7581dcd10123de1f85a71c99cde49fbf3'),
            signature: Ed25519Signature(List<int>.filled(64, 1)),
          ),
        ],
        redeemers: [
          Redeemer(
              tag: RedeemerTag.spend,
              index: BigInt.from(12),
              data: PlutusInteger(BigInt.one),
              exUnits: ExUnits(
                mem: BigInt.from(123),
                steps: BigInt.from(456),
              ))
        ],
        plutusData: PlutusList([PlutusInteger(BigInt.one)]),
        plutusScripts: [
          PlutusScript.fromCborBytes(
              BytesUtils.fromHexString('4e4d01000033222220051200120011'),
              language: Language.plutusV1),
          PlutusScript.fromCborBytes(
              BytesUtils.fromHexString('4e4d01000033222220051200120011'),
              language: Language.plutusV2)
        ]);
    expect(witness.serializeHex(),
        'a50081825820d5a84d0bd9d9c9aac0339f87b05e2eb7581dcd10123de1f85a71c99cde49fbf358400101010101010101010101010101010101010101010101010101010101010101010101010101010101010101010101010101010101010101010101010101010103814e4d0100003322222005120012001106814e4d01000033222220051200120011049f01ff058184000c0182187b1901c8');

    final decode = TransactionWitnessSet.fromCborBytes(witness.serialize());
    expect(decode.serialize(), witness.serialize());
  });
}
