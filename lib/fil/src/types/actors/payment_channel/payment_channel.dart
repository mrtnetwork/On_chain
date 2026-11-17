import 'package:blockchain_utils/blockchain_utils.dart';
import 'package:on_chain/fil/src/address/address.dart';
import 'package:on_chain/fil/src/crypto/crypto.dart';
import 'package:on_chain/fil/src/serialization/seriaization.dart';
import 'package:on_chain/fil/src/types/types/token_amount.dart';

// =============================================================================
// Payment Channel (Paych) actor parameter types
//
// Uni-directional payment channels allow off-chain micro-payments that are
// later settled on-chain. Typical flow:
//   1. createPaymentChannel (Init.Exec)
//   2. exchange signed vouchers off-chain
//   3. updateChannelState (submit best voucher)
//   4. settle → wait → collect
// =============================================================================

/// Constructor parameters for a Payment Channel (passed via Init.Exec).
///
/// [from] is the funder / voucher signer; [to] is the payee.
class FilPaychConstructorParams with FilSerialization {
  /// Channel funder (payer) address.
  final FilAddress from;

  /// Channel payee address.
  final FilAddress to;

  const FilPaychConstructorParams({required this.from, required this.to});

  @override
  CborListValue toCbor() {
    return CborSerializable.listFromObjects([from.toCbor(), to.toCbor()]);
  }
}

/// On-chain representation of a signed payment voucher.
///
/// Vouchers are exchanged off-chain and later submitted via
/// [FilPaychUpdateChannelStateParams]. Only the highest-value valid voucher
/// for a lane needs to be submitted.
class FilPaychSignedVoucher with FilSerialization {
  /// Address of the payment channel actor.
  final FilAddress channelAddr;

  /// Earliest epoch at which this voucher can be redeemed.
  final BigInt timeLockMin;

  /// Latest epoch at which this voucher can be redeemed (0 = no limit).
  final BigInt timeLockMax;

  /// Optional hash of a secret required to redeem (hash-locked payments).
  final List<int>? secretHash;

  /// Optional extra verification parameters (actor + method + data).
  final FilPaychModVerifyParams? extra;

  /// Payment lane (independent nonce space).
  final BigInt lane;

  /// Nonce within the lane (must be strictly increasing).
  final BigInt nonce;

  /// Cumulative amount that can be collected for this lane.
  final FilTokenAmount amount;

  /// Optional minimum settle height.
  final BigInt? minSettleHeight;

  /// Optional list of merged lanes.
  final List<FilPaychSignedVoucherMerge>? merges;

  /// Signature over the voucher (null when producing signing bytes).
  final FilSignature? signature;

  const FilPaychSignedVoucher({
    required this.channelAddr,
    required this.timeLockMin,
    required this.timeLockMax,
    this.secretHash,
    this.extra,
    required this.lane,
    required this.nonce,
    required this.amount,
    this.minSettleHeight,
    this.merges,
    this.signature,
  });

  /// Returns a copy with selected fields replaced.
  FilPaychSignedVoucher copyWith({
    FilAddress? channelAddr,
    BigInt? timeLockMin,
    BigInt? timeLockMax,
    List<int>? secretHash,
    FilPaychModVerifyParams? extra,
    BigInt? lane,
    BigInt? nonce,
    FilTokenAmount? amount,
    BigInt? minSettleHeight,
    List<FilPaychSignedVoucherMerge>? merges,
    FilSignature? signature,
  }) {
    return FilPaychSignedVoucher(
      channelAddr: channelAddr ?? this.channelAddr,
      timeLockMin: timeLockMin ?? this.timeLockMin,
      timeLockMax: timeLockMax ?? this.timeLockMax,
      lane: lane ?? this.lane,
      nonce: nonce ?? this.nonce,
      amount: amount ?? this.amount,
      extra: extra ?? this.extra,
      merges: merges ?? this.merges,
      minSettleHeight: minSettleHeight ?? this.minSettleHeight,
      secretHash: secretHash ?? this.secretHash,
      signature: signature ?? this.signature,
    );
  }

  /// CBOR encoding. When [signingBytes] is `true` the signature slot is
  /// encoded as null so the resulting bytes can be signed.
  @override
  CborListValue toCbor({bool signingBytes = false}) {
    return CborSerializable.listFromObjects([
      channelAddr.toCbor(),
      timeLockMin.toSafeIntCbor(),
      timeLockMax.toSafeIntCbor(),
      (secretHash ?? []).toCborBytes(),
      extra?.toCbor(),
      lane.toSafeIntCbor(),
      nonce.toSafeIntCbor(),
      amount.toCbor(),
      (minSettleHeight ?? BigInt.zero).toSafeIntCbor(),
      CborSerializable.listFromObjects(
        (merges ?? []).map((e) => e.toCbor()).toList(),
      ),
      if (signingBytes) CborNullValue() else signature?.toCbor(),
    ]);
  }

  /// Bytes that must be signed by the channel funder.
  List<int> signingBytes() => toCbor(signingBytes: true).encode();
}

/// Parameters for **Paych.UpdateChannelState** (method 2).
class FilPaychUpdateChannelStateParams with FilSerialization {
  /// Signed voucher to submit.
  final FilPaychSignedVoucher signedVoucherCbor;

  /// Pre-image of [FilPaychSignedVoucher.secretHash] when the voucher is hash-locked.
  final List<int> secret;

  const FilPaychUpdateChannelStateParams({
    required this.signedVoucherCbor,
    this.secret = const [],
  });

  @override
  CborListValue toCbor() {
    return CborSerializable.listFromObjects([
      signedVoucherCbor.toCbor(),
      secret.toCborBytes(),
    ]);
  }
}

/// Lane merge entry inside a signed voucher.
class FilPaychSignedVoucherMerge with FilSerialization {
  final BigInt lane;
  final BigInt nonce;

  const FilPaychSignedVoucherMerge({required this.lane, required this.nonce});

  @override
  CborObject<Object?> toCbor() {
    return CborSerializable.listFromObjects([
      lane.toSafeIntCbor(),
      nonce.toSafeIntCbor(),
    ]);
  }
}

/// Optional extra verification parameters attached to a voucher.
class FilPaychModVerifyParams with FilSerialization {
  /// Actor that will perform the extra verification.
  final FilAddress actor;

  /// Method number to call on [actor].
  final BigInt method;

  /// Opaque data passed to the verification method.
  final List<int> data;

  FilPaychModVerifyParams({
    required this.actor,
    required this.method,
    required List<int> data,
  }) : data = data.asImmutableBytes;

  @override
  CborObject<Object?> toCbor() {
    return CborSerializable.listFromObjects([
      actor.toCbor(),
      method.toSafeIntCbor(),
      data.toCborBytes(),
    ]);
  }
}
