import 'dart:typed_data' show Endian;

import 'package:blockchain_utils/blockchain_utils.dart';

import 'package:blockchain_utils/utils/numbers/fixed/src/u64/u64.dart';
import 'package:on_chain/exception/onchain_error.dart';
import 'shield_note.dart';
import 'sapling_note.dart';
import 'tron_config.dart';
import 'types.dart';

class TronShieldWitness {
  final List<int> bytes;
  final int kind; // 0 spend, 1 output
  const TronShieldWitness(this.bytes, this.kind);
}

class TronShieldBuiltOutput {
  final TronSaplingNote note;
  final TronSaplingEncryptedNote encrypted;
  final List<int> encCiphertext;
  final List<int> outCiphertext;
  final List<int> epk;
  final JubJubFr rcv;
  final JubJubPoint cv;
  final TronShieldWitness witness;
  const TronShieldBuiltOutput({
    required this.note,
    required this.encrypted,
    required this.encCiphertext,
    required this.outCiphertext,
    required this.epk,
    required this.rcv,
    required this.cv,
    required this.witness,
  });
}

class TronShieldBuiltSpend {
  final TronShieldSpendInput input;
  final JubJubFr rcv;
  final JubJubFr alpha;
  final JubJubPoint cv;
  final TronSaplingNullifier nullifier;
  final List<int> rk;
  final TronShieldWitness witness;
  final SaplingExpandedSpendingKey? spendingKey;
  const TronShieldBuiltSpend({
    required this.input,
    required this.rcv,
    required this.alpha,
    required this.cv,
    required this.nullifier,
    required this.rk,
    required this.witness,
    required this.spendingKey,
  });
}

class TronShieldBuildResult {
  final List<TronShieldBuiltSpend> spends;
  final List<TronShieldBuiltOutput> outputs;

  /// bsk bytes (binding signing key) for final bindingSig.
  final List<int> bsk;

  /// bvk bytes (binding verification key).
  final List<int> bvk;
  final BigInt valueBalance;
  const TronShieldBuildResult({
    required this.spends,
    required this.outputs,
    required this.bsk,
    required this.bvk,
    required this.valueBalance,
  });
}

class TronShieldBuilder {
  final List<TronShieldSpendInput> _spends = [];
  final List<TronShieldOutputRequest> _outputs = [];
  final Map<TronShieldSpendInput, SaplingExpandedSpendingKey> _spendKeys = {};

  void addSpend(
    TronShieldSpendInput input, {
    SaplingExpandedSpendingKey? spendingKey,
  }) {
    _spends.add(input);
    if (spendingKey != null) _spendKeys[input] = spendingKey;
  }

  void addOutput(TronShieldOutputRequest out) => _outputs.add(out);

  static List<int> _u64le(BigInt v) => List<int>.from(
    BigintUtils.toBytes(v, length: 8, byteOrder: Endian.little),
  );

  static List<int> _b32(List<int> b, String name) {
    if (b.length != 32) {
      throw BuError(
        DefaultErrorType.invalidLength,
        'TronShieldBuilder: $name needs 32 bytes, got ${b.length}.',
      );
    }
    return b;
  }

  /// Pack spend witness (1288B) per Rust ffi::sapling docs.
  static List<int> packSpendWitness({
    required BigInt value,
    required List<int> rcv,
    required List<int> ak,
    required List<int> nsk,
    required List<int> gd,
    required List<int> rcm,
    required List<int> ar,
    required List<List<int>> authPath,
    required List<bool> pos,
    required List<int> anchor,
  }) {
    if (authPath.length != 32 || pos.length != 32) {
      throw const BuError(
        DefaultErrorType.invalidArgument,
        'Invalid spend witness shape: expected authPath[32]/pos[32].',
      );
    }
    return [
      ..._u64le(value),
      ..._b32(rcv, 'rcv'),
      ..._b32(ak, 'ak'),
      ..._b32(nsk, 'nsk'),
      ..._b32(gd, 'g_d'),
      ..._b32(rcm, 'rcm'),
      ..._b32(ar, 'ar'),
      for (final e in authPath) ..._b32(e, 'auth_path'),
      for (final b in pos) (b ? 1 : 0),
      ..._b32(anchor, 'anchor'),
    ];
  }

  /// Pack output witness (168B).
  static List<int> packOutputWitness({
    required BigInt value,
    required List<int> rcv,
    required List<int> gd,
    required List<int> pkd,
    required List<int> rcm,
    required List<int> esk,
  }) {
    return [
      ..._u64le(value),
      ..._b32(rcv, 'rcv'),
      ..._b32(gd, 'g_d'),
      ..._b32(pkd, 'pk_d'),
      ..._b32(rcm, 'rcm'),
      ..._b32(esk, 'esk'),
    ];
  }

  TronShieldBuildResult build({BigInt? valueBalance}) {
    final domain = TronSaplingDomain();
    // Pad to min sizes for privacy (dummy notes with zero value).
    final spends = List<TronShieldSpendInput>.from(_spends);
    final outputs = List<TronShieldOutputRequest>.from(_outputs);
    // NOTE: dummy padding needs a throwaway key; use random seed.
    while (spends.isEmpty && outputs.isNotEmpty) {
      // At least 1 spend slot required by circuit; caller should provide
      // real spend or use mint path (transparent-in). For now require spends.
      break;
    }
    if (spends.isEmpty) {
      throw const BuError(
        OnChainErrorType.tronPlugin,
        'TronShieldBuilder: no spends (transparent-to-shielded mint path is not implemented).',
      );
    }
    while (outputs.length < TronShieldConfig.minOutputs) {
      final fvk = spends.first.fvk;
      // Derive a throwaway diversifier address from nk? Simplify: reuse note recipient.
      outputs.add(
        TronShieldOutputRequest(
          to: spends.first.note.recipient,
          value: BigInt.zero,
          memo: TronShieldConfig.defaultMemo(),
          ovk: SaplingOutgoingViewingKey(List<int>.filled(32, 0)),
        ),
      );
      void _ = fvk;
      break;
    }

    final builtSpends = <TronShieldBuiltSpend>[];
    final builtOutputs = <TronShieldBuiltOutput>[];
    final rcvsSpend = <JubJubFr>[];
    final rcvsOut = <JubJubFr>[];
    final cvsSpend = <JubJubPoint>[];
    final cvsOut = <JubJubPoint>[];

    for (final s in spends) {
      final rcv = JubJubFr.random();
      final alpha = JubJubFr.random();
      final cv =
          TronSaplingUtils.valueCommitmentValueGenerator() *
              JubJubFr.from(Uint64.fromBigInt(s.note.value)) +
          TronSaplingUtils.valueCommitmentRandomnessGenerator() * rcv;
      // rk = ak + [alpha]G_spendAuth
      final akPoint = JubJubPoint.fromBytes(s.fvk.vk.ak.toBytes());
      final spendGen = JubJubPoint.fromBytes(
        SaplingKeyUtils.spendAuthGeneratorBytes,
      );
      final rkPoint = akPoint + (spendGen * alpha);
      final nf = s.note.note.nullifier(
        nk: s.fvk.vk.nk,
        position: s.note.position,
      );
      final gdBytes = List<int>.from(s.note.note.recipient.gd().toBytes());
      final rcmBytes = List<int>.from(s.note.note.rseed.rcm().toBytes());
      final witness = packSpendWitness(
        value: s.note.value,
        rcv: List<int>.from(rcv.toBytes()),
        ak: List<int>.from(s.fvk.vk.ak.toBytes()),
        nsk: _nskBytes(s.fvk, _spendKeys[s]),
        gd: gdBytes,
        rcm: rcmBytes,
        ar: List<int>.from(alpha.toBytes()),
        authPath: s.authPath,
        pos: _spendPos(s),
        anchor: s.anchor,
      );

      if (witness.length != 1288) {
        throw const BuError(
          DefaultErrorType.invalidArgument,
          'Invalid spend witness: expected 1288 bytes.',
        );
      }
      rcvsSpend.add(rcv);
      cvsSpend.add(cv);
      builtSpends.add(
        TronShieldBuiltSpend(
          input: s,
          rcv: rcv,
          alpha: alpha,
          cv: cv,
          nullifier: nf,
          rk: List<int>.from(rkPoint.toBytes()),
          witness: TronShieldWitness(witness, 0),
          spendingKey: _spendKeys[s],
        ),
      );
    }

    for (final o in outputs) {
      final rseed = TronSaplingRSeedAfter.random();
      final note = TronSaplingNote(
        recipient: o.to,
        value: ShieldAmount(o.value),
        rseed: rseed,
      );
      // validity check (cmu derivable)
      note.cmu();
      final esk = rseed.deriveEsk();
      final rcv = JubJubFr.random();
      final cv =
          TronSaplingUtils.valueCommitmentValueGenerator() *
              JubJubFr.from(Uint64.fromBigInt(o.value)) +
          TronSaplingUtils.valueCommitmentRandomnessGenerator() * rcv;
      final enc = domain.createNoteWithEsk(
        note: note,
        memo: o.memo ?? TronShieldConfig.defaultMemo(),
        esk: List<int>.from(esk.toBytes()),
        ovk: o.ovk,
      );
      final encCt = domain.encryptNotePlaintext(enc);
      final cmu = note.cmu();
      final outCt = domain.encryptOutgoingPlaintext(
        encryptedNote: enc,
        cv: List<int>.from(cv.toBytes()),
        cm: cmu,
      );
      final witness = packOutputWitness(
        value: o.value,
        rcv: List<int>.from(rcv.toBytes()),
        gd: List<int>.from(o.to.gd().toBytes()),
        pkd: List<int>.from(o.to.transmissionKey.toBytes()),
        rcm: List<int>.from(rseed.rcm().toBytes()),
        esk: List<int>.from(esk.toBytes()),
      );

      if (witness.length != 168) {
        throw const BuError(
          DefaultErrorType.invalidArgument,
          'Invalid output witness: expected 168 bytes.',
        );
      }
      rcvsOut.add(rcv);
      cvsOut.add(cv);
      builtOutputs.add(
        TronShieldBuiltOutput(
          note: note,
          encrypted: enc,
          encCiphertext: encCt,
          outCiphertext: outCt,
          epk: List<int>.from(domain.epkBytes(enc.epk).inner),
          rcv: rcv,
          cv: cv,
          witness: TronShieldWitness(witness, 1),
        ),
      );
    }

    // bsk = sum(rcv_s) - sum(rcv_o); bvk = sum(cv_s) - sum(cv_o) - [vBal]Gv
    JubJubFr bsk = JubJubFr.zero;
    for (final r in rcvsSpend) {
      bsk = bsk + r;
    }
    for (final r in rcvsOut) {
      bsk = bsk - r;
    }
    JubJubPoint bvk = JubJubPoint.identity();
    for (final c in cvsSpend) {
      bvk = bvk + c;
    }
    for (final c in cvsOut) {
      bvk = bvk - c;
    }
    final vBal = valueBalance ?? BigInt.zero;
    if (vBal != BigInt.zero) {
      final gv =
          TronSaplingUtils.valueCommitmentValueGenerator() *
          JubJubFr.from(Uint64.fromBigInt(vBal));
      bvk = bvk - gv;
    }
    return TronShieldBuildResult(
      spends: builtSpends,
      outputs: builtOutputs,
      bsk: List<int>.from(bsk.toBytes()),
      bvk: List<int>.from(bvk.toBytes()),
      valueBalance: vBal,
    );
  }

  List<int> _nskBytes(
    SaplingFullViewingKey fvk,
    SaplingExpandedSpendingKey? exsk,
  ) {
    if (exsk != null) return List<int>.from(exsk.nsk.toBytes());
    return List<int>.from(fvk.vk.nk.toBytes());
  }

  List<bool> _spendPos(TronShieldSpendInput s) {
    if (s.position.length != 32 || s.authPath.length != 32) {
      throw const BuError(
        DefaultErrorType.invalidArgument,
        'Invalid spend input: expected 32 position flags and 32 auth path siblings.',
      );
    }
    return s.position;
  }
}
