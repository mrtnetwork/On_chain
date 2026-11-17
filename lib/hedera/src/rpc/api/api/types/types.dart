import 'package:on_chain/exception/onchain_error.dart';
import 'package:on_chain/hedera/src/address/src/address.dart';

import 'package:on_chain/hedera/src/crypto/types/types.dart';
import 'package:on_chain/hedera/src/proto_messages/proto/models.dart';
import 'package:on_chain/hedera/src/rpc/api/api.dart';
import 'package:on_chain/hedera/src/rpc/models/types.dart';
import 'package:on_chain/hedera/src/serialization/serialization.dart';

typedef CbBuildQueryTxPayment = Future<HederaTransaction> Function();
typedef CbQueryPaymnetSource =
    Future<HederaPaidQuerySource> Function(IHederaQuery query);

sealed class HederaApiNodeStrategy {
  const HederaApiNodeStrategy();
}

class HederaPaidQuerySource {
  final HederaSigner signer;
  final HederaAddress payer;
  final BigInt? maxQueryCost;
  const HederaPaidQuerySource({
    required this.signer,
    required this.payer,
    this.maxQueryCost,
  });
}

class HederaApiNodeStrategyFreeQuery implements HederaApiNodeStrategy {
  const HederaApiNodeStrategyFreeQuery();
}

class HederaApiNodeStrategyPaidQuery implements HederaApiNodeStrategy {
  final CbQueryPaymnetSource source;
  final BigInt? defaultMaxQueryCost;

  const HederaApiNodeStrategyPaidQuery({
    required this.source,
    this.defaultMaxQueryCost,
  });
}

sealed class HederaApiMirrorStrategy {
  const HederaApiMirrorStrategy();
}

class HederaApiMirrorStrategyAllow implements HederaApiMirrorStrategy {
  const HederaApiMirrorStrategyAllow();
}

class HederaClientSterategy {
  final HederaApiNodeStrategy? node;
  final HederaApiMirrorStrategy? mirror;
  const HederaClientSterategy({
    this.node = const HederaApiNodeStrategyFreeQuery(),
    this.mirror = const HederaApiMirrorStrategyAllow(),
  });
  bool get allowMirror => mirror != null;
  bool get allowNode => node != null;
  bool get allowPaidQuery =>
      allowNode && node is HederaApiNodeStrategyPaidQuery;
}

/// Result of [HederaQuickNodeApi.submitTransactionAndWait].
class HederaSubmitResult {
  final HederaTransactionResponse submitResponse;
  final HederaTransactionReceipt? receipt;
  final HederaTransactionID? transactionId;
  final String? mirrorResult;
  final bool success;

  const HederaSubmitResult({
    required this.submitResponse,
    this.receipt,
    this.transactionId,
    this.mirrorResult,
    required this.success,
  });
}

/// Contract call / estimate result (mirror or node local call).
class HederaContractCallResult {
  /// Hex-encoded return data (may be null for estimate-only).
  final String? resultHex;

  /// Estimated gas when [estimate] was requested.
  final BigInt gasEstimate;

  /// Raw mirror response if from mirror.
  final HederaMirrorTypesContractCallResponse? mirrorResponse;

  final Object? result;

  const HederaContractCallResult({
    this.resultHex,
    required this.gasEstimate,
    this.mirrorResponse,
    this.result,
  });

  HederaContractCallResult copyWith({
    String? resultHex,
    BigInt? gasEstimate,
    HederaMirrorTypesContractCallResponse? mirrorResponse,
    Object? result,
  }) {
    return HederaContractCallResult(
      gasEstimate: gasEstimate ?? this.gasEstimate,
      mirrorResponse: mirrorResponse ?? this.mirrorResponse,
      result: result ?? this.result,
      resultHex: resultHex ?? this.resultHex,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "resultHex": resultHex,
      "gasEstimate": gasEstimate,
      "mirrorResponse": mirrorResponse?.toJson(),
      "result": result,
    };
  }

  @override
  String toString() {
    return "HederaContractCallResult(${toJson()})";
  }
}

/// Backend that produced this account view.
enum HederaAccountDataSource { node, mirror }

/// Unified account view shared by node [CryptoGetInfo] and mirror account APIs.
///
/// Use this as the return type of [DefaultHederaClient.getAccount] so callers
class HederaAccountSnapshot {
  /// Account entity (0.0.x / alias / EVM form as [HederaAddress]).
  final HederaAddress account;

  /// HBAR balance in tinybars.
  final BigInt balance;

  final bool? deleted;
  final bool? receiverSigRequired;
  final String? memo;
  final int? maxAutomaticTokenAssociations;
  final BigInt? ethereumNonce;
  final BigInt? pendingReward;
  final bool? declineReward;

  /// Staked account id string (e.g. `0.0.1001`), if any.
  final HederaAddress? stakedAccountId;

  /// Staked node id, if any.
  final BigInt? stakedNodeId;

  /// EVM address hex (with or without `0x`), if known.
  final String? evmAddress;

  /// Key alias / account alias string, if known.
  final String? alias;

  /// Auto-renew period in seconds, if known.
  final BigInt? autoRenewPeriodSeconds;

  /// Expiry as consensus timestamp string (mirror) or seconds (node).
  final String? expiryTimestamp;

  /// Created timestamp (mirror), if known.
  final String? createdTimestamp;

  /// Mirror key payload (`_type` + hex), when from mirror.
  final HederaMirrorTypesKey? mirrorKey;

  /// Node account key, when from node CryptoGetInfo.
  final HederaKey? nodeKey;

  /// Where this snapshot was loaded from.
  final HederaAccountDataSource source;

  /// Original response object (mirror entity or [HederaCryptoGetInfoResponse]).
  final Object? raw;

  const HederaAccountSnapshot({
    required this.account,
    required this.balance,
    required this.source,
    this.deleted,
    this.receiverSigRequired,
    this.memo,
    this.maxAutomaticTokenAssociations,
    this.ethereumNonce,
    this.pendingReward,
    this.declineReward,
    this.stakedAccountId,
    this.stakedNodeId,
    this.evmAddress,
    this.alias,
    this.autoRenewPeriodSeconds,
    this.expiryTimestamp,
    this.createdTimestamp,
    this.mirrorKey,
    this.nodeKey,
    this.raw,
  });

  // ── Factories ────────────────────────────────────────────────────────────

  /// From mirror `GET /api/v1/accounts/{id}` ([HederaMirrorTypesAccountBalanceTransactions]).
  factory HederaAccountSnapshot.fromMirror({
    required HederaMirrorTypesAccountBalanceTransactions response,
    required HederaAddress fallbackAccount,
  }) {
    final idStr = response.account;
    if (idStr != null) {
      fallbackAccount = HederaAddress(idStr);
    }
    final bal = response.balance?.balance;
    return HederaAccountSnapshot(
      account: fallbackAccount,
      balance: bal ?? BigInt.zero,
      source: HederaAccountDataSource.mirror,
      deleted: response.deleted,
      receiverSigRequired: response.receiverSigRequired,
      memo: response.memo,
      maxAutomaticTokenAssociations: response.maxAutomaticTokenAssociations,
      ethereumNonce: response.ethereumNonce,
      pendingReward: response.pendingReward,
      declineReward: response.declineReward,
      stakedAccountId:
          response.stakedAccountId == null
              ? null
              : HederaAddress(response.stakedAccountId!),
      stakedNodeId: response.stakedNodeId,
      evmAddress: response.evmAddress,
      alias: response.alias,
      autoRenewPeriodSeconds: response.autoRenewPeriod,
      expiryTimestamp: response.expiryTimestamp,
      createdTimestamp: response.createdTimestamp,
      mirrorKey: response.key,
      raw: response,
    );
  }

  /// From mirror account info entity (list accounts / embedded info).
  factory HederaAccountSnapshot.fromMirrorAccountInfo({
    required HederaMirrorTypesAccountInfo response,
    required HederaAddress fallbackAccount,
  }) {
    final idStr = response.account;
    if (idStr != null) {
      fallbackAccount = HederaAddress(idStr);
    }

    final bal = response.balance?.balance;
    return HederaAccountSnapshot(
      account: fallbackAccount,
      balance: bal ?? BigInt.zero,
      source: HederaAccountDataSource.mirror,
      deleted: response.deleted,
      receiverSigRequired: response.receiverSigRequired,
      memo: response.memo,
      maxAutomaticTokenAssociations: response.maxAutomaticTokenAssociations,
      ethereumNonce: response.ethereumNonce,
      pendingReward: response.pendingReward,
      declineReward: response.declineReward,
      stakedAccountId:
          response.stakedAccountId == null
              ? null
              : HederaAddress(response.stakedAccountId!),
      stakedNodeId: response.stakedNodeId,
      evmAddress: response.evmAddress,
      alias: response.alias,
      autoRenewPeriodSeconds: response.autoRenewPeriod,
      expiryTimestamp: response.expiryTimestamp,
      createdTimestamp: response.createdTimestamp,
      mirrorKey: response.key,
      raw: response,
    );
  }

  /// From node gRPC [HederaCryptoGetInfoResponse].
  ///
  /// Field names follow standard Hedera `CryptoGetInfoResponse.AccountInfo`.
  factory HederaAccountSnapshot.fromNode({
    required HederaCryptoGetInfoResponse response,
    required HederaAddress fallbackAccount,
  }) {
    final info = response.accountInfo;
    if (info == null) {
      throw OnChainErrors.hederaPlugin(
        "HederaAccountSnapshot.fromNode",
        reason: 'CryptoGetInfoResponse.accountInfo is null.',
        details: {'account': fallbackAccount.address},
      );
    }

    HederaAddress account = fallbackAccount;
    final accountId = info.accountID;
    if (accountId != null) {
      account = HederaAddress.fromAccountId(accountId);
    }

    final balance = info.balance ?? BigInt.zero;
    final autoRenew = info.autoRenewPeriod?.seconds;
    final expiry = info.expirationTime?.seconds;

    return HederaAccountSnapshot(
      account: account,
      balance: balance,
      source: HederaAccountDataSource.node,
      deleted: info.deleted,
      receiverSigRequired: info.receiverSigRequired,
      memo: info.memo,
      maxAutomaticTokenAssociations: info.maxAutomaticTokenAssociations,
      ethereumNonce: info.ethereumNonce,
      pendingReward: null,
      declineReward: info.stakingInfo?.declineReward,
      stakedAccountId:
          info.stakingInfo?.stakedAccountId == null
              ? null
              : HederaAddress.fromAccountId(info.stakingInfo!.stakedAccountId!),
      stakedNodeId: info.stakingInfo?.stakedNodeId,
      evmAddress: info.contractAccountID,
      alias: null,
      autoRenewPeriodSeconds: autoRenew,
      expiryTimestamp: expiry?.toString(),
      createdTimestamp: null,
      nodeKey: info.key,
      raw: response,
    );
  }

  @override
  String toString() =>
      'HederaAccountSnapshot($account, balance=$balance, source=$source)';
}

class HederaAccountTokenSnapshot {
  final HederaAddress tokenId;
  final BigInt balance;
  const HederaAccountTokenSnapshot({
    required this.tokenId,
    required this.balance,
  });
}

class HederaAccountBalanceSnapshot {
  final List<HederaAccountTokenSnapshot> tokens;
  final BigInt balance;
  const HederaAccountBalanceSnapshot({
    required this.tokens,
    required this.balance,
  });
}

/// Where entity keys were loaded from.
enum HederaKeyDataSource { node, mirror }

/// Normalized HAPI [HederaKey] plus optional mirror raw payload.
///
/// Mirror REST returns `{_type, key}` while node queries return [HederaKey].
/// This snapshot always exposes a best-effort [hederaKey] for signing.
class HederaKeySnapshot {
  /// Converted / native HAPI key (may be null if conversion failed).
  final HederaKey? hederaKey;

  /// Original mirror key object when source is mirror.
  final HederaMirrorTypesKey? mirrorKey;

  final HederaKeyDataSource source;

  const HederaKeySnapshot({
    this.hederaKey,
    this.mirrorKey,
    required this.source,
  });

  bool get hasKey => hederaKey != null;

  /// Build from node [HederaKey].
  factory HederaKeySnapshot.fromNode(HederaKey? key) {
    return HederaKeySnapshot(hederaKey: key, source: HederaKeyDataSource.node);
  }

  /// Build from mirror `{_type, key}` with conversion to [HederaKey].
  factory HederaKeySnapshot.fromMirror(HederaMirrorTypesKey? key) {
    if (key == null) {
      return const HederaKeySnapshot(source: HederaKeyDataSource.mirror);
    }
    final converted = HederaClientUtils.hederaMirrorTypesKeyToHederaKey(key);
    if (converted == null) {
      return const HederaKeySnapshot(source: HederaKeyDataSource.mirror);
    }
    // final converted = HederaMirrorKeyConverter.toHederaKey(key);
    return HederaKeySnapshot(
      hederaKey: converted,
      mirrorKey: key,
      source: HederaKeyDataSource.mirror,
    );
  }
  Map<String, dynamic> toJson() {
    return {
      "hederaKey": hederaKey?.toJson(),
      "mirrorKey": mirrorKey?.toJson(),
      "source": source.name,
    };
  }
}

/// Token authority keys (admin, supply, wipe, …) from node or mirror.
class HederaTokenKeysSnapshot {
  final HederaKeySnapshot? adminKey;
  final HederaKeySnapshot? kycKey;
  final HederaKeySnapshot? freezeKey;
  final HederaKeySnapshot? wipeKey;
  final HederaKeySnapshot? supplyKey;
  final HederaKeySnapshot? feeScheduleKey;
  final HederaKeySnapshot? pauseKey;
  final HederaKeySnapshot? metadataKey;
  final HederaKeyDataSource source;
  final Object? raw;

  const HederaTokenKeysSnapshot({
    this.adminKey,
    this.kycKey,
    this.freezeKey,
    this.wipeKey,
    this.supplyKey,
    this.feeScheduleKey,
    this.pauseKey,
    this.metadataKey,
    required this.source,
    this.raw,
  });

  factory HederaTokenKeysSnapshot.fromNode(
    HederaTokenGetInfoResponse response,
  ) {
    final info = response.tokenInfo;
    return HederaTokenKeysSnapshot(
      adminKey: HederaKeySnapshot.fromNode(info?.adminKey),
      kycKey: HederaKeySnapshot.fromNode(info?.kycKey),
      freezeKey: HederaKeySnapshot.fromNode(info?.freezeKey),
      wipeKey: HederaKeySnapshot.fromNode(info?.wipeKey),
      supplyKey: HederaKeySnapshot.fromNode(info?.supplyKey),
      feeScheduleKey: HederaKeySnapshot.fromNode(info?.feeScheduleKey),
      pauseKey: HederaKeySnapshot.fromNode(info?.pauseKey),
      metadataKey: HederaKeySnapshot.fromNode(info?.metadataKey),
      source: HederaKeyDataSource.node,
      raw: response,
    );
  }

  factory HederaTokenKeysSnapshot.fromMirror(HederaMirrorTypesTokenInfo info) {
    HederaKeySnapshot? meta;
    if (info.metadataKey != null) {
      // metadataKey is a sibling type with same shape
      meta = HederaKeySnapshot.fromMirror(
        HederaMirrorTypesKey(
          type: info.metadataKey!.type,
          key: info.metadataKey!.key,
        ),
      );
    }
    return HederaTokenKeysSnapshot(
      adminKey: HederaKeySnapshot.fromMirror(info.adminKey),
      kycKey: HederaKeySnapshot.fromMirror(info.kycKey),
      freezeKey: HederaKeySnapshot.fromMirror(info.freezeKey),
      wipeKey: HederaKeySnapshot.fromMirror(info.wipeKey),
      supplyKey: HederaKeySnapshot.fromMirror(info.supplyKey),
      feeScheduleKey: HederaKeySnapshot.fromMirror(info.feeScheduleKey),
      pauseKey: HederaKeySnapshot.fromMirror(info.pauseKey),
      metadataKey: meta,
      source: HederaKeyDataSource.mirror,
      raw: info,
    );
  }

  HederaKey? get admin => adminKey?.hederaKey;
  HederaKey? get kyc => kycKey?.hederaKey;
  HederaKey? get freeze => freezeKey?.hederaKey;
  HederaKey? get wipe => wipeKey?.hederaKey;
  HederaKey? get supply => supplyKey?.hederaKey;
  HederaKey? get feeSchedule => feeScheduleKey?.hederaKey;
  HederaKey? get pause => pauseKey?.hederaKey;
  HederaKey? get metadata => metadataKey?.hederaKey;
  Map<String, dynamic> toJson() {
    return {
      "adminKey": adminKey?.toJson(),
      "kycKey": kycKey?.toJson(),
      "freezeKey": freezeKey?.toJson(),
      "wipeKey": wipeKey?.toJson(),
      "supplyKey": supplyKey?.toJson(),
      "feeScheduleKey": feeScheduleKey?.toJson(),
      "pauseKey": pauseKey?.toJson(),
      "metadataKey": metadataKey?.toJson(),
      "source": source.name,
    };
  }
}

/// Contract admin key from node or mirror.
class HederaContractKeysSnapshot {
  final HederaKeySnapshot? adminKey;
  final HederaKeyDataSource source;
  final Object? raw;

  const HederaContractKeysSnapshot({
    this.adminKey,
    required this.source,
    this.raw,
  });

  factory HederaContractKeysSnapshot.fromNode(
    HederaContractGetInfoResponse response,
  ) {
    return HederaContractKeysSnapshot(
      adminKey: HederaKeySnapshot.fromNode(response.contractInfo?.adminKey),
      source: HederaKeyDataSource.node,
      raw: response,
    );
  }

  factory HederaContractKeysSnapshot.fromMirror(
    HederaMirrorTypesContractResponse response,
  ) {
    return HederaContractKeysSnapshot(
      adminKey: HederaKeySnapshot.fromMirror(response.adminKey),
      source: HederaKeyDataSource.mirror,
      raw: response,
    );
  }

  HederaKey? get admin => adminKey?.hederaKey;
}

/// Topic admin / submit keys from node or mirror.
class HederaTopicKeysSnapshot {
  final HederaKeySnapshot? adminKey;
  final HederaKeySnapshot? submitKey;
  final HederaKeyDataSource source;
  final Object? raw;

  const HederaTopicKeysSnapshot({
    this.adminKey,
    this.submitKey,
    required this.source,
    this.raw,
  });

  factory HederaTopicKeysSnapshot.fromNode(
    HederaConsensusGetTopicInfoResponse response,
  ) {
    final info = response.topicInfo;
    return HederaTopicKeysSnapshot(
      adminKey: HederaKeySnapshot.fromNode(info?.adminKey),
      submitKey: HederaKeySnapshot.fromNode(info?.submitKey),
      source: HederaKeyDataSource.node,
      raw: response,
    );
  }

  factory HederaTopicKeysSnapshot.fromMirror(HederaMirrorTypesTopic topic) {
    return HederaTopicKeysSnapshot(
      adminKey: HederaKeySnapshot.fromMirror(topic.adminKey),
      submitKey: HederaKeySnapshot.fromMirror(topic.submitKey),
      source: HederaKeyDataSource.mirror,
      raw: topic,
    );
  }

  HederaKey? get admin => adminKey?.hederaKey;
  HederaKey? get submit => submitKey?.hederaKey;

  Map<String, dynamic> toJson() {
    return {
      "adminKey": adminKey?.toJson(),
      "submitKey": submitKey?.toJson(),
      "source": source.name,
    };
  }
}
