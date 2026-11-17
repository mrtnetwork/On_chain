// Auto-generated from Go struct definitions.

import 'package:blockchain_utils/blockchain_utils.dart';
import 'package:on_chain/algorand/src/transaction/src/signatures.dart';

/// This file uses Algorand types only. toJson()/toMsgPack returns a raw object.
/// To serialize it into a JSON string, use a JSON encoder with support for custom encodable
/// objects and ensure all BigInt values are encoded as strings.

/// Account account information at a given round. Definition: data/basics/userBalance.go : AccountData
class AlgoRestTypesAccount {
  /// Address the account public key
  final String address;

  /// Amount total number of MicroAlgos in the account
  final BigInt amount;

  /// AmountWithoutPendingRewards specifies the amount of MicroAlgos in the account, without the pending rewards.
  final BigInt amountWithoutPendingRewards;

  /// AppsLocalState application local data stored in this account. Note the raw object uses `map[int] -> AppLocalState` for this type.
  final List<AlgoRestTypesApplicationLocalState>? appsLocalState;

  /// AppsTotalExtraPages the sum of all extra application program pages for this account.
  final BigInt? appsTotalExtraPages;

  /// AppsTotalSchema the sum of all of the local schemas and global schemas in this account. Note: the raw account uses `StateSchema` for this type.
  final AlgoRestTypesApplicationStateSchema? appsTotalSchema;

  /// Assets assets held by this account. Note the raw object uses `map[int] -> AssetHolding` for this type.
  final List<AlgoRestTypesAssetHolding>? assets;

  /// AuthAddr the address against which signing should be checked. If empty, the address of the current account is used. This field can be updated in any transaction by setting the RekeyTo field.
  final String? authAddr;

  /// ClosedAtRound round during which this account was most recently closed.
  final BigInt? closedAtRound;

  /// CreatedApps parameters of applications created by this account including app global data. Note: the raw account uses `map[int] -> AppParams` for this type.
  final List<AlgoRestTypesApplication>? createdApps;

  /// CreatedAssets parameters of assets created by this account. Note: the raw account uses `map[int] -> Asset` for this type.
  final List<AlgoRestTypesAsset>? createdAssets;

  /// CreatedAtRound round during which this account first appeared in a transaction.
  final BigInt? createdAtRound;

  /// Deleted whether or not this account is currently closed.
  final bool? deleted;

  /// IncentiveEligible can the account receive block incentives if its balance is in range at proposal time.
  final bool? incentiveEligible;

  /// LastHeartbeat the round in which this account last went online, or explicitly renewed their online status.
  final BigInt? lastHeartbeat;

  /// LastProposed the round in which this account last proposed the block.
  final BigInt? lastProposed;

  /// MinBalance microAlgo balance required by the account. The requirement grows based on asset and application usage.
  final BigInt minBalance;

  /// Participation accountParticipation describes the parameters used by this account in consensus protocol.
  final AlgoRestTypesAccountParticipation? participation;

  /// PendingRewards amount of MicroAlgos of pending rewards in this account.
  final BigInt pendingRewards;

  /// RewardBase used as part of the rewards computation. Only applicable to accounts which are participating.
  final BigInt? rewardBase;

  /// Rewards total rewards of MicroAlgos the account has received, including pending rewards.
  final BigInt rewards;

  /// Round the round for which this information is relevant.
  final BigInt round;

  /// SigType the type of signature used by this account, must be one of: * sig * msig * lsig * or null if unknown
  final String? sigType;

  /// Status voting status of the account's MicroAlgos * Offline - indicates that the associated account is delegated. * Online - indicates that the associated account used as part of the delegation pool. * NotParticipating - indicates that the associated account is neither a delegator nor a delegate.
  final String status;

  /// TotalAppsOptedIn the count of all applications that have been opted in, equivalent to the count of application local data (AppLocalState objects) stored in this account.
  final BigInt totalAppsOptedIn;

  /// TotalAssetsOptedIn the count of all assets that have been opted in, equivalent to the count of AssetHolding objects held by this account.
  final BigInt totalAssetsOptedIn;

  /// TotalBoxBytes for app-accounts only. The total number of bytes allocated for the keys and values of boxes which belong to the associated application.
  final BigInt totalBoxBytes;

  /// TotalBoxes for app-accounts only. The total number of boxes which belong to the associated application.
  final BigInt totalBoxes;

  /// TotalCreatedApps the count of all apps (AppParams objects) created by this account.
  final BigInt totalCreatedApps;

  /// TotalCreatedAssets the count of all assets (AssetParams objects) created by this account.
  final BigInt totalCreatedAssets;

  const AlgoRestTypesAccount({
    required this.address,
    required this.amount,
    required this.amountWithoutPendingRewards,
    this.appsLocalState,
    this.appsTotalExtraPages,
    this.appsTotalSchema,
    this.assets,
    this.authAddr,
    this.closedAtRound,
    this.createdApps,
    this.createdAssets,
    this.createdAtRound,
    this.deleted,
    this.incentiveEligible,
    this.lastHeartbeat,
    this.lastProposed,
    required this.minBalance,
    this.participation,
    required this.pendingRewards,
    this.rewardBase,
    required this.rewards,
    required this.round,
    this.sigType,
    required this.status,
    required this.totalAppsOptedIn,
    required this.totalAssetsOptedIn,
    required this.totalBoxBytes,
    required this.totalBoxes,
    required this.totalCreatedApps,
    required this.totalCreatedAssets,
  });

  factory AlgoRestTypesAccount.fromJson(Map<String, dynamic> json) {
    return AlgoRestTypesAccount(
      address: json.valueAsString(
        "address",
        bytesEncoding: StringEncoding.utf8,
        onMissing: () => '',
      ),
      amount: json.valueAsBigInt("amount", onMissing: () => BigInt.zero),
      amountWithoutPendingRewards: json.valueAsBigInt(
        "amount-without-pending-rewards",
        onMissing: () => BigInt.zero,
      ),
      appsLocalState: json
          .valueTo<List<AlgoRestTypesApplicationLocalState>?, List>(
            key: "apps-local-state",
            parse:
                (e) =>
                    e
                        .map(
                          (x) => AlgoRestTypesApplicationLocalState.fromJson(
                            JsonParser.valueEnsureAsMap(x),
                          ),
                        )
                        .toList(),
          ),
      appsTotalExtraPages: json.valueAsBigInt("apps-total-extra-pages"),
      appsTotalSchema: json.valueTo<AlgoRestTypesApplicationStateSchema?, Map>(
        key: "apps-total-schema",
        parse:
            (e) => AlgoRestTypesApplicationStateSchema.fromJson(
              JsonParser.valueEnsureAsMap(e),
            ),
      ),
      assets: json.valueTo<List<AlgoRestTypesAssetHolding>?, List>(
        key: "assets",
        parse:
            (e) =>
                e
                    .map(
                      (x) => AlgoRestTypesAssetHolding.fromJson(
                        JsonParser.valueEnsureAsMap(x),
                      ),
                    )
                    .toList(),
      ),
      authAddr: json.valueAsString(
        "auth-addr",
        bytesEncoding: StringEncoding.utf8,
      ),
      closedAtRound: json.valueAsBigInt("closed-at-round"),
      createdApps: json.valueTo<List<AlgoRestTypesApplication>?, List>(
        key: "created-apps",
        parse:
            (e) =>
                e
                    .map(
                      (x) => AlgoRestTypesApplication.fromJson(
                        JsonParser.valueEnsureAsMap(x),
                      ),
                    )
                    .toList(),
      ),
      createdAssets: json.valueTo<List<AlgoRestTypesAsset>?, List>(
        key: "created-assets",
        parse:
            (e) =>
                e
                    .map(
                      (x) => AlgoRestTypesAsset.fromJson(
                        JsonParser.valueEnsureAsMap(x),
                      ),
                    )
                    .toList(),
      ),
      createdAtRound: json.valueAsBigInt("created-at-round"),
      deleted: json.valueAsBool("deleted"),
      incentiveEligible: json.valueAsBool("incentive-eligible"),
      lastHeartbeat: json.valueAsBigInt("last-heartbeat"),
      lastProposed: json.valueAsBigInt("last-proposed"),
      minBalance: json.valueAsBigInt(
        "min-balance",
        onMissing: () => BigInt.zero,
      ),
      participation: json.valueTo<AlgoRestTypesAccountParticipation?, Map>(
        key: "participation",
        parse:
            (e) => AlgoRestTypesAccountParticipation.fromJson(
              JsonParser.valueEnsureAsMap(e),
            ),
      ),
      pendingRewards: json.valueAsBigInt(
        "pending-rewards",
        onMissing: () => BigInt.zero,
      ),
      rewardBase: json.valueAsBigInt("reward-base"),
      rewards: json.valueAsBigInt("rewards", onMissing: () => BigInt.zero),
      round: json.valueAsBigInt("round", onMissing: () => BigInt.zero),
      sigType: json.valueAsString(
        "sig-type",
        bytesEncoding: StringEncoding.utf8,
      ),
      status: json.valueAsString(
        "status",
        bytesEncoding: StringEncoding.utf8,
        onMissing: () => '',
      ),
      totalAppsOptedIn: json.valueAsBigInt(
        "total-apps-opted-in",
        onMissing: () => BigInt.zero,
      ),
      totalAssetsOptedIn: json.valueAsBigInt(
        "total-assets-opted-in",
        onMissing: () => BigInt.zero,
      ),
      totalBoxBytes: json.valueAsBigInt(
        "total-box-bytes",
        onMissing: () => BigInt.zero,
      ),
      totalBoxes: json.valueAsBigInt(
        "total-boxes",
        onMissing: () => BigInt.zero,
      ),
      totalCreatedApps: json.valueAsBigInt(
        "total-created-apps",
        onMissing: () => BigInt.zero,
      ),
      totalCreatedAssets: json.valueAsBigInt(
        "total-created-assets",
        onMissing: () => BigInt.zero,
      ),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "address": address,
      "amount": amount,
      "amount-without-pending-rewards": amountWithoutPendingRewards,
      "apps-local-state": appsLocalState?.map((e) => e.toJson()).toList(),
      "apps-total-extra-pages": appsTotalExtraPages,
      "apps-total-schema": appsTotalSchema?.toJson(),
      "assets": assets?.map((e) => e.toJson()).toList(),
      "auth-addr": authAddr,
      "closed-at-round": closedAtRound,
      "created-apps": createdApps?.map((e) => e.toJson()).toList(),
      "created-assets": createdAssets?.map((e) => e.toJson()).toList(),
      "created-at-round": createdAtRound,
      "deleted": deleted,
      "incentive-eligible": incentiveEligible,
      "last-heartbeat": lastHeartbeat,
      "last-proposed": lastProposed,
      "min-balance": minBalance,
      "participation": participation?.toJson(),
      "pending-rewards": pendingRewards,
      "reward-base": rewardBase,
      "rewards": rewards,
      "round": round,
      "sig-type": sigType,
      "status": status,
      "total-apps-opted-in": totalAppsOptedIn,
      "total-assets-opted-in": totalAssetsOptedIn,
      "total-box-bytes": totalBoxBytes,
      "total-boxes": totalBoxes,
      "total-created-apps": totalCreatedApps,
      "total-created-assets": totalCreatedAssets,
    }.notNullValue;
  }
}

/// AccountApplicationResource accountApplicationResource describes the account's application resource (local state and params if the account is the creator) for a specific application ID.
class AlgoRestTypesAccountApplicationResource {
  /// AppLocalState (appl) the application local data stored in this account. The raw account uses `AppLocalState` for this type.
  final AlgoRestTypesApplicationLocalState? appLocalState;

  /// CreatedAtRound round when the account opted into or created the application.
  final BigInt? createdAtRound;

  /// Deleted whether the application has been deleted.
  final bool? deleted;

  /// Id the application ID.
  final BigInt id;

  /// Params (appp) parameters of the application created by this account including app global data. The raw account uses `AppParams` for this type. Only present if the account is the creator and `include=params` is specified.
  final AlgoRestTypesApplicationParams? params;

  const AlgoRestTypesAccountApplicationResource({
    this.appLocalState,
    this.createdAtRound,
    this.deleted,
    required this.id,
    this.params,
  });

  factory AlgoRestTypesAccountApplicationResource.fromJson(
    Map<String, dynamic> json,
  ) {
    return AlgoRestTypesAccountApplicationResource(
      appLocalState: json.valueTo<AlgoRestTypesApplicationLocalState?, Map>(
        key: "app-local-state",
        parse:
            (e) => AlgoRestTypesApplicationLocalState.fromJson(
              JsonParser.valueEnsureAsMap(e),
            ),
      ),
      createdAtRound: json.valueAsBigInt("created-at-round"),
      deleted: json.valueAsBool("deleted"),
      id: json.valueAsBigInt("id", onMissing: () => BigInt.zero),
      params: json.valueTo<AlgoRestTypesApplicationParams?, Map>(
        key: "params",
        parse:
            (e) => AlgoRestTypesApplicationParams.fromJson(
              JsonParser.valueEnsureAsMap(e),
            ),
      ),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "app-local-state": appLocalState?.toJson(),
      "created-at-round": createdAtRound,
      "deleted": deleted,
      "id": id,
      "params": params?.toJson(),
    }.notNullValue;
  }
}

/// AccountApplicationResponse accountApplicationResponse describes the account's application local state and global state (AppLocalState and AppParams, if either exists) for a specific application ID. Global state will only be returned if the provided address is the application's creator.
class AlgoRestTypesAccountApplicationResponse {
  /// AppLocalState (appl) the application local data stored in this account. The raw account uses `AppLocalState` for this type.
  final AlgoRestTypesApplicationLocalState? appLocalState;

  /// CreatedApp (appp) parameters of the application created by this account including app global data. The raw account uses `AppParams` for this type.
  final AlgoRestTypesApplicationParams? createdApp;

  /// Round the round for which this information is relevant.
  final BigInt round;

  const AlgoRestTypesAccountApplicationResponse({
    this.appLocalState,
    this.createdApp,
    required this.round,
  });

  factory AlgoRestTypesAccountApplicationResponse.fromJson(
    Map<String, dynamic> json,
  ) {
    return AlgoRestTypesAccountApplicationResponse(
      appLocalState: json.valueTo<AlgoRestTypesApplicationLocalState?, Map>(
        key: "app-local-state",
        parse:
            (e) => AlgoRestTypesApplicationLocalState.fromJson(
              JsonParser.valueEnsureAsMap(e),
            ),
      ),
      createdApp: json.valueTo<AlgoRestTypesApplicationParams?, Map>(
        key: "created-app",
        parse:
            (e) => AlgoRestTypesApplicationParams.fromJson(
              JsonParser.valueEnsureAsMap(e),
            ),
      ),
      round: json.valueAsBigInt("round", onMissing: () => BigInt.zero),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "app-local-state": appLocalState?.toJson(),
      "created-app": createdApp?.toJson(),
      "round": round,
    }.notNullValue;
  }
}

/// AccountApplicationsInformationResponse accountApplicationsInformationResponse contains a list of application resources for an account.
class AlgoRestTypesAccountApplicationsInformationResponse {
  /// ApplicationResources
  final List<AlgoRestTypesAccountApplicationResource>? applicationResources;

  /// NextToken used for pagination, when making another request provide this token with the next parameter. The next token is the next application ID to use as the pagination cursor.
  final String? nextToken;

  /// Round the round for which this information is relevant.
  final BigInt round;

  const AlgoRestTypesAccountApplicationsInformationResponse({
    this.applicationResources,
    this.nextToken,
    required this.round,
  });

  factory AlgoRestTypesAccountApplicationsInformationResponse.fromJson(
    Map<String, dynamic> json,
  ) {
    return AlgoRestTypesAccountApplicationsInformationResponse(
      applicationResources: json
          .valueTo<List<AlgoRestTypesAccountApplicationResource>?, List>(
            key: "application-resources",
            parse:
                (e) =>
                    e
                        .map(
                          (x) =>
                              AlgoRestTypesAccountApplicationResource.fromJson(
                                JsonParser.valueEnsureAsMap(x),
                              ),
                        )
                        .toList(),
          ),
      nextToken: json.valueAsString(
        "next-token",
        bytesEncoding: StringEncoding.utf8,
      ),
      round: json.valueAsBigInt("round", onMissing: () => BigInt.zero),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "application-resources":
          applicationResources?.map((e) => e.toJson()).toList(),
      "next-token": nextToken,
      "round": round,
    }.notNullValue;
  }
}

/// AccountAssetHolding accountAssetHolding describes the account's asset holding and asset parameters (if either exist) for a specific asset ID.
class AlgoRestTypesAccountAssetHolding {
  /// AssetHolding (asset) Details about the asset held by this account. The raw account uses `AssetHolding` for this type.
  final AlgoRestTypesAssetHolding assetHolding;

  /// AssetParams (apar) parameters of the asset held by this account. The raw account uses `AssetParams` for this type.
  final AlgoRestTypesAssetParams? assetParams;

  const AlgoRestTypesAccountAssetHolding({
    required this.assetHolding,
    this.assetParams,
  });

  factory AlgoRestTypesAccountAssetHolding.fromJson(Map<String, dynamic> json) {
    return AlgoRestTypesAccountAssetHolding(
      assetHolding: json.valueTo<AlgoRestTypesAssetHolding, Map>(
        key: "asset-holding",
        parse:
            (e) => AlgoRestTypesAssetHolding.fromJson(
              JsonParser.valueEnsureAsMap(e),
            ),
      ),
      assetParams: json.valueTo<AlgoRestTypesAssetParams?, Map>(
        key: "asset-params",
        parse:
            (e) => AlgoRestTypesAssetParams.fromJson(
              JsonParser.valueEnsureAsMap(e),
            ),
      ),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "asset-holding": assetHolding.toJson(),
      "asset-params": assetParams?.toJson(),
    }.notNullValue;
  }
}

/// AccountAssetResponse accountAssetResponse describes the account's asset holding and asset parameters (if either exist) for a specific asset ID. Asset parameters will only be returned if the provided address is the asset's creator.
class AlgoRestTypesAccountAssetResponse {
  /// AssetHolding (asset) Details about the asset held by this account. The raw account uses `AssetHolding` for this type.
  final AlgoRestTypesAssetHolding? assetHolding;

  /// CreatedAsset (apar) parameters of the asset created by this account. The raw account uses `AssetParams` for this type.
  final AlgoRestTypesAssetParams? createdAsset;

  /// Round the round for which this information is relevant.
  final BigInt round;

  const AlgoRestTypesAccountAssetResponse({
    this.assetHolding,
    this.createdAsset,
    required this.round,
  });

  factory AlgoRestTypesAccountAssetResponse.fromJson(
    Map<String, dynamic> json,
  ) {
    return AlgoRestTypesAccountAssetResponse(
      assetHolding: json.valueTo<AlgoRestTypesAssetHolding?, Map>(
        key: "asset-holding",
        parse:
            (e) => AlgoRestTypesAssetHolding.fromJson(
              JsonParser.valueEnsureAsMap(e),
            ),
      ),
      createdAsset: json.valueTo<AlgoRestTypesAssetParams?, Map>(
        key: "created-asset",
        parse:
            (e) => AlgoRestTypesAssetParams.fromJson(
              JsonParser.valueEnsureAsMap(e),
            ),
      ),
      round: json.valueAsBigInt("round", onMissing: () => BigInt.zero),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "asset-holding": assetHolding?.toJson(),
      "created-asset": createdAsset?.toJson(),
      "round": round,
    }.notNullValue;
  }
}

/// AccountAssetsInformationResponse accountAssetsInformationResponse contains a list of assets held by an account.
class AlgoRestTypesAccountAssetsInformationResponse {
  /// AssetHoldings
  final List<AlgoRestTypesAccountAssetHolding>? assetHoldings;

  /// NextToken used for pagination, when making another request provide this token with the next parameter.
  final String? nextToken;

  /// Round the round for which this information is relevant.
  final BigInt round;

  const AlgoRestTypesAccountAssetsInformationResponse({
    this.assetHoldings,
    this.nextToken,
    required this.round,
  });

  factory AlgoRestTypesAccountAssetsInformationResponse.fromJson(
    Map<String, dynamic> json,
  ) {
    return AlgoRestTypesAccountAssetsInformationResponse(
      assetHoldings: json
          .valueTo<List<AlgoRestTypesAccountAssetHolding>?, List>(
            key: "asset-holdings",
            parse:
                (e) =>
                    e
                        .map(
                          (x) => AlgoRestTypesAccountAssetHolding.fromJson(
                            JsonParser.valueEnsureAsMap(x),
                          ),
                        )
                        .toList(),
          ),
      nextToken: json.valueAsString(
        "next-token",
        bytesEncoding: StringEncoding.utf8,
      ),
      round: json.valueAsBigInt("round", onMissing: () => BigInt.zero),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "asset-holdings": assetHoldings?.map((e) => e.toJson()).toList(),
      "next-token": nextToken,
      "round": round,
    }.notNullValue;
  }
}

/// AccountErrorResponse an error response for the AccountInformation endpoint, with optional information about limits that were exceeded.
class AlgoRestTypesAccountErrorResponse {
  /// Data
  final String? data;

  /// MaxResults
  final BigInt? maxResults;

  /// Message
  final String message;

  /// TotalAppsLocalState
  final BigInt? totalAppsLocalState;

  /// TotalAssets
  final BigInt? totalAssets;

  /// TotalCreatedApps
  final BigInt? totalCreatedApps;

  /// TotalCreatedAssets
  final BigInt? totalCreatedAssets;

  const AlgoRestTypesAccountErrorResponse({
    this.data,
    this.maxResults,
    required this.message,
    this.totalAppsLocalState,
    this.totalAssets,
    this.totalCreatedApps,
    this.totalCreatedAssets,
  });

  factory AlgoRestTypesAccountErrorResponse.fromJson(
    Map<String, dynamic> json,
  ) {
    return AlgoRestTypesAccountErrorResponse(
      data: json.valueAsString("data", bytesEncoding: StringEncoding.utf8),
      maxResults: json.valueAsBigInt("max-results"),
      message: json.valueAsString(
        "message",
        bytesEncoding: StringEncoding.utf8,
        onMissing: () => '',
      ),
      totalAppsLocalState: json.valueAsBigInt("total-apps-local-state"),
      totalAssets: json.valueAsBigInt("total-assets"),
      totalCreatedApps: json.valueAsBigInt("total-created-apps"),
      totalCreatedAssets: json.valueAsBigInt("total-created-assets"),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "data": data,
      "max-results": maxResults,
      "message": message,
      "total-apps-local-state": totalAppsLocalState,
      "total-assets": totalAssets,
      "total-created-apps": totalCreatedApps,
      "total-created-assets": totalCreatedAssets,
    }.notNullValue;
  }
}

/// AccountParticipation accountParticipation describes the parameters used by this account in consensus protocol.
class AlgoRestTypesAccountParticipation {
  /// SelectionParticipationKey selection public key (if any) currently registered for this round.
  final BuBytes selectionParticipationKey;

  /// StateProofKey root of the state proof key (if any)
  final BuBytes? stateProofKey;

  /// VoteFirstValid first round for which this participation is valid.
  final BigInt voteFirstValid;

  /// VoteKeyDilution number of subkeys in each batch of participation keys.
  final BigInt voteKeyDilution;

  /// VoteLastValid last round for which this participation is valid.
  final BigInt voteLastValid;

  /// VoteParticipationKey root participation public key (if any) currently registered for this round.
  final BuBytes voteParticipationKey;

  AlgoRestTypesAccountParticipation({
    required List<int> selectionParticipationKey,
    List<int>? stateProofKey,
    required this.voteFirstValid,
    required this.voteKeyDilution,
    required this.voteLastValid,
    required List<int> voteParticipationKey,
  }) : voteParticipationKey = voteParticipationKey.asImmutableBytes, stateProofKey = stateProofKey?.asImmutableBytes, selectionParticipationKey = selectionParticipationKey.asImmutableBytes;

  factory AlgoRestTypesAccountParticipation.fromJson(
    Map<String, dynamic> json,
  ) {
    return AlgoRestTypesAccountParticipation(
      selectionParticipationKey: json.valueAsBytes(
        "selection-participation-key",
        encoding: StringEncoding.base64,
        onMissing: () => [],
      ),
      stateProofKey: json.valueAsBytes(
        "state-proof-key",
        encoding: StringEncoding.base64,
      ),
      voteFirstValid: json.valueAsBigInt(
        "vote-first-valid",
        onMissing: () => BigInt.zero,
      ),
      voteKeyDilution: json.valueAsBigInt(
        "vote-key-dilution",
        onMissing: () => BigInt.zero,
      ),
      voteLastValid: json.valueAsBigInt(
        "vote-last-valid",
        onMissing: () => BigInt.zero,
      ),
      voteParticipationKey: json.valueAsBytes(
        "vote-participation-key",
        encoding: StringEncoding.base64,
        onMissing: () => [],
      ),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "selection-participation-key": selectionParticipationKey,
      "state-proof-key": stateProofKey,
      "vote-first-valid": voteFirstValid,
      "vote-key-dilution": voteKeyDilution,
      "vote-last-valid": voteLastValid,
      "vote-participation-key": voteParticipationKey,
    }.notNullValue;
  }
}

/// AccountResponse
class AlgoRestTypesAccountResponse {
  /// Account account information at a given round. Definition: data/basics/userBalance.go : AccountData
  final AlgoRestTypesAccount account;

  /// CurrentRound round at which the results were computed.
  final BigInt currentRound;

  const AlgoRestTypesAccountResponse({
    required this.account,
    required this.currentRound,
  });

  factory AlgoRestTypesAccountResponse.fromJson(Map<String, dynamic> json) {
    return AlgoRestTypesAccountResponse(
      account: json.valueTo<AlgoRestTypesAccount, Map>(
        key: "account",
        parse:
            (e) =>
                AlgoRestTypesAccount.fromJson(JsonParser.valueEnsureAsMap(e)),
      ),
      currentRound: json.valueAsBigInt(
        "current-round",
        onMissing: () => BigInt.zero,
      ),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "account": account.toJson(),
      "current-round": currentRound,
    }.notNullValue;
  }
}

/// AccountStateDelta application state delta.
class AlgoRestTypesAccountStateDelta {
  /// Address
  final String address;

  /// Delta application state delta.
  final List<AlgoRestTypesEvalDeltaKeyValue> delta;

  const AlgoRestTypesAccountStateDelta({
    required this.address,
    required this.delta,
  });

  factory AlgoRestTypesAccountStateDelta.fromJson(Map<String, dynamic> json) {
    return AlgoRestTypesAccountStateDelta(
      address: json.valueAsString(
        "address",
        bytesEncoding: StringEncoding.utf8,
        onMissing: () => '',
      ),
      delta: json.valueTo<List<AlgoRestTypesEvalDeltaKeyValue>, List>(
        key: "delta",
        onMissing: () => [],
        parse:
            (e) =>
                e
                    .map(
                      (x) => AlgoRestTypesEvalDeltaKeyValue.fromJson(
                        JsonParser.valueEnsureAsMap(x),
                      ),
                    )
                    .toList(),
      ),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "address": address,
      "delta": delta.map((e) => e.toJson()).toList(),
    }.notNullValue;
  }
}

/// AccountsResponse
class AlgoRestTypesAccountsResponse {
  /// Accounts
  final List<AlgoRestTypesAccount> accounts;

  /// CurrentRound round at which the results were computed.
  final BigInt currentRound;

  /// NextToken used for pagination, when making another request provide this token with the next parameter.
  final String? nextToken;

  const AlgoRestTypesAccountsResponse({
    required this.accounts,
    required this.currentRound,
    this.nextToken,
  });

  factory AlgoRestTypesAccountsResponse.fromJson(Map<String, dynamic> json) {
    return AlgoRestTypesAccountsResponse(
      accounts: json.valueTo<List<AlgoRestTypesAccount>, List>(
        key: "accounts",
        onMissing: () => [],
        parse:
            (e) =>
                e
                    .map(
                      (x) => AlgoRestTypesAccount.fromJson(
                        JsonParser.valueEnsureAsMap(x),
                      ),
                    )
                    .toList(),
      ),
      currentRound: json.valueAsBigInt(
        "current-round",
        onMissing: () => BigInt.zero,
      ),
      nextToken: json.valueAsString(
        "next-token",
        bytesEncoding: StringEncoding.utf8,
      ),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "accounts": accounts.map((e) => e.toJson()).toList(),
      "current-round": currentRound,
      "next-token": nextToken,
    }.notNullValue;
  }
}

/// AppCallLogs the logged messages from an app call along with the app ID and outer transaction ID. Logs appear in the same order that they were emitted.
class AlgoRestTypesAppCallLogs {
  /// ApplicationIndex the application from which the logs were generated
  final BigInt applicationIndex;

  /// Logs an array of logs
  final List<BuBytes> logs;

  /// Txid the transaction ID of the outer app call that lead to these logs
  final String txid;

  AlgoRestTypesAppCallLogs({
    required this.applicationIndex,
    required List<List<int>> logs,
    required this.txid,
  }) : logs = logs.map((e) => e.asImmutableBytes).toImutableList;

  factory AlgoRestTypesAppCallLogs.fromJson(Map<String, dynamic> json) {
    return AlgoRestTypesAppCallLogs(
      applicationIndex: json.valueAsBigInt(
        "application-index",
        onMissing: () => BigInt.zero,
      ),
      logs: json.valueTo<List<List<int>>, List>(
        key: "logs",
        onMissing: () => [],
        parse:
            (e) =>
                e
                    .map(
                      (x) => JsonParser.valueAsBytes<List<int>>(
                        x,
                        encoding: StringEncoding.base64,
                      ),
                    )
                    .toList(),
      ),
      txid: json.valueAsString(
        "txId",
        bytesEncoding: StringEncoding.utf8,
        onMissing: () => '',
      ),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "application-index": applicationIndex,
      "logs": logs,
      "txId": txid,
    }.notNullValue;
  }
}

/// Application application index and its parameters
class AlgoRestTypesApplication {
  /// CreatedAtRound round when this application was created.
  final BigInt? createdAtRound;

  /// Deleted whether or not this application is currently deleted.
  final bool? deleted;

  /// DeletedAtRound round when this application was deleted.
  final BigInt? deletedAtRound;

  /// Id application index.
  final BigInt id;

  /// Params application parameters.
  final AlgoRestTypesApplicationParams params;

  const AlgoRestTypesApplication({
    this.createdAtRound,
    this.deleted,
    this.deletedAtRound,
    required this.id,
    required this.params,
  });

  factory AlgoRestTypesApplication.fromJson(Map<String, dynamic> json) {
    return AlgoRestTypesApplication(
      createdAtRound: json.valueAsBigInt("created-at-round"),
      deleted: json.valueAsBool("deleted"),
      deletedAtRound: json.valueAsBigInt("deleted-at-round"),
      id: json.valueAsBigInt("id", onMissing: () => BigInt.zero),
      params: json.valueTo<AlgoRestTypesApplicationParams, Map>(
        key: "params",
        parse:
            (e) => AlgoRestTypesApplicationParams.fromJson(
              JsonParser.valueEnsureAsMap(e),
            ),
      ),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "created-at-round": createdAtRound,
      "deleted": deleted,
      "deleted-at-round": deletedAtRound,
      "id": id,
      "params": params.toJson(),
    }.notNullValue;
  }
}

/// ApplicationInitialStates an application's initial global/local/box states that were accessed during simulation.
class AlgoRestTypesApplicationInitialStates {
  /// AppBoxes an application's global/local/box state.
  final AlgoRestTypesApplicationKVStorage? appBoxes;

  /// AppGlobals an application's global/local/box state.
  final AlgoRestTypesApplicationKVStorage? appGlobals;

  /// AppLocals an application's initial local states tied to different accounts.
  final List<AlgoRestTypesApplicationKVStorage>? appLocals;

  /// Id application index.
  final BigInt id;

  const AlgoRestTypesApplicationInitialStates({
    this.appBoxes,
    this.appGlobals,
    this.appLocals,
    required this.id,
  });

  factory AlgoRestTypesApplicationInitialStates.fromJson(
    Map<String, dynamic> json,
  ) {
    return AlgoRestTypesApplicationInitialStates(
      appBoxes: json.valueTo<AlgoRestTypesApplicationKVStorage?, Map>(
        key: "app-boxes",
        parse:
            (e) => AlgoRestTypesApplicationKVStorage.fromJson(
              JsonParser.valueEnsureAsMap(e),
            ),
      ),
      appGlobals: json.valueTo<AlgoRestTypesApplicationKVStorage?, Map>(
        key: "app-globals",
        parse:
            (e) => AlgoRestTypesApplicationKVStorage.fromJson(
              JsonParser.valueEnsureAsMap(e),
            ),
      ),
      appLocals: json.valueTo<List<AlgoRestTypesApplicationKVStorage>?, List>(
        key: "app-locals",
        parse:
            (e) =>
                e
                    .map(
                      (x) => AlgoRestTypesApplicationKVStorage.fromJson(
                        JsonParser.valueEnsureAsMap(x),
                      ),
                    )
                    .toList(),
      ),
      id: json.valueAsBigInt("id", onMissing: () => BigInt.zero),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "app-boxes": appBoxes?.toJson(),
      "app-globals": appGlobals?.toJson(),
      "app-locals": appLocals?.map((e) => e.toJson()).toList(),
      "id": id,
    }.notNullValue;
  }
}

/// ApplicationKVStorage an application's global/local/box state.
class AlgoRestTypesApplicationKVStorage {
  /// Account the address of the account associated with the local state.
  final String? account;

  /// Kvs key-Value pairs representing application states.
  final List<AlgoRestTypesAvmKeyValue> kvs;

  const AlgoRestTypesApplicationKVStorage({this.account, required this.kvs});

  factory AlgoRestTypesApplicationKVStorage.fromJson(
    Map<String, dynamic> json,
  ) {
    return AlgoRestTypesApplicationKVStorage(
      account: json.valueAsString(
        "account",
        bytesEncoding: StringEncoding.utf8,
      ),
      kvs: json.valueTo<List<AlgoRestTypesAvmKeyValue>, List>(
        key: "kvs",
        onMissing: () => [],
        parse:
            (e) =>
                e
                    .map(
                      (x) => AlgoRestTypesAvmKeyValue.fromJson(
                        JsonParser.valueEnsureAsMap(x),
                      ),
                    )
                    .toList(),
      ),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "account": account,
      "kvs": kvs.map((e) => e.toJson()).toList(),
    }.notNullValue;
  }
}

/// ApplicationLocalReference references an account's local state for an application.
class AlgoRestTypesApplicationLocalReference {
  /// Account address of the account with the local state.
  final String account;

  /// App application ID of the local state application.
  final BigInt app;

  const AlgoRestTypesApplicationLocalReference({
    required this.account,
    required this.app,
  });

  factory AlgoRestTypesApplicationLocalReference.fromJson(
    Map<String, dynamic> json,
  ) {
    return AlgoRestTypesApplicationLocalReference(
      account: json.valueAsString(
        "account",
        bytesEncoding: StringEncoding.utf8,
        onMissing: () => '',
      ),
      app: json.valueAsBigInt("app", onMissing: () => BigInt.zero),
    );
  }

  Map<String, dynamic> toJson() {
    return {"account": account, "app": app}.notNullValue;
  }
}

/// ApplicationLocalState stores local state associated with an application.
class AlgoRestTypesApplicationLocalState {
  /// ClosedOutAtRound round when account closed out of the application.
  final BigInt? closedOutAtRound;

  /// Deleted whether or not the application local state is currently deleted from its account.
  final bool? deleted;

  /// Id the application which this local state is for.
  final BigInt id;

  /// KeyValue storage.
  final List<AlgoRestTypesTealKeyValue>? keyValue;

  /// OptedInAtRound round when the account opted into the application.
  final BigInt? optedInAtRound;

  /// Schema schema.
  final AlgoRestTypesApplicationStateSchema schema;

  const AlgoRestTypesApplicationLocalState({
    this.closedOutAtRound,
    this.deleted,
    required this.id,
    this.keyValue,
    this.optedInAtRound,
    required this.schema,
  });

  factory AlgoRestTypesApplicationLocalState.fromJson(
    Map<String, dynamic> json,
  ) {
    return AlgoRestTypesApplicationLocalState(
      closedOutAtRound: json.valueAsBigInt("closed-out-at-round"),
      deleted: json.valueAsBool("deleted"),
      id: json.valueAsBigInt("id", onMissing: () => BigInt.zero),
      keyValue: json.valueTo<List<AlgoRestTypesTealKeyValue>?, List>(
        key: "key-value",
        parse:
            (e) =>
                e
                    .map(
                      (x) => AlgoRestTypesTealKeyValue.fromJson(
                        JsonParser.valueEnsureAsMap(x),
                      ),
                    )
                    .toList(),
      ),
      optedInAtRound: json.valueAsBigInt("opted-in-at-round"),
      schema: json.valueTo<AlgoRestTypesApplicationStateSchema, Map>(
        key: "schema",
        parse:
            (e) => AlgoRestTypesApplicationStateSchema.fromJson(
              JsonParser.valueEnsureAsMap(e),
            ),
      ),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "closed-out-at-round": closedOutAtRound,
      "deleted": deleted,
      "id": id,
      "key-value": keyValue?.map((e) => e.toJson()).toList(),
      "opted-in-at-round": optedInAtRound,
      "schema": schema.toJson(),
    }.notNullValue;
  }
}

/// ApplicationLocalStatesResponse
class AlgoRestTypesApplicationLocalStatesResponse {
  /// AppsLocalStates
  final List<AlgoRestTypesApplicationLocalState> appsLocalStates;

  /// CurrentRound round at which the results were computed.
  final BigInt currentRound;

  /// NextToken used for pagination, when making another request provide this token with the next parameter.
  final String? nextToken;

  const AlgoRestTypesApplicationLocalStatesResponse({
    required this.appsLocalStates,
    required this.currentRound,
    this.nextToken,
  });

  factory AlgoRestTypesApplicationLocalStatesResponse.fromJson(
    Map<String, dynamic> json,
  ) {
    return AlgoRestTypesApplicationLocalStatesResponse(
      appsLocalStates: json
          .valueTo<List<AlgoRestTypesApplicationLocalState>, List>(
            key: "apps-local-states",
            onMissing: () => [],
            parse:
                (e) =>
                    e
                        .map(
                          (x) => AlgoRestTypesApplicationLocalState.fromJson(
                            JsonParser.valueEnsureAsMap(x),
                          ),
                        )
                        .toList(),
          ),
      currentRound: json.valueAsBigInt(
        "current-round",
        onMissing: () => BigInt.zero,
      ),
      nextToken: json.valueAsString(
        "next-token",
        bytesEncoding: StringEncoding.utf8,
      ),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "apps-local-states": appsLocalStates.map((e) => e.toJson()).toList(),
      "current-round": currentRound,
      "next-token": nextToken,
    }.notNullValue;
  }
}

/// ApplicationLogData stores the global information associated with an application.
class AlgoRestTypesApplicationLogData {
  /// Logs logs for the application being executed by the transaction.
  final List<BuBytes> logs;

  /// Txid transaction ID
  final String txid;

  AlgoRestTypesApplicationLogData({
    required List<List<int>> logs,
    required this.txid,
  }) : logs = logs.map((e) => e.asImmutableBytes).toImutableList;

  factory AlgoRestTypesApplicationLogData.fromJson(Map<String, dynamic> json) {
    return AlgoRestTypesApplicationLogData(
      logs: json.valueTo<List<List<int>>, List>(
        key: "logs",
        onMissing: () => [],
        parse:
            (e) =>
                e
                    .map(
                      (x) => JsonParser.valueAsBytes<List<int>>(
                        x,
                        encoding: StringEncoding.base64,
                      ),
                    )
                    .toList(),
      ),
      txid: json.valueAsString(
        "txid",
        bytesEncoding: StringEncoding.utf8,
        onMissing: () => '',
      ),
    );
  }

  Map<String, dynamic> toJson() {
    return {"logs": logs, "txid": txid}.notNullValue;
  }
}

/// ApplicationLogsResponse
class AlgoRestTypesApplicationLogsResponse {
  /// ApplicationId (appidx) application index.
  final BigInt applicationId;

  /// CurrentRound round at which the results were computed.
  final BigInt currentRound;

  /// LogData
  final List<AlgoRestTypesApplicationLogData>? logData;

  /// NextToken used for pagination, when making another request provide this token with the next parameter.
  final String? nextToken;

  const AlgoRestTypesApplicationLogsResponse({
    required this.applicationId,
    required this.currentRound,
    this.logData,
    this.nextToken,
  });

  factory AlgoRestTypesApplicationLogsResponse.fromJson(
    Map<String, dynamic> json,
  ) {
    return AlgoRestTypesApplicationLogsResponse(
      applicationId: json.valueAsBigInt(
        "application-id",
        onMissing: () => BigInt.zero,
      ),
      currentRound: json.valueAsBigInt(
        "current-round",
        onMissing: () => BigInt.zero,
      ),
      logData: json.valueTo<List<AlgoRestTypesApplicationLogData>?, List>(
        key: "log-data",
        parse:
            (e) =>
                e
                    .map(
                      (x) => AlgoRestTypesApplicationLogData.fromJson(
                        JsonParser.valueEnsureAsMap(x),
                      ),
                    )
                    .toList(),
      ),
      nextToken: json.valueAsString(
        "next-token",
        bytesEncoding: StringEncoding.utf8,
      ),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "application-id": applicationId,
      "current-round": currentRound,
      "log-data": logData?.map((e) => e.toJson()).toList(),
      "next-token": nextToken,
    }.notNullValue;
  }
}

/// ApplicationParams stores the global information associated with an application.
class AlgoRestTypesApplicationParams {
  /// ApprovalProgram approval program.
  final BuBytes approvalProgram;

  /// ClearStateProgram clear state program.
  final BuBytes clearStateProgram;

  /// Creator the address that created this application. This is the address where the parameters and global state for this application can be found.
  final String? creator;

  /// ExtraProgramPages the number of extra program pages available to this app.
  final BigInt? extraProgramPages;

  /// GlobalState global state
  final List<AlgoRestTypesTealKeyValue>? globalState;

  /// GlobalStateSchema global schema
  final AlgoRestTypesApplicationStateSchema? globalStateSchema;

  /// LocalStateSchema local schema
  final AlgoRestTypesApplicationStateSchema? localStateSchema;

  /// Version the number of updates to the application programs
  final BigInt? version;

  AlgoRestTypesApplicationParams({
    required List<int> approvalProgram,
    required List<int> clearStateProgram,
    this.creator,
    this.extraProgramPages,
    this.globalState,
    this.globalStateSchema,
    this.localStateSchema,
    this.version,
  }) : clearStateProgram = clearStateProgram.asImmutableBytes, approvalProgram = approvalProgram.asImmutableBytes;

  factory AlgoRestTypesApplicationParams.fromJson(Map<String, dynamic> json) {
    return AlgoRestTypesApplicationParams(
      approvalProgram: json.valueAsBytes(
        "approval-program",
        encoding: StringEncoding.base64,
        onMissing: () => [],
      ),
      clearStateProgram: json.valueAsBytes(
        "clear-state-program",
        encoding: StringEncoding.base64,
        onMissing: () => [],
      ),
      creator: json.valueAsString(
        "creator",
        bytesEncoding: StringEncoding.utf8,
      ),
      extraProgramPages: json.valueAsBigInt("extra-program-pages"),
      globalState: json.valueTo<List<AlgoRestTypesTealKeyValue>?, List>(
        key: "global-state",
        parse:
            (e) =>
                e
                    .map(
                      (x) => AlgoRestTypesTealKeyValue.fromJson(
                        JsonParser.valueEnsureAsMap(x),
                      ),
                    )
                    .toList(),
      ),
      globalStateSchema: json
          .valueTo<AlgoRestTypesApplicationStateSchema?, Map>(
            key: "global-state-schema",
            parse:
                (e) => AlgoRestTypesApplicationStateSchema.fromJson(
                  JsonParser.valueEnsureAsMap(e),
                ),
          ),
      localStateSchema: json.valueTo<AlgoRestTypesApplicationStateSchema?, Map>(
        key: "local-state-schema",
        parse:
            (e) => AlgoRestTypesApplicationStateSchema.fromJson(
              JsonParser.valueEnsureAsMap(e),
            ),
      ),
      version: json.valueAsBigInt("version"),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "approval-program": approvalProgram,
      "clear-state-program": clearStateProgram,
      "creator": creator,
      "extra-program-pages": extraProgramPages,
      "global-state": globalState?.map((e) => e.toJson()).toList(),
      "global-state-schema": globalStateSchema?.toJson(),
      "local-state-schema": localStateSchema?.toJson(),
      "version": version,
    }.notNullValue;
  }
}

/// ApplicationResponse
class AlgoRestTypesApplicationResponse {
  /// Application application index and its parameters
  final AlgoRestTypesApplication? application;

  /// CurrentRound round at which the results were computed.
  final BigInt currentRound;

  const AlgoRestTypesApplicationResponse({
    this.application,
    required this.currentRound,
  });

  factory AlgoRestTypesApplicationResponse.fromJson(Map<String, dynamic> json) {
    return AlgoRestTypesApplicationResponse(
      application: json.valueTo<AlgoRestTypesApplication?, Map>(
        key: "application",
        parse:
            (e) => AlgoRestTypesApplication.fromJson(
              JsonParser.valueEnsureAsMap(e),
            ),
      ),
      currentRound: json.valueAsBigInt(
        "current-round",
        onMissing: () => BigInt.zero,
      ),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "application": application?.toJson(),
      "current-round": currentRound,
    }.notNullValue;
  }
}

/// ApplicationStateOperation an operation against an application's global/local/box state.
class AlgoRestTypesApplicationStateOperation {
  /// Account for local state changes, the address of the account associated with the local state.
  final String? account;

  /// AppStateType type of application state. Value `g` is **global state**, `l` is **local state**, `b` is **boxes**.
  final String appStateType;

  /// Key the key (name) of the global/local/box state.
  final BuBytes key;

  /// NewValue represents an AVM value.
  final AlgoRestTypesAvmValue? newValue;

  /// Operation operation type. Value `w` is **write**, `d` is **delete**.
  final String operation;

  AlgoRestTypesApplicationStateOperation({
    this.account,
    required this.appStateType,
    required List<int> key,
    this.newValue,
    required this.operation,
  }) : key = key.asImmutableBytes;

  factory AlgoRestTypesApplicationStateOperation.fromJson(
    Map<String, dynamic> json,
  ) {
    return AlgoRestTypesApplicationStateOperation(
      account: json.valueAsString(
        "account",
        bytesEncoding: StringEncoding.utf8,
      ),
      appStateType: json.valueAsString(
        "app-state-type",
        bytesEncoding: StringEncoding.utf8,
        onMissing: () => '',
      ),
      key: json.valueAsBytes(
        "key",
        encoding: StringEncoding.base64,
        onMissing: () => [],
      ),
      newValue: json.valueTo<AlgoRestTypesAvmValue?, Map>(
        key: "new-value",
        parse:
            (e) =>
                AlgoRestTypesAvmValue.fromJson(JsonParser.valueEnsureAsMap(e)),
      ),
      operation: json.valueAsString(
        "operation",
        bytesEncoding: StringEncoding.utf8,
        onMissing: () => '',
      ),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "account": account,
      "app-state-type": appStateType,
      "key": key,
      "new-value": newValue?.toJson(),
      "operation": operation,
    }.notNullValue;
  }
}

/// ApplicationStateSchema specifies maximums on the number of each type that may be stored.
class AlgoRestTypesApplicationStateSchema {
  /// NumByteSlice number of byte slices.
  final BigInt numByteSlice;

  /// NumUint number of uints.
  final BigInt numUint;

  const AlgoRestTypesApplicationStateSchema({
    required this.numByteSlice,
    required this.numUint,
  });

  factory AlgoRestTypesApplicationStateSchema.fromJson(
    Map<String, dynamic> json,
  ) {
    return AlgoRestTypesApplicationStateSchema(
      numByteSlice: json.valueAsBigInt(
        "num-byte-slice",
        onMissing: () => BigInt.zero,
      ),
      numUint: json.valueAsBigInt("num-uint", onMissing: () => BigInt.zero),
    );
  }

  Map<String, dynamic> toJson() {
    return {"num-byte-slice": numByteSlice, "num-uint": numUint}.notNullValue;
  }
}

/// ApplicationsResponse
class AlgoRestTypesApplicationsResponse {
  /// Applications
  final List<AlgoRestTypesApplication> applications;

  /// CurrentRound round at which the results were computed.
  final BigInt currentRound;

  /// NextToken used for pagination, when making another request provide this token with the next parameter.
  final String? nextToken;

  const AlgoRestTypesApplicationsResponse({
    required this.applications,
    required this.currentRound,
    this.nextToken,
  });

  factory AlgoRestTypesApplicationsResponse.fromJson(
    Map<String, dynamic> json,
  ) {
    return AlgoRestTypesApplicationsResponse(
      applications: json.valueTo<List<AlgoRestTypesApplication>, List>(
        key: "applications",
        onMissing: () => [],
        parse:
            (e) =>
                e
                    .map(
                      (x) => AlgoRestTypesApplication.fromJson(
                        JsonParser.valueEnsureAsMap(x),
                      ),
                    )
                    .toList(),
      ),
      currentRound: json.valueAsBigInt(
        "current-round",
        onMissing: () => BigInt.zero,
      ),
      nextToken: json.valueAsString(
        "next-token",
        bytesEncoding: StringEncoding.utf8,
      ),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "applications": applications.map((e) => e.toJson()).toList(),
      "current-round": currentRound,
      "next-token": nextToken,
    }.notNullValue;
  }
}

/// Asset specifies both the unique identifier and the parameters for an asset
class AlgoRestTypesAsset {
  /// CreatedAtRound round during which this asset was created.
  final BigInt? createdAtRound;

  /// Deleted whether or not this asset is currently deleted.
  final bool? deleted;

  /// DestroyedAtRound round during which this asset was destroyed.
  final BigInt? destroyedAtRound;

  /// Index unique asset identifier
  final BigInt index;

  /// Params assetParams specifies the parameters for an asset. (apar) when part of an AssetConfig transaction. Definition: data/transactions/asset.go : AssetParams
  final AlgoRestTypesAssetParams params;

  const AlgoRestTypesAsset({
    this.createdAtRound,
    this.deleted,
    this.destroyedAtRound,
    required this.index,
    required this.params,
  });

  factory AlgoRestTypesAsset.fromJson(Map<String, dynamic> json) {
    return AlgoRestTypesAsset(
      createdAtRound: json.valueAsBigInt("created-at-round"),
      deleted: json.valueAsBool("deleted"),
      destroyedAtRound: json.valueAsBigInt("destroyed-at-round"),
      index: json.valueAsBigInt("index", onMissing: () => BigInt.zero),
      params: json.valueTo<AlgoRestTypesAssetParams, Map>(
        key: "params",
        parse:
            (e) => AlgoRestTypesAssetParams.fromJson(
              JsonParser.valueEnsureAsMap(e),
            ),
      ),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "created-at-round": createdAtRound,
      "deleted": deleted,
      "destroyed-at-round": destroyedAtRound,
      "index": index,
      "params": params.toJson(),
    }.notNullValue;
  }
}

/// AssetBalancesResponse
class AlgoRestTypesAssetBalancesResponse {
  /// Balances
  final List<AlgoRestTypesMiniAssetHolding> balances;

  /// CurrentRound round at which the results were computed.
  final BigInt currentRound;

  /// NextToken used for pagination, when making another request provide this token with the next parameter.
  final String? nextToken;

  const AlgoRestTypesAssetBalancesResponse({
    required this.balances,
    required this.currentRound,
    this.nextToken,
  });

  factory AlgoRestTypesAssetBalancesResponse.fromJson(
    Map<String, dynamic> json,
  ) {
    return AlgoRestTypesAssetBalancesResponse(
      balances: json.valueTo<List<AlgoRestTypesMiniAssetHolding>, List>(
        key: "balances",
        onMissing: () => [],
        parse:
            (e) =>
                e
                    .map(
                      (x) => AlgoRestTypesMiniAssetHolding.fromJson(
                        JsonParser.valueEnsureAsMap(x),
                      ),
                    )
                    .toList(),
      ),
      currentRound: json.valueAsBigInt(
        "current-round",
        onMissing: () => BigInt.zero,
      ),
      nextToken: json.valueAsString(
        "next-token",
        bytesEncoding: StringEncoding.utf8,
      ),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "balances": balances.map((e) => e.toJson()).toList(),
      "current-round": currentRound,
      "next-token": nextToken,
    }.notNullValue;
  }
}

/// AssetHolding describes an asset held by an account. Definition: data/basics/userBalance.go : AssetHolding
class AlgoRestTypesAssetHolding {
  /// Amount number of units held.
  final BigInt amount;

  /// AssetId asset ID of the holding.
  final BigInt assetId;

  /// Deleted whether or not the asset holding is currently deleted from its account.
  final bool? deleted;

  /// IsFrozen whether or not the holding is frozen.
  final bool isFrozen;

  /// OptedInAtRound round during which the account opted into this asset holding.
  final BigInt? optedInAtRound;

  /// OptedOutAtRound round during which the account opted out of this asset holding.
  final BigInt? optedOutAtRound;

  const AlgoRestTypesAssetHolding({
    required this.amount,
    required this.assetId,
    this.deleted,
    required this.isFrozen,
    this.optedInAtRound,
    this.optedOutAtRound,
  });

  factory AlgoRestTypesAssetHolding.fromJson(Map<String, dynamic> json) {
    return AlgoRestTypesAssetHolding(
      amount: json.valueAsBigInt("amount", onMissing: () => BigInt.zero),
      assetId: json.valueAsBigInt("asset-id", onMissing: () => BigInt.zero),
      deleted: json.valueAsBool("deleted"),
      isFrozen: json.valueAsBool("is-frozen", onMissing: () => false),
      optedInAtRound: json.valueAsBigInt("opted-in-at-round"),
      optedOutAtRound: json.valueAsBigInt("opted-out-at-round"),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "amount": amount,
      "asset-id": assetId,
      "deleted": deleted,
      "is-frozen": isFrozen,
      "opted-in-at-round": optedInAtRound,
      "opted-out-at-round": optedOutAtRound,
    }.notNullValue;
  }
}

/// AssetHoldingReference references an asset held by an account.
class AlgoRestTypesAssetHoldingReference {
  /// Account address of the account holding the asset.
  final String account;

  /// Asset asset ID of the holding.
  final BigInt asset;

  const AlgoRestTypesAssetHoldingReference({
    required this.account,
    required this.asset,
  });

  factory AlgoRestTypesAssetHoldingReference.fromJson(
    Map<String, dynamic> json,
  ) {
    return AlgoRestTypesAssetHoldingReference(
      account: json.valueAsString(
        "account",
        bytesEncoding: StringEncoding.utf8,
        onMissing: () => '',
      ),
      asset: json.valueAsBigInt("asset", onMissing: () => BigInt.zero),
    );
  }

  Map<String, dynamic> toJson() {
    return {"account": account, "asset": asset}.notNullValue;
  }
}

/// AssetHoldingsResponse
class AlgoRestTypesAssetHoldingsResponse {
  /// Assets
  final List<AlgoRestTypesAssetHolding> assets;

  /// CurrentRound round at which the results were computed.
  final BigInt currentRound;

  /// NextToken used for pagination, when making another request provide this token with the next parameter.
  final String? nextToken;

  const AlgoRestTypesAssetHoldingsResponse({
    required this.assets,
    required this.currentRound,
    this.nextToken,
  });

  factory AlgoRestTypesAssetHoldingsResponse.fromJson(
    Map<String, dynamic> json,
  ) {
    return AlgoRestTypesAssetHoldingsResponse(
      assets: json.valueTo<List<AlgoRestTypesAssetHolding>, List>(
        key: "assets",
        onMissing: () => [],
        parse:
            (e) =>
                e
                    .map(
                      (x) => AlgoRestTypesAssetHolding.fromJson(
                        JsonParser.valueEnsureAsMap(x),
                      ),
                    )
                    .toList(),
      ),
      currentRound: json.valueAsBigInt(
        "current-round",
        onMissing: () => BigInt.zero,
      ),
      nextToken: json.valueAsString(
        "next-token",
        bytesEncoding: StringEncoding.utf8,
      ),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "assets": assets.map((e) => e.toJson()).toList(),
      "current-round": currentRound,
      "next-token": nextToken,
    }.notNullValue;
  }
}

/// AssetParams assetParams specifies the parameters for an asset. (apar) when part of an AssetConfig transaction. Definition: data/transactions/asset.go : AssetParams
class AlgoRestTypesAssetParams {
  /// Clawback address of account used to clawback holdings of this asset. If empty, clawback is not permitted.
  final String? clawback;

  /// Creator the address that created this asset. This is the address where the parameters for this asset can be found, and also the address where unwanted asset units can be sent in the worst case.
  final String creator;

  /// Decimals the number of digits to use after the decimal point when displaying this asset. If 0, the asset is not divisible. If 1, the base unit of the asset is in tenths. If 2, the base unit of the asset is in hundredths, and so on. This value must be between 0 and 19 (inclusive).
  final BigInt decimals;

  /// DefaultFrozen whether holdings of this asset are frozen by default.
  final bool? defaultFrozen;

  /// Freeze address of account used to freeze holdings of this asset. If empty, freezing is not permitted.
  final String? freeze;

  /// Manager address of account used to manage the keys of this asset and to destroy it.
  final String? manager;

  /// MetadataHash a commitment to some unspecified asset metadata. The format of this metadata is up to the application.
  final BuBytes? metadataHash;

  /// Name name of this asset, as supplied by the creator. Included only when the asset name is composed of printable utf-8 characters.
  final String? name;

  /// NameB64 base64 encoded name of this asset, as supplied by the creator.
  final BuBytes? nameB64;

  /// Reserve address of account holding reserve (non-minted) units of this asset.
  final String? reserve;

  /// Total the total number of units of this asset.
  final BigInt total;

  /// UnitName name of a unit of this asset, as supplied by the creator. Included only when the name of a unit of this asset is composed of printable utf-8 characters.
  final String? unitName;

  /// UnitNameB64 base64 encoded name of a unit of this asset, as supplied by the creator.
  final BuBytes? unitNameB64;

  /// Url uRL where more information about the asset can be retrieved. Included only when the URL is composed of printable utf-8 characters.
  final String? url;

  /// UrlB64 base64 encoded URL where more information about the asset can be retrieved.
  final BuBytes? urlB64;

  AlgoRestTypesAssetParams({
    this.clawback,
    required this.creator,
    required this.decimals,
    this.defaultFrozen,
    this.freeze,
    this.manager,
    List<int>? metadataHash,
    this.name,
    List<int>? nameB64,
    this.reserve,
    required this.total,
    this.unitName,
    List<int>? unitNameB64,
    this.url,
    List<int>? urlB64,
  }) : urlB64 = urlB64?.asImmutableBytes, unitNameB64 = unitNameB64?.asImmutableBytes, nameB64 = nameB64?.asImmutableBytes, metadataHash = metadataHash?.asImmutableBytes;

  factory AlgoRestTypesAssetParams.fromJson(Map<String, dynamic> json) {
    return AlgoRestTypesAssetParams(
      clawback: json.valueAsString(
        "clawback",
        bytesEncoding: StringEncoding.utf8,
      ),
      creator: json.valueAsString(
        "creator",
        bytesEncoding: StringEncoding.utf8,
        onMissing: () => '',
      ),
      decimals: json.valueAsBigInt("decimals", onMissing: () => BigInt.zero),
      defaultFrozen: json.valueAsBool("default-frozen"),
      freeze: json.valueAsString("freeze", bytesEncoding: StringEncoding.utf8),
      manager: json.valueAsString(
        "manager",
        bytesEncoding: StringEncoding.utf8,
      ),
      metadataHash: json.valueAsBytes(
        "metadata-hash",
        encoding: StringEncoding.base64,
      ),
      name: json.valueAsString("name", bytesEncoding: StringEncoding.utf8),
      nameB64: json.valueAsBytes("name-b64", encoding: StringEncoding.base64),
      reserve: json.valueAsString(
        "reserve",
        bytesEncoding: StringEncoding.utf8,
      ),
      total: json.valueAsBigInt("total", onMissing: () => BigInt.zero),
      unitName: json.valueAsString(
        "unit-name",
        bytesEncoding: StringEncoding.utf8,
      ),
      unitNameB64: json.valueAsBytes(
        "unit-name-b64",
        encoding: StringEncoding.base64,
      ),
      url: json.valueAsString("url", bytesEncoding: StringEncoding.utf8),
      urlB64: json.valueAsBytes("url-b64", encoding: StringEncoding.base64),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "clawback": clawback,
      "creator": creator,
      "decimals": decimals,
      "default-frozen": defaultFrozen,
      "freeze": freeze,
      "manager": manager,
      "metadata-hash": metadataHash,
      "name": name,
      "name-b64": nameB64,
      "reserve": reserve,
      "total": total,
      "unit-name": unitName,
      "unit-name-b64": unitNameB64,
      "url": url,
      "url-b64": urlB64,
    }.notNullValue;
  }
}

/// AssetResponse
class AlgoRestTypesAssetResponse {
  /// Asset specifies both the unique identifier and the parameters for an asset
  final AlgoRestTypesAsset asset;

  /// CurrentRound round at which the results were computed.
  final BigInt currentRound;

  const AlgoRestTypesAssetResponse({
    required this.asset,
    required this.currentRound,
  });

  factory AlgoRestTypesAssetResponse.fromJson(Map<String, dynamic> json) {
    return AlgoRestTypesAssetResponse(
      asset: json.valueTo<AlgoRestTypesAsset, Map>(
        key: "asset",
        parse:
            (e) => AlgoRestTypesAsset.fromJson(JsonParser.valueEnsureAsMap(e)),
      ),
      currentRound: json.valueAsBigInt(
        "current-round",
        onMissing: () => BigInt.zero,
      ),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "asset": asset.toJson(),
      "current-round": currentRound,
    }.notNullValue;
  }
}

/// AssetsResponse
class AlgoRestTypesAssetsResponse {
  /// Assets
  final List<AlgoRestTypesAsset> assets;

  /// CurrentRound round at which the results were computed.
  final BigInt currentRound;

  /// NextToken used for pagination, when making another request provide this token with the next parameter.
  final String? nextToken;

  const AlgoRestTypesAssetsResponse({
    required this.assets,
    required this.currentRound,
    this.nextToken,
  });

  factory AlgoRestTypesAssetsResponse.fromJson(Map<String, dynamic> json) {
    return AlgoRestTypesAssetsResponse(
      assets: json.valueTo<List<AlgoRestTypesAsset>, List>(
        key: "assets",
        onMissing: () => [],
        parse:
            (e) =>
                e
                    .map(
                      (x) => AlgoRestTypesAsset.fromJson(
                        JsonParser.valueEnsureAsMap(x),
                      ),
                    )
                    .toList(),
      ),
      currentRound: json.valueAsBigInt(
        "current-round",
        onMissing: () => BigInt.zero,
      ),
      nextToken: json.valueAsString(
        "next-token",
        bytesEncoding: StringEncoding.utf8,
      ),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "assets": assets.map((e) => e.toJson()).toList(),
      "current-round": currentRound,
      "next-token": nextToken,
    }.notNullValue;
  }
}

/// AvmKeyValue represents an AVM key-value pair in an application store.
class AlgoRestTypesAvmKeyValue {
  /// Key
  final BuBytes key;

  /// Value represents an AVM value.
  final AlgoRestTypesAvmValue value;

  AlgoRestTypesAvmKeyValue({required List<int> key, required this.value}) : key = key.asImmutableBytes;

  factory AlgoRestTypesAvmKeyValue.fromJson(Map<String, dynamic> json) {
    return AlgoRestTypesAvmKeyValue(
      key: json.valueAsBytes(
        "key",
        encoding: StringEncoding.base64,
        onMissing: () => [],
      ),
      value: json.valueTo<AlgoRestTypesAvmValue, Map>(
        key: "value",
        parse:
            (e) =>
                AlgoRestTypesAvmValue.fromJson(JsonParser.valueEnsureAsMap(e)),
      ),
    );
  }

  Map<String, dynamic> toJson() {
    return {"key": key, "value": value.toJson()}.notNullValue;
  }
}

/// AvmValue represents an AVM value.
class AlgoRestTypesAvmValue {
  /// Bytes bytes value.
  final BuBytes? bytes;

  /// Type value type. Value `1` refers to **bytes**, value `2` refers to **uint64**
  final BigInt type;

  /// Uint uint value.
  final BigInt? uint;

  AlgoRestTypesAvmValue({List<int>? bytes, required this.type, this.uint}) : bytes = bytes?.asImmutableBytes;

  factory AlgoRestTypesAvmValue.fromJson(Map<String, dynamic> json) {
    return AlgoRestTypesAvmValue(
      bytes: json.valueAsBytes("bytes", encoding: StringEncoding.base64),
      type: json.valueAsBigInt("type", onMissing: () => BigInt.zero),
      uint: json.valueAsBigInt("uint"),
    );
  }

  Map<String, dynamic> toJson() {
    return {"bytes": bytes, "type": type, "uint": uint}.notNullValue;
  }
}

/// Block block information. Definition: data/bookkeeping/block.go : Block
class AlgoRestTypesBlock {
  /// Bonus the potential bonus payout for this block.
  final BigInt? bonus;

  /// FeesCollected the sum of all fees paid by transactions in this block.
  final BigInt? feesCollected;

  /// GenesisHash (gh) hash to which this block belongs.
  final BuBytes genesisHash;

  /// GenesisId (gen) ID to which this block belongs.
  final String genesisId;

  /// ParticipationUpdates participation account data that needs to be checked/acted on by the network.
  final AlgoRestTypesParticipationUpdates? participationUpdates;

  /// PreviousBlockHash (prev) Previous block hash.
  final BuBytes previousBlockHash;

  /// PreviousBlockHash512 (prev512) Previous block hash, using SHA-512.
  final BuBytes? previousBlockHash512;

  /// Proposer the proposer of this block.
  final String? proposer;

  /// ProposerPayout the actual amount transferred to the proposer from the fee sink.
  final BigInt? proposerPayout;

  /// Rewards fields relating to rewards,
  final AlgoRestTypesBlockRewards? rewards;

  /// Round (rnd) Current round on which this block was appended to the chain.
  final BigInt round;

  /// Seed (seed) Sortition seed.
  final BuBytes seed;

  /// StateProofTracking tracks the status of state proofs.
  final List<AlgoRestTypesStateProofTracking>? stateProofTracking;

  /// Timestamp (ts) Block creation timestamp in seconds since eposh
  final BigInt timestamp;

  /// Transactions (txns) list of transactions corresponding to a given round.
  final List<AlgoRestTypesTransaction>? transactions;

  /// TransactionsRoot (txn) TransactionsRoot authenticates the set of transactions appearing in the block. More specifically, it's the root of a merkle tree whose leaves are the block's Txids, in lexicographic order. For the empty block, it's 0. Note that the TxnRoot does not authenticate the signatures on the transactions, only the transactions themselves. Two blocks with the same transactions but in a different order and with different signatures will have the same TxnRoot.
  final BuBytes transactionsRoot;

  /// TransactionsRootSha256 (txn256) TransactionsRootSHA256 is an auxiliary TransactionRoot, built using a vector commitment instead of a merkle tree, and SHA256 hash function instead of the default SHA512_256. This commitment can be used on environments where only the SHA256 function exists.
  final BuBytes transactionsRootSha256;

  /// TransactionsRootSha512 (txn512) TransactionsRootSHA512 is an auxiliary TransactionRoot, built using a vector commitment instead of a merkle tree, and SHA512 hash function instead of the default SHA512_256.
  final BuBytes? transactionsRootSha512;

  /// TxnCounter (tc) TxnCounter counts the number of transactions committed in the ledger, from the time at which support for this feature was introduced. Specifically, TxnCounter is the number of the next transaction that will be committed after this block. It is 0 when no transactions have ever been committed (since TxnCounter started being supported).
  final BigInt? txnCounter;

  /// UpgradeState fields relating to a protocol upgrade.
  final AlgoRestTypesBlockUpgradeState? upgradeState;

  /// UpgradeVote fields relating to voting for a protocol upgrade.
  final AlgoRestTypesBlockUpgradeVote? upgradeVote;

  AlgoRestTypesBlock({
    this.bonus,
    this.feesCollected,
    required List<int> genesisHash,
    required this.genesisId,
    this.participationUpdates,
    required List<int> previousBlockHash,
    List<int>? previousBlockHash512,
    this.proposer,
    this.proposerPayout,
    this.rewards,
    required this.round,
    required List<int> seed,
    this.stateProofTracking,
    required this.timestamp,
    this.transactions,
    required List<int> transactionsRoot,
    required List<int> transactionsRootSha256,
    List<int>? transactionsRootSha512,
    this.txnCounter,
    this.upgradeState,
    this.upgradeVote,
  }) : genesisHash = genesisHash.asImmutableBytes, transactionsRootSha512 = transactionsRootSha512?.asImmutableBytes, transactionsRootSha256 = transactionsRootSha256.asImmutableBytes, transactionsRoot = transactionsRoot.asImmutableBytes, seed = seed.asImmutableBytes, previousBlockHash512 = previousBlockHash512?.asImmutableBytes, previousBlockHash = previousBlockHash.asImmutableBytes;

  factory AlgoRestTypesBlock.fromJson(Map<String, dynamic> json) {
    return AlgoRestTypesBlock(
      bonus: json.valueAsBigInt("bonus"),
      feesCollected: json.valueAsBigInt("fees-collected"),
      genesisHash: json.valueAsBytes(
        "genesis-hash",
        encoding: StringEncoding.base64,
        onMissing: () => [],
      ),
      genesisId: json.valueAsString(
        "genesis-id",
        bytesEncoding: StringEncoding.utf8,
        onMissing: () => '',
      ),
      participationUpdates: json
          .valueTo<AlgoRestTypesParticipationUpdates?, Map>(
            key: "participation-updates",
            parse:
                (e) => AlgoRestTypesParticipationUpdates.fromJson(
                  JsonParser.valueEnsureAsMap(e),
                ),
          ),
      previousBlockHash: json.valueAsBytes(
        "previous-block-hash",
        encoding: StringEncoding.base64,
        onMissing: () => [],
      ),
      previousBlockHash512: json.valueAsBytes(
        "previous-block-hash-512",
        encoding: StringEncoding.base64,
      ),
      proposer: json.valueAsString(
        "proposer",
        bytesEncoding: StringEncoding.utf8,
      ),
      proposerPayout: json.valueAsBigInt("proposer-payout"),
      rewards: json.valueTo<AlgoRestTypesBlockRewards?, Map>(
        key: "rewards",
        parse:
            (e) => AlgoRestTypesBlockRewards.fromJson(
              JsonParser.valueEnsureAsMap(e),
            ),
      ),
      round: json.valueAsBigInt("round", onMissing: () => BigInt.zero),
      seed: json.valueAsBytes(
        "seed",
        encoding: StringEncoding.base64,
        onMissing: () => [],
      ),
      stateProofTracking: json
          .valueTo<List<AlgoRestTypesStateProofTracking>?, List>(
            key: "state-proof-tracking",
            parse:
                (e) =>
                    e
                        .map(
                          (x) => AlgoRestTypesStateProofTracking.fromJson(
                            JsonParser.valueEnsureAsMap(x),
                          ),
                        )
                        .toList(),
          ),
      timestamp: json.valueAsBigInt("timestamp", onMissing: () => BigInt.zero),
      transactions: json.valueTo<List<AlgoRestTypesTransaction>?, List>(
        key: "transactions",
        parse:
            (e) =>
                e
                    .map(
                      (x) => AlgoRestTypesTransaction.fromJson(
                        JsonParser.valueEnsureAsMap(x),
                      ),
                    )
                    .toList(),
      ),
      transactionsRoot: json.valueAsBytes(
        "transactions-root",
        encoding: StringEncoding.base64,
        onMissing: () => [],
      ),
      transactionsRootSha256: json.valueAsBytes(
        "transactions-root-sha256",
        encoding: StringEncoding.base64,
        onMissing: () => [],
      ),
      transactionsRootSha512: json.valueAsBytes(
        "transactions-root-sha512",
        encoding: StringEncoding.base64,
      ),
      txnCounter: json.valueAsBigInt("txn-counter"),
      upgradeState: json.valueTo<AlgoRestTypesBlockUpgradeState?, Map>(
        key: "upgrade-state",
        parse:
            (e) => AlgoRestTypesBlockUpgradeState.fromJson(
              JsonParser.valueEnsureAsMap(e),
            ),
      ),
      upgradeVote: json.valueTo<AlgoRestTypesBlockUpgradeVote?, Map>(
        key: "upgrade-vote",
        parse:
            (e) => AlgoRestTypesBlockUpgradeVote.fromJson(
              JsonParser.valueEnsureAsMap(e),
            ),
      ),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "bonus": bonus,
      "fees-collected": feesCollected,
      "genesis-hash": genesisHash,
      "genesis-id": genesisId,
      "participation-updates": participationUpdates?.toJson(),
      "previous-block-hash": previousBlockHash,
      "previous-block-hash-512": previousBlockHash512,
      "proposer": proposer,
      "proposer-payout": proposerPayout,
      "rewards": rewards?.toJson(),
      "round": round,
      "seed": seed,
      "state-proof-tracking":
          stateProofTracking?.map((e) => e.toJson()).toList(),
      "timestamp": timestamp,
      "transactions": transactions?.map((e) => e.toJson()).toList(),
      "transactions-root": transactionsRoot,
      "transactions-root-sha256": transactionsRootSha256,
      "transactions-root-sha512": transactionsRootSha512,
      "txn-counter": txnCounter,
      "upgrade-state": upgradeState?.toJson(),
      "upgrade-vote": upgradeVote?.toJson(),
    }.notNullValue;
  }
}

/// BlockHashResponse hash of a block header.
class AlgoRestTypesBlockHashResponse {
  /// Blockhash block header hash.
  final String blockhash;

  const AlgoRestTypesBlockHashResponse({required this.blockhash});

  factory AlgoRestTypesBlockHashResponse.fromJson(Map<String, dynamic> json) {
    return AlgoRestTypesBlockHashResponse(
      blockhash: json.valueAsString(
        "blockHash",
        bytesEncoding: StringEncoding.utf8,
        onMissing: () => '',
      ),
    );
  }

  Map<String, dynamic> toJson() {
    return {"blockHash": blockhash}.notNullValue;
  }
}

/// BlockHeadersResponse
class AlgoRestTypesBlockHeadersResponse {
  /// Blocks
  final List<AlgoRestTypesBlock> blocks;

  /// CurrentRound round at which the results were computed.
  final BigInt currentRound;

  /// NextToken used for pagination, when making another request provide this token with the next parameter.
  final String? nextToken;

  const AlgoRestTypesBlockHeadersResponse({
    required this.blocks,
    required this.currentRound,
    this.nextToken,
  });

  factory AlgoRestTypesBlockHeadersResponse.fromJson(
    Map<String, dynamic> json,
  ) {
    return AlgoRestTypesBlockHeadersResponse(
      blocks: json.valueTo<List<AlgoRestTypesBlock>, List>(
        key: "blocks",
        onMissing: () => [],
        parse:
            (e) =>
                e
                    .map(
                      (x) => AlgoRestTypesBlock.fromJson(
                        JsonParser.valueEnsureAsMap(x),
                      ),
                    )
                    .toList(),
      ),
      currentRound: json.valueAsBigInt(
        "current-round",
        onMissing: () => BigInt.zero,
      ),
      nextToken: json.valueAsString(
        "next-token",
        bytesEncoding: StringEncoding.utf8,
      ),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "blocks": blocks.map((e) => e.toJson()).toList(),
      "current-round": currentRound,
      "next-token": nextToken,
    }.notNullValue;
  }
}

/// BlockLogsResponse all logs emitted in the given round. Each app call, whether top-level or inner, that contains logs results in a separate AppCallLogs object. Therefore there may be multiple AppCallLogs with the same application ID and outer transaction ID in the event of multiple inner app calls to the same app. App calls with no logs are not included in the response. AppCallLogs are returned in the same order that their corresponding app call appeared in the block (pre-order traversal of inner app calls)
class AlgoRestTypesBlockLogsResponse {
  /// Logs
  final List<AlgoRestTypesAppCallLogs> logs;

  AlgoRestTypesBlockLogsResponse({required this.logs}) ;

  factory AlgoRestTypesBlockLogsResponse.fromJson(Map<String, dynamic> json) {
    return AlgoRestTypesBlockLogsResponse(
      logs: json.valueTo<List<AlgoRestTypesAppCallLogs>, List>(
        key: "logs",
        onMissing: () => [],
        parse:
            (e) =>
                e
                    .map(
                      (x) => AlgoRestTypesAppCallLogs.fromJson(
                        JsonParser.valueEnsureAsMap(x),
                      ),
                    )
                    .toList(),
      ),
    );
  }

  Map<String, dynamic> toJson() {
    return {"logs": logs.map((e) => e.toJson()).toList()}.notNullValue;
  }
}

/// BlockRewards fields relating to rewards,
class AlgoRestTypesBlockRewards {
  /// FeeSink (fees) accepts transaction fees, it can only spend to the incentive pool.
  final String feeSink;

  /// RewardsCalculationRound (rwcalr) number of leftover MicroAlgos after the distribution of rewards-rate MicroAlgos for every reward unit in the next round.
  final BigInt rewardsCalculationRound;

  /// RewardsLevel (earn) How many rewards, in MicroAlgos, have been distributed to each RewardUnit of MicroAlgos since genesis.
  final BigInt rewardsLevel;

  /// RewardsPool (rwd) accepts periodic injections from the fee-sink and continually redistributes them as rewards.
  final String rewardsPool;

  /// RewardsRate (rate) Number of new MicroAlgos added to the participation stake from rewards at the next round.
  final BigInt rewardsRate;

  /// RewardsResidue (frac) Number of leftover MicroAlgos after the distribution of RewardsRate/rewardUnits MicroAlgos for every reward unit in the next round.
  final BigInt rewardsResidue;

  const AlgoRestTypesBlockRewards({
    required this.feeSink,
    required this.rewardsCalculationRound,
    required this.rewardsLevel,
    required this.rewardsPool,
    required this.rewardsRate,
    required this.rewardsResidue,
  });

  factory AlgoRestTypesBlockRewards.fromJson(Map<String, dynamic> json) {
    return AlgoRestTypesBlockRewards(
      feeSink: json.valueAsString(
        "fee-sink",
        bytesEncoding: StringEncoding.utf8,
        onMissing: () => '',
      ),
      rewardsCalculationRound: json.valueAsBigInt(
        "rewards-calculation-round",
        onMissing: () => BigInt.zero,
      ),
      rewardsLevel: json.valueAsBigInt(
        "rewards-level",
        onMissing: () => BigInt.zero,
      ),
      rewardsPool: json.valueAsString(
        "rewards-pool",
        bytesEncoding: StringEncoding.utf8,
        onMissing: () => '',
      ),
      rewardsRate: json.valueAsBigInt(
        "rewards-rate",
        onMissing: () => BigInt.zero,
      ),
      rewardsResidue: json.valueAsBigInt(
        "rewards-residue",
        onMissing: () => BigInt.zero,
      ),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "fee-sink": feeSink,
      "rewards-calculation-round": rewardsCalculationRound,
      "rewards-level": rewardsLevel,
      "rewards-pool": rewardsPool,
      "rewards-rate": rewardsRate,
      "rewards-residue": rewardsResidue,
    }.notNullValue;
  }
}

/// BlockTxidsResponse top level transaction IDs in a block.
class AlgoRestTypesBlockTxidsResponse {
  /// Blocktxids block transaction IDs.
  final List<String> blocktxids;

  const AlgoRestTypesBlockTxidsResponse({required this.blocktxids});

  factory AlgoRestTypesBlockTxidsResponse.fromJson(Map<String, dynamic> json) {
    return AlgoRestTypesBlockTxidsResponse(
      blocktxids: json.valueEnsureAsList<String>(
        "blockTxids",
        onMissing: () => [],
      ),
    );
  }

  Map<String, dynamic> toJson() {
    return {"blockTxids": blocktxids}.notNullValue;
  }
}

/// BlockUpgradeState fields relating to a protocol upgrade.
class AlgoRestTypesBlockUpgradeState {
  /// CurrentProtocol (proto) The current protocol version.
  final String currentProtocol;

  /// NextProtocol (nextproto) The next proposed protocol version.
  final String? nextProtocol;

  /// NextProtocolApprovals (nextyes) Number of blocks which approved the protocol upgrade.
  final BigInt? nextProtocolApprovals;

  /// NextProtocolSwitchOn (nextswitch) Round on which the protocol upgrade will take effect.
  final BigInt? nextProtocolSwitchOn;

  /// NextProtocolVoteBefore (nextbefore) Deadline round for this protocol upgrade (No votes will be consider after this round).
  final BigInt? nextProtocolVoteBefore;

  const AlgoRestTypesBlockUpgradeState({
    required this.currentProtocol,
    this.nextProtocol,
    this.nextProtocolApprovals,
    this.nextProtocolSwitchOn,
    this.nextProtocolVoteBefore,
  });

  factory AlgoRestTypesBlockUpgradeState.fromJson(Map<String, dynamic> json) {
    return AlgoRestTypesBlockUpgradeState(
      currentProtocol: json.valueAsString(
        "current-protocol",
        bytesEncoding: StringEncoding.utf8,
        onMissing: () => '',
      ),
      nextProtocol: json.valueAsString(
        "next-protocol",
        bytesEncoding: StringEncoding.utf8,
      ),
      nextProtocolApprovals: json.valueAsBigInt("next-protocol-approvals"),
      nextProtocolSwitchOn: json.valueAsBigInt("next-protocol-switch-on"),
      nextProtocolVoteBefore: json.valueAsBigInt("next-protocol-vote-before"),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "current-protocol": currentProtocol,
      "next-protocol": nextProtocol,
      "next-protocol-approvals": nextProtocolApprovals,
      "next-protocol-switch-on": nextProtocolSwitchOn,
      "next-protocol-vote-before": nextProtocolVoteBefore,
    }.notNullValue;
  }
}

/// BlockUpgradeVote fields relating to voting for a protocol upgrade.
class AlgoRestTypesBlockUpgradeVote {
  /// UpgradeApprove (upgradeyes) Indicates a yes vote for the current proposal.
  final bool? upgradeApprove;

  /// UpgradeDelay (upgradedelay) Indicates the time between acceptance and execution.
  final BigInt? upgradeDelay;

  /// UpgradePropose (upgradeprop) Indicates a proposed upgrade.
  final String? upgradePropose;

  const AlgoRestTypesBlockUpgradeVote({
    this.upgradeApprove,
    this.upgradeDelay,
    this.upgradePropose,
  });

  factory AlgoRestTypesBlockUpgradeVote.fromJson(Map<String, dynamic> json) {
    return AlgoRestTypesBlockUpgradeVote(
      upgradeApprove: json.valueAsBool("upgrade-approve"),
      upgradeDelay: json.valueAsBigInt("upgrade-delay"),
      upgradePropose: json.valueAsString(
        "upgrade-propose",
        bytesEncoding: StringEncoding.utf8,
      ),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "upgrade-approve": upgradeApprove,
      "upgrade-delay": upgradeDelay,
      "upgrade-propose": upgradePropose,
    }.notNullValue;
  }
}

/// Box box name and its content.
class AlgoRestTypesBox {
  /// Name (name) box name, base64 encoded
  final BuBytes name;

  /// Round the round for which this information is relevant
  final BigInt round;

  /// Value (value) box value, base64 encoded.
  final BuBytes value;

  AlgoRestTypesBox({
    required List<int> name,
    required this.round,
    required List<int> value,
  }) : name = name.asImmutableBytes, value = value.asImmutableBytes;

  factory AlgoRestTypesBox.fromJson(Map<String, dynamic> json) {
    return AlgoRestTypesBox(
      name: json.valueAsBytes(
        "name",
        encoding: StringEncoding.base64,
        onMissing: () => [],
      ),
      round: json.valueAsBigInt("round", onMissing: () => BigInt.zero),
      value: json.valueAsBytes(
        "value",
        encoding: StringEncoding.base64,
        onMissing: () => [],
      ),
    );
  }

  Map<String, dynamic> toJson() {
    return {"name": name, "round": round, "value": value}.notNullValue;
  }
}

/// BoxDescriptor box descriptor describes an app box.
class AlgoRestTypesBoxDescriptor {
  /// Name base64 encoded box name
  final BuBytes name;

  /// Value base64 encoded box value. Present only when the `values` query parameter is set to true.
  final BuBytes? value;

  AlgoRestTypesBoxDescriptor({required List<int> name, List<int>? value}) : name = name.asImmutableBytes, value = value?.asImmutableBytes;

  factory AlgoRestTypesBoxDescriptor.fromJson(Map<String, dynamic> json) {
    return AlgoRestTypesBoxDescriptor(
      name: json.valueAsBytes(
        "name",
        encoding: StringEncoding.base64,
        onMissing: () => [],
      ),
      value: json.valueAsBytes("value", encoding: StringEncoding.base64),
    );
  }

  Map<String, dynamic> toJson() {
    return {"name": name, "value": value}.notNullValue;
  }
}

/// BoxReference boxReference names a box by its name and the application ID it belongs to.
class AlgoRestTypesBoxReference {
  /// App application ID to which the box belongs, or zero if referring to the called application.
  final BigInt app;

  /// Name base64 encoded box name
  final BuBytes name;

  AlgoRestTypesBoxReference({required this.app, required List<int> name}) : name = name.asImmutableBytes;

  factory AlgoRestTypesBoxReference.fromJson(Map<String, dynamic> json) {
    return AlgoRestTypesBoxReference(
      app: json.valueAsBigInt("app", onMissing: () => BigInt.zero),
      name: json.valueAsBytes(
        "name",
        encoding: StringEncoding.base64,
        onMissing: () => [],
      ),
    );
  }

  Map<String, dynamic> toJson() {
    return {"app": app, "name": name}.notNullValue;
  }
}

/// BoxesResponse box names of an application
class AlgoRestTypesBoxesResponse {
  /// ApplicationId (appidx) application index.
  final BigInt applicationId;

  /// Boxes
  final List<AlgoRestTypesBoxDescriptor> boxes;

  /// NextToken used for pagination, when making another request provide this token with the next parameter.
  final String? nextToken;

  /// Round the round for which this information is relevant.
  final BigInt? round;

  const AlgoRestTypesBoxesResponse({
    required this.applicationId,
    required this.boxes,
    this.nextToken,
    this.round,
  });

  factory AlgoRestTypesBoxesResponse.fromJson(Map<String, dynamic> json) {
    return AlgoRestTypesBoxesResponse(
      applicationId: json.valueAsBigInt(
        "application-id",
        onMissing: () => BigInt.zero,
      ),
      boxes: json.valueTo<List<AlgoRestTypesBoxDescriptor>, List>(
        key: "boxes",
        onMissing: () => [],
        parse:
            (e) =>
                e
                    .map(
                      (x) => AlgoRestTypesBoxDescriptor.fromJson(
                        JsonParser.valueEnsureAsMap(x),
                      ),
                    )
                    .toList(),
      ),
      nextToken: json.valueAsString(
        "next-token",
        bytesEncoding: StringEncoding.utf8,
      ),
      round: json.valueAsBigInt("round"),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "application-id": applicationId,
      "boxes": boxes.map((e) => e.toJson()).toList(),
      "next-token": nextToken,
      "round": round,
    }.notNullValue;
  }
}

/// BuildVersion defines a model for BuildVersion.
class AlgoRestTypesBuildVersion {
  /// Branch
  final String branch;

  /// BuildNumber
  final BigInt buildNumber;

  /// Channel
  final String channel;

  /// CommitHash
  final String commitHash;

  /// Major
  final BigInt major;

  /// Minor
  final BigInt minor;

  const AlgoRestTypesBuildVersion({
    required this.branch,
    required this.buildNumber,
    required this.channel,
    required this.commitHash,
    required this.major,
    required this.minor,
  });

  factory AlgoRestTypesBuildVersion.fromJson(Map<String, dynamic> json) {
    return AlgoRestTypesBuildVersion(
      branch: json.valueAsString(
        "branch",
        bytesEncoding: StringEncoding.utf8,
        onMissing: () => '',
      ),
      buildNumber: json.valueAsBigInt(
        "build_number",
        onMissing: () => BigInt.zero,
      ),
      channel: json.valueAsString(
        "channel",
        bytesEncoding: StringEncoding.utf8,
        onMissing: () => '',
      ),
      commitHash: json.valueAsString(
        "commit_hash",
        bytesEncoding: StringEncoding.utf8,
        onMissing: () => '',
      ),
      major: json.valueAsBigInt("major", onMissing: () => BigInt.zero),
      minor: json.valueAsBigInt("minor", onMissing: () => BigInt.zero),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "branch": branch,
      "build_number": buildNumber,
      "channel": channel,
      "commit_hash": commitHash,
      "major": major,
      "minor": minor,
    }.notNullValue;
  }
}

/// CompileResponse teal compile Result
class AlgoRestTypesCompileResponse {
  /// Hash base32 SHA512_256 of program bytes (Address style)
  final String hash;

  /// Result base64 encoded program bytes
  final String result;

  /// Sourcemap jSON of the source map
  final Map<String, dynamic>? sourcemap;

  const AlgoRestTypesCompileResponse({
    required this.hash,
    required this.result,
    this.sourcemap,
  });

  factory AlgoRestTypesCompileResponse.fromJson(Map<String, dynamic> json) {
    return AlgoRestTypesCompileResponse(
      hash: json.valueAsString(
        "hash",
        bytesEncoding: StringEncoding.utf8,
        onMissing: () => '',
      ),
      result: json.valueAsString(
        "result",
        bytesEncoding: StringEncoding.utf8,
        onMissing: () => '',
      ),
      sourcemap: json.valueAsMap<Map<String, dynamic>?>("sourcemap"),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "hash": hash,
      "result": result,
      "sourcemap": sourcemap,
    }.notNullValue;
  }
}

/// DisassembleResponse teal disassembly Result
class AlgoRestTypesDisassembleResponse {
  /// Result disassembled Teal code
  final String result;

  const AlgoRestTypesDisassembleResponse({required this.result});

  factory AlgoRestTypesDisassembleResponse.fromJson(Map<String, dynamic> json) {
    return AlgoRestTypesDisassembleResponse(
      result: json.valueAsString(
        "result",
        bytesEncoding: StringEncoding.utf8,
        onMissing: () => '',
      ),
    );
  }

  Map<String, dynamic> toJson() {
    return {"result": result}.notNullValue;
  }
}

/// ErrorResponse response for errors
class AlgoRestTypesErrorResponse {
  /// Data
  final Map<String, dynamic>? data;

  /// Message
  final String message;

  const AlgoRestTypesErrorResponse({this.data, required this.message});

  factory AlgoRestTypesErrorResponse.fromJson(Map<String, dynamic> json) {
    return AlgoRestTypesErrorResponse(
      data: json.valueAsMap<Map<String, dynamic>?>("data"),
      message: json.valueAsString(
        "message",
        bytesEncoding: StringEncoding.utf8,
        onMissing: () => '',
      ),
    );
  }

  Map<String, dynamic> toJson() {
    return {"data": data, "message": message}.notNullValue;
  }
}

/// EvalDelta represents a TEAL value delta.
class AlgoRestTypesEvalDelta {
  /// Action (at) delta action.
  final BigInt action;

  /// Bytes (bs) bytes value.
  final String? bytes;

  /// Uint (ui) uint value.
  final BigInt? uint;

  AlgoRestTypesEvalDelta({required this.action, this.bytes, this.uint}) ;

  factory AlgoRestTypesEvalDelta.fromJson(Map<String, dynamic> json) {
    return AlgoRestTypesEvalDelta(
      action: json.valueAsBigInt("action", onMissing: () => BigInt.zero),
      bytes: json.valueAsString("bytes", bytesEncoding: StringEncoding.utf8),
      uint: json.valueAsBigInt("uint"),
    );
  }

  Map<String, dynamic> toJson() {
    return {"action": action, "bytes": bytes, "uint": uint}.notNullValue;
  }
}

/// EvalDeltaKeyValue key-value pairs for StateDelta.
class AlgoRestTypesEvalDeltaKeyValue {
  /// Key
  final String key;

  /// Value represents a TEAL value delta.
  final AlgoRestTypesEvalDelta value;

  AlgoRestTypesEvalDeltaKeyValue({
    required this.key,
    required this.value,
  }) ;

  factory AlgoRestTypesEvalDeltaKeyValue.fromJson(Map<String, dynamic> json) {
    return AlgoRestTypesEvalDeltaKeyValue(
      key: json.valueAsString(
        "key",
        bytesEncoding: StringEncoding.utf8,
        onMissing: () => '',
      ),
      value: json.valueTo<AlgoRestTypesEvalDelta, Map>(
        key: "value",
        parse:
            (e) =>
                AlgoRestTypesEvalDelta.fromJson(JsonParser.valueEnsureAsMap(e)),
      ),
    );
  }

  Map<String, dynamic> toJson() {
    return {"key": key, "value": value.toJson()}.notNullValue;
  }
}

/// Genesis defines a model for Genesis.
class AlgoRestTypesGenesis {
  /// Alloc
  final List<AlgoRestTypesGenesisAllocation> alloc;

  /// Comment
  final String? comment;

  /// Devmode
  final bool? devmode;

  /// Fees
  final String fees;

  /// Id
  final String id;

  /// Network
  final String network;

  /// Proto
  final String proto;

  /// Rwd
  final String rwd;

  /// Timestamp
  final BigInt timestamp;

  const AlgoRestTypesGenesis({
    required this.alloc,
    this.comment,
    this.devmode,
    required this.fees,
    required this.id,
    required this.network,
    required this.proto,
    required this.rwd,
    required this.timestamp,
  });

  factory AlgoRestTypesGenesis.fromJson(Map<String, dynamic> json) {
    return AlgoRestTypesGenesis(
      alloc: json.valueTo<List<AlgoRestTypesGenesisAllocation>, List>(
        key: "alloc",
        onMissing: () => [],
        parse:
            (e) =>
                e
                    .map(
                      (x) => AlgoRestTypesGenesisAllocation.fromJson(
                        JsonParser.valueEnsureAsMap(x),
                      ),
                    )
                    .toList(),
      ),
      comment: json.valueAsString(
        "comment",
        bytesEncoding: StringEncoding.utf8,
      ),
      devmode: json.valueAsBool("devmode"),
      fees: json.valueAsString(
        "fees",
        bytesEncoding: StringEncoding.utf8,
        onMissing: () => '',
      ),
      id: json.valueAsString(
        "id",
        bytesEncoding: StringEncoding.utf8,
        onMissing: () => '',
      ),
      network: json.valueAsString(
        "network",
        bytesEncoding: StringEncoding.utf8,
        onMissing: () => '',
      ),
      proto: json.valueAsString(
        "proto",
        bytesEncoding: StringEncoding.utf8,
        onMissing: () => '',
      ),
      rwd: json.valueAsString(
        "rwd",
        bytesEncoding: StringEncoding.utf8,
        onMissing: () => '',
      ),
      timestamp: json.valueAsBigInt("timestamp", onMissing: () => BigInt.zero),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "alloc": alloc.map((e) => e.toJson()).toList(),
      "comment": comment,
      "devmode": devmode,
      "fees": fees,
      "id": id,
      "network": network,
      "proto": proto,
      "rwd": rwd,
      "timestamp": timestamp,
    }.notNullValue;
  }
}

/// GenesisAllocation defines a model for GenesisAllocation.
class AlgoRestTypesGenesisAllocation {
  /// Addr
  final String addr;

  /// Comment
  final String comment;

  /// State
  final Map<String, dynamic>? state;

  const AlgoRestTypesGenesisAllocation({
    required this.addr,
    required this.comment,
    this.state,
  });

  factory AlgoRestTypesGenesisAllocation.fromJson(Map<String, dynamic> json) {
    return AlgoRestTypesGenesisAllocation(
      addr: json.valueAsString(
        "addr",
        bytesEncoding: StringEncoding.utf8,
        onMissing: () => '',
      ),
      comment: json.valueAsString(
        "comment",
        bytesEncoding: StringEncoding.utf8,
        onMissing: () => '',
      ),
      state: json.valueAsMap<Map<String, dynamic>?>("state"),
    );
  }

  Map<String, dynamic> toJson() {
    return {"addr": addr, "comment": comment, "state": state}.notNullValue;
  }
}

/// GetBlockTimeStampOffsetResponse response containing the timestamp offset in seconds
class AlgoRestTypesGetBlockTimeStampOffsetResponse {
  /// Offset timestamp offset in seconds.
  final BigInt offset;

  const AlgoRestTypesGetBlockTimeStampOffsetResponse({required this.offset});

  factory AlgoRestTypesGetBlockTimeStampOffsetResponse.fromJson(
    Map<String, dynamic> json,
  ) {
    return AlgoRestTypesGetBlockTimeStampOffsetResponse(
      offset: json.valueAsBigInt("offset", onMissing: () => BigInt.zero),
    );
  }

  Map<String, dynamic> toJson() {
    return {"offset": offset}.notNullValue;
  }
}

/// GetSyncRoundResponse response containing the ledger's minimum sync round
class AlgoRestTypesGetSyncRoundResponse {
  /// Round the minimum sync round for the ledger.
  final BigInt round;

  const AlgoRestTypesGetSyncRoundResponse({required this.round});

  factory AlgoRestTypesGetSyncRoundResponse.fromJson(
    Map<String, dynamic> json,
  ) {
    return AlgoRestTypesGetSyncRoundResponse(
      round: json.valueAsBigInt("round", onMissing: () => BigInt.zero),
    );
  }

  Map<String, dynamic> toJson() {
    return {"round": round}.notNullValue;
  }
}

/// HashFactory defines a model for HashFactory.
class AlgoRestTypesHashFactory {
  /// HashType (t)
  final BigInt? hashType;

  const AlgoRestTypesHashFactory({this.hashType});

  factory AlgoRestTypesHashFactory.fromJson(Map<String, dynamic> json) {
    return AlgoRestTypesHashFactory(hashType: json.valueAsBigInt("hash-type"));
  }

  Map<String, dynamic> toJson() {
    return {"hash-type": hashType}.notNullValue;
  }
}

/// HbProofFields (hbprf) HbProof is a signature using HeartbeatAddress's partkey, thereby showing it is online.
class AlgoRestTypesHbProofFields {
  /// HbPk (p) Public key of the heartbeat message.
  final BuBytes? hbPk;

  /// HbPk1sig (p1s) Signature of OneTimeSignatureSubkeyOffsetID(PK, Batch, Offset) under the key PK2.
  final BuBytes? hbPk1sig;

  /// HbPk2 (p2) Key for new-style two-level ephemeral signature.
  final BuBytes? hbPk2;

  /// HbPk2sig (p2s) Signature of OneTimeSignatureSubkeyBatchID(PK2, Batch) under the master key (OneTimeSignatureVerifier).
  final BuBytes? hbPk2sig;

  /// HbSig (s) Signature of the heartbeat message.
  final BuBytes? hbSig;

  AlgoRestTypesHbProofFields({
    List<int>? hbPk,
    List<int>? hbPk1sig,
    List<int>? hbPk2,
    List<int>? hbPk2sig,
    List<int>? hbSig,
  }) : hbSig = hbSig?.asImmutableBytes, hbPk2sig = hbPk2sig?.asImmutableBytes, hbPk2 = hbPk2?.asImmutableBytes, hbPk1sig = hbPk1sig?.asImmutableBytes, hbPk = hbPk?.asImmutableBytes;

  factory AlgoRestTypesHbProofFields.fromJson(Map<String, dynamic> json) {
    return AlgoRestTypesHbProofFields(
      hbPk: json.valueAsBytes("hb-pk", encoding: StringEncoding.base64),
      hbPk1sig: json.valueAsBytes("hb-pk1sig", encoding: StringEncoding.base64),
      hbPk2: json.valueAsBytes("hb-pk2", encoding: StringEncoding.base64),
      hbPk2sig: json.valueAsBytes("hb-pk2sig", encoding: StringEncoding.base64),
      hbSig: json.valueAsBytes("hb-sig", encoding: StringEncoding.base64),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "hb-pk": hbPk,
      "hb-pk1sig": hbPk1sig,
      "hb-pk2": hbPk2,
      "hb-pk2sig": hbPk2sig,
      "hb-sig": hbSig,
    }.notNullValue;
  }
}

/// HealthCheck a health check response.
class AlgoRestTypesHealthCheck {
  /// Data
  final Map<String, dynamic>? data;

  /// DbAvailable
  final bool dbAvailable;

  /// Errors
  final List<String>? errors;

  /// IsMigrating
  final bool isMigrating;

  /// Message
  final String message;

  /// Round
  final BigInt round;

  /// Version current version.
  final String version;

  const AlgoRestTypesHealthCheck({
    this.data,
    required this.dbAvailable,
    this.errors,
    required this.isMigrating,
    required this.message,
    required this.round,
    required this.version,
  });

  factory AlgoRestTypesHealthCheck.fromJson(Map<String, dynamic> json) {
    return AlgoRestTypesHealthCheck(
      data: json.valueAsMap<Map<String, dynamic>?>("data"),
      dbAvailable: json.valueAsBool("db-available", onMissing: () => false),
      errors: json.valueAsList<List<String>?>("errors"),
      isMigrating: json.valueAsBool("is-migrating", onMissing: () => false),
      message: json.valueAsString(
        "message",
        bytesEncoding: StringEncoding.utf8,
        onMissing: () => '',
      ),
      round: json.valueAsBigInt("round", onMissing: () => BigInt.zero),
      version: json.valueAsString(
        "version",
        bytesEncoding: StringEncoding.utf8,
        onMissing: () => '',
      ),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "data": data,
      "db-available": dbAvailable,
      "errors": errors,
      "is-migrating": isMigrating,
      "message": message,
      "round": round,
      "version": version,
    }.notNullValue;
  }
}

/// HoldingRef holdingRef names a holding by referring to an Address and Asset it belongs to.
class AlgoRestTypesHoldingRef {
  /// Address (d) Address in access list, or the sender of the transaction.
  final String address;

  /// Asset (s) Asset ID for asset in access list.
  final BigInt asset;

  const AlgoRestTypesHoldingRef({required this.address, required this.asset});

  factory AlgoRestTypesHoldingRef.fromJson(Map<String, dynamic> json) {
    return AlgoRestTypesHoldingRef(
      address: json.valueAsString(
        "address",
        bytesEncoding: StringEncoding.utf8,
        onMissing: () => '',
      ),
      asset: json.valueAsBigInt("asset", onMissing: () => BigInt.zero),
    );
  }

  Map<String, dynamic> toJson() {
    return {"address": address, "asset": asset}.notNullValue;
  }
}

/// IndexerStateProofMessage defines a model for IndexerStateProofMessage.
class AlgoRestTypesIndexerStateProofMessage {
  /// BlockHeadersCommitment (b)
  final BuBytes? blockHeadersCommitment;

  /// FirstAttestedRound (f)
  final BigInt? firstAttestedRound;

  /// LatestAttestedRound (l)
  final BigInt? latestAttestedRound;

  /// LnProvenWeight (P)
  final BigInt? lnProvenWeight;

  /// VotersCommitment (v)
  final BuBytes? votersCommitment;

  AlgoRestTypesIndexerStateProofMessage({
    List<int>? blockHeadersCommitment,
    this.firstAttestedRound,
    this.latestAttestedRound,
    this.lnProvenWeight,
    List<int>? votersCommitment,
  }) : votersCommitment = votersCommitment?.asImmutableBytes, blockHeadersCommitment = blockHeadersCommitment?.asImmutableBytes;

  factory AlgoRestTypesIndexerStateProofMessage.fromJson(
    Map<String, dynamic> json,
  ) {
    return AlgoRestTypesIndexerStateProofMessage(
      blockHeadersCommitment: json.valueAsBytes(
        "block-headers-commitment",
        encoding: StringEncoding.base64,
      ),
      firstAttestedRound: json.valueAsBigInt("first-attested-round"),
      latestAttestedRound: json.valueAsBigInt("latest-attested-round"),
      lnProvenWeight: json.valueAsBigInt("ln-proven-weight"),
      votersCommitment: json.valueAsBytes(
        "voters-commitment",
        encoding: StringEncoding.base64,
      ),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "block-headers-commitment": blockHeadersCommitment,
      "first-attested-round": firstAttestedRound,
      "latest-attested-round": latestAttestedRound,
      "ln-proven-weight": lnProvenWeight,
      "voters-commitment": votersCommitment,
    }.notNullValue;
  }
}

/// LedgerStateDeltaForTransactionGroup contains a ledger delta for a single transaction group
class AlgoRestTypesLedgerStateDeltaForTransactionGroup {
  /// Delta ledger StateDelta object
  final Map<String, dynamic>? delta;

  /// Ids
  final List<String> ids;

  const AlgoRestTypesLedgerStateDeltaForTransactionGroup({
    this.delta,
    required this.ids,
  });

  factory AlgoRestTypesLedgerStateDeltaForTransactionGroup.fromJson(
    Map<String, dynamic> json,
  ) {
    return AlgoRestTypesLedgerStateDeltaForTransactionGroup(
      delta: json.valueAsMap<Map<String, dynamic>?>("Delta"),
      ids: json.valueEnsureAsList<String>("Ids", onMissing: () => []),
    );
  }

  Map<String, dynamic> toJson() {
    return {"Delta": delta, "Ids": ids}.notNullValue;
  }
}

/// LightBlockHeaderProof proof of membership and position of a light block header.
class AlgoRestTypesLightBlockHeaderProof {
  /// Index the index of the light block header in the vector commitment tree
  final BigInt index;

  /// Proof the encoded proof.
  final BuBytes proof;

  /// Treedepth represents the depth of the tree that is being proven, i.e. the number of edges from a leaf to the root.
  final BigInt treedepth;

  AlgoRestTypesLightBlockHeaderProof({
    required this.index,
    required List<int> proof,
    required this.treedepth,
  }) : proof = proof.asImmutableBytes;

  factory AlgoRestTypesLightBlockHeaderProof.fromJson(
    Map<String, dynamic> json,
  ) {
    return AlgoRestTypesLightBlockHeaderProof(
      index: json.valueAsBigInt("index", onMissing: () => BigInt.zero),
      proof: json.valueAsBytes(
        "proof",
        encoding: StringEncoding.base64,
        onMissing: () => [],
      ),
      treedepth: json.valueAsBigInt("treedepth", onMissing: () => BigInt.zero),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "index": index,
      "proof": proof,
      "treedepth": treedepth,
    }.notNullValue;
  }
}

/// LocalsRef localsRef names a local state by referring to an Address and App it belongs to.
class AlgoRestTypesLocalsRef {
  /// Address (d) Address in access list, or the sender of the transaction.
  final String address;

  /// App (p) Application ID for app in access list, or zero if referring to the called application.
  final BigInt app;

  const AlgoRestTypesLocalsRef({required this.address, required this.app});

  factory AlgoRestTypesLocalsRef.fromJson(Map<String, dynamic> json) {
    return AlgoRestTypesLocalsRef(
      address: json.valueAsString(
        "address",
        bytesEncoding: StringEncoding.utf8,
        onMissing: () => '',
      ),
      app: json.valueAsBigInt("app", onMissing: () => BigInt.zero),
    );
  }

  Map<String, dynamic> toJson() {
    return {"address": address, "app": app}.notNullValue;
  }
}

/// MerkleArrayProof defines a model for MerkleArrayProof.
class AlgoRestTypesMerkleArrayProof {
  /// HashFactory
  final AlgoRestTypesHashFactory? hashFactory;

  /// Path (pth)
  final List<BuBytes>? path;

  /// TreeDepth (td)
  final BigInt? treeDepth;

  AlgoRestTypesMerkleArrayProof({
    this.hashFactory,
    List<List<int>>? path,
    this.treeDepth,
  }) : path = path?.map((e) => e.asImmutableBytes).toImutableList;

  factory AlgoRestTypesMerkleArrayProof.fromJson(Map<String, dynamic> json) {
    return AlgoRestTypesMerkleArrayProof(
      hashFactory: json.valueTo<AlgoRestTypesHashFactory?, Map>(
        key: "hash-factory",
        parse:
            (e) => AlgoRestTypesHashFactory.fromJson(
              JsonParser.valueEnsureAsMap(e),
            ),
      ),
      path: json.valueTo<List<List<int>>?, List>(
        key: "path",
        parse:
            (e) =>
                e
                    .map(
                      (x) => JsonParser.valueAsBytes<List<int>>(
                        x,
                        encoding: StringEncoding.base64,
                      ),
                    )
                    .toList(),
      ),
      treeDepth: json.valueAsBigInt("tree-depth"),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "hash-factory": hashFactory?.toJson(),
      "path": path,
      "tree-depth": treeDepth,
    }.notNullValue;
  }
}

/// MiniAssetHolding a simplified version of AssetHolding
class AlgoRestTypesMiniAssetHolding {
  /// Address
  final String address;

  /// Amount
  final BigInt amount;

  /// Deleted whether or not this asset holding is currently deleted from its account.
  final bool? deleted;

  /// IsFrozen
  final bool isFrozen;

  /// OptedInAtRound round during which the account opted into the asset.
  final BigInt? optedInAtRound;

  /// OptedOutAtRound round during which the account opted out of the asset.
  final BigInt? optedOutAtRound;

  const AlgoRestTypesMiniAssetHolding({
    required this.address,
    required this.amount,
    this.deleted,
    required this.isFrozen,
    this.optedInAtRound,
    this.optedOutAtRound,
  });

  factory AlgoRestTypesMiniAssetHolding.fromJson(Map<String, dynamic> json) {
    return AlgoRestTypesMiniAssetHolding(
      address: json.valueAsString(
        "address",
        bytesEncoding: StringEncoding.utf8,
        onMissing: () => '',
      ),
      amount: json.valueAsBigInt("amount", onMissing: () => BigInt.zero),
      deleted: json.valueAsBool("deleted"),
      isFrozen: json.valueAsBool("is-frozen", onMissing: () => false),
      optedInAtRound: json.valueAsBigInt("opted-in-at-round"),
      optedOutAtRound: json.valueAsBigInt("opted-out-at-round"),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "address": address,
      "amount": amount,
      "deleted": deleted,
      "is-frozen": isFrozen,
      "opted-in-at-round": optedInAtRound,
      "opted-out-at-round": optedOutAtRound,
    }.notNullValue;
  }
}

/// NodeStatusResponse
class AlgoRestTypesNodeStatusResponse {
  /// Catchpoint the current catchpoint that is being caught up to
  final String? catchpoint;

  /// CatchpointAcquiredBlocks the number of blocks that have already been obtained by the node as part of the catchup
  final BigInt? catchpointAcquiredBlocks;

  /// CatchpointProcessedAccounts the number of accounts from the current catchpoint that have been processed so far as part of the catchup
  final BigInt? catchpointProcessedAccounts;

  /// CatchpointProcessedKvs the number of key-values (KVs) from the current catchpoint that have been processed so far as part of the catchup
  final BigInt? catchpointProcessedKvs;

  /// CatchpointTotalAccounts the total number of accounts included in the current catchpoint
  final BigInt? catchpointTotalAccounts;

  /// CatchpointTotalBlocks the total number of blocks that are required to complete the current catchpoint catchup
  final BigInt? catchpointTotalBlocks;

  /// CatchpointTotalKvs the total number of key-values (KVs) included in the current catchpoint
  final BigInt? catchpointTotalKvs;

  /// CatchpointVerifiedAccounts the number of accounts from the current catchpoint that have been verified so far as part of the catchup
  final BigInt? catchpointVerifiedAccounts;

  /// CatchpointVerifiedKvs the number of key-values (KVs) from the current catchpoint that have been verified so far as part of the catchup
  final BigInt? catchpointVerifiedKvs;

  /// CatchupTime catchupTime in nanoseconds
  final BigInt catchupTime;

  /// LastCatchpoint the last catchpoint seen by the node
  final String? lastCatchpoint;

  /// LastRound lastRound indicates the last round seen
  final BigInt lastRound;

  /// LastVersion lastVersion indicates the last consensus version supported
  final String lastVersion;

  /// NextVersion nextVersion of consensus protocol to use
  final String nextVersion;

  /// NextVersionRound nextVersionRound is the round at which the next consensus version will apply
  final BigInt nextVersionRound;

  /// NextVersionSupported nextVersionSupported indicates whether the next consensus version is supported by this node
  final bool nextVersionSupported;

  /// StoppedAtUnsupportedRound stoppedAtUnsupportedRound indicates that the node does not support the new rounds and has stopped making progress
  final bool stoppedAtUnsupportedRound;

  /// TimeSinceLastRound timeSinceLastRound in nanoseconds
  final BigInt timeSinceLastRound;

  /// UpgradeDelay upgrade delay
  final BigInt? upgradeDelay;

  /// UpgradeNextProtocolVoteBefore next protocol round
  final BigInt? upgradeNextProtocolVoteBefore;

  /// UpgradeNoVotes no votes cast for consensus upgrade
  final BigInt? upgradeNoVotes;

  /// UpgradeNodeVote this node's upgrade vote
  final bool? upgradeNodeVote;

  /// UpgradeVoteRounds total voting rounds for current upgrade
  final BigInt? upgradeVoteRounds;

  /// UpgradeVotes total votes cast for consensus upgrade
  final BigInt? upgradeVotes;

  /// UpgradeVotesRequired yes votes required for consensus upgrade
  final BigInt? upgradeVotesRequired;

  /// UpgradeYesVotes yes votes cast for consensus upgrade
  final BigInt? upgradeYesVotes;

  const AlgoRestTypesNodeStatusResponse({
    this.catchpoint,
    this.catchpointAcquiredBlocks,
    this.catchpointProcessedAccounts,
    this.catchpointProcessedKvs,
    this.catchpointTotalAccounts,
    this.catchpointTotalBlocks,
    this.catchpointTotalKvs,
    this.catchpointVerifiedAccounts,
    this.catchpointVerifiedKvs,
    required this.catchupTime,
    this.lastCatchpoint,
    required this.lastRound,
    required this.lastVersion,
    required this.nextVersion,
    required this.nextVersionRound,
    required this.nextVersionSupported,
    required this.stoppedAtUnsupportedRound,
    required this.timeSinceLastRound,
    this.upgradeDelay,
    this.upgradeNextProtocolVoteBefore,
    this.upgradeNoVotes,
    this.upgradeNodeVote,
    this.upgradeVoteRounds,
    this.upgradeVotes,
    this.upgradeVotesRequired,
    this.upgradeYesVotes,
  });

  factory AlgoRestTypesNodeStatusResponse.fromJson(Map<String, dynamic> json) {
    return AlgoRestTypesNodeStatusResponse(
      catchpoint: json.valueAsString(
        "catchpoint",
        bytesEncoding: StringEncoding.utf8,
      ),
      catchpointAcquiredBlocks: json.valueAsBigInt(
        "catchpoint-acquired-blocks",
      ),
      catchpointProcessedAccounts: json.valueAsBigInt(
        "catchpoint-processed-accounts",
      ),
      catchpointProcessedKvs: json.valueAsBigInt("catchpoint-processed-kvs"),
      catchpointTotalAccounts: json.valueAsBigInt("catchpoint-total-accounts"),
      catchpointTotalBlocks: json.valueAsBigInt("catchpoint-total-blocks"),
      catchpointTotalKvs: json.valueAsBigInt("catchpoint-total-kvs"),
      catchpointVerifiedAccounts: json.valueAsBigInt(
        "catchpoint-verified-accounts",
      ),
      catchpointVerifiedKvs: json.valueAsBigInt("catchpoint-verified-kvs"),
      catchupTime: json.valueAsBigInt(
        "catchup-time",
        onMissing: () => BigInt.zero,
      ),
      lastCatchpoint: json.valueAsString(
        "last-catchpoint",
        bytesEncoding: StringEncoding.utf8,
      ),
      lastRound: json.valueAsBigInt("last-round", onMissing: () => BigInt.zero),
      lastVersion: json.valueAsString(
        "last-version",
        bytesEncoding: StringEncoding.utf8,
        onMissing: () => '',
      ),
      nextVersion: json.valueAsString(
        "next-version",
        bytesEncoding: StringEncoding.utf8,
        onMissing: () => '',
      ),
      nextVersionRound: json.valueAsBigInt(
        "next-version-round",
        onMissing: () => BigInt.zero,
      ),
      nextVersionSupported: json.valueAsBool(
        "next-version-supported",
        onMissing: () => false,
      ),
      stoppedAtUnsupportedRound: json.valueAsBool(
        "stopped-at-unsupported-round",
        onMissing: () => false,
      ),
      timeSinceLastRound: json.valueAsBigInt(
        "time-since-last-round",
        onMissing: () => BigInt.zero,
      ),
      upgradeDelay: json.valueAsBigInt("upgrade-delay"),
      upgradeNextProtocolVoteBefore: json.valueAsBigInt(
        "upgrade-next-protocol-vote-before",
      ),
      upgradeNoVotes: json.valueAsBigInt("upgrade-no-votes"),
      upgradeNodeVote: json.valueAsBool("upgrade-node-vote"),
      upgradeVoteRounds: json.valueAsBigInt("upgrade-vote-rounds"),
      upgradeVotes: json.valueAsBigInt("upgrade-votes"),
      upgradeVotesRequired: json.valueAsBigInt("upgrade-votes-required"),
      upgradeYesVotes: json.valueAsBigInt("upgrade-yes-votes"),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "catchpoint": catchpoint,
      "catchpoint-acquired-blocks": catchpointAcquiredBlocks,
      "catchpoint-processed-accounts": catchpointProcessedAccounts,
      "catchpoint-processed-kvs": catchpointProcessedKvs,
      "catchpoint-total-accounts": catchpointTotalAccounts,
      "catchpoint-total-blocks": catchpointTotalBlocks,
      "catchpoint-total-kvs": catchpointTotalKvs,
      "catchpoint-verified-accounts": catchpointVerifiedAccounts,
      "catchpoint-verified-kvs": catchpointVerifiedKvs,
      "catchup-time": catchupTime,
      "last-catchpoint": lastCatchpoint,
      "last-round": lastRound,
      "last-version": lastVersion,
      "next-version": nextVersion,
      "next-version-round": nextVersionRound,
      "next-version-supported": nextVersionSupported,
      "stopped-at-unsupported-round": stoppedAtUnsupportedRound,
      "time-since-last-round": timeSinceLastRound,
      "upgrade-delay": upgradeDelay,
      "upgrade-next-protocol-vote-before": upgradeNextProtocolVoteBefore,
      "upgrade-no-votes": upgradeNoVotes,
      "upgrade-node-vote": upgradeNodeVote,
      "upgrade-vote-rounds": upgradeVoteRounds,
      "upgrade-votes": upgradeVotes,
      "upgrade-votes-required": upgradeVotesRequired,
      "upgrade-yes-votes": upgradeYesVotes,
    }.notNullValue;
  }
}

/// ParticipationUpdates participation account data that needs to be checked/acted on by the network.
class AlgoRestTypesParticipationUpdates {
  /// AbsentParticipationAccounts (partupabs) a list of online accounts that need to be suspended.
  final List<String>? absentParticipationAccounts;

  /// ExpiredParticipationAccounts (partupdrmv) a list of online accounts that needs to be converted to offline since their participation key expired.
  final List<String>? expiredParticipationAccounts;

  const AlgoRestTypesParticipationUpdates({
    this.absentParticipationAccounts,
    this.expiredParticipationAccounts,
  });

  factory AlgoRestTypesParticipationUpdates.fromJson(
    Map<String, dynamic> json,
  ) {
    return AlgoRestTypesParticipationUpdates(
      absentParticipationAccounts: json.valueAsList<List<String>?>(
        "absent-participation-accounts",
      ),
      expiredParticipationAccounts: json.valueAsList<List<String>?>(
        "expired-participation-accounts",
      ),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "absent-participation-accounts": absentParticipationAccounts,
      "expired-participation-accounts": expiredParticipationAccounts,
    }.notNullValue;
  }
}

/// PendingTransactionResponse details about a pending transaction. If the transaction was recently confirmed, includes confirmation details like the round and reward details.
class AlgoRestTypesPendingTransactionResponse {
  /// ApplicationIndex the application index if the transaction was found and it created an application.
  final BigInt? applicationIndex;

  /// AssetClosingAmount the number of the asset's unit that were transferred to the close-to address.
  final BigInt? assetClosingAmount;

  /// AssetIndex the asset index if the transaction was found and it created an asset.
  final BigInt? assetIndex;

  /// CloseRewards rewards in microalgos applied to the close remainder to account.
  final BigInt? closeRewards;

  /// ClosingAmount closing amount for the transaction.
  final BigInt? closingAmount;

  /// ConfirmedRound the round where this transaction was confirmed, if present.
  final BigInt? confirmedRound;

  /// GlobalStateDelta global state key/value changes for the application being executed by this transaction.
  final List<AlgoRestTypesEvalDeltaKeyValue>? globalStateDelta;

  /// InnerTxns inner transactions produced by application execution.
  final List<AlgoRestTypesPendingTransactionResponse>? innerTxns;

  /// LocalStateDelta local state key/value changes for the application being executed by this transaction.
  final List<AlgoRestTypesAccountStateDelta>? localStateDelta;

  /// Logs logs for the application being executed by this transaction.
  final List<BuBytes>? logs;

  /// PoolError indicates that the transaction was kicked out of this node's transaction pool (and specifies why that happened). An empty string indicates the transaction wasn't kicked out of this node's txpool due to an error.
  final String poolError;

  /// ReceiverRewards rewards in microalgos applied to the receiver account.
  final BigInt? receiverRewards;

  /// SenderRewards rewards in microalgos applied to the sender account.
  final BigInt? senderRewards;

  /// Transaction the raw signed transaction.
  final AlgoSignedTxn transaction;

  AlgoRestTypesPendingTransactionResponse({
    this.applicationIndex,
    this.assetClosingAmount,
    this.assetIndex,
    this.closeRewards,
    this.closingAmount,
    this.confirmedRound,
    this.globalStateDelta,
    this.innerTxns,
    this.localStateDelta,
    List<List<int>>? logs,
    required this.poolError,
    this.receiverRewards,
    this.senderRewards,
    required this.transaction,
  }) : logs = logs?.map((e) => e.asImmutableBytes).toImutableList;

  factory AlgoRestTypesPendingTransactionResponse.fromJson(
    Map<String, dynamic> json,
  ) {
    return AlgoRestTypesPendingTransactionResponse(
      applicationIndex: json.valueAsBigInt("application-index"),
      assetClosingAmount: json.valueAsBigInt("asset-closing-amount"),
      assetIndex: json.valueAsBigInt("asset-index"),
      closeRewards: json.valueAsBigInt("close-rewards"),
      closingAmount: json.valueAsBigInt("closing-amount"),
      confirmedRound: json.valueAsBigInt("confirmed-round"),
      globalStateDelta: json
          .valueTo<List<AlgoRestTypesEvalDeltaKeyValue>?, List>(
            key: "global-state-delta",
            parse:
                (e) =>
                    e
                        .map(
                          (x) => AlgoRestTypesEvalDeltaKeyValue.fromJson(
                            JsonParser.valueEnsureAsMap(x),
                          ),
                        )
                        .toList(),
          ),
      innerTxns: json
          .valueTo<List<AlgoRestTypesPendingTransactionResponse>?, List>(
            key: "inner-txns",
            parse:
                (e) =>
                    e
                        .map(
                          (x) =>
                              AlgoRestTypesPendingTransactionResponse.fromJson(
                                JsonParser.valueEnsureAsMap(x),
                              ),
                        )
                        .toList(),
          ),
      localStateDelta: json
          .valueTo<List<AlgoRestTypesAccountStateDelta>?, List>(
            key: "local-state-delta",
            parse:
                (e) =>
                    e
                        .map(
                          (x) => AlgoRestTypesAccountStateDelta.fromJson(
                            JsonParser.valueEnsureAsMap(x),
                          ),
                        )
                        .toList(),
          ),
      logs: json.valueTo<List<List<int>>?, List>(
        key: "logs",
        parse:
            (e) =>
                e
                    .map(
                      (x) => JsonParser.valueAsBytes<List<int>>(
                        x,
                        encoding: StringEncoding.base64,
                      ),
                    )
                    .toList(),
      ),
      poolError: json.valueAsString(
        "pool-error",
        bytesEncoding: StringEncoding.utf8,
        onMissing: () => '',
      ),
      receiverRewards: json.valueAsBigInt("receiver-rewards"),
      senderRewards: json.valueAsBigInt("sender-rewards"),
      transaction: AlgoSignedTxn.deserializeJson(json.valueEnsureAsMap("txn")),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "application-index": applicationIndex,
      "asset-closing-amount": assetClosingAmount,
      "asset-index": assetIndex,
      "close-rewards": closeRewards,
      "closing-amount": closingAmount,
      "confirmed-round": confirmedRound,
      "global-state-delta": globalStateDelta?.map((e) => e.toJson()).toList(),
      "inner-txns": innerTxns?.map((e) => e.toJson()).toList(),
      "local-state-delta": localStateDelta?.map((e) => e.toJson()).toList(),
      "logs": logs,
      "pool-error": poolError,
      "receiver-rewards": receiverRewards,
      "sender-rewards": senderRewards,
      "txn": transaction.toSerializeBytes(),
    }.notNullValue;
  }
}

/// PendingTransactionsResponse a potentially truncated list of transactions currently in the node's transaction pool. You can compute whether or not the list is truncated if the number of elements in the **top-transactions** array is fewer than **total-transactions**.
class AlgoRestTypesPendingTransactionsResponse {
  /// TopTransactions an array of signed transaction objects.
  final List<AlgoSignedTxn> topTransactions;

  /// TotalTransactions total number of transactions in the pool.
  final BigInt totalTransactions;

  const AlgoRestTypesPendingTransactionsResponse({
    required this.topTransactions,
    required this.totalTransactions,
  });

  factory AlgoRestTypesPendingTransactionsResponse.fromJson(
    Map<String, dynamic> json,
  ) {
    return AlgoRestTypesPendingTransactionsResponse(
      topTransactions:
          json
              .valueEnsureAsList<Map<String, dynamic>>(
                "top-transactions",
                onMissing: () => [],
              )
              .map((e) => AlgoSignedTxn.deserializeJson(e))
              .toList(),
      totalTransactions: json.valueAsBigInt(
        "total-transactions",
        onMissing: () => BigInt.zero,
      ),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "top-transactions":
          topTransactions.map((e) => e.toSerializeJson()).toList(),
      "total-transactions": totalTransactions,
    }.notNullValue;
  }
}

/// PostTransactionsResponse transaction ID of the submission.
class AlgoRestTypesPostTransactionsResponse {
  /// Txid encoding of the transaction hash.
  final String txid;

  const AlgoRestTypesPostTransactionsResponse({required this.txid});

  factory AlgoRestTypesPostTransactionsResponse.fromJson(
    Map<String, dynamic> json,
  ) {
    return AlgoRestTypesPostTransactionsResponse(
      txid: json.valueAsString(
        "txId",
        bytesEncoding: StringEncoding.utf8,
        onMissing: () => '',
      ),
    );
  }

  Map<String, dynamic> toJson() {
    return {"txId": txid}.notNullValue;
  }
}

/// ResourceRef resourceRef names a single resource. Only one of the fields should be set.
class AlgoRestTypesResourceRef {
  /// Address (d) Account whose balance record is accessible by the executing ApprovalProgram or ClearStateProgram.
  final String? address;

  /// ApplicationId (p) Application id whose GlobalState may be read by the executing ApprovalProgram or ClearStateProgram.
  final BigInt? applicationId;

  /// AssetId (s) Asset whose AssetParams may be read by the executing ApprovalProgram or ClearStateProgram.
  final BigInt? assetId;

  /// Box boxReference names a box by its name and the application ID it belongs to.
  final AlgoRestTypesBoxReference? box;

  /// Holding holdingRef names a holding by referring to an Address and Asset it belongs to.
  final AlgoRestTypesHoldingRef? holding;

  /// Local localsRef names a local state by referring to an Address and App it belongs to.
  final AlgoRestTypesLocalsRef? local;

  const AlgoRestTypesResourceRef({
    this.address,
    this.applicationId,
    this.assetId,
    this.box,
    this.holding,
    this.local,
  });

  factory AlgoRestTypesResourceRef.fromJson(Map<String, dynamic> json) {
    return AlgoRestTypesResourceRef(
      address: json.valueAsString(
        "address",
        bytesEncoding: StringEncoding.utf8,
      ),
      applicationId: json.valueAsBigInt("application-id"),
      assetId: json.valueAsBigInt("asset-id"),
      box: json.valueTo<AlgoRestTypesBoxReference?, Map>(
        key: "box",
        parse:
            (e) => AlgoRestTypesBoxReference.fromJson(
              JsonParser.valueEnsureAsMap(e),
            ),
      ),
      holding: json.valueTo<AlgoRestTypesHoldingRef?, Map>(
        key: "holding",
        parse:
            (e) => AlgoRestTypesHoldingRef.fromJson(
              JsonParser.valueEnsureAsMap(e),
            ),
      ),
      local: json.valueTo<AlgoRestTypesLocalsRef?, Map>(
        key: "local",
        parse:
            (e) =>
                AlgoRestTypesLocalsRef.fromJson(JsonParser.valueEnsureAsMap(e)),
      ),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "address": address,
      "application-id": applicationId,
      "asset-id": assetId,
      "box": box?.toJson(),
      "holding": holding?.toJson(),
      "local": local?.toJson(),
    }.notNullValue;
  }
}

/// ScratchChange a write operation into a scratch slot.
class AlgoRestTypesScratchChange {
  /// NewValue represents an AVM value.
  final AlgoRestTypesAvmValue newValue;

  /// Slot the scratch slot written.
  final BigInt slot;

  const AlgoRestTypesScratchChange({
    required this.newValue,
    required this.slot,
  });

  factory AlgoRestTypesScratchChange.fromJson(Map<String, dynamic> json) {
    return AlgoRestTypesScratchChange(
      newValue: json.valueTo<AlgoRestTypesAvmValue, Map>(
        key: "new-value",
        parse:
            (e) =>
                AlgoRestTypesAvmValue.fromJson(JsonParser.valueEnsureAsMap(e)),
      ),
      slot: json.valueAsBigInt("slot", onMissing: () => BigInt.zero),
    );
  }

  Map<String, dynamic> toJson() {
    return {"new-value": newValue.toJson(), "slot": slot}.notNullValue;
  }
}

/// SimulateInitialStates initial states of resources that were accessed during simulation.
class AlgoRestTypesSimulateInitialStates {
  /// AppInitialStates the initial states of accessed application before simulation. The order of this array is arbitrary.
  final List<AlgoRestTypesApplicationInitialStates>? appInitialStates;

  const AlgoRestTypesSimulateInitialStates({this.appInitialStates});

  factory AlgoRestTypesSimulateInitialStates.fromJson(
    Map<String, dynamic> json,
  ) {
    return AlgoRestTypesSimulateInitialStates(
      appInitialStates: json
          .valueTo<List<AlgoRestTypesApplicationInitialStates>?, List>(
            key: "app-initial-states",
            parse:
                (e) =>
                    e
                        .map(
                          (x) => AlgoRestTypesApplicationInitialStates.fromJson(
                            JsonParser.valueEnsureAsMap(x),
                          ),
                        )
                        .toList(),
          ),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "app-initial-states": appInitialStates?.map((e) => e.toJson()).toList(),
    }.notNullValue;
  }
}

/// SimulateRequest request type for simulation endpoint.
class AlgoRestTypesSimulateRequest {
  /// AllowEmptySignatures allows transactions without signatures to be simulated as if they had correct signatures.
  final bool? allowEmptySignatures;

  /// AllowMoreLogging lifts limits on log opcode usage during simulation.
  final bool? allowMoreLogging;

  /// AllowUnnamedResources allows access to unnamed resources during simulation.
  final bool? allowUnnamedResources;

  /// ExecTraceConfig an object that configures simulation execution trace.
  final AlgoRestTypesSimulateTraceConfig? execTraceConfig;

  /// ExtraOpcodeBudget applies extra opcode budget during simulation for each transaction group.
  final BigInt? extraOpcodeBudget;

  /// FixSigners if true, signers for transactions that are missing signatures will be fixed during evaluation.
  final bool? fixSigners;

  /// Round if provided, specifies the round preceding the simulation. State changes through this round will be used to run this simulation. Usually only the 4 most recent rounds will be available (controlled by the node config value MaxAcctLookback). If not specified, defaults to the latest available round.
  final BigInt? round;

  /// TxnGroups the transaction groups to simulate.
  final List<AlgoRestTypesSimulateRequestTransactionGroup> txnGroups;

  const AlgoRestTypesSimulateRequest({
    this.allowEmptySignatures,
    this.allowMoreLogging,
    this.allowUnnamedResources,
    this.execTraceConfig,
    this.extraOpcodeBudget,
    this.fixSigners,
    this.round,
    required this.txnGroups,
  });

  factory AlgoRestTypesSimulateRequest.fromJson(Map<String, dynamic> json) {
    return AlgoRestTypesSimulateRequest(
      allowEmptySignatures: json.valueAsBool("allow-empty-signatures"),
      allowMoreLogging: json.valueAsBool("allow-more-logging"),
      allowUnnamedResources: json.valueAsBool("allow-unnamed-resources"),
      execTraceConfig: json.valueTo<AlgoRestTypesSimulateTraceConfig?, Map>(
        key: "exec-trace-config",
        parse:
            (e) => AlgoRestTypesSimulateTraceConfig.fromJson(
              JsonParser.valueEnsureAsMap(e),
            ),
      ),
      extraOpcodeBudget: json.valueAsBigInt("extra-opcode-budget"),
      fixSigners: json.valueAsBool("fix-signers"),
      round: json.valueAsBigInt("round"),
      txnGroups: json.valueTo<
        List<AlgoRestTypesSimulateRequestTransactionGroup>,
        List
      >(
        key: "txn-groups",
        onMissing: () => [],
        parse:
            (e) =>
                e
                    .map(
                      (x) =>
                          AlgoRestTypesSimulateRequestTransactionGroup.fromJson(
                            JsonParser.valueEnsureAsMap(x),
                          ),
                    )
                    .toList(),
      ),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "allow-empty-signatures": allowEmptySignatures,
      "allow-more-logging": allowMoreLogging,
      "allow-unnamed-resources": allowUnnamedResources,
      "exec-trace-config": execTraceConfig?.toJson(),
      "extra-opcode-budget": extraOpcodeBudget,
      "fix-signers": fixSigners,
      "round": round,
      "txn-groups": txnGroups.map((e) => e.toJson()).toList(),
    }.notNullValue;
  }
}

/// SimulateRequestTransactionGroup a transaction group to simulate.
class AlgoRestTypesSimulateRequestTransactionGroup {
  /// Txns an atomic transaction group.
  final List<AlgoSignedTxn> txns;

  const AlgoRestTypesSimulateRequestTransactionGroup({required this.txns});

  factory AlgoRestTypesSimulateRequestTransactionGroup.fromJson(
    Map<String, dynamic> json,
  ) {
    return AlgoRestTypesSimulateRequestTransactionGroup(
      txns:
          json
              .valueEnsureAsList<Map<String, dynamic>>(
                "txns",
                onMissing: () => [],
              )
              .map((e) => AlgoSignedTxn.deserializeJson(e))
              .toList(),
    );
  }

  Map<String, dynamic> toJson() {
    return {"txns": txns.map((e) => e.toSerializeJson()).toList()}.notNullValue;
  }
}

/// SimulateResponse result of a transaction group simulation.
class AlgoRestTypesSimulateResponse {
  /// EvalOverrides the set of parameters and limits override during simulation. If this set of parameters is present, then evaluation parameters may differ from standard evaluation in certain ways.
  final AlgoRestTypesSimulationEvalOverrides? evalOverrides;

  /// ExecTraceConfig an object that configures simulation execution trace.
  final AlgoRestTypesSimulateTraceConfig? execTraceConfig;

  /// InitialStates initial states of resources that were accessed during simulation.
  final AlgoRestTypesSimulateInitialStates? initialStates;

  /// LastRound the round immediately preceding this simulation. State changes through this round were used to run this simulation.
  final BigInt lastRound;

  /// TxnGroups a result object for each transaction group that was simulated.
  final List<AlgoRestTypesSimulateTransactionGroupResult> txnGroups;

  /// Version the version of this response object.
  final BigInt version;

  const AlgoRestTypesSimulateResponse({
    this.evalOverrides,
    this.execTraceConfig,
    this.initialStates,
    required this.lastRound,
    required this.txnGroups,
    required this.version,
  });

  factory AlgoRestTypesSimulateResponse.fromJson(Map<String, dynamic> json) {
    return AlgoRestTypesSimulateResponse(
      evalOverrides: json.valueTo<AlgoRestTypesSimulationEvalOverrides?, Map>(
        key: "eval-overrides",
        parse:
            (e) => AlgoRestTypesSimulationEvalOverrides.fromJson(
              JsonParser.valueEnsureAsMap(e),
            ),
      ),
      execTraceConfig: json.valueTo<AlgoRestTypesSimulateTraceConfig?, Map>(
        key: "exec-trace-config",
        parse:
            (e) => AlgoRestTypesSimulateTraceConfig.fromJson(
              JsonParser.valueEnsureAsMap(e),
            ),
      ),
      initialStates: json.valueTo<AlgoRestTypesSimulateInitialStates?, Map>(
        key: "initial-states",
        parse:
            (e) => AlgoRestTypesSimulateInitialStates.fromJson(
              JsonParser.valueEnsureAsMap(e),
            ),
      ),
      lastRound: json.valueAsBigInt("last-round", onMissing: () => BigInt.zero),
      txnGroups: json.valueTo<
        List<AlgoRestTypesSimulateTransactionGroupResult>,
        List
      >(
        key: "txn-groups",
        onMissing: () => [],
        parse:
            (e) =>
                e
                    .map(
                      (x) =>
                          AlgoRestTypesSimulateTransactionGroupResult.fromJson(
                            JsonParser.valueEnsureAsMap(x),
                          ),
                    )
                    .toList(),
      ),
      version: json.valueAsBigInt("version", onMissing: () => BigInt.zero),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "eval-overrides": evalOverrides?.toJson(),
      "exec-trace-config": execTraceConfig?.toJson(),
      "initial-states": initialStates?.toJson(),
      "last-round": lastRound,
      "txn-groups": txnGroups.map((e) => e.toJson()).toList(),
      "version": version,
    }.notNullValue;
  }
}

/// SimulateTraceConfig an object that configures simulation execution trace.
class AlgoRestTypesSimulateTraceConfig {
  /// Enable a boolean option for opting in execution trace features simulation endpoint.
  final bool? enable;

  /// ScratchChange a boolean option enabling returning scratch slot changes together with execution trace during simulation.
  final bool? scratchChange;

  /// StackChange a boolean option enabling returning stack changes together with execution trace during simulation.
  final bool? stackChange;

  /// StateChange a boolean option enabling returning application state changes (global, local, and box changes) with the execution trace during simulation.
  final bool? stateChange;

  const AlgoRestTypesSimulateTraceConfig({
    this.enable,
    this.scratchChange,
    this.stackChange,
    this.stateChange,
  });

  factory AlgoRestTypesSimulateTraceConfig.fromJson(Map<String, dynamic> json) {
    return AlgoRestTypesSimulateTraceConfig(
      enable: json.valueAsBool("enable"),
      scratchChange: json.valueAsBool("scratch-change"),
      stackChange: json.valueAsBool("stack-change"),
      stateChange: json.valueAsBool("state-change"),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "enable": enable,
      "scratch-change": scratchChange,
      "stack-change": stackChange,
      "state-change": stateChange,
    }.notNullValue;
  }
}

/// SimulateTransactionGroupResult simulation result for an atomic transaction group
class AlgoRestTypesSimulateTransactionGroupResult {
  /// AppBudgetAdded total budget added during execution of app calls in the transaction group.
  final BigInt? appBudgetAdded;

  /// AppBudgetConsumed total budget consumed during execution of app calls in the transaction group.
  final BigInt? appBudgetConsumed;

  /// FailedAt if present, indicates which transaction in this group caused the failure. This array represents the path to the failing transaction. Indexes are zero based, the first element indicates the top-level transaction, and successive elements indicate deeper inner transactions.
  final List<BigInt>? failedAt;

  /// FailureMessage if present, indicates that the transaction group failed and specifies why that happened
  final String? failureMessage;

  /// GroupFeesPaid total fees paid by the transaction group and all of its descendant inner transaction groups.
  final BigInt? groupFeesPaid;

  /// GroupUsage fee usage for the transaction group, including all descendant inner transactions, in millionths of a basic transaction fee unit.
  final BigInt? groupUsage;

  /// TxnResults simulation result for individual transactions
  final List<AlgoRestTypesSimulateTransactionResult> txnResults;

  /// UnnamedResourcesAccessed these are resources that were accessed by this group that would normally have caused failure, but were allowed in simulation. Depending on where this object is in the response, the unnamed resources it contains may or may not qualify for group resource sharing. If this is a field in SimulateTransactionGroupResult, the resources do qualify, but if this is a field in SimulateTransactionResult, they do not qualify. In order to make this group valid for actual submission, resources that qualify for group sharing can be made available by any transaction of the group; otherwise, resources must be placed in the same transaction which accessed them.
  final AlgoRestTypesSimulateUnnamedResourcesAccessed? unnamedResourcesAccessed;

  const AlgoRestTypesSimulateTransactionGroupResult({
    this.appBudgetAdded,
    this.appBudgetConsumed,
    this.failedAt,
    this.failureMessage,
    this.groupFeesPaid,
    this.groupUsage,
    required this.txnResults,
    this.unnamedResourcesAccessed,
  });

  factory AlgoRestTypesSimulateTransactionGroupResult.fromJson(
    Map<String, dynamic> json,
  ) {
    return AlgoRestTypesSimulateTransactionGroupResult(
      appBudgetAdded: json.valueAsBigInt("app-budget-added"),
      appBudgetConsumed: json.valueAsBigInt("app-budget-consumed"),
      failedAt: json.valueAsList<List<BigInt>?>("failed-at"),
      failureMessage: json.valueAsString(
        "failure-message",
        bytesEncoding: StringEncoding.utf8,
      ),
      groupFeesPaid: json.valueAsBigInt("group-fees-paid"),
      groupUsage: json.valueAsBigInt("group-usage"),
      txnResults: json
          .valueTo<List<AlgoRestTypesSimulateTransactionResult>, List>(
            key: "txn-results",
            onMissing: () => [],
            parse:
                (e) =>
                    e
                        .map(
                          (x) =>
                              AlgoRestTypesSimulateTransactionResult.fromJson(
                                JsonParser.valueEnsureAsMap(x),
                              ),
                        )
                        .toList(),
          ),
      unnamedResourcesAccessed: json
          .valueTo<AlgoRestTypesSimulateUnnamedResourcesAccessed?, Map>(
            key: "unnamed-resources-accessed",
            parse:
                (e) => AlgoRestTypesSimulateUnnamedResourcesAccessed.fromJson(
                  JsonParser.valueEnsureAsMap(e),
                ),
          ),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "app-budget-added": appBudgetAdded,
      "app-budget-consumed": appBudgetConsumed,
      "failed-at": failedAt?.map((e) => e).toList(),
      "failure-message": failureMessage,
      "group-fees-paid": groupFeesPaid,
      "group-usage": groupUsage,
      "txn-results": txnResults.map((e) => e.toJson()).toList(),
      "unnamed-resources-accessed": unnamedResourcesAccessed?.toJson(),
    }.notNullValue;
  }
}

/// SimulateTransactionResult simulation result for an individual transaction
class AlgoRestTypesSimulateTransactionResult {
  /// AppBudgetConsumed budget used during execution of an app call transaction. This value includes budged used by inner app calls spawned by this transaction.
  final BigInt? appBudgetConsumed;

  /// ExecTrace the execution trace of calling an app or a logic sig, containing the inner app call trace in a recursive way.
  final AlgoRestTypesSimulationTransactionExecTrace? execTrace;

  /// FeesPaid total fees paid by this transaction and all of its descendant inner transactions.
  final BigInt? feesPaid;

  /// FixedSigner the account that needed to sign this transaction when no signature was provided and the provided signer was incorrect.
  final String? fixedSigner;

  /// LogicSigBudgetConsumed budget used during execution of a logic sig transaction.
  final BigInt? logicSigBudgetConsumed;

  /// TxnResult details about a pending transaction. If the transaction was recently confirmed, includes confirmation details like the round and reward details.
  final AlgoRestTypesPendingTransactionResponse txnResult;

  /// UnnamedResourcesAccessed these are resources that were accessed by this group that would normally have caused failure, but were allowed in simulation. Depending on where this object is in the response, the unnamed resources it contains may or may not qualify for group resource sharing. If this is a field in SimulateTransactionGroupResult, the resources do qualify, but if this is a field in SimulateTransactionResult, they do not qualify. In order to make this group valid for actual submission, resources that qualify for group sharing can be made available by any transaction of the group; otherwise, resources must be placed in the same transaction which accessed them.
  final AlgoRestTypesSimulateUnnamedResourcesAccessed? unnamedResourcesAccessed;

  const AlgoRestTypesSimulateTransactionResult({
    this.appBudgetConsumed,
    this.execTrace,
    this.feesPaid,
    this.fixedSigner,
    this.logicSigBudgetConsumed,
    required this.txnResult,
    this.unnamedResourcesAccessed,
  });

  factory AlgoRestTypesSimulateTransactionResult.fromJson(
    Map<String, dynamic> json,
  ) {
    return AlgoRestTypesSimulateTransactionResult(
      appBudgetConsumed: json.valueAsBigInt("app-budget-consumed"),
      execTrace: json
          .valueTo<AlgoRestTypesSimulationTransactionExecTrace?, Map>(
            key: "exec-trace",
            parse:
                (e) => AlgoRestTypesSimulationTransactionExecTrace.fromJson(
                  JsonParser.valueEnsureAsMap(e),
                ),
          ),
      feesPaid: json.valueAsBigInt("fees-paid"),
      fixedSigner: json.valueAsString(
        "fixed-signer",
        bytesEncoding: StringEncoding.utf8,
      ),
      logicSigBudgetConsumed: json.valueAsBigInt("logic-sig-budget-consumed"),
      txnResult: json.valueTo<AlgoRestTypesPendingTransactionResponse, Map>(
        key: "txn-result",
        parse:
            (e) => AlgoRestTypesPendingTransactionResponse.fromJson(
              JsonParser.valueEnsureAsMap(e),
            ),
      ),
      unnamedResourcesAccessed: json
          .valueTo<AlgoRestTypesSimulateUnnamedResourcesAccessed?, Map>(
            key: "unnamed-resources-accessed",
            parse:
                (e) => AlgoRestTypesSimulateUnnamedResourcesAccessed.fromJson(
                  JsonParser.valueEnsureAsMap(e),
                ),
          ),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "app-budget-consumed": appBudgetConsumed,
      "exec-trace": execTrace?.toJson(),
      "fees-paid": feesPaid,
      "fixed-signer": fixedSigner,
      "logic-sig-budget-consumed": logicSigBudgetConsumed,
      "txn-result": txnResult.toJson(),
      "unnamed-resources-accessed": unnamedResourcesAccessed?.toJson(),
    }.notNullValue;
  }
}

/// SimulateUnnamedResourcesAccessed these are resources that were accessed by this group that would normally have caused failure, but were allowed in simulation. Depending on where this object is in the response, the unnamed resources it contains may or may not qualify for group resource sharing. If this is a field in SimulateTransactionGroupResult, the resources do qualify, but if this is a field in SimulateTransactionResult, they do not qualify. In order to make this group valid for actual submission, resources that qualify for group sharing can be made available by any transaction of the group; otherwise, resources must be placed in the same transaction which accessed them.
class AlgoRestTypesSimulateUnnamedResourcesAccessed {
  /// Accounts the unnamed accounts that were referenced. The order of this array is arbitrary.
  final List<String>? accounts;

  /// AppLocals the unnamed application local states that were referenced. The order of this array is arbitrary.
  final List<AlgoRestTypesApplicationLocalReference>? appLocals;

  /// Apps the unnamed applications that were referenced. The order of this array is arbitrary.
  final List<BigInt>? apps;

  /// AssetHoldings the unnamed asset holdings that were referenced. The order of this array is arbitrary.
  final List<AlgoRestTypesAssetHoldingReference>? assetHoldings;

  /// Assets the unnamed assets that were referenced. The order of this array is arbitrary.
  final List<BigInt>? assets;

  /// Boxes the unnamed boxes that were referenced. The order of this array is arbitrary.
  final List<AlgoRestTypesBoxReference>? boxes;

  /// ExtraBoxRefs the number of extra box references used to increase the IO budget. This is in addition to the references defined in the input transaction group and any referenced to unnamed boxes.
  final BigInt? extraBoxRefs;

  const AlgoRestTypesSimulateUnnamedResourcesAccessed({
    this.accounts,
    this.appLocals,
    this.apps,
    this.assetHoldings,
    this.assets,
    this.boxes,
    this.extraBoxRefs,
  });

  factory AlgoRestTypesSimulateUnnamedResourcesAccessed.fromJson(
    Map<String, dynamic> json,
  ) {
    return AlgoRestTypesSimulateUnnamedResourcesAccessed(
      accounts: json.valueAsList<List<String>?>("accounts"),
      appLocals: json
          .valueTo<List<AlgoRestTypesApplicationLocalReference>?, List>(
            key: "app-locals",
            parse:
                (e) =>
                    e
                        .map(
                          (x) =>
                              AlgoRestTypesApplicationLocalReference.fromJson(
                                JsonParser.valueEnsureAsMap(x),
                              ),
                        )
                        .toList(),
          ),
      apps: json.valueAsList<List<BigInt>?>("apps"),
      assetHoldings: json
          .valueTo<List<AlgoRestTypesAssetHoldingReference>?, List>(
            key: "asset-holdings",
            parse:
                (e) =>
                    e
                        .map(
                          (x) => AlgoRestTypesAssetHoldingReference.fromJson(
                            JsonParser.valueEnsureAsMap(x),
                          ),
                        )
                        .toList(),
          ),
      assets: json.valueAsList<List<BigInt>?>("assets"),
      boxes: json.valueTo<List<AlgoRestTypesBoxReference>?, List>(
        key: "boxes",
        parse:
            (e) =>
                e
                    .map(
                      (x) => AlgoRestTypesBoxReference.fromJson(
                        JsonParser.valueEnsureAsMap(x),
                      ),
                    )
                    .toList(),
      ),
      extraBoxRefs: json.valueAsBigInt("extra-box-refs"),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "accounts": accounts,
      "app-locals": appLocals?.map((e) => e.toJson()).toList(),
      "apps": apps?.map((e) => e).toList(),
      "asset-holdings": assetHoldings?.map((e) => e.toJson()).toList(),
      "assets": assets?.map((e) => e).toList(),
      "boxes": boxes?.map((e) => e.toJson()).toList(),
      "extra-box-refs": extraBoxRefs,
    }.notNullValue;
  }
}

/// SimulationEvalOverrides the set of parameters and limits override during simulation. If this set of parameters is present, then evaluation parameters may differ from standard evaluation in certain ways.
class AlgoRestTypesSimulationEvalOverrides {
  /// AllowEmptySignatures if true, transactions without signatures are allowed and simulated as if they were properly signed.
  final bool? allowEmptySignatures;

  /// AllowUnnamedResources if true, allows access to unnamed resources during simulation.
  final bool? allowUnnamedResources;

  /// ExtraOpcodeBudget the extra opcode budget added to each transaction group during simulation
  final BigInt? extraOpcodeBudget;

  /// FixSigners if true, signers for transactions that are missing signatures will be fixed during evaluation.
  final bool? fixSigners;

  /// MaxLogCalls the maximum log calls one can make during simulation
  final BigInt? maxLogCalls;

  /// MaxLogSize the maximum byte number to log during simulation
  final BigInt? maxLogSize;

  const AlgoRestTypesSimulationEvalOverrides({
    this.allowEmptySignatures,
    this.allowUnnamedResources,
    this.extraOpcodeBudget,
    this.fixSigners,
    this.maxLogCalls,
    this.maxLogSize,
  });

  factory AlgoRestTypesSimulationEvalOverrides.fromJson(
    Map<String, dynamic> json,
  ) {
    return AlgoRestTypesSimulationEvalOverrides(
      allowEmptySignatures: json.valueAsBool("allow-empty-signatures"),
      allowUnnamedResources: json.valueAsBool("allow-unnamed-resources"),
      extraOpcodeBudget: json.valueAsBigInt("extra-opcode-budget"),
      fixSigners: json.valueAsBool("fix-signers"),
      maxLogCalls: json.valueAsBigInt("max-log-calls"),
      maxLogSize: json.valueAsBigInt("max-log-size"),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "allow-empty-signatures": allowEmptySignatures,
      "allow-unnamed-resources": allowUnnamedResources,
      "extra-opcode-budget": extraOpcodeBudget,
      "fix-signers": fixSigners,
      "max-log-calls": maxLogCalls,
      "max-log-size": maxLogSize,
    }.notNullValue;
  }
}

/// SimulationOpcodeTraceUnit the set of trace information and effect from evaluating a single opcode.
class AlgoRestTypesSimulationOpcodeTraceUnit {
  /// Pc the program counter of the current opcode being evaluated.
  final BigInt pc;

  /// ScratchChanges the writes into scratch slots.
  final List<AlgoRestTypesScratchChange>? scratchChanges;

  /// SpawnedInners the indexes of the traces for inner transactions spawned by this opcode, if any.
  final List<BigInt>? spawnedInners;

  /// StackAdditions the values added by this opcode to the stack.
  final List<AlgoRestTypesAvmValue>? stackAdditions;

  /// StackPopCount the number of deleted stack values by this opcode.
  final BigInt? stackPopCount;

  /// StateChanges the operations against the current application's states.
  final List<AlgoRestTypesApplicationStateOperation>? stateChanges;

  const AlgoRestTypesSimulationOpcodeTraceUnit({
    required this.pc,
    this.scratchChanges,
    this.spawnedInners,
    this.stackAdditions,
    this.stackPopCount,
    this.stateChanges,
  });

  factory AlgoRestTypesSimulationOpcodeTraceUnit.fromJson(
    Map<String, dynamic> json,
  ) {
    return AlgoRestTypesSimulationOpcodeTraceUnit(
      pc: json.valueAsBigInt("pc", onMissing: () => BigInt.zero),
      scratchChanges: json.valueTo<List<AlgoRestTypesScratchChange>?, List>(
        key: "scratch-changes",
        parse:
            (e) =>
                e
                    .map(
                      (x) => AlgoRestTypesScratchChange.fromJson(
                        JsonParser.valueEnsureAsMap(x),
                      ),
                    )
                    .toList(),
      ),
      spawnedInners: json.valueAsList<List<BigInt>?>("spawned-inners"),
      stackAdditions: json.valueTo<List<AlgoRestTypesAvmValue>?, List>(
        key: "stack-additions",
        parse:
            (e) =>
                e
                    .map(
                      (x) => AlgoRestTypesAvmValue.fromJson(
                        JsonParser.valueEnsureAsMap(x),
                      ),
                    )
                    .toList(),
      ),
      stackPopCount: json.valueAsBigInt("stack-pop-count"),
      stateChanges: json
          .valueTo<List<AlgoRestTypesApplicationStateOperation>?, List>(
            key: "state-changes",
            parse:
                (e) =>
                    e
                        .map(
                          (x) =>
                              AlgoRestTypesApplicationStateOperation.fromJson(
                                JsonParser.valueEnsureAsMap(x),
                              ),
                        )
                        .toList(),
          ),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "pc": pc,
      "scratch-changes": scratchChanges?.map((e) => e.toJson()).toList(),
      "spawned-inners": spawnedInners?.map((e) => e).toList(),
      "stack-additions": stackAdditions?.map((e) => e.toJson()).toList(),
      "stack-pop-count": stackPopCount,
      "state-changes": stateChanges?.map((e) => e.toJson()).toList(),
    }.notNullValue;
  }
}

/// SimulationTransactionExecTrace the execution trace of calling an app or a logic sig, containing the inner app call trace in a recursive way.
class AlgoRestTypesSimulationTransactionExecTrace {
  /// ApprovalProgramHash sHA512_256 hash digest of the approval program executed in transaction.
  final BuBytes? approvalProgramHash;

  /// ApprovalProgramTrace program trace that contains a trace of opcode effects in an approval program.
  final List<AlgoRestTypesSimulationOpcodeTraceUnit>? approvalProgramTrace;

  /// ClearStateProgramHash sHA512_256 hash digest of the clear state program executed in transaction.
  final BuBytes? clearStateProgramHash;

  /// ClearStateProgramTrace program trace that contains a trace of opcode effects in a clear state program.
  final List<AlgoRestTypesSimulationOpcodeTraceUnit>? clearStateProgramTrace;

  /// ClearStateRollback if true, indicates that the clear state program failed and any persistent state changes it produced should be reverted once the program exits.
  final bool? clearStateRollback;

  /// ClearStateRollbackError the error message explaining why the clear state program failed. This field will only be populated if clear-state-rollback is true and the failure was due to an execution error.
  final String? clearStateRollbackError;

  /// InnerTrace an array of SimulationTransactionExecTrace representing the execution trace of any inner transactions executed.
  final List<AlgoRestTypesSimulationTransactionExecTrace>? innerTrace;

  /// LogicSigHash sHA512_256 hash digest of the logic sig executed in transaction.
  final BuBytes? logicSigHash;

  /// LogicSigTrace program trace that contains a trace of opcode effects in a logic sig.
  final List<AlgoRestTypesSimulationOpcodeTraceUnit>? logicSigTrace;

  AlgoRestTypesSimulationTransactionExecTrace({
    List<int>? approvalProgramHash,
    this.approvalProgramTrace,
    List<int>? clearStateProgramHash,
    this.clearStateProgramTrace,
    this.clearStateRollback,
    this.clearStateRollbackError,
    this.innerTrace,
    List<int>? logicSigHash,
    this.logicSigTrace,
  }) : logicSigHash = logicSigHash?.asImmutableBytes, clearStateProgramHash = clearStateProgramHash?.asImmutableBytes, approvalProgramHash = approvalProgramHash?.asImmutableBytes;

  factory AlgoRestTypesSimulationTransactionExecTrace.fromJson(
    Map<String, dynamic> json,
  ) {
    return AlgoRestTypesSimulationTransactionExecTrace(
      approvalProgramHash: json.valueAsBytes(
        "approval-program-hash",
        encoding: StringEncoding.base64,
      ),
      approvalProgramTrace: json
          .valueTo<List<AlgoRestTypesSimulationOpcodeTraceUnit>?, List>(
            key: "approval-program-trace",
            parse:
                (e) =>
                    e
                        .map(
                          (x) =>
                              AlgoRestTypesSimulationOpcodeTraceUnit.fromJson(
                                JsonParser.valueEnsureAsMap(x),
                              ),
                        )
                        .toList(),
          ),
      clearStateProgramHash: json.valueAsBytes(
        "clear-state-program-hash",
        encoding: StringEncoding.base64,
      ),
      clearStateProgramTrace: json
          .valueTo<List<AlgoRestTypesSimulationOpcodeTraceUnit>?, List>(
            key: "clear-state-program-trace",
            parse:
                (e) =>
                    e
                        .map(
                          (x) =>
                              AlgoRestTypesSimulationOpcodeTraceUnit.fromJson(
                                JsonParser.valueEnsureAsMap(x),
                              ),
                        )
                        .toList(),
          ),
      clearStateRollback: json.valueAsBool("clear-state-rollback"),
      clearStateRollbackError: json.valueAsString(
        "clear-state-rollback-error",
        bytesEncoding: StringEncoding.utf8,
      ),
      innerTrace: json.valueTo<
        List<AlgoRestTypesSimulationTransactionExecTrace>?,
        List
      >(
        key: "inner-trace",
        parse:
            (e) =>
                e
                    .map(
                      (x) =>
                          AlgoRestTypesSimulationTransactionExecTrace.fromJson(
                            JsonParser.valueEnsureAsMap(x),
                          ),
                    )
                    .toList(),
      ),
      logicSigHash: json.valueAsBytes(
        "logic-sig-hash",
        encoding: StringEncoding.base64,
      ),
      logicSigTrace: json
          .valueTo<List<AlgoRestTypesSimulationOpcodeTraceUnit>?, List>(
            key: "logic-sig-trace",
            parse:
                (e) =>
                    e
                        .map(
                          (x) =>
                              AlgoRestTypesSimulationOpcodeTraceUnit.fromJson(
                                JsonParser.valueEnsureAsMap(x),
                              ),
                        )
                        .toList(),
          ),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "approval-program-hash": approvalProgramHash,
      "approval-program-trace":
          approvalProgramTrace?.map((e) => e.toJson()).toList(),
      "clear-state-program-hash": clearStateProgramHash,
      "clear-state-program-trace":
          clearStateProgramTrace?.map((e) => e.toJson()).toList(),
      "clear-state-rollback": clearStateRollback,
      "clear-state-rollback-error": clearStateRollbackError,
      "inner-trace": innerTrace?.map((e) => e.toJson()).toList(),
      "logic-sig-hash": logicSigHash,
      "logic-sig-trace": logicSigTrace?.map((e) => e.toJson()).toList(),
    }.notNullValue;
  }
}

/// StateProof represents a state proof and its corresponding message
class AlgoRestTypesStateProof {
  /// Message represents the message that the state proofs are attesting to.
  final AlgoRestTypesStateProofMessage message;

  /// Stateproof the encoded StateProof for the message.
  final BuBytes stateproof;

  AlgoRestTypesStateProof({
    required this.message,
    required List<int> stateproof,
  }) : stateproof = stateproof.asImmutableBytes;

  factory AlgoRestTypesStateProof.fromJson(Map<String, dynamic> json) {
    return AlgoRestTypesStateProof(
      message: json.valueTo<AlgoRestTypesStateProofMessage, Map>(
        key: "Message",
        parse:
            (e) => AlgoRestTypesStateProofMessage.fromJson(
              JsonParser.valueEnsureAsMap(e),
            ),
      ),
      stateproof: json.valueAsBytes(
        "StateProof",
        encoding: StringEncoding.base64,
        onMissing: () => [],
      ),
    );
  }

  Map<String, dynamic> toJson() {
    return {"Message": message.toJson(), "StateProof": stateproof}.notNullValue;
  }
}

/// StateProofFields (sp) represents a state proof. Definition: crypto/stateproof/structs.go : StateProof
class AlgoRestTypesStateProofFields {
  /// PartProofs (P)
  final AlgoRestTypesMerkleArrayProof? partProofs;

  /// PositionsToReveal (pr) Sequence of reveal positions.
  final List<BigInt>? positionsToReveal;

  /// Reveals (r) Note that this is actually stored as a map[uint64] - Reveal in the actual msgp
  final List<AlgoRestTypesStateProofReveal>? reveals;

  /// SaltVersion (v) Salt version of the merkle signature.
  final BigInt? saltVersion;

  /// SigCommit (c)
  final BuBytes? sigCommit;

  /// SigProofs (S)
  final AlgoRestTypesMerkleArrayProof? sigProofs;

  /// SignedWeight (w)
  final BigInt? signedWeight;

  AlgoRestTypesStateProofFields({
    this.partProofs,
    this.positionsToReveal,
    this.reveals,
    this.saltVersion,
    List<int>? sigCommit,
    this.sigProofs,
    this.signedWeight,
  }) : sigCommit = sigCommit?.asImmutableBytes;

  factory AlgoRestTypesStateProofFields.fromJson(Map<String, dynamic> json) {
    return AlgoRestTypesStateProofFields(
      partProofs: json.valueTo<AlgoRestTypesMerkleArrayProof?, Map>(
        key: "part-proofs",
        parse:
            (e) => AlgoRestTypesMerkleArrayProof.fromJson(
              JsonParser.valueEnsureAsMap(e),
            ),
      ),
      positionsToReveal: json.valueAsList<List<BigInt>?>("positions-to-reveal"),
      reveals: json.valueTo<List<AlgoRestTypesStateProofReveal>?, List>(
        key: "reveals",
        parse:
            (e) =>
                e
                    .map(
                      (x) => AlgoRestTypesStateProofReveal.fromJson(
                        JsonParser.valueEnsureAsMap(x),
                      ),
                    )
                    .toList(),
      ),
      saltVersion: json.valueAsBigInt("salt-version"),
      sigCommit: json.valueAsBytes(
        "sig-commit",
        encoding: StringEncoding.base64,
      ),
      sigProofs: json.valueTo<AlgoRestTypesMerkleArrayProof?, Map>(
        key: "sig-proofs",
        parse:
            (e) => AlgoRestTypesMerkleArrayProof.fromJson(
              JsonParser.valueEnsureAsMap(e),
            ),
      ),
      signedWeight: json.valueAsBigInt("signed-weight"),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "part-proofs": partProofs?.toJson(),
      "positions-to-reveal": positionsToReveal?.map((e) => e).toList(),
      "reveals": reveals?.map((e) => e.toJson()).toList(),
      "salt-version": saltVersion,
      "sig-commit": sigCommit,
      "sig-proofs": sigProofs?.toJson(),
      "signed-weight": signedWeight,
    }.notNullValue;
  }
}

/// StateProofMessage represents the message that the state proofs are attesting to.
class AlgoRestTypesStateProofMessage {
  /// Blockheaderscommitment the vector commitment root on all light block headers within a state proof interval.
  final BuBytes blockheaderscommitment;

  /// Firstattestedround the first round the message attests to.
  final BigInt firstattestedround;

  /// Lastattestedround the last round the message attests to.
  final BigInt lastattestedround;

  /// Lnprovenweight an integer value representing the natural log of the proven weight with 16 bits of precision. This value would be used to verify the next state proof.
  final BigInt lnprovenweight;

  /// Voterscommitment the vector commitment root of the top N accounts to sign the next StateProof.
  final BuBytes voterscommitment;

  AlgoRestTypesStateProofMessage({
    required List<int> blockheaderscommitment,
    required this.firstattestedround,
    required this.lastattestedround,
    required this.lnprovenweight,
    required List<int> voterscommitment,
  }) : voterscommitment = voterscommitment.asImmutableBytes, blockheaderscommitment = blockheaderscommitment.asImmutableBytes;

  factory AlgoRestTypesStateProofMessage.fromJson(Map<String, dynamic> json) {
    return AlgoRestTypesStateProofMessage(
      blockheaderscommitment: json.valueAsBytes(
        "BlockHeadersCommitment",
        encoding: StringEncoding.base64,
        onMissing: () => [],
      ),
      firstattestedround: json.valueAsBigInt(
        "FirstAttestedRound",
        onMissing: () => BigInt.zero,
      ),
      lastattestedround: json.valueAsBigInt(
        "LastAttestedRound",
        onMissing: () => BigInt.zero,
      ),
      lnprovenweight: json.valueAsBigInt(
        "LnProvenWeight",
        onMissing: () => BigInt.zero,
      ),
      voterscommitment: json.valueAsBytes(
        "VotersCommitment",
        encoding: StringEncoding.base64,
        onMissing: () => [],
      ),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "BlockHeadersCommitment": blockheaderscommitment,
      "FirstAttestedRound": firstattestedround,
      "LastAttestedRound": lastattestedround,
      "LnProvenWeight": lnprovenweight,
      "VotersCommitment": voterscommitment,
    }.notNullValue;
  }
}

/// StateProofParticipant defines a model for StateProofParticipant.
class AlgoRestTypesStateProofParticipant {
  /// Verifier (p)
  final AlgoRestTypesStateProofVerifier? verifier;

  /// Weight (w)
  final BigInt? weight;

  const AlgoRestTypesStateProofParticipant({this.verifier, this.weight});

  factory AlgoRestTypesStateProofParticipant.fromJson(
    Map<String, dynamic> json,
  ) {
    return AlgoRestTypesStateProofParticipant(
      verifier: json.valueTo<AlgoRestTypesStateProofVerifier?, Map>(
        key: "verifier",
        parse:
            (e) => AlgoRestTypesStateProofVerifier.fromJson(
              JsonParser.valueEnsureAsMap(e),
            ),
      ),
      weight: json.valueAsBigInt("weight"),
    );
  }

  Map<String, dynamic> toJson() {
    return {"verifier": verifier?.toJson(), "weight": weight}.notNullValue;
  }
}

/// StateProofReveal defines a model for StateProofReveal.
class AlgoRestTypesStateProofReveal {
  /// Participant (p)
  final AlgoRestTypesStateProofParticipant? participant;

  /// Position the position in the signature and participants arrays corresponding to this entry.
  final BigInt? position;

  /// SigSlot (s)
  final AlgoRestTypesStateProofSigSlot? sigSlot;

  const AlgoRestTypesStateProofReveal({
    this.participant,
    this.position,
    this.sigSlot,
  });

  factory AlgoRestTypesStateProofReveal.fromJson(Map<String, dynamic> json) {
    return AlgoRestTypesStateProofReveal(
      participant: json.valueTo<AlgoRestTypesStateProofParticipant?, Map>(
        key: "participant",
        parse:
            (e) => AlgoRestTypesStateProofParticipant.fromJson(
              JsonParser.valueEnsureAsMap(e),
            ),
      ),
      position: json.valueAsBigInt("position"),
      sigSlot: json.valueTo<AlgoRestTypesStateProofSigSlot?, Map>(
        key: "sig-slot",
        parse:
            (e) => AlgoRestTypesStateProofSigSlot.fromJson(
              JsonParser.valueEnsureAsMap(e),
            ),
      ),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "participant": participant?.toJson(),
      "position": position,
      "sig-slot": sigSlot?.toJson(),
    }.notNullValue;
  }
}

/// StateProofSigSlot defines a model for StateProofSigSlot.
class AlgoRestTypesStateProofSigSlot {
  /// LowerSigWeight (l) The total weight of signatures in the lower-numbered slots.
  final BigInt? lowerSigWeight;

  /// Signature
  final AlgoRestTypesStateProofSignature? signature;

  AlgoRestTypesStateProofSigSlot({this.lowerSigWeight, this.signature}) ;

  factory AlgoRestTypesStateProofSigSlot.fromJson(Map<String, dynamic> json) {
    return AlgoRestTypesStateProofSigSlot(
      lowerSigWeight: json.valueAsBigInt("lower-sig-weight"),
      signature: json.valueTo<AlgoRestTypesStateProofSignature?, Map>(
        key: "signature",
        parse:
            (e) => AlgoRestTypesStateProofSignature.fromJson(
              JsonParser.valueEnsureAsMap(e),
            ),
      ),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "lower-sig-weight": lowerSigWeight,
      "signature": signature?.toJson(),
    }.notNullValue;
  }
}

/// StateProofSignature defines a model for StateProofSignature.
class AlgoRestTypesStateProofSignature {
  /// FalconSignature
  final BuBytes? falconSignature;

  /// MerkleArrayIndex
  final BigInt? merkleArrayIndex;

  /// Proof
  final AlgoRestTypesMerkleArrayProof? proof;

  /// VerifyingKey (vkey)
  final BuBytes? verifyingKey;

  AlgoRestTypesStateProofSignature({
    List<int>? falconSignature,
    this.merkleArrayIndex,
    this.proof,
    List<int>? verifyingKey,
  }) : verifyingKey = verifyingKey?.asImmutableBytes, falconSignature = falconSignature?.asImmutableBytes;

  factory AlgoRestTypesStateProofSignature.fromJson(Map<String, dynamic> json) {
    return AlgoRestTypesStateProofSignature(
      falconSignature: json.valueAsBytes(
        "falcon-signature",
        encoding: StringEncoding.base64,
      ),
      merkleArrayIndex: json.valueAsBigInt("merkle-array-index"),
      proof: json.valueTo<AlgoRestTypesMerkleArrayProof?, Map>(
        key: "proof",
        parse:
            (e) => AlgoRestTypesMerkleArrayProof.fromJson(
              JsonParser.valueEnsureAsMap(e),
            ),
      ),
      verifyingKey: json.valueAsBytes(
        "verifying-key",
        encoding: StringEncoding.base64,
      ),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "falcon-signature": falconSignature,
      "merkle-array-index": merkleArrayIndex,
      "proof": proof?.toJson(),
      "verifying-key": verifyingKey,
    }.notNullValue;
  }
}

/// StateProofTracking defines a model for StateProofTracking.
class AlgoRestTypesStateProofTracking {
  /// NextRound (n) Next round for which we will accept a state proof transaction.
  final BigInt? nextRound;

  /// OnlineTotalWeight (t) The total number of microalgos held by the online accounts during the StateProof round.
  final BigInt? onlineTotalWeight;

  /// Type state Proof Type. Note the raw object uses map with this as key.
  final BigInt? type;

  /// VotersCommitment (v) Root of a vector commitment containing online accounts that will help sign the proof.
  final BuBytes? votersCommitment;

  AlgoRestTypesStateProofTracking({
    this.nextRound,
    this.onlineTotalWeight,
    this.type,
    List<int>? votersCommitment,
  }) : votersCommitment = votersCommitment?.asImmutableBytes;

  factory AlgoRestTypesStateProofTracking.fromJson(Map<String, dynamic> json) {
    return AlgoRestTypesStateProofTracking(
      nextRound: json.valueAsBigInt("next-round"),
      onlineTotalWeight: json.valueAsBigInt("online-total-weight"),
      type: json.valueAsBigInt("type"),
      votersCommitment: json.valueAsBytes(
        "voters-commitment",
        encoding: StringEncoding.base64,
      ),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "next-round": nextRound,
      "online-total-weight": onlineTotalWeight,
      "type": type,
      "voters-commitment": votersCommitment,
    }.notNullValue;
  }
}

/// StateProofVerifier defines a model for StateProofVerifier.
class AlgoRestTypesStateProofVerifier {
  /// Commitment (cmt) Represents the root of the vector commitment tree.
  final BuBytes? commitment;

  /// KeyLifetime (lf) Key lifetime.
  final BigInt? keyLifetime;

  AlgoRestTypesStateProofVerifier({List<int>? commitment, this.keyLifetime}) : commitment = commitment?.asImmutableBytes;

  factory AlgoRestTypesStateProofVerifier.fromJson(Map<String, dynamic> json) {
    return AlgoRestTypesStateProofVerifier(
      commitment: json.valueAsBytes(
        "commitment",
        encoding: StringEncoding.base64,
      ),
      keyLifetime: json.valueAsBigInt("key-lifetime"),
    );
  }

  Map<String, dynamic> toJson() {
    return {"commitment": commitment, "key-lifetime": keyLifetime}.notNullValue;
  }
}

/// StateSchema represents a (apls) local-state or (apgs) global-state schema. These schemas determine how much storage may be used in a local-state or global-state for an application. The more space used, the larger minimum balance must be maintained in the account holding the data.
class AlgoRestTypesStateSchema {
  /// NumByteSlice maximum number of TEAL byte slices that may be stored in the key/value store.
  final BigInt numByteSlice;

  /// NumUint maximum number of TEAL uints that may be stored in the key/value store.
  final BigInt numUint;

  const AlgoRestTypesStateSchema({
    required this.numByteSlice,
    required this.numUint,
  });

  factory AlgoRestTypesStateSchema.fromJson(Map<String, dynamic> json) {
    return AlgoRestTypesStateSchema(
      numByteSlice: json.valueAsBigInt(
        "num-byte-slice",
        onMissing: () => BigInt.zero,
      ),
      numUint: json.valueAsBigInt("num-uint", onMissing: () => BigInt.zero),
    );
  }

  Map<String, dynamic> toJson() {
    return {"num-byte-slice": numByteSlice, "num-uint": numUint}.notNullValue;
  }
}

/// SupplyResponse supply represents the current supply of MicroAlgos in the system.
class AlgoRestTypesSupplyResponse {
  /// Current_round round
  final BigInt currentRound;

  /// OnlineMoney total stake held by accounts with status Online at current_round, including those whose participation keys have expired but have not yet been marked offline.
  final BigInt onlineMoney;

  /// OnlineStake online stake used by agreement to vote for current_round, excluding accounts whose participation keys have expired.
  final BigInt onlineStake;

  /// TotalMoney totalMoney
  final BigInt totalMoney;

  const AlgoRestTypesSupplyResponse({
    required this.currentRound,
    required this.onlineMoney,
    required this.onlineStake,
    required this.totalMoney,
  });

  factory AlgoRestTypesSupplyResponse.fromJson(Map<String, dynamic> json) {
    return AlgoRestTypesSupplyResponse(
      currentRound: json.valueAsBigInt(
        "current_round",
        onMissing: () => BigInt.zero,
      ),
      onlineMoney: json.valueAsBigInt(
        "online-money",
        onMissing: () => BigInt.zero,
      ),
      onlineStake: json.valueAsBigInt(
        "online-stake",
        onMissing: () => BigInt.zero,
      ),
      totalMoney: json.valueAsBigInt(
        "total-money",
        onMissing: () => BigInt.zero,
      ),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "current_round": currentRound,
      "online-money": onlineMoney,
      "online-stake": onlineStake,
      "total-money": totalMoney,
    }.notNullValue;
  }
}

/// TealKeyValue represents a key-value pair in an application store.
class AlgoRestTypesTealKeyValue {
  /// Key
  final String key;

  /// Value represents a TEAL value.
  final AlgoRestTypesTealValue value;

  AlgoRestTypesTealKeyValue({required this.key, required this.value}) ;

  factory AlgoRestTypesTealKeyValue.fromJson(Map<String, dynamic> json) {
    return AlgoRestTypesTealKeyValue(
      key: json.valueAsString(
        "key",
        bytesEncoding: StringEncoding.utf8,
        onMissing: () => '',
      ),
      value: json.valueTo<AlgoRestTypesTealValue, Map>(
        key: "value",
        parse:
            (e) =>
                AlgoRestTypesTealValue.fromJson(JsonParser.valueEnsureAsMap(e)),
      ),
    );
  }

  Map<String, dynamic> toJson() {
    return {"key": key, "value": value.toJson()}.notNullValue;
  }
}

/// TealValue represents a TEAL value.
class AlgoRestTypesTealValue {
  /// Bytes bytes value.
  final String bytes;

  /// Type type of the value. Value `1` refers to **bytes**, value `2` refers to **uint**
  final BigInt type;

  /// Uint uint value.
  final BigInt uint;

  AlgoRestTypesTealValue({
    required this.bytes,
    required this.type,
    required this.uint,
  }) ;

  factory AlgoRestTypesTealValue.fromJson(Map<String, dynamic> json) {
    return AlgoRestTypesTealValue(
      bytes: json.valueAsString(
        "bytes",
        bytesEncoding: StringEncoding.utf8,
        onMissing: () => '',
      ),
      type: json.valueAsBigInt("type", onMissing: () => BigInt.zero),
      uint: json.valueAsBigInt("uint", onMissing: () => BigInt.zero),
    );
  }

  Map<String, dynamic> toJson() {
    return {"bytes": bytes, "type": type, "uint": uint}.notNullValue;
  }
}

/// Transaction contains all fields common to all transactions and serves as an envelope to all transactions type. Represents both regular and inner transactions. Definition: data/transactions/signedtxn.go : SignedTxn data/transactions/transaction.go : Transaction
class AlgoRestTypesTransaction {
  /// ApplicationTransaction fields for application transactions. Definition: data/transactions/application.go : ApplicationCallTxnFields
  final AlgoRestTypesTransactionApplication? applicationTransaction;

  /// AssetConfigTransaction fields for asset allocation, re-configuration, and destruction. A zero value for asset-id indicates asset creation. A zero value for the params indicates asset destruction. Definition: data/transactions/asset.go : AssetConfigTxnFields
  final AlgoRestTypesTransactionAssetConfig? assetConfigTransaction;

  /// AssetFreezeTransaction fields for an asset freeze transaction. Definition: data/transactions/asset.go : AssetFreezeTxnFields
  final AlgoRestTypesTransactionAssetFreeze? assetFreezeTransaction;

  /// AssetTransferTransaction fields for an asset transfer transaction. Definition: data/transactions/asset.go : AssetTransferTxnFields
  final AlgoRestTypesTransactionAssetTransfer? assetTransferTransaction;

  /// AuthAddr (sgnr) this is included with signed transactions when the signing address does not equal the sender. The backend can use this to ensure that auth addr is equal to the accounts auth addr.
  final String? authAddr;

  /// CloseRewards (rc) rewards applied to close-remainder-to account.
  final BigInt? closeRewards;

  /// ClosingAmount (ca) closing amount for transaction.
  final BigInt? closingAmount;

  /// ConfirmedRound round when the transaction was confirmed.
  final BigInt? confirmedRound;

  /// CreatedApplicationIndex specifies an application index (ID) if an application was created with this transaction.
  final BigInt? createdApplicationIndex;

  /// CreatedAssetIndex specifies an asset index (ID) if an asset was created with this transaction.
  final BigInt? createdAssetIndex;

  /// Fee (fee) Transaction fee.
  final BigInt fee;

  /// FirstValid (fv) First valid round for this transaction.
  final BigInt firstValid;

  /// GenesisHash (gh) Hash of genesis block.
  final BuBytes? genesisHash;

  /// GenesisId (gen) genesis block ID.
  final String? genesisId;

  /// GlobalStateDelta (gd) Global state key/value changes for the application being executed by this transaction.
  final List<AlgoRestTypesEvalDeltaKeyValue>? globalStateDelta;

  /// Group (grp) Base64 encoded byte array of a sha512/256 digest. When present indicates that this transaction is part of a transaction group and the value is the sha512/256 hash of the transactions in that group.
  final BuBytes? group;

  /// HeartbeatTransaction fields for a heartbeat transaction. Definition: data/transactions/heartbeat.go : HeartbeatTxnFields
  final AlgoRestTypesTransactionHeartbeat? heartbeatTransaction;

  /// Id transaction ID
  final String? id;

  /// InnerTxns inner transactions produced by application execution.
  final List<AlgoRestTypesTransaction>? innerTxns;

  /// IntraRoundOffset offset into the round where this transaction was confirmed.
  final BigInt? intraRoundOffset;

  /// KeyregTransaction fields for a keyreg transaction. Definition: data/transactions/keyreg.go : KeyregTxnFields
  final AlgoRestTypesTransactionKeyreg? keyregTransaction;

  /// LastValid (lv) Last valid round for this transaction.
  final BigInt lastValid;

  /// Lease (lx) Base64 encoded 32-byte array. Lease enforces mutual exclusion of transactions. If this field is nonzero, then once the transaction is confirmed, it acquires the lease identified by the (Sender, Lease) pair of the transaction until the LastValid round passes. While this transaction possesses the lease, no other transaction specifying this lease can be confirmed.
  final BuBytes? lease;

  /// LocalStateDelta (ld) Local state key/value changes for the application being executed by this transaction.
  final List<AlgoRestTypesAccountStateDelta>? localStateDelta;

  /// Logs (lg) Logs for the application being executed by this transaction.
  final List<BuBytes>? logs;

  /// Note (note) Free form data.
  final BuBytes? note;

  /// PaymentTransaction fields for a payment transaction. Definition: data/transactions/payment.go : PaymentTxnFields
  final AlgoRestTypesTransactionPayment? paymentTransaction;

  /// ReceiverRewards (rr) rewards applied to receiver account.
  final BigInt? receiverRewards;

  /// RekeyTo (rekey) when included in a valid transaction, the accounts auth addr will be updated with this value and future signatures must be signed with the key represented by this address.
  final String? rekeyTo;

  /// RoundTime time when the block this transaction is in was confirmed.
  final BigInt? roundTime;

  /// Sender (snd) Sender's address.
  final String sender;

  /// SenderRewards (rs) rewards applied to sender account.
  final BigInt? senderRewards;

  /// Signature validation signature associated with some data. Only one of the signatures should be provided.
  final AlgoRestTypesTransactionSignature? signature;

  /// StateProofTransaction fields for a state proof transaction. Definition: data/transactions/stateproof.go : StateProofTxnFields
  final AlgoRestTypesTransactionStateProof? stateProofTransaction;

  /// Type (type) Indicates what type of transaction this is. Different types have different fields. Valid types, and where their fields are stored: * (pay) payment-transaction * (keyreg) keyreg-transaction * (acfg) asset-config-transaction * (axfer) asset-transfer-transaction * (afrz) asset-freeze-transaction * (appl) application-transaction * (stpf) state-proof-transaction * (hb) heartbeat-transaction
  final String? type;

  AlgoRestTypesTransaction({
    this.applicationTransaction,
    this.assetConfigTransaction,
    this.assetFreezeTransaction,
    this.assetTransferTransaction,
    this.authAddr,
    this.closeRewards,
    this.closingAmount,
    this.confirmedRound,
    this.createdApplicationIndex,
    this.createdAssetIndex,
    required this.fee,
    required this.firstValid,
    List<int>? genesisHash,
    this.genesisId,
    this.globalStateDelta,
    List<int>? group,
    this.heartbeatTransaction,
    this.id,
    this.innerTxns,
    this.intraRoundOffset,
    this.keyregTransaction,
    required this.lastValid,
    List<int>? lease,
    this.localStateDelta,
    List<List<int>>? logs,
    List<int>? note,
    this.paymentTransaction,
    this.receiverRewards,
    this.rekeyTo,
    this.roundTime,
    required this.sender,
    this.senderRewards,
    this.signature,
    this.stateProofTransaction,
    this.type,
  }) : genesisHash = genesisHash?.asImmutableBytes, note = note?.asImmutableBytes, logs = logs?.map((e) => e.asImmutableBytes).toImutableList, lease = lease?.asImmutableBytes, group = group?.asImmutableBytes;

  factory AlgoRestTypesTransaction.fromJson(Map<String, dynamic> json) {
    return AlgoRestTypesTransaction(
      applicationTransaction: json
          .valueTo<AlgoRestTypesTransactionApplication?, Map>(
            key: "application-transaction",
            parse:
                (e) => AlgoRestTypesTransactionApplication.fromJson(
                  JsonParser.valueEnsureAsMap(e),
                ),
          ),
      assetConfigTransaction: json
          .valueTo<AlgoRestTypesTransactionAssetConfig?, Map>(
            key: "asset-config-transaction",
            parse:
                (e) => AlgoRestTypesTransactionAssetConfig.fromJson(
                  JsonParser.valueEnsureAsMap(e),
                ),
          ),
      assetFreezeTransaction: json
          .valueTo<AlgoRestTypesTransactionAssetFreeze?, Map>(
            key: "asset-freeze-transaction",
            parse:
                (e) => AlgoRestTypesTransactionAssetFreeze.fromJson(
                  JsonParser.valueEnsureAsMap(e),
                ),
          ),
      assetTransferTransaction: json
          .valueTo<AlgoRestTypesTransactionAssetTransfer?, Map>(
            key: "asset-transfer-transaction",
            parse:
                (e) => AlgoRestTypesTransactionAssetTransfer.fromJson(
                  JsonParser.valueEnsureAsMap(e),
                ),
          ),
      authAddr: json.valueAsString(
        "auth-addr",
        bytesEncoding: StringEncoding.utf8,
      ),
      closeRewards: json.valueAsBigInt("close-rewards"),
      closingAmount: json.valueAsBigInt("closing-amount"),
      confirmedRound: json.valueAsBigInt("confirmed-round"),
      createdApplicationIndex: json.valueAsBigInt("created-application-index"),
      createdAssetIndex: json.valueAsBigInt("created-asset-index"),
      fee: json.valueAsBigInt("fee", onMissing: () => BigInt.zero),
      firstValid: json.valueAsBigInt(
        "first-valid",
        onMissing: () => BigInt.zero,
      ),
      genesisHash: json.valueAsBytes(
        "genesis-hash",
        encoding: StringEncoding.base64,
      ),
      genesisId: json.valueAsString(
        "genesis-id",
        bytesEncoding: StringEncoding.utf8,
      ),
      globalStateDelta: json
          .valueTo<List<AlgoRestTypesEvalDeltaKeyValue>?, List>(
            key: "global-state-delta",
            parse:
                (e) =>
                    e
                        .map(
                          (x) => AlgoRestTypesEvalDeltaKeyValue.fromJson(
                            JsonParser.valueEnsureAsMap(x),
                          ),
                        )
                        .toList(),
          ),
      group: json.valueAsBytes("group", encoding: StringEncoding.base64),
      heartbeatTransaction: json
          .valueTo<AlgoRestTypesTransactionHeartbeat?, Map>(
            key: "heartbeat-transaction",
            parse:
                (e) => AlgoRestTypesTransactionHeartbeat.fromJson(
                  JsonParser.valueEnsureAsMap(e),
                ),
          ),
      id: json.valueAsString("id", bytesEncoding: StringEncoding.utf8),
      innerTxns: json.valueTo<List<AlgoRestTypesTransaction>?, List>(
        key: "inner-txns",
        parse:
            (e) =>
                e
                    .map(
                      (x) => AlgoRestTypesTransaction.fromJson(
                        JsonParser.valueEnsureAsMap(x),
                      ),
                    )
                    .toList(),
      ),
      intraRoundOffset: json.valueAsBigInt("intra-round-offset"),
      keyregTransaction: json.valueTo<AlgoRestTypesTransactionKeyreg?, Map>(
        key: "keyreg-transaction",
        parse:
            (e) => AlgoRestTypesTransactionKeyreg.fromJson(
              JsonParser.valueEnsureAsMap(e),
            ),
      ),
      lastValid: json.valueAsBigInt("last-valid", onMissing: () => BigInt.zero),
      lease: json.valueAsBytes("lease", encoding: StringEncoding.base64),
      localStateDelta: json
          .valueTo<List<AlgoRestTypesAccountStateDelta>?, List>(
            key: "local-state-delta",
            parse:
                (e) =>
                    e
                        .map(
                          (x) => AlgoRestTypesAccountStateDelta.fromJson(
                            JsonParser.valueEnsureAsMap(x),
                          ),
                        )
                        .toList(),
          ),
      logs: json.valueTo<List<List<int>>?, List>(
        key: "logs",
        parse:
            (e) =>
                e
                    .map(
                      (x) => JsonParser.valueAsBytes<List<int>>(
                        x,
                        encoding: StringEncoding.base64,
                      ),
                    )
                    .toList(),
      ),
      note: json.valueAsBytes("note", encoding: StringEncoding.base64),
      paymentTransaction: json.valueTo<AlgoRestTypesTransactionPayment?, Map>(
        key: "payment-transaction",
        parse:
            (e) => AlgoRestTypesTransactionPayment.fromJson(
              JsonParser.valueEnsureAsMap(e),
            ),
      ),
      receiverRewards: json.valueAsBigInt("receiver-rewards"),
      rekeyTo: json.valueAsString(
        "rekey-to",
        bytesEncoding: StringEncoding.utf8,
      ),
      roundTime: json.valueAsBigInt("round-time"),
      sender: json.valueAsString(
        "sender",
        bytesEncoding: StringEncoding.utf8,
        onMissing: () => '',
      ),
      senderRewards: json.valueAsBigInt("sender-rewards"),
      signature: json.valueTo<AlgoRestTypesTransactionSignature?, Map>(
        key: "signature",
        parse:
            (e) => AlgoRestTypesTransactionSignature.fromJson(
              JsonParser.valueEnsureAsMap(e),
            ),
      ),
      stateProofTransaction: json
          .valueTo<AlgoRestTypesTransactionStateProof?, Map>(
            key: "state-proof-transaction",
            parse:
                (e) => AlgoRestTypesTransactionStateProof.fromJson(
                  JsonParser.valueEnsureAsMap(e),
                ),
          ),
      type: json.valueAsString("tx-type", bytesEncoding: StringEncoding.utf8),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "application-transaction": applicationTransaction?.toJson(),
      "asset-config-transaction": assetConfigTransaction?.toJson(),
      "asset-freeze-transaction": assetFreezeTransaction?.toJson(),
      "asset-transfer-transaction": assetTransferTransaction?.toJson(),
      "auth-addr": authAddr,
      "close-rewards": closeRewards,
      "closing-amount": closingAmount,
      "confirmed-round": confirmedRound,
      "created-application-index": createdApplicationIndex,
      "created-asset-index": createdAssetIndex,
      "fee": fee,
      "first-valid": firstValid,
      "genesis-hash": genesisHash,
      "genesis-id": genesisId,
      "global-state-delta": globalStateDelta?.map((e) => e.toJson()).toList(),
      "group": group,
      "heartbeat-transaction": heartbeatTransaction?.toJson(),
      "id": id,
      "inner-txns": innerTxns?.map((e) => e.toJson()).toList(),
      "intra-round-offset": intraRoundOffset,
      "keyreg-transaction": keyregTransaction?.toJson(),
      "last-valid": lastValid,
      "lease": lease,
      "local-state-delta": localStateDelta?.map((e) => e.toJson()).toList(),
      "logs": logs,
      "note": note,
      "payment-transaction": paymentTransaction?.toJson(),
      "receiver-rewards": receiverRewards,
      "rekey-to": rekeyTo,
      "round-time": roundTime,
      "sender": sender,
      "sender-rewards": senderRewards,
      "signature": signature?.toJson(),
      "state-proof-transaction": stateProofTransaction?.toJson(),
      "tx-type": type,
    }.notNullValue;
  }
}

/// TransactionApplication fields for application transactions. Definition: data/transactions/application.go : ApplicationCallTxnFields
class AlgoRestTypesTransactionApplication {
  /// Access (al) Access unifies `accounts`, `foreign-apps`, `foreign-assets`, and `box-references` under a single list. If access is non-empty, these lists must be empty. If access is empty, those lists may be non-empty.
  final List<AlgoRestTypesResourceRef>? access;

  /// Accounts (apat) List of accounts in addition to the sender that may be accessed from the application's approval-program and clear-state-program.
  final List<String>? accounts;

  /// ApplicationArgs (apaa) transaction specific arguments accessed from the application's approval-program and clear-state-program.
  final List<BuBytes>? applicationArgs;

  /// ApplicationId (apid) ID of the application being configured or empty if creating.
  final BigInt applicationId;

  /// ApprovalProgram (apap) Logic executed for every application transaction, except when on-completion is set to "clear". It can read and write global state for the application, as well as account-specific local state. Approval programs may reject the transaction.
  final BuBytes? approvalProgram;

  /// BoxReferences (apbx) the boxes that can be accessed by this transaction (and others in the same group).
  final List<AlgoRestTypesBoxReference>? boxReferences;

  /// ClearStateProgram (apsu) Logic executed for application transactions with on-completion set to "clear". It can read and write global state for the application, as well as account-specific local state. Clear state programs cannot reject the transaction.
  final BuBytes? clearStateProgram;

  /// ExtraProgramPages (epp) specifies the additional app program len requested in pages.
  final BigInt? extraProgramPages;

  /// ForeignApps (apfa) Lists the applications in addition to the application-id whose global states may be accessed by this application's approval-program and clear-state-program. The access is read-only.
  final List<BigInt>? foreignApps;

  /// ForeignAssets (apas) lists the assets whose parameters may be accessed by this application's ApprovalProgram and ClearStateProgram. The access is read-only.
  final List<BigInt>? foreignAssets;

  /// GlobalStateSchema represents a (apls) local-state or (apgs) global-state schema. These schemas determine how much storage may be used in a local-state or global-state for an application. The more space used, the larger minimum balance must be maintained in the account holding the data.
  final AlgoRestTypesStateSchema? globalStateSchema;

  /// LocalStateSchema represents a (apls) local-state or (apgs) global-state schema. These schemas determine how much storage may be used in a local-state or global-state for an application. The more space used, the larger minimum balance must be maintained in the account holding the data.
  final AlgoRestTypesStateSchema? localStateSchema;

  /// OnCompletion (apan) defines the what additional actions occur with the transaction. Valid types: * noop * optin * closeout * clear * update * update * delete
  final String? onCompletion;

  /// RejectVersion (aprv) the lowest application version for which this transaction should immediately fail. 0 indicates that no version check should be performed.
  final BigInt? rejectVersion;

  AlgoRestTypesTransactionApplication({
    this.access,
    this.accounts,
    List<List<int>>? applicationArgs,
    required this.applicationId,
    List<int>? approvalProgram,
    this.boxReferences,
    List<int>? clearStateProgram,
    this.extraProgramPages,
    this.foreignApps,
    this.foreignAssets,
    this.globalStateSchema,
    this.localStateSchema,
    this.onCompletion,
    this.rejectVersion,
  }) : clearStateProgram = clearStateProgram?.asImmutableBytes, approvalProgram = approvalProgram?.asImmutableBytes, applicationArgs = applicationArgs?.map((e) => e.asImmutableBytes).toImutableList;

  factory AlgoRestTypesTransactionApplication.fromJson(
    Map<String, dynamic> json,
  ) {
    return AlgoRestTypesTransactionApplication(
      access: json.valueTo<List<AlgoRestTypesResourceRef>?, List>(
        key: "access",
        parse:
            (e) =>
                e
                    .map(
                      (x) => AlgoRestTypesResourceRef.fromJson(
                        JsonParser.valueEnsureAsMap(x),
                      ),
                    )
                    .toList(),
      ),
      accounts: json.valueAsList<List<String>?>("accounts"),
      applicationArgs: json.valueTo<List<List<int>>?, List>(
        key: "application-args",
        parse:
            (e) =>
                e
                    .map(
                      (x) => JsonParser.valueAsBytes<List<int>>(
                        x,
                        encoding: StringEncoding.base64,
                      ),
                    )
                    .toList(),
      ),
      applicationId: json.valueAsBigInt(
        "application-id",
        onMissing: () => BigInt.zero,
      ),
      approvalProgram: json.valueAsBytes(
        "approval-program",
        encoding: StringEncoding.base64,
      ),
      boxReferences: json.valueTo<List<AlgoRestTypesBoxReference>?, List>(
        key: "box-references",
        parse:
            (e) =>
                e
                    .map(
                      (x) => AlgoRestTypesBoxReference.fromJson(
                        JsonParser.valueEnsureAsMap(x),
                      ),
                    )
                    .toList(),
      ),
      clearStateProgram: json.valueAsBytes(
        "clear-state-program",
        encoding: StringEncoding.base64,
      ),
      extraProgramPages: json.valueAsBigInt("extra-program-pages"),
      foreignApps: json.valueAsList<List<BigInt>?>("foreign-apps"),
      foreignAssets: json.valueAsList<List<BigInt>?>("foreign-assets"),
      globalStateSchema: json.valueTo<AlgoRestTypesStateSchema?, Map>(
        key: "global-state-schema",
        parse:
            (e) => AlgoRestTypesStateSchema.fromJson(
              JsonParser.valueEnsureAsMap(e),
            ),
      ),
      localStateSchema: json.valueTo<AlgoRestTypesStateSchema?, Map>(
        key: "local-state-schema",
        parse:
            (e) => AlgoRestTypesStateSchema.fromJson(
              JsonParser.valueEnsureAsMap(e),
            ),
      ),
      onCompletion: json.valueAsString(
        "on-completion",
        bytesEncoding: StringEncoding.utf8,
      ),
      rejectVersion: json.valueAsBigInt("reject-version"),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "access": access?.map((e) => e.toJson()).toList(),
      "accounts": accounts,
      "application-args": applicationArgs,
      "application-id": applicationId,
      "approval-program": approvalProgram,
      "box-references": boxReferences?.map((e) => e.toJson()).toList(),
      "clear-state-program": clearStateProgram,
      "extra-program-pages": extraProgramPages,
      "foreign-apps": foreignApps?.map((e) => e).toList(),
      "foreign-assets": foreignAssets?.map((e) => e).toList(),
      "global-state-schema": globalStateSchema?.toJson(),
      "local-state-schema": localStateSchema?.toJson(),
      "on-completion": onCompletion,
      "reject-version": rejectVersion,
    }.notNullValue;
  }
}

/// TransactionAssetConfig fields for asset allocation, re-configuration, and destruction. A zero value for asset-id indicates asset creation. A zero value for the params indicates asset destruction. Definition: data/transactions/asset.go : AssetConfigTxnFields
class AlgoRestTypesTransactionAssetConfig {
  /// AssetId (xaid) ID of the asset being configured or empty if creating.
  final BigInt? assetId;

  /// Params assetParams specifies the parameters for an asset. (apar) when part of an AssetConfig transaction. Definition: data/transactions/asset.go : AssetParams
  final AlgoRestTypesAssetParams? params;

  const AlgoRestTypesTransactionAssetConfig({this.assetId, this.params});

  factory AlgoRestTypesTransactionAssetConfig.fromJson(
    Map<String, dynamic> json,
  ) {
    return AlgoRestTypesTransactionAssetConfig(
      assetId: json.valueAsBigInt("asset-id"),
      params: json.valueTo<AlgoRestTypesAssetParams?, Map>(
        key: "params",
        parse:
            (e) => AlgoRestTypesAssetParams.fromJson(
              JsonParser.valueEnsureAsMap(e),
            ),
      ),
    );
  }

  Map<String, dynamic> toJson() {
    return {"asset-id": assetId, "params": params?.toJson()}.notNullValue;
  }
}

/// TransactionAssetFreeze fields for an asset freeze transaction. Definition: data/transactions/asset.go : AssetFreezeTxnFields
class AlgoRestTypesTransactionAssetFreeze {
  /// Address (fadd) Address of the account whose asset is being frozen or thawed.
  final String address;

  /// AssetId (faid) ID of the asset being frozen or thawed.
  final BigInt assetId;

  /// NewFreezeStatus (afrz) The new freeze status.
  final bool newFreezeStatus;

  const AlgoRestTypesTransactionAssetFreeze({
    required this.address,
    required this.assetId,
    required this.newFreezeStatus,
  });

  factory AlgoRestTypesTransactionAssetFreeze.fromJson(
    Map<String, dynamic> json,
  ) {
    return AlgoRestTypesTransactionAssetFreeze(
      address: json.valueAsString(
        "address",
        bytesEncoding: StringEncoding.utf8,
        onMissing: () => '',
      ),
      assetId: json.valueAsBigInt("asset-id", onMissing: () => BigInt.zero),
      newFreezeStatus: json.valueAsBool(
        "new-freeze-status",
        onMissing: () => false,
      ),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "address": address,
      "asset-id": assetId,
      "new-freeze-status": newFreezeStatus,
    }.notNullValue;
  }
}

/// TransactionAssetTransfer fields for an asset transfer transaction. Definition: data/transactions/asset.go : AssetTransferTxnFields
class AlgoRestTypesTransactionAssetTransfer {
  /// Amount (aamt) Amount of asset to transfer. A zero amount transferred to self allocates that asset in the account's Assets map.
  final BigInt amount;

  /// AssetId (xaid) ID of the asset being transferred.
  final BigInt assetId;

  /// CloseAmount number of assets transferred to the close-to account as part of the transaction.
  final BigInt? closeAmount;

  /// CloseTo (aclose) Indicates that the asset should be removed from the account's Assets map, and specifies where the remaining asset holdings should be transferred. It's always valid to transfer remaining asset holdings to the creator account.
  final String? closeTo;

  /// Receiver (arcv) Recipient address of the transfer.
  final String receiver;

  /// Sender (asnd) The effective sender during a clawback transactions. If this is not a zero value, the real transaction sender must be the Clawback address from the AssetParams.
  final String? sender;

  const AlgoRestTypesTransactionAssetTransfer({
    required this.amount,
    required this.assetId,
    this.closeAmount,
    this.closeTo,
    required this.receiver,
    this.sender,
  });

  factory AlgoRestTypesTransactionAssetTransfer.fromJson(
    Map<String, dynamic> json,
  ) {
    return AlgoRestTypesTransactionAssetTransfer(
      amount: json.valueAsBigInt("amount", onMissing: () => BigInt.zero),
      assetId: json.valueAsBigInt("asset-id", onMissing: () => BigInt.zero),
      closeAmount: json.valueAsBigInt("close-amount"),
      closeTo: json.valueAsString(
        "close-to",
        bytesEncoding: StringEncoding.utf8,
      ),
      receiver: json.valueAsString(
        "receiver",
        bytesEncoding: StringEncoding.utf8,
        onMissing: () => '',
      ),
      sender: json.valueAsString("sender", bytesEncoding: StringEncoding.utf8),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "amount": amount,
      "asset-id": assetId,
      "close-amount": closeAmount,
      "close-to": closeTo,
      "receiver": receiver,
      "sender": sender,
    }.notNullValue;
  }
}

/// TransactionGroupLedgerStateDeltasForRoundResponse response containing all ledger state deltas for transaction groups, with their associated Ids, in a single round.
class AlgoRestTypesTransactionGroupLedgerStateDeltasForRoundResponse {
  /// Deltas
  final List<AlgoRestTypesLedgerStateDeltaForTransactionGroup> deltas;

  const AlgoRestTypesTransactionGroupLedgerStateDeltasForRoundResponse({
    required this.deltas,
  });

  factory AlgoRestTypesTransactionGroupLedgerStateDeltasForRoundResponse.fromJson(
    Map<String, dynamic> json,
  ) {
    return AlgoRestTypesTransactionGroupLedgerStateDeltasForRoundResponse(
      deltas: json.valueTo<
        List<AlgoRestTypesLedgerStateDeltaForTransactionGroup>,
        List
      >(
        key: "Deltas",
        onMissing: () => [],
        parse:
            (e) =>
                e
                    .map(
                      (x) =>
                          AlgoRestTypesLedgerStateDeltaForTransactionGroup.fromJson(
                            JsonParser.valueEnsureAsMap(x),
                          ),
                    )
                    .toList(),
      ),
    );
  }

  Map<String, dynamic> toJson() {
    return {"Deltas": deltas.map((e) => e.toJson()).toList()}.notNullValue;
  }
}

/// TransactionHeartbeat fields for a heartbeat transaction. Definition: data/transactions/heartbeat.go : HeartbeatTxnFields
class AlgoRestTypesTransactionHeartbeat {
  /// HbAddress (hbad) HbAddress is the account this txn is proving onlineness for.
  final String hbAddress;

  /// HbKeyDilution (hbkd) HbKeyDilution must match HbAddress account's current KeyDilution.
  final BigInt hbKeyDilution;

  /// HbProof (hbprf) HbProof is a signature using HeartbeatAddress's partkey, thereby showing it is online.
  final AlgoRestTypesHbProofFields hbProof;

  /// HbSeed (hbsd) HbSeed must be the block seed for the this transaction's firstValid block.
  final BuBytes hbSeed;

  /// HbVoteId (hbvid) HbVoteID must match the HbAddress account's current VoteID.
  final BuBytes hbVoteId;

  AlgoRestTypesTransactionHeartbeat({
    required this.hbAddress,
    required this.hbKeyDilution,
    required this.hbProof,
    required List<int> hbSeed,
    required List<int> hbVoteId,
  }) : hbVoteId = hbVoteId.asImmutableBytes, hbSeed = hbSeed.asImmutableBytes;

  factory AlgoRestTypesTransactionHeartbeat.fromJson(
    Map<String, dynamic> json,
  ) {
    return AlgoRestTypesTransactionHeartbeat(
      hbAddress: json.valueAsString(
        "hb-address",
        bytesEncoding: StringEncoding.utf8,
        onMissing: () => '',
      ),
      hbKeyDilution: json.valueAsBigInt(
        "hb-key-dilution",
        onMissing: () => BigInt.zero,
      ),
      hbProof: json.valueTo<AlgoRestTypesHbProofFields, Map>(
        key: "hb-proof",
        parse:
            (e) => AlgoRestTypesHbProofFields.fromJson(
              JsonParser.valueEnsureAsMap(e),
            ),
      ),
      hbSeed: json.valueAsBytes(
        "hb-seed",
        encoding: StringEncoding.base64,
        onMissing: () => [],
      ),
      hbVoteId: json.valueAsBytes(
        "hb-vote-id",
        encoding: StringEncoding.base64,
        onMissing: () => [],
      ),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "hb-address": hbAddress,
      "hb-key-dilution": hbKeyDilution,
      "hb-proof": hbProof.toJson(),
      "hb-seed": hbSeed,
      "hb-vote-id": hbVoteId,
    }.notNullValue;
  }
}

/// TransactionKeyreg fields for a keyreg transaction. Definition: data/transactions/keyreg.go : KeyregTxnFields
class AlgoRestTypesTransactionKeyreg {
  /// NonParticipation (nonpart) Mark the account as participating or non-participating.
  final bool? nonParticipation;

  /// SelectionParticipationKey (selkey) Public key used with the Verified Random Function (VRF) result during committee selection.
  final BuBytes? selectionParticipationKey;

  /// StateProofKey (sprfkey) State proof key used in key registration transactions.
  final BuBytes? stateProofKey;

  /// VoteFirstValid (votefst) First round this participation key is valid.
  final BigInt? voteFirstValid;

  /// VoteKeyDilution (votekd) Number of subkeys in each batch of participation keys.
  final BigInt? voteKeyDilution;

  /// VoteLastValid (votelst) Last round this participation key is valid.
  final BigInt? voteLastValid;

  /// VoteParticipationKey (votekey) Participation public key used in key registration transactions.
  final BuBytes? voteParticipationKey;

  AlgoRestTypesTransactionKeyreg({
    this.nonParticipation,
    List<int>? selectionParticipationKey,
    List<int>? stateProofKey,
    this.voteFirstValid,
    this.voteKeyDilution,
    this.voteLastValid,
    List<int>? voteParticipationKey,
  }) : voteParticipationKey = voteParticipationKey?.asImmutableBytes, stateProofKey = stateProofKey?.asImmutableBytes, selectionParticipationKey = selectionParticipationKey?.asImmutableBytes;

  factory AlgoRestTypesTransactionKeyreg.fromJson(Map<String, dynamic> json) {
    return AlgoRestTypesTransactionKeyreg(
      nonParticipation: json.valueAsBool("non-participation"),
      selectionParticipationKey: json.valueAsBytes(
        "selection-participation-key",
        encoding: StringEncoding.base64,
      ),
      stateProofKey: json.valueAsBytes(
        "state-proof-key",
        encoding: StringEncoding.base64,
      ),
      voteFirstValid: json.valueAsBigInt("vote-first-valid"),
      voteKeyDilution: json.valueAsBigInt("vote-key-dilution"),
      voteLastValid: json.valueAsBigInt("vote-last-valid"),
      voteParticipationKey: json.valueAsBytes(
        "vote-participation-key",
        encoding: StringEncoding.base64,
      ),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "non-participation": nonParticipation,
      "selection-participation-key": selectionParticipationKey,
      "state-proof-key": stateProofKey,
      "vote-first-valid": voteFirstValid,
      "vote-key-dilution": voteKeyDilution,
      "vote-last-valid": voteLastValid,
      "vote-participation-key": voteParticipationKey,
    }.notNullValue;
  }
}

/// TransactionParametersResponse transactionParams contains the parameters that help a client construct a new transaction.
class AlgoRestTypesTransactionParametersResponse {
  /// ConsensusVersion consensusVersion indicates the consensus protocol version as of LastRound.
  final String consensusVersion;

  /// Fee fee is the suggested transaction fee Fee is in units of micro-Algos per byte. Fee may fall to zero but transactions must still have a fee of at least MinTxnFee for the current network protocol.
  final BigInt fee;

  /// GenesisHash genesisHash is the hash of the genesis block.
  final BuBytes genesisHash;

  /// GenesisId genesisID is an ID listed in the genesis block.
  final String genesisId;

  /// LastRound lastRound indicates the last round seen
  final BigInt lastRound;

  /// MinFee the minimum transaction fee (not per byte) required for the txn to validate for the current network protocol.
  final BigInt minFee;

  AlgoRestTypesTransactionParametersResponse({
    required this.consensusVersion,
    required this.fee,
    required List<int> genesisHash,
    required this.genesisId,
    required this.lastRound,
    required this.minFee,
  }) : genesisHash = genesisHash.asImmutableBytes;

  factory AlgoRestTypesTransactionParametersResponse.fromJson(
    Map<String, dynamic> json,
  ) {
    return AlgoRestTypesTransactionParametersResponse(
      consensusVersion: json.valueAsString(
        "consensus-version",
        bytesEncoding: StringEncoding.utf8,
        onMissing: () => '',
      ),
      fee: json.valueAsBigInt("fee", onMissing: () => BigInt.zero),
      genesisHash: json.valueAsBytes(
        "genesis-hash",
        encoding: StringEncoding.base64,
        onMissing: () => [],
      ),
      genesisId: json.valueAsString(
        "genesis-id",
        bytesEncoding: StringEncoding.utf8,
        onMissing: () => '',
      ),
      lastRound: json.valueAsBigInt("last-round", onMissing: () => BigInt.zero),
      minFee: json.valueAsBigInt("min-fee", onMissing: () => BigInt.zero),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "consensus-version": consensusVersion,
      "fee": fee,
      "genesis-hash": genesisHash,
      "genesis-id": genesisId,
      "last-round": lastRound,
      "min-fee": minFee,
    }.notNullValue;
  }
}

/// TransactionPayment fields for a payment transaction. Definition: data/transactions/payment.go : PaymentTxnFields
class AlgoRestTypesTransactionPayment {
  /// Amount (amt) number of MicroAlgos intended to be transferred.
  final BigInt amount;

  /// CloseAmount number of MicroAlgos that were sent to the close-remainder-to address when closing the sender account.
  final BigInt? closeAmount;

  /// CloseRemainderTo (close) when set, indicates that the sending account should be closed and all remaining funds be transferred to this address.
  final String? closeRemainderTo;

  /// Receiver (rcv) receiver's address.
  final String receiver;

  const AlgoRestTypesTransactionPayment({
    required this.amount,
    this.closeAmount,
    this.closeRemainderTo,
    required this.receiver,
  });

  factory AlgoRestTypesTransactionPayment.fromJson(Map<String, dynamic> json) {
    return AlgoRestTypesTransactionPayment(
      amount: json.valueAsBigInt("amount", onMissing: () => BigInt.zero),
      closeAmount: json.valueAsBigInt("close-amount"),
      closeRemainderTo: json.valueAsString(
        "close-remainder-to",
        bytesEncoding: StringEncoding.utf8,
      ),
      receiver: json.valueAsString(
        "receiver",
        bytesEncoding: StringEncoding.utf8,
        onMissing: () => '',
      ),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "amount": amount,
      "close-amount": closeAmount,
      "close-remainder-to": closeRemainderTo,
      "receiver": receiver,
    }.notNullValue;
  }
}

/// TransactionProof proof of transaction in a block.
class AlgoRestTypesTransactionProof {
  /// Hashtype the type of hash function used to create the proof, must be one of: * sha512_256 * sha256
  final String? hashtype;

  /// Idx index of the transaction in the block's payset.
  final BigInt idx;

  /// Proof proof of transaction membership.
  final BuBytes proof;

  /// Stibhash hash of SignedTxnInBlock for verifying proof.
  final BuBytes stibhash;

  /// Treedepth represents the depth of the tree that is being proven, i.e. the number of edges from a leaf to the root.
  final BigInt treedepth;

  AlgoRestTypesTransactionProof({
    this.hashtype,
    required this.idx,
    required List<int> proof,
    required List<int> stibhash,
    required this.treedepth,
  }) : stibhash = stibhash.asImmutableBytes, proof = proof.asImmutableBytes;

  factory AlgoRestTypesTransactionProof.fromJson(Map<String, dynamic> json) {
    return AlgoRestTypesTransactionProof(
      hashtype: json.valueAsString(
        "hashtype",
        bytesEncoding: StringEncoding.utf8,
      ),
      idx: json.valueAsBigInt("idx", onMissing: () => BigInt.zero),
      proof: json.valueAsBytes(
        "proof",
        encoding: StringEncoding.base64,
        onMissing: () => [],
      ),
      stibhash: json.valueAsBytes(
        "stibhash",
        encoding: StringEncoding.base64,
        onMissing: () => [],
      ),
      treedepth: json.valueAsBigInt("treedepth", onMissing: () => BigInt.zero),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "hashtype": hashtype,
      "idx": idx,
      "proof": proof,
      "stibhash": stibhash,
      "treedepth": treedepth,
    }.notNullValue;
  }
}

/// TransactionResponse
class AlgoRestTypesTransactionResponse {
  /// CurrentRound round at which the results were computed.
  final BigInt currentRound;

  /// Transaction contains all fields common to all transactions and serves as an envelope to all transactions type. Represents both regular and inner transactions. Definition: data/transactions/signedtxn.go : SignedTxn data/transactions/transaction.go : Transaction
  final AlgoRestTypesTransaction transaction;

  const AlgoRestTypesTransactionResponse({
    required this.currentRound,
    required this.transaction,
  });

  factory AlgoRestTypesTransactionResponse.fromJson(Map<String, dynamic> json) {
    return AlgoRestTypesTransactionResponse(
      currentRound: json.valueAsBigInt(
        "current-round",
        onMissing: () => BigInt.zero,
      ),
      transaction: json.valueTo<AlgoRestTypesTransaction, Map>(
        key: "transaction",
        parse:
            (e) => AlgoRestTypesTransaction.fromJson(
              JsonParser.valueEnsureAsMap(e),
            ),
      ),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "current-round": currentRound,
      "transaction": transaction.toJson(),
    }.notNullValue;
  }
}

/// TransactionSignature validation signature associated with some data. Only one of the signatures should be provided.
class AlgoRestTypesTransactionSignature {
  /// Logicsig (lsig) Programatic transaction signature. Definition: data/transactions/logicsig.go
  final AlgoRestTypesTransactionSignatureLogicsig? logicsig;

  /// Multisig structure holding multiple subsignatures. Definition: crypto/multisig.go : MultisigSig
  final AlgoRestTypesTransactionSignatureMultisig? multisig;

  /// Sig (sig) Standard ed25519 signature.
  final BuBytes? sig;

  AlgoRestTypesTransactionSignature({
    this.logicsig,
    this.multisig,
    List<int>? sig,
  }) : sig = sig?.asImmutableBytes;

  factory AlgoRestTypesTransactionSignature.fromJson(
    Map<String, dynamic> json,
  ) {
    return AlgoRestTypesTransactionSignature(
      logicsig: json.valueTo<AlgoRestTypesTransactionSignatureLogicsig?, Map>(
        key: "logicsig",
        parse:
            (e) => AlgoRestTypesTransactionSignatureLogicsig.fromJson(
              JsonParser.valueEnsureAsMap(e),
            ),
      ),
      multisig: json.valueTo<AlgoRestTypesTransactionSignatureMultisig?, Map>(
        key: "multisig",
        parse:
            (e) => AlgoRestTypesTransactionSignatureMultisig.fromJson(
              JsonParser.valueEnsureAsMap(e),
            ),
      ),
      sig: json.valueAsBytes("sig", encoding: StringEncoding.base64),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "logicsig": logicsig?.toJson(),
      "multisig": multisig?.toJson(),
      "sig": sig,
    }.notNullValue;
  }
}

/// TransactionSignatureLogicsig (lsig) Programatic transaction signature. Definition: data/transactions/logicsig.go
class AlgoRestTypesTransactionSignatureLogicsig {
  /// Args (arg) Logic arguments, base64 encoded.
  final List<BuBytes>? args;

  /// Logic (l) Program signed by a signature or multi signature, or hashed to be the address of ana ccount. Base64 encoded TEAL program.
  final BuBytes logic;

  /// LogicMultisigSignature structure holding multiple subsignatures. Definition: crypto/multisig.go : MultisigSig
  final AlgoRestTypesTransactionSignatureMultisig? logicMultisigSignature;

  /// MultisigSignature structure holding multiple subsignatures. Definition: crypto/multisig.go : MultisigSig
  final AlgoRestTypesTransactionSignatureMultisig? multisigSignature;

  /// Signature (sig) ed25519 signature.
  final BuBytes? signature;

  AlgoRestTypesTransactionSignatureLogicsig({
    List<List<int>>? args,
    required List<int> logic,
    this.logicMultisigSignature,
    this.multisigSignature,
    List<int>? signature,
  }) : signature = signature?.asImmutableBytes, logic = logic.asImmutableBytes, args = args?.map((e) => e.asImmutableBytes).toImutableList;

  factory AlgoRestTypesTransactionSignatureLogicsig.fromJson(
    Map<String, dynamic> json,
  ) {
    return AlgoRestTypesTransactionSignatureLogicsig(
      args: json.valueTo<List<List<int>>?, List>(
        key: "args",
        parse:
            (e) =>
                e
                    .map(
                      (x) => JsonParser.valueAsBytes<List<int>>(
                        x,
                        encoding: StringEncoding.base64,
                      ),
                    )
                    .toList(),
      ),
      logic: json.valueAsBytes(
        "logic",
        encoding: StringEncoding.base64,
        onMissing: () => [],
      ),
      logicMultisigSignature: json
          .valueTo<AlgoRestTypesTransactionSignatureMultisig?, Map>(
            key: "logic-multisig-signature",
            parse:
                (e) => AlgoRestTypesTransactionSignatureMultisig.fromJson(
                  JsonParser.valueEnsureAsMap(e),
                ),
          ),
      multisigSignature: json
          .valueTo<AlgoRestTypesTransactionSignatureMultisig?, Map>(
            key: "multisig-signature",
            parse:
                (e) => AlgoRestTypesTransactionSignatureMultisig.fromJson(
                  JsonParser.valueEnsureAsMap(e),
                ),
          ),
      signature: json.valueAsBytes(
        "signature",
        encoding: StringEncoding.base64,
      ),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "args": args,
      "logic": logic,
      "logic-multisig-signature": logicMultisigSignature?.toJson(),
      "multisig-signature": multisigSignature?.toJson(),
      "signature": signature,
    }.notNullValue;
  }
}

/// TransactionSignatureMultisig structure holding multiple subsignatures. Definition: crypto/multisig.go : MultisigSig
class AlgoRestTypesTransactionSignatureMultisig {
  /// Subsignature (subsig) holds pairs of public key and signatures.
  final List<AlgoRestTypesTransactionSignatureMultisigSubsignature>?
  subsignature;

  /// Threshold (thr)
  final BigInt? threshold;

  /// Version (v)
  final BigInt? version;

  const AlgoRestTypesTransactionSignatureMultisig({
    this.subsignature,
    this.threshold,
    this.version,
  });

  factory AlgoRestTypesTransactionSignatureMultisig.fromJson(
    Map<String, dynamic> json,
  ) {
    return AlgoRestTypesTransactionSignatureMultisig(
      subsignature: json.valueTo<
        List<AlgoRestTypesTransactionSignatureMultisigSubsignature>?,
        List
      >(
        key: "subsignature",
        parse:
            (e) =>
                e
                    .map(
                      (x) =>
                          AlgoRestTypesTransactionSignatureMultisigSubsignature.fromJson(
                            JsonParser.valueEnsureAsMap(x),
                          ),
                    )
                    .toList(),
      ),
      threshold: json.valueAsBigInt("threshold"),
      version: json.valueAsBigInt("version"),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "subsignature": subsignature?.map((e) => e.toJson()).toList(),
      "threshold": threshold,
      "version": version,
    }.notNullValue;
  }
}

/// TransactionSignatureMultisigSubsignature defines a model for TransactionSignatureMultisigSubsignature.
class AlgoRestTypesTransactionSignatureMultisigSubsignature {
  /// PublicKey (pk)
  final BuBytes? publicKey;

  /// Signature (s)
  final BuBytes? signature;

  AlgoRestTypesTransactionSignatureMultisigSubsignature({
    List<int>? publicKey,
    List<int>? signature,
  }) : signature = signature?.asImmutableBytes, publicKey = publicKey?.asImmutableBytes;

  factory AlgoRestTypesTransactionSignatureMultisigSubsignature.fromJson(
    Map<String, dynamic> json,
  ) {
    return AlgoRestTypesTransactionSignatureMultisigSubsignature(
      publicKey: json.valueAsBytes(
        "public-key",
        encoding: StringEncoding.base64,
      ),
      signature: json.valueAsBytes(
        "signature",
        encoding: StringEncoding.base64,
      ),
    );
  }

  Map<String, dynamic> toJson() {
    return {"public-key": publicKey, "signature": signature}.notNullValue;
  }
}

/// TransactionStateProof fields for a state proof transaction. Definition: data/transactions/stateproof.go : StateProofTxnFields
class AlgoRestTypesTransactionStateProof {
  /// Message (spmsg)
  final AlgoRestTypesIndexerStateProofMessage? message;

  /// StateProof (sp) represents a state proof. Definition: crypto/stateproof/structs.go : StateProof
  final AlgoRestTypesStateProofFields? stateProof;

  /// StateProofType (sptype) Type of the state proof. Integer representing an entry defined in protocol/stateproof.go
  final BigInt? stateProofType;

  const AlgoRestTypesTransactionStateProof({
    this.message,
    this.stateProof,
    this.stateProofType,
  });

  factory AlgoRestTypesTransactionStateProof.fromJson(
    Map<String, dynamic> json,
  ) {
    return AlgoRestTypesTransactionStateProof(
      message: json.valueTo<AlgoRestTypesIndexerStateProofMessage?, Map>(
        key: "message",
        parse:
            (e) => AlgoRestTypesIndexerStateProofMessage.fromJson(
              JsonParser.valueEnsureAsMap(e),
            ),
      ),
      stateProof: json.valueTo<AlgoRestTypesStateProofFields?, Map>(
        key: "state-proof",
        parse:
            (e) => AlgoRestTypesStateProofFields.fromJson(
              JsonParser.valueEnsureAsMap(e),
            ),
      ),
      stateProofType: json.valueAsBigInt("state-proof-type"),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "message": message?.toJson(),
      "state-proof": stateProof?.toJson(),
      "state-proof-type": stateProofType,
    }.notNullValue;
  }
}

/// TransactionsResponse
class AlgoRestTypesTransactionsResponse {
  /// CurrentRound round at which the results were computed.
  final BigInt currentRound;

  /// NextToken used for pagination, when making another request provide this token with the next parameter.
  final String? nextToken;

  /// Transactions
  final List<AlgoRestTypesTransaction> transactions;

  const AlgoRestTypesTransactionsResponse({
    required this.currentRound,
    this.nextToken,
    required this.transactions,
  });

  factory AlgoRestTypesTransactionsResponse.fromJson(
    Map<String, dynamic> json,
  ) {
    return AlgoRestTypesTransactionsResponse(
      currentRound: json.valueAsBigInt(
        "current-round",
        onMissing: () => BigInt.zero,
      ),
      nextToken: json.valueAsString(
        "next-token",
        bytesEncoding: StringEncoding.utf8,
      ),
      transactions: json.valueTo<List<AlgoRestTypesTransaction>, List>(
        key: "transactions",
        onMissing: () => [],
        parse:
            (e) =>
                e
                    .map(
                      (x) => AlgoRestTypesTransaction.fromJson(
                        JsonParser.valueEnsureAsMap(x),
                      ),
                    )
                    .toList(),
      ),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "current-round": currentRound,
      "next-token": nextToken,
      "transactions": transactions.map((e) => e.toJson()).toList(),
    }.notNullValue;
  }
}

/// Version algod version information.
class AlgoRestTypesVersion {
  /// Build
  final AlgoRestTypesBuildVersion build;

  /// GenesisHash
  final BuBytes genesisHash;

  /// GenesisID
  final String genesisID;

  /// Versions
  final List<String> versions;

  AlgoRestTypesVersion({
    required this.build,
    required List<int> genesisHash,
    required this.genesisID,
    required this.versions,
  }) : genesisHash = genesisHash.asImmutableBytes;

  factory AlgoRestTypesVersion.fromJson(Map<String, dynamic> json) {
    return AlgoRestTypesVersion(
      build: json.valueTo<AlgoRestTypesBuildVersion, Map>(
        key: "build",
        parse:
            (e) => AlgoRestTypesBuildVersion.fromJson(
              JsonParser.valueEnsureAsMap(e),
            ),
      ),
      genesisHash: json.valueAsBytes(
        "genesis_hash_b64",
        encoding: StringEncoding.base64,
        onMissing: () => [],
      ),
      genesisID: json.valueAsString(
        "genesis_id",
        bytesEncoding: StringEncoding.utf8,
        onMissing: () => '',
      ),
      versions: json.valueEnsureAsList<String>("versions", onMissing: () => []),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "build": build.toJson(),
      "genesis_hash_b64": genesisHash,
      "genesis_id": genesisID,
      "versions": versions,
    }.notNullValue;
  }
}
