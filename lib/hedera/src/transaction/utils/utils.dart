import 'package:blockchain_utils/blockchain_utils.dart';

import 'package:on_chain/exception/onchain_error.dart';
import 'package:on_chain/hedera/src/proto_messages/proto/models.dart';
import 'package:on_chain/on_chain.dart';

class HederaFeeEstimateOptions {
  final HederaFeeScheduleMode mode;
  final int signatureCount;
  final BigInt? gasUsed;
  final bool transferIncludesTokenWithCustomFees;
  final bool submitToTopicWithCustomFee;
  final int existingKeyCount;
  final int existingAccountCount;
  final double safetyMultiplier;
  final BigInt? minFeeTinybars;
  final BigInt? maxFeeTinybars;

  const HederaFeeEstimateOptions({
    this.mode = HederaFeeScheduleMode.mirror,
    required this.signatureCount,
    this.gasUsed,
    this.transferIncludesTokenWithCustomFees = false,
    this.submitToTopicWithCustomFee = false,
    this.existingKeyCount = 0,
    this.existingAccountCount = 0,
    this.safetyMultiplier = 1.25,
    this.minFeeTinybars,
    this.maxFeeTinybars,
  });
}

/// Shared helpers for [HederaTransactionBuilder]: gas estimation, fee
/// estimation (schedule + mirror), and small pure utilities.
///
/// Keep primary set*/sign/finalize APIs on the builder; put estimation here.
class HederaTransactionBuilderUtils {
  HederaTransactionBuilderUtils({
    required this.client,
    required this.feeCalculator,
  });

  final HederaClient client;
  final HederaFeeCalculatorLike feeCalculator;

  /// Fallback gas for contract create when estimate is unavailable.
  static final BigInt defaultContractCreateGas = BigInt.from(2_000_000);

  static HederaAddress? addressFromAccountId(HederaAccountID? id) {
    if (id == null) return null;
    try {
      return HederaAddress.fromAccountId(id);
    } catch (_) {
      return null;
    }
  }

  // ── Safety multipliers ───────────────────────────────────────────────────

  static BigInt applyGasSafety(BigInt estimated, double multiplier) {
    if (multiplier < 1.0) {
      throw OnChainErrors.hederaTx(
        'applyGasSafety',
        reason: 'Gas safety multiplier must be >= 1.0.',
      );
    }
    final scaled =
        (estimated * BigInt.from((multiplier * 1000).round())) ~/
        BigInt.from(1000);
    return scaled <= BigInt.zero ? BigInt.one : scaled;
  }

  static BigInt applyFeeSafety(
    BigInt raw, {
    required double multiplier,
    BigInt? minFee,
    BigInt? maxFee,
  }) {
    if (multiplier < 1.0) {
      throw OnChainErrors.hederaTx(
        'applyFeeSafety',
        reason: 'Safety multiplier must be >= 1.0.',
      );
    }
    BigInt fee = raw;
    if (multiplier > 1.0) {
      fee =
          (raw * BigInt.from((multiplier * 1000).round())) ~/ BigInt.from(1000);
    }
    if (minFee != null && fee < minFee) fee = minFee;
    if (maxFee != null && fee > maxFee) fee = maxFee;
    if (fee <= BigInt.zero) fee = BigInt.one;
    return fee;
  }

  // ── Signature / gas usage from body ─────────────────────────────────────

  // static int estimateSignatureCount({
  //   required int requiredSigners,
  //   required int requiredKeySignatureSlots,
  //   int? overrideCount,
  // }) {
  //   if (overrideCount != null) return overrideCount;
  //   final total = requiredSigners + requiredKeySignatureSlots;
  //   return total < 1 ? 1 : total;
  // }

  static BigInt? resolveGasUsed(HederaTransactionBody body, BigInt? explicit) {
    if (explicit != null) return explicit;
    return body.contractCall?.gas ??
        body.contractCreateInstance?.gas ??
        body.ethereumTransaction?.maxGasAllowance;
  }

  // ── Contract gas (mirror) ────────────────────────────────────────────────

  Future<HederaContractCallResult> estimateContractCallGas({
    required HederaContractID contractID,
    List<int>? functionParameters,
    HederaAddress? from,
    BigInt? value,
    BigInt? gas,
  }) async {
    final to = HederaAddress.fromContractId(contractID);
    final data =
        functionParameters == null || functionParameters.isEmpty
            ? null
            : BytesUtils.toHexString(functionParameters, prefix: "0x");
    return client.estimateGas(
      to: to,
      data: data,
      from: from,
      value: value,
      gas: gas,
    );
  }

  Future<HederaContractCallResult> estimateEthereumTransaction({
    required HederaAddress from,
    required HederaAddress to,
    BigInt? value,
    BigInt? gas,
    List<int>? data,
  }) async {
    return client.estimateGas(
      to: to,
      data:
          (data?.isEmpty ?? true)
              ? null
              : BytesUtils.toHexString(data ?? [], prefix: "0x"),
      from: from,
      value: value,

      gas: gas ?? BigInt.from(15000000),
    );
  }

  Future<HederaContractCallResult> estimateContractCallGasWithAbi({
    required HederaContractID contractID,
    required ContractABI abi,
    required String functionName,
    required List<dynamic> params,
    HederaAddress? from,
    BigInt? value,
  }) async {
    final encoded = encodeFunctionCall(
      abi: abi,
      functionName: functionName,
      params: params,
    );
    return estimateContractCallGas(
      contractID: contractID,
      functionParameters: encoded,
      from: from,
      value: value,
    );
  }

  /// Estimate create gas: `data` = full initcode, `to` = 0.0.0.
  Future<HederaContractCallResult> estimateContractCreateGas({
    required List<int> initcode,
    HederaAddress? from,
    BigInt? value,
    BigInt? estimateGas,
  }) async {
    if (initcode.isEmpty) {
      throw OnChainErrors.hederaTx(
        'estimateContractCreateGas',
        reason: 'Initcode is required to estimate create gas.',
      );
    }
    final data = BytesUtils.toHexString(initcode, prefix: "0x");
    final to = HederaAddress.fromNum(num: BigInt.zero);
    final BigInt maxGas = BigInt.from(15000000);
    return client.estimateGas(
      to: to,
      data: data,
      from: from,
      value: value,
      gas: estimateGas ?? maxGas,
    );
  }

  /// Resolve gas for a contract call (estimate if null).
  Future<HederaContractCallResult> resolveContractCallGas({
    required HederaContractID contractID,
    BigInt? gas,
    List<int>? functionParameters,
    HederaAddress? gasEstimateFrom,
    BigInt? amount,
    double gasSafetyMultiplier = 1.2,
    BigInt? estimateGas,
  }) async {
    if (gas != null) {
      if (gas <= BigInt.zero) {
        throw OnChainErrors.hederaTx(
          'resolveContractGas',
          reason: 'Gas must be > 0.',
        );
      }
      return HederaContractCallResult(gasEstimate: gas);
    }
    final BigInt maxGas = BigInt.from(15000000);
    final estimated = await estimateContractCallGas(
      contractID: contractID,
      functionParameters: functionParameters,
      from: gasEstimateFrom,
      value: amount,
      gas: estimateGas ?? maxGas,
    );
    final HederaContractCallResult resolved = estimated.copyWith(
      gasEstimate: applyGasSafety(estimated.gasEstimate, gasSafetyMultiplier),
    );
    if (resolved.gasEstimate <= BigInt.zero) {
      throw OnChainErrors.hederaTx(
        'resolveContractCallGas',
        reason: 'Resolved gas must be > 0.',
      );
    }
    return resolved;
  }

  /// Resolve gas for contract create (estimate if null and initcode present).
  /// Resolve gas for contract create.
  ///
  /// Prefer explicit [gas]. Otherwise estimate via mirror using [initcode]
  /// (creation bytecode ‖ constructor args). Does **not** silently fall back
  /// to a hardcoded value — pass [gas] or provide [initcode] for estimation.
  Future<HederaContractCallResult> resolveContractCreateGas({
    BigInt? gas,
    List<int>? initcode,
    HederaAddress? gasEstimateFrom,
    BigInt? initialBalance,
    double gasSafetyMultiplier = 1.2,
    BigInt? estimateGas,
  }) async {
    if (gas != null) {
      if (gas <= BigInt.zero) {
        throw OnChainErrors.hederaTx(
          'resolveContractCreateGas',
          reason: 'gas must be > 0',
        );
      }
      return HederaContractCallResult(gasEstimate: gas);
    }
    if (initcode == null || initcode.isEmpty) {
      throw OnChainErrors.hederaTx(
        'resolveContractCreateGas',
        reason:
            'Cannot estimate create gas without initcode. '
            'Pass gas explicitly, or provide initcode / local bytecode '
            'for mirror estimation (fileID-only creates need bytecode for estimate).',
      );
    }
    final estimated = await estimateContractCreateGas(
      initcode: initcode,
      from: gasEstimateFrom,
      value: initialBalance,
      estimateGas: estimateGas,
    );
    final resolved = estimated.copyWith(
      gasEstimate: applyGasSafety(estimated.gasEstimate, gasSafetyMultiplier),
    );
    if (resolved.gasEstimate <= BigInt.zero) {
      throw OnChainErrors.hederaTx(
        'resolveContractCreateGas',
        reason: 'Mirror estimated gas was <= 0.',
      );
    }
    return resolved;
  }
  // ── HBAR fee estimation ──────────────────────────────────────────────────

  Future<HederaFeeEstimate> estimateFeeSchedule({
    required HederaTransactionBody body,
    required HederaFeeEstimateOptions options,
  }) async {
    final gas = resolveGasUsed(body, options.gasUsed);

    Future<HederaFeeEstimate> hip() => feeCalculator.calculateHIP1261Fee(
      body: body,
      totalSignature: options.signatureCount,
      gasUsed: gas,
      existingKeyCount: options.existingKeyCount,
      existingAccountCount: options.existingAccountCount,
      transferIncludesTokenWithCustomFees:
          options.transferIncludesTokenWithCustomFees,
      submitToTopicWithCustomFee: options.submitToTopicWithCustomFee,
      stateBytesWritten: 0,
      recordsProduced: 0,
    );

    Future<HederaFeeEstimate> legacy() => feeCalculator.calculateFee(
      body: body,
      totalSignature: options.signatureCount,
      gasUsed: gas,
      transferIncludesTokenWithCustomFees:
          options.transferIncludesTokenWithCustomFees,
    );

    late HederaFeeEstimate raw;
    switch (options.mode) {
      case HederaFeeScheduleMode.scheduleLegacy:
        raw = await legacy();
      case HederaFeeScheduleMode.scheduleHip1261:
        raw = await hip();
      default:
        throw OnChainErrors.hederaTx(
          "estimateFeeSchedule",
          reason: "Invalid fee mode.",
        );
    }

    final fee = applyFeeSafety(
      raw.maxFee,
      multiplier: options.safetyMultiplier,
      minFee: options.minFeeTinybars,
      maxFee: options.maxFeeTinybars,
    );
    BigInt? gasFee = raw.gasFee;
    if (gasFee != null) {
      gasFee = applyFeeSafety(
        gasFee,
        multiplier: options.safetyMultiplier,
        minFee: options.minFeeTinybars,
        maxFee: options.maxFeeTinybars,
      );
    }

    return HederaFeeEstimate(
      maxFee: fee,
      gasFee: gasFee,
      total: fee + (gasFee ?? BigInt.zero),
      mode: options.mode,
      signatureCount: options.signatureCount,
    );
  }

  Future<BigInt> tinycentsToTinybars(BigInt tinycents) async {
    HederaExchangeRateSet? exChangeRate = feeCalculator.exchangeRate;
    if (exChangeRate == null && client.strategy.allowMirror) {
      exChangeRate ??= await client.getMirrorExchangeRateSet();
    }
    if (exChangeRate != null) {
      final rate = exChangeRate.currentRate ?? exChangeRate.nextRate;
      if (rate != null) {
        final hbarEquiv = rate.hbarEquiv ?? 1;
        final centEquiv = rate.centEquiv ?? 1;
        if (centEquiv != 0) {
          return (tinycents * BigInt.from(hbarEquiv)) ~/ BigInt.from(centEquiv);
        }
      }
    }
    return tinycents;
  }

  /// Mirror POST `/api/v1/network/fees`.
  ///
  /// Fee depends on **serialized size including signatures**. We inject
  /// [signatureCount] placeholder sig pairs so the estimate matches a fully
  /// signed tx (empty sigMap → INSUFFICIENT_TX_FEE at submit).
  ///
  /// - [mode]: `INTRINSIC` (fast) or `STATE` (closer to consensus).
  /// - [highVolumeThrottle]: `0` disables surge pricing input.
  /// - [neutralizeHighVolumeMultiplier]: default **false** — keep mirror total
  ///   as max-fee ceiling (safer against INSUFFICIENT_TX_FEE).
  Future<HederaFeeEstimate> estimateFeeViaMirror({
    required HederaTransactionBody body,
    required int signatureCount,
    HederaMirrorTypesFeeEstimateMode mode =
        HederaMirrorTypesFeeEstimateMode.iNTRINSIC,
    int highVolumeThrottle = 0,
    double safetyMultiplier = 1.25,
    BigInt? minFeeTinybars,
    BigInt? maxFeeTinybars,
    bool neutralizeHighVolumeMultiplier = false,
    BigInt? gasUsed,
  }) async {
    final n = signatureCount < 1 ? 1 : signatureCount;
    // ~64-byte ed25519 sig + 32-byte prefix — size drives signature fee component.
    final placeholderPairs = List<HederaSignaturePair>.generate(
      n,
      (i) => HederaSignaturePair(
        pubKeyPrefix: List<int>.filled(32, i + 1),
        ed25519: List<int>.filled(64, i + 2),
      ),
    );

    final txBytes =
        HederaTransaction(
          signedTransactionBytes:
              HederaSignedTransaction(
                bodyBytes: body.toBuffer(),
                sigMap: HederaSignatureMap(sigPair: placeholderPairs),
              ).toBuffer(),
        ).toBuffer();

    final response = await client.mirrorRequest(
      HederaMirrorRequestEstimateFees(
        mode: mode,
        highVolumeThrottle: highVolumeThrottle,
        txBody: txBytes,
      ),
    );

    var totalTinycents = response.total;

    final hvm = response.highVolumeMultiplier;
    if (neutralizeHighVolumeMultiplier && hvm > BigInt.one) {
      totalTinycents = totalTinycents ~/ hvm;
    }
    BigInt? gasPrice;
    if (gasUsed != null) {
      final fees = await client.mirrorGetFees();
      if (body.contractCall != null) {
        gasPrice =
            fees.fees
                ?.firstWhereNullable(
                  (e) =>
                      e.transactionType ==
                      HederaHederaFunctionality.contractCall.protoName,
                )
                ?.gas;
      } else if (body.contractCreateInstance != null) {
        gasPrice =
            fees.fees
                ?.firstWhereNullable(
                  (e) =>
                      e.transactionType ==
                      HederaHederaFunctionality.contractCreate.protoName,
                )
                ?.gas;
      } else if (body.ethereumTransaction != null) {
        gasPrice =
            fees.fees
                ?.firstWhereNullable(
                  (e) =>
                      e.transactionType ==
                      HederaHederaFunctionality.ethereumTransaction.protoName,
                )
                ?.gas;
      }
    }

    final rawTinybars = await tinycentsToTinybars(totalTinycents);
    final fee = applyFeeSafety(
      rawTinybars,
      multiplier: safetyMultiplier,
      minFee: minFeeTinybars,
      maxFee: maxFeeTinybars,
    );
    BigInt? gasFee;
    if (gasPrice != null && gasUsed != null) {
      gasFee = applyFeeSafety(
        gasPrice * gasUsed,
        multiplier: safetyMultiplier,
        minFee: minFeeTinybars,
        maxFee: maxFeeTinybars,
      );
    }
    return HederaFeeEstimate(
      maxFee: fee,
      mode: HederaFeeScheduleMode.mirror,
      signatureCount: n,
      total: fee + (gasFee ?? BigInt.zero),
      gasFee: gasFee,
    );
  }

  Future<HederaFeeEstimate> estimateFeeUnified({
    required HederaTransactionBody body,
    required int requiredSigners,
    required int requiredKeySignatureSlots,
    required int signatureCount,
    HederaFeeScheduleMode mode = HederaFeeScheduleMode.mirror,

    BigInt? gasUsed,
    double safetyMultiplier = 1.25,
    bool transferIncludesTokenWithCustomFees = false,
    bool submitToTopicWithCustomFee = false,
  }) async {
    Future<HederaFeeEstimate> viaSchedule() => estimateFeeSchedule(
      body: body,
      options: HederaFeeEstimateOptions(
        mode: mode,
        signatureCount: signatureCount,
        gasUsed: gasUsed,
        safetyMultiplier: safetyMultiplier,
        existingAccountCount: requiredSigners,
        existingKeyCount: requiredKeySignatureSlots,
        transferIncludesTokenWithCustomFees:
            transferIncludesTokenWithCustomFees,
        submitToTopicWithCustomFee: submitToTopicWithCustomFee,
      ),
    );

    Future<HederaFeeEstimate> viaMirror() => estimateFeeViaMirror(
      body: body,
      signatureCount: signatureCount,
      safetyMultiplier: safetyMultiplier,

      highVolumeThrottle: 0,
      neutralizeHighVolumeMultiplier: true,
      gasUsed: gasUsed,
    );

    switch (mode) {
      case HederaFeeScheduleMode.scheduleHip1261:
      case HederaFeeScheduleMode.scheduleLegacy:
        return viaSchedule();
      case HederaFeeScheduleMode.mirror:
        return viaMirror();
    }
  }

  /// Encode a function call: selector + ABI-encoded arguments.
  static List<int> encodeFunctionCall({
    required ContractABI abi,
    required String functionName,
    required List<dynamic> params,
  }) {
    final fragment = abi.findFunctionFromName(functionName);
    if (fragment == null) {
      throw OnChainErrors.hederaPlugin(
        'encodeFunctionCall',
        reason: 'Function "$functionName" not found in ABI.',
      );
    }
    _validateParamCount(fragment, params);
    return fragment.encode(params, true);
  }

  /// Decode a function call: selector + ABI-encoded arguments.
  static List<dynamic>? decodeFunctionCall({
    required ContractABI abi,
    required String functionName,
    required String? result,
    // required List<dynamic> params,
  }) {
    // if(result=)
    final fragment = abi.findFunctionFromName(functionName);
    if (fragment == null) {
      throw OnChainErrors.hederaPlugin(
        'decodeFunctionCall',
        reason: 'Function "$functionName" not found in ABI.',
      );
    }
    if (fragment.outputs.isEmpty || result == null) {
      return null;
    }

    return fragment.decodeOutput(BytesUtils.fromHexString(result));
  }

  /// Encode constructor arguments only (no selector).
  static List<int> encodeConstructor({
    required ContractABI abi,
    required List<dynamic> params,
  }) {
    if (abi.constractors.isEmpty) {
      if (params.isEmpty) return const [];
      throw OnChainErrors.hederaPlugin(
        'encodeConstructor',
        reason: 'ABI has no constructor but params were provided.',
      );
    }
    final ctor = abi.constractors.first;
    if (ctor.inputs.length != params.length) {
      throw OnChainErrors.hederaPlugin(
        'encodeConstructor',
        reason:
            'Constructor expects ${ctor.inputs.length} args, got ${params.length}.',
      );
    }
    // Constructor has no selector – encode params only.
    return ctor.encode(params);
  }

  /// Decode function return data.
  static List<dynamic> decodeOutput({
    required ContractABI abi,
    required String functionName,
    required List<int> encodedOutput,
  }) {
    final fragment = abi.functionFromName(functionName);
    return fragment.decodeOutput(encodedOutput);
  }

  /// Decode function return data from hex.
  static List<dynamic> decodeOutputHex({
    required ContractABI abi,
    required String functionName,
    required String encodedOutputHex,
  }) {
    return decodeOutput(
      abi: abi,
      functionName: functionName,
      encodedOutput: BytesUtils.fromHexString(encodedOutputHex),
    );
  }

  static void _validateParamCount(
    AbiFunctionFragment fragment,
    List<dynamic> params,
  ) {
    if (fragment.inputs.length != params.length) {
      throw OnChainErrors.hederaPlugin(
        'encodeFunctionCall',
        reason:
            '${fragment.name} expects ${fragment.inputs.length} args, '
            'got ${params.length}.',
      );
    }
  }

  static const Duration maxTransactionValidDuration = Duration(seconds: 120);
  static ({HederaTransactionID id, DateTime transactionValidStart}) buildTxId({
    HederaAddress? address,
  }) {
    final now = DateTime.now();
    final id = HederaTransactionID(
      accountID: address?.toAccoutId() ?? HederaAccountID(),
      transactionValidStart: HederaTimestamp(
        seconds: BigInt.from(now.millisecondsSinceEpoch ~/ 1000),
        nanos: now.microsecond * 1000,
      ),
    );
    return (id: id, transactionValidStart: now);
  }

  static String toMirrorTxId(HederaTransactionID id) {
    final payer = id.accountID;
    final payerStr =
        payer == null
            ? "0.0.0"
            : "${payer.shardNum ?? BigInt.zero}.${payer.realmNum ?? BigInt.zero}.${payer.accountNum ?? BigInt.zero}";
    final start = id.transactionValidStart;
    return "$payerStr-${start?.seconds ?? BigInt.zero}-${start?.nanos ?? 0}";
  }

  static String toExplorerTxId(HederaTransactionID id) {
    final payer = id.accountID;
    final payerStr =
        payer == null
            ? "0.0.0"
            : "${payer.shardNum ?? BigInt.zero}.${payer.realmNum ?? BigInt.zero}.${payer.accountNum ?? BigInt.zero}";
    final start = id.transactionValidStart;
    return "$payerStr@${start?.seconds ?? BigInt.zero}.${start?.nanos ?? 0}";
  }

  /// Parse a mirror REST transaction id into a [HederaTransactionID].
  ///
  /// Strict form: `shard.realm.num-seconds-nanos`
  /// (e.g. `0.0.9959237-1793290875-763000`).
  static HederaTransactionID fromMirrorTxId(String txId) {
    return _parseTxId(
      txId: txId,
      pattern: RegExp(r'^(\d+)\.(\d+)\.(\d+)-(\d+)-(\d+)$'),
      method: 'fromMirrorTxId',
      hint:
          '"shard.realm.num-seconds-nanos" (e.g. "0.0.9959237-1793290875-763000")',
    );
  }

  /// Parse an explorer (HashScan) transaction id into a
  /// [HederaTransactionID].
  ///
  /// Strict form: `shard.realm.num@seconds.nanos`
  /// (e.g. `0.0.9959237@1793290875.763000`).
  static HederaTransactionID fromExplorerTxId(String txId) {
    return _parseTxId(
      txId: txId,
      pattern: RegExp(r'^(\d+)\.(\d+)\.(\d+)@(\d+)\.(\d+)$'),
      method: 'fromExplorerTxId',
      hint:
          '"shard.realm.num@seconds.nanos" (e.g. "0.0.9959237@1793290875.763000")',
    );
  }

  /// Parse an explorer (HashScan) or mirror REST transaction id into a
  /// [HederaTransactionID].
  ///
  /// Accepted forms:
  /// - mirror: `0.0.9959237-1793290875-763000`
  /// - explorer: `0.0.9959237@1793290875.763000`
  static HederaTransactionID fromExplorerOrMirrorTxId(String txId) {
    for (final parse in [fromMirrorTxId, fromExplorerTxId]) {
      try {
        return parse(txId);
      } catch (_) {}
    }
    throw OnChainErrors.hederaTx(
      'fromExplorerOrMirrorTxId',
      reason:
          'Invalid transaction id "$txId". Expected '
          '"shard.realm.num-seconds-nanos" (mirror) or '
          '"shard.realm.num@seconds.nanos" (explorer).',
    );
  }

  static HederaTransactionID _parseTxId({
    required String txId,
    required RegExp pattern,
    required String method,
    required String hint,
  }) {
    try {
      final match = pattern.firstMatch(txId.trim());
      if (match == null) {
        throw OnChainErrors.hederaTx(
          method,
          reason: 'Unknown transaction ID format.',
          details: {'txId': txId},
        );
      }
      final nanos = IntUtils.parse(match.group(5)!);
      if (nanos < 0 || nanos >= 1000000000) {
        throw OnChainErrors.hederaTx(
          method,
          reason: 'Transaction ID nanos out of range.',
          details: {'nanos': '$nanos', 'txId': txId},
        );
      }
      return HederaTransactionID(
        accountID: HederaAccountID(
          shardNum: BigintUtils.parse(match.group(1)!),
          realmNum: BigintUtils.parse(match.group(2)!),
          accountNum: BigintUtils.parse(match.group(3)!),
        ),
        transactionValidStart: HederaTimestamp(
          seconds: BigintUtils.parse(match.group(4)!),
          nanos: nanos,
        ),
      );
    } catch (_) {
      throw OnChainErrors.hederaTx(
        method,
        reason: 'Invalid transaction id "$txId". Expected $hint.',
      );
    }
  }
}
