import 'package:blockchain_utils/blockchain_utils.dart';
import 'package:on_chain/algorand/src/address/address.dart';

import 'package:on_chain/algorand/src/utils/layout_utils.dart';
import 'package:on_chain/algorand/src/utils/utils.dart';

/// This file uses Algorand types only. toJson()/toMsgPack returns a raw object.
/// To serialize it into a JSON string, use a JSON encoder with support for custom encodable
/// objects and ensure all BigInt values are encoded as strings.

typedef AlgoTypesGenericDigest = List<int>;
typedef AlgoTypesMerkleSignature = List<int>;
typedef AlgoTypesOneTimeSignatureVerifier = List<int>;
typedef AlgoTypesPQScheme = List<int>;
typedef AlgoTypesSeed = List<int>;
typedef AlgoTypesSignature = List<int>;
typedef AlgoTypesTxid = List<int>;
typedef AlgoTypesVRFPK = List<int>;
typedef AlgoTypesVRFVerifier = List<int>;
typedef AlgoTypesVotePK = List<int>;

enum AlgoTypesDeltaAction {
  /// SetBytesAction indicates that a TEAL byte slice should be stored at a key
  setBytesAction(1),

  /// SetUintAction indicates that a Uint should be stored at a key
  setUintAction(2),

  /// DeleteAction indicates that the value for a particular key should be deleted
  deleteAction(3);

  final int value;
  const AlgoTypesDeltaAction(this.value);

  static AlgoTypesDeltaAction fromValue(int value) {
    return AlgoTypesDeltaAction.values.firstWhere(
      (e) => e.value == value,
      orElse:
          () =>
              throw BuError(
                DefaultErrorType.invalidArgument,
                'Invalid AlgoTypesDeltaAction value.',
                details: {'value': '$value'},
              ),
    );
  }
}

enum AlgoTypesOnCompletion {
  /// NoOpOC indicates that an application transaction will simply call its ApprovalProgram
  noOpOC(0),

  /// OptInOC indicates that an application transaction will allocate some LocalState for the application in the sender's account
  optInOC(1),

  /// CloseOutOC indicates that an application transaction will deallocate some LocalState for the application from the user's account
  closeOutOC(2),

  /// ClearStateOC is similar to CloseOutOC, but may never fail. This allows users to reclaim their minimum balance from an application they no longer wish to opt in to.
  clearStateOC(3),

  /// UpdateApplicationOC indicates that an application transaction will update the ApprovalProgram and ClearStateProgram for the application
  updateApplicationOC(4),

  /// DeleteApplicationOC indicates that an application transaction will delete the AppParams for the application from the creator's balance record
  deleteApplicationOC(5);

  final int value;
  const AlgoTypesOnCompletion(this.value);

  static AlgoTypesOnCompletion fromValue(int value) {
    return AlgoTypesOnCompletion.values.firstWhere(
      (e) => e.value == value,
      orElse:
          () =>
              throw BuError(
                DefaultErrorType.invalidArgument,
                'Invalid AlgoTypesOnCompletion value.',
                details: {'value': '$value'},
              ),
    );
  }
}

enum AlgoTypesStateProofType {
  /// StateProofBasic is our initial state proof setup. using falcon keys and subset-sum hash
  stateProofBasic(0);

  final int value;
  const AlgoTypesStateProofType(this.value);

  static AlgoTypesStateProofType fromValue(int value) {
    return AlgoTypesStateProofType.values.firstWhere(
      (e) => e.value == value,
      orElse:
          () =>
              throw BuError(
                DefaultErrorType.invalidArgument,
                'Invalid AlgoTypesStateProofType value.',
                details: {'value': '$value'},
              ),
    );
  }
}

enum AlgoTypesTealType {
  /// TealBytesType represents the type of a byte slice in a TEAL program
  tealBytesType(1),

  /// TealUintType represents the type of a uint in a TEAL program
  tealUintType(2);

  final int value;
  const AlgoTypesTealType(this.value);

  static AlgoTypesTealType fromValue(int value) {
    return AlgoTypesTealType.values.firstWhere(
      (e) => e.value == value,
      orElse:
          () =>
              throw BuError(
                DefaultErrorType.invalidArgument,
                'Invalid AlgoTypesTealType value.',
                details: {'value': '$value'},
              ),
    );
  }
}

/// Account contains the data associated with a given address. This includes the account balance, cryptographic public keys, consensus delegation status.
class AlgoTypesAccount {
  final dynamic status;
  final BigInt microAlgos;
  final List<int> voteID;
  final List<int> stateProofID;
  final List<int> selectionID;
  final BigInt voteFirstValid;
  final BigInt voteLastValid;
  final BigInt voteKeyDilution;

  const AlgoTypesAccount({
    required this.status,
    required this.microAlgos,
    required this.voteID,
    required this.stateProofID,
    required this.selectionID,
    required this.voteFirstValid,
    required this.voteLastValid,
    required this.voteKeyDilution,
  });

  factory AlgoTypesAccount.deserializeJson(Map<String, dynamic> json) {
    return AlgoTypesAccount(
      status: json["onl"],
      microAlgos: json.valueAsBigInt("algo", onMissing: () => BigInt.zero),
      voteID: json.valueAsBytes(
        "vote",
        encoding: StringEncoding.base64,
        onMissing: () => [],
      ),
      stateProofID: json.valueAsBytes(
        "stprf",
        encoding: StringEncoding.base64,
        onMissing: () => [],
      ),
      selectionID: json.valueAsBytes(
        "sel",
        encoding: StringEncoding.base64,
        onMissing: () => [],
      ),
      voteFirstValid: json.valueAsBigInt(
        "voteFst",
        onMissing: () => BigInt.zero,
      ),
      voteLastValid: json.valueAsBigInt(
        "voteLst",
        onMissing: () => BigInt.zero,
      ),
      voteKeyDilution: json.valueAsBigInt(
        "voteKD",
        onMissing: () => BigInt.zero,
      ),
    );
  }

  Map<String, dynamic> toMsgPack() {
    return {
      "onl": status,
      "algo": microAlgos,
      "vote": voteID,
      "stprf": stateProofID,
      "sel": selectionID,
      "voteFst": voteFirstValid,
      "voteLst": voteLastValid,
      "voteKD": voteKeyDilution,
    }.notNullValue;
  }
}

/// AccountApp is used as a map key.
class AlgoTypesAccountApp {
  final AlgoAddress address;
  final BigInt app;

  const AlgoTypesAccountApp({required this.address, required this.app});

  factory AlgoTypesAccountApp.fromJson(Map<String, dynamic> json) {
    return AlgoTypesAccountApp(
      address: AlgoUtils.parseAddressOrDefault(json.valueAs("Address")),
      app: json.valueAsBigInt("App", onMissing: () => BigInt.zero),
    );
  }

  Map<String, dynamic> toJson() {
    return {"Address": address, "App": app}.notNullValue;
  }
}

/// AccountAsset is used as a map key.
class AlgoTypesAccountAsset {
  final AlgoAddress address;
  final BigInt asset;

  const AlgoTypesAccountAsset({required this.address, required this.asset});

  factory AlgoTypesAccountAsset.fromJson(Map<String, dynamic> json) {
    return AlgoTypesAccountAsset(
      address: AlgoUtils.parseAddressOrDefault(json.valueAs("Address")),
      asset: json.valueAsBigInt("Asset", onMissing: () => BigInt.zero),
    );
  }

  Map<String, dynamic> toJson() {
    return {"Address": address, "Asset": asset}.notNullValue;
  }
}

/// AccountBaseData contains base account info like balance, status and total number of resources
class AlgoTypesAccountBaseData {
  final dynamic status;
  final BigInt microAlgos;
  final BigInt rewardsBase;
  final BigInt rewardedMicroAlgos;
  final AlgoAddress authAddr;
  final bool incentiveEligible;
  final AlgoTypesStateSchema? totalAppSchema;
  final int totalExtraAppPages;
  final BigInt totalAppParams;
  final BigInt totalAppLocalStates;
  final BigInt totalAssetParams;
  final BigInt totalAssets;
  final BigInt totalBoxes;
  final BigInt totalBoxBytes;
  final BigInt lastProposed;
  final BigInt lastHeartbeat;

  const AlgoTypesAccountBaseData({
    required this.status,
    required this.microAlgos,
    required this.rewardsBase,
    required this.rewardedMicroAlgos,
    required this.authAddr,
    required this.incentiveEligible,
    this.totalAppSchema,
    required this.totalExtraAppPages,
    required this.totalAppParams,
    required this.totalAppLocalStates,
    required this.totalAssetParams,
    required this.totalAssets,
    required this.totalBoxes,
    required this.totalBoxBytes,
    required this.lastProposed,
    required this.lastHeartbeat,
  });

  factory AlgoTypesAccountBaseData.fromJson(Map<String, dynamic> json) {
    return AlgoTypesAccountBaseData(
      status: json["Status"],
      microAlgos: json.valueAsBigInt(
        "MicroAlgos",
        onMissing: () => BigInt.zero,
      ),
      rewardsBase: json.valueAsBigInt(
        "RewardsBase",
        onMissing: () => BigInt.zero,
      ),
      rewardedMicroAlgos: json.valueAsBigInt(
        "RewardedMicroAlgos",
        onMissing: () => BigInt.zero,
      ),
      authAddr: AlgoUtils.parseAddressOrDefault(json.valueAs("AuthAddr")),

      incentiveEligible: json.valueAsBool(
        "IncentiveEligible",
        onMissing: () => false,
      ),
      totalAppSchema: json.valueTo<AlgoTypesStateSchema?, Map>(
        key: "TotalAppSchema",
        parse:
            (e) => AlgoTypesStateSchema.deserializeJson(
              JsonParser.valueEnsureAsMap(e),
            ),
      ),
      totalExtraAppPages: json.valueAsInt(
        "TotalExtraAppPages",
        onMissing: () => 0,
      ),
      totalAppParams: json.valueAsBigInt(
        "TotalAppParams",
        onMissing: () => BigInt.zero,
      ),
      totalAppLocalStates: json.valueAsBigInt(
        "TotalAppLocalStates",
        onMissing: () => BigInt.zero,
      ),
      totalAssetParams: json.valueAsBigInt(
        "TotalAssetParams",
        onMissing: () => BigInt.zero,
      ),
      totalAssets: json.valueAsBigInt(
        "TotalAssets",
        onMissing: () => BigInt.zero,
      ),
      totalBoxes: json.valueAsBigInt(
        "TotalBoxes",
        onMissing: () => BigInt.zero,
      ),
      totalBoxBytes: json.valueAsBigInt(
        "TotalBoxBytes",
        onMissing: () => BigInt.zero,
      ),
      lastProposed: json.valueAsBigInt(
        "LastProposed",
        onMissing: () => BigInt.zero,
      ),
      lastHeartbeat: json.valueAsBigInt(
        "LastHeartbeat",
        onMissing: () => BigInt.zero,
      ),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "Status": status,
      "MicroAlgos": microAlgos,
      "RewardsBase": rewardsBase,
      "RewardedMicroAlgos": rewardedMicroAlgos,
      "AuthAddr": authAddr,
      "IncentiveEligible": incentiveEligible,
      "TotalAppSchema": totalAppSchema?.toMsgPack(),
      "TotalExtraAppPages": totalExtraAppPages,
      "TotalAppParams": totalAppParams,
      "TotalAppLocalStates": totalAppLocalStates,
      "TotalAssetParams": totalAssetParams,
      "TotalAssets": totalAssets,
      "TotalBoxes": totalBoxes,
      "TotalBoxBytes": totalBoxBytes,
      "LastProposed": lastProposed,
      "LastHeartbeat": lastHeartbeat,
    }.notNullValue;
  }
}

/// AccountData provides users of the Balances interface per-account data (like basics.AccountData) but without any maps containing AppParams, AppLocalState, AssetHolding, or AssetParams. This ensures that transaction evaluation must retrieve and mutate account, asset, and application data separately, to better support on-disk and in-memory schemas that do not store them together.
class AlgoTypesAccountData {
  final dynamic status;
  final BigInt microAlgos;
  final BigInt rewardsBase;
  final BigInt rewardedMicroAlgos;
  final AlgoAddress authAddr;
  final bool incentiveEligible;
  final AlgoTypesStateSchema? totalAppSchema;
  final int totalExtraAppPages;
  final BigInt totalAppParams;
  final BigInt totalAppLocalStates;
  final BigInt totalAssetParams;
  final BigInt totalAssets;
  final BigInt totalBoxes;
  final BigInt totalBoxBytes;
  final BigInt lastProposed;
  final BigInt lastHeartbeat;
  final AlgoTypesOneTimeSignatureVerifier voteID;
  final AlgoTypesVRFVerifier selectionID;
  final List<int> stateProofID;
  final BigInt voteFirstValid;
  final BigInt voteLastValid;
  final BigInt voteKeyDilution;

  const AlgoTypesAccountData({
    required this.status,
    required this.microAlgos,
    required this.rewardsBase,
    required this.rewardedMicroAlgos,
    required this.authAddr,
    required this.incentiveEligible,
    this.totalAppSchema,
    required this.totalExtraAppPages,
    required this.totalAppParams,
    required this.totalAppLocalStates,
    required this.totalAssetParams,
    required this.totalAssets,
    required this.totalBoxes,
    required this.totalBoxBytes,
    required this.lastProposed,
    required this.lastHeartbeat,
    required this.voteID,
    required this.selectionID,
    required this.stateProofID,
    required this.voteFirstValid,
    required this.voteLastValid,
    required this.voteKeyDilution,
  });

  factory AlgoTypesAccountData.fromJson(Map<String, dynamic> json) {
    return AlgoTypesAccountData(
      status: json["Status"],
      microAlgos: json.valueAsBigInt(
        "MicroAlgos",
        onMissing: () => BigInt.zero,
      ),
      rewardsBase: json.valueAsBigInt(
        "RewardsBase",
        onMissing: () => BigInt.zero,
      ),
      rewardedMicroAlgos: json.valueAsBigInt(
        "RewardedMicroAlgos",
        onMissing: () => BigInt.zero,
      ),
      authAddr: AlgoUtils.parseAddressOrDefault(json.valueAs("AuthAddr")),
      incentiveEligible: json.valueAsBool(
        "IncentiveEligible",
        onMissing: () => false,
      ),
      totalAppSchema: json.valueTo<AlgoTypesStateSchema?, Map>(
        key: "TotalAppSchema",
        parse:
            (e) => AlgoTypesStateSchema.deserializeJson(
              JsonParser.valueEnsureAsMap(e),
            ),
      ),
      totalExtraAppPages: json.valueAsInt(
        "TotalExtraAppPages",
        onMissing: () => 0,
      ),
      totalAppParams: json.valueAsBigInt(
        "TotalAppParams",
        onMissing: () => BigInt.zero,
      ),
      totalAppLocalStates: json.valueAsBigInt(
        "TotalAppLocalStates",
        onMissing: () => BigInt.zero,
      ),
      totalAssetParams: json.valueAsBigInt(
        "TotalAssetParams",
        onMissing: () => BigInt.zero,
      ),
      totalAssets: json.valueAsBigInt(
        "TotalAssets",
        onMissing: () => BigInt.zero,
      ),
      totalBoxes: json.valueAsBigInt(
        "TotalBoxes",
        onMissing: () => BigInt.zero,
      ),
      totalBoxBytes: json.valueAsBigInt(
        "TotalBoxBytes",
        onMissing: () => BigInt.zero,
      ),
      lastProposed: json.valueAsBigInt(
        "LastProposed",
        onMissing: () => BigInt.zero,
      ),
      lastHeartbeat: json.valueAsBigInt(
        "LastHeartbeat",
        onMissing: () => BigInt.zero,
      ),
      voteID: json.valueAsBytes(
        "VoteID",
        encoding: StringEncoding.base64,
        onMissing: () => [],
      ),
      selectionID: json.valueAsBytes(
        "SelectionID",
        encoding: StringEncoding.base64,
        onMissing: () => List<int>.filled(QuickCrypto.sha256DigestSize, 0),
      ),
      stateProofID: json.valueAsBytes(
        "StateProofID",
        encoding: StringEncoding.base64,
        onMissing: () => List<int>.filled(QuickCrypto.sha512DigestLength, 0),
      ),
      voteFirstValid: json.valueAsBigInt(
        "VoteFirstValid",
        onMissing: () => BigInt.zero,
      ),
      voteLastValid: json.valueAsBigInt(
        "VoteLastValid",
        onMissing: () => BigInt.zero,
      ),
      voteKeyDilution: json.valueAsBigInt(
        "VoteKeyDilution",
        onMissing: () => BigInt.zero,
      ),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "Status": status,
      "MicroAlgos": microAlgos,
      "RewardsBase": rewardsBase,
      "RewardedMicroAlgos": rewardedMicroAlgos,
      "AuthAddr": authAddr,
      "IncentiveEligible": incentiveEligible,
      "TotalAppSchema": totalAppSchema?.toMsgPack(),
      "TotalExtraAppPages": totalExtraAppPages,
      "TotalAppParams": totalAppParams,
      "TotalAppLocalStates": totalAppLocalStates,
      "TotalAssetParams": totalAssetParams,
      "TotalAssets": totalAssets,
      "TotalBoxes": totalBoxes,
      "TotalBoxBytes": totalBoxBytes,
      "LastProposed": lastProposed,
      "LastHeartbeat": lastHeartbeat,
      "VoteID": voteID,
      "SelectionID": selectionID,
      "StateProofID": stateProofID,
      "VoteFirstValid": voteFirstValid,
      "VoteLastValid": voteLastValid,
      "VoteKeyDilution": voteKeyDilution,
    }.notNullValue;
  }
}

/// AccountDeltas stores ordered accounts and allows fast lookup by address One key design aspect here was to ensure that we're able to access the written deltas in a deterministic order, while maintaining O(1) lookup. In order to do that, each of the arrays here is constructed as a pair of (slice, map). The map would point the address/address+creatable id onto the index of the element within the slice. If adding fields make sure to add them to the .reset() method to avoid dirty state
class AlgoTypesAccountDeltas {
  /// Actual data. If an account is deleted, `Accts` contains the BalanceRecord with an empty `AccountData` and a populated `Addr`.
  final List<AlgoTypesBalanceRecord> accts;

  /// cache for addr to deltas index resolution
  final Map<AlgoAddress, int> acctsCache;

  /// AppResources deltas. If app params or local state is deleted, there is a nil value in AppResources.Params or AppResources.State and Deleted flag set
  final List<AlgoTypesAppResourceRecord> appResources;

  /// caches for {addr, app id} to app params delta resolution not preallocated - use UpsertAppResource instead of inserting directly
  final Map<AlgoTypesAccountApp, int> appResourcesCache;
  final List<AlgoTypesAssetResourceRecord> assetResources;

  /// not preallocated - use UpsertAssertResource instead of inserting directly
  final Map<AlgoTypesAccountAsset, int> assetResourcesCache;

  const AlgoTypesAccountDeltas({
    required this.accts,
    required this.acctsCache,
    required this.appResources,
    required this.appResourcesCache,
    required this.assetResources,
    required this.assetResourcesCache,
  });

  factory AlgoTypesAccountDeltas.fromJson(Map<String, dynamic> json) {
    return AlgoTypesAccountDeltas(
      accts: json.valueTo<List<AlgoTypesBalanceRecord>, List>(
        key: "Accts",
        onMissing: () => [],
        parse:
            (e) =>
                e
                    .map(
                      (x) => AlgoTypesBalanceRecord.fromJson(
                        JsonParser.valueEnsureAsMap(x),
                      ),
                    )
                    .toList(),
      ),
      acctsCache: json.valueTo<Map<AlgoAddress, int>, Map>(
        key: "acctsCache",
        onMissing: () => {},
        parse:
            (e) => e.map(
              (k, v) => MapEntry(AlgoUtils.parseAddressOrDefault(k), v),
            ),
      ),
      appResources: json.valueTo<List<AlgoTypesAppResourceRecord>, List>(
        key: "AppResources",
        onMissing: () => [],
        parse:
            (e) =>
                e
                    .map(
                      (x) => AlgoTypesAppResourceRecord.fromJson(
                        JsonParser.valueEnsureAsMap(x),
                      ),
                    )
                    .toList(),
      ),
      appResourcesCache: json.valueTo<Map<AlgoTypesAccountApp, int>, Map>(
        key: "appResourcesCache",
        onMissing: () => {},
        parse:
            (e) => e.map(
              (k, v) => MapEntry(
                AlgoTypesAccountApp.fromJson(JsonParser.valueEnsureAsMap(k)),
                v,
              ),
            ),
      ),
      assetResources: json.valueTo<List<AlgoTypesAssetResourceRecord>, List>(
        key: "AssetResources",
        onMissing: () => [],
        parse:
            (e) =>
                e
                    .map(
                      (x) => AlgoTypesAssetResourceRecord.fromJson(
                        JsonParser.valueEnsureAsMap(x),
                      ),
                    )
                    .toList(),
      ),
      assetResourcesCache: json.valueTo<Map<AlgoTypesAccountAsset, int>, Map>(
        key: "assetResourcesCache",
        onMissing: () => {},
        parse:
            (e) => e.map(
              (k, v) => MapEntry(
                AlgoTypesAccountAsset.fromJson(JsonParser.valueEnsureAsMap(k)),
                v,
              ),
            ),
      ),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "Accts": accts.map((e) => e.toJson()).toList(),
      "acctsCache": acctsCache,
      "AppResources": appResources.map((e) => e.toJson()).toList(),
      "appResourcesCache": appResourcesCache.map(
        (k, e) => MapEntry(k.toJson(), e),
      ),
      "AssetResources": assetResources.map((e) => e.toJson()).toList(),
      "assetResourcesCache": assetResourcesCache.map(
        (k, e) => MapEntry(k.toJson(), e),
      ),
    }.notNullValue;
  }
}

/// AccountTotals represents the totals of algos in the system grouped by different account status values.
class AlgoTypesAccountTotals {
  final AlgoTypesAlgoCount? online;
  final AlgoTypesAlgoCount? offline;
  final AlgoTypesAlgoCount? notParticipating;

  /// Total number of algos received per reward unit since genesis
  final BigInt rewardsLevel;

  const AlgoTypesAccountTotals({
    this.online,
    this.offline,
    this.notParticipating,
    required this.rewardsLevel,
  });

  factory AlgoTypesAccountTotals.deserializeJson(Map<String, dynamic> json) {
    return AlgoTypesAccountTotals(
      online: json.valueTo<AlgoTypesAlgoCount?, Map>(
        key: "online",
        parse:
            (e) => AlgoTypesAlgoCount.deserializeJson(
              JsonParser.valueEnsureAsMap(e),
            ),
      ),
      offline: json.valueTo<AlgoTypesAlgoCount?, Map>(
        key: "offline",
        parse:
            (e) => AlgoTypesAlgoCount.deserializeJson(
              JsonParser.valueEnsureAsMap(e),
            ),
      ),
      notParticipating: json.valueTo<AlgoTypesAlgoCount?, Map>(
        key: "notpart",
        parse:
            (e) => AlgoTypesAlgoCount.deserializeJson(
              JsonParser.valueEnsureAsMap(e),
            ),
      ),
      rewardsLevel: json.valueAsBigInt("rwdlvl", onMissing: () => BigInt.zero),
    );
  }

  Map<String, dynamic> toMsgPack() {
    return {
      "online": online?.toMsgPack(),
      "offline": offline?.toMsgPack(),
      "notpart": notParticipating?.toMsgPack(),
      "rwdlvl": rewardsLevel,
    }.notNullValue;
  }
}

/// AlgoCount represents a total of algos of a certain class of accounts (split up by their Status value).
class AlgoTypesAlgoCount {
  /// Sum of algos of all accounts in this class.
  final BigInt money;

  /// Total number of whole reward units in accounts.
  final BigInt rewardUnits;

  const AlgoTypesAlgoCount({required this.money, required this.rewardUnits});

  factory AlgoTypesAlgoCount.deserializeJson(Map<String, dynamic> json) {
    return AlgoTypesAlgoCount(
      money: json.valueAsBigInt("mon", onMissing: () => BigInt.zero),
      rewardUnits: json.valueAsBigInt("rwd", onMissing: () => BigInt.zero),
    );
  }

  Map<String, dynamic> toMsgPack() {
    return {"mon": money, "rwd": rewardUnits}.notNullValue;
  }
}

/// AppBoxReference names a box by the app ID
class AlgoTypesAppBoxReference {
  /// The ID of the app that owns the box. Must be converted to BoxReference during transaction submission.
  final BigInt appID;

  /// The Name of the box unique to the app it belongs to
  final List<int> name;

  const AlgoTypesAppBoxReference({required this.appID, required this.name});

  factory AlgoTypesAppBoxReference.fromJson(Map<String, dynamic> json) {
    return AlgoTypesAppBoxReference(
      appID: json.valueAsBigInt("AppID", onMissing: () => BigInt.zero),
      name: json.valueAsBytes(
        "Name",
        encoding: StringEncoding.base64,
        onMissing: () => [],
      ),
    );
  }

  Map<String, dynamic> toJson() {
    return {"AppID": appID, "Name": name}.notNullValue;
  }
}

/// AppHoldingRef identifies an asset holding by the asset id and the address (zero address/empty string means Sender). It can be viewed as the "hydrated" form of a HoldingRef, which uses indices.
class AlgoTypesAppHoldingRef {
  final BigInt asset;
  final String address;

  const AlgoTypesAppHoldingRef({required this.asset, required this.address});

  factory AlgoTypesAppHoldingRef.fromJson(Map<String, dynamic> json) {
    return AlgoTypesAppHoldingRef(
      asset: json.valueAsBigInt("Asset", onMissing: () => BigInt.zero),
      address: json.valueAsString(
        "Address",
        bytesEncoding: StringEncoding.utf8,
        onMissing: () => '',
      ),
    );
  }

  Map<String, dynamic> toJson() {
    return {"Asset": asset, "Address": address}.notNullValue;
  }
}

/// AppLocalState stores the LocalState associated with an application. It also stores a cached copy of the application's LocalStateSchema so that MinBalance requirements may be computed 1. without looking up the AppParams and 2. even if the application has been deleted
class AlgoTypesAppLocalState {
  final AlgoTypesStateSchema? schema;
  final Map<String, AlgoTypesTealValue> keyValue;

  const AlgoTypesAppLocalState({this.schema, required this.keyValue});

  factory AlgoTypesAppLocalState.deserializeJson(Map<String, dynamic> json) {
    return AlgoTypesAppLocalState(
      schema: json.valueTo<AlgoTypesStateSchema?, Map>(
        key: "hsch",
        parse:
            (e) => AlgoTypesStateSchema.deserializeJson(
              JsonParser.valueEnsureAsMap(e),
            ),
      ),
      keyValue: json.valueTo<Map<String, AlgoTypesTealValue>, Map>(
        key: "tkv",
        onMissing: () => {},
        parse:
            (e) => e.map(
              (k, v) => MapEntry(
                JsonParser.valueAsString(k),
                AlgoTypesTealValue.deserializeJson(
                  JsonParser.valueEnsureAsMap(v),
                ),
              ),
            ),
      ),
    );
  }

  Map<String, dynamic> toMsgPack() {
    return {
      "hsch": schema?.toMsgPack(),
      "tkv": keyValue.map((k, e) => MapEntry(k, e.toMsgPack())),
    }.notNullValue;
  }
}

/// AppLocalStateDelta tracks a changed AppLocalState, and whether it was deleted
class AlgoTypesAppLocalStateDelta {
  final AlgoTypesAppLocalState? localState;
  final bool deleted;

  const AlgoTypesAppLocalStateDelta({this.localState, required this.deleted});

  factory AlgoTypesAppLocalStateDelta.fromJson(Map<String, dynamic> json) {
    return AlgoTypesAppLocalStateDelta(
      localState: json.valueTo<AlgoTypesAppLocalState?, Map>(
        key: "LocalState",
        parse:
            (e) => AlgoTypesAppLocalState.deserializeJson(
              JsonParser.valueEnsureAsMap(e),
            ),
      ),
      deleted: json.valueAsBool("Deleted", onMissing: () => false),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "LocalState": localState?.toMsgPack(),
      "Deleted": deleted,
    }.notNullValue;
  }
}

/// AppLocalsRef identifies local state by the app id and the address (zero address/empty string means Sender). It can be viewed as the "hydrated" form of a LocalsRef, which uses indices.
class AlgoTypesAppLocalsRef {
  final BigInt app;
  final String address;

  const AlgoTypesAppLocalsRef({required this.app, required this.address});

  factory AlgoTypesAppLocalsRef.fromJson(Map<String, dynamic> json) {
    return AlgoTypesAppLocalsRef(
      app: json.valueAsBigInt("App", onMissing: () => BigInt.zero),
      address: json.valueAsString(
        "Address",
        bytesEncoding: StringEncoding.utf8,
        onMissing: () => '',
      ),
    );
  }

  Map<String, dynamic> toJson() {
    return {"App": app, "Address": address}.notNullValue;
  }
}

/// AppParams stores the global information associated with an application
class AlgoTypesAppParams {
  final List<int> approvalProgram;
  final List<int> clearStateProgram;
  final Map<String, AlgoTypesTealValue> globalState;
  final AlgoTypesStateSchema? localStateSchema;
  final AlgoTypesStateSchema? globalStateSchema;
  final int extraProgramPages;
  final BigInt version;

  /// SizeSponsor, if non-zero, is the account that must hold MBR for extra program pages, and the global schema.
  final AlgoAddress sizeSponsor;

  /// ForeignBoxReads, when true, allows any app to read this app's boxes.
  final bool foreignBoxReads;

  /// FamilyBoxAccess, when true, allows apps with the same creator to read and write this app's boxes.
  final bool familyBoxAccess;

  const AlgoTypesAppParams({
    required this.approvalProgram,
    required this.clearStateProgram,
    required this.globalState,
    this.localStateSchema,
    this.globalStateSchema,
    required this.extraProgramPages,
    required this.version,
    required this.sizeSponsor,
    required this.foreignBoxReads,
    required this.familyBoxAccess,
  });

  factory AlgoTypesAppParams.deserializeJson(Map<String, dynamic> json) {
    return AlgoTypesAppParams(
      approvalProgram: json.valueAsBytes(
        "approv",
        encoding: StringEncoding.base64,
        onMissing: () => [],
      ),
      clearStateProgram: json.valueAsBytes(
        "clearp",
        encoding: StringEncoding.base64,
        onMissing: () => [],
      ),
      globalState: json.valueTo<Map<String, AlgoTypesTealValue>, Map>(
        key: "gs",
        onMissing: () => {},
        parse:
            (e) => e.map(
              (k, v) => MapEntry(
                JsonParser.valueAsString(k),
                AlgoTypesTealValue.deserializeJson(
                  JsonParser.valueEnsureAsMap(v),
                ),
              ),
            ),
      ),
      localStateSchema: json.valueTo<AlgoTypesStateSchema?, Map>(
        key: "lsch",
        parse:
            (e) => AlgoTypesStateSchema.deserializeJson(
              JsonParser.valueEnsureAsMap(e),
            ),
      ),
      globalStateSchema: json.valueTo<AlgoTypesStateSchema?, Map>(
        key: "gsch",
        parse:
            (e) => AlgoTypesStateSchema.deserializeJson(
              JsonParser.valueEnsureAsMap(e),
            ),
      ),
      extraProgramPages: json.valueAsInt("epp", onMissing: () => 0),
      version: json.valueAsBigInt("v", onMissing: () => BigInt.zero),
      sizeSponsor: AlgoUtils.parseAddressOrDefault(json.valueAs("ss")),

      foreignBoxReads: json.valueAsBool("fbr", onMissing: () => false),
      familyBoxAccess: json.valueAsBool("fba", onMissing: () => false),
    );
  }

  Map<String, dynamic> toMsgPack() {
    return {
      "approv": approvalProgram,
      "clearp": clearStateProgram,
      "gs": globalState.map((k, e) => MapEntry(k, e.toMsgPack())),
      "lsch": localStateSchema?.toMsgPack(),
      "gsch": globalStateSchema?.toMsgPack(),
      "epp": extraProgramPages,
      "v": version,
      "ss": sizeSponsor,
      "fbr": foreignBoxReads,
      "fba": familyBoxAccess,
    }.notNullValue;
  }
}

/// AppParamsDelta tracks a changed AppParams, and whether it was deleted
class AlgoTypesAppParamsDelta {
  final AlgoTypesAppParams? params;
  final bool deleted;

  const AlgoTypesAppParamsDelta({this.params, required this.deleted});

  factory AlgoTypesAppParamsDelta.fromJson(Map<String, dynamic> json) {
    return AlgoTypesAppParamsDelta(
      params: json.valueTo<AlgoTypesAppParams?, Map>(
        key: "Params",
        parse:
            (e) => AlgoTypesAppParams.deserializeJson(
              JsonParser.valueEnsureAsMap(e),
            ),
      ),
      deleted: json.valueAsBool("Deleted", onMissing: () => false),
    );
  }

  Map<String, dynamic> toJson() {
    return {"Params": params?.toMsgPack(), "Deleted": deleted}.notNullValue;
  }
}

/// AppResourceRecord represents AppParams and AppLocalState in deltas
class AlgoTypesAppResourceRecord {
  final BigInt aidx;
  final AlgoAddress addr;
  final AlgoTypesAppParamsDelta params;
  final AlgoTypesAppLocalStateDelta state;

  const AlgoTypesAppResourceRecord({
    required this.aidx,
    required this.addr,
    required this.params,
    required this.state,
  });

  factory AlgoTypesAppResourceRecord.fromJson(Map<String, dynamic> json) {
    return AlgoTypesAppResourceRecord(
      aidx: json.valueAsBigInt("Aidx", onMissing: () => BigInt.zero),
      addr: AlgoUtils.parseAddressOrDefault(json.valueAs("Addr")),

      params: json.valueTo<AlgoTypesAppParamsDelta, Map>(
        key: "Params",
        parse:
            (e) => AlgoTypesAppParamsDelta.fromJson(
              JsonParser.valueEnsureAsMap(e),
            ),
      ),
      state: json.valueTo<AlgoTypesAppLocalStateDelta, Map>(
        key: "State",
        parse:
            (e) => AlgoTypesAppLocalStateDelta.fromJson(
              JsonParser.valueEnsureAsMap(e),
            ),
      ),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "Aidx": aidx,
      "Addr": addr,
      "Params": params.toJson(),
      "State": state.toJson(),
    }.notNullValue;
  }
}

/// ApplicationCallTxnFields captures the transaction fields used for all interactions with applications
class AlgoTypesApplicationCallTxnFields {
  /// ApplicationID is 0 when creating an application, and nonzero when calling an existing application.
  final BigInt applicationID;

  /// OnCompletion specifies an optional side-effect that this transaction will have on the balance record of the sender or the application's creator. See the documentation for the OnCompletion type for more information on each possible value.
  final AlgoTypesOnCompletion onCompletion;

  /// ApplicationArgs are arguments accessible to the executing ApprovalProgram or ClearStateProgram.
  final List<List<int>> applicationArgs;

  /// Accounts are accounts whose balance records are accessible by the executing ApprovalProgram or ClearStateProgram. To access LocalState or an ASA balance for an account besides the sender, that account's address must be listed here (and since v4, the ForeignApp or ForeignAsset must also include the app or asset id).
  final List<AlgoAddress> accounts;

  /// ForeignAssets are asset IDs for assets whose AssetParams (and since v4, Holdings) may be read by the executing ApprovalProgram or ClearStateProgram.
  final List<BigInt> foreignAssets;

  /// ForeignApps are application IDs for applications besides this one whose GlobalState (or Local, since v4) may be read by the executing ApprovalProgram or ClearStateProgram.
  final List<BigInt> foreignApps;

  /// Access unifies `Accounts`, `ForeignApps`, `ForeignAssets`, and `Boxes` under a single list. It removes all implicitly available resources, so "cross-product" resources (holdings and locals) must be explicitly listed, as well as app accounts, even the app account of the called app! Transactions using Access may not use the other lists.
  final List<AlgoTypesResourceRef> access;

  /// Boxes are the boxes that can be accessed by this transaction (and others in the same group). The Index in the BoxRef is the slot of ForeignApps that the name is associated with (shifted by 1. 0 indicates "current app")
  final List<AlgoTypesBoxReference> boxReferences;

  /// LocalStateSchema specifies the maximum number of each type that may appear in the local key/value store of users who opt in to this application. This field is only used during application creation (when the ApplicationID field is 0),
  final AlgoTypesStateSchema? localStateSchema;

  /// GlobalStateSchema specifies the maximum number of each type that may appear in the global key/value store associated with this application. This field is only used during application creation (when the ApplicationID field is 0).
  final AlgoTypesStateSchema? globalStateSchema;

  /// ApprovalProgram is the stateful TEAL bytecode that executes on all ApplicationCall transactions associated with this application, except for those where OnCompletion is equal to ClearStateOC. If this program fails, the transaction is rejected. This program may read and write local and global state for this application.
  final List<int> approvalProgram;

  /// ClearStateProgram is the stateful TEAL bytecode that executes on ApplicationCall transactions associated with this application when OnCompletion is equal to ClearStateOC. This program will not cause the transaction to be rejected, even if it fails. This program may read and write local and global state for this application.
  final List<int> clearStateProgram;

  /// ExtraProgramPages specifies the additional app program len requested in pages. A page is MaxAppProgramLen bytes. This field enables execution of app programs larger than the default config, MaxAppProgramLen.
  final int extraProgramPages;

  /// RejectVersion is the lowest application version for which this transaction should immediately fail. 0 indicates that no version check should be performed.
  final BigInt rejectVersion;

  const AlgoTypesApplicationCallTxnFields({
    required this.applicationID,
    required this.onCompletion,
    required this.applicationArgs,
    required this.accounts,
    required this.foreignAssets,
    required this.foreignApps,
    required this.access,
    required this.boxReferences,
    this.localStateSchema,
    this.globalStateSchema,
    required this.approvalProgram,
    required this.clearStateProgram,
    required this.extraProgramPages,
    required this.rejectVersion,
  });

  factory AlgoTypesApplicationCallTxnFields.deserializeJson(
    Map<String, dynamic> json,
  ) {
    return AlgoTypesApplicationCallTxnFields(
      applicationID: json.valueAsBigInt("apid", onMissing: () => BigInt.zero),
      onCompletion: json.valueTo<AlgoTypesOnCompletion, int>(
        key: "apan",
        parse: (e) => AlgoTypesOnCompletion.fromValue(e),
      ),
      applicationArgs: json.valueTo<List<List<int>>, List>(
        key: "apaa",
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
      accounts: json.valueTo<List<AlgoAddress>, List>(
        key: "apat",
        onMissing: () => [],
        parse: (e) => e.map((x) => AlgoUtils.parseAddressOrDefault(x)).toList(),
      ),
      foreignAssets: json.valueEnsureAsList<BigInt>(
        "apas",
        onMissing: () => [],
      ),
      foreignApps: json.valueEnsureAsList<BigInt>("apfa", onMissing: () => []),
      access: json.valueTo<List<AlgoTypesResourceRef>, List>(
        key: "al",
        onMissing: () => [],
        parse:
            (e) =>
                e
                    .map(
                      (x) => AlgoTypesResourceRef.deserializeJson(
                        JsonParser.valueEnsureAsMap(x),
                      ),
                    )
                    .toList(),
      ),
      boxReferences: json.valueTo<List<AlgoTypesBoxReference>, List>(
        key: "apbx",
        onMissing: () => [],
        parse:
            (e) =>
                e
                    .map(
                      (x) => AlgoTypesBoxReference.deserializeJson(
                        JsonParser.valueEnsureAsMap(x),
                      ),
                    )
                    .toList(),
      ),
      localStateSchema: json.valueTo<AlgoTypesStateSchema?, Map>(
        key: "apls",
        parse:
            (e) => AlgoTypesStateSchema.deserializeJson(
              JsonParser.valueEnsureAsMap(e),
            ),
      ),
      globalStateSchema: json.valueTo<AlgoTypesStateSchema?, Map>(
        key: "apgs",
        parse:
            (e) => AlgoTypesStateSchema.deserializeJson(
              JsonParser.valueEnsureAsMap(e),
            ),
      ),
      approvalProgram: json.valueAsBytes(
        "apap",
        encoding: StringEncoding.base64,
        onMissing: () => [],
      ),
      clearStateProgram: json.valueAsBytes(
        "apsu",
        encoding: StringEncoding.base64,
        onMissing: () => [],
      ),
      extraProgramPages: json.valueAsInt("apep", onMissing: () => 0),
      rejectVersion: json.valueAsBigInt("aprv", onMissing: () => BigInt.zero),
    );
  }

  Map<String, dynamic> toMsgPack() {
    return {
      "apid": applicationID,
      "apan": onCompletion.value,
      "apaa": applicationArgs,
      "apat": accounts,
      "apas": foreignAssets.map((e) => e).toList(),
      "apfa": foreignApps.map((e) => e).toList(),
      "al": access.map((e) => e.toMsgPack()).toList(),
      "apbx": boxReferences.map((e) => e.toMsgPack()).toList(),
      "apls": localStateSchema?.toMsgPack(),
      "apgs": globalStateSchema?.toMsgPack(),
      "apap": approvalProgram,
      "apsu": clearStateProgram,
      "apep": extraProgramPages,
      "aprv": rejectVersion,
    }.notNullValue;
  }
}

/// This file has the applications specific structures ApplicationFields are the fields that are common to all application
class AlgoTypesApplicationFields {
  /// ApplicationID is 0 when creating an application, and nonzero when calling an existing application.
  final BigInt applicationID;

  /// OnCompletion specifies an optional side-effect that this transaction will have on the balance record of the sender or the application's creator. See the documentation for the OnCompletion type for more information on each possible value.
  final AlgoTypesOnCompletion onCompletion;

  /// ApplicationArgs are arguments accessible to the executing ApprovalProgram or ClearStateProgram.
  final List<List<int>> applicationArgs;

  /// Accounts are accounts whose balance records are accessible by the executing ApprovalProgram or ClearStateProgram. To access LocalState or an ASA balance for an account besides the sender, that account's address must be listed here (and since v4, the ForeignApp or ForeignAsset must also include the app or asset id).
  final List<AlgoAddress> accounts;

  /// ForeignAssets are asset IDs for assets whose AssetParams (and since v4, Holdings) may be read by the executing ApprovalProgram or ClearStateProgram.
  final List<BigInt> foreignAssets;

  /// ForeignApps are application IDs for applications besides this one whose GlobalState (or Local, since v4) may be read by the executing ApprovalProgram or ClearStateProgram.
  final List<BigInt> foreignApps;

  /// Access unifies `Accounts`, `ForeignApps`, `ForeignAssets`, and `Boxes` under a single list. It removes all implicitly available resources, so "cross-product" resources (holdings and locals) must be explicitly listed, as well as app accounts, even the app account of the called app! Transactions using Access may not use the other lists.
  final List<AlgoTypesResourceRef> access;

  /// Boxes are the boxes that can be accessed by this transaction (and others in the same group). The Index in the BoxRef is the slot of ForeignApps that the name is associated with (shifted by 1. 0 indicates "current app")
  final List<AlgoTypesBoxReference> boxReferences;

  /// LocalStateSchema specifies the maximum number of each type that may appear in the local key/value store of users who opt in to this application. This field is only used during application creation (when the ApplicationID field is 0),
  final AlgoTypesStateSchema? localStateSchema;

  /// GlobalStateSchema specifies the maximum number of each type that may appear in the global key/value store associated with this application. This field is only used during application creation (when the ApplicationID field is 0).
  final AlgoTypesStateSchema? globalStateSchema;

  /// ApprovalProgram is the stateful TEAL bytecode that executes on all ApplicationCall transactions associated with this application, except for those where OnCompletion is equal to ClearStateOC. If this program fails, the transaction is rejected. This program may read and write local and global state for this application.
  final List<int> approvalProgram;

  /// ClearStateProgram is the stateful TEAL bytecode that executes on ApplicationCall transactions associated with this application when OnCompletion is equal to ClearStateOC. This program will not cause the transaction to be rejected, even if it fails. This program may read and write local and global state for this application.
  final List<int> clearStateProgram;

  /// ExtraProgramPages specifies the additional app program len requested in pages. A page is MaxAppProgramLen bytes. This field enables execution of app programs larger than the default config, MaxAppProgramLen.
  final int extraProgramPages;

  /// RejectVersion is the lowest application version for which this transaction should immediately fail. 0 indicates that no version check should be performed.
  final BigInt rejectVersion;

  const AlgoTypesApplicationFields({
    required this.applicationID,
    required this.onCompletion,
    required this.applicationArgs,
    required this.accounts,
    required this.foreignAssets,
    required this.foreignApps,
    required this.access,
    required this.boxReferences,
    this.localStateSchema,
    this.globalStateSchema,
    required this.approvalProgram,
    required this.clearStateProgram,
    required this.extraProgramPages,
    required this.rejectVersion,
  });

  factory AlgoTypesApplicationFields.deserializeJson(
    Map<String, dynamic> json,
  ) {
    return AlgoTypesApplicationFields(
      applicationID: json.valueAsBigInt("apid", onMissing: () => BigInt.zero),
      onCompletion: json.valueTo<AlgoTypesOnCompletion, int>(
        key: "apan",
        parse: (e) => AlgoTypesOnCompletion.fromValue(e),
      ),
      applicationArgs: json.valueTo<List<List<int>>, List>(
        key: "apaa",
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
      accounts: json.valueTo<List<AlgoAddress>, List>(
        key: "apat",
        onMissing: () => [],
        parse: (e) => e.map((x) => AlgoUtils.parseAddressOrDefault(x)).toList(),
      ),
      foreignAssets: json.valueEnsureAsList<BigInt>(
        "apas",
        onMissing: () => [],
      ),
      foreignApps: json.valueEnsureAsList<BigInt>("apfa", onMissing: () => []),
      access: json.valueTo<List<AlgoTypesResourceRef>, List>(
        key: "al",
        onMissing: () => [],
        parse:
            (e) =>
                e
                    .map(
                      (x) => AlgoTypesResourceRef.deserializeJson(
                        JsonParser.valueEnsureAsMap(x),
                      ),
                    )
                    .toList(),
      ),
      boxReferences: json.valueTo<List<AlgoTypesBoxReference>, List>(
        key: "apbx",
        onMissing: () => [],
        parse:
            (e) =>
                e
                    .map(
                      (x) => AlgoTypesBoxReference.deserializeJson(
                        JsonParser.valueEnsureAsMap(x),
                      ),
                    )
                    .toList(),
      ),
      localStateSchema: json.valueTo<AlgoTypesStateSchema?, Map>(
        key: "apls",
        parse:
            (e) => AlgoTypesStateSchema.deserializeJson(
              JsonParser.valueEnsureAsMap(e),
            ),
      ),
      globalStateSchema: json.valueTo<AlgoTypesStateSchema?, Map>(
        key: "apgs",
        parse:
            (e) => AlgoTypesStateSchema.deserializeJson(
              JsonParser.valueEnsureAsMap(e),
            ),
      ),
      approvalProgram: json.valueAsBytes(
        "apap",
        encoding: StringEncoding.base64,
        onMissing: () => [],
      ),
      clearStateProgram: json.valueAsBytes(
        "apsu",
        encoding: StringEncoding.base64,
        onMissing: () => [],
      ),
      extraProgramPages: json.valueAsInt("apep", onMissing: () => 0),
      rejectVersion: json.valueAsBigInt("aprv", onMissing: () => BigInt.zero),
    );
  }

  Map<String, dynamic> toMsgPack() {
    return {
      "apid": applicationID,
      "apan": onCompletion.value,
      "apaa": applicationArgs,
      "apat": accounts,
      "apas": foreignAssets.map((e) => e).toList(),
      "apfa": foreignApps.map((e) => e).toList(),
      "al": access.map((e) => e.toMsgPack()).toList(),
      "apbx": boxReferences.map((e) => e.toMsgPack()).toList(),
      "apls": localStateSchema?.toMsgPack(),
      "apgs": globalStateSchema?.toMsgPack(),
      "apap": approvalProgram,
      "apsu": clearStateProgram,
      "apep": extraProgramPages,
      "aprv": rejectVersion,
    }.notNullValue;
  }
}

/// ApplyData contains information about the transaction's execution.
class AlgoTypesApplyData {
  /// Closing amount for transaction.
  final BigInt closingAmount;

  /// Closing amount for asset transaction.
  final BigInt assetClosingAmount;

  /// Rewards applied to the Sender, Receiver, and CloseRemainderTo accounts.
  final BigInt senderRewards;
  final BigInt receiverRewards;
  final BigInt closeRewards;
  final AlgoTypesEvalDelta? evalDelta;

  /// If asa or app is being created, the id used. Else 0. Names chosen to match naming the corresponding txn. These are populated only when MaxInnerTransactions > 0 (TEAL 5)
  final BigInt configAsset;
  final BigInt applicationID;

  const AlgoTypesApplyData({
    required this.closingAmount,
    required this.assetClosingAmount,
    required this.senderRewards,
    required this.receiverRewards,
    required this.closeRewards,
    this.evalDelta,
    required this.configAsset,
    required this.applicationID,
  });

  factory AlgoTypesApplyData.deserializeJson(Map<String, dynamic> json) {
    return AlgoTypesApplyData(
      closingAmount: json.valueAsBigInt("ca", onMissing: () => BigInt.zero),
      assetClosingAmount: json.valueAsBigInt(
        "aca",
        onMissing: () => BigInt.zero,
      ),
      senderRewards: json.valueAsBigInt("rs", onMissing: () => BigInt.zero),
      receiverRewards: json.valueAsBigInt("rr", onMissing: () => BigInt.zero),
      closeRewards: json.valueAsBigInt("rc", onMissing: () => BigInt.zero),
      evalDelta: json.valueTo<AlgoTypesEvalDelta?, Map>(
        key: "dt",
        parse:
            (e) => AlgoTypesEvalDelta.deserializeJson(
              JsonParser.valueEnsureAsMap(e),
            ),
      ),
      configAsset: json.valueAsBigInt("caid", onMissing: () => BigInt.zero),
      applicationID: json.valueAsBigInt("apid", onMissing: () => BigInt.zero),
    );
  }

  Map<String, dynamic> toMsgPack() {
    return {
      "ca": closingAmount,
      "aca": assetClosingAmount,
      "rs": senderRewards,
      "rr": receiverRewards,
      "rc": closeRewards,
      "dt": evalDelta?.toMsgPack(),
      "caid": configAsset,
      "apid": applicationID,
    }.notNullValue;
  }
}

/// AssetConfigTxnFields captures the fields used for asset allocation, re-configuration, and destruction.
class AlgoTypesAssetConfigTxnFields {
  /// ConfigAsset is the asset being configured or destroyed. A zero value means allocation
  final BigInt configAsset;

  /// AssetParams are the parameters for the asset being created or re-configured.  A zero value means destruction.
  final AlgoTypesAssetParams? assetParams;

  const AlgoTypesAssetConfigTxnFields({
    required this.configAsset,
    this.assetParams,
  });

  factory AlgoTypesAssetConfigTxnFields.deserializeJson(
    Map<String, dynamic> json,
  ) {
    return AlgoTypesAssetConfigTxnFields(
      configAsset: json.valueAsBigInt("caid", onMissing: () => BigInt.zero),
      assetParams: json.valueTo<AlgoTypesAssetParams?, Map>(
        key: "apar",
        parse:
            (e) => AlgoTypesAssetParams.deserializeJson(
              JsonParser.valueEnsureAsMap(e),
            ),
      ),
    );
  }

  Map<String, dynamic> toMsgPack() {
    return {"caid": configAsset, "apar": assetParams?.toMsgPack()}.notNullValue;
  }
}

/// AssetFreezeTxnFields captures the fields used for freezing asset slots.
class AlgoTypesAssetFreezeTxnFields {
  /// FreezeAccount is the address of the account whose asset slot is being frozen or un-frozen.
  final AlgoAddress freezeAccount;

  /// FreezeAsset is the asset ID being frozen or un-frozen.
  final BigInt freezeAsset;

  /// AssetFrozen is the new frozen value.
  final bool assetFrozen;

  const AlgoTypesAssetFreezeTxnFields({
    required this.freezeAccount,
    required this.freezeAsset,
    required this.assetFrozen,
  });

  factory AlgoTypesAssetFreezeTxnFields.deserializeJson(
    Map<String, dynamic> json,
  ) {
    return AlgoTypesAssetFreezeTxnFields(
      freezeAccount: AlgoUtils.parseAddressOrDefault(json.valueAs("fadd")),

      freezeAsset: json.valueAsBigInt("faid", onMissing: () => BigInt.zero),
      assetFrozen: json.valueAsBool("afrz", onMissing: () => false),
    );
  }

  Map<String, dynamic> toMsgPack() {
    return {
      "fadd": freezeAccount,
      "faid": freezeAsset,
      "afrz": assetFrozen,
    }.notNullValue;
  }
}

/// AssetHolding describes an asset held by an account.
class AlgoTypesAssetHolding {
  final BigInt amount;
  final bool frozen;

  const AlgoTypesAssetHolding({required this.amount, required this.frozen});

  factory AlgoTypesAssetHolding.deserializeJson(Map<String, dynamic> json) {
    return AlgoTypesAssetHolding(
      amount: json.valueAsBigInt("a", onMissing: () => BigInt.zero),
      frozen: json.valueAsBool("f", onMissing: () => false),
    );
  }

  Map<String, dynamic> toMsgPack() {
    return {"a": amount, "f": frozen}.notNullValue;
  }
}

/// AssetHoldingDelta records a changed AssetHolding, and whether it was deleted
class AlgoTypesAssetHoldingDelta {
  final AlgoTypesAssetHolding? holding;
  final bool deleted;

  const AlgoTypesAssetHoldingDelta({this.holding, required this.deleted});

  factory AlgoTypesAssetHoldingDelta.fromJson(Map<String, dynamic> json) {
    return AlgoTypesAssetHoldingDelta(
      holding: json.valueTo<AlgoTypesAssetHolding?, Map>(
        key: "Holding",
        parse:
            (e) => AlgoTypesAssetHolding.deserializeJson(
              JsonParser.valueEnsureAsMap(e),
            ),
      ),
      deleted: json.valueAsBool("Deleted", onMissing: () => false),
    );
  }

  Map<String, dynamic> toJson() {
    return {"Holding": holding?.toMsgPack(), "Deleted": deleted}.notNullValue;
  }
}

/// AssetParams describes the parameters of an asset.
class AlgoTypesAssetParams {
  /// Total specifies the total number of units of this asset created.
  final BigInt total;

  /// Decimals specifies the number of digits to display after the decimal place when displaying this asset. A value of 0 represents an asset that is not divisible, a value of 1 represents an asset divisible into tenths, and so on. This value must be between 0 and 19 (inclusive).
  final int decimals;

  /// DefaultFrozen specifies whether slots for this asset in user accounts are frozen by default or not.
  final bool defaultFrozen;

  /// UnitName specifies a hint for the name of a unit of this asset.
  final String unitName;

  /// AssetName specifies a hint for the name of the asset.
  final String assetName;

  /// URL specifies a URL where more information about the asset can be retrieved
  final String uRL;

  /// MetadataHash specifies a commitment to some unspecified asset metadata. The format of this metadata is up to the application.
  final List<int> metadataHash;

  /// Manager specifies an account that is allowed to change the non-zero addresses in this AssetParams.
  final AlgoAddress manager;

  /// Reserve specifies an account whose holdings of this asset should be reported as "not minted".
  final AlgoAddress reserve;

  /// Freeze specifies an account that is allowed to change the frozen state of holdings of this asset.
  final AlgoAddress freeze;

  /// Clawback specifies an account that is allowed to take units of this asset from any account.
  final AlgoAddress clawback;

  const AlgoTypesAssetParams({
    required this.total,
    required this.decimals,
    required this.defaultFrozen,
    required this.unitName,
    required this.assetName,
    required this.uRL,
    required this.metadataHash,
    required this.manager,
    required this.reserve,
    required this.freeze,
    required this.clawback,
  });

  factory AlgoTypesAssetParams.deserializeJson(Map<String, dynamic> json) {
    return AlgoTypesAssetParams(
      total: json.valueAsBigInt("t", onMissing: () => BigInt.zero),
      decimals: json.valueAsInt("dc", onMissing: () => 0),
      defaultFrozen: json.valueAsBool("df", onMissing: () => false),
      unitName: json.valueAsString(
        "un",
        bytesEncoding: StringEncoding.utf8,
        onMissing: () => '',
      ),
      assetName: json.valueAsString(
        "an",
        bytesEncoding: StringEncoding.utf8,
        onMissing: () => '',
      ),
      uRL: json.valueAsString(
        "au",
        bytesEncoding: StringEncoding.utf8,
        onMissing: () => '',
      ),
      metadataHash: json.valueAsBytes(
        "am",
        encoding: StringEncoding.base64,
        onMissing: () => [],
      ),
      manager: AlgoUtils.parseAddressOrDefault(json.valueAs("m")),

      reserve: AlgoUtils.parseAddressOrDefault(json.valueAs("r")),

      freeze: AlgoUtils.parseAddressOrDefault(json.valueAs("f")),

      clawback: AlgoUtils.parseAddressOrDefault(json.valueAs("c")),
    );
  }

  Map<String, dynamic> toMsgPack() {
    return {
      "t": total,
      "dc": decimals,
      "df": defaultFrozen,
      "un": unitName,
      "an": assetName,
      "au": uRL,
      "am": metadataHash,
      "m": manager,
      "r": reserve,
      "f": freeze,
      "c": clawback,
    }.notNullValue;
  }
}

/// AssetParamsDelta tracks a changed AssetParams, and whether it was deleted
class AlgoTypesAssetParamsDelta {
  final AlgoTypesAssetParams? params;
  final bool deleted;

  const AlgoTypesAssetParamsDelta({this.params, required this.deleted});

  factory AlgoTypesAssetParamsDelta.fromJson(Map<String, dynamic> json) {
    return AlgoTypesAssetParamsDelta(
      params: json.valueTo<AlgoTypesAssetParams?, Map>(
        key: "Params",
        parse:
            (e) => AlgoTypesAssetParams.deserializeJson(
              JsonParser.valueEnsureAsMap(e),
            ),
      ),
      deleted: json.valueAsBool("Deleted", onMissing: () => false),
    );
  }

  Map<String, dynamic> toJson() {
    return {"Params": params?.toMsgPack(), "Deleted": deleted}.notNullValue;
  }
}

/// AssetResourceRecord represents AssetParams and AssetHolding in deltas
class AlgoTypesAssetResourceRecord {
  final BigInt aidx;
  final AlgoAddress addr;
  final AlgoTypesAssetParamsDelta params;
  final AlgoTypesAssetHoldingDelta holding;

  const AlgoTypesAssetResourceRecord({
    required this.aidx,
    required this.addr,
    required this.params,
    required this.holding,
  });

  factory AlgoTypesAssetResourceRecord.fromJson(Map<String, dynamic> json) {
    return AlgoTypesAssetResourceRecord(
      aidx: json.valueAsBigInt("Aidx", onMissing: () => BigInt.zero),
      addr: AlgoUtils.parseAddressOrDefault(json.valueAs("Addr")),

      params: json.valueTo<AlgoTypesAssetParamsDelta, Map>(
        key: "Params",
        parse:
            (e) => AlgoTypesAssetParamsDelta.fromJson(
              JsonParser.valueEnsureAsMap(e),
            ),
      ),
      holding: json.valueTo<AlgoTypesAssetHoldingDelta, Map>(
        key: "Holding",
        parse:
            (e) => AlgoTypesAssetHoldingDelta.fromJson(
              JsonParser.valueEnsureAsMap(e),
            ),
      ),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "Aidx": aidx,
      "Addr": addr,
      "Params": params.toJson(),
      "Holding": holding.toJson(),
    }.notNullValue;
  }
}

/// AssetTransferTxnFields captures the fields used for asset transfers.
class AlgoTypesAssetTransferTxnFields {
  final BigInt xferAsset;

  /// AssetAmount is the amount of asset to transfer. A zero amount transferred to self allocates that asset in the account's Assets map.
  final BigInt assetAmount;

  /// AssetSender is the sender of the transfer.  If this is not a zero value, the real transaction sender must be the Clawback address from the AssetParams.  If this is the zero value, the asset is sent from the transaction's Sender.
  final AlgoAddress assetSender;

  /// AssetReceiver is the recipient of the transfer.
  final AlgoAddress assetReceiver;

  /// AssetCloseTo indicates that the asset should be removed from the account's Assets map, and specifies where the remaining asset holdings should be transferred.  It's always valid to transfer remaining asset holdings to the creator account.
  final AlgoAddress assetCloseTo;

  const AlgoTypesAssetTransferTxnFields({
    required this.xferAsset,
    required this.assetAmount,
    required this.assetSender,
    required this.assetReceiver,
    required this.assetCloseTo,
  });

  factory AlgoTypesAssetTransferTxnFields.deserializeJson(
    Map<String, dynamic> json,
  ) {
    return AlgoTypesAssetTransferTxnFields(
      xferAsset: json.valueAsBigInt("xaid", onMissing: () => BigInt.zero),
      assetAmount: json.valueAsBigInt("aamt", onMissing: () => BigInt.zero),
      assetSender: AlgoUtils.parseAddressOrDefault(json.valueAs("asnd")),

      assetReceiver: AlgoUtils.parseAddressOrDefault(json.valueAs("arcv")),

      assetCloseTo: AlgoUtils.parseAddressOrDefault(json.valueAs("aclose")),
    );
  }

  Map<String, dynamic> toMsgPack() {
    return {
      "xaid": xferAsset,
      "aamt": assetAmount,
      "asnd": assetSender,
      "arcv": assetReceiver,
      "aclose": assetCloseTo,
    }.notNullValue;
  }
}

/// BalanceRecord is similar to basics.BalanceRecord but with decoupled base and voting data
class AlgoTypesBalanceRecord {
  final AlgoAddress addr;
  final dynamic status;
  final BigInt microAlgos;
  final BigInt rewardsBase;
  final BigInt rewardedMicroAlgos;
  final AlgoAddress authAddr;
  final bool incentiveEligible;
  final AlgoTypesStateSchema? totalAppSchema;
  final int totalExtraAppPages;
  final BigInt totalAppParams;
  final BigInt totalAppLocalStates;
  final BigInt totalAssetParams;
  final BigInt totalAssets;
  final BigInt totalBoxes;
  final BigInt totalBoxBytes;
  final BigInt lastProposed;
  final BigInt lastHeartbeat;
  final AlgoTypesOneTimeSignatureVerifier voteID;
  final AlgoTypesVRFVerifier selectionID;
  final List<int> stateProofID;
  final BigInt voteFirstValid;
  final BigInt voteLastValid;
  final BigInt voteKeyDilution;

  const AlgoTypesBalanceRecord({
    required this.addr,
    required this.status,
    required this.microAlgos,
    required this.rewardsBase,
    required this.rewardedMicroAlgos,
    required this.authAddr,
    required this.incentiveEligible,
    this.totalAppSchema,
    required this.totalExtraAppPages,
    required this.totalAppParams,
    required this.totalAppLocalStates,
    required this.totalAssetParams,
    required this.totalAssets,
    required this.totalBoxes,
    required this.totalBoxBytes,
    required this.lastProposed,
    required this.lastHeartbeat,
    required this.voteID,
    required this.selectionID,
    required this.stateProofID,
    required this.voteFirstValid,
    required this.voteLastValid,
    required this.voteKeyDilution,
  });

  factory AlgoTypesBalanceRecord.fromJson(Map<String, dynamic> json) {
    return AlgoTypesBalanceRecord(
      addr: AlgoUtils.parseAddressOrDefault(json.valueAs("Addr")),

      status: json["Status"],
      microAlgos: json.valueAsBigInt(
        "MicroAlgos",
        onMissing: () => BigInt.zero,
      ),
      rewardsBase: json.valueAsBigInt(
        "RewardsBase",
        onMissing: () => BigInt.zero,
      ),
      rewardedMicroAlgos: json.valueAsBigInt(
        "RewardedMicroAlgos",
        onMissing: () => BigInt.zero,
      ),
      authAddr: AlgoUtils.parseAddressOrDefault(json.valueAs("AuthAddr")),

      incentiveEligible: json.valueAsBool(
        "IncentiveEligible",
        onMissing: () => false,
      ),
      totalAppSchema: json.valueTo<AlgoTypesStateSchema?, Map>(
        key: "TotalAppSchema",
        parse:
            (e) => AlgoTypesStateSchema.deserializeJson(
              JsonParser.valueEnsureAsMap(e),
            ),
      ),
      totalExtraAppPages: json.valueAsInt(
        "TotalExtraAppPages",
        onMissing: () => 0,
      ),
      totalAppParams: json.valueAsBigInt(
        "TotalAppParams",
        onMissing: () => BigInt.zero,
      ),
      totalAppLocalStates: json.valueAsBigInt(
        "TotalAppLocalStates",
        onMissing: () => BigInt.zero,
      ),
      totalAssetParams: json.valueAsBigInt(
        "TotalAssetParams",
        onMissing: () => BigInt.zero,
      ),
      totalAssets: json.valueAsBigInt(
        "TotalAssets",
        onMissing: () => BigInt.zero,
      ),
      totalBoxes: json.valueAsBigInt(
        "TotalBoxes",
        onMissing: () => BigInt.zero,
      ),
      totalBoxBytes: json.valueAsBigInt(
        "TotalBoxBytes",
        onMissing: () => BigInt.zero,
      ),
      lastProposed: json.valueAsBigInt(
        "LastProposed",
        onMissing: () => BigInt.zero,
      ),
      lastHeartbeat: json.valueAsBigInt(
        "LastHeartbeat",
        onMissing: () => BigInt.zero,
      ),
      voteID: json.valueAsBytes(
        "VoteID",
        encoding: StringEncoding.base64,
        onMissing: () => [],
      ),
      selectionID: json.valueAsBytes(
        "SelectionID",
        encoding: StringEncoding.base64,
        onMissing: () => List<int>.filled(QuickCrypto.sha256DigestSize, 0),
      ),
      stateProofID: json.valueAsBytes(
        "StateProofID",
        encoding: StringEncoding.base64,
        onMissing: () => List<int>.filled(QuickCrypto.sha512DigestLength, 0),
      ),
      voteFirstValid: json.valueAsBigInt(
        "VoteFirstValid",
        onMissing: () => BigInt.zero,
      ),
      voteLastValid: json.valueAsBigInt(
        "VoteLastValid",
        onMissing: () => BigInt.zero,
      ),
      voteKeyDilution: json.valueAsBigInt(
        "VoteKeyDilution",
        onMissing: () => BigInt.zero,
      ),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "Addr": addr,
      "Status": status,
      "MicroAlgos": microAlgos,
      "RewardsBase": rewardsBase,
      "RewardedMicroAlgos": rewardedMicroAlgos,
      "AuthAddr": authAddr,
      "IncentiveEligible": incentiveEligible,
      "TotalAppSchema": totalAppSchema?.toMsgPack(),
      "TotalExtraAppPages": totalExtraAppPages,
      "TotalAppParams": totalAppParams,
      "TotalAppLocalStates": totalAppLocalStates,
      "TotalAssetParams": totalAssetParams,
      "TotalAssets": totalAssets,
      "TotalBoxes": totalBoxes,
      "TotalBoxBytes": totalBoxBytes,
      "LastProposed": lastProposed,
      "LastHeartbeat": lastHeartbeat,
      "VoteID": voteID,
      "SelectionID": selectionID,
      "StateProofID": stateProofID,
      "VoteFirstValid": voteFirstValid,
      "VoteLastValid": voteLastValid,
      "VoteKeyDilution": voteKeyDilution,
    }.notNullValue;
  }
}

/// Bid represents a bid by a user as part of an auction.
class AlgoTypesBid with LayoutSerializable {
  /// BidderKey identifies the bidder placing this bid.
  final AlgoAddress bidderKey;

  /// BidCurrency specifies how much external currency the bidder is putting in with this bid.
  final BigInt bidCurrency;

  /// MaxPrice specifies the maximum price, in units of external currency per Algo, that the bidder is willing to pay. This must be at least as high as the current price of the auction in the block in which this bid appears.
  final BigInt maxPrice;

  /// BidID identifies this bid.  The first bid by a bidder (identified by BidderKey) with a particular BidID on the blockchain will be considered, preventing replay of bids.  Specifying a different BidID allows the bidder to place multiple bids in an auction.
  final BigInt bidID;

  /// AuctionKey specifies the auction for this bid.
  final AlgoAddress auctionKey;

  /// AuctionID identifies the auction for which this bid is intended.
  final BigInt auctionID;

  const AlgoTypesBid({
    required this.bidderKey,
    required this.bidCurrency,
    required this.maxPrice,
    required this.bidID,
    required this.auctionKey,
    required this.auctionID,
  });
  static MsgPackFixedKeyDynamicLazyValueMapLayout<
    String,
    dynamic,
    LayoutRepository
  >
  layout({String? property}) {
    return MsgPackFixedKeyDynamicLazyValueMapLayout<
      String,
      dynamic,
      LayoutRepository
    >(
      keyLayout: MsgPackStringLayout(),
      sortKeys: true,
      valueLayouts: [
        MapEntry(
          "bidder",
          LazyMsgPackMapLayoutBuilder(
            layout: AlgoAddressLayout.defaultAddressLayout,
          ),
        ),
        MapEntry(
          "cur",
          LazyMsgPackMapLayoutBuilder(
            layout: AlgoBigIntLayout.defaultU64Layout,
          ),
        ),
        MapEntry(
          "price",
          LazyMsgPackMapLayoutBuilder(
            layout: AlgoBigIntLayout.defaultU64Layout,
          ),
        ),
        MapEntry(
          "id",
          LazyMsgPackMapLayoutBuilder(
            layout: AlgoBigIntLayout.defaultU64Layout,
          ),
        ),
        MapEntry(
          "auc",
          LazyMsgPackMapLayoutBuilder(
            layout: AlgoAddressLayout.defaultAddressLayout,
          ),
        ),
        MapEntry(
          "aid",
          LazyMsgPackMapLayoutBuilder(
            layout: AlgoBigIntLayout.defaultU64Layout,
          ),
        ),
      ],
      property: property,
    );
  }

  factory AlgoTypesBid.deserializeJson(Map<String, dynamic> json) {
    return AlgoTypesBid(
      bidderKey: AlgoUtils.parseAddressOrDefault(json.valueAs("bidder")),
      bidCurrency: json.valueAsBigInt("cur", onMissing: () => BigInt.zero),
      maxPrice: json.valueAsBigInt("price", onMissing: () => BigInt.zero),
      bidID: json.valueAsBigInt("id", onMissing: () => BigInt.zero),
      auctionKey: AlgoUtils.parseAddressOrDefault(json.valueAs("auc")),

      auctionID: json.valueAsBigInt("aid", onMissing: () => BigInt.zero),
    );
  }

  @override
  Layout<Map<String, dynamic>> toLayout({String? property}) {
    return layout(property: property);
  }

  @override
  Map<String, dynamic> toSerializeJson() {
    return {
      "bidder": bidderKey.toBytes(),
      "cur": bidCurrency,
      "price": maxPrice,
      "id": bidID,
      "auc": auctionKey.toBytes(),
      "aid": auctionID,
    };
  }
}

/// A Block contains the Payset and metadata corresponding to a given Round.
class AlgoTypesBlock {
  final BigInt round;

  /// The hash of the previous block
  final List<int> branch;

  /// The hash of the previous block, using SHA-512
  final List<int> branch512;

  /// Sortition seed
  final AlgoTypesSeed seed;

  /// Root of transaction Merkle tree using the SHA-512/256 hash function. This commitment is computed based on the PaysetCommit type specified in the block's consensus protocol.
  final List<int> nativeSha512256Commitment;

  /// Root of transaction vector commitment Merkle tree using the SHA-256 hash function.
  final List<int> sha256Commitment;

  /// Root of transaction vector commitment Merkle tree using the SHA-512 hash function.
  final List<int> sha512Commitment;

  /// TimeStamp in seconds since epoch
  final BigInt timeStamp;

  /// Genesis ID to which this block belongs.
  final String genesisID;

  /// Genesis hash to which this block belongs.
  final List<int> genesisHash;

  /// Proposer is the proposer of this block. Like the Seed, agreement adds this after the block is assembled by the transaction pool, so that the same block can be prepared for multiple participating accounts in the same node. Therefore, it can not be used to influence block evaluation. Populated if proto.Payouts.Enabled
  final AlgoAddress proposer;

  /// FeesCollected is the sum of all fees paid by transactions in this block. Populated if proto.Payouts.Enabled
  final BigInt feesCollected;

  /// Bonus is the bonus incentive to be paid for proposing this block.  It begins as a consensus parameter value, and decays periodically.
  final BigInt bonus;

  /// ProposerPayout is the amount that is moved from the FeeSink to the Proposer in this block.  It is basically the bonus + the payouts percent of FeesCollected, but may be zero'd by proposer ineligibility.
  final BigInt proposerPayout;

  /// The FeeSink accepts transaction fees. It can only spend to the incentive pool.
  final AlgoAddress feeSink;

  /// The RewardsPool accepts periodic injections from the FeeSink and continually redistributes them to addresses as rewards.
  final AlgoAddress rewardsPool;

  /// RewardsLevel specifies how many rewards, in MicroAlgos, have been distributed to each config.Protocol.RewardUnit of MicroAlgos since genesis.
  final BigInt rewardsLevel;

  /// The number of new MicroAlgos added to the participation stake from rewards at the next round.
  final BigInt rewardsRate;

  /// The number of leftover MicroAlgos after the distribution of RewardsRate/rewardUnits MicroAlgos for every reward unit in the next round.
  final BigInt rewardsResidue;

  /// The round at which the RewardsRate will be recalculated.
  final BigInt rewardsRecalculationRound;
  final String currentProtocol;
  final String nextProtocol;

  /// NextProtocolApprovals is the number of approvals for the next protocol proposal. It is expressed in Round because it is a count of rounds.
  final BigInt nextProtocolApprovals;

  /// NextProtocolVoteBefore specifies the last voting round for the next protocol proposal. If there is no voting for an upgrade taking place, this would be zero.
  final BigInt nextProtocolVoteBefore;

  /// NextProtocolSwitchOn specify the round number at which the next protocol would be adopted. If there is no upgrade taking place, nor a wait for the next protocol, this would be zero.
  final BigInt nextProtocolSwitchOn;

  /// UpgradePropose indicates a proposed upgrade
  final String upgradePropose;

  /// UpgradeDelay indicates the time between acceptance and execution
  final BigInt upgradeDelay;

  /// UpgradeApprove indicates a yes vote for the current proposal
  final bool upgradeApprove;

  /// TxnCounter is the number of the next transaction that will be committed after this block.  Genesis blocks can start at either 0 or 1000, depending on a consensus parameter (AppForbidLowResources).
  final BigInt txnCounter;

  /// StateProofTracking tracks the status of the state proofs, potentially for multiple types of ASPs (Algorand's State Proofs).
  final Map<AlgoTypesStateProofType, AlgoTypesStateProofTrackingData>
  stateProofTracking;

  /// ExpiredParticipationAccounts contains a list of online accounts that needs to be converted to offline since their participation key expired.
  final List<AlgoAddress> expiredParticipationAccounts;

  /// AbsentParticipationAccounts contains a list of online accounts that needs to be converted to offline since they are not proposing.
  final List<AlgoAddress> absentParticipationAccounts;

  /// Load is the degree to which a block is full. Currently, it is based on the number of bytes in the final block, compared to the maximum allowed. It is expressed as a fixed-point integer with 6 digits of precision.  So, 1,000,000 is a completely full block.
  final BigInt load;

  /// CongestionTax fee required, beyond the MinFee, for "normal" transactions in this block.
  final BigInt congestionTax;
  final List<AlgoTypesSignedTxnInBlock> payset;

  const AlgoTypesBlock({
    required this.round,
    required this.branch,
    required this.branch512,
    required this.seed,
    required this.nativeSha512256Commitment,
    required this.sha256Commitment,
    required this.sha512Commitment,
    required this.timeStamp,
    required this.genesisID,
    required this.genesisHash,
    required this.proposer,
    required this.feesCollected,
    required this.bonus,
    required this.proposerPayout,
    required this.feeSink,
    required this.rewardsPool,
    required this.rewardsLevel,
    required this.rewardsRate,
    required this.rewardsResidue,
    required this.rewardsRecalculationRound,
    required this.currentProtocol,
    required this.nextProtocol,
    required this.nextProtocolApprovals,
    required this.nextProtocolVoteBefore,
    required this.nextProtocolSwitchOn,
    required this.upgradePropose,
    required this.upgradeDelay,
    required this.upgradeApprove,
    required this.txnCounter,
    required this.stateProofTracking,
    required this.expiredParticipationAccounts,
    required this.absentParticipationAccounts,
    required this.load,
    required this.congestionTax,
    required this.payset,
  });

  factory AlgoTypesBlock.deserializeJson(Map<String, dynamic> json) {
    return AlgoTypesBlock(
      round: json.valueAsBigInt("rnd", onMissing: () => BigInt.zero),
      branch: AlgoUtils.parseBlockHash(json.valueAs("prev")),
      branch512: json.valueAsBytes(
        "prev512",
        encoding: StringEncoding.base64,
        onMissing: () => List<int>.filled(QuickCrypto.sha512DigestLength, 0),
      ),
      seed: json.valueAsBytes(
        "seed",
        encoding: StringEncoding.base64,
        onMissing: () => List<int>.filled(QuickCrypto.sha256DigestSize, 0),
      ),
      nativeSha512256Commitment: json.valueAsBytes(
        "txn",
        encoding: StringEncoding.base64,
        onMissing: () => List<int>.filled(QuickCrypto.sha256DigestSize, 0),
      ),
      sha256Commitment: json.valueAsBytes(
        "txn256",
        encoding: StringEncoding.base64,
        onMissing: () => List<int>.filled(QuickCrypto.sha256DigestSize, 0),
      ),
      sha512Commitment: json.valueAsBytes(
        "txn512",
        encoding: StringEncoding.base64,
        onMissing: () => List<int>.filled(QuickCrypto.sha512DigestLength, 0),
      ),
      timeStamp: json.valueAsBigInt("ts", onMissing: () => BigInt.zero),
      genesisID: json.valueAsString(
        "gen",
        bytesEncoding: StringEncoding.utf8,
        onMissing: () => '',
      ),
      genesisHash: json.valueAsBytes(
        "gh",
        encoding: StringEncoding.base64,
        onMissing: () => List<int>.filled(QuickCrypto.sha256DigestSize, 0),
      ),
      proposer: AlgoUtils.parseAddressOrDefault(json.valueAs("prp")),

      feesCollected: json.valueAsBigInt("fc", onMissing: () => BigInt.zero),
      bonus: json.valueAsBigInt("bi", onMissing: () => BigInt.zero),
      proposerPayout: json.valueAsBigInt("pp", onMissing: () => BigInt.zero),
      feeSink: AlgoUtils.parseAddressOrDefault(json.valueAs("fees")),

      rewardsPool: AlgoUtils.parseAddressOrDefault(json.valueAs("rwd")),

      rewardsLevel: json.valueAsBigInt("earn", onMissing: () => BigInt.zero),
      rewardsRate: json.valueAsBigInt("rate", onMissing: () => BigInt.zero),
      rewardsResidue: json.valueAsBigInt("frac", onMissing: () => BigInt.zero),
      rewardsRecalculationRound: json.valueAsBigInt(
        "rwcalr",
        onMissing: () => BigInt.zero,
      ),
      currentProtocol: json.valueAsString(
        "proto",
        bytesEncoding: StringEncoding.utf8,
        onMissing: () => '',
      ),
      nextProtocol: json.valueAsString(
        "nextproto",
        bytesEncoding: StringEncoding.utf8,
        onMissing: () => '',
      ),
      nextProtocolApprovals: json.valueAsBigInt(
        "nextyes",
        onMissing: () => BigInt.zero,
      ),
      nextProtocolVoteBefore: json.valueAsBigInt(
        "nextbefore",
        onMissing: () => BigInt.zero,
      ),
      nextProtocolSwitchOn: json.valueAsBigInt(
        "nextswitch",
        onMissing: () => BigInt.zero,
      ),
      upgradePropose: json.valueAsString(
        "upgradeprop",
        bytesEncoding: StringEncoding.utf8,
        onMissing: () => '',
      ),
      upgradeDelay: json.valueAsBigInt(
        "upgradedelay",
        onMissing: () => BigInt.zero,
      ),
      upgradeApprove: json.valueAsBool("upgradeyes", onMissing: () => false),
      txnCounter: json.valueAsBigInt("tc", onMissing: () => BigInt.zero),
      stateProofTracking: json.valueTo<
        Map<AlgoTypesStateProofType, AlgoTypesStateProofTrackingData>,
        Map
      >(
        key: "spt",
        onMissing: () => {},
        parse:
            (e) => e.map(
              (k, v) => MapEntry(
                AlgoTypesStateProofType.fromValue(JsonParser.valueAsInt(k)),
                AlgoTypesStateProofTrackingData.deserializeJson(
                  JsonParser.valueEnsureAsMap(v),
                ),
              ),
            ),
      ),
      expiredParticipationAccounts: json.valueTo<List<AlgoAddress>, List>(
        key: "partupdrmv",
        onMissing: () => [],
        parse: (e) => e.map(AlgoUtils.parseAddressOrDefault).toList(),
      ),
      absentParticipationAccounts: json.valueTo<List<AlgoAddress>, List>(
        key: "partupdabs",
        onMissing: () => [],
        parse: (e) => e.map(AlgoUtils.parseAddressOrDefault).toList(),
      ),
      load: json.valueAsBigInt("ld", onMissing: () => BigInt.zero),
      congestionTax: json.valueAsBigInt("ct", onMissing: () => BigInt.zero),
      payset: json.valueTo<List<AlgoTypesSignedTxnInBlock>, List>(
        key: "txns",
        onMissing: () => [],
        parse:
            (e) =>
                e
                    .map(
                      (x) => AlgoTypesSignedTxnInBlock.deserializeJson(
                        JsonParser.valueEnsureAsMap(x),
                      ),
                    )
                    .toList(),
      ),
    );
  }

  Map<String, dynamic> toMsgPack() {
    return {
      "rnd": round,
      "prev": branch,
      "prev512": branch512,
      "seed": seed,
      "txn": nativeSha512256Commitment,
      "txn256": sha256Commitment,
      "txn512": sha512Commitment,
      "ts": timeStamp,
      "gen": genesisID,
      "gh": genesisHash,
      "prp": proposer,
      "fc": feesCollected,
      "bi": bonus,
      "pp": proposerPayout,
      "fees": feeSink,
      "rwd": rewardsPool,
      "earn": rewardsLevel,
      "rate": rewardsRate,
      "frac": rewardsResidue,
      "rwcalr": rewardsRecalculationRound,
      "proto": currentProtocol,
      "nextproto": nextProtocol,
      "nextyes": nextProtocolApprovals,
      "nextbefore": nextProtocolVoteBefore,
      "nextswitch": nextProtocolSwitchOn,
      "upgradeprop": upgradePropose,
      "upgradedelay": upgradeDelay,
      "upgradeyes": upgradeApprove,
      "tc": txnCounter,
      "spt": stateProofTracking.map((k, e) => MapEntry(k.value, e.toMsgPack())),
      "partupdrmv": expiredParticipationAccounts,
      "partupdabs": absentParticipationAccounts,
      "ld": load,
      "ct": congestionTax,
      "txns": payset.map((e) => e.toMsgPack()).toList(),
    }.notNullValue;
  }
}

/// A BlockHeader represents the metadata and commitments to the state of a Block. The Algorand Ledger may be defined minimally as a cryptographically authenticated series of BlockHeader objects.
class AlgoTypesBlockHeader {
  final BigInt round;

  /// The hash of the previous block
  final List<int> branch;

  /// The hash of the previous block, using SHA-512
  final List<int> branch512;

  /// Sortition seed
  final AlgoTypesSeed seed;

  /// Root of transaction Merkle tree using the SHA-512/256 hash function. This commitment is computed based on the PaysetCommit type specified in the block's consensus protocol.
  final List<int> nativeSha512256Commitment;

  /// Root of transaction vector commitment Merkle tree using the SHA-256 hash function.
  final List<int> sha256Commitment;

  /// Root of transaction vector commitment Merkle tree using the SHA-512 hash function.
  final List<int> sha512Commitment;

  /// TimeStamp in seconds since epoch
  final BigInt timeStamp;

  /// Genesis ID to which this block belongs.
  final String genesisID;

  /// Genesis hash to which this block belongs.
  final List<int> genesisHash;

  /// Proposer is the proposer of this block. Like the Seed, agreement adds this after the block is assembled by the transaction pool, so that the same block can be prepared for multiple participating accounts in the same node. Therefore, it can not be used to influence block evaluation. Populated if proto.Payouts.Enabled
  final AlgoAddress proposer;

  /// FeesCollected is the sum of all fees paid by transactions in this block. Populated if proto.Payouts.Enabled
  final BigInt feesCollected;

  /// Bonus is the bonus incentive to be paid for proposing this block.  It begins as a consensus parameter value, and decays periodically.
  final BigInt bonus;

  /// ProposerPayout is the amount that is moved from the FeeSink to the Proposer in this block.  It is basically the bonus + the payouts percent of FeesCollected, but may be zero'd by proposer ineligibility.
  final BigInt proposerPayout;

  /// The FeeSink accepts transaction fees. It can only spend to the incentive pool.
  final AlgoAddress feeSink;

  /// The RewardsPool accepts periodic injections from the FeeSink and continually redistributes them to addresses as rewards.
  final AlgoAddress rewardsPool;

  /// RewardsLevel specifies how many rewards, in MicroAlgos, have been distributed to each config.Protocol.RewardUnit of MicroAlgos since genesis.
  final BigInt rewardsLevel;

  /// The number of new MicroAlgos added to the participation stake from rewards at the next round.
  final BigInt rewardsRate;

  /// The number of leftover MicroAlgos after the distribution of RewardsRate/rewardUnits MicroAlgos for every reward unit in the next round.
  final BigInt rewardsResidue;

  /// The round at which the RewardsRate will be recalculated.
  final BigInt rewardsRecalculationRound;
  final String currentProtocol;
  final String nextProtocol;

  /// NextProtocolApprovals is the number of approvals for the next protocol proposal. It is expressed in Round because it is a count of rounds.
  final BigInt nextProtocolApprovals;

  /// NextProtocolVoteBefore specifies the last voting round for the next protocol proposal. If there is no voting for an upgrade taking place, this would be zero.
  final BigInt nextProtocolVoteBefore;

  /// NextProtocolSwitchOn specify the round number at which the next protocol would be adopted. If there is no upgrade taking place, nor a wait for the next protocol, this would be zero.
  final BigInt nextProtocolSwitchOn;

  /// UpgradePropose indicates a proposed upgrade
  final String upgradePropose;

  /// UpgradeDelay indicates the time between acceptance and execution
  final BigInt upgradeDelay;

  /// UpgradeApprove indicates a yes vote for the current proposal
  final bool upgradeApprove;

  /// TxnCounter is the number of the next transaction that will be committed after this block.  Genesis blocks can start at either 0 or 1000, depending on a consensus parameter (AppForbidLowResources).
  final BigInt txnCounter;

  /// StateProofTracking tracks the status of the state proofs, potentially for multiple types of ASPs (Algorand's State Proofs).
  final Map<AlgoTypesStateProofType, AlgoTypesStateProofTrackingData>
  stateProofTracking;

  /// ExpiredParticipationAccounts contains a list of online accounts that needs to be converted to offline since their participation key expired.
  final List<AlgoAddress> expiredParticipationAccounts;

  /// AbsentParticipationAccounts contains a list of online accounts that needs to be converted to offline since they are not proposing.
  final List<AlgoAddress> absentParticipationAccounts;

  /// Load is the degree to which a block is full. Currently, it is based on the number of bytes in the final block, compared to the maximum allowed. It is expressed as a fixed-point integer with 6 digits of precision.  So, 1,000,000 is a completely full block.
  final BigInt load;

  /// CongestionTax fee required, beyond the MinFee, for "normal" transactions in this block.
  final BigInt congestionTax;

  const AlgoTypesBlockHeader({
    required this.round,
    required this.branch,
    required this.branch512,
    required this.seed,
    required this.nativeSha512256Commitment,
    required this.sha256Commitment,
    required this.sha512Commitment,
    required this.timeStamp,
    required this.genesisID,
    required this.genesisHash,
    required this.proposer,
    required this.feesCollected,
    required this.bonus,
    required this.proposerPayout,
    required this.feeSink,
    required this.rewardsPool,
    required this.rewardsLevel,
    required this.rewardsRate,
    required this.rewardsResidue,
    required this.rewardsRecalculationRound,
    required this.currentProtocol,
    required this.nextProtocol,
    required this.nextProtocolApprovals,
    required this.nextProtocolVoteBefore,
    required this.nextProtocolSwitchOn,
    required this.upgradePropose,
    required this.upgradeDelay,
    required this.upgradeApprove,
    required this.txnCounter,
    required this.stateProofTracking,
    required this.expiredParticipationAccounts,
    required this.absentParticipationAccounts,
    required this.load,
    required this.congestionTax,
  });

  factory AlgoTypesBlockHeader.deserializeJson(Map<String, dynamic> json) {
    return AlgoTypesBlockHeader(
      round: json.valueAsBigInt("rnd", onMissing: () => BigInt.zero),
      branch: AlgoUtils.parseBlockHash(json.valueAs("prev")),

      branch512: json.valueAsBytes(
        "prev512",
        encoding: StringEncoding.base64,
        onMissing: () => List<int>.filled(QuickCrypto.sha512DigestLength, 0),
      ),
      seed: json.valueAsBytes(
        "seed",
        encoding: StringEncoding.base64,
        onMissing: () => List<int>.filled(QuickCrypto.sha256DigestSize, 0),
      ),
      nativeSha512256Commitment: json.valueAsBytes(
        "txn",
        encoding: StringEncoding.base64,
        onMissing: () => List<int>.filled(QuickCrypto.sha256DigestSize, 0),
      ),
      sha256Commitment: json.valueAsBytes(
        "txn256",
        encoding: StringEncoding.base64,
        onMissing: () => List<int>.filled(QuickCrypto.sha256DigestSize, 0),
      ),
      sha512Commitment: json.valueAsBytes(
        "txn512",
        encoding: StringEncoding.base64,
        onMissing: () => List<int>.filled(QuickCrypto.sha512DigestLength, 0),
      ),
      timeStamp: json.valueAsBigInt("ts", onMissing: () => BigInt.zero),
      genesisID: json.valueAsString(
        "gen",
        bytesEncoding: StringEncoding.utf8,
        onMissing: () => '',
      ),
      genesisHash: json.valueAsBytes(
        "gh",
        encoding: StringEncoding.base64,
        onMissing: () => List<int>.filled(QuickCrypto.sha256DigestSize, 0),
      ),
      proposer: AlgoUtils.parseAddressOrDefault(json.valueAs("prp")),

      feesCollected: json.valueAsBigInt("fc", onMissing: () => BigInt.zero),
      bonus: json.valueAsBigInt("bi", onMissing: () => BigInt.zero),
      proposerPayout: json.valueAsBigInt("pp", onMissing: () => BigInt.zero),
      feeSink: AlgoUtils.parseAddressOrDefault(json.valueAs("fees")),

      rewardsPool: AlgoUtils.parseAddressOrDefault(json.valueAs("rwd")),

      rewardsLevel: json.valueAsBigInt("earn", onMissing: () => BigInt.zero),
      rewardsRate: json.valueAsBigInt("rate", onMissing: () => BigInt.zero),
      rewardsResidue: json.valueAsBigInt("frac", onMissing: () => BigInt.zero),
      rewardsRecalculationRound: json.valueAsBigInt(
        "rwcalr",
        onMissing: () => BigInt.zero,
      ),
      currentProtocol: json.valueAsString(
        "proto",
        bytesEncoding: StringEncoding.utf8,
        onMissing: () => '',
      ),
      nextProtocol: json.valueAsString(
        "nextproto",
        bytesEncoding: StringEncoding.utf8,
        onMissing: () => '',
      ),
      nextProtocolApprovals: json.valueAsBigInt(
        "nextyes",
        onMissing: () => BigInt.zero,
      ),
      nextProtocolVoteBefore: json.valueAsBigInt(
        "nextbefore",
        onMissing: () => BigInt.zero,
      ),
      nextProtocolSwitchOn: json.valueAsBigInt(
        "nextswitch",
        onMissing: () => BigInt.zero,
      ),
      upgradePropose: json.valueAsString(
        "upgradeprop",
        bytesEncoding: StringEncoding.utf8,
        onMissing: () => '',
      ),
      upgradeDelay: json.valueAsBigInt(
        "upgradedelay",
        onMissing: () => BigInt.zero,
      ),
      upgradeApprove: json.valueAsBool("upgradeyes", onMissing: () => false),
      txnCounter: json.valueAsBigInt("tc", onMissing: () => BigInt.zero),
      stateProofTracking: json.valueTo<
        Map<AlgoTypesStateProofType, AlgoTypesStateProofTrackingData>,
        Map
      >(
        key: "spt",
        onMissing: () => {},
        parse:
            (e) => e.map(
              (k, v) => MapEntry(
                AlgoTypesStateProofType.fromValue(JsonParser.valueAsInt(k)),
                AlgoTypesStateProofTrackingData.deserializeJson(
                  JsonParser.valueEnsureAsMap(v),
                ),
              ),
            ),
      ),
      expiredParticipationAccounts: json.valueTo<List<AlgoAddress>, List>(
        key: "partupdrmv",
        onMissing: () => [],
        parse: (e) => e.map(AlgoUtils.parseAddressOrDefault).toList(),
      ),
      absentParticipationAccounts: json.valueTo<List<AlgoAddress>, List>(
        key: "partupdabs",
        onMissing: () => [],
        parse: (e) => e.map(AlgoUtils.parseAddressOrDefault).toList(),
      ),
      load: json.valueAsBigInt("ld", onMissing: () => BigInt.zero),
      congestionTax: json.valueAsBigInt("ct", onMissing: () => BigInt.zero),
    );
  }

  Map<String, dynamic> toMsgPack() {
    return {
      "rnd": round,
      "prev": branch,
      "prev512": branch512,
      "seed": seed,
      "txn": nativeSha512256Commitment,
      "txn256": sha256Commitment,
      "txn512": sha512Commitment,
      "ts": timeStamp,
      "gen": genesisID,
      "gh": genesisHash,
      "prp": proposer,
      "fc": feesCollected,
      "bi": bonus,
      "pp": proposerPayout,
      "fees": feeSink,
      "rwd": rewardsPool,
      "earn": rewardsLevel,
      "rate": rewardsRate,
      "frac": rewardsResidue,
      "rwcalr": rewardsRecalculationRound,
      "proto": currentProtocol,
      "nextproto": nextProtocol,
      "nextyes": nextProtocolApprovals,
      "nextbefore": nextProtocolVoteBefore,
      "nextswitch": nextProtocolSwitchOn,
      "upgradeprop": upgradePropose,
      "upgradedelay": upgradeDelay,
      "upgradeyes": upgradeApprove,
      "tc": txnCounter,
      "spt": stateProofTracking.map((k, e) => MapEntry(k.value, e.toMsgPack())),
      "partupdrmv": expiredParticipationAccounts,
      "partupdabs": absentParticipationAccounts,
      "ld": load,
      "ct": congestionTax,
    }.notNullValue;
  }
}

/// BoxReference names a box by the index in the foreign app array
class AlgoTypesBoxReference {
  /// The index of the app in the foreign app array.
  final BigInt foreignAppIdx;

  /// The name of the box unique to the app it belongs to
  final List<int> name;

  const AlgoTypesBoxReference({
    required this.foreignAppIdx,
    required this.name,
  });

  factory AlgoTypesBoxReference.deserializeJson(Map<String, dynamic> json) {
    return AlgoTypesBoxReference(
      foreignAppIdx: json.valueAsBigInt("i", onMissing: () => BigInt.zero),
      name: json.valueAsBytes(
        "n",
        encoding: StringEncoding.base64,
        onMissing: () => [],
      ),
    );
  }

  Map<String, dynamic> toMsgPack() {
    return {"i": foreignAppIdx, "n": name}.notNullValue;
  }
}

/// EvalDelta stores StateDeltas for an application's global key/value store, as well as StateDeltas for some number of accounts holding local state for that application
class AlgoTypesEvalDelta {
  final Map<String, AlgoTypesValueDelta> globalDelta;

  /// When decoding EvalDeltas, the integer key represents an offset into [txn.Sender, txn.Accounts[0], txn.Accounts[1], ..., SharedAccts[0], SharedAccts[1], ...]
  final Map<BigInt, Map<String, AlgoTypesValueDelta>> localDeltas;

  /// If a program modifies the local of an account that is not the Sender, or in txn.Accounts, it must be recorded here, so that the key in LocalDeltas can refer to it.
  final List<AlgoAddress> sharedAccts;

  /// The total allocbound calculation here accounts for the worse possible case of having bounds.MaxLogCalls individual log entries with the length of all of them summing up to bounds.MaxEvalDeltaTotalLogSize which is the limit for the sum of individual log lengths
  final List<String> logs;
  final List<AlgoTypesSignedTxnWithAD> innerTxns;

  const AlgoTypesEvalDelta({
    required this.globalDelta,
    required this.localDeltas,
    required this.sharedAccts,
    required this.logs,
    required this.innerTxns,
  });

  factory AlgoTypesEvalDelta.deserializeJson(Map<String, dynamic> json) {
    return AlgoTypesEvalDelta(
      globalDelta: json.valueTo<Map<String, AlgoTypesValueDelta>, Map>(
        key: "gd",
        onMissing: () => {},
        parse:
            (e) => e.map(
              (k, v) => MapEntry(
                k,
                AlgoTypesValueDelta.deserializeJson(
                  JsonParser.valueEnsureAsMap(v),
                ),
              ),
            ),
      ),
      localDeltas: json
          .valueTo<Map<BigInt, Map<String, AlgoTypesValueDelta>>, Map>(
            key: "ld",
            onMissing: () => {},
            parse:
                (e) => e.map(
                  (k, v) => MapEntry(
                    JsonParser.valueAsBigInt(k),
                    (v as Map).map(
                      (ik, iv) => MapEntry(
                        JsonParser.valueAsString(ik),
                        AlgoTypesValueDelta.deserializeJson(
                          JsonParser.valueEnsureAsMap(iv),
                        ),
                      ),
                    ),
                  ),
                ),
          ),
      sharedAccts: json.valueTo<List<AlgoAddress>, List>(
        key: "sa",
        onMissing: () => [],
        parse: (e) => e.map(AlgoUtils.parseAddressOrDefault).toList(),
      ),
      logs: json.valueEnsureAsList<String>("lg", onMissing: () => []),
      innerTxns: json.valueTo<List<AlgoTypesSignedTxnWithAD>, List>(
        key: "itx",
        onMissing: () => [],
        parse:
            (e) =>
                e
                    .map(
                      (x) => AlgoTypesSignedTxnWithAD.deserializeJson(
                        JsonParser.valueEnsureAsMap(x),
                      ),
                    )
                    .toList(),
      ),
    );
  }

  Map<String, dynamic> toMsgPack() {
    return {
      "gd": globalDelta.map((k, e) => MapEntry(k, e.toMsgPack())),
      "ld": localDeltas.map(
        (k, e) => MapEntry(k, e.map((ik, ie) => MapEntry(ik, ie.toMsgPack()))),
      ),
      "sa": sharedAccts,
      "lg": logs,
      "itx": innerTxns.map((e) => e.toMsgPack()).toList(),
    }.notNullValue;
  }
}

/// FalconSignatureStruct represents a signature in the merkle signature scheme using falcon signatures as an underlying crypto scheme. It consists of an ephemeral public key, a signature, a merkle verification path and an index. The merkle signature considered valid only if the Signature is verified under the ephemeral public key and the Merkle verification path verifies that the ephemeral public key is located at the given index of the tree (for the root given in the long-term public key). More details can be found on Algorand's spec
class AlgoTypesFalconSignatureStruct {
  final AlgoTypesMerkleSignature signature;
  final BigInt vectorCommitmentIndex;
  final AlgoTypesSingleLeafProof? proof;
  final AlgoTypesFalconVerifier? verifyingKey;

  const AlgoTypesFalconSignatureStruct({
    required this.signature,
    required this.vectorCommitmentIndex,
    this.proof,
    this.verifyingKey,
  });

  factory AlgoTypesFalconSignatureStruct.deserializeJson(
    Map<String, dynamic> json,
  ) {
    return AlgoTypesFalconSignatureStruct(
      signature: json.valueAsBytes(
        "sig",
        encoding: StringEncoding.base64,
        onMissing: () => [],
      ),
      vectorCommitmentIndex: json.valueAsBigInt(
        "idx",
        onMissing: () => BigInt.zero,
      ),
      proof: json.valueTo<AlgoTypesSingleLeafProof?, Map>(
        key: "prf",
        parse:
            (e) => AlgoTypesSingleLeafProof.deserializeJson(
              JsonParser.valueEnsureAsMap(e),
            ),
      ),
      verifyingKey: json.valueTo<AlgoTypesFalconVerifier?, Map>(
        key: "vkey",
        parse:
            (e) => AlgoTypesFalconVerifier.deserializeJson(
              JsonParser.valueEnsureAsMap(e),
            ),
      ),
    );
  }

  Map<String, dynamic> toMsgPack() {
    return {
      "sig": signature,
      "idx": vectorCommitmentIndex,
      "prf": proof?.toMsgPack(),
      "vkey": verifyingKey?.toMsgPack(),
    }.notNullValue;
  }
}

/// FalconVerifier implements the type Verifier interface for the falcon signature scheme.
class AlgoTypesFalconVerifier {
  final List<int>? publicKey;

  const AlgoTypesFalconVerifier({required this.publicKey});

  factory AlgoTypesFalconVerifier.deserializeJson(Map<String, dynamic> json) {
    return AlgoTypesFalconVerifier(
      publicKey: json.valueAsBytes("k", encoding: StringEncoding.base64),
    );
  }

  Map<String, dynamic> toMsgPack() {
    return {"k": publicKey}.notNullValue;
  }
}

/// AlgoTypesFields
class AlgoTypesFields {
  final List<AlgoTypesGenesisAllocation> allocation;
  final String feeSink;
  final String rewardsPool;

  const AlgoTypesFields({
    required this.allocation,
    required this.feeSink,
    required this.rewardsPool,
  });

  factory AlgoTypesFields.fromJson(Map<String, dynamic> json) {
    return AlgoTypesFields(
      allocation: json.valueTo<List<AlgoTypesGenesisAllocation>, List>(
        key: "Allocation",
        onMissing: () => [],
        parse:
            (e) =>
                e
                    .map(
                      (x) => AlgoTypesGenesisAllocation.deserializeJson(
                        JsonParser.valueEnsureAsMap(x),
                      ),
                    )
                    .toList(),
      ),
      feeSink: json.valueAsString(
        "FeeSink",
        bytesEncoding: StringEncoding.utf8,
        onMissing: () => '',
      ),
      rewardsPool: json.valueAsString(
        "RewardsPool",
        bytesEncoding: StringEncoding.utf8,
        onMissing: () => '',
      ),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "Allocation": allocation.map((e) => e.toMsgPack()).toList(),
      "FeeSink": feeSink,
      "RewardsPool": rewardsPool,
    }.notNullValue;
  }
}

/// A Genesis object defines an Algorand "universe"
class AlgoTypesGenesis {
  /// The SchemaID allows nodes to store data specific to a particular universe
  final String schemaID;

  /// Network identifies the unique algorand network for which the ledger is valid.
  final String network;

  /// Proto is the consensus protocol in use at the genesis block.
  final String proto;

  /// Allocation determines the initial accounts and their state.
  final List<AlgoTypesGenesisAllocation> allocation;

  /// RewardsPool is the address of the rewards pool.
  final String rewardsPool;

  /// FeeSink is the address of the fee sink.
  final String feeSink;

  /// Timestamp for the genesis block
  final BigInt timestamp;

  /// Arbitrary genesis comment string - will be excluded from file if empty
  final String comment;

  /// DevMode defines whether this network operates in a developer mode or not. Developer mode networks are a single node network, that operates without the agreement service being active. In liue of the agreement service, a new block is generated each time a node receives a transaction group. The default value for this field is "false", which makes this field empty from it's encoding, and therefore backward compatible.
  final bool devMode;

  const AlgoTypesGenesis({
    required this.schemaID,
    required this.network,
    required this.proto,
    required this.allocation,
    required this.rewardsPool,
    required this.feeSink,
    required this.timestamp,
    required this.comment,
    required this.devMode,
  });

  factory AlgoTypesGenesis.deserializeJson(Map<String, dynamic> json) {
    return AlgoTypesGenesis(
      schemaID: json.valueAsString(
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
      allocation: json.valueTo<List<AlgoTypesGenesisAllocation>, List>(
        key: "alloc",
        onMissing: () => [],
        parse:
            (e) =>
                e
                    .map(
                      (x) => AlgoTypesGenesisAllocation.deserializeJson(
                        JsonParser.valueEnsureAsMap(x),
                      ),
                    )
                    .toList(),
      ),
      rewardsPool: json.valueAsString(
        "rwd",
        bytesEncoding: StringEncoding.utf8,
        onMissing: () => '',
      ),
      feeSink: json.valueAsString(
        "fees",
        bytesEncoding: StringEncoding.utf8,
        onMissing: () => '',
      ),
      timestamp: json.valueAsBigInt("timestamp", onMissing: () => BigInt.zero),
      comment: json.valueAsString(
        "comment",
        bytesEncoding: StringEncoding.utf8,
        onMissing: () => '',
      ),
      devMode: json.valueAsBool("devmode", onMissing: () => false),
    );
  }

  Map<String, dynamic> toMsgPack() {
    return {
      "id": schemaID,
      "network": network,
      "proto": proto,
      "alloc": allocation.map((e) => e.toMsgPack()).toList(),
      "rwd": rewardsPool,
      "fees": feeSink,
      "timestamp": timestamp,
      "comment": comment,
      "devmode": devMode,
    }.notNullValue;
  }
}

/// GenesisAllocation object represents an allocation of algos to an address in the genesis block.  Address is the checksummed short address.  Comment is a note about what this address is representing, and is purely informational.  State is the initial account state.
class AlgoTypesGenesisAllocation {
  final String address;
  final String comment;
  final AlgoTypesAccount? state;

  const AlgoTypesGenesisAllocation({
    required this.address,
    required this.comment,
    this.state,
  });

  factory AlgoTypesGenesisAllocation.deserializeJson(
    Map<String, dynamic> json,
  ) {
    return AlgoTypesGenesisAllocation(
      address: json.valueAsString(
        "addr",
        bytesEncoding: StringEncoding.utf8,
        onMissing: () => '',
      ),
      comment: json.valueAsString(
        "comment",
        bytesEncoding: StringEncoding.utf8,
        onMissing: () => '',
      ),
      state: json.valueTo<AlgoTypesAccount?, Map>(
        key: "state",
        parse:
            (e) => AlgoTypesAccount.deserializeJson(
              JsonParser.valueEnsureAsMap(e),
            ),
      ),
    );
  }

  Map<String, dynamic> toMsgPack() {
    return {
      "addr": address,
      "comment": comment,
      "state": state?.toMsgPack(),
    }.notNullValue;
  }
}

/// GenesisBalances contains the information needed to generate a new ledger
class AlgoTypesGenesisBalances {
  final Map<AlgoAddress, AlgoTypesAccount> balances;
  final AlgoAddress feeSink;
  final AlgoAddress rewardsPool;
  final BigInt timestamp;

  const AlgoTypesGenesisBalances({
    required this.balances,
    required this.feeSink,
    required this.rewardsPool,
    required this.timestamp,
  });

  factory AlgoTypesGenesisBalances.fromJson(Map<String, dynamic> json) {
    return AlgoTypesGenesisBalances(
      balances: json.valueTo<Map<AlgoAddress, AlgoTypesAccount>, Map>(
        key: "Balances",
        onMissing: () => {},
        parse:
            (e) => e.map(
              (k, v) => MapEntry(
                AlgoUtils.parseAddressOrDefault(k),
                AlgoTypesAccount.deserializeJson(
                  JsonParser.valueEnsureAsMap(v),
                ),
              ),
            ),
      ),
      feeSink: AlgoUtils.parseAddressOrDefault(json.valueAs("FeeSink")),

      rewardsPool: AlgoUtils.parseAddressOrDefault(json.valueAs("RewardsPool")),

      timestamp: json.valueAsBigInt("Timestamp", onMissing: () => BigInt.zero),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "Balances": balances.map((k, e) => MapEntry(k, e.toMsgPack())),
      "FeeSink": feeSink,
      "RewardsPool": rewardsPool,
      "Timestamp": timestamp,
    }.notNullValue;
  }
}

/// HashFactory is responsible for generating new hashes accordingly to the type it stores.  msgp:postunmarshalcheck HashFactory Validate
class AlgoTypesHashFactory {
  final int hashType;

  const AlgoTypesHashFactory({required this.hashType});

  factory AlgoTypesHashFactory.deserializeJson(Map<String, dynamic> json) {
    return AlgoTypesHashFactory(
      hashType: json.valueAsInt("t", onMissing: () => 0),
    );
  }

  Map<String, dynamic> toMsgPack() {
    return {"t": hashType}.notNullValue;
  }
}

/// Header captures the fields common to every transaction type.
class AlgoTypesHeader {
  final AlgoAddress sender;
  final BigInt fee;
  final BigInt firstValid;
  final BigInt lastValid;
  final List<int> note;
  final String genesisID;
  final List<int> genesisHash;

  /// Group specifies that this transaction is part of a transaction group (and, if so, specifies the hash of a TxGroup).
  final List<int> group;

  /// Lease enforces mutual exclusion of transactions.  If this field is nonzero, then once the transaction is confirmed, it acquires the lease identified by the (Sender, Lease) pair of the transaction until the LastValid round passes.  While this transaction possesses the lease, no other transaction specifying this lease can be confirmed.
  final List<int> lease;

  /// RekeyTo, if nonzero, sets the sender's AuthAddr to the given address If the RekeyTo address is the sender's actual address, the AuthAddr is set to zero This allows "re-keying" a long-lived account -- rotating the signing key, changing membership of a multisig account, etc.
  final AlgoAddress rekeyTo;

  const AlgoTypesHeader({
    required this.sender,
    required this.fee,
    required this.firstValid,
    required this.lastValid,
    required this.note,
    required this.genesisID,
    required this.genesisHash,
    required this.group,
    required this.lease,
    required this.rekeyTo,
  });

  factory AlgoTypesHeader.deserializeJson(Map<String, dynamic> json) {
    return AlgoTypesHeader(
      sender: AlgoUtils.parseAddressOrDefault(json.valueAs("snd")),

      fee: json.valueAsBigInt("fee", onMissing: () => BigInt.zero),
      firstValid: json.valueAsBigInt("fv", onMissing: () => BigInt.zero),
      lastValid: json.valueAsBigInt("lv", onMissing: () => BigInt.zero),
      note: json.valueAsBytes(
        "note",
        encoding: StringEncoding.base64,
        onMissing: () => [],
      ),
      genesisID: json.valueAsString(
        "gen",
        bytesEncoding: StringEncoding.utf8,
        onMissing: () => '',
      ),
      genesisHash: json.valueAsBytes(
        "gh",
        encoding: StringEncoding.base64,
        onMissing: () => List<int>.filled(QuickCrypto.sha256DigestSize, 0),
      ),
      group: json.valueAsBytes(
        "grp",
        encoding: StringEncoding.base64,
        onMissing: () => List<int>.filled(QuickCrypto.sha256DigestSize, 0),
      ),
      lease: json.valueAsBytes(
        "lx",
        encoding: StringEncoding.base64,
        onMissing: () => [],
      ),
      rekeyTo: AlgoUtils.parseAddressOrDefault(json.valueAs("rekey")),
    );
  }

  Map<String, dynamic> toMsgPack() {
    return {
      "snd": sender,
      "fee": fee,
      "fv": firstValid,
      "lv": lastValid,
      "note": note,
      "gen": genesisID,
      "gh": genesisHash,
      "grp": group,
      "lx": lease,
      "rekey": rekeyTo,
    }.notNullValue;
  }
}

/// A HeartbeatProof is functionally equivalent to a OneTimeSignature (see below), but it has been cleaned up for use as a transaction field in heartbeat transactions.  A OneTimeSignature is a cryptographic signature that is produced a limited number of times and provides forward integrity.  Specifically, a OneTimeSignature is generated from an ephemeral secret. After some number of messages is signed under a given OneTimeSignatureIdentifier identifier, the corresponding secret is deleted. This prevents the secret-holder from signing a contradictory message in the future in the event of a secret-key compromise.
class AlgoTypesHeartbeatProof {
  /// Sig is a signature of msg under the key PK.
  final List<int> sig;
  final List<int> pK;

  /// PK2 is used to verify a two-level ephemeral signature.
  final List<int> pK2;

  /// PK1Sig is a signature of OneTimeSignatureSubkeyOffsetID(PK, Batch, Offset) under the key PK2.
  final List<int> pK1Sig;

  /// PK2Sig is a signature of OneTimeSignatureSubkeyBatchID(PK2, Batch) under the master key (OneTimeSignatureVerifier).
  final List<int> pK2Sig;

  const AlgoTypesHeartbeatProof({
    required this.sig,
    required this.pK,
    required this.pK2,
    required this.pK1Sig,
    required this.pK2Sig,
  });

  factory AlgoTypesHeartbeatProof.deserializeJson(Map<String, dynamic> json) {
    return AlgoTypesHeartbeatProof(
      sig: json.valueAsBytes(
        "s",
        encoding: StringEncoding.base64,
        onMissing:
            () => List<int>.filled(CryptoSignerConst.ed25519SignatureLength, 0),
      ),
      pK: json.valueAsBytes(
        "p",
        encoding: StringEncoding.base64,
        onMissing: () => List<int>.filled(Ed25519KeysConst.pubKeyByteLen, 0),
      ),
      pK2: json.valueAsBytes(
        "p2",
        encoding: StringEncoding.base64,
        onMissing: () => List<int>.filled(Ed25519KeysConst.pubKeyByteLen, 0),
      ),
      pK1Sig: json.valueAsBytes(
        "p1s",
        encoding: StringEncoding.base64,
        onMissing:
            () => List<int>.filled(CryptoSignerConst.ed25519SignatureLength, 0),
      ),
      pK2Sig: json.valueAsBytes(
        "p2s",
        encoding: StringEncoding.base64,
        onMissing:
            () => List<int>.filled(CryptoSignerConst.ed25519SignatureLength, 0),
      ),
    );
  }

  Map<String, dynamic> toMsgPack() {
    return {
      "s": sig,
      "p": pK,
      "p2": pK2,
      "p1s": pK1Sig,
      "p2s": pK2Sig,
    }.notNullValue;
  }
}

/// HeartbeatTxnFields captures the fields used for an account to prove it is online (really, it proves that an entity with the account's part keys is able to submit transactions, so it should be able to propose/vote.)
class AlgoTypesHeartbeatTxnFields {
  /// HbAddress is the account this txn is proving onlineness for.
  final AlgoAddress hbAddress;

  /// HbProof is a signature using HeartbeatAddress's partkey, thereby showing it is online.
  final AlgoTypesHeartbeatProof? hbProof;

  /// The final three fields are included to allow early, concurrent check of the HbProof. HbSeed must be the block seed for this transaction's firstValid block. It is the message that must be signed with HbAddress's part key.
  final AlgoTypesSeed hbSeed;

  /// HbVoteID must match the HbAddress account's current VoteID.
  final AlgoTypesVotePK hbVoteID;

  /// HbKeyDilution must match HbAddress account's current KeyDilution.
  final BigInt hbKeyDilution;

  /// HbChallengeDiscount requests the challenge fee discount: when set, the required fee is reduced by one min fee. It is optional even for a challenged account (an account willing to pay the normal fee can leave it off), so it is a request, not an assertion. apply verifies HbAddress is actually under challenge before granting it. The flag is only allowed once transaction size pricing is enabled (proto.TxnSizePricingEnabled()); it makes sense to think in terms of transaction fields changing fees now, so it needs no separate consensus flag. Before then, the discount was inferred from an underpaid singleton heartbeat instead (see wellFormed and apply).
  final bool hbChallengeDiscount;

  const AlgoTypesHeartbeatTxnFields({
    required this.hbAddress,
    this.hbProof,
    required this.hbSeed,
    required this.hbVoteID,
    required this.hbKeyDilution,
    required this.hbChallengeDiscount,
  });

  factory AlgoTypesHeartbeatTxnFields.deserializeJson(
    Map<String, dynamic> json,
  ) {
    return AlgoTypesHeartbeatTxnFields(
      hbAddress: AlgoUtils.parseAddressOrDefault(json.valueAs("a")),

      hbProof: json.valueTo<AlgoTypesHeartbeatProof?, Map>(
        key: "prf",
        parse:
            (e) => AlgoTypesHeartbeatProof.deserializeJson(
              JsonParser.valueEnsureAsMap(e),
            ),
      ),
      hbSeed: json.valueAsBytes(
        "sd",
        encoding: StringEncoding.base64,
        onMissing: () => [],
      ),
      hbVoteID: json.valueAsBytes(
        "vid",
        encoding: StringEncoding.base64,
        onMissing: () => List<int>.filled(Ed25519KeysConst.pubKeyByteLen, 0),
      ),
      hbKeyDilution: json.valueAsBigInt("kd", onMissing: () => BigInt.zero),
      hbChallengeDiscount: json.valueAsBool("c", onMissing: () => false),
    );
  }

  Map<String, dynamic> toMsgPack() {
    return {
      "a": hbAddress,
      "prf": hbProof?.toMsgPack(),
      "sd": hbSeed,
      "vid": hbVoteID,
      "kd": hbKeyDilution,
      "c": hbChallengeDiscount,
    }.notNullValue;
  }
}

/// HoldingRef names a holding by referring to an Address and Asset that appear earlier in the Access list (0 is special cased)
class AlgoTypesHoldingRef {
  final BigInt address;
  final BigInt asset;

  const AlgoTypesHoldingRef({required this.address, required this.asset});

  factory AlgoTypesHoldingRef.deserializeJson(Map<String, dynamic> json) {
    return AlgoTypesHoldingRef(
      address: json.valueAsBigInt("d", onMissing: () => BigInt.zero),
      asset: json.valueAsBigInt("s", onMissing: () => BigInt.zero),
    );
  }

  Map<String, dynamic> toMsgPack() {
    return {"d": address, "s": asset}.notNullValue;
  }
}

/// IncludedTransactions defines the transactions included in a block, their index and last valid round.
class AlgoTypesIncludedTransactions {
  final BigInt lastValid;
  final BigInt intra;

  const AlgoTypesIncludedTransactions({
    required this.lastValid,
    required this.intra,
  });

  factory AlgoTypesIncludedTransactions.fromJson(Map<String, dynamic> json) {
    return AlgoTypesIncludedTransactions(
      lastValid: json.valueAsBigInt("LastValid", onMissing: () => BigInt.zero),
      intra: json.valueAsBigInt("Intra", onMissing: () => BigInt.zero),
    );
  }

  Map<String, dynamic> toJson() {
    return {"LastValid": lastValid, "Intra": intra}.notNullValue;
  }
}

/// KeyregTxnFields captures the fields used for key registration transactions.
class AlgoTypesKeyregTxnFields {
  final AlgoTypesVotePK votePK;
  final AlgoTypesVRFPK selectionPK;
  final List<int>? stateProofPK;
  final BigInt voteFirst;
  final BigInt voteLast;
  final BigInt voteKeyDilution;
  final bool nonparticipation;

  const AlgoTypesKeyregTxnFields({
    required this.votePK,
    required this.selectionPK,
    required this.stateProofPK,
    required this.voteFirst,
    required this.voteLast,
    required this.voteKeyDilution,
    required this.nonparticipation,
  });

  factory AlgoTypesKeyregTxnFields.deserializeJson(Map<String, dynamic> json) {
    return AlgoTypesKeyregTxnFields(
      votePK: json.valueAsBytes(
        "votekey",
        encoding: StringEncoding.base64,
        onMissing: () => List<int>.filled(Ed25519KeysConst.pubKeyByteLen, 0),
      ),
      selectionPK: json.valueAsBytes(
        "selkey",
        encoding: StringEncoding.base64,
        onMissing: () => [],
      ),
      stateProofPK: json.valueAsBytes(
        "sprfkey",
        encoding: StringEncoding.base64,
      ),
      voteFirst: json.valueAsBigInt("votefst", onMissing: () => BigInt.zero),
      voteLast: json.valueAsBigInt("votelst", onMissing: () => BigInt.zero),
      voteKeyDilution: json.valueAsBigInt(
        "votekd",
        onMissing: () => BigInt.zero,
      ),
      nonparticipation: json.valueAsBool("nonpart", onMissing: () => false),
    );
  }

  Map<String, dynamic> toMsgPack() {
    return {
      "votekey": votePK,
      "selkey": selectionPK,
      "sprfkey": stateProofPK,
      "votefst": voteFirst,
      "votelst": voteLast,
      "votekd": voteKeyDilution,
      "nonpart": nonparticipation,
    }.notNullValue;
  }
}

/// A KvValueDelta shows how the Data associated with a key in the kvstore has changed.  However, OldData is elided during evaluation, and only filled in at the conclusion of a block during the called to roundCowState.deltas()
class AlgoTypesKvValueDelta {
  /// Data stores the most recent value (nil == deleted)
  final List<int> data;

  /// OldData stores the previous value (nil == didn't exist)
  final List<int> oldData;

  const AlgoTypesKvValueDelta({required this.data, required this.oldData});

  factory AlgoTypesKvValueDelta.fromJson(Map<String, dynamic> json) {
    return AlgoTypesKvValueDelta(
      data: json.valueAsBytes(
        "Data",
        encoding: StringEncoding.base64,
        onMissing: () => [],
      ),
      oldData: json.valueAsBytes(
        "OldData",
        encoding: StringEncoding.base64,
        onMissing: () => [],
      ),
    );
  }

  Map<String, dynamic> toJson() {
    return {"Data": data, "OldData": oldData}.notNullValue;
  }
}

/// LedgerStateDelta describes the delta between a given round to the previous round If adding a new field not explicitly allocated by PopulateStateDelta, make sure to reset it in .ReuseStateDelta to avoid dirty memory errors. If adding fields make sure to add them to the .Reset() method to avoid dirty state
class AlgoTypesLedgerStateDelta {
  /// modified new accounts
  final AlgoTypesAccountDeltas accts;

  /// modified kv pairs (nil == delete) not preallocated use .AddKvMod to insert instead of direct assignment
  final Map<String, AlgoTypesKvValueDelta> kvMods;

  /// new Txids for the txtail and TxnCounter, mapped to txn.LastValid
  final Map<AlgoTypesTxid, AlgoTypesIncludedTransactions> txids;

  /// new txleases for the txtail mapped to expiration not pre-allocated so use .AddTxLease to insert instead of direct assignment
  final Map<AlgoTypesTxlease, BigInt> txleases;

  /// new creatables creator lookup table not pre-allocated so use .AddCreatable to insert instead of direct assignment
  final Map<BigInt, AlgoTypesModifiedCreatable> creatables;

  /// new block header; read-only
  final AlgoTypesBlockHeader? hdr;

  /// StateProofNext represents modification on StateProofNextRound field in the block header. If the block contains a valid state proof transaction, this field will contain the next round for state proof. otherwise it will be set to 0.
  final BigInt stateProofNext;

  /// previous block timestamp
  final BigInt prevTimestamp;

  /// initial hint for allocating data structures for StateDelta
  final int initialHint;

  /// The account totals reflecting the changes in this StateDelta object.
  final AlgoTypesAccountTotals? totals;

  const AlgoTypesLedgerStateDelta({
    required this.accts,
    required this.kvMods,
    required this.txids,
    required this.txleases,
    required this.creatables,
    this.hdr,
    required this.stateProofNext,
    required this.prevTimestamp,
    required this.initialHint,
    this.totals,
  });

  factory AlgoTypesLedgerStateDelta.fromJson(Map<String, dynamic> json) {
    return AlgoTypesLedgerStateDelta(
      accts: json.valueTo<AlgoTypesAccountDeltas, Map>(
        key: "Accts",
        parse:
            (e) =>
                AlgoTypesAccountDeltas.fromJson(JsonParser.valueEnsureAsMap(e)),
      ),
      kvMods: json.valueTo<Map<String, AlgoTypesKvValueDelta>, Map>(
        key: "KvMods",
        onMissing: () => {},
        parse:
            (e) => e.map(
              (k, v) => MapEntry(
                JsonParser.valueAsString(k),
                AlgoTypesKvValueDelta.fromJson(JsonParser.valueEnsureAsMap(v)),
              ),
            ),
      ),
      txids: json
          .valueTo<Map<AlgoTypesTxid, AlgoTypesIncludedTransactions>, Map>(
            key: "Txids",
            onMissing: () => {},
            parse:
                (e) => e.map(
                  (k, v) => MapEntry(
                    JsonParser.valueAsBytes<List<int>>(
                      k,
                      encoding: StringEncoding.base64,
                    ),
                    AlgoTypesIncludedTransactions.fromJson(
                      JsonParser.valueEnsureAsMap(v),
                    ),
                  ),
                ),
          ),
      txleases: json.valueTo<Map<AlgoTypesTxlease, BigInt>, Map>(
        key: "Txleases",
        onMissing: () => {},
        parse:
            (e) => e.map(
              (k, v) => MapEntry(
                AlgoTypesTxlease.fromJson(JsonParser.valueEnsureAsMap(k)),
                JsonParser.valueAsBigInt(k),
              ),
            ),
      ),
      creatables: json.valueTo<Map<BigInt, AlgoTypesModifiedCreatable>, Map>(
        key: "Creatables",
        onMissing: () => {},
        parse:
            (e) => e.map(
              (k, v) => MapEntry(
                JsonParser.valueAsBigInt(k),
                AlgoTypesModifiedCreatable.fromJson(
                  JsonParser.valueEnsureAsMap(v),
                ),
              ),
            ),
      ),
      hdr: json.valueTo<AlgoTypesBlockHeader?, Map>(
        key: "Hdr",
        parse:
            (e) => AlgoTypesBlockHeader.deserializeJson(
              JsonParser.valueEnsureAsMap(e),
            ),
      ),
      stateProofNext: json.valueAsBigInt(
        "StateProofNext",
        onMissing: () => BigInt.zero,
      ),
      prevTimestamp: json.valueAsBigInt(
        "PrevTimestamp",
        onMissing: () => BigInt.zero,
      ),
      initialHint: json.valueAsInt("initialHint", onMissing: () => 0),
      totals: json.valueTo<AlgoTypesAccountTotals?, Map>(
        key: "Totals",
        parse:
            (e) => AlgoTypesAccountTotals.deserializeJson(
              JsonParser.valueEnsureAsMap(e),
            ),
      ),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "Accts": accts.toJson(),
      "KvMods": kvMods.map((k, e) => MapEntry(k, e.toJson())),
      "Txids": txids.map((k, e) => MapEntry(k, e.toJson())),
      "Txleases": txleases.map((k, e) => MapEntry(k.toJson(), e)),
      "Creatables": creatables.map((k, e) => MapEntry(k, e.toJson())),
      "Hdr": hdr?.toMsgPack(),
      "StateProofNext": stateProofNext,
      "PrevTimestamp": prevTimestamp,
      "initialHint": initialHint,
      "Totals": totals?.toMsgPack(),
    }.notNullValue;
  }
}

/// LightBlockHeader represents a minimal block header. It contains all the necessary fields for verifying proofs on transactions. In addition, this struct is designed to be used on environments where only SHA256 function exists
class AlgoTypesLightBlockHeader with LayoutSerializable {
  final AlgoTypesSeed seed;
  final List<int> blockHash;
  final BigInt roundNumber;
  final List<int> genesisHash;
  final List<int> sha256TxnCommitment;

  const AlgoTypesLightBlockHeader({
    required this.seed,
    required this.blockHash,
    required this.roundNumber,
    required this.genesisHash,
    required this.sha256TxnCommitment,
  });
  static MsgPackFixedKeyDynamicLazyValueMapLayout<
    String,
    dynamic,
    LayoutRepository
  >
  layout({String? property}) {
    return MsgPackFixedKeyDynamicLazyValueMapLayout<
      String,
      dynamic,
      LayoutRepository
    >(
      keyLayout: MsgPackStringLayout(),
      sortKeys: true,
      valueLayouts: [
        MapEntry(
          "0",
          LazyMsgPackMapLayoutBuilder(
            layout: AlgoBinaryLayout.defaultBinary32Layout,
          ),
        ),
        MapEntry(
          "1",
          LazyMsgPackMapLayoutBuilder(
            layout: AlgoBinaryLayout.defaultBinary32Layout,
          ),
        ),
        MapEntry(
          "r",
          LazyMsgPackMapLayoutBuilder(
            layout: AlgoBigIntLayout.defaultU64Layout,
          ),
        ),
        MapEntry(
          "gh",
          LazyMsgPackMapLayoutBuilder(
            layout: AlgoBinaryLayout.defaultBinary32Layout,
          ),
        ),
        MapEntry(
          "tc",
          LazyMsgPackMapLayoutBuilder(
            layout: AlgoBinaryLayout.defaultBinary32Layout,
          ),
        ),
      ],
      property: property,
    );
  }

  @override
  Layout<Map<String, dynamic>> toLayout({String? property}) {
    return layout(property: property);
  }

  factory AlgoTypesLightBlockHeader.deserializeJson(Map<String, dynamic> json) {
    return AlgoTypesLightBlockHeader(
      seed: json.valueAsBytes(
        "0",
        encoding: StringEncoding.base64,
        onMissing: () => List<int>.filled(QuickCrypto.sha256DigestSize, 0),
      ),
      blockHash: json.valueAsBytes(
        "1",
        encoding: StringEncoding.base64,
        onMissing: () => List<int>.filled(QuickCrypto.sha256DigestSize, 0),
      ),
      roundNumber: json.valueAsBigInt("r", onMissing: () => BigInt.zero),
      genesisHash: json.valueAsBytes(
        "gh",
        encoding: StringEncoding.base64,
        onMissing: () => List<int>.filled(QuickCrypto.sha256DigestSize, 0),
      ),
      sha256TxnCommitment: json.valueAsBytes(
        "tc",
        encoding: StringEncoding.base64,
        onMissing: () => List<int>.filled(QuickCrypto.sha256DigestSize, 0),
      ),
    );
  }

  @override
  Map<String, dynamic> toSerializeJson() {
    return {
      "0": seed,
      "1": blockHash,
      "r": roundNumber,
      "gh": genesisHash,
      "tc": sha256TxnCommitment,
    };
  }
}

/// LocalsRef names a local state by referring to an Address and App that appear earlier in the Access list (0 is special cased)
class AlgoTypesLocalsRef {
  final BigInt address;
  final BigInt app;

  const AlgoTypesLocalsRef({required this.address, required this.app});

  factory AlgoTypesLocalsRef.deserializeJson(Map<String, dynamic> json) {
    return AlgoTypesLocalsRef(
      address: json.valueAsBigInt("d", onMissing: () => BigInt.zero),
      app: json.valueAsBigInt("p", onMissing: () => BigInt.zero),
    );
  }

  Map<String, dynamic> toMsgPack() {
    return {"d": address, "p": app}.notNullValue;
  }
}

/// LogicSig contains logic for validating a transaction. LogicSig is signed by an account, allowing delegation of operations. OR LogicSig defines a contract account.  LogicSig cannot sign transactions in all cases.  Instead, use LogicSigAccount as a safe, general purpose signing mechanism.  Since LogicSig does not track the provided signature's public key, LogicSig cannot sign transactions when delegated to a non-multisig account _and_ the sender is not the delegating account.
class AlgoTypesLogicSig {
  /// Logic signed by Sig or Msig OR hashed to be the Address of an account.
  final List<int> logic;

  /// The signature of the account that has delegated to this LogicSig, if any
  final AlgoTypesSignature sig;

  /// The signature of the multisig account that has delegated to this LogicSig, if any Accepted on transactions if consensus param LogicSigMsig=true
  final AlgoTypesMultisigSig? msig;

  /// The signature of the multisig account that has delegated to this LogicSig, if any Accepted on transactions if consensus param LogicSigLMsig=true
  final AlgoTypesMultisigSig? lMsig;

  /// The signature of the post-quantum account that has delegated to this LogicSig, if any
  final AlgoTypesPQSig? pQsig;

  /// Args are not signed, but checked by Logic
  final List<List<int>> args;

  const AlgoTypesLogicSig({
    required this.logic,
    required this.sig,
    this.msig,
    this.lMsig,
    this.pQsig,
    required this.args,
  });

  factory AlgoTypesLogicSig.deserializeJson(Map<String, dynamic> json) {
    return AlgoTypesLogicSig(
      logic: json.valueAsBytes(
        "l",
        encoding: StringEncoding.base64,
        onMissing: () => [],
      ),
      sig: json.valueAsBytes(
        "sig",
        encoding: StringEncoding.base64,
        onMissing:
            () => List<int>.filled(CryptoSignerConst.ed25519SignatureLength, 0),
      ),
      msig: json.valueTo<AlgoTypesMultisigSig?, Map>(
        key: "msig",
        parse:
            (e) => AlgoTypesMultisigSig.deserializeJson(
              JsonParser.valueEnsureAsMap(e),
            ),
      ),
      lMsig: json.valueTo<AlgoTypesMultisigSig?, Map>(
        key: "lmsig",
        parse:
            (e) => AlgoTypesMultisigSig.deserializeJson(
              JsonParser.valueEnsureAsMap(e),
            ),
      ),
      pQsig: json.valueTo<AlgoTypesPQSig?, Map>(
        key: "pqsig",
        parse:
            (e) =>
                AlgoTypesPQSig.deserializeJson(JsonParser.valueEnsureAsMap(e)),
      ),
      args: json.valueTo<List<List<int>>, List>(
        key: "arg",
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
    );
  }

  Map<String, dynamic> toMsgPack() {
    return {
      "l": logic,
      "sig": sig,
      "msig": msig?.toMsgPack(),
      "lmsig": lMsig?.toMsgPack(),
      "pqsig": pQsig?.toMsgPack(),
      "arg": args,
    }.notNullValue;
  }
}

/// Message represents the message that the state proofs are attesting to. This message can be used by lightweight client and gives it the ability to verify proofs on the Algorand's state. In addition to that proof, this message also contains fields that are needed in order to verify the next state proofs (VotersCommitment and LnProvenWeight).
class AlgoTypesMessage with LayoutSerializable {
  /// BlockHeadersCommitment contains a commitment on all light block headers within a state proof interval.
  final List<int> blockHeadersCommitment;
  final List<int> votersCommitment;
  final BigInt lnProvenWeight;
  final BigInt firstAttestedRound;
  final BigInt lastAttestedRound;

  const AlgoTypesMessage({
    required this.blockHeadersCommitment,
    required this.votersCommitment,
    required this.lnProvenWeight,
    required this.firstAttestedRound,
    required this.lastAttestedRound,
  });

  factory AlgoTypesMessage.deserializeJson(Map<String, dynamic> json) {
    return AlgoTypesMessage(
      blockHeadersCommitment: json.valueAsBytes(
        "b",
        encoding: StringEncoding.base64,
        onMissing: () => [],
      ),
      votersCommitment: json.valueAsBytes(
        "v",
        encoding: StringEncoding.base64,
        onMissing: () => [],
      ),
      lnProvenWeight: json.valueAsBigInt("P", onMissing: () => BigInt.zero),
      firstAttestedRound: json.valueAsBigInt("f", onMissing: () => BigInt.zero),
      lastAttestedRound: json.valueAsBigInt("l", onMissing: () => BigInt.zero),
    );
  }

  static MsgPackFixedKeyDynamicLazyValueMapLayout<
    String,
    dynamic,
    LayoutRepository
  >
  layout({String? property}) {
    return MsgPackFixedKeyDynamicLazyValueMapLayout<
      String,
      dynamic,
      LayoutRepository
    >(
      keyLayout: MsgPackStringLayout(),
      sortKeys: true,
      valueLayouts: [
        MapEntry(
          "b",
          LazyMsgPackMapLayoutBuilder(
            layout: AlgoBinaryLayout.defaultBinary32Layout,
          ),
        ),
        MapEntry(
          "v",
          LazyMsgPackMapLayoutBuilder(
            layout: AlgoBinaryLayout.defaultBinary64Layout,
          ),
        ),
        MapEntry(
          "P",
          LazyMsgPackMapLayoutBuilder(
            layout: AlgoBigIntLayout.defaultU64Layout,
          ),
        ),
        MapEntry(
          "f",
          LazyMsgPackMapLayoutBuilder(
            layout: AlgoBigIntLayout.defaultU64Layout,
          ),
        ),
        MapEntry(
          "l",
          LazyMsgPackMapLayoutBuilder(
            layout: AlgoBigIntLayout.defaultU64Layout,
          ),
        ),
      ],
      property: property,
    );
  }

  @override
  Layout<Map<String, dynamic>> toLayout({String? property}) {
    return layout(property: property);
  }

  @override
  Map<String, dynamic> toSerializeJson() {
    return {
      "b": blockHeadersCommitment,
      "v": votersCommitment,
      "P": lnProvenWeight,
      "f": firstAttestedRound,
      "l": lastAttestedRound,
    };
  }
}

/// ModifiedCreatable defines the changes to a single single creatable state
class AlgoTypesModifiedCreatable {
  /// Type of the creatable: app or asset
  final BigInt ctype;

  /// Created if true, deleted if false
  final bool created;

  /// creator of the app/asset
  final AlgoAddress creator;

  /// Keeps track of how many times this app/asset appears in accountUpdates.creatableDeltas
  final int ndeltas;

  const AlgoTypesModifiedCreatable({
    required this.ctype,
    required this.created,
    required this.creator,
    required this.ndeltas,
  });

  factory AlgoTypesModifiedCreatable.fromJson(Map<String, dynamic> json) {
    return AlgoTypesModifiedCreatable(
      ctype: json.valueAsBigInt("Ctype", onMissing: () => BigInt.zero),
      created: json.valueAsBool("Created", onMissing: () => false),
      creator: AlgoUtils.parseAddressOrDefault(json.valueAs("Creator")),

      ndeltas: json.valueAsInt("Ndeltas", onMissing: () => 0),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "Ctype": ctype,
      "Created": created,
      "Creator": creator,
      "Ndeltas": ndeltas,
    }.notNullValue;
  }
}

/// MultisigSig holds multiple Subsigs, as well as threshold and version info
class AlgoTypesMultisigSig {
  final int version;
  final int threshold;
  final List<AlgoTypesMultisigSubsig> subsigs;

  const AlgoTypesMultisigSig({
    required this.version,
    required this.threshold,
    required this.subsigs,
  });

  factory AlgoTypesMultisigSig.deserializeJson(Map<String, dynamic> json) {
    return AlgoTypesMultisigSig(
      version: json.valueAsInt("v", onMissing: () => 0),
      threshold: json.valueAsInt("thr", onMissing: () => 0),
      subsigs: json.valueTo<List<AlgoTypesMultisigSubsig>, List>(
        key: "subsig",
        onMissing: () => [],
        parse:
            (e) =>
                e
                    .map(
                      (x) => AlgoTypesMultisigSubsig.deserializeJson(
                        JsonParser.valueEnsureAsMap(x),
                      ),
                    )
                    .toList(),
      ),
    );
  }

  Map<String, dynamic> toMsgPack() {
    return {
      "v": version,
      "thr": threshold,
      "subsig": subsigs.map((e) => e.toMsgPack()).toList(),
    }.notNullValue;
  }
}

/// MultisigSubsig contains a single public key and, optionally, a signature
class AlgoTypesMultisigSubsig {
  final dynamic key;
  final AlgoTypesSignature sig;

  const AlgoTypesMultisigSubsig({required this.key, required this.sig});

  factory AlgoTypesMultisigSubsig.deserializeJson(Map<String, dynamic> json) {
    return AlgoTypesMultisigSubsig(
      key: json["pk"],
      sig: json.valueAsBytes(
        "s",
        encoding: StringEncoding.base64,
        onMissing:
            () => List<int>.filled(CryptoSignerConst.ed25519SignatureLength, 0),
      ),
    );
  }

  Map<String, dynamic> toMsgPack() {
    return {"pk": key, "s": sig}.notNullValue;
  }
}

enum NoteFieldType {
  deposit('d'),
  bid('b'),
  settlement('s'),
  params('p');

  final String value;
  const NoteFieldType(this.value);

  @override
  String toString() => value;
  static NoteFieldType fromValue(String? v) {
    return values.firstWhere(
      (e) => e.value == v,
      orElse:
          () =>
              throw BuError(
                DefaultErrorType.invalidArgument,
                'Invalid NoteFieldType value.',
                details: {'value': v},
              ),
    );
  }
}

/// NoteField is the struct that represents an auction message.
class AlgoTypesNoteField with LayoutSerializable {
  /// Type indicates which type of a message this is
  final NoteFieldType type;

  /// SignedBid, for NoteBid type
  final AlgoTypesSignedBid signedBid;

  const AlgoTypesNoteField({required this.type, required this.signedBid});

  factory AlgoTypesNoteField.deserializeJson(Map<String, dynamic> json) {
    return AlgoTypesNoteField(
      type: NoteFieldType.fromValue(json.valueAsString("t")),
      signedBid: json.valueTo<AlgoTypesSignedBid, Map>(
        key: "b",
        parse:
            (e) => AlgoTypesSignedBid.deserializeJson(
              JsonParser.valueEnsureAsMap(e),
            ),
      ),
    );
  }
  static MsgPackFixedKeyDynamicLazyValueMapLayout<
    String,
    dynamic,
    LayoutRepository
  >
  layout({String? property}) {
    return MsgPackFixedKeyDynamicLazyValueMapLayout<
      String,
      dynamic,
      LayoutRepository
    >(
      keyLayout: MsgPackStringLayout(),
      sortKeys: true,
      valueLayouts: [
        MapEntry(
          "t",
          LazyMsgPackMapLayoutBuilder(
            layout: AlgoStringLayout.defaultStringLayout,
          ),
        ),
        MapEntry(
          "b",
          LazyMsgPackMapLayoutBuilder(
            layout: (property, params) => AlgoTypesSignedBid.layout(),
          ),
        ),
      ],
      property: property,
    );
  }

  @override
  Layout<Map<String, dynamic>> toLayout({String? property}) {
    return layout(property: property);
  }

  @override
  Map<String, dynamic> toSerializeJson() {
    return {"t": type.value, "b": signedBid.toSerializeJson()};
  }
}

/// PQSig is a post-quantum transaction authorization proof. Its public key and signature are wire/decode-bounded by crypto.MaxPQPublicKeySize and crypto.MaxPQSignatureSize (the largest sizes over all supported PQ schemes), which feed msgp allocation bounds and therefore PQSigMaxSize, SignedTxnMaxSize, and the SignedTxn wire bound.
class AlgoTypesPQSig {
  final AlgoTypesPQScheme scheme;
  final int salt;
  final List<int> publicKey;
  final List<int> signature;

  const AlgoTypesPQSig({
    required this.scheme,
    required this.salt,
    required this.publicKey,
    required this.signature,
  });

  factory AlgoTypesPQSig.deserializeJson(Map<String, dynamic> json) {
    return AlgoTypesPQSig(
      scheme: json.valueAsBytes(
        "sch",
        encoding: StringEncoding.base64,
        onMissing: () => [],
      ),
      salt: json.valueAsInt("slt", onMissing: () => 0),
      publicKey: json.valueAsBytes(
        "pk",
        encoding: StringEncoding.base64,
        onMissing: () => [],
      ),
      signature: json.valueAsBytes(
        "sig",
        encoding: StringEncoding.base64,
        onMissing: () => [],
      ),
    );
  }

  Map<String, dynamic> toMsgPack() {
    return {
      "sch": scheme,
      "slt": salt,
      "pk": publicKey,
      "sig": signature,
    }.notNullValue;
  }
}

/// A Participant corresponds to an account whose AccountData.Status is Online, and for which the expected sigRound satisfies AccountData.VoteFirstValid <= sigRound <= AccountData.VoteLastValid.  In the Algorand ledger, it is possible for multiple accounts to have the same PK.  Thus, the PK is not necessarily unique among Participants. However, each account will produce a unique Participant struct, to avoid potential DoS attacks where one account claims to have the same VoteID PK as another account.
class AlgoTypesParticipant {
  /// PK is the identifier used to verify the signature for a specific participant
  final AlgoTypesVerifier? pK;

  /// Weight is AccountData.MicroAlgos.
  final BigInt weight;

  const AlgoTypesParticipant({this.pK, required this.weight});

  factory AlgoTypesParticipant.deserializeJson(Map<String, dynamic> json) {
    return AlgoTypesParticipant(
      pK: json.valueTo<AlgoTypesVerifier?, Map>(
        key: "p",
        parse:
            (e) => AlgoTypesVerifier.deserializeJson(
              JsonParser.valueEnsureAsMap(e),
            ),
      ),
      weight: json.valueAsBigInt("w", onMissing: () => BigInt.zero),
    );
  }

  Map<String, dynamic> toMsgPack() {
    return {"p": pK?.toMsgPack(), "w": weight}.notNullValue;
  }
}

/// ParticipationUpdates represents participation account data that needs to be checked/acted on by the network
class AlgoTypesParticipationUpdates {
  /// ExpiredParticipationAccounts contains a list of online accounts that needs to be converted to offline since their participation key expired.
  final List<AlgoAddress> expiredParticipationAccounts;

  /// AbsentParticipationAccounts contains a list of online accounts that needs to be converted to offline since they are not proposing.
  final List<AlgoAddress> absentParticipationAccounts;

  const AlgoTypesParticipationUpdates({
    required this.expiredParticipationAccounts,
    required this.absentParticipationAccounts,
  });

  factory AlgoTypesParticipationUpdates.deserializeJson(
    Map<String, dynamic> json,
  ) {
    return AlgoTypesParticipationUpdates(
      expiredParticipationAccounts: json.valueTo<List<AlgoAddress>, List>(
        key: "partupdrmv",
        onMissing: () => [],
        parse: (e) => e.map(AlgoUtils.parseAddressOrDefault).toList(),
      ),
      absentParticipationAccounts: json.valueTo<List<AlgoAddress>, List>(
        key: "partupdabs",
        onMissing: () => [],
        parse: (e) => e.map(AlgoUtils.parseAddressOrDefault).toList(),
      ),
    );
  }

  Map<String, dynamic> toMsgPack() {
    return {
      "partupdrmv": expiredParticipationAccounts,
      "partupdabs": absentParticipationAccounts,
    }.notNullValue;
  }
}

/// PaymentTxnFields captures the fields used by payment transactions.
class AlgoTypesPaymentTxnFields {
  final AlgoAddress receiver;
  final BigInt amount;

  /// When CloseRemainderTo is set, it indicates that the transaction is requesting that the account should be closed, and all remaining funds be transferred to this address.
  final AlgoAddress closeRemainderTo;

  const AlgoTypesPaymentTxnFields({
    required this.receiver,
    required this.amount,
    required this.closeRemainderTo,
  });

  factory AlgoTypesPaymentTxnFields.deserializeJson(Map<String, dynamic> json) {
    return AlgoTypesPaymentTxnFields(
      receiver: AlgoUtils.parseAddressOrDefault(json.valueAs("rcv")),

      amount: json.valueAsBigInt("amt", onMissing: () => BigInt.zero),
      closeRemainderTo: AlgoUtils.parseAddressOrDefault(json.valueAs("close")),
    );
  }

  Map<String, dynamic> toMsgPack() {
    return {
      "rcv": receiver,
      "amt": amount,
      "close": closeRemainderTo,
    }.notNullValue;
  }
}

/// Proof is used to convince a verifier about membership of leaves: h0,h1...hn at indexes i0,i1...in on a tree. The verifier has a trusted value of the tree root hash.
class AlgoTypesProof {
  /// Path is bounded by MaxNumLeavesOnEncodedTree since there could be multiple reveals, and given the distribution of the elt positions and the depth of the tree, the path length can increase up to 2^MaxEncodedTreeDepth / 2
  final List<AlgoTypesGenericDigest> path;
  final AlgoTypesHashFactory? hashFactory;

  /// TreeDepth represents the depth of the tree that is being proven. It is the number of edges from the root to a leaf.
  final int treeDepth;

  const AlgoTypesProof({
    required this.path,
    this.hashFactory,
    required this.treeDepth,
  });

  factory AlgoTypesProof.deserializeJson(Map<String, dynamic> json) {
    return AlgoTypesProof(
      path: json.valueTo<List<AlgoTypesGenericDigest>, List>(
        key: "pth",
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
      hashFactory: json.valueTo<AlgoTypesHashFactory?, Map>(
        key: "hsh",
        parse:
            (e) => AlgoTypesHashFactory.deserializeJson(
              JsonParser.valueEnsureAsMap(e),
            ),
      ),
      treeDepth: json.valueAsInt("td", onMissing: () => 0),
    );
  }

  Map<String, dynamic> toMsgPack() {
    return {
      "pth": path,
      "hsh": hashFactory?.toMsgPack(),
      "td": treeDepth,
    }.notNullValue;
  }
}

/// ResourceRef names a single resource
class AlgoTypesResourceRef {
  /// Only one of these may be set
  final AlgoAddress address;
  final BigInt asset;
  final BigInt app;
  final AlgoTypesHoldingRef? holding;
  final AlgoTypesLocalsRef? locals;
  final AlgoTypesBoxReference? box;

  const AlgoTypesResourceRef({
    required this.address,
    required this.asset,
    required this.app,
    this.holding,
    this.locals,
    this.box,
  });

  factory AlgoTypesResourceRef.deserializeJson(Map<String, dynamic> json) {
    return AlgoTypesResourceRef(
      address: AlgoUtils.parseAddressOrDefault(json.valueAs("d")),

      asset: json.valueAsBigInt("s", onMissing: () => BigInt.zero),
      app: json.valueAsBigInt("p", onMissing: () => BigInt.zero),
      holding: json.valueTo<AlgoTypesHoldingRef?, Map>(
        key: "h",
        parse:
            (e) => AlgoTypesHoldingRef.deserializeJson(
              JsonParser.valueEnsureAsMap(e),
            ),
      ),
      locals: json.valueTo<AlgoTypesLocalsRef?, Map>(
        key: "l",
        parse:
            (e) => AlgoTypesLocalsRef.deserializeJson(
              JsonParser.valueEnsureAsMap(e),
            ),
      ),
      box: json.valueTo<AlgoTypesBoxReference?, Map>(
        key: "b",
        parse:
            (e) => AlgoTypesBoxReference.deserializeJson(
              JsonParser.valueEnsureAsMap(e),
            ),
      ),
    );
  }

  Map<String, dynamic> toMsgPack() {
    return {
      "d": address,
      "s": asset,
      "p": app,
      "h": holding?.toMsgPack(),
      "l": locals?.toMsgPack(),
      "b": box?.toMsgPack(),
    }.notNullValue;
  }
}

/// Reveal is a single array position revealed as part of a state proof.  It reveals an element of the signature array and the corresponding element of the participants array.
class AlgoTypesReveal {
  final dynamic sigSlot;
  final AlgoTypesParticipant? partValue;

  const AlgoTypesReveal({required this.sigSlot, this.partValue});

  factory AlgoTypesReveal.deserializeJson(Map<String, dynamic> json) {
    return AlgoTypesReveal(
      sigSlot: json["s"],
      partValue: json.valueTo<AlgoTypesParticipant?, Map>(
        key: "p",
        parse:
            (e) => AlgoTypesParticipant.deserializeJson(
              JsonParser.valueEnsureAsMap(e),
            ),
      ),
    );
  }

  Map<String, dynamic> toMsgPack() {
    return {"s": sigSlot, "p": partValue?.toMsgPack()}.notNullValue;
  }
}

/// RewardsState represents the global parameters controlling the rate at which accounts accrue rewards.
class AlgoTypesRewardsState {
  /// The FeeSink accepts transaction fees. It can only spend to the incentive pool.
  final AlgoAddress feeSink;

  /// The RewardsPool accepts periodic injections from the FeeSink and continually redistributes them to addresses as rewards.
  final AlgoAddress rewardsPool;

  /// RewardsLevel specifies how many rewards, in MicroAlgos, have been distributed to each config.Protocol.RewardUnit of MicroAlgos since genesis.
  final BigInt rewardsLevel;

  /// The number of new MicroAlgos added to the participation stake from rewards at the next round.
  final BigInt rewardsRate;

  /// The number of leftover MicroAlgos after the distribution of RewardsRate/rewardUnits MicroAlgos for every reward unit in the next round.
  final BigInt rewardsResidue;

  /// The round at which the RewardsRate will be recalculated.
  final BigInt rewardsRecalculationRound;

  const AlgoTypesRewardsState({
    required this.feeSink,
    required this.rewardsPool,
    required this.rewardsLevel,
    required this.rewardsRate,
    required this.rewardsResidue,
    required this.rewardsRecalculationRound,
  });

  factory AlgoTypesRewardsState.deserializeJson(Map<String, dynamic> json) {
    return AlgoTypesRewardsState(
      feeSink: AlgoUtils.parseAddressOrDefault(json.valueAs("fees")),

      rewardsPool: AlgoUtils.parseAddressOrDefault(json.valueAs("rwd")),

      rewardsLevel: json.valueAsBigInt("earn", onMissing: () => BigInt.zero),
      rewardsRate: json.valueAsBigInt("rate", onMissing: () => BigInt.zero),
      rewardsResidue: json.valueAsBigInt("frac", onMissing: () => BigInt.zero),
      rewardsRecalculationRound: json.valueAsBigInt(
        "rwcalr",
        onMissing: () => BigInt.zero,
      ),
    );
  }

  Map<String, dynamic> toMsgPack() {
    return {
      "fees": feeSink,
      "rwd": rewardsPool,
      "earn": rewardsLevel,
      "rate": rewardsRate,
      "frac": rewardsResidue,
      "rwcalr": rewardsRecalculationRound,
    }.notNullValue;
  }
}

/// SignedBid represents a signed bid by a bidder.
class AlgoTypesSignedBid with LayoutSerializable {
  /// Bid contains information about the bid.
  final AlgoTypesBid bid;

  /// Sig is a signature by the bidder, as identified in the bid (Bid.BidderKey) over the hash of the Bid.
  final List<int> sig;

  const AlgoTypesSignedBid({required this.bid, required this.sig});

  factory AlgoTypesSignedBid.deserializeJson(Map<String, dynamic> json) {
    return AlgoTypesSignedBid(
      bid: json.valueTo<AlgoTypesBid, Map>(
        key: "bid",
        parse:
            (e) => AlgoTypesBid.deserializeJson(JsonParser.valueEnsureAsMap(e)),
      ),
      sig: json.valueAsBytes(
        "sig",
        encoding: StringEncoding.base64,
        onMissing: () => [],
      ),
    );
  }

  static MsgPackFixedKeyDynamicLazyValueMapLayout<
    String,
    dynamic,
    LayoutRepository
  >
  layout({String? property}) {
    return MsgPackFixedKeyDynamicLazyValueMapLayout<
      String,
      dynamic,
      LayoutRepository
    >(
      keyLayout: MsgPackStringLayout(),
      sortKeys: true,
      valueLayouts: [
        MapEntry(
          "bid",
          LazyMsgPackMapLayoutBuilder(
            layout: (property, params) => AlgoTypesBid.layout(),
          ),
        ),
        MapEntry(
          "sig",
          LazyMsgPackMapLayoutBuilder(
            layout: AlgoBinaryLayout.defaultBinary64Layout,
          ),
        ),
      ],
      property: property,
    );
  }

  @override
  Layout<Map<String, dynamic>> toLayout({String? property}) {
    return layout(property: property);
  }

  @override
  Map<String, dynamic> toSerializeJson() {
    return {"bid": bid.toSerializeJson(), "sig": sig};
  }
}

/// SignedTxn wraps a transaction and a signature. The encoding of this struct is suitable to broadcast on the network
class AlgoTypesSignedTxn {
  final AlgoTypesSignature sig;
  final AlgoTypesMultisigSig? msig;
  final AlgoTypesLogicSig? lsig;
  final AlgoTypesPQSig? pQsig;
  final AlgoTypesTransaction? txn;
  final AlgoAddress authAddr;

  const AlgoTypesSignedTxn({
    required this.sig,
    this.msig,
    this.lsig,
    this.pQsig,
    this.txn,
    required this.authAddr,
  });

  factory AlgoTypesSignedTxn.deserializeJson(Map<String, dynamic> json) {
    return AlgoTypesSignedTxn(
      sig: json.valueAsBytes(
        "sig",
        encoding: StringEncoding.base64,
        onMissing:
            () => List<int>.filled(CryptoSignerConst.ed25519SignatureLength, 0),
      ),
      msig: json.valueTo<AlgoTypesMultisigSig?, Map>(
        key: "msig",
        parse:
            (e) => AlgoTypesMultisigSig.deserializeJson(
              JsonParser.valueEnsureAsMap(e),
            ),
      ),
      lsig: json.valueTo<AlgoTypesLogicSig?, Map>(
        key: "lsig",
        parse:
            (e) => AlgoTypesLogicSig.deserializeJson(
              JsonParser.valueEnsureAsMap(e),
            ),
      ),
      pQsig: json.valueTo<AlgoTypesPQSig?, Map>(
        key: "pqsig",
        parse:
            (e) =>
                AlgoTypesPQSig.deserializeJson(JsonParser.valueEnsureAsMap(e)),
      ),
      txn: json.valueTo<AlgoTypesTransaction?, Map>(
        key: "txn",
        parse:
            (e) => AlgoTypesTransaction.deserializeJson(
              JsonParser.valueEnsureAsMap(e),
            ),
      ),
      authAddr: AlgoUtils.parseAddressOrDefault(json.valueAs("sgnr")),
    );
  }

  Map<String, dynamic> toMsgPack() {
    return {
      "sig": sig,
      "msig": msig?.toMsgPack(),
      "lsig": lsig?.toMsgPack(),
      "pqsig": pQsig?.toMsgPack(),
      "txn": txn?.toMsgPack(),
      "sgnr": authAddr,
    }.notNullValue;
  }
}

/// SignedTxnInBlock is how a signed transaction is encoded in a block.
class AlgoTypesSignedTxnInBlock {
  final AlgoTypesSignature sig;
  final AlgoTypesMultisigSig? msig;
  final AlgoTypesLogicSig? lsig;
  final AlgoTypesPQSig? pQsig;
  final AlgoTypesTransaction? txn;
  final AlgoAddress authAddr;

  /// Closing amount for transaction.
  final BigInt closingAmount;

  /// Closing amount for asset transaction.
  final BigInt assetClosingAmount;

  /// Rewards applied to the Sender, Receiver, and CloseRemainderTo accounts.
  final BigInt senderRewards;
  final BigInt receiverRewards;
  final BigInt closeRewards;
  final AlgoTypesEvalDelta? evalDelta;

  /// If asa or app is being created, the id used. Else 0. Names chosen to match naming the corresponding txn. These are populated only when MaxInnerTransactions > 0 (TEAL 5)
  final BigInt configAsset;
  final BigInt applicationID;
  final bool hasGenesisID;
  final bool hasGenesisHash;

  const AlgoTypesSignedTxnInBlock({
    required this.sig,
    this.msig,
    this.lsig,
    this.pQsig,
    this.txn,
    required this.authAddr,
    required this.closingAmount,
    required this.assetClosingAmount,
    required this.senderRewards,
    required this.receiverRewards,
    required this.closeRewards,
    this.evalDelta,
    required this.configAsset,
    required this.applicationID,
    required this.hasGenesisID,
    required this.hasGenesisHash,
  });

  factory AlgoTypesSignedTxnInBlock.deserializeJson(Map<String, dynamic> json) {
    return AlgoTypesSignedTxnInBlock(
      sig: json.valueAsBytes(
        "sig",
        encoding: StringEncoding.base64,
        onMissing:
            () => List<int>.filled(CryptoSignerConst.ed25519SignatureLength, 0),
      ),
      msig: json.valueTo<AlgoTypesMultisigSig?, Map>(
        key: "msig",
        parse:
            (e) => AlgoTypesMultisigSig.deserializeJson(
              JsonParser.valueEnsureAsMap(e),
            ),
      ),
      lsig: json.valueTo<AlgoTypesLogicSig?, Map>(
        key: "lsig",
        parse:
            (e) => AlgoTypesLogicSig.deserializeJson(
              JsonParser.valueEnsureAsMap(e),
            ),
      ),
      pQsig: json.valueTo<AlgoTypesPQSig?, Map>(
        key: "pqsig",
        parse:
            (e) =>
                AlgoTypesPQSig.deserializeJson(JsonParser.valueEnsureAsMap(e)),
      ),
      txn: json.valueTo<AlgoTypesTransaction?, Map>(
        key: "txn",
        parse:
            (e) => AlgoTypesTransaction.deserializeJson(
              JsonParser.valueEnsureAsMap(e),
            ),
      ),
      authAddr: AlgoUtils.parseAddressOrDefault(json.valueAs("sgnr")),

      closingAmount: json.valueAsBigInt("ca", onMissing: () => BigInt.zero),
      assetClosingAmount: json.valueAsBigInt(
        "aca",
        onMissing: () => BigInt.zero,
      ),
      senderRewards: json.valueAsBigInt("rs", onMissing: () => BigInt.zero),
      receiverRewards: json.valueAsBigInt("rr", onMissing: () => BigInt.zero),
      closeRewards: json.valueAsBigInt("rc", onMissing: () => BigInt.zero),
      evalDelta: json.valueTo<AlgoTypesEvalDelta?, Map>(
        key: "dt",
        parse:
            (e) => AlgoTypesEvalDelta.deserializeJson(
              JsonParser.valueEnsureAsMap(e),
            ),
      ),
      configAsset: json.valueAsBigInt("caid", onMissing: () => BigInt.zero),
      applicationID: json.valueAsBigInt("apid", onMissing: () => BigInt.zero),
      hasGenesisID: json.valueAsBool("hgi", onMissing: () => false),
      hasGenesisHash: json.valueAsBool("hgh", onMissing: () => false),
    );
  }

  Map<String, dynamic> toMsgPack() {
    return {
      "sig": sig,
      "msig": msig?.toMsgPack(),
      "lsig": lsig?.toMsgPack(),
      "pqsig": pQsig?.toMsgPack(),
      "txn": txn?.toMsgPack(),
      "sgnr": authAddr,
      "ca": closingAmount,
      "aca": assetClosingAmount,
      "rs": senderRewards,
      "rr": receiverRewards,
      "rc": closeRewards,
      "dt": evalDelta?.toMsgPack(),
      "caid": configAsset,
      "apid": applicationID,
      "hgi": hasGenesisID,
      "hgh": hasGenesisHash,
    }.notNullValue;
  }
}

/// SignedTxnWithAD is a (decoded) SignedTxn with associated ApplyData
class AlgoTypesSignedTxnWithAD {
  final AlgoTypesSignature sig;
  final AlgoTypesMultisigSig? msig;
  final AlgoTypesLogicSig? lsig;
  final AlgoTypesPQSig? pQsig;
  final AlgoTypesTransaction? txn;
  final AlgoAddress authAddr;

  /// Closing amount for transaction.
  final BigInt closingAmount;

  /// Closing amount for asset transaction.
  final BigInt assetClosingAmount;

  /// Rewards applied to the Sender, Receiver, and CloseRemainderTo accounts.
  final BigInt senderRewards;
  final BigInt receiverRewards;
  final BigInt closeRewards;
  final AlgoTypesEvalDelta? evalDelta;

  /// If asa or app is being created, the id used. Else 0. Names chosen to match naming the corresponding txn. These are populated only when MaxInnerTransactions > 0 (TEAL 5)
  final BigInt configAsset;
  final BigInt applicationID;

  const AlgoTypesSignedTxnWithAD({
    required this.sig,
    this.msig,
    this.lsig,
    this.pQsig,
    this.txn,
    required this.authAddr,
    required this.closingAmount,
    required this.assetClosingAmount,
    required this.senderRewards,
    required this.receiverRewards,
    required this.closeRewards,
    this.evalDelta,
    required this.configAsset,
    required this.applicationID,
  });

  factory AlgoTypesSignedTxnWithAD.deserializeJson(Map<String, dynamic> json) {
    return AlgoTypesSignedTxnWithAD(
      sig: json.valueAsBytes(
        "sig",
        encoding: StringEncoding.base64,
        onMissing:
            () => List<int>.filled(CryptoSignerConst.ed25519SignatureLength, 0),
      ),
      msig: json.valueTo<AlgoTypesMultisigSig?, Map>(
        key: "msig",
        parse:
            (e) => AlgoTypesMultisigSig.deserializeJson(
              JsonParser.valueEnsureAsMap(e),
            ),
      ),
      lsig: json.valueTo<AlgoTypesLogicSig?, Map>(
        key: "lsig",
        parse:
            (e) => AlgoTypesLogicSig.deserializeJson(
              JsonParser.valueEnsureAsMap(e),
            ),
      ),
      pQsig: json.valueTo<AlgoTypesPQSig?, Map>(
        key: "pqsig",
        parse:
            (e) =>
                AlgoTypesPQSig.deserializeJson(JsonParser.valueEnsureAsMap(e)),
      ),
      txn: json.valueTo<AlgoTypesTransaction?, Map>(
        key: "txn",
        parse:
            (e) => AlgoTypesTransaction.deserializeJson(
              JsonParser.valueEnsureAsMap(e),
            ),
      ),
      authAddr: AlgoUtils.parseAddressOrDefault(json.valueAs("sgnr")),

      closingAmount: json.valueAsBigInt("ca", onMissing: () => BigInt.zero),
      assetClosingAmount: json.valueAsBigInt(
        "aca",
        onMissing: () => BigInt.zero,
      ),
      senderRewards: json.valueAsBigInt("rs", onMissing: () => BigInt.zero),
      receiverRewards: json.valueAsBigInt("rr", onMissing: () => BigInt.zero),
      closeRewards: json.valueAsBigInt("rc", onMissing: () => BigInt.zero),
      evalDelta: json.valueTo<AlgoTypesEvalDelta?, Map>(
        key: "dt",
        parse:
            (e) => AlgoTypesEvalDelta.deserializeJson(
              JsonParser.valueEnsureAsMap(e),
            ),
      ),
      configAsset: json.valueAsBigInt("caid", onMissing: () => BigInt.zero),
      applicationID: json.valueAsBigInt("apid", onMissing: () => BigInt.zero),
    );
  }

  Map<String, dynamic> toMsgPack() {
    return {
      "sig": sig,
      "msig": msig?.toMsgPack(),
      "lsig": lsig?.toMsgPack(),
      "pqsig": pQsig?.toMsgPack(),
      "txn": txn?.toMsgPack(),
      "sgnr": authAddr,
      "ca": closingAmount,
      "aca": assetClosingAmount,
      "rs": senderRewards,
      "rr": receiverRewards,
      "rc": closeRewards,
      "dt": evalDelta?.toMsgPack(),
      "caid": configAsset,
      "apid": applicationID,
    }.notNullValue;
  }
}

/// A sigslotCommit is a single slot in the sigs array that forms the state proof.
class AlgoTypesSigslotCommit {
  /// Sig is a signature by the participant on the expected message.
  final AlgoTypesFalconSignatureStruct? sig;

  /// L is the total weight of signatures in lower-numbered slots. This is initialized once the builder has collected a sufficient number of signatures.
  final BigInt l;

  const AlgoTypesSigslotCommit({this.sig, required this.l});

  factory AlgoTypesSigslotCommit.deserializeJson(Map<String, dynamic> json) {
    return AlgoTypesSigslotCommit(
      sig: json.valueTo<AlgoTypesFalconSignatureStruct?, Map>(
        key: "s",
        parse:
            (e) => AlgoTypesFalconSignatureStruct.deserializeJson(
              JsonParser.valueEnsureAsMap(e),
            ),
      ),
      l: json.valueAsBigInt("l", onMissing: () => BigInt.zero),
    );
  }

  Map<String, dynamic> toMsgPack() {
    return {"s": sig?.toMsgPack(), "l": l}.notNullValue;
  }
}

/// SingleLeafProof is used to convince a verifier about membership of a specific leaf h at index i on a tree. The verifier has a trusted value of the tree root hash. it corresponds to merkle verification path.
class AlgoTypesSingleLeafProof {
  /// Path is bounded by MaxNumLeavesOnEncodedTree since there could be multiple reveals, and given the distribution of the elt positions and the depth of the tree, the path length can increase up to 2^MaxEncodedTreeDepth / 2
  final List<AlgoTypesGenericDigest> path;
  final AlgoTypesHashFactory? hashFactory;

  /// TreeDepth represents the depth of the tree that is being proven. It is the number of edges from the root to a leaf.
  final int treeDepth;

  const AlgoTypesSingleLeafProof({
    required this.path,
    this.hashFactory,
    required this.treeDepth,
  });

  factory AlgoTypesSingleLeafProof.deserializeJson(Map<String, dynamic> json) {
    return AlgoTypesSingleLeafProof(
      path: json.valueTo<List<AlgoTypesGenericDigest>, List>(
        key: "pth",
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
      hashFactory: json.valueTo<AlgoTypesHashFactory?, Map>(
        key: "hsh",
        parse:
            (e) => AlgoTypesHashFactory.deserializeJson(
              JsonParser.valueEnsureAsMap(e),
            ),
      ),
      treeDepth: json.valueAsInt("td", onMissing: () => 0),
    );
  }

  Map<String, dynamic> toMsgPack() {
    return {
      "pth": path,
      "hsh": hashFactory?.toMsgPack(),
      "td": treeDepth,
    }.notNullValue;
  }
}

/// StateProof represents a proof on Algorand's state.
class AlgoTypesStateProof {
  final AlgoTypesGenericDigest sigCommit;
  final BigInt signedWeight;
  final AlgoTypesProof? sigProofs;
  final AlgoTypesProof? partProofs;
  final dynamic merkleSignatureSaltVersion;

  /// Reveals is a sparse map from the position being revealed to the corresponding elements from the sigs and participants arrays.
  final Map<BigInt, AlgoTypesReveal> reveals;
  final List<BigInt> positionsToReveal;

  const AlgoTypesStateProof({
    required this.sigCommit,
    required this.signedWeight,
    this.sigProofs,
    this.partProofs,
    required this.merkleSignatureSaltVersion,
    required this.reveals,
    required this.positionsToReveal,
  });

  factory AlgoTypesStateProof.deserializeJson(Map<String, dynamic> json) {
    return AlgoTypesStateProof(
      sigCommit: json.valueAsBytes(
        "c",
        encoding: StringEncoding.base64,
        onMissing: () => [],
      ),
      signedWeight: json.valueAsBigInt("w", onMissing: () => BigInt.zero),
      sigProofs: json.valueTo<AlgoTypesProof?, Map>(
        key: "S",
        parse:
            (e) =>
                AlgoTypesProof.deserializeJson(JsonParser.valueEnsureAsMap(e)),
      ),
      partProofs: json.valueTo<AlgoTypesProof?, Map>(
        key: "P",
        parse:
            (e) =>
                AlgoTypesProof.deserializeJson(JsonParser.valueEnsureAsMap(e)),
      ),
      merkleSignatureSaltVersion: json["v"],
      reveals: json.valueTo<Map<BigInt, AlgoTypesReveal>, Map>(
        key: "r",
        onMissing: () => {},
        parse:
            (e) => e.map(
              (k, v) => MapEntry(
                JsonParser.valueAsBigInt(k),
                AlgoTypesReveal.deserializeJson(JsonParser.valueEnsureAsMap(v)),
              ),
            ),
      ),
      positionsToReveal: json.valueEnsureAsList<BigInt>(
        "pr",
        onMissing: () => [],
      ),
    );
  }

  Map<String, dynamic> toMsgPack() {
    return {
      "c": sigCommit,
      "w": signedWeight,
      "S": sigProofs?.toMsgPack(),
      "P": partProofs?.toMsgPack(),
      "v": merkleSignatureSaltVersion,
      "r": reveals.map((k, e) => MapEntry(k, e.toMsgPack())),
      "pr": positionsToReveal.map((e) => e).toList(),
    }.notNullValue;
  }
}

/// StateProofTrackingData tracks the status of state proofs.
class AlgoTypesStateProofTrackingData {
  /// StateProofVotersCommitment is the root of a vector commitment containing the online accounts that will help sign a state proof.  The VC root, and the state proof, happen on blocks that are a multiple of ConsensusParams.StateProofRounds.  For blocks that are not a multiple of ConsensusParams.StateProofRounds, this value is zero.
  final AlgoTypesGenericDigest stateProofVotersCommitment;

  /// StateProofOnlineTotalWeight is the total number of microalgos held by the online accounts during the StateProof round (or zero, if the merkle root is zero - no commitment for StateProof voters). This is intended for computing the threshold of votes to expect from StateProofVotersCommitment.
  final BigInt stateProofOnlineTotalWeight;

  /// StateProofNextRound is the next round for which we will accept a StateProof transaction.
  final BigInt stateProofNextRound;

  const AlgoTypesStateProofTrackingData({
    required this.stateProofVotersCommitment,
    required this.stateProofOnlineTotalWeight,
    required this.stateProofNextRound,
  });

  factory AlgoTypesStateProofTrackingData.deserializeJson(
    Map<String, dynamic> json,
  ) {
    return AlgoTypesStateProofTrackingData(
      stateProofVotersCommitment: json.valueAsBytes(
        "v",
        encoding: StringEncoding.base64,
        onMissing: () => [],
      ),
      stateProofOnlineTotalWeight: json.valueAsBigInt(
        "t",
        onMissing: () => BigInt.zero,
      ),
      stateProofNextRound: json.valueAsBigInt(
        "n",
        onMissing: () => BigInt.zero,
      ),
    );
  }

  Map<String, dynamic> toMsgPack() {
    return {
      "v": stateProofVotersCommitment,
      "t": stateProofOnlineTotalWeight,
      "n": stateProofNextRound,
    }.notNullValue;
  }
}

/// StateProofTxnFields captures the fields used for stateproof transactions.
class AlgoTypesStateProofTxnFields {
  final AlgoTypesStateProofType stateProofType;
  final AlgoTypesStateProof? stateProof;
  final AlgoTypesMessage? message;

  const AlgoTypesStateProofTxnFields({
    required this.stateProofType,
    this.stateProof,
    this.message,
  });

  factory AlgoTypesStateProofTxnFields.deserializeJson(
    Map<String, dynamic> json,
  ) {
    return AlgoTypesStateProofTxnFields(
      stateProofType: json.valueTo<AlgoTypesStateProofType, int>(
        key: "sptype",
        parse: (e) => AlgoTypesStateProofType.fromValue(e),
      ),
      stateProof: json.valueTo<AlgoTypesStateProof?, Map>(
        key: "sp",
        parse:
            (e) => AlgoTypesStateProof.deserializeJson(
              JsonParser.valueEnsureAsMap(e),
            ),
      ),
      message: json.valueTo<AlgoTypesMessage?, Map>(
        key: "spmsg",
        parse:
            (e) => AlgoTypesMessage.deserializeJson(
              JsonParser.valueEnsureAsMap(e),
            ),
      ),
    );
  }

  Map<String, dynamic> toMsgPack() {
    return {
      "sptype": stateProofType.value,
      "sp": stateProof?.toMsgPack(),
      "spmsg": message?.toSerializeJson(),
    }.notNullValue;
  }
}

/// StateSchema sets maximums on the number of each type that may be stored
class AlgoTypesStateSchema {
  final BigInt numUint;
  final BigInt numByteSlice;

  const AlgoTypesStateSchema({
    required this.numUint,
    required this.numByteSlice,
  });

  factory AlgoTypesStateSchema.deserializeJson(Map<String, dynamic> json) {
    return AlgoTypesStateSchema(
      numUint: json.valueAsBigInt("nui", onMissing: () => BigInt.zero),
      numByteSlice: json.valueAsBigInt("nbs", onMissing: () => BigInt.zero),
    );
  }

  Map<String, dynamic> toMsgPack() {
    return {"nui": numUint, "nbs": numByteSlice}.notNullValue;
  }
}

/// StateSchemas is a thin wrapper around the LocalStateSchema and the GlobalStateSchema, since they are often needed together
class AlgoTypesStateSchemas {
  final AlgoTypesStateSchema? localStateSchema;
  final AlgoTypesStateSchema? globalStateSchema;

  const AlgoTypesStateSchemas({this.localStateSchema, this.globalStateSchema});

  factory AlgoTypesStateSchemas.deserializeJson(Map<String, dynamic> json) {
    return AlgoTypesStateSchemas(
      localStateSchema: json.valueTo<AlgoTypesStateSchema?, Map>(
        key: "lsch",
        parse:
            (e) => AlgoTypesStateSchema.deserializeJson(
              JsonParser.valueEnsureAsMap(e),
            ),
      ),
      globalStateSchema: json.valueTo<AlgoTypesStateSchema?, Map>(
        key: "gsch",
        parse:
            (e) => AlgoTypesStateSchema.deserializeJson(
              JsonParser.valueEnsureAsMap(e),
            ),
      ),
    );
  }

  Map<String, dynamic> toMsgPack() {
    return {
      "lsch": localStateSchema?.toMsgPack(),
      "gsch": globalStateSchema?.toMsgPack(),
    }.notNullValue;
  }
}

/// SuggestedParams wraps the transaction parameters common to all transactions, typically received from the SuggestedParams endpoint of algod. This struct itself is not sent over the wire to or from algod: see models.TransactionParams.
class AlgoTypesSuggestedParams {
  /// Fee is the suggested transaction fee Fee is in units of micro-Algos per byte. Fee may fall to zero but a group of N atomic transactions must still have a fee of at least N*MinTxnFee for the current network protocol.
  final BigInt fee;

  /// Genesis ID
  final String genesisID;

  /// Genesis hash
  final List<int> genesisHash;

  /// FirstRoundValid is the first protocol round on which the txn is valid
  final BigInt firstRoundValid;

  /// LastRoundValid is the final protocol round on which the txn may be committed
  final BigInt lastRoundValid;

  /// ConsensusVersion indicates the consensus protocol version as of LastRound.
  final String consensusVersion;

  /// FlatFee indicates whether the passed fee is per-byte or per-transaction If true, txn fee may fall below the MinTxnFee for the current network protocol.
  final bool flatFee;

  /// The minimum transaction fee (not per byte) required for the txn to validate for the current network protocol.
  final BigInt minFee;

  const AlgoTypesSuggestedParams({
    required this.fee,
    required this.genesisID,
    required this.genesisHash,
    required this.firstRoundValid,
    required this.lastRoundValid,
    required this.consensusVersion,
    required this.flatFee,
    required this.minFee,
  });

  factory AlgoTypesSuggestedParams.deserializeJson(Map<String, dynamic> json) {
    return AlgoTypesSuggestedParams(
      fee: json.valueAsBigInt("fee", onMissing: () => BigInt.zero),
      genesisID: json.valueAsString(
        "genesis-id",
        bytesEncoding: StringEncoding.utf8,
        onMissing: () => '',
      ),
      genesisHash: json.valueAsBytes(
        "genesis-hash",
        encoding: StringEncoding.base64,
        onMissing: () => [],
      ),
      firstRoundValid: json.valueAsBigInt(
        "first-round",
        onMissing: () => BigInt.zero,
      ),
      lastRoundValid: json.valueAsBigInt(
        "last-round",
        onMissing: () => BigInt.zero,
      ),
      consensusVersion: json.valueAsString(
        "consensus-version",
        bytesEncoding: StringEncoding.utf8,
        onMissing: () => '',
      ),
      flatFee: json.valueAsBool("flat-fee", onMissing: () => false),
      minFee: json.valueAsBigInt("min-fee", onMissing: () => BigInt.zero),
    );
  }

  Map<String, dynamic> toMsgPack() {
    return {
      "fee": fee,
      "genesis-id": genesisID,
      "genesis-hash": genesisHash,
      "first-round": firstRoundValid,
      "last-round": lastRoundValid,
      "consensus-version": consensusVersion,
      "flat-fee": flatFee,
      "min-fee": minFee,
    }.notNullValue;
  }
}

/// TealValue contains type information and a value, representing a value in a TEAL program
class AlgoTypesTealValue {
  final AlgoTypesTealType type;
  final String bytes;
  final BigInt uint;

  const AlgoTypesTealValue({
    required this.type,
    required this.bytes,
    required this.uint,
  });

  factory AlgoTypesTealValue.deserializeJson(Map<String, dynamic> json) {
    return AlgoTypesTealValue(
      type: json.valueTo<AlgoTypesTealType, int>(
        key: "tt",
        parse: (e) => AlgoTypesTealType.fromValue(e),
      ),
      bytes: json.valueAsString(
        "tb",
        bytesEncoding: StringEncoding.utf8,
        onMissing: () => '',
      ),
      uint: json.valueAsBigInt("ui", onMissing: () => BigInt.zero),
    );
  }

  Map<String, dynamic> toMsgPack() {
    return {"tt": type.value, "tb": bytes, "ui": uint}.notNullValue;
  }
}

/// Transaction describes a transaction that can appear in a block.
class AlgoTypesTransaction {
  /// Type of transaction
  final String type;
  final AlgoAddress sender;
  final BigInt fee;
  final BigInt firstValid;
  final BigInt lastValid;
  final List<int> note;
  final String genesisID;
  final List<int> genesisHash;

  /// Group specifies that this transaction is part of a transaction group (and, if so, specifies the hash of a TxGroup).
  final List<int> group;

  /// Lease enforces mutual exclusion of transactions.  If this field is nonzero, then once the transaction is confirmed, it acquires the lease identified by the (Sender, Lease) pair of the transaction until the LastValid round passes.  While this transaction possesses the lease, no other transaction specifying this lease can be confirmed.
  final List<int> lease;

  /// RekeyTo, if nonzero, sets the sender's AuthAddr to the given address If the RekeyTo address is the sender's actual address, the AuthAddr is set to zero This allows "re-keying" a long-lived account -- rotating the signing key, changing membership of a multisig account, etc.
  final AlgoAddress rekeyTo;
  final AlgoTypesVotePK votePK;
  final AlgoTypesVRFPK selectionPK;
  final List<int>? stateProofPK;
  final BigInt voteFirst;
  final BigInt voteLast;
  final BigInt voteKeyDilution;
  final bool nonparticipation;
  final AlgoAddress receiver;
  final BigInt amount;

  /// When CloseRemainderTo is set, it indicates that the transaction is requesting that the account should be closed, and all remaining funds be transferred to this address.
  final AlgoAddress closeRemainderTo;

  /// ConfigAsset is the asset being configured or destroyed. A zero value means allocation
  final BigInt configAsset;

  /// AssetParams are the parameters for the asset being created or re-configured.  A zero value means destruction.
  final AlgoTypesAssetParams? assetParams;
  final BigInt xferAsset;

  /// AssetAmount is the amount of asset to transfer. A zero amount transferred to self allocates that asset in the account's Assets map.
  final BigInt assetAmount;

  /// AssetSender is the sender of the transfer.  If this is not a zero value, the real transaction sender must be the Clawback address from the AssetParams.  If this is the zero value, the asset is sent from the transaction's Sender.
  final AlgoAddress assetSender;

  /// AssetReceiver is the recipient of the transfer.
  final AlgoAddress assetReceiver;

  /// AssetCloseTo indicates that the asset should be removed from the account's Assets map, and specifies where the remaining asset holdings should be transferred.  It's always valid to transfer remaining asset holdings to the creator account.
  final AlgoAddress assetCloseTo;

  /// FreezeAccount is the address of the account whose asset slot is being frozen or un-frozen.
  final AlgoAddress freezeAccount;

  /// FreezeAsset is the asset ID being frozen or un-frozen.
  final BigInt freezeAsset;

  /// AssetFrozen is the new frozen value.
  final bool assetFrozen;

  /// ApplicationID is 0 when creating an application, and nonzero when calling an existing application.
  final BigInt applicationID;

  /// OnCompletion specifies an optional side-effect that this transaction will have on the balance record of the sender or the application's creator. See the documentation for the OnCompletion type for more information on each possible value.
  final AlgoTypesOnCompletion onCompletion;

  /// ApplicationArgs are arguments accessible to the executing ApprovalProgram or ClearStateProgram.
  final List<List<int>> applicationArgs;

  /// Accounts are accounts whose balance records are accessible by the executing ApprovalProgram or ClearStateProgram. To access LocalState or an ASA balance for an account besides the sender, that account's address must be listed here (and since v4, the ForeignApp or ForeignAsset must also include the app or asset id).
  final List<AlgoAddress> accounts;

  /// ForeignAssets are asset IDs for assets whose AssetParams (and since v4, Holdings) may be read by the executing ApprovalProgram or ClearStateProgram.
  final List<BigInt> foreignAssets;

  /// ForeignApps are application IDs for applications besides this one whose GlobalState (or Local, since v4) may be read by the executing ApprovalProgram or ClearStateProgram.
  final List<BigInt> foreignApps;

  /// Access unifies `Accounts`, `ForeignApps`, `ForeignAssets`, and `Boxes` under a single list. It removes all implicitly available resources, so "cross-product" resources (holdings and locals) must be explicitly listed, as well as app accounts, even the app account of the called app! Transactions using Access may not use the other lists.
  final List<AlgoTypesResourceRef> access;

  /// Boxes are the boxes that can be accessed by this transaction (and others in the same group). The Index in the BoxRef is the slot of ForeignApps that the name is associated with (shifted by 1. 0 indicates "current app")
  final List<AlgoTypesBoxReference> boxReferences;

  /// LocalStateSchema specifies the maximum number of each type that may appear in the local key/value store of users who opt in to this application. This field is only used during application creation (when the ApplicationID field is 0),
  final AlgoTypesStateSchema? localStateSchema;

  /// GlobalStateSchema specifies the maximum number of each type that may appear in the global key/value store associated with this application. This field is only used during application creation (when the ApplicationID field is 0).
  final AlgoTypesStateSchema? globalStateSchema;

  /// ApprovalProgram is the stateful TEAL bytecode that executes on all ApplicationCall transactions associated with this application, except for those where OnCompletion is equal to ClearStateOC. If this program fails, the transaction is rejected. This program may read and write local and global state for this application.
  final List<int> approvalProgram;

  /// ClearStateProgram is the stateful TEAL bytecode that executes on ApplicationCall transactions associated with this application when OnCompletion is equal to ClearStateOC. This program will not cause the transaction to be rejected, even if it fails. This program may read and write local and global state for this application.
  final List<int> clearStateProgram;

  /// ExtraProgramPages specifies the additional app program len requested in pages. A page is MaxAppProgramLen bytes. This field enables execution of app programs larger than the default config, MaxAppProgramLen.
  final int extraProgramPages;

  /// RejectVersion is the lowest application version for which this transaction should immediately fail. 0 indicates that no version check should be performed.
  final BigInt rejectVersion;
  final AlgoTypesStateProofType stateProofType;
  final AlgoTypesStateProof? stateProof;
  final AlgoTypesMessage? message;

  /// HbAddress is the account this txn is proving onlineness for.
  final AlgoAddress hbAddress;

  /// HbProof is a signature using HeartbeatAddress's partkey, thereby showing it is online.
  final AlgoTypesHeartbeatProof? hbProof;

  /// The final three fields are included to allow early, concurrent check of the HbProof. HbSeed must be the block seed for this transaction's firstValid block. It is the message that must be signed with HbAddress's part key.
  final AlgoTypesSeed hbSeed;

  /// HbVoteID must match the HbAddress account's current VoteID.
  final AlgoTypesVotePK hbVoteID;

  /// HbKeyDilution must match HbAddress account's current KeyDilution.
  final BigInt hbKeyDilution;

  /// HbChallengeDiscount requests the challenge fee discount: when set, the required fee is reduced by one min fee. It is optional even for a challenged account (an account willing to pay the normal fee can leave it off), so it is a request, not an assertion. apply verifies HbAddress is actually under challenge before granting it. The flag is only allowed once transaction size pricing is enabled (proto.TxnSizePricingEnabled()); it makes sense to think in terms of transaction fields changing fees now, so it needs no separate consensus flag. Before then, the discount was inferred from an underpaid singleton heartbeat instead (see wellFormed and apply).
  final bool hbChallengeDiscount;

  const AlgoTypesTransaction({
    required this.type,
    required this.sender,
    required this.fee,
    required this.firstValid,
    required this.lastValid,
    required this.note,
    required this.genesisID,
    required this.genesisHash,
    required this.group,
    required this.lease,
    required this.rekeyTo,
    required this.votePK,
    required this.selectionPK,
    required this.stateProofPK,
    required this.voteFirst,
    required this.voteLast,
    required this.voteKeyDilution,
    required this.nonparticipation,
    required this.receiver,
    required this.amount,
    required this.closeRemainderTo,
    required this.configAsset,
    this.assetParams,
    required this.xferAsset,
    required this.assetAmount,
    required this.assetSender,
    required this.assetReceiver,
    required this.assetCloseTo,
    required this.freezeAccount,
    required this.freezeAsset,
    required this.assetFrozen,
    required this.applicationID,
    required this.onCompletion,
    required this.applicationArgs,
    required this.accounts,
    required this.foreignAssets,
    required this.foreignApps,
    required this.access,
    required this.boxReferences,
    this.localStateSchema,
    this.globalStateSchema,
    required this.approvalProgram,
    required this.clearStateProgram,
    required this.extraProgramPages,
    required this.rejectVersion,
    required this.stateProofType,
    this.stateProof,
    this.message,
    required this.hbAddress,
    this.hbProof,
    required this.hbSeed,
    required this.hbVoteID,
    required this.hbKeyDilution,
    required this.hbChallengeDiscount,
  });

  factory AlgoTypesTransaction.deserializeJson(Map<String, dynamic> json) {
    return AlgoTypesTransaction(
      type: json.valueAsString(
        "type",
        bytesEncoding: StringEncoding.utf8,
        onMissing: () => '',
      ),
      sender: AlgoUtils.parseAddressOrDefault(json.valueAs("snd")),

      fee: json.valueAsBigInt("fee", onMissing: () => BigInt.zero),
      firstValid: json.valueAsBigInt("fv", onMissing: () => BigInt.zero),
      lastValid: json.valueAsBigInt("lv", onMissing: () => BigInt.zero),
      note: json.valueAsBytes(
        "note",
        encoding: StringEncoding.base64,
        onMissing: () => [],
      ),
      genesisID: json.valueAsString(
        "gen",
        bytesEncoding: StringEncoding.utf8,
        onMissing: () => '',
      ),
      genesisHash: json.valueAsBytes(
        "gh",
        encoding: StringEncoding.base64,
        onMissing: () => List<int>.filled(QuickCrypto.sha256DigestSize, 0),
      ),
      group: json.valueAsBytes(
        "grp",
        encoding: StringEncoding.base64,
        onMissing: () => List<int>.filled(QuickCrypto.sha256DigestSize, 0),
      ),
      lease: json.valueAsBytes(
        "lx",
        encoding: StringEncoding.base64,
        onMissing: () => [],
      ),
      rekeyTo: AlgoUtils.parseAddressOrDefault(json.valueAs("rekey")),

      votePK: json.valueAsBytes(
        "votekey",
        encoding: StringEncoding.base64,
        onMissing: () => List<int>.filled(Ed25519KeysConst.pubKeyByteLen, 0),
      ),
      selectionPK: json.valueAsBytes(
        "selkey",
        encoding: StringEncoding.base64,
        onMissing: () => List<int>.filled(Ed25519KeysConst.pubKeyByteLen, 0),
      ),
      stateProofPK: json.valueAsBytes(
        "sprfkey",
        encoding: StringEncoding.base64,
      ),
      voteFirst: json.valueAsBigInt("votefst", onMissing: () => BigInt.zero),
      voteLast: json.valueAsBigInt("votelst", onMissing: () => BigInt.zero),
      voteKeyDilution: json.valueAsBigInt(
        "votekd",
        onMissing: () => BigInt.zero,
      ),
      nonparticipation: json.valueAsBool("nonpart", onMissing: () => false),
      receiver: AlgoUtils.parseAddressOrDefault(json.valueAs("rcv")),

      amount: json.valueAsBigInt("amt", onMissing: () => BigInt.zero),
      closeRemainderTo: AlgoUtils.parseAddressOrDefault(json.valueAs("close")),

      configAsset: json.valueAsBigInt("caid", onMissing: () => BigInt.zero),
      assetParams: json.valueTo<AlgoTypesAssetParams?, Map>(
        key: "apar",
        parse:
            (e) => AlgoTypesAssetParams.deserializeJson(
              JsonParser.valueEnsureAsMap(e),
            ),
      ),
      xferAsset: json.valueAsBigInt("xaid", onMissing: () => BigInt.zero),
      assetAmount: json.valueAsBigInt("aamt", onMissing: () => BigInt.zero),
      assetSender: AlgoUtils.parseAddressOrDefault(json.valueAs("asnd")),

      assetReceiver: AlgoUtils.parseAddressOrDefault(json.valueAs("arcv")),

      assetCloseTo: AlgoUtils.parseAddressOrDefault(json.valueAs("aclose")),

      freezeAccount: AlgoUtils.parseAddressOrDefault(json.valueAs("fadd")),

      freezeAsset: json.valueAsBigInt("faid", onMissing: () => BigInt.zero),
      assetFrozen: json.valueAsBool("afrz", onMissing: () => false),
      applicationID: json.valueAsBigInt("apid", onMissing: () => BigInt.zero),
      onCompletion: json.valueTo<AlgoTypesOnCompletion, int>(
        key: "apan",
        parse: (e) => AlgoTypesOnCompletion.fromValue(e),
      ),
      applicationArgs: json.valueTo<List<List<int>>, List>(
        key: "apaa",
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
      accounts: json.valueTo<List<AlgoAddress>, List>(
        key: "apat",
        onMissing: () => [],
        parse: (e) => e.map(AlgoUtils.parseAddressOrDefault).toList(),
      ),
      foreignAssets: json.valueEnsureAsList<BigInt>(
        "apas",
        onMissing: () => [],
      ),
      foreignApps: json.valueEnsureAsList<BigInt>("apfa", onMissing: () => []),
      access: json.valueTo<List<AlgoTypesResourceRef>, List>(
        key: "al",
        onMissing: () => [],
        parse:
            (e) =>
                e
                    .map(
                      (x) => AlgoTypesResourceRef.deserializeJson(
                        JsonParser.valueEnsureAsMap(x),
                      ),
                    )
                    .toList(),
      ),
      boxReferences: json.valueTo<List<AlgoTypesBoxReference>, List>(
        key: "apbx",
        onMissing: () => [],
        parse:
            (e) =>
                e
                    .map(
                      (x) => AlgoTypesBoxReference.deserializeJson(
                        JsonParser.valueEnsureAsMap(x),
                      ),
                    )
                    .toList(),
      ),
      localStateSchema: json.valueTo<AlgoTypesStateSchema?, Map>(
        key: "apls",
        parse:
            (e) => AlgoTypesStateSchema.deserializeJson(
              JsonParser.valueEnsureAsMap(e),
            ),
      ),
      globalStateSchema: json.valueTo<AlgoTypesStateSchema?, Map>(
        key: "apgs",
        parse:
            (e) => AlgoTypesStateSchema.deserializeJson(
              JsonParser.valueEnsureAsMap(e),
            ),
      ),
      approvalProgram: json.valueAsBytes(
        "apap",
        encoding: StringEncoding.base64,
        onMissing: () => [],
      ),
      clearStateProgram: json.valueAsBytes(
        "apsu",
        encoding: StringEncoding.base64,
        onMissing: () => [],
      ),
      extraProgramPages: json.valueAsInt("apep", onMissing: () => 0),
      rejectVersion: json.valueAsBigInt("aprv", onMissing: () => BigInt.zero),
      stateProofType: json.valueTo<AlgoTypesStateProofType, int>(
        key: "sptype",
        parse: (e) => AlgoTypesStateProofType.fromValue(e),
      ),
      stateProof: json.valueTo<AlgoTypesStateProof?, Map>(
        key: "sp",
        parse:
            (e) => AlgoTypesStateProof.deserializeJson(
              JsonParser.valueEnsureAsMap(e),
            ),
      ),
      message: json.valueTo<AlgoTypesMessage?, Map>(
        key: "spmsg",
        parse:
            (e) => AlgoTypesMessage.deserializeJson(
              JsonParser.valueEnsureAsMap(e),
            ),
      ),
      hbAddress: AlgoUtils.parseAddressOrDefault(json.valueAs("a")),

      hbProof: json.valueTo<AlgoTypesHeartbeatProof?, Map>(
        key: "prf",
        parse:
            (e) => AlgoTypesHeartbeatProof.deserializeJson(
              JsonParser.valueEnsureAsMap(e),
            ),
      ),
      hbSeed: json.valueAsBytes(
        "sd",
        encoding: StringEncoding.base64,
        onMissing: () => List<int>.filled(QuickCrypto.sha256DigestSize, 0),
      ),
      hbVoteID: json.valueAsBytes(
        "vid",
        encoding: StringEncoding.base64,
        onMissing: () => List<int>.filled(Ed25519KeysConst.pubKeyByteLen, 0),
      ),
      hbKeyDilution: json.valueAsBigInt("kd", onMissing: () => BigInt.zero),
      hbChallengeDiscount: json.valueAsBool("c", onMissing: () => false),
    );
  }

  Map<String, dynamic> toMsgPack() {
    return {
      "type": type,
      "snd": sender,
      "fee": fee,
      "fv": firstValid,
      "lv": lastValid,
      "note": note,
      "gen": genesisID,
      "gh": genesisHash,
      "grp": group,
      "lx": lease,
      "rekey": rekeyTo,
      "votekey": votePK,
      "selkey": selectionPK,
      "sprfkey": stateProofPK,
      "votefst": voteFirst,
      "votelst": voteLast,
      "votekd": voteKeyDilution,
      "nonpart": nonparticipation,
      "rcv": receiver,
      "amt": amount,
      "close": closeRemainderTo,
      "caid": configAsset,
      "apar": assetParams?.toMsgPack(),
      "xaid": xferAsset,
      "aamt": assetAmount,
      "asnd": assetSender,
      "arcv": assetReceiver,
      "aclose": assetCloseTo,
      "fadd": freezeAccount,
      "faid": freezeAsset,
      "afrz": assetFrozen,
      "apid": applicationID,
      "apan": onCompletion.value,
      "apaa": applicationArgs,
      "apat": accounts,
      "apas": foreignAssets.map((e) => e).toList(),
      "apfa": foreignApps.map((e) => e).toList(),
      "al": access.map((e) => e.toMsgPack()).toList(),
      "apbx": boxReferences.map((e) => e.toMsgPack()).toList(),
      "apls": localStateSchema?.toMsgPack(),
      "apgs": globalStateSchema?.toMsgPack(),
      "apap": approvalProgram,
      "apsu": clearStateProgram,
      "apep": extraProgramPages,
      "aprv": rejectVersion,
      "sptype": stateProofType.value,
      "sp": stateProof?.toMsgPack(),
      "spmsg": message?.toSerializeJson(),
      "a": hbAddress,
      "prf": hbProof?.toMsgPack(),
      "sd": hbSeed,
      "vid": hbVoteID,
      "kd": hbKeyDilution,
      "c": hbChallengeDiscount,
    }.notNullValue;
  }
}

/// TxGroup describes a group of transactions that must appear together in a specific order in a block.
class AlgoTypesTxGroup with LayoutSerializable {
  /// TxGroupHashes specifies a list of hashes of transactions that must appear together, sequentially, in a block in order for the group to be valid.  Each hash in the list is a hash of a transaction with the `Group` field omitted.
  final List<List<int>> txGroupHashes;

  const AlgoTypesTxGroup({required this.txGroupHashes});

  factory AlgoTypesTxGroup.deserializeJson(Map<String, dynamic> json) {
    return AlgoTypesTxGroup(
      txGroupHashes: json.valueTo<List<List<int>>, List>(
        key: "txlist",
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
    );
  }

  static MsgPackFixedKeyDynamicLazyValueMapLayout<
    String,
    dynamic,
    LayoutRepository
  >
  layout({String? property}) {
    return MsgPackFixedKeyDynamicLazyValueMapLayout<
      String,
      dynamic,
      LayoutRepository
    >(
      keyLayout: MsgPackStringLayout(),
      sortKeys: true,
      valueLayouts: [
        MapEntry(
          "txlist",
          LazyMsgPackMapLayoutBuilder(
            layout: AlgoLayoutArray.defaultArrayOfBinary32Layout,
          ),
        ),
      ],
      property: property,
    );
  }

  @override
  Map<String, dynamic> toSerializeJson() {
    return {"txlist": txGroupHashes}.notNullValue;
  }

  @override
  Layout<Map<String, dynamic>> toLayout({String? property}) {
    return layout(property: property);
  }
}

/// A Txlease is a transaction (sender, lease) pair which uniquely specifies a transaction lease.
class AlgoTypesTxlease {
  final AlgoAddress sender;
  final List<int> lease;

  const AlgoTypesTxlease({required this.sender, required this.lease});

  factory AlgoTypesTxlease.fromJson(Map<String, dynamic> json) {
    return AlgoTypesTxlease(
      sender: AlgoUtils.parseAddressOrDefault(json.valueAs("Sender")),

      lease: json.valueAsBytes(
        "Lease",
        encoding: StringEncoding.base64,
        onMissing: () => [],
      ),
    );
  }

  Map<String, dynamic> toJson() {
    return {"Sender": sender, "Lease": lease}.notNullValue;
  }
}

/// TxnCommitments represents the commitments computed from the transactions in the block. It contains multiple commitments based on different algorithms and hash functions, to support different use cases.
class AlgoTypesTxnCommitments {
  /// Root of transaction Merkle tree using the SHA-512/256 hash function. This commitment is computed based on the PaysetCommit type specified in the block's consensus protocol.
  final List<int> nativeSha512256Commitment;

  /// Root of transaction vector commitment Merkle tree using the SHA-256 hash function.
  final List<int> sha256Commitment;

  /// Root of transaction vector commitment Merkle tree using the SHA-512 hash function.
  final List<int> sha512Commitment;

  const AlgoTypesTxnCommitments({
    required this.nativeSha512256Commitment,
    required this.sha256Commitment,
    required this.sha512Commitment,
  });

  factory AlgoTypesTxnCommitments.deserializeJson(Map<String, dynamic> json) {
    return AlgoTypesTxnCommitments(
      nativeSha512256Commitment: json.valueAsBytes(
        "txn",
        encoding: StringEncoding.base64,
        onMissing: () => List<int>.filled(QuickCrypto.sha256DigestSize, 0),
      ),
      sha256Commitment: json.valueAsBytes(
        "txn256",
        encoding: StringEncoding.base64,
        onMissing: () => List<int>.filled(QuickCrypto.sha256DigestSize, 0),
      ),
      sha512Commitment: json.valueAsBytes(
        "txn512",
        encoding: StringEncoding.base64,
        onMissing: () => List<int>.filled(QuickCrypto.sha512DigestLength, 0),
      ),
    );
  }

  Map<String, dynamic> toMsgPack() {
    return {
      "txn": nativeSha512256Commitment,
      "txn256": sha256Commitment,
      "txn512": sha512Commitment,
    }.notNullValue;
  }
}

/// UpgradeState tracks the protocol upgrade state machine.  It is, strictly speaking, computable from the history of all UpgradeVotes but we keep it in the block for explicitness and convenience (instead of materializing it separately, like balances).
class AlgoTypesUpgradeState {
  final String currentProtocol;
  final String nextProtocol;

  /// NextProtocolApprovals is the number of approvals for the next protocol proposal. It is expressed in Round because it is a count of rounds.
  final BigInt nextProtocolApprovals;

  /// NextProtocolVoteBefore specifies the last voting round for the next protocol proposal. If there is no voting for an upgrade taking place, this would be zero.
  final BigInt nextProtocolVoteBefore;

  /// NextProtocolSwitchOn specify the round number at which the next protocol would be adopted. If there is no upgrade taking place, nor a wait for the next protocol, this would be zero.
  final BigInt nextProtocolSwitchOn;

  const AlgoTypesUpgradeState({
    required this.currentProtocol,
    required this.nextProtocol,
    required this.nextProtocolApprovals,
    required this.nextProtocolVoteBefore,
    required this.nextProtocolSwitchOn,
  });

  factory AlgoTypesUpgradeState.deserializeJson(Map<String, dynamic> json) {
    return AlgoTypesUpgradeState(
      currentProtocol: json.valueAsString(
        "proto",
        bytesEncoding: StringEncoding.utf8,
        onMissing: () => '',
      ),
      nextProtocol: json.valueAsString(
        "nextproto",
        bytesEncoding: StringEncoding.utf8,
        onMissing: () => '',
      ),
      nextProtocolApprovals: json.valueAsBigInt(
        "nextyes",
        onMissing: () => BigInt.zero,
      ),
      nextProtocolVoteBefore: json.valueAsBigInt(
        "nextbefore",
        onMissing: () => BigInt.zero,
      ),
      nextProtocolSwitchOn: json.valueAsBigInt(
        "nextswitch",
        onMissing: () => BigInt.zero,
      ),
    );
  }

  Map<String, dynamic> toMsgPack() {
    return {
      "proto": currentProtocol,
      "nextproto": nextProtocol,
      "nextyes": nextProtocolApprovals,
      "nextbefore": nextProtocolVoteBefore,
      "nextswitch": nextProtocolSwitchOn,
    }.notNullValue;
  }
}

/// UpgradeVote represents the vote of the block proposer with respect to protocol upgrades.
class AlgoTypesUpgradeVote {
  /// UpgradePropose indicates a proposed upgrade
  final String upgradePropose;

  /// UpgradeDelay indicates the time between acceptance and execution
  final BigInt upgradeDelay;

  /// UpgradeApprove indicates a yes vote for the current proposal
  final bool upgradeApprove;

  const AlgoTypesUpgradeVote({
    required this.upgradePropose,
    required this.upgradeDelay,
    required this.upgradeApprove,
  });

  factory AlgoTypesUpgradeVote.deserializeJson(Map<String, dynamic> json) {
    return AlgoTypesUpgradeVote(
      upgradePropose: json.valueAsString(
        "upgradeprop",
        bytesEncoding: StringEncoding.utf8,
        onMissing: () => '',
      ),
      upgradeDelay: json.valueAsBigInt(
        "upgradedelay",
        onMissing: () => BigInt.zero,
      ),
      upgradeApprove: json.valueAsBool("upgradeyes", onMissing: () => false),
    );
  }

  Map<String, dynamic> toMsgPack() {
    return {
      "upgradeprop": upgradePropose,
      "upgradedelay": upgradeDelay,
      "upgradeyes": upgradeApprove,
    }.notNullValue;
  }
}

/// ValueDelta links a DeltaAction with a value to be set
class AlgoTypesValueDelta {
  final AlgoTypesDeltaAction action;
  final String bytes;
  final BigInt uint;

  const AlgoTypesValueDelta({
    required this.action,
    required this.bytes,
    required this.uint,
  });

  factory AlgoTypesValueDelta.deserializeJson(Map<String, dynamic> json) {
    return AlgoTypesValueDelta(
      action: json.valueTo<AlgoTypesDeltaAction, int>(
        key: "at",
        parse: (e) => AlgoTypesDeltaAction.fromValue(e),
      ),
      bytes: json.valueAsString(
        "bs",
        bytesEncoding: StringEncoding.utf8,
        onMissing: () => '',
      ),
      uint: json.valueAsBigInt("ui", onMissing: () => BigInt.zero),
    );
  }

  Map<String, dynamic> toMsgPack() {
    return {"at": action.value, "bs": bytes, "ui": uint}.notNullValue;
  }
}

/// Verifier is used to verify a merklesignature.Signature produced by merklesignature.Secrets.
class AlgoTypesVerifier {
  final List<int> commitment;
  final BigInt keyLifetime;

  const AlgoTypesVerifier({
    required this.commitment,
    required this.keyLifetime,
  });

  factory AlgoTypesVerifier.deserializeJson(Map<String, dynamic> json) {
    return AlgoTypesVerifier(
      commitment: json.valueAsBytes(
        "cmt",
        encoding: StringEncoding.base64,
        onMissing: () => List<int>.filled(QuickCrypto.sha512DigestLength, 0),
      ),
      keyLifetime: json.valueAsBigInt("lf", onMissing: () => BigInt.zero),
    );
  }

  Map<String, dynamic> toMsgPack() {
    return {"cmt": commitment, "lf": keyLifetime}.notNullValue;
  }
}

/// VotingData holds participation information
class AlgoTypesVotingData {
  final AlgoTypesOneTimeSignatureVerifier voteID;
  final AlgoTypesVRFVerifier selectionID;
  final List<int> stateProofID;
  final BigInt voteFirstValid;
  final BigInt voteLastValid;
  final BigInt voteKeyDilution;

  const AlgoTypesVotingData({
    required this.voteID,
    required this.selectionID,
    required this.stateProofID,
    required this.voteFirstValid,
    required this.voteLastValid,
    required this.voteKeyDilution,
  });

  factory AlgoTypesVotingData.fromJson(Map<String, dynamic> json) {
    return AlgoTypesVotingData(
      voteID: json.valueAsBytes(
        "VoteID",
        encoding: StringEncoding.base64,
        onMissing: () => [],
      ),
      selectionID: json.valueAsBytes(
        "SelectionID",
        encoding: StringEncoding.base64,
        onMissing: () => List<int>.filled(QuickCrypto.sha256DigestSize, 0),
      ),
      stateProofID: json.valueAsBytes(
        "StateProofID",
        encoding: StringEncoding.base64,
        onMissing: () => List<int>.filled(QuickCrypto.sha512DigestLength, 0),
      ),
      voteFirstValid: json.valueAsBigInt(
        "VoteFirstValid",
        onMissing: () => BigInt.zero,
      ),
      voteLastValid: json.valueAsBigInt(
        "VoteLastValid",
        onMissing: () => BigInt.zero,
      ),
      voteKeyDilution: json.valueAsBigInt(
        "VoteKeyDilution",
        onMissing: () => BigInt.zero,
      ),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "VoteID": voteID,
      "SelectionID": selectionID,
      "StateProofID": stateProofID,
      "VoteFirstValid": voteFirstValid,
      "VoteLastValid": voteLastValid,
      "VoteKeyDilution": voteKeyDilution,
    }.notNullValue;
  }
}
