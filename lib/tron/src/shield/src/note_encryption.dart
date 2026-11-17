import 'package:blockchain_utils/api/api.dart';
import 'package:blockchain_utils/crypto/quick_crypto.dart';
import 'package:blockchain_utils/utils/binary/src/utils.dart';

import 'consts.dart';
import 'types.dart';

/// Generic Sapling note-encryption domain.
/// Pure-Dart port of the zcash_dart note-encryption domain, kept here (TRON
/// shielded use) so `on_chain/tron` uses it without importing zcash_dart.
///
/// Uses only blockchain_utils primitives: JubJubNative*, Blake2b/s, ChaCha20,
/// ChaCha20Poly1305, QuickCrypto.
abstract class ShieldNoteDomain<
  Esk extends Object,
  Epk extends Object,
  DecSecret extends Object,
  EncSecret extends Object,
  N extends Object,
  Recipient extends Object,
  Pkd extends Object,
  Ivk extends Object,
  Ovk extends Object,
  Cv extends Object,
  Cm extends Object,
  Out extends ShieldOutput<Cm>,
  EncNote extends ShieldNoteEncryption<Esk, Epk, N, Ovk>
> {
  static const List<int> nonce = [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0];

  Esk? deriveEsk(N note);
  Pkd getPkD(N note);
  Epk kaDerivePublic(N note, Esk esk);
  EncSecret kaAgreeEnc(Esk esk, Pkd pkD);
  DecSecret kaAgreeDec(Ivk ivk, List<int> epkBytes);
  BuBytes kdf(DecSecret secret, ShieldEphemeralKey ephemeralKey);
  BuBytes encKdf(EncSecret secret, ShieldEphemeralKey ephemeralKey);
  BuBytes notePlaintextBytes(N note, List<int> memo);
  BuBytes deriveOck(Ovk ovk, Cv cv, Cm cm, ShieldEphemeralKey ephemeralKey);
  BuBytes outgoingPlaintextBytes(N note, Esk esk);
  ShieldEphemeralKey epkBytes(Epk epk);
  BuBytes? decEpkToBytes(ShieldEphemeralKey ephemeralKey);
  Cm cmstar(N note);
  (N, Recipient, BuBytes?)? parseNotePlaintextWithoutMemoIvk(
    Ivk ivk,
    List<int> plaintext,
    Out output,
  );
  (N, Recipient)? parseNotePlaintextWithoutMemoOvk(
    Pkd pkD,
    List<int> plaintext,
    Out output,
  );
  BuBytes extractMemo(List<int> plaintext);
  Pkd? extractPkD(List<int> outPlaintext);
  Esk? extractEsk(List<int> outPlaintext);

  (BuBytes, BuBytes)? splitPlaintextAtMemo(List<int> plaintext) {
    if (plaintext.length < ShieldNoteConst.memoLength) return null;
    final split = plaintext.length - ShieldNoteConst.memoLength;
    return (
      BuBytes(plaintext.sublist(0, split)),
      BuBytes(plaintext.sublist(split)),
    );
  }

  bool checkNoteValidity({
    required N note,
    required ShieldEphemeralKey ephemeralKey,
    required Cm cm,
  }) {
    final gCm = cmstar(note);
    if (gCm != cm) return false;
    // Strict epk check when esk is derivable (ZIP-212 style).
    final esk = deriveEsk(note);
    if (esk == null) return true;
    final epk = epkBytes(kaDerivePublic(note, esk));
    return BytesUtils.bytesEqual(
      List<int>.from(epk.inner),
      List<int>.from(ephemeralKey.inner),
    );
  }

  (N, Recipient, BuBytes?)? tryCompactNoteDecryption({
    required Ivk ivk,
    required Out output,
  }) {
    final epkRaw = decEpkToBytes(output.ephemeralKey);
    if (epkRaw == null) return null;
    final secret = kaAgreeDec(ivk, epkRaw);
    final key = kdf(secret, output.ephemeralKey);
    final pt = QuickCrypto.chacha20(key, (chacha) {
      return chacha.process(
        output.encCiphertextCompact,
        nonce: nonce,
        seekBytes: 64,
      );
    });
    final parsed = parseNotePlaintextWithoutMemoIvk(
      ivk,
      List<int>.from(pt),
      output,
    );
    if (parsed == null) return null;
    return parsed;
  }

  (N, Recipient, BuBytes)? tryNoteDecryption({
    required Ivk ivk,
    required Out output,
  }) {
    final epkRaw = decEpkToBytes(output.ephemeralKey);
    if (epkRaw == null) return null;
    final secret = kaAgreeDec(ivk, epkRaw);
    final key = kdf(secret, output.ephemeralKey);
    final split = output.splitCiphertextAtTag();
    if (split == null) return null;
    final dec = QuickCrypto.chacha20Poly1305(key, (chacha) {
      return chacha.decrypt(nonce, output.encCiphertext);
    });
    if (dec == null) return null;
    final compact = splitPlaintextAtMemo(List<int>.from(dec));
    if (compact == null) return null;
    final parsed = parseNotePlaintextWithoutMemoIvk(ivk, compact.$1, output);
    if (parsed == null) return null;
    return (parsed.$1, parsed.$2, compact.$2);
  }

  ShieldBatchIvkResult<Ivk, N, Recipient>? batchIvkCompactNoteDecryption({
    required List<Ivk> ivks,
    required Out output,
  }) {
    for (final ivk in ivks) {
      final d = tryCompactNoteDecryption(ivk: ivk, output: output);
      if (d != null) {
        return ShieldBatchIvkResult(
          ivk: ivk,
          note: d.$1,
          recipient: d.$2,
          memo: d.$3,
        );
      }
    }
    return null;
  }

  ShieldBatchIvkResult<Ivk, N, Recipient>? batchIvkNoteDecryption({
    required List<Ivk> ivks,
    required Out output,
  }) {
    for (final ivk in ivks) {
      final d = tryNoteDecryption(ivk: ivk, output: output);
      if (d != null) {
        return ShieldBatchIvkResult(
          ivk: ivk,
          note: d.$1,
          recipient: d.$2,
          memo: d.$3,
        );
      }
    }
    return null;
  }

  (N, Recipient, BuBytes?)? tryOutputRecoveryWithOvk({
    required Ovk ovk,
    required Out output,
    required List<int> outCiphertext,
    required Cv cv,
  }) {
    final ock = deriveOck(ovk, cv, output.cmstar(), output.ephemeralKey);
    return tryOutputRecoveryWithOck(
      ock: ock,
      output: output,
      outCiphertext: outCiphertext,
    );
  }

  (N, Recipient, BuBytes?)? tryOutputRecoveryWithOck({
    required BuBytes ock,
    required Out output,
    required List<int> outCiphertext,
  }) {
    if (ock.length != ShieldNoteConst.outgoingCipherKeyLen ||
        outCiphertext.length != ShieldNoteConst.outCiphertextSize) {
      return null;
    }
    final dec = QuickCrypto.chacha20Poly1305(ock, (chacha) {
      return chacha.decrypt(nonce, outCiphertext);
    });
    if (dec == null) return null;
    final pkD = extractPkD(List<int>.from(dec));
    final esk = extractEsk(List<int>.from(dec));
    if (pkD == null || esk == null) return null;
    final shared = kaAgreeEnc(esk, pkD);
    final key = encKdf(shared, output.ephemeralKey);
    final split = output.splitCiphertextAtTag();
    if (split == null) return null;
    final noteDec = QuickCrypto.chacha20Poly1305(key, (chacha) {
      return chacha.decrypt(nonce, output.encCiphertext);
    });
    if (noteDec == null) return null;
    final compact = splitPlaintextAtMemo(List<int>.from(noteDec));
    if (compact == null) return null;
    final note = parseNotePlaintextWithoutMemoOvk(pkD, compact.$1, output);
    if (note == null) return null;
    return (note.$1, note.$2, compact.$2);
  }

  EncNote createNote({required N note, required List<int> memo, Ovk? ovk});
  EncNote createNoteWithEsk({
    required N note,
    required List<int> memo,
    required List<int> esk,
    Ovk? ovk,
  });

  BuBytes encryptNotePlaintext(EncNote encryptedNote) {
    final pkD = getPkD(encryptedNote.note);
    final shared = kaAgreeEnc(encryptedNote.esk, pkD);
    final key = encKdf(shared, epkBytes(encryptedNote.epk));
    final input = notePlaintextBytes(encryptedNote.note, encryptedNote.memo);
    return QuickCrypto.chacha20Poly1305(key, (chacha) {
      return chacha.encrypt(nonce, input);
    });
  }

  BuBytes encryptOutgoingPlaintext({
    required EncNote encryptedNote,
    required Cv cv,
    required Cm cm,
  }) {
    final ovk = encryptedNote.ovk;
    late BuBytes ock;
    late BuBytes input;
    if (ovk != null) {
      ock = deriveOck(ovk, cv, cm, epkBytes(encryptedNote.epk));
      input = outgoingPlaintextBytes(encryptedNote.note, encryptedNote.esk);
    } else {
      ock = QuickCrypto.generateRandom(length: 32);
      input = QuickCrypto.generateRandom(
        length: ShieldNoteConst.outPlaintextSize,
      );
    }
    return QuickCrypto.chacha20Poly1305(ock, (chacha) {
      return chacha.encrypt(nonce, input);
    });
  }
}
