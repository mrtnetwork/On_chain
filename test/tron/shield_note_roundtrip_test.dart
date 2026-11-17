import 'package:blockchain_utils/blockchain_utils.dart';
import 'package:on_chain/tron/src/shield/src/sapling_note.dart';
import 'package:on_chain/tron/src/shield/src/shield_keys.dart';
import 'package:on_chain/tron/src/shield/src/types.dart';
import 'package:test/test.dart';

import '../utils.dart';

void shieldNoteRoundtripTest() {
  TronSaplingNote makeNote(
    SaplingPaymentAddress to,
    int value, {
    TronSaplingRSeed? rseed,
  }) {
    return TronSaplingNote(
      recipient: to,
      value: ShieldAmount.fromInt(value),
      rseed: rseed ?? TronSaplingRSeedAfter.random(),
    );
  }

  group('Tron/Sapling note encrypt/decrypt roundtrip', () {
    test('ivk trial-decryption recovers note and memo', () {
      final seed = List<int>.generate(64, (i) => i & 0xFF);
      final spending = TronShieldSpendingKey.master(seed);
      final address = spending.defaultAddress().$1;
      final ivk = spending.externalIvk();
      final ovk = spending.externalOvk();
      final domain = TronSaplingDomain();

      final note = makeNote(address, 123456);
      const memo = [1, 2, 3, 4];
      final enc = domain.createNote(note: note, memo: memo, ovk: ovk);
      final encCiphertext = domain.encryptNotePlaintext(enc);
      final output = TronSaplingShieldOutput(
        ephemeralKey: domain.epkBytes(enc.epk),
        commitment: note.cmu(),
        encCiphertext: List<int>.from(encCiphertext),
      );

      final found = domain.tryNoteDecryption(ivk: ivk, output: output);
      expect(found, isNotNull);
      expect(found!.$1.value.value, BigInt.from(123456));
      expect(
        List<int>.from(found.$1.recipient.toBytes()),
        List<int>.from(address.toBytes()),
      );
      expect(found.$3.sublist(0, memo.length), memo);
    });

    test('wrong ivk does not decrypt', () {
      final spending = TronShieldSpendingKey.master(
        List<int>.generate(64, (i) => i & 0xFF),
      );
      final other = TronShieldSpendingKey.master(
        List<int>.generate(64, (i) => (i + 1) & 0xFF),
      );
      final address = spending.defaultAddress().$1;
      final domain = TronSaplingDomain();

      final note = makeNote(address, 777);
      final enc = domain.createNote(
        note: note,
        memo: const [],
        ovk: spending.externalOvk(),
      );
      final output = TronSaplingShieldOutput(
        ephemeralKey: domain.epkBytes(enc.epk),
        commitment: note.cmu(),
        encCiphertext: List<int>.from(domain.encryptNotePlaintext(enc)),
      );
      expect(
        domain.tryNoteDecryption(ivk: other.externalIvk(), output: output),
        isNull,
      );
    });

    test('ovk output recovery recovers esk and pkD', () {
      final spending = TronShieldSpendingKey.master(
        List<int>.generate(64, (i) => (i * 3) & 0xFF),
      );
      final address = spending.defaultAddress().$1;
      final ovk = spending.externalOvk();
      final domain = TronSaplingDomain();

      final note = makeNote(address, 999);
      final enc = domain.createNote(note: note, memo: const [9], ovk: ovk);
      final cv = List<int>.filled(32, 8);
      final outCiphertext = domain.encryptOutgoingPlaintext(
        encryptedNote: enc,
        cv: cv,
        cm: note.cmu(),
      );
      final output = TronSaplingShieldOutput(
        ephemeralKey: domain.epkBytes(enc.epk),
        commitment: note.cmu(),
        encCiphertext: List<int>.from(domain.encryptNotePlaintext(enc)),
      );
      final recovered = domain.tryOutputRecoveryWithOvk(
        ovk: ovk,
        output: output,
        outCiphertext: List<int>.from(outCiphertext),
        cv: cv,
      );
      expect(recovered, isNotNull);
      expect(recovered!.$1.value.value, BigInt.from(999));
      expect(recovered.$3!.first, 9);
    });

    test('commitment and nullifier are deterministic', () {
      final spending = TronShieldSpendingKey.master(
        List<int>.generate(64, (i) => (i * 7 + 1) & 0xFF),
      );
      final address = spending.defaultAddress().$1;
      final nk = spending.fullViewingKey().vk.nk;
      final note = makeNote(address, 42);

      expect(note.cmu().toBytes(), note.cmu().toBytes());
      final nf1 = note.nullifier(nk: nk, position: 5);
      final nf2 = note.nullifier(nk: nk, position: 5);
      expect(nf1.toBytes(), nf2.toBytes());
      expect(nf1.toBytes().length, 32);
      // Different value commits differently.
      final other = makeNote(address, 43, rseed: note.rseed);
      expect(other.cmu().toBytes(), isNot(equals(note.cmu().toBytes())));
    });
  });
}

void main() {
  OnChainUtilsTestApi.runTest(shieldNoteRoundtripTest, 'ShieldNoteRoundtrip');
}
