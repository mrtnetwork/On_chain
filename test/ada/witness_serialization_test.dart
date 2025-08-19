import 'package:blockchain_utils/blockchain_utils.dart';
import 'package:on_chain/ada/ada.dart';
import 'package:test/test.dart';

void main() {
  _witnessSerialization();
}

void _witnessSerialization() {
  test('serialization', () {
    final witness = TransactionWitnessSet(
      vKeys: VkeyWitnesses([
        Vkeywitness(
            vKey: Vkey.fromHex(
                'f9aa3fccb7fe539e471188ccc9ee65514c5961c070b06ca185962484a4813bee'),
            signature: Ed25519Signature.fromHex(
                '9dd4f5014c8a98760295533210bb4e5fbc6f8497769e3efcae6f219d12fc12e306f04878b8e6eb9dd125a9cf713b3631c7812fe9caf0894d51396a7fcba05600')),
      ],
          serializationConfig: VkeyWitnessesSerializationConfig(
              encoding: CborIterableEncodingType.definite)),
    );
    expect(witness.serializeHex(),
        'a10081825820f9aa3fccb7fe539e471188ccc9ee65514c5961c070b06ca185962484a4813bee58409dd4f5014c8a98760295533210bb4e5fbc6f8497769e3efcae6f219d12fc12e306f04878b8e6eb9dd125a9cf713b3631c7812fe9caf0894d51396a7fcba05600');
  });
  test('serialization_2', () {
    final witness = TransactionWitnessSet(
      vKeys: VkeyWitnesses([
        Vkeywitness(
            vKey: Vkey.fromHex(
                '4ced1e732e40b5a8abae0b7eb072565d1cb9554dd61ff88510657990a4075308'),
            signature: Ed25519Signature(List<int>.filled(64, 1))),
      ],
          serializationConfig: VkeyWitnessesSerializationConfig(
              encoding: CborIterableEncodingType.definite)),
      redeemers: Redeemers(
        serializationConfig: RedeemersSerializationConfig(
            encoding: RedeemersCborContainerType.definite),
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
      ),
      plutusData: PlutusList(
        [PlutusInteger(BigInt.one)],
        serializationConfig: PlutusListSerializationConfig(
            encoding: CborIterableEncodingType.inDefinite),
      ),
      plutusScriptsV1: PlutusScripts([],
          serializationConfig: PlutusScriptsSerializationConfig(
              encoding: CborIterableEncodingType.definite)),
    );
    expect(witness.serializeHex(),
        'a400818258204ced1e732e40b5a8abae0b7eb072565d1cb9554dd61ff88510657990a40753085840010101010101010101010101010101010101010101010101010101010101010101010101010101010101010101010101010101010101010101010101010101010380049f01ff058184000c0182187b1901c8');
    final decode = TransactionWitnessSet.fromCborBytes(witness.serialize());
    expect(decode.serialize(), witness.serialize());
  });
}
