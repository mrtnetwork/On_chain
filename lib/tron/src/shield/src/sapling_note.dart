import 'package:blockchain_utils/blockchain_utils.dart';
import 'package:blockchain_utils/utils/numbers/fixed/src/u64/u64.dart';

import 'consts.dart';
import 'note_encryption.dart';
import 'types.dart';

/// Sapling note + commitment + nullifier + domain for
/// TRON shielded use. Reuses Sapling keys from
/// `package:blockchain_utils` zip32/sapling.
/// Mirrors zcash_dart `sapling/note/note.dart` but with BigInt amount, and
/// routes the Pedersen hash through `blockchainUtils.api` (native backend
/// when available) instead of calling PedersenHashNative directly —
/// mirroring how zcash_dart routes through its `ZcashCryptoContext`.

class TronSaplingNoteCommitment with Equality {
  final JubJubPoint inner;
  const TronSaplingNoteCommitment(this.inner);

  static JubJubPoint derive({
    required List<int> gD,
    required List<int> pkD,
    required ShieldAmount v,
    required JubJubFr rcm,
  }) {
    // LSB-first bit order (matches the pure-Dart PedersenHashNative path:
    // value LE, diversifier bytes LE, pk_d bytes LE).
    final bits = <bool>[
      ...v.toBits(),
      ...BytesUtils.bytesToBits(gD),
      ...BytesUtils.bytesToBits(pkD),
    ];
    final packed = BuBytes(
      List<int>.generate((bits.length + 7) ~/ 8, (i) {
        var b = 0;
        for (var k = 0; k < 8; k++) {
          final idx = i * 8 + k;
          if (idx < bits.length && bits[idx]) b |= 1 << k;
        }
        return b;
      }),
    );
    final compressed = blockchainUtils.api.hash.pedersenHash(
      personal: BuHashApi.pedersenNoteCommitment,
      packedBits: packed,
      bitLen: bits.length,
    );
    final pedersen = JubJubPoint.fromBytes(compressed);
    return pedersen + (SaplingKeyUtils.noteCommitmentRandomnessGenerator * rcm);
  }

  BuBytes toBytes() => inner.toBytes();

  @override
  List<dynamic> get variables => [inner];
}

class TronSaplingExtractedCommitment with Equality, LayoutSerializable {
  final JubJubFq inner;
  const TronSaplingExtractedCommitment(this.inner);
  factory TronSaplingExtractedCommitment.fromCommitment(
    TronSaplingNoteCommitment c,
  ) {
    return TronSaplingExtractedCommitment(c.inner.toAffine().u);
  }
  factory TronSaplingExtractedCommitment.fromBytes(List<int> bytes) {
    return TronSaplingExtractedCommitment(JubJubFq.fromBytes(bytes));
  }
  factory TronSaplingExtractedCommitment.deserialize(List<int> bytes) {
    final json = LayoutSerializable.deserialize(bytes: bytes, layout: layout());
    return TronSaplingExtractedCommitment.deserializeJson(json);
  }
  factory TronSaplingExtractedCommitment.deserializeJson(
    Map<String, dynamic> json,
  ) {
    return TronSaplingExtractedCommitment.fromBytes(json.valueAsBytes('inner'));
  }
  static Layout<Map<String, dynamic>> layout({String? property}) {
    return LayoutConst.struct([
      LayoutConst.fixedBlob32(property: 'inner'),
    ], property: property);
  }

  BuBytes toBytes() => inner.toBytes();

  @override
  List<dynamic> get variables => [inner];

  @override
  Layout<Map<String, dynamic>> toLayout({String? property}) =>
      layout(property: property);

  @override
  Map<String, dynamic> toSerializeJson() => {'inner': toBytes()};
}

class TronSaplingNullifier with Equality, LayoutSerializable {
  final BuBytes inner;
  TronSaplingNullifier(List<int> bytes)
    : inner =
          bytes.length == 32
              ? BuBytes.from(bytes)
              : throw BuError(
                DefaultErrorType.invalidLength,
                "Nullifier must be 32 bytes.",
                details: {'length': bytes.length.toString()},
              );
  factory TronSaplingNullifier.deserialize(List<int> bytes) {
    final json = LayoutSerializable.deserialize(bytes: bytes, layout: layout());
    return TronSaplingNullifier.deserializeJson(json);
  }
  factory TronSaplingNullifier.deserializeJson(Map<String, dynamic> json) {
    return TronSaplingNullifier(json.valueAsBytes('inner'));
  }
  static Layout<Map<String, dynamic>> layout({String? property}) {
    return LayoutConst.struct([
      LayoutConst.fixedBlob32(property: 'inner'),
    ], property: property);
  }

  BuBytes toBytes() => inner.cloneBytes();

  @override
  List<dynamic> get variables => [inner];

  @override
  Layout<Map<String, dynamic>> toLayout({String? property}) =>
      layout(property: property);

  @override
  Map<String, dynamic> toSerializeJson() => {'inner': toBytes()};
}

/// RSeed handling: before-ZIP212 (rcm is scalar) vs after (32 random bytes).
sealed class TronSaplingRSeed with Equality {
  const TronSaplingRSeed();
  JubJubFr rcm();
  JubJubFr? deriveEsk();
  BuBytes toBytes();
  int get tag;
}

class TronSaplingRSeedBefore extends TronSaplingRSeed {
  final JubJubFr inner;
  const TronSaplingRSeedBefore(this.inner);
  @override
  JubJubFr rcm() => inner;
  @override
  JubJubFr? deriveEsk() => null;
  @override
  BuBytes toBytes() => BuBytes(inner.toBytes());
  @override
  int get tag => 1;
  @override
  List<dynamic> get variables => [inner];
}

class TronSaplingRSeedAfter extends TronSaplingRSeed {
  final BuBytes inner;
  TronSaplingRSeedAfter(List<int> bytes)
    : inner =
          bytes.length == 32
              ? BuBytes.from(bytes)
              : throw BuError(
                DefaultErrorType.invalidLength,
                "RSeed must be 32 bytes.",
                details: {'length': bytes.length.toString()},
              );
  factory TronSaplingRSeedAfter.random() =>
      TronSaplingRSeedAfter(QuickCrypto.generateRandom(length: 32));
  @override
  JubJubFr rcm() =>
      JubJubFr.fromBytes64(PrfExpand.saplingRcm.apply(List<int>.from(inner)));
  @override
  JubJubFr deriveEsk() =>
      JubJubFr.fromBytes64(PrfExpand.saplingEsk.apply(List<int>.from(inner)));
  @override
  BuBytes toBytes() => BuBytes(inner);
  @override
  int get tag => 2;
  @override
  List<dynamic> get variables => [inner];
}

class TronSaplingNote with Equality, LayoutSerializable {
  final SaplingPaymentAddress recipient;
  final ShieldAmount value;
  final TronSaplingRSeed rseed;
  TronSaplingNote({
    required this.recipient,
    required this.value,
    required this.rseed,
  });

  /// Compact layout: recipient(43) || value u64 LE || rseed tag u8 || rseed(32).
  static Layout<Map<String, dynamic>> layout({String? property}) {
    return LayoutConst.struct([
      LayoutConst.fixedBlobN(43, property: 'recipient'),
      LayoutConst.u64(property: 'value'),
      LayoutConst.u8(property: 'rseed_tag'),
      LayoutConst.fixedBlob32(property: 'rseed'),
    ], property: property);
  }

  factory TronSaplingNote.deserialize(List<int> bytes) {
    final json = LayoutSerializable.deserialize(bytes: bytes, layout: layout());
    return TronSaplingNote.deserializeJson(json);
  }

  factory TronSaplingNote.deserializeJson(Map<String, dynamic> json) {
    final recipient = SaplingPaymentAddress.fromBytesUnchecked(
      json.valueAsBytes('recipient')!,
    );
    final rseedBytes = json.valueAsBytes('rseed')!;
    final TronSaplingRSeed rseed = switch (json.valueAsInt('rseed_tag')) {
      1 => TronSaplingRSeedBefore(JubJubFr.fromBytes(rseedBytes)),
      _ => TronSaplingRSeedAfter(rseedBytes),
    };
    return TronSaplingNote(
      recipient: recipient,
      value: ShieldAmount(json.valueAsBigInt('value')),
      rseed: rseed,
    );
  }

  @override
  Layout<Map<String, dynamic>> toLayout({String? property}) =>
      layout(property: property);

  @override
  Map<String, dynamic> toSerializeJson() => {
    'recipient': List<int>.from(recipient.toBytes()),
    'value': value.value,
    'rseed_tag': rseed.tag,
    'rseed': rseed.toBytes(),
  };

  TronSaplingNoteCommitment? _full;
  TronSaplingNoteCommitment fullCommitment() {
    final cached = _full;
    if (cached != null) return cached;
    final c = TronSaplingNoteCommitment(
      TronSaplingNoteCommitment.derive(
        gD: List<int>.from(recipient.gd().toBytes()),
        pkD: List<int>.from(recipient.transmissionKey.toBytes()),
        v: value,
        rcm: rseed.rcm(),
      ),
    );
    _full = c;
    return c;
  }

  TronSaplingExtractedCommitment cmu() =>
      TronSaplingExtractedCommitment.fromCommitment(fullCommitment());

  /// nf = Blake2s(Zcash_nf, nk || rho), rho = cm + [pos] * J.
  TronSaplingNullifier nullifier({
    required SaplingNullifierDerivingKey nk,
    required int position,
  }) {
    final rho = TronSaplingUtils.mixingPedersenHash(
      fullCommitment().inner,
      position,
    );
    final nfBytes = TronSaplingUtils.prfNf(nk: nk.inner, rho: rho);
    return TronSaplingNullifier(nfBytes);
  }

  JubJubFr? deriveEsk() => rseed.deriveEsk();

  @override
  List<dynamic> get variables => [recipient, value, rseed];
}

/// Placeholder to allow non-nullable late caching without context.
class JubJubNativePointPlaceholder {
  static JubJubPoint get identity => JubJubPoint.identity();
}

class TronSaplingEncryptedNote
    extends
        ShieldNoteEncryption<
          JubJubFr,
          JubJubPoint,
          TronSaplingNote,
          SaplingOutgoingViewingKey
        > {
  const TronSaplingEncryptedNote({
    required super.esk,
    required super.epk,
    required super.note,
    required super.memo,
    required super.ovk,
  });
}

class TronSaplingShieldOutput
    with ShieldOutput<TronSaplingExtractedCommitment> {
  @override
  final ShieldEphemeralKey ephemeralKey;
  final TronSaplingExtractedCommitment commitment;
  @override
  final BuBytes encCiphertext;
  TronSaplingShieldOutput({
    required this.ephemeralKey,
    required this.commitment,
    required List<int> encCiphertext,
  }) : encCiphertext = BuBytes.from(encCiphertext);
  @override
  TronSaplingExtractedCommitment cmstar() => commitment;
  @override
  BuBytes cmstarBytes() => BuBytes(commitment.toBytes());
  @override
  BuBytes get encCiphertextCompact {
    if (encCiphertext.length < ShieldNoteConst.compactNoteSize) {
      return BuBytes(encCiphertext);
    }
    return encCiphertext.sublist(0, ShieldNoteConst.compactNoteSize);
  }
}

/// Sapling utils for TRON (KDF, KA, nullifier helpers). Generator points are
/// shared with `SaplingKeyUtils` (zcash key mirrors) instead of redefined.
class TronSaplingUtils {
  static BuBytes kdfSapling({
    required List<int> ephemeralKey,
    required List<int> secret,
  }) {
    return BuBytes(
      QuickCrypto.blake2b256Hash(
        secret,
        extraBlocks: [ephemeralKey],
        personalization: 'Zcash_SaplingKDF'.codeUnits,
      ),
    );
  }

  static JubJubPoint kaAgree({
    required JubJubFr scalar,
    required JubJubPoint b,
  }) {
    return (b * scalar).clearCofactor();
  }

  static JubJubPoint kaDerivePublic({
    required JubJubFr scalar,
    required JubJubPoint b,
  }) {
    return b * scalar;
  }

  static JubJubPoint mixingPedersenHash(JubJubPoint cm, int position) {
    return cm +
        (SaplingKeyUtils.nullifierPositionGenerator *
            JubJubFr.from(Uint64.from(position)));
  }

  static BuBytes prfNf({required JubJubPoint nk, required JubJubPoint rho}) {
    return BuBytes(
      QuickCrypto.blake2s256Hash(
        nk.toBytes().toList(),
        personalization: 'Zcash_nf'.codeUnits,
        extraBlocks: [rho.toBytes().toList()],
      ),
    );
  }

  static BuBytes deriveOck({
    required SaplingOutgoingViewingKey ovk,
    required List<int> cv,
    required List<int> cm,
    required List<int> epk,
  }) {
    return BuBytes(
      QuickCrypto.blake2b256Hash(
        List<int>.from(ovk.inner),
        extraBlocks: [cv, cm, epk],
        personalization: 'Zcash_Derive_ock'.codeUnits,
      ),
    );
  }

  /// Value-commitment value generator V (`cv = v*V + rcv*R`).
  static JubJubPoint valueCommitmentValueGenerator() =>
      SaplingKeyUtils.valueCommitmentValueGenerator;

  /// Value-commitment randomness generator R (== binding signature generator).
  static JubJubPoint valueCommitmentRandomnessGenerator() =>
      JubJubPoint.fromBytes(SaplingKeyUtils.bindingGeneratorBytes);
}

/// Domain implementing ShieldNoteDomain for Tron Sapling notes.
class TronSaplingDomain
    extends
        ShieldNoteDomain<
          JubJubFr,
          JubJubPoint,
          JubJubPoint,
          JubJubPoint,
          TronSaplingNote,
          SaplingPaymentAddress,
          SaplingDiversifiedTransmissionKey,
          SaplingIvk,
          SaplingOutgoingViewingKey,
          List<int>,
          TronSaplingExtractedCommitment,
          TronSaplingShieldOutput,
          TronSaplingEncryptedNote
        > {
  @override
  TronSaplingExtractedCommitment cmstar(TronSaplingNote note) => note.cmu();

  @override
  BuBytes? decEpkToBytes(ShieldEphemeralKey ephemeralKey) {
    try {
      final p = JubJubPoint.fromBytes(List<int>.from(ephemeralKey.inner));
      if (p.isIdentity()) return null;
      return BuBytes(ephemeralKey.inner);
    } catch (_) {
      return null;
    }
  }

  @override
  JubJubFr? deriveEsk(TronSaplingNote note) => note.deriveEsk();

  @override
  BuBytes deriveOck(
    SaplingOutgoingViewingKey ovk,
    List<int> cv,
    TronSaplingExtractedCommitment cm,
    ShieldEphemeralKey ephemeralKey,
  ) {
    return TronSaplingUtils.deriveOck(
      ovk: ovk,
      cv: cv,
      cm: List<int>.from(cm.toBytes()),
      epk: List<int>.from(ephemeralKey.inner),
    );
  }

  @override
  BuBytes encKdf(JubJubPoint secret, ShieldEphemeralKey ephemeralKey) =>
      TronSaplingUtils.kdfSapling(
        ephemeralKey: List<int>.from(ephemeralKey.inner),
        secret: secret.toBytes().toList(),
      );

  @override
  ShieldEphemeralKey epkBytes(JubJubPoint epk) =>
      ShieldEphemeralKey(epk.toBytes().toList());

  @override
  JubJubFr? extractEsk(List<int> outPlaintext) {
    if (outPlaintext.length < 64) return null;
    return JubJubFr.fromBytes(outPlaintext.sublist(32, 64));
  }

  @override
  BuBytes extractMemo(List<int> plaintext) {
    if (plaintext.length < ShieldNoteConst.compactNoteSize) return BuBytes([]);
    return BuBytes(plaintext.sublist(ShieldNoteConst.compactNoteSize));
  }

  @override
  SaplingDiversifiedTransmissionKey? extractPkD(List<int> outPlaintext) {
    if (outPlaintext.length < 32) return null;
    try {
      return SaplingDiversifiedTransmissionKey.fromBytes(
        outPlaintext.sublist(0, 32),
      );
    } catch (_) {
      return null;
    }
  }

  @override
  SaplingDiversifiedTransmissionKey getPkD(TronSaplingNote note) =>
      note.recipient.transmissionKey;

  @override
  JubJubPoint kaAgreeDec(SaplingIvk ivk, List<int> epkBytes) {
    final epk = JubJubPoint.fromBytes(epkBytes);
    return TronSaplingUtils.kaAgree(scalar: ivk.inner, b: epk);
  }

  @override
  JubJubPoint kaAgreeEnc(JubJubFr esk, SaplingDiversifiedTransmissionKey pkD) {
    return TronSaplingUtils.kaAgree(scalar: esk, b: pkD.toPoint());
  }

  @override
  JubJubPoint kaDerivePublic(TronSaplingNote note, JubJubFr esk) {
    return TronSaplingUtils.kaDerivePublic(scalar: esk, b: note.recipient.gd());
  }

  @override
  BuBytes kdf(JubJubPoint secret, ShieldEphemeralKey ephemeralKey) =>
      TronSaplingUtils.kdfSapling(
        ephemeralKey: List<int>.from(ephemeralKey.inner),
        secret: secret.toBytes().toList(),
      );

  @override
  BuBytes notePlaintextBytes(TronSaplingNote note, List<int> memo) {
    final memoPad = List<int>.filled(ShieldNoteConst.memoLength, 0);
    for (int i = 0; i < memo.length && i < memoPad.length; i++) {
      memoPad[i] = memo[i];
    }
    return BuBytes([
      note.rseed.tag,
      ...note.recipient.diversifier.inner,
      ...note.value.toBytes(),
      ...note.rseed.toBytes(),
      ...memoPad,
    ]);
  }

  @override
  BuBytes outgoingPlaintextBytes(TronSaplingNote note, JubJubFr esk) =>
      BuBytes([...note.recipient.transmissionKey.toBytes(), ...esk.toBytes()]);

  (TronSaplingNote, BuBytes?)? _parse(
    List<int> plaintext,
    SaplingDiversifiedTransmissionKey? Function(Diversifier d) pkd,
  ) {
    if (plaintext.length < ShieldNoteConst.compactNoteSize) return null;
    final tag = plaintext[0];
    if (tag != 1 && tag != 2) return null;
    try {
      final dv = Diversifier(plaintext.sublist(1, 12));
      final value = ShieldAmount.fromBytes(plaintext.sublist(12, 20));
      final r = plaintext.sublist(20, 52);
      final TronSaplingRSeed rseed =
          tag == 1
              ? TronSaplingRSeedBefore(JubJubFr.fromBytes(r))
              : TronSaplingRSeedAfter(r);
      final pkD = pkd(dv);
      if (pkD == null) return null;
      final to = SaplingPaymentAddress(transmissionKey: pkD, diversifier: dv);
      final note = TronSaplingNote(recipient: to, value: value, rseed: rseed);
      // validity: cmu must be derivable
      note.cmu();
      final BuBytes? memo =
          plaintext.length == ShieldNoteConst.notePlaintextSize
              ? BuBytes(plaintext.sublist(ShieldNoteConst.compactNoteSize))
              : null;
      return (note, memo);
    } catch (_) {
      return null;
    }
  }

  @override
  (TronSaplingNote, SaplingPaymentAddress, BuBytes?)?
  parseNotePlaintextWithoutMemoIvk(
    SaplingIvk ivk,
    List<int> plaintext,
    TronSaplingShieldOutput output,
  ) {
    final n = _parse(plaintext, (dv) {
      try {
        final pkd = SaplingDiversifiedTransmissionKey.derive(
          d: dv,
          ivk: ivk.inner,
        );
        return pkd;
      } catch (_) {
        return null;
      }
    });
    if (n == null) return null;
    return (n.$1, n.$1.recipient, n.$2);
  }

  @override
  (TronSaplingNote, SaplingPaymentAddress)? parseNotePlaintextWithoutMemoOvk(
    SaplingDiversifiedTransmissionKey pkD,
    List<int> plaintext,
    TronSaplingShieldOutput output,
  ) {
    final n = _parse(plaintext, (_) => pkD);
    if (n == null) return null;
    return (n.$1, n.$1.recipient);
  }

  @override
  TronSaplingEncryptedNote createNote({
    required TronSaplingNote note,
    required List<int> memo,
    SaplingOutgoingViewingKey? ovk,
  }) {
    final esk = deriveEsk(note);
    if (esk == null) {
      throw BuError(
        DefaultErrorType.invalidArgument,
        "Cannot create note: ZIP-212 style note has no ephemeral secret key.",
      );
    }
    return TronSaplingEncryptedNote(
      esk: esk,
      epk: kaDerivePublic(note, esk),
      note: note,
      memo: memo,
      ovk: ovk,
    );
  }

  @override
  TronSaplingEncryptedNote createNoteWithEsk({
    required TronSaplingNote note,
    required List<int> memo,
    required List<int> esk,
    SaplingOutgoingViewingKey? ovk,
  }) {
    final s = JubJubFr.fromBytes(esk);
    return TronSaplingEncryptedNote(
      esk: s,
      epk: kaDerivePublic(note, s),
      note: note,
      memo: memo,
      ovk: ovk,
    );
  }
}
