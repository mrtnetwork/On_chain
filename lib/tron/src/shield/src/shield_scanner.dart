import 'package:blockchain_utils/blockchain_utils.dart';
import 'shield_note.dart';
import 'sapling_note.dart';
import 'types.dart';
import 'consts.dart';

class TronShieldScanKey {
  final SaplingIvk ivk;
  final SaplingFullViewingKey? fvk;
  final int activationHeight;
  const TronShieldScanKey({
    required this.ivk,
    this.fvk,
    this.activationHeight = 0,
  });
}

class TronShieldScannedNote {
  final TronShieldDecryptedNote note;
  final SaplingIvk ivk;
  const TronShieldScannedNote({required this.note, required this.ivk});
}

class TronShieldScanner {
  final TronSaplingDomain domain;
  TronShieldScanner([TronSaplingDomain? domain])
    : domain = domain ?? TronSaplingDomain();

  /// Trial-decrypt one RPC note output against a list of ivks.
  /// `rpcNote` expects keys: `epk`/`ephemeral_key`, `cmu`/`cm`, `enc`/`ciphertext`,
  /// `out`/`out_ciphertext`, `position`/`index`, `txid` (hex), `index`.
  TronShieldScannedNote? scanOne({
    required Map<String, dynamic> rpcNote,
    required List<TronShieldScanKey> keys,
    int? positionOverride,
  }) {
    final epk = _bytesField(rpcNote, ['epk', 'ephemeral_key', 'ephemeralKey']);
    final cmu = _bytesField(rpcNote, ['cmu', 'cm', 'commitment']);
    final enc = _bytesField(rpcNote, [
      'enc',
      'ciphertext',
      'enc_ciphertext',
      'encCiphertext',
    ]);
    final outCt = _bytesField(rpcNote, [
      'out',
      'out_ciphertext',
      'outCiphertext',
    ]);
    if (epk == null || cmu == null || enc == null) return null;
    final output = TronSaplingShieldOutput(
      ephemeralKey: ShieldEphemeralKey(epk),
      commitment: TronSaplingExtractedCommitment.fromBytes(cmu),
      encCiphertext: enc,
    );
    final ivks = keys.map((e) => e.ivk).toList();
    final found =
        domain.batchIvkNoteDecryption(ivks: ivks, output: output) ??
        _compactAsFallback(ivks, output);
    if (found == null) return null;
    final key = keys.firstWhere(
      (k) => k.ivk == found.ivk,
      orElse: () => keys.first,
    );
    final pos =
        positionOverride ??
        (rpcNote['position'] as int? ?? rpcNote['index'] as int? ?? 0);
    TronSaplingNullifier? nf;
    if (key.fvk != null) {
      try {
        nf = found.note.nullifier(nk: key.fvk!.vk.nk, position: pos);
      } catch (_) {
        nf = null;
      }
    }
    final dec = TronShieldDecryptedNote(
      note: found.note,
      recipient: found.recipient,
      memo: found.memo,
      position: pos,
      nullifier: nf,
      encCiphertext: enc,
      outCiphertext: outCt ?? <int>[],
      ephemeralKey: epk,
    );
    return TronShieldScannedNote(note: dec, ivk: found.ivk);
  }

  ShieldBatchIvkResult<SaplingIvk, TronSaplingNote, SaplingPaymentAddress>?
  _compactAsFallback(List<SaplingIvk> ivks, TronSaplingShieldOutput output) {
    // Compact ciphertexts (52B, no memo) are returned by ScanNoteByIvk.
    if (output.encCiphertext.length < ShieldNoteConst.compactNoteSize) {
      return null;
    }
    final compact = TronSaplingShieldOutput(
      ephemeralKey: output.ephemeralKey,
      commitment: output.commitment,
      encCiphertext: output.encCiphertext.sublist(
        0,
        ShieldNoteConst.compactNoteSize,
      ),
    );
    return domain.batchIvkCompactNoteDecryption(ivks: ivks, output: compact);
  }

  List<int>? _bytesField(Map<String, dynamic> m, List<String> keys) {
    for (final k in keys) {
      final v = m[k];
      if (v == null) continue;
      if (v is String) {
        final decoded = BytesUtils.tryFromHexString(v);
        if (decoded != null) return List<int>.from(decoded);
        continue;
      }
      if (v is List) return List<int>.from(v);
    }
    return null;
  }
}
