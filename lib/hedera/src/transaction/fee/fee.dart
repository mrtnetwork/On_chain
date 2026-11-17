import 'package:blockchain_utils/blockchain_utils.dart';

import 'package:on_chain/exception/onchain_error.dart';
import 'package:on_chain/hedera/src/rpc/api/api/api/node.dart';
import 'package:on_chain/hedera/src/proto_messages/org/hiero/hapi/support/fees/src/fee_schedule.dart';
import 'package:on_chain/hedera/src/proto_messages/proto/src/basic_types.dart';
import 'package:on_chain/hedera/src/proto_messages/proto/src/exchange_rate.dart';
import 'package:on_chain/hedera/src/proto_messages/proto/src/file_get_contents.dart';
import 'package:on_chain/hedera/src/proto_messages/proto/src/transaction.dart';

enum HederaFeeScheduleMode { scheduleLegacy, scheduleHip1261, mirror }

class HederaFeeEstimate {
  /// max **non-gas** fee only (Hedera rule for EVM).
  final BigInt maxFee;

  /// Gas fee
  final BigInt? gasFee;

  /// maxFee + gasFee
  final BigInt total;

  final HederaFeeScheduleMode? mode;
  final int? signatureCount;

  const HederaFeeEstimate({
    required this.maxFee,
    this.mode,
    this.signatureCount,
    required this.total,
    this.gasFee,
  });
  Map<String, dynamic> toJson() => {
    "maxFee": maxFee,
    "gasFee": gasFee,
    "total": total,
    "mode": mode?.name,
    "signatureCount": signatureCount,
  };

  @override
  String toString() {
    return "HederaFeeEstimate(${toJson()})";
  }
}

/// Computes Hedera transaction fees under both fee schedules:
///
///  - `calculateFee`  — legacy resource-weighted schedule, file 0.0.111,
///    `HederaCurrentAndNextFeeSchedule` / `HederaFeeSchedule` /
///    `HederaTransactionFeeSchedule` / `HederaFeeData` / `HederaFeeComponents`.
///
///  - `calculateHIP1261Fee`  — Simple Fees schedule (HIP-1261), file 0.0.113,
///    `HederaNewFeeSchedule` / `HederaNodeFee` / `HederaNetworkFee` /
///    `HederaServiceFeeSchedule` / `HederaServiceFeeDefinition` /
///    `HederaExtraFeeDefinition` / `HederaExtraFeeReference`.
///
/// Both methods return a [HederaFee]: `maxFee` is the fee portion that does
/// not depend on gas usage (node + network + service base/extras with gas
/// usage zeroed out), `gasFee` is the portion attributable purely to
/// `gasUsed` (null when the tx type doesn't consume gas or none was
/// supplied), and `total = maxFee + (gasFee ?? 0)`.
abstract class HederaFeeCalculatorLike {
  Future<HederaFeeEstimate> calculateFee({
    required HederaTransactionBody body,
    required int totalSignature,
    BigInt? gasUsed,
    bool transferIncludesTokenWithCustomFees,
  });

  Future<HederaFeeEstimate> calculateHIP1261Fee({
    required HederaTransactionBody body,
    required int totalSignature,
    BigInt? gasUsed,
    int existingKeyCount,
    int existingAccountCount,
    bool transferIncludesTokenWithCustomFees,
    bool submitToTopicWithCustomFee,
    int stateBytesWritten,
    int recordsProduced,
  });

  Future<BigInt> gasPriceTinybars({
    HederaFeeScheduleMode mode = HederaFeeScheduleMode.scheduleHip1261,
  });
  HederaExchangeRateSet? get exchangeRate;
}

class HederaFeeCalculator implements HederaFeeCalculatorLike {
  static const int feeScheduleId = 111;
  static const int hip1261FeeScheduleId = 113;
  static const int exchangeRateSetId = 112;

  HederaExchangeRateSet? _exchange;
  HederaCurrentAndNextFeeSchedule? _feeSchedule;
  HederaHIP1261FeeSchedule? _hip1264;
  final HederaQuickQueryApi client;

  @override
  HederaExchangeRateSet? get exchangeRate => _exchange;
  HederaFeeCalculator({
    HederaExchangeRateSet? exchange,
    required this.client,
    HederaCurrentAndNextFeeSchedule? feeSchedule,
    HederaHIP1261FeeSchedule? hip1264,
  }) : _exchange = exchange,
       _feeSchedule = feeSchedule,
       _hip1264 = hip1264;

  Future<HederaExchangeRateSet> exchangeRateSet() async {
    HederaExchangeRateSet? exchange = _exchange;
    if (exchange != null) return exchange;
    final result = await _getFileContent(fileId: exchangeRateSetId);
    return _exchange = HederaExchangeRateSet.deserialize(result);
  }

  Future<HederaHIP1261FeeSchedule> hip1261FeeSchedule() async {
    HederaHIP1261FeeSchedule? feeSchedule = _hip1264;
    if (feeSchedule != null) return feeSchedule;
    final result = await _getFileContent(fileId: hip1261FeeScheduleId);
    return _hip1264 = HederaHIP1261FeeSchedule.deserialize(result);
  }

  Future<HederaCurrentAndNextFeeSchedule> feeSchedule() async {
    HederaCurrentAndNextFeeSchedule? feeSchedule = _feeSchedule;
    if (feeSchedule != null) return feeSchedule;
    final result = await _getFileContent(fileId: feeScheduleId);
    return _feeSchedule = HederaCurrentAndNextFeeSchedule.deserialize(result);
  }

  Future<List<int>> _getFileContent({required int fileId}) async {
    final result = await client.query(
      query: HederaFileGetContentsQuery(
        fileID: HederaFileID(fileNum: BigInt.from(fileId)),
      ),
    );
    return result.fileContents?.contents ?? [];
  }

  /// Required struct/message field: throws a specific, named error instead
  /// of crashing on `!` when the fee schedule / tx data is incomplete.
  static T _need<T extends Object>(T? value, String field) {
    if (value == null) {
      throw OnChainErrors.hederaPlugin(
        "HederaFeeCalculator",
        reason: 'Missing required field "$field"',
      );
    }
    return value;
  }

  /// Numeric leaf field → plain [int], defaulting to 0 when absent.
  static int _int(Object? value) {
    if (value == null) return 0;
    if (value is int) return value;
    if (value is BigInt && value.isSafeInt()) return value.asSafeInt;
    throw OnChainErrors.hederaPlugin(
      "HederaFeeCalculator",
      reason: 'Failed to convert value to int.',
      details: {"value": value.toString()},
    );
  }

  /// Numeric leaf field that must not be zero because it's a divisor —
  /// distinct from [_int] because defaulting a divisor to 0 would hide a
  /// real data problem behind a division-by-zero crash instead of a clear
  /// message.
  static int _nonZeroInt(int? value, String field) {
    final v = _int(value);
    if (v == 0) {
      throw OnChainErrors.hederaPlugin(
        "HederaFeeCalculator",
        reason: 'Field "$field" must be non-zero',
      );
    }
    return v;
  }

  /// Converts a fee already expressed in tinycents into tinybars.
  /// fee_tinybars = fee_tinycents * hbarEquiv / centEquiv
  static BigInt _tinyCentsToTinybars(
    BigInt tinyCents,
    HederaExchangeRate rate,
  ) {
    final hbarEquiv = _int(rate.hbarEquiv);
    final centEquiv = _nonZeroInt(rate.centEquiv, 'exchangeRate.centEquiv');
    return (tinyCents * BigInt.from(hbarEquiv)) ~/ BigInt.from(centEquiv);
  }

  /// Picks whichever exchange rate (current or next) is active "now".
  static HederaExchangeRate _activeRate(HederaExchangeRateSet set) {
    final currentRate = _need(set.currentRate, 'exchangeRateSet.currentRate');
    final nowSeconds = DateTime.now().toUtc().millisecondsSinceEpoch ~/ 1000;
    final expiry = _int(currentRate.expirationTime?.seconds);
    if (nowSeconds < expiry) return currentRate;
    return _need(set.nextRate, 'exchangeRateSet.nextRate');
  }

  /// Splits a fee already expressed in tinycents into a [HederaFee]:
  /// - [maxFeeTinyCents] — portion independent of gas usage.
  /// - [gasFeeTinyCents] — portion attributable purely to gas usage; 0
  ///   (and therefore reported as `null` on [HederaFee.gasFee]) when the
  ///   tx type doesn't consume gas or none was supplied.
  /// `total` is derived as `maxFee + (gasFee ?? 0)` rather than converted
  /// independently, so the two parts always add up exactly.
  static HederaFeeEstimate _buildFee({
    required int maxFeeTinyCents,
    required int gasFeeTinyCents,
    required HederaExchangeRate rate,
    required HederaFeeScheduleMode mode,
    required int totalSignature,
  }) {
    final maxFeeTinybar = _tinyCentsToTinybars(
      BigInt.from(maxFeeTinyCents),
      rate,
    );
    final BigInt? gasFeeTinybar =
        gasFeeTinyCents > 0
            ? _tinyCentsToTinybars(BigInt.from(gasFeeTinyCents), rate)
            : null;
    return HederaFeeEstimate(
      maxFee: maxFeeTinybar,
      gasFee: gasFeeTinybar,
      total: maxFeeTinybar + (gasFeeTinybar ?? BigInt.zero),
      mode: mode,
      signatureCount: totalSignature,
    );
  }

  /// Fee for [body] under the legacy resource-weighted schedule from file
  /// 0.0.111, split into gas-independent [HederaFee.maxFee] and
  /// gas-attributable [HederaFee.gasFee].
  ///
  /// [transferIncludesTokenWithCustomFees] — only relevant for
  /// CryptoTransfer: set true if ANY token moved in this transfer has a
  /// custom-fee schedule attached. The tx body only has token IDs, not
  /// their custom-fee configuration, so this can't be derived here — look
  /// it up from your token cache / mirror node before calling.
  @override
  Future<HederaFeeEstimate> calculateFee({
    required HederaTransactionBody body,
    required int totalSignature,
    BigInt? gasUsed,
    bool transferIncludesTokenWithCustomFees = false,
  }) async {
    final exchange = await exchangeRateSet();
    final feeSchedule = await this.feeSchedule();
    final functionality = body.hederaFunctionality;
    final activeSchedule = _activeOldSchedule(feeSchedule);

    final entry = activeSchedule.transactionFeeSchedule.firstWhere(
      (e) => e.hederaFunctionality == functionality,
      orElse:
          () =>
              throw OnChainErrors.hederaPlugin(
                "calculateFee",
                reason: "No TransactionFeeSchedule entry for $functionality.",
              ),
    );

    final feeData =
        entry.fees.isNotEmpty
            ? _pickFeeData(
              entry.fees,
              body,
              transferIncludesTokenWithCustomFees,
            )
            : entry.feeData;
    final resolvedFeeData = _need(feeData, 'transactionFeeSchedule.feeData');

    final bytes = body.toBuffer().length;

    final usage = _LegacyUsage(
      bpt: bytes,
      vpt: totalSignature,
      rbh: _ramByteHoursFor(body),
      sbh: _storageByteHoursFor(body),
      gas: _int(gasUsed ?? BigInt.zero),
      tv: _transferValueFor(body),
      bpr: 0, // response bandwidth — queries only, not applicable here
      sbpr: 0, // response storage — queries only, not applicable here
    );
    // Same usage with gas zeroed out — used to isolate the gas-only
    // portion of the fee (clamping is per-component and non-linear, so we
    // can't just subtract `c.gas * u.gas` after the fact).
    final usageNoGas = _LegacyUsage(
      bpt: usage.bpt,
      vpt: usage.vpt,
      rbh: usage.rbh,
      sbh: usage.sbh,
      gas: 0,
      tv: usage.tv,
      bpr: usage.bpr,
      sbpr: usage.sbpr,
    );

    final nodeData = _need(resolvedFeeData.nodedata, 'feeData.nodedata');
    final networkData = _need(
      resolvedFeeData.networkdata,
      'feeData.networkdata',
    );
    final serviceData = _need(
      resolvedFeeData.servicedata,
      'feeData.servicedata',
    );

    final nodeRaw = _componentFee(nodeData, usage);
    final networkRaw = _componentFee(networkData, usage);
    final serviceRaw = _componentFee(serviceData, usage);

    final nodeRawNoGas = _componentFee(nodeData, usageNoGas);
    final networkRawNoGas = _componentFee(networkData, usageNoGas);
    final serviceRawNoGas = _componentFee(serviceData, usageNoGas);

    // FeeComponents values are priced in *thousandths* of a tinycent.
    final maxFeeTinyCents =
        (nodeRawNoGas + networkRawNoGas + serviceRawNoGas) ~/ 1000;
    final totalTinyCentsWithGas = (nodeRaw + networkRaw + serviceRaw) ~/ 1000;
    final gasFeeTinyCents = (totalTinyCentsWithGas - maxFeeTinyCents).clamp(
      0,
      1 << 62,
    );

    return _buildFee(
      maxFeeTinyCents: maxFeeTinyCents,
      gasFeeTinyCents: gasFeeTinyCents,

      rate: _activeRate(exchange),
      totalSignature: totalSignature,
      mode: HederaFeeScheduleMode.scheduleLegacy,
    );
  }

  /// Price of a single unit of gas, in tinybars — the Hedera analogue of
  /// `eth_gasPrice`. Unlike [calculateFee]/[calculateHIP1261Fee], this does
  /// NOT depend on a transaction body; it's the flat per-gas coefficient
  /// published in the active fee schedule, converted through the current
  /// exchange rate.
  @override
  Future<BigInt> gasPriceTinybars({
    HederaFeeScheduleMode mode = HederaFeeScheduleMode.scheduleHip1261,
  }) async {
    final rate = HederaFeeCalculator._activeRate(await exchangeRateSet());

    if (mode == HederaFeeScheduleMode.scheduleLegacy) {
      final schedule = HederaFeeCalculator._activeOldSchedule(
        await feeSchedule(),
      );
      final entry = schedule.transactionFeeSchedule.firstWhere(
        (e) => e.hederaFunctionality == HederaHederaFunctionality.contractCall,
        orElse:
            () =>
                throw OnChainErrors.hederaPlugin(
                  "gasPriceTinybars",
                  reason: "No ContractCall entry in legacy fee schedule.",
                ),
      );
      final feeData = entry.fees.isNotEmpty ? entry.fees.first : entry.feeData;
      final serviceData = HederaFeeCalculator._need(
        feeData?.servicedata,
        'feeData.servicedata',
      );
      // gas coefficient is in thousandths of a tinycent; convert to
      // tinybars *before* dividing by 1000 to avoid losing precision.
      final gasThousandthsTinyCents = BigInt.from(
        HederaFeeCalculator._int(serviceData.gas),
      );
      final tinybarsThousandths = HederaFeeCalculator._tinyCentsToTinybars(
        gasThousandthsTinyCents,
        rate,
      );
      return tinybarsThousandths ~/ BigInt.from(1000);
    }

    // HIP-1261: flat per-gas extra fee, already in whole tinycents.
    final schedule = await hip1261FeeSchedule();
    HederaExtraFeeDefinition? gasExtra;
    for (final def in schedule.extras) {
      if (def.name == HederaExtra.gas) {
        gasExtra = def;
        break;
      }
    }
    final resolved = HederaFeeCalculator._need(gasExtra, 'extras[gas]');
    return HederaFeeCalculator._tinyCentsToTinybars(
      BigInt.from(HederaFeeCalculator._int(resolved.fee)),
      rate,
    );
  }

  static HederaFeeSchedule _activeOldSchedule(
    HederaCurrentAndNextFeeSchedule schedule,
  ) {
    final currentSchedule = _need(
      schedule.currentFeeSchedule,
      'feeSchedule.currentFeeSchedule',
    );
    final nowSeconds = DateTime.now().toUtc().millisecondsSinceEpoch ~/ 1000;
    final expiry = _int(currentSchedule.expiryTime?.seconds);
    if (nowSeconds < expiry) return currentSchedule;
    return _need(schedule.nextFeeSchedule, 'feeSchedule.nextFeeSchedule');
  }

  static HederaFeeData? _pickFeeData(
    List<HederaFeeData> fees,
    HederaTransactionBody body,
    bool transferIncludesTokenWithCustomFees,
  ) {
    final wanted = _subTypeOf(body, transferIncludesTokenWithCustomFees);
    HederaFeeData? match;
    for (final f in fees) {
      if (f.subType == wanted) {
        match = f;
        break;
      }
    }
    return match ?? (fees.isNotEmpty ? fees.first : null);
  }

  /// Derives the SubType used to pick the right priced variant of a
  /// transaction. Covers the cases that actually vary by SubType in the
  /// current fee schedule; everything else correctly falls through to
  /// `default_`.
  static HederaSubType _subTypeOf(
    HederaTransactionBody body,
    bool transferIncludesTokenWithCustomFees,
  ) {
    // TokenCreate — fungible vs NFT, each with a *_WITH_CUSTOM_FEES variant
    // when the create body itself defines custom fees.
    if (body.tokenCreation != null) {
      final t = body.tokenCreation!;
      final hasCustomFees = t.customFees.isNotEmpty;
      final isNft = t.tokenType == HederaTokenType.nonFungibleUnique;
      if (isNft) {
        return hasCustomFees
            ? HederaSubType.tokenNonFungibleUniqueWithCustomFees
            : HederaSubType.tokenNonFungibleUnique;
      }
      return hasCustomFees
          ? HederaSubType.tokenFungibleCommonWithCustomFees
          : HederaSubType.tokenFungibleCommon;
    }

    // TokenMint / TokenBurn / TokenWipe — NFT variant if serials/metadata
    // are present, fungible variant otherwise (amount-based).
    if (body.tokenMint != null) {
      return body.tokenMint!.metadata.isNotEmpty
          ? HederaSubType.tokenNonFungibleUnique
          : HederaSubType.tokenFungibleCommon;
    }
    if (body.tokenBurn != null) {
      return body.tokenBurn!.serialNumbers.isNotEmpty
          ? HederaSubType.tokenNonFungibleUnique
          : HederaSubType.tokenFungibleCommon;
    }
    if (body.tokenWipe != null) {
      return body.tokenWipe!.serialNumbers.isNotEmpty
          ? HederaSubType.tokenNonFungibleUnique
          : HederaSubType.tokenFungibleCommon;
    }

    // CryptoTransfer — priced differently depending on whether it moves
    // only hbar, fungible tokens, or NFTs, and whether any moved token
    // carries custom fees (needs [transferIncludesTokenWithCustomFees]
    // since token config isn't in the tx body).
    if (body.cryptoTransfer != null) {
      final tokenTransfers = body.cryptoTransfer!.tokenTransfers;
      if (tokenTransfers.isEmpty) {
        return HederaSubType.default_; // plain hbar transfer
      }
      final movesNfts = tokenTransfers.any((t) => t.nftTransfers.isNotEmpty);
      if (movesNfts) {
        return transferIncludesTokenWithCustomFees
            ? HederaSubType.tokenNonFungibleUniqueWithCustomFees
            : HederaSubType.tokenNonFungibleUnique;
      }
      return transferIncludesTokenWithCustomFees
          ? HederaSubType.tokenFungibleCommonWithCustomFees
          : HederaSubType.tokenFungibleCommon;
    }

    // ScheduleCreate wrapping a ContractCall prices differently.
    if (body.scheduleCreate?.scheduledTransactionBody?.contractCall != null) {
      return HederaSubType.scheduleCreateContractCall;
    }

    // extend: ConsensusSubmitMessage *_WITH_CUSTOM_FEES SubType (HIP-991) —
    // needs to know whether the *target topic* has custom fees, which
    // (like the transfer case above) isn't in the submit body itself and
    // would need its own bool param, e.g. `submitToTopicWithCustomFees`.

    return HederaSubType.default_;
  }

  /// extend: RAM byte-hours for entities that stay on ledger past this tx
  /// (accounts, files, tokens, topics, contracts) — roughly
  /// `entitySizeBytes * autoRenewPeriod.seconds / 3600` for *Create ops.
  /// Left as a stub because the per-entity size formula differs by type;
  /// wire in the specific one(s) you actually submit.
  static int _ramByteHoursFor(HederaTransactionBody body) => 0;

  /// Storage byte-hours for content that persists on ledger, billed by
  /// bytes stored times how long (in hours) it's kept via autoRenew.
  static int _storageByteHoursFor(HederaTransactionBody body) {
    if (body.fileCreate != null) {
      final f = body.fileCreate!;
      final seconds = _int(f.expirationTime?.seconds);
      final nowSeconds = DateTime.now().toUtc().millisecondsSinceEpoch ~/ 3600;
      final lifetimeHours =
          ((seconds - nowSeconds) / 3600).clamp(0, 1 << 31).toInt();
      return (f.contents?.length ?? 0) * lifetimeHours;
    }
    if (body.fileAppend != null) {
      // FileAppend doesn't carry the file's remaining autoRenew period, so
      // this only bills for the bytes added, not lifetime-weighted storage.
      // extend: pass the target file's remaining lifetime in hours if you
      // need this priced exactly like consensus nodes do.
      return body.fileAppend!.contents?.length ?? 0;
    }
    return 0;
  }

  /// For CryptoTransfer, the transfer-value component: sum of the positive
  /// AccountAmount.amount values in the hbar transfer list (debits and
  /// credits are mirrored, so summing only positives avoids double count).
  static int _transferValueFor(HederaTransactionBody body) {
    final transfers = body.cryptoTransfer?.transfers?.accountAmounts;
    if (transfers == null) return 0;
    var total = 0;
    for (final aa in transfers) {
      final amount = _int(aa.amount);
      if (amount > 0) total += amount;
    }
    return total;
  }

  static int _componentFee(HederaFeeComponents c, _LegacyUsage u) {
    final raw =
        _int(c.constant) +
        _int(c.bpt) * u.bpt +
        _int(c.vpt) * u.vpt +
        _int(c.rbh) * u.rbh +
        _int(c.sbh) * u.sbh +
        _int(c.gas) * u.gas +
        _int(c.tv) * u.tv +
        _int(c.bpr) * u.bpr +
        _int(c.sbpr) * u.sbpr;
    return raw.clamp(_int(c.min), _int(c.max));
  }

  /// Fee for [body] under the Simple Fees schedule from file 0.0.113,
  /// split into gas-independent [HederaFee.maxFee] and gas-attributable
  /// [HederaFee.gasFee]. Only the service-fee component depends on gas
  /// (via the `gas` extra), so node/network fee always land entirely in
  /// `maxFee`.
  ///
  /// Extras that depend on chain state rather than the tx body are exposed
  /// as parameters — pass them when the relevant transaction type applies,
  /// leave them at their defaults (0/false) otherwise:
  ///
  /// - [existingKeyCount] — number of keys already on the entity being
  ///   updated (AccountUpdate/TokenUpdate/etc. bodies only carry *changed*
  ///   fields, not the entity's current key count).
  /// - [existingAccountCount] — for txs whose price scales with how many
  ///   accounts are touched beyond what's in the body (e.g. auto-created
  ///   accounts from an unknown-alias transfer) — you'll know this only
  ///   after simulating the transfer.
  /// - [transferIncludesTokenWithCustomFees] — whether any token moved by
  ///   a CryptoTransfer has a custom-fee schedule attached (drives the
  ///   TOKEN_TRANSFER_BASE_CUSTOM_FEES extra); not present in the transfer
  ///   body itself.
  /// - [submitToTopicWithCustomFee] — whether the topic a
  ///   ConsensusSubmitMessage targets has custom fees configured (HIP-991);
  ///   not present in the submit body itself.
  /// - [stateBytesWritten] / [recordsProduced] — actual node-side usage
  ///   numbers (state growth, records emitted) that only exist after
  ///   execution — pass 0 for a pre-submission fee estimate.
  @override
  Future<HederaFeeEstimate> calculateHIP1261Fee({
    required HederaTransactionBody body,
    required int totalSignature,
    BigInt? gasUsed,
    int existingKeyCount = 0,
    int existingAccountCount = 0,
    bool transferIncludesTokenWithCustomFees = false,
    bool submitToTopicWithCustomFee = false,
    int stateBytesWritten = 0,
    int recordsProduced = 0,
  }) async {
    final exchange = await exchangeRateSet();
    final feeSchedule = await hip1261FeeSchedule();

    final functionality = body.hederaFunctionality;
    final bytes = body.toBuffer().length;

    final nodeSchedule = _need(feeSchedule.node, 'feeSchedule.node');
    final networkSchedule = _need(feeSchedule.network, 'feeSchedule.network');

    // -- Node fee: identical base+extras formula for every tx type, and
    // never depends on gas. --
    final nodeUsage = <HederaExtra, int>{
      HederaExtra.signatures: totalSignature,
      HederaExtra.processingBytes: bytes,
    };
    final nodeFee =
        _int(nodeSchedule.baseFee) +
        _extrasCost(nodeSchedule.extras, feeSchedule.extras, nodeUsage);

    // -- Network fee: multiplier of the node fee, also gas-independent. --
    final networkFee = _int(networkSchedule.multiplier) * nodeFee;

    // -- Service fee: specific to this transaction/query, and the only
    // component that can vary with gas usage. Compute it once with the
    // real gas usage and once with gas zeroed out so the gas-only portion
    // can be isolated after extras (min/max, tiers, etc.) are applied. --
    final definition = _findServiceDefinition(feeSchedule, functionality);
    var serviceFee = 0;
    var serviceFeeNoGas = 0;
    if (definition != null && !(definition.free ?? false)) {
      final serviceUsage = _serviceUsageFor(
        body: body,
        totalSignature: totalSignature,
        bytes: bytes,
        gasUsed: gasUsed,
        existingKeyCount: existingKeyCount,
        existingAccountCount: existingAccountCount,
        transferIncludesTokenWithCustomFees:
            transferIncludesTokenWithCustomFees,
        submitToTopicWithCustomFee: submitToTopicWithCustomFee,
        stateBytesWritten: stateBytesWritten,
        recordsProduced: recordsProduced,
      );
      final serviceUsageNoGas = Map<HederaExtra, int>.from(serviceUsage)
        ..[HederaExtra.gas] = 0;

      final base = _int(definition.baseFee);
      serviceFee =
          base +
          _extrasCost(definition.extras, feeSchedule.extras, serviceUsage);
      serviceFeeNoGas =
          base +
          _extrasCost(definition.extras, feeSchedule.extras, serviceUsageNoGas);
    }

    final maxFeeTinyCents = nodeFee + networkFee + serviceFeeNoGas;
    final gasFeeTinyCents = (serviceFee - serviceFeeNoGas).clamp(0, 1 << 62);

    return _buildFee(
      maxFeeTinyCents: maxFeeTinyCents,
      gasFeeTinyCents: gasFeeTinyCents,
      rate: _activeRate(exchange),
      totalSignature: totalSignature,
      mode: HederaFeeScheduleMode.scheduleHip1261,
    );
  }

  /// Builds the usage map for the service-fee extras. Extras not
  /// applicable to [body]'s transaction type simply won't be referenced by
  /// that type's `HederaServiceFeeDefinition.extras`, so it's safe to
  /// populate all of them generically here.
  static Map<HederaExtra, int> _serviceUsageFor({
    required HederaTransactionBody body,
    required int totalSignature,
    required int bytes,
    required BigInt? gasUsed,
    required int existingKeyCount,
    required int existingAccountCount,
    required bool transferIncludesTokenWithCustomFees,
    required bool submitToTopicWithCustomFee,
    required int stateBytesWritten,
    required int recordsProduced,
  }) {
    // Keys — new keys being set by this tx (create/update bodies carry a
    // key or KeyList directly), plus any [existingKeyCount] the caller
    // supplied for update-type bodies.
    int keyCount = existingKeyCount;
    if (body.cryptoCreateAccount?.key != null) keyCount += 1;
    if (body.tokenCreation != null) {
      final t = body.tokenCreation!;
      for (final k in [
        t.adminKey,
        t.kycKey,
        t.freezeKey,
        t.wipeKey,
        t.supplyKey,
        t.feeScheduleKey,
        t.pauseKey,
      ]) {
        if (k != null) keyCount += 1;
      }
    }

    // Accounts — distinct account IDs touched by a transfer, plus any
    // extra accounts (e.g. auto-created) the caller knows about.
    int accountCount = existingAccountCount;
    final accountAmounts = body.cryptoTransfer?.transfers?.accountAmounts;
    if (accountAmounts != null) accountCount += accountAmounts.length;

    // TokenTypes — distinct tokens referenced by a multi-token operation.
    int tokenTypeCount = 0;
    if (body.tokenAssociate != null) {
      tokenTypeCount += body.tokenAssociate!.tokens.length;
    }
    if (body.tokenDissociate != null) {
      tokenTypeCount += body.tokenDissociate!.tokens.length;
    }
    final tokenTransfers = body.cryptoTransfer?.tokenTransfers;
    if (tokenTransfers != null) tokenTypeCount += tokenTransfers.length;

    // NftSerials — count of specific NFT serials this tx references, across
    // mint/burn/wipe/transfer.
    int nftSerialCount = 0;
    if (body.tokenMint != null) {
      nftSerialCount += body.tokenMint!.metadata.length;
    }
    if (body.tokenBurn != null) {
      nftSerialCount += body.tokenBurn!.serialNumbers.length;
    }
    if (body.tokenWipe != null) {
      nftSerialCount += body.tokenWipe!.serialNumbers.length;
    }
    if (tokenTransfers != null) {
      for (final tt in tokenTransfers) {
        nftSerialCount += tt.nftTransfers.length;
      }
    }

    // Allowances — count of each allowance kind being approved/removed.
    int allowanceCount = 0;
    if (body.cryptoApproveAllowance != null) {
      final a = body.cryptoApproveAllowance!;
      allowanceCount +=
          a.cryptoAllowances.length +
          a.tokenAllowances.length +
          a.nftAllowances.length;
    }
    if (body.cryptoDeleteAllowance != null) {
      allowanceCount += body.cryptoDeleteAllowance!.nftAllowances.length;
    }

    // Airdrops — number of token-transfer entries in a TokenAirdrop.
    final airdropCount = body.tokenAirdrop?.tokenTransfers.length ?? 0;

    // TokenAssociate — number of tokens being associated in one call.
    final tokenAssociateCount = body.tokenAssociate?.tokens.length ?? 0;

    // Token transfer base — number of token-transfer lines, and however
    // many of those carry custom fees (needs the caller-supplied flag
    // since custom-fee config isn't in the transfer body itself).
    final tokenTransferBaseCount = tokenTransfers?.length ?? 0;
    final tokenTransferBaseCustomFeesCount =
        transferIncludesTokenWithCustomFees ? tokenTransferBaseCount : 0;

    // TokenCreate with custom fees — flag extra.
    final tokenCreateWithCustomFee =
        (body.tokenCreation?.customFees.isNotEmpty ?? false) ? 1 : 0;

    // TokenMintNft / TokenMintNftBase — per-serial count vs. flat base flag
    // for an NFT mint call. (Semantics of "base" vs. per-unit here are my
    // best guess from the schedule's naming convention — confirm against
    // the actual HederaServiceFeeDefinition.extras entries for TokenMint.)
    final isNftMint = body.tokenMint?.metadata.isNotEmpty ?? false;
    final tokenMintNftCount = body.tokenMint?.metadata.length ?? 0;
    final tokenMintNftBase = isNftMint ? 1 : 0;

    // ConsensusCreateTopic with custom fees — flag extra.
    final consensusCreateTopicWithCustomFee =
        (body.consensusCreateTopic?.customFees.isNotEmpty ?? false) ? 1 : 0;

    // ConsensusSubmitMessage — flag + message-bytes, split by whether the
    // target topic has custom fees (needs [submitToTopicWithCustomFee]
    // since that's topic state, not in the submit body).
    final submitMessageBytes =
        body.consensusSubmitMessage?.message?.length ?? 0;
    final consensusSubmitMessageWithCustomFee =
        (body.consensusSubmitMessage != null && submitToTopicWithCustomFee)
            ? 1
            : 0;
    final consensusSubmitMessageWithCustomFeeBytes =
        submitToTopicWithCustomFee ? submitMessageBytes : 0;
    final consensusSubmitMessageWithoutCustomFeeBytes =
        (body.consensusSubmitMessage != null && !submitToTopicWithCustomFee)
            ? submitMessageBytes
            : 0;

    // ScheduleCreate wrapping a ContractCall — flag extra.
    final scheduleCreateContractCallBase =
        (body.scheduleCreate?.scheduledTransactionBody?.contractCall != null)
            ? 1
            : 0;

    // NftUpdate — number of NFT serials updated in one call.
    final nftUpdateCount = body.tokenUpdateNfts?.serialNumbers.length ?? 0;

    // extend: HookUpdates / HookExecution / HookSlotUpdate — the
    // `hookStore` / `hookDispatch` message shapes weren't shown to me, so
    // these are left at 0. Wire in the real counts (hooks created/updated,
    // hooks executed, storage slots touched) once you have those fields.
    const hookUpdates = 0;
    const hookExecution = 0;
    const hookSlotUpdate = 0;

    return <HederaExtra, int>{
      HederaExtra.signatures: totalSignature,
      HederaExtra.processingBytes: bytes,
      HederaExtra.gas: _int(gasUsed ?? BigInt.zero),
      HederaExtra.keys: keyCount,
      HederaExtra.accounts: accountCount,
      HederaExtra.tokenTypes: tokenTypeCount,
      HederaExtra.nftSerials: nftSerialCount,
      HederaExtra.allowances: allowanceCount,
      HederaExtra.airdrops: airdropCount,
      HederaExtra.tokenAssociate: tokenAssociateCount,
      HederaExtra.tokenTransferBase: tokenTransferBaseCount,
      HederaExtra.tokenTransferBaseCustomFees: tokenTransferBaseCustomFeesCount,
      HederaExtra.tokenCreateWithCustomFee: tokenCreateWithCustomFee,
      HederaExtra.tokenMintNft: tokenMintNftCount,
      HederaExtra.tokenMintNftBase: tokenMintNftBase,
      HederaExtra.consensusCreateTopicWithCustomFee:
          consensusCreateTopicWithCustomFee,
      HederaExtra.consensusSubmitMessageWithCustomFee:
          consensusSubmitMessageWithCustomFee,
      HederaExtra.consensusSubmitMessageWithCustomFeeBytes:
          consensusSubmitMessageWithCustomFeeBytes,
      HederaExtra.consensusSubmitMessageWithoutCustomFeeBytes:
          consensusSubmitMessageWithoutCustomFeeBytes,
      HederaExtra.scheduleCreateContractCallBase:
          scheduleCreateContractCallBase,
      HederaExtra.nftUpdate: nftUpdateCount,
      HederaExtra.records: recordsProduced,
      HederaExtra.stateBytes: stateBytesWritten,
      HederaExtra.hookUpdates: hookUpdates,
      HederaExtra.hookExecution: hookExecution,
      HederaExtra.hookSlotUpdate: hookSlotUpdate,
    };
  }

  static HederaServiceFeeDefinition? _findServiceDefinition(
    HederaHIP1261FeeSchedule feeSchedule,
    HederaHederaFunctionality functionalityName,
  ) {
    for (final service in feeSchedule.services) {
      for (final def in service.schedule) {
        final cDef = def.name ?? HederaHederaFunctionality.none;
        if (cDef == functionalityName) return def;
      }
    }
    return null; // not present in this schedule — caller decides fallback
  }

  static int _extrasCost(
    List<HederaExtraFeeReference> references,
    List<HederaExtraFeeDefinition> definitions,
    Map<HederaExtra, int> usage,
  ) {
    var total = 0;
    for (final ref in references) {
      final used = usage[ref.name] ?? 0;
      final billable = used - _int(ref.includedCount);
      if (billable <= 0) continue;
      HederaExtraFeeDefinition? def;
      for (final d in definitions) {
        if (d.name == ref.name) {
          def = d;
          break;
        }
      }
      final resolvedDef = _need(
        def,
        'feeSchedule.extras[${ref.name?.protoName}]',
      );
      total += billable * _int(resolvedDef.fee);
    }
    return total;
  }
}

class _LegacyUsage {
  final int bpt, vpt, rbh, sbh, gas, tv, bpr, sbpr;
  const _LegacyUsage({
    required this.bpt,
    required this.vpt,
    required this.rbh,
    required this.sbh,
    required this.gas,
    required this.tv,
    required this.bpr,
    required this.sbpr,
  });
}

extension HederaTransactionBodyFeeExtension on HederaTransactionBody {
  HederaHederaFunctionality get hederaFunctionality {
    if (contractCall != null) return HederaHederaFunctionality.contractCall;
    if (contractCreateInstance != null) {
      return HederaHederaFunctionality.contractCreate;
    }
    if (contractUpdateInstance != null) {
      return HederaHederaFunctionality.contractUpdate;
    }
    if (contractDeleteInstance != null) {
      return HederaHederaFunctionality.contractDelete;
    }

    if (cryptoTransfer != null) return HederaHederaFunctionality.cryptoTransfer;
    if (cryptoCreateAccount != null) {
      return HederaHederaFunctionality.cryptoCreate;
    }
    if (cryptoUpdateAccount != null) {
      return HederaHederaFunctionality.cryptoUpdate;
    }
    if (cryptoDelete != null) return HederaHederaFunctionality.cryptoDelete;
    if (cryptoAddLiveHash != null) {
      return HederaHederaFunctionality.cryptoAddLiveHash;
    }
    if (cryptoDeleteLiveHash != null) {
      return HederaHederaFunctionality.cryptoDeleteLiveHash;
    }
    if (cryptoApproveAllowance != null) {
      return HederaHederaFunctionality.cryptoApproveAllowance;
    }
    if (cryptoDeleteAllowance != null) {
      return HederaHederaFunctionality.cryptoDeleteAllowance;
    }

    if (fileCreate != null) return HederaHederaFunctionality.fileCreate;
    if (fileAppend != null) return HederaHederaFunctionality.fileAppend;
    if (fileUpdate != null) return HederaHederaFunctionality.fileUpdate;
    if (fileDelete != null) return HederaHederaFunctionality.fileDelete;
    if (systemDelete != null) return HederaHederaFunctionality.systemDelete;
    if (systemUndelete != null) return HederaHederaFunctionality.systemUndelete;

    if (consensusCreateTopic != null) {
      return HederaHederaFunctionality.consensusCreateTopic;
    }
    if (consensusUpdateTopic != null) {
      return HederaHederaFunctionality.consensusUpdateTopic;
    }
    if (consensusDeleteTopic != null) {
      return HederaHederaFunctionality.consensusDeleteTopic;
    }
    if (consensusSubmitMessage != null) {
      return HederaHederaFunctionality.consensusSubmitMessage;
    }

    if (tokenCreation != null) return HederaHederaFunctionality.tokenCreate;
    if (tokenMint != null) return HederaHederaFunctionality.tokenMint;
    if (tokenBurn != null) return HederaHederaFunctionality.tokenBurn;
    if (tokenAssociate != null) {
      return HederaHederaFunctionality.tokenAssociateToAccount;
    }
    if (tokenDissociate != null) {
      return HederaHederaFunctionality.tokenDissociateFromAccount;
    }
    if (tokenFreeze != null) {
      return HederaHederaFunctionality.tokenFreezeAccount;
    }
    if (tokenUnfreeze != null) {
      return HederaHederaFunctionality.tokenUnfreezeAccount;
    }
    if (tokenGrantKyc != null) {
      return HederaHederaFunctionality.tokenGrantKycToAccount;
    }
    if (tokenRevokeKyc != null) {
      return HederaHederaFunctionality.tokenRevokeKycFromAccount;
    }
    if (tokenDeletion != null) return HederaHederaFunctionality.tokenDelete;
    if (tokenUpdate != null) return HederaHederaFunctionality.tokenUpdate;
    if (tokenWipe != null) return HederaHederaFunctionality.tokenAccountWipe;
    if (tokenFeeScheduleUpdate != null) {
      return HederaHederaFunctionality.tokenFeeScheduleUpdate;
    }
    if (tokenPause != null) return HederaHederaFunctionality.tokenPause;
    if (tokenUnpause != null) return HederaHederaFunctionality.tokenUnpause;
    if (tokenUpdateNfts != null) {
      return HederaHederaFunctionality.tokenUpdateNfts;
    }
    if (tokenReject != null) return HederaHederaFunctionality.tokenReject;
    if (tokenAirdrop != null) return HederaHederaFunctionality.tokenAirdrop;
    if (tokenCancelAirdrop != null) {
      return HederaHederaFunctionality.tokenCancelAirdrop;
    }
    if (tokenClaimAirdrop != null) {
      return HederaHederaFunctionality.tokenClaimAirdrop;
    }

    if (scheduleCreate != null) return HederaHederaFunctionality.scheduleCreate;
    if (scheduleSign != null) return HederaHederaFunctionality.scheduleSign;
    if (scheduleDelete != null) return HederaHederaFunctionality.scheduleDelete;

    if (nodeCreate != null) return HederaHederaFunctionality.nodeCreate;
    if (nodeUpdate != null) return HederaHederaFunctionality.nodeUpdate;
    if (nodeDelete != null) return HederaHederaFunctionality.nodeDelete;
    if (registeredNodeCreate != null) {
      return HederaHederaFunctionality.registeredNodeCreate;
    }
    if (registeredNodeUpdate != null) {
      return HederaHederaFunctionality.registeredNodeUpdate;
    }
    if (registeredNodeDelete != null) {
      return HederaHederaFunctionality.registeredNodeDelete;
    }
    if (nodeStakeUpdate != null) {
      return HederaHederaFunctionality.nodeStakeUpdate;
    }

    if (freeze != null) return HederaHederaFunctionality.freeze;
    if (uncheckedSubmit != null) {
      return HederaHederaFunctionality.uncheckedSubmit;
    }
    if (ethereumTransaction != null) {
      return HederaHederaFunctionality.ethereumTransaction;
    }
    if (utilPrng != null) return HederaHederaFunctionality.utilPrng;
    if (stateSignatureTransaction != null) {
      return HederaHederaFunctionality.stateSignatureTransaction;
    }
    if (hintsKeyPublication != null) {
      return HederaHederaFunctionality.hintsKeyPublication;
    }
    if (hintsPreprocessingVote != null) {
      return HederaHederaFunctionality.hintsPreprocessingVote;
    }
    if (hintsPartialSignature != null) {
      return HederaHederaFunctionality.hintsPartialSignature;
    }
    if (historyProofSignature != null) {
      return HederaHederaFunctionality.historyAssemblySignature;
    }
    if (historyProofKeyPublication != null) {
      return HederaHederaFunctionality.historyProofKeyPublication;
    }
    if (historyProofVote != null) {
      return HederaHederaFunctionality.historyProofVote;
    }
    if (crsPublication != null) return HederaHederaFunctionality.crsPublication;
    if (atomicBatch != null) return HederaHederaFunctionality.atomicBatch;
    if (hookStore != null) return HederaHederaFunctionality.hookStore;
    if (hookDispatch != null) return HederaHederaFunctionality.hookDispatch;
    if (ledgerIdPublication != null) {
      return HederaHederaFunctionality.ledgerIdPublication;
    }
    if (migrationRootHashVote != null) {
      return HederaHederaFunctionality.migrationRootHashVote;
    }

    throw OnChainErrors.hederaPlugin(
      "hederaFunctionality",
      reason: "Unknown Hedera transaction body type.",
    );
  }
}
