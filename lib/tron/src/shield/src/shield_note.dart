import 'package:blockchain_utils/blockchain_utils.dart';
import 'package:on_chain/tron/src/proto_messages/protocol/src/api.dart';
import 'shield_keys.dart';
import 'sapling_note.dart';
import 'types.dart';

class TronShieldDecryptedNote {
  final TronSaplingNote note;
  final SaplingPaymentAddress recipient;
  final List<int>? memo;
  final int position;
  final TronSaplingNullifier? nullifier;

  /// Raw ciphertexts as returned by ScanNote RPC.
  final List<int> encCiphertext;
  final List<int> outCiphertext;
  final List<int> ephemeralKey;

  const TronShieldDecryptedNote({
    required this.note,
    required this.recipient,
    required this.memo,
    required this.nullifier,
    required this.encCiphertext,
    required this.outCiphertext,
    required this.ephemeralKey,
    this.position = 0,
  });

  BigInt get value => note.value.value;

  /// Build shield output for trial-decryption from RPC note fields.
  static TronSaplingShieldOutput toShieldOutput({
    required List<int> ephemeralKey,
    required List<int> cmu,
    required List<int> encCiphertext,
  }) {
    return TronSaplingShieldOutput(
      ephemeralKey: ShieldEphemeralKey(ephemeralKey),
      commitment: TronSaplingExtractedCommitment.fromBytes(cmu),
      encCiphertext: encCiphertext,
    );
  }

  /// this note as a proto [TronNote]
  /// (payment address as bech32 ztron1...).
  TronNote toTronNote() {
    return TronNote(
      value: value,
      paymentAddress: TronShieldAddressCodec.toBech32(recipient),
      rcm: List<int>.from(note.rseed.rcm().toBytes()),
      memo: memo,
    );
  }

  /// this note as a proto receive entry.
  TronReceiveNote toReceiveNote() => TronReceiveNote(note: toTronNote());

  /// This note as a TRC20 spend entry.
  /// [root]/[path] come from the shielded contract `getPath(position)`;
  /// [alpha] must be a fresh random scalar (also used to randomize the
  /// signing key for the spendAuthSig).
  TronSpendNoteTRC20 toSpendNoteTRC20({
    required List<int> alpha,
    required List<int> root,
    required List<int> path,
    BigInt? pos,
  }) {
    return TronSpendNoteTRC20(
      note: toTronNote(),
      alpha: alpha,
      root: root,
      path: path,
      pos: pos ?? BigInt.from(position),
    );
  }

  /// This note as note-parameters
  /// (for IsSpend / nullifier queries).
  TronNoteParameters toNoteParameters({
    required List<int> ak,
    required List<int> nk,
    List<int>? txid,
    int? index,
  }) {
    return TronNoteParameters(
      ak: ak,
      nk: nk,
      note: toTronNote(),
      txid: txid,
      index: index,
    );
  }

  /// Rebuild from a proto [TronNote]
  /// (server ScanNote plaintext form).
  static TronShieldDecryptedNote fromTronNote({
    required TronNote note,
    required SaplingPaymentAddress recipient,
    required TronSaplingRSeed rseed,
    List<int>? memo,
    int position = 0,
    TronSaplingNullifier? nullifier,
  }) {
    return TronShieldDecryptedNote(
      note: TronSaplingNote(
        recipient: recipient,
        value: ShieldAmount(note.value ?? BigInt.zero),
        rseed: rseed,
      ),
      recipient: recipient,
      memo: memo ?? note.memo,
      position: position,
      nullifier: nullifier,
      encCiphertext: const [],
      outCiphertext: const [],
      ephemeralKey: const [],
    );
  }
}

/// Outgoing (to be created) note request for the builder.
class TronShieldOutputRequest {
  final SaplingPaymentAddress to;
  final BigInt value;
  final List<int>? memo;
  final SaplingOutgoingViewingKey? ovk;
  const TronShieldOutputRequest({
    required this.to,
    required this.value,
    this.memo,
    this.ovk,
  });

  /// Request as a proto [TronReceiveNote].
  /// [rcm] must be fresh randomness (chain GetRcm or local Fr).
  TronReceiveNote toReceiveNote({required List<int> rcm, List<int>? memo}) {
    return TronReceiveNote(
      note: TronNote(
        value: value,
        paymentAddress: TronShieldAddressCodec.toBech32(to),
        rcm: rcm,
        memo: memo ?? this.memo ?? List<int>.filled(512, 0),
      ),
    );
  }
}

/// Spendable input (already scanned + witnessed).
class TronShieldSpendInput {
  final TronShieldDecryptedNote note;
  final SaplingFullViewingKey fvk;

  /// 32 siblings (each 32 bytes, Fq LE).
  final List<List<int>> authPath;

  /// 32 position flags (false = left, true = right), depth 32, LSB first.
  /// Must match the sibling path: this is the leaf index bits for the
  /// note in the commitment tree (e.g. the voucher `index` flags, or the
  /// bits of the position passed to the shielded contract `getPath`).
  /// A wrong position builds a witness for a different leaf and the
  /// spend proof will not verify.
  final List<bool> position;
  final List<int> anchor;
  const TronShieldSpendInput({
    required this.note,
    required this.fvk,
    required this.authPath,
    required this.position,
    required this.anchor,
  });
}
