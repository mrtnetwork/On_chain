import 'package:blockchain_utils/blockchain_utils.dart';

import 'package:on_chain/exception/onchain_error.dart';
import 'package:on_chain/tron/src/address/tron_address.dart';
import 'package:on_chain/tron/src/models/models.dart';
import 'package:on_chain/tron/src/proto_messages/protocol/models.dart';

import 'package:on_chain/tron/src/proto_messages/protocol/src/api.dart'
    as protocol_api;
import 'package:on_chain/tron/src/provider/models/types.dart';

class TronProviderUtils {
  static Map<K, V> decodeMap<K, V>(
    Object? obj,
    MapEntry<K, V> Function(Object? k, Object? v) keyMapper,
  ) {
    if (obj == null) return <K, V>{};
    if (obj is List) {
      final entries = JsonParser.valueEnsureAsList<Map<dynamic, dynamic>>(obj);
      return Map<K, V>.fromEntries(
        entries.map((e) => keyMapper(e.valueAs("key"), e.valueAs("value"))),
      );
    }
    return JsonParser.valueEnsureAsMap<dynamic, dynamic>(obj).map(keyMapper);
  }

  static T? _mapObject<T extends Object, N extends Object>(
    N? obj,
    T Function(N) on,
  ) {
    if (obj != null) return on(obj);
    return null;
  }

  static List<int>? _mapUtf8(String? data) {
    if (data == null) return null;
    return StringUtils.encode(data);
  }

  static List<int>? _mapHex(String? data) {
    if (data == null) return null;
    return StringUtils.encode(data, encoding: StringEncoding.hex);
  }

  static List<int>? _hexToBytes(String? data) {
    if (data == null) return null;
    return StringUtils.encode(data, encoding: StringEncoding.hex);
  }

  static List<int> _mapHexOrThrow(String? data) {
    return StringUtils.encode(data!, encoding: StringEncoding.hex);
  }

  static List<int>? _mapAddressToBytes(String? data) {
    if (data == null) return null;
    return TronAddress(data).toBytes();
  }

  static TronAddress? _mapAddress(String? data) {
    if (data == null) return null;
    return TronAddress(data);
  }

  static TronAddress _mapAddressOrThrow(String? data) {
    if (data == null) {
      throw BuError(
        OnChainErrorType.tronAddress,
        "Missing address in response data.",
      );
    }
    return TronAddress(data);
  }

  static Map<String, BigInt> _mapBigIntMap(Map<String, BigInt>? map) {
    return map ?? const {};
  }

  static BigInt _bigIntOrZero(BigInt? v) => v ?? BigInt.zero;
}

extension ExtKeyInt64StringCompatible on TronHttpKeyInt64StringCompatible {
  TronKey toKey() =>
      TronKey(address: TronProviderUtils._mapAddress(address), weight: weight);
}

extension ExtPermissionInt64StringCompatible
    on TronHttpPermissionInt64StringCompatible {
  TronPermission toPermission() => TronPermission(
    type: type?.toProtobuf(),
    id: id,
    permissionName: permissionName,
    threshold: threshold,
    parentId: parentId,
    operations: TronProviderUtils._hexToBytes(operations),
    keys: keys?.map((e) => e.toKey()).toList() ?? const [],
  );
}

extension ExtTronHttpPermissionType on TronHttpPermissionType {
  TronPermissionPermissionType toProtobuf() =>
      TronPermissionPermissionType.from(value);
}

extension ExtVoteInt64StringCompatible on TronHttpVoteInt64StringCompatible {
  TronVote toVote() => TronVote(
    voteAddress: TronProviderUtils._mapAddressToBytes(voteAddress),
    voteCount: voteCount,
  );
}

extension ExtVote on TronHttpVote {
  TronVote toVote() => TronVote(
    voteAddress: TronProviderUtils._mapAddressToBytes(voteAddress),
    voteCount: voteCount,
  );
}

// ---------------------------------------------------------------------------
// Account frozen / freeze-v2 / account-resource (nested)
// ---------------------------------------------------------------------------

extension ExtAccountFrozenInt64StringCompatible
    on TronHttpAccountFrozenInt64StringCompatible {
  TronAccountFrozen toAccountFrozen() =>
      TronAccountFrozen(frozenBalance: frozenBalance, expireTime: expireTime);
}

extension ExtAccountFrozen on TronHttpAccountFrozen {
  TronAccountFrozen toAccountFrozen() =>
      TronAccountFrozen(frozenBalance: frozenBalance, expireTime: expireTime);
}

extension ExtAccountFreezeV2Int64StringCompatible
    on TronHttpAccountFreezeV2Int64StringCompatible {
  TronAccountFreezeV2 toAccountFreezeV2() =>
      TronAccountFreezeV2(type: type?.toProtobuf(), amount: amount);
}

extension ExtAccountFreezeV2 on TronHttpAccountFreezeV2 {
  TronAccountFreezeV2 toAccountFreezeV2() =>
      TronAccountFreezeV2(type: type?.toProtobuf(), amount: amount);
}

extension ExtAccountUnFreezeV2Int64StringCompatible
    on TronHttpAccountUnFreezeV2Int64StringCompatible {
  TronAccountUnFreezeV2 toAccountUnFreezeV2() => TronAccountUnFreezeV2(
    type: type?.toProtobuf(),
    unfreezeAmount: unfreezeAmount,
    unfreezeExpireTime: unfreezeExpireTime,
  );
}

extension ExtAccountUnFreezeV2 on TronHttpAccountUnFreezeV2 {
  TronAccountUnFreezeV2 toAccountUnFreezeV2() => TronAccountUnFreezeV2(
    type: type?.toProtobuf(),
    unfreezeAmount: unfreezeAmount,
    unfreezeExpireTime: unfreezeExpireTime,
  );
}

extension ExtAccountAccountResourceInt64StringCompatible
    on TronHttpAccountAccountResourceInt64StringCompatible {
  TronAccountAccountResource toAccountResource() => TronAccountAccountResource(
    energyUsage: energyUsage,
    frozenBalanceForEnergy: TronProviderUtils._mapObject(
      frozenBalanceForEnergy,
      (f) => f.toAccountFrozen(),
    ),
    latestConsumeTimeForEnergy: latestConsumeTimeForEnergy,
    acquiredDelegatedFrozenBalanceForEnergy:
        acquiredDelegatedFrozenBalanceForEnergy,
    delegatedFrozenBalanceForEnergy: delegatedFrozenBalanceForEnergy,
    storageLimit: storageLimit,
    storageUsage: storageUsage,
    latestExchangeStorageTime: latestExchangeStorageTime,
    energyWindowSize: energyWindowSize,
    delegatedFrozenV2BalanceForEnergy: delegatedFrozenV2BalanceForEnergy,
    acquiredDelegatedFrozenV2BalanceForEnergy:
        acquiredDelegatedFrozenV2BalanceForEnergy,
    energyWindowOptimized: energyWindowOptimized,
  );
}

extension ExtAccountAccountResource on TronHttpAccountAccountResource {
  TronAccountAccountResource toAccountResource() => TronAccountAccountResource(
    energyUsage: energyUsage,
    frozenBalanceForEnergy: TronProviderUtils._mapObject(
      frozenBalanceForEnergy,
      (f) => f.toAccountFrozen(),
    ),
    latestConsumeTimeForEnergy: latestConsumeTimeForEnergy,
    acquiredDelegatedFrozenBalanceForEnergy:
        acquiredDelegatedFrozenBalanceForEnergy,
    delegatedFrozenBalanceForEnergy: delegatedFrozenBalanceForEnergy,
    storageLimit: storageLimit,
    storageUsage: storageUsage,
    latestExchangeStorageTime: latestExchangeStorageTime,
    energyWindowSize: energyWindowSize,
    delegatedFrozenV2BalanceForEnergy: delegatedFrozenV2BalanceForEnergy,
    acquiredDelegatedFrozenV2BalanceForEnergy:
        acquiredDelegatedFrozenV2BalanceForEnergy,
    energyWindowOptimized: energyWindowOptimized,
  );
}

// ---------------------------------------------------------------------------
// Account (main)
// ---------------------------------------------------------------------------

extension ExtAccountInt64StringCompatible
    on TronHttpAccountInt64StringCompatible {
  TronAccount toAccount() => TronAccount(
    accountName: TronProviderUtils._mapUtf8(accountName),
    type: type?.toProtobuf(),
    address: TronProviderUtils._mapAddressToBytes(address),
    balance: balance,
    votes: votes?.map((e) => e.toVote()).toList() ?? const [],
    asset: asset ?? {},
    assetV2: assetV2 ?? {},
    frozen: frozen?.map((e) => e.toAccountFrozen()).toList() ?? const [],
    netUsage: netUsage,
    acquiredDelegatedFrozenBalanceForBandwidth:
        acquiredDelegatedFrozenBalanceForBandwidth,
    delegatedFrozenBalanceForBandwidth: delegatedFrozenBalanceForBandwidth,
    oldTronPower: oldTronPower,
    tronPower: TronProviderUtils._mapObject(
      tronPower,
      (e) => e.toAccountFrozen(),
    ),
    assetOptimized: assetOptimized,
    createTime: createTime,
    latestOprationTime: latestOprationTime,
    allowance: allowance,
    latestWithdrawTime: latestWithdrawTime,
    code: TronProviderUtils._hexToBytes(code),
    isWitness: isWitness,
    isCommittee: isCommittee,
    frozenSupply:
        frozenSupply?.map((e) => e.toAccountFrozen()).toList() ?? const [],
    assetIssuedName: TronProviderUtils._mapUtf8(assetIssuedName),
    assetIssuedId: TronProviderUtils._mapUtf8(assetIssuedID),
    latestAssetOperationTime: latestAssetOperationTime ?? {},
    latestAssetOperationTimeV2: latestAssetOperationTimeV2 ?? {},
    freeNetUsage: freeNetUsage,
    freeAssetNetUsage: freeAssetNetUsage ?? {},
    freeAssetNetUsageV2: freeAssetNetUsageV2 ?? {},
    latestConsumeTime: latestConsumeTime,
    latestConsumeFreeTime: latestConsumeFreeTime,
    accountId: TronProviderUtils._mapUtf8(accountId),
    netWindowSize: netWindowSize,
    netWindowOptimized: netWindowOptimized,
    accountResource: TronProviderUtils._mapObject(
      accountResource,
      (e) => e.toAccountResource(),
    ),
    codeHash: TronProviderUtils._hexToBytes(codeHash),
    ownerPermission: TronProviderUtils._mapObject(
      ownerPermission,
      (e) => e.toPermission(),
    ),
    witnessPermission: TronProviderUtils._mapObject(
      witnessPermission,
      (e) => e.toPermission(),
    ),
    activePermission:
        activePermission?.map((e) => e.toPermission()).toList() ?? const [],
    frozenV2: frozenV2?.map((e) => e.toAccountFreezeV2()).toList() ?? const [],
    unfrozenV2:
        unfrozenV2?.map((e) => e.toAccountUnFreezeV2()).toList() ?? const [],
    delegatedFrozenV2BalanceForBandwidth: delegatedFrozenV2BalanceForBandwidth,
    acquiredDelegatedFrozenV2BalanceForBandwidth:
        acquiredDelegatedFrozenV2BalanceForBandwidth,
  );
}

extension ExtTronHttpAccountType on TronHttpAccountType {
  TronAccountType toProtobuf() => TronAccountType.from(value);
}

/// Plain (non int64-as-string) Account variant when present in responses.
extension ExtAccount on TronHttpAccount {
  TronAccount toAccount() => TronAccount(
    accountName: TronProviderUtils._hexToBytes(accountName),
    type: type?.toProtobuf(),
    address: TronProviderUtils._mapAddressToBytes(address),
    balance: balance,
    votes: votes?.map((e) => e.toVote()).toList() ?? const [],
    asset: TronProviderUtils._mapBigIntMap(asset),
    assetV2: TronProviderUtils._mapBigIntMap(assetV2),
    frozen: frozen?.map((e) => e.toAccountFrozen()).toList() ?? const [],
    netUsage: netUsage,
    acquiredDelegatedFrozenBalanceForBandwidth:
        acquiredDelegatedFrozenBalanceForBandwidth,
    delegatedFrozenBalanceForBandwidth: delegatedFrozenBalanceForBandwidth,
    oldTronPower: oldTronPower,
    tronPower: TronProviderUtils._mapObject(
      tronPower,
      (e) => e.toAccountFrozen(),
    ),
    assetOptimized: assetOptimized,
    createTime: createTime,
    latestOprationTime: latestOprationTime,
    allowance: allowance,
    latestWithdrawTime: latestWithdrawTime,
    code: TronProviderUtils._hexToBytes(code),
    isWitness: isWitness,
    isCommittee: isCommittee,
    frozenSupply:
        frozenSupply?.map((e) => e.toAccountFrozen()).toList() ?? const [],
    assetIssuedName: TronProviderUtils._hexToBytes(assetIssuedName),
    assetIssuedId: TronProviderUtils._mapUtf8(assetIssuedID),
    latestAssetOperationTime: TronProviderUtils._mapBigIntMap(
      latestAssetOperationTime,
    ),
    latestAssetOperationTimeV2: TronProviderUtils._mapBigIntMap(
      latestAssetOperationTimeV2,
    ),
    freeNetUsage: freeNetUsage,
    freeAssetNetUsage: TronProviderUtils._mapBigIntMap(freeAssetNetUsage),
    freeAssetNetUsageV2: TronProviderUtils._mapBigIntMap(freeAssetNetUsageV2),
    latestConsumeTime: latestConsumeTime,
    latestConsumeFreeTime: latestConsumeFreeTime,
    accountId: TronProviderUtils._hexToBytes(accountId),
    netWindowSize: netWindowSize,
    netWindowOptimized: netWindowOptimized,
    accountResource: TronProviderUtils._mapObject(
      accountResource,
      (e) => e.toAccountResource(),
    ),
    codeHash: TronProviderUtils._hexToBytes(codeHash),
    ownerPermission: TronProviderUtils._mapObject(
      ownerPermission,
      (e) => e.toPermission(),
    ),
    witnessPermission: TronProviderUtils._mapObject(
      witnessPermission,
      (e) => e.toPermission(),
    ),
    activePermission:
        activePermission?.map((e) => e.toPermission()).toList() ?? const [],
    frozenV2: frozenV2?.map((e) => e.toAccountFreezeV2()).toList() ?? const [],
    unfrozenV2:
        unfrozenV2?.map((e) => e.toAccountUnFreezeV2()).toList() ?? const [],
    delegatedFrozenV2BalanceForBandwidth: delegatedFrozenV2BalanceForBandwidth,
    acquiredDelegatedFrozenV2BalanceForBandwidth:
        acquiredDelegatedFrozenV2BalanceForBandwidth,
  );
}

// ---------------------------------------------------------------------------
// Account resource / net messages (getaccountresource, getaccountnet)
// ---------------------------------------------------------------------------

extension ExtAccountResourceMessageInt64StringCompatible
    on TronHttpAccountResourceMessageInt64StringCompatible {
  TronAccountResourceMessage toAccountResourceMessage() {
    return TronAccountResourceMessage(
      freeNetUsed: TronProviderUtils._bigIntOrZero(freeNetUsed),
      freeNetLimit: TronProviderUtils._bigIntOrZero(freeNetLimit),
      netUsed: TronProviderUtils._bigIntOrZero(netUsed),
      netLimit: TronProviderUtils._bigIntOrZero(netLimit),
      assetNetUsed: assetNetUsed ?? {},
      assetNetLimit: assetNetLimit ?? {},
      totalNetLimit: TronProviderUtils._bigIntOrZero(totalNetLimit),
      totalNetWeight: TronProviderUtils._bigIntOrZero(totalNetWeight),
      totalTronPowerWeight: TronProviderUtils._bigIntOrZero(
        totalTronPowerWeight,
      ),
      tronPowerUsed: TronProviderUtils._bigIntOrZero(tronPowerUsed),
      tronPowerLimit: TronProviderUtils._bigIntOrZero(tronPowerLimit),
      energyUsed: TronProviderUtils._bigIntOrZero(energyUsed),
      energyLimit: TronProviderUtils._bigIntOrZero(energyLimit),
      totalEnergyLimit: TronProviderUtils._bigIntOrZero(totalEnergyLimit),
      totalEnergyWeight: TronProviderUtils._bigIntOrZero(totalEnergyWeight),
      storageUsed: TronProviderUtils._bigIntOrZero(storageUsed),
      storageLimit: TronProviderUtils._bigIntOrZero(storageLimit),
    );
  }
}

extension ExtAccountResourceMessage on TronHttpAccountResourceMessage {
  TronAccountResourceMessage toAccountResourceMessage() {
    return TronAccountResourceMessage(
      freeNetUsed: TronProviderUtils._bigIntOrZero(freeNetUsed),
      freeNetLimit: TronProviderUtils._bigIntOrZero(freeNetLimit),
      netUsed: TronProviderUtils._bigIntOrZero(netUsed),
      netLimit: TronProviderUtils._bigIntOrZero(netLimit),
      assetNetUsed: TronProviderUtils._mapBigIntMap(assetNetUsed),
      assetNetLimit: TronProviderUtils._mapBigIntMap(assetNetLimit),
      totalNetLimit: TronProviderUtils._bigIntOrZero(totalNetLimit),
      totalNetWeight: TronProviderUtils._bigIntOrZero(totalNetWeight),
      totalTronPowerWeight: TronProviderUtils._bigIntOrZero(
        totalTronPowerWeight,
      ),
      tronPowerUsed: TronProviderUtils._bigIntOrZero(tronPowerUsed),
      tronPowerLimit: TronProviderUtils._bigIntOrZero(tronPowerLimit),
      energyUsed: TronProviderUtils._bigIntOrZero(energyUsed),
      energyLimit: TronProviderUtils._bigIntOrZero(energyLimit),
      totalEnergyLimit: TronProviderUtils._bigIntOrZero(totalEnergyLimit),
      totalEnergyWeight: TronProviderUtils._bigIntOrZero(totalEnergyWeight),
      storageUsed: TronProviderUtils._bigIntOrZero(storageUsed),
      storageLimit: TronProviderUtils._bigIntOrZero(storageLimit),
    );
  }
}

extension ExtAccountNetMessageInt64StringCompatible
    on TronHttpAccountNetMessageInt64StringCompatible {
  protocol_api.TronAccountNetMessage toAccountNetMessage() {
    return protocol_api.TronAccountNetMessage(
      freeNetUsed: freeNetUsed,
      freeNetLimit: freeNetLimit,
      netUsed: netUsed,
      netLimit: netLimit,
      assetNetUsed: assetNetUsed ?? {},
      assetNetLimit: assetNetLimit ?? {},
      totalNetLimit: totalNetLimit,
      totalNetWeight: totalNetWeight,
    );
  }
}

extension ExtAccountNetMessage on TronHttpAccountNetMessage {
  protocol_api.TronAccountNetMessage toAccountNetMessage() {
    return protocol_api.TronAccountNetMessage(
      freeNetUsed: freeNetUsed,
      freeNetLimit: freeNetLimit,
      netUsed: netUsed,
      netLimit: netLimit,
      assetNetUsed: TronProviderUtils._mapBigIntMap(assetNetUsed),
      assetNetLimit: TronProviderUtils._mapBigIntMap(assetNetLimit),
      totalNetLimit: totalNetLimit,
      totalNetWeight: totalNetWeight,
    );
  }
}

// ---------------------------------------------------------------------------
// Witness
// ---------------------------------------------------------------------------

extension ExtWitnessInt64StringCompatible
    on TronHttpWitnessInt64StringCompatible {
  TronWitness toWitness() => TronWitness(
    address: TronProviderUtils._mapAddressToBytes(address),
    voteCount: voteCount,
    pubKey: TronProviderUtils._hexToBytes(pubKey),
    url: url,
    totalProduced: totalProduced,
    totalMissed: totalMissed,
    latestBlockNum: latestBlockNum,
    latestSlotNum: latestSlotNum,
    isJobs: isJobs,
  );
}

extension ExtWitness on TronHttpWitness {
  TronWitness toWitness() => TronWitness(
    address: TronProviderUtils._mapAddressToBytes(address),
    voteCount: voteCount,
    pubKey: TronProviderUtils._hexToBytes(pubKey),
    url: url,
    totalProduced: totalProduced,
    totalMissed: totalMissed,
    latestBlockNum: latestBlockNum,
    latestSlotNum: latestSlotNum,
    isJobs: isJobs,
  );
}

extension ExtWitnessListInt64StringCompatible
    on TronHttpWitnessListInt64StringCompatible {
  protocol_api.TronWitnessList toWitnessList() => protocol_api.TronWitnessList(
    witnesses: witnesses?.map((e) => e.toWitness()).toList() ?? const [],
  );
}

extension ExtWitnessList on TronHttpWitnessList {
  protocol_api.TronWitnessList toWitnessList() => protocol_api.TronWitnessList(
    witnesses: witnesses?.map((e) => e.toWitness()).toList() ?? const [],
  );
}

// ---------------------------------------------------------------------------
// Chain parameters
// ---------------------------------------------------------------------------

extension ExtChainParametersChainParameterInt64StringCompatible
    on TronHttpChainParametersChainParameterInt64StringCompatible {
  TronChainParametersChainParameter toChainParameter() =>
      TronChainParametersChainParameter(key: key, value: value);
}

extension ExtChainParametersChainParameter
    on TronHttpChainParametersChainParameter {
  TronChainParametersChainParameter toChainParameter() =>
      TronChainParametersChainParameter(key: key, value: value);
}

extension ExtChainParametersInt64StringCompatible
    on TronHttpChainParametersInt64StringCompatible {
  TronChainParameters toChainParameters() => TronChainParameters(
    chainParameter:
        chainParameter?.map((e) => e.toChainParameter()).toList() ?? const [],
  );
}

extension ExtChainParameters on TronHttpChainParameters {
  TronChainParameters toChainParameters() => TronChainParameters(
    chainParameter:
        chainParameter?.map((e) => e.toChainParameter()).toList() ?? const [],
  );
}

// ---------------------------------------------------------------------------
// Delegated resource
// ---------------------------------------------------------------------------

extension ExtDelegatedResourceInt64StringCompatible
    on TronHttpDelegatedResourceInt64StringCompatible {
  TronDelegatedResource toDelegatedResource() => TronDelegatedResource(
    from: TronProviderUtils._mapAddressToBytes(from),
    to: TronProviderUtils._mapAddressToBytes(to),
    frozenBalanceForBandwidth: frozenBalanceForBandwidth,
    frozenBalanceForEnergy: frozenBalanceForEnergy,
    expireTimeForBandwidth: expireTimeForBandwidth,
    expireTimeForEnergy: expireTimeForEnergy,
  );
}

extension ExtDelegatedResource on TronHttpDelegatedResource {
  TronDelegatedResource toDelegatedResource() => TronDelegatedResource(
    from: TronProviderUtils._mapAddressToBytes(from),
    to: TronProviderUtils._mapAddressToBytes(to),
    frozenBalanceForBandwidth: frozenBalanceForBandwidth,
    frozenBalanceForEnergy: frozenBalanceForEnergy,
    expireTimeForBandwidth: expireTimeForBandwidth,
    expireTimeForEnergy: expireTimeForEnergy,
  );
}

extension ExtDelegatedResourceListInt64StringCompatible
    on TronHttpDelegatedResourceListInt64StringCompatible {
  protocol_api.TronDelegatedResourceList toDelegatedResourceList() =>
      protocol_api.TronDelegatedResourceList(
        delegatedResource:
            delegatedResource?.map((e) => e.toDelegatedResource()).toList() ??
            const [],
      );
}

extension ExtDelegatedResourceList on TronHttpDelegatedResourceList {
  protocol_api.TronDelegatedResourceList toDelegatedResourceList() =>
      protocol_api.TronDelegatedResourceList(
        delegatedResource:
            delegatedResource?.map((e) => e.toDelegatedResource()).toList() ??
            const [],
      );
}

extension ExtDelegatedResourceAccountIndexInt64StringCompatible
    on TronHttpDelegatedResourceAccountIndexInt64StringCompatible {
  TronDelegatedResourceAccountIndex toDelegatedResourceAccountIndex() =>
      TronDelegatedResourceAccountIndex(
        account: TronProviderUtils._mapAddressToBytes(account),
        fromAccounts:
            fromAccounts
                ?.map(TronProviderUtils._mapAddressToBytes)
                .whereType<List<int>>()
                .toList() ??
            const [],
        toAccounts:
            toAccounts
                ?.map(TronProviderUtils._mapAddressToBytes)
                .whereType<List<int>>()
                .toList() ??
            const [],
        timestamp: timestamp,
      );
}

extension ExtDelegatedResourceAccountIndex
    on TronHttpDelegatedResourceAccountIndex {
  TronDelegatedResourceAccountIndex toDelegatedResourceAccountIndex() =>
      TronDelegatedResourceAccountIndex(
        account: TronProviderUtils._mapAddressToBytes(account),
        fromAccounts:
            fromAccounts
                ?.map(TronProviderUtils._mapAddressToBytes)
                .whereType<List<int>>()
                .toList() ??
            const [],
        toAccounts:
            toAccounts
                ?.map(TronProviderUtils._mapAddressToBytes)
                .whereType<List<int>>()
                .toList() ??
            const [],
        timestamp: timestamp,
      );
}

// ---------------------------------------------------------------------------
// Can-delegate / can-withdraw / available unfreeze responses
// ---------------------------------------------------------------------------

extension ExtCanDelegatedMaxSizeResponseMessageInt64StringCompatible
    on TronHttpCanDelegatedMaxSizeResponseMessageInt64StringCompatible {
  protocol_api.TronCanDelegatedMaxSizeResponseMessage toProtobuf() =>
      protocol_api.TronCanDelegatedMaxSizeResponseMessage(maxSize: maxSize);
}

extension ExtCanDelegatedMaxSizeResponseMessage
    on TronHttpCanDelegatedMaxSizeResponseMessage {
  protocol_api.TronCanDelegatedMaxSizeResponseMessage toProtobuf() =>
      protocol_api.TronCanDelegatedMaxSizeResponseMessage(maxSize: maxSize);
}

extension ExtCanWithdrawUnfreezeAmountResponseMessageInt64StringCompatible
    on TronHttpCanWithdrawUnfreezeAmountResponseMessageInt64StringCompatible {
  protocol_api.TronCanWithdrawUnfreezeAmountResponseMessage toProtobuf() =>
      protocol_api.TronCanWithdrawUnfreezeAmountResponseMessage(amount: amount);
}

extension ExtCanWithdrawUnfreezeAmountResponseMessage
    on TronHttpCanWithdrawUnfreezeAmountResponseMessage {
  protocol_api.TronCanWithdrawUnfreezeAmountResponseMessage toProtobuf() =>
      protocol_api.TronCanWithdrawUnfreezeAmountResponseMessage(amount: amount);
}

extension ExtGetAvailableUnfreezeCountResponseMessageInt64StringCompatible
    on TronHttpGetAvailableUnfreezeCountResponseMessageInt64StringCompatible {
  protocol_api.TronGetAvailableUnfreezeCountResponseMessage toProtobuf() =>
      protocol_api.TronGetAvailableUnfreezeCountResponseMessage(count: count);
}

extension ExtGetAvailableUnfreezeCountResponseMessage
    on TronHttpGetAvailableUnfreezeCountResponseMessage {
  protocol_api.TronGetAvailableUnfreezeCountResponseMessage toProtobuf() =>
      protocol_api.TronGetAvailableUnfreezeCountResponseMessage(count: count);
}

// ---------------------------------------------------------------------------
// Prices / burn / brokerage simple responses (when typed)
// ---------------------------------------------------------------------------

extension ExtPricesResponseMessage on TronHttpPricesResponseMessage {
  protocol_api.TronPricesResponseMessage toProtobuf() =>
      protocol_api.TronPricesResponseMessage(prices: prices);
}

extension ExtNumberMessageInt64StringCompatible
    on TronHttpNumberMessageInt64StringCompatible {
  protocol_api.TronNumberMessage toProtobuf() =>
      protocol_api.TronNumberMessage(num: num_);
}

extension ExtNumberMessage on TronHttpNumberMessage {
  protocol_api.TronNumberMessage toProtobuf() =>
      protocol_api.TronNumberMessage(num: num_);
}

// ---------------------------------------------------------------------------
// Plain Permission / Key (used by plain Account)
// ---------------------------------------------------------------------------

extension ExtKey on TronHttpKey {
  TronKey toKey() =>
      TronKey(address: TronProviderUtils._mapAddress(address), weight: weight);
}

extension ExtPermission on TronHttpPermission {
  TronPermission toPermission() => TronPermission(
    type: type?.toProtobuf(),
    id: id,
    permissionName: permissionName,
    threshold: threshold,
    parentId: parentId,
    operations: TronProviderUtils._hexToBytes(operations),
    keys: keys?.map((e) => e.toKey()).toList() ?? const [],
  );
}

// ---------------------------------------------------------------------------
// Authority / AccountId
// ---------------------------------------------------------------------------

extension ExtAccountId on TronHttpAccountId {
  TronAccountId toAccountId() => TronAccountId(
    name: TronProviderUtils._mapUtf8(name),
    address: TronProviderUtils._mapAddressToBytes(address),
  );
}

extension ExtAuthority on TronHttpAuthority {
  TronAuthority toAuthority() => TronAuthority(
    account: TronProviderUtils._mapObject(account, (e) => e.toAccountId()),
    permissionName: TronProviderUtils._mapUtf8(permissionName),
  );
}

// ---------------------------------------------------------------------------
// Transaction result / raw / contract / transaction
// ---------------------------------------------------------------------------

extension ExtTransactionResultRet on TronHttpTransactionResultRet {
  TronTransactionResultcode toProtobuf() =>
      TronTransactionResultcode.from(value);
}

extension ExtTransactionResultContractRet
    on TronHttpTransactionResultContractRet {
  TronTransactionResultcontractResult toProtobuf() =>
      TronTransactionResultcontractResult.from(value);
}

extension ExtTronHttpMarketOrderDetailInt64StringCompatible
    on TronHttpMarketOrderDetailInt64StringCompatible {
  TronMarketOrderDetail toProtobuf() => TronMarketOrderDetail(
    fillBuyQuantity: fillBuyQuantity,
    fillSellQuantity: fillSellQuantity,
    makerOrderId: TronProviderUtils._hexToBytes(makerOrderId),
    takerOrderId: TronProviderUtils._hexToBytes(takerOrderId),
  );
}

extension ExtTransactionResultInt64StringCompatible
    on TronHttpTransactionResultInt64StringCompatible {
  TronTransactionResult toTransactionResult() => TronTransactionResult(
    fee: fee,
    ret: ret?.toProtobuf(),
    contractRet: contractRet?.toProtobuf(),
    assetIssueID: assetIssueID,
    withdrawAmount: withdrawAmount,
    unfreezeAmount: unfreezeAmount,
    exchangeReceivedAmount: exchangeReceivedAmount,
    exchangeInjectAnotherAmount: exchangeInjectAnotherAmount,
    exchangeWithdrawAnotherAmount: exchangeWithdrawAnotherAmount,
    exchangeId: exchangeId,
    shieldedTransactionFee: shieldedTransactionFee,
    orderId: TronProviderUtils._mapHex(orderId),
    orderDetails: orderDetails?.map((e) => e.toProtobuf()).toList() ?? [],
    withdrawExpireAmount: withdrawExpireAmount,
    cancelUnfreezeV2Amount: cancelUnfreezeV2Amount ?? {},
  );
}

extension ExtTransactionResult on TronHttpTransactionResult {
  TronTransactionResult toTransactionResult() => TronTransactionResult(
    fee: fee,
    ret: ret?.toProtobuf(),
    contractRet: contractRet?.toProtobuf(),
    assetIssueID: assetIssueID,
    withdrawAmount: withdrawAmount,
    unfreezeAmount: unfreezeAmount,
    exchangeReceivedAmount: exchangeReceivedAmount,
    exchangeInjectAnotherAmount: exchangeInjectAnotherAmount,
    exchangeWithdrawAnotherAmount: exchangeWithdrawAnotherAmount,
    exchangeId: exchangeId,
    shieldedTransactionFee: shieldedTransactionFee,
    orderId: TronProviderUtils._mapHex(orderId),
    orderDetails: const [],
    withdrawExpireAmount: withdrawExpireAmount,
    cancelUnfreezeV2Amount: TronProviderUtils._mapBigIntMap(
      cancelUnfreezeV2Amount,
    ),
  );
}

extension ExtTransferContract on TronHttpTransferContract {
  TronTransferContract toContract() => TronTransferContract(
    ownerAddress: TronProviderUtils._mapAddressOrThrow(ownerAddress),
    toAddress: TronProviderUtils._mapAddressOrThrow(toAddress),
    amount: amount,
  );
}

extension ExtTransferContractInt64StringCompatible
    on TronHttpTransferContractInt64StringCompatible {
  TronTransferContract toContract() => TronTransferContract(
    ownerAddress: TronProviderUtils._mapAddressOrThrow(ownerAddress),
    toAddress: TronProviderUtils._mapAddressOrThrow(toAddress),
    amount: amount,
  );
}

extension ExtTransferAssetContract on TronHttpTransferAssetContract {
  TronTransferAssetContract toContract() => TronTransferAssetContract(
    assetName: TronProviderUtils._mapUtf8(assetName),
    ownerAddress: TronProviderUtils._mapAddressOrThrow(ownerAddress),
    toAddress: TronProviderUtils._mapAddress(toAddress),
    amount: amount,
  );
}

extension ExtTransferAssetContractInt64StringCompatible
    on TronHttpTransferAssetContractInt64StringCompatible {
  TronTransferAssetContract toContract() => TronTransferAssetContract(
    assetName: TronProviderUtils._mapUtf8(assetName),
    ownerAddress: TronProviderUtils._mapAddressOrThrow(ownerAddress),
    toAddress: TronProviderUtils._mapAddress(toAddress),
    amount: amount,
  );
}

extension ExtFreezeBalanceContract on TronHttpFreezeBalanceContract {
  TronFreezeBalanceContract toContract() => TronFreezeBalanceContract(
    ownerAddress: TronProviderUtils._mapAddressOrThrow(ownerAddress),
    frozenBalance: frozenBalance,
    frozenDuration: frozenDuration,
    resource: resource?.toProtobuf(),
    receiverAddress: TronProviderUtils._mapAddress(receiverAddress),
  );
}

extension ExtFreezeBalanceV2Contract on TronHttpFreezeBalanceV2Contract {
  TronFreezeBalanceV2Contract toContract() => TronFreezeBalanceV2Contract(
    ownerAddress: TronProviderUtils._mapAddressOrThrow(ownerAddress),
    frozenBalance: frozenBalance,
    resource: resource?.toProtobuf(),
  );
}

extension ExtUnfreezeBalanceContract on TronHttpUnfreezeBalanceContract {
  TronUnfreezeBalanceContract toContract() => TronUnfreezeBalanceContract(
    ownerAddress: TronProviderUtils._mapAddressOrThrow(ownerAddress),
    resource: resource?.toProtobuf(),
    receiverAddress: TronProviderUtils._mapAddress(receiverAddress),
  );
}

extension ExtUnfreezeBalanceV2Contract on TronHttpUnfreezeBalanceV2Contract {
  TronUnfreezeBalanceV2Contract toContract() => TronUnfreezeBalanceV2Contract(
    ownerAddress: TronProviderUtils._mapAddressOrThrow(ownerAddress),
    unfreezeBalance: unfreezeBalance,
    resource: resource?.toProtobuf(),
  );
}

extension ExtDelegateResourceContract on TronHttpDelegateResourceContract {
  TronDelegateResourceContract toContract() => TronDelegateResourceContract(
    ownerAddress: TronProviderUtils._mapAddressOrThrow(ownerAddress),
    resource: resource?.toProtobuf(),
    balance: balance,
    receiverAddress: TronProviderUtils._mapAddress(receiverAddress),
    lock: lock,
    lockPeriod: lockPeriod,
  );
}

extension ExtUnDelegateResourceContract on TronHttpUnDelegateResourceContract {
  TronUnDelegateResourceContract toContract() => TronUnDelegateResourceContract(
    ownerAddress: TronProviderUtils._mapAddressOrThrow(ownerAddress),
    resource: resource?.toProtobuf(),
    balance: balance,
    receiverAddress: TronProviderUtils._mapAddress(receiverAddress),
  );
}

extension ExtAccountCreateContract on TronHttpAccountCreateContract {
  TronAccountCreateContract toContract() => TronAccountCreateContract(
    ownerAddress: TronProviderUtils._mapAddressOrThrow(ownerAddress),
    accountAddress: TronProviderUtils._mapAddressOrThrow(accountAddress),
    type: type?.toProtobuf(),
  );
}

extension ExtAccountUpdateContract on TronHttpAccountUpdateContract {
  TronAccountUpdateContract toContract() => TronAccountUpdateContract(
    accountName: TronProviderUtils._mapUtf8(accountName),
    ownerAddress: TronProviderUtils._mapAddressOrThrow(ownerAddress),
  );
}

extension ExtAccountPermissionUpdateContract
    on TronHttpAccountPermissionUpdateContract {
  TronAccountPermissionUpdateContract toContract() =>
      TronAccountPermissionUpdateContract(
        ownerAddress: TronProviderUtils._mapAddressOrThrow(ownerAddress),
        owner: TronProviderUtils._mapObject(owner, (e) => e.toPermission()),
        witness: TronProviderUtils._mapObject(witness, (e) => e.toPermission()),
        actives: actives?.map((e) => e.toPermission()).toList() ?? const [],
      );
}

extension ExtWithdrawBalanceContract on TronHttpWithdrawBalanceContract {
  TronWithdrawBalanceContract toContract() => TronWithdrawBalanceContract(
    ownerAddress: TronProviderUtils._mapAddressOrThrow(ownerAddress),
  );
}

extension ExtWithdrawExpireUnfreezeContract
    on TronHttpWithdrawExpireUnfreezeContract {
  TronWithdrawExpireUnfreezeContract toContract() =>
      TronWithdrawExpireUnfreezeContract(
        ownerAddress: TronProviderUtils._mapAddressOrThrow(ownerAddress),
      );
}

extension ExtCancelAllUnfreezeV2Contract
    on TronHttpCancelAllUnfreezeV2Contract {
  TronCancelAllUnfreezeV2Contract toContract() =>
      TronCancelAllUnfreezeV2Contract(
        ownerAddress: TronProviderUtils._mapAddressOrThrow(ownerAddress),
      );
}

extension ExtTriggerSmartContract on TronHttpTriggerSmartContract {
  TronTriggerSmartContract toContract() => TronTriggerSmartContract(
    ownerAddress: TronProviderUtils._mapAddressOrThrow(ownerAddress),
    contractAddress: TronProviderUtils._mapAddress(contractAddress),
    callValue: callValue,
    data: TronProviderUtils._hexToBytes(data),
    callTokenValue: callTokenValue,
    tokenId: tokenId,
  );
}

extension ExtTriggerSmartContractInt64StringCompatible
    on TronHttpTriggerSmartContractInt64StringCompatible {
  TronTriggerSmartContract toContract() => TronTriggerSmartContract(
    ownerAddress: TronProviderUtils._mapAddressOrThrow(ownerAddress),
    contractAddress: TronProviderUtils._mapAddress(contractAddress),
    callValue: callValue,
    data: TronProviderUtils._hexToBytes(data),
    callTokenValue: callTokenValue,
    tokenId: tokenId,
  );
}

extension ExtVoteWitnessContractVote on TronHttpVoteWitnessContractVote {
  TronVoteWitnessContractVote toVote() => TronVoteWitnessContractVote(
    voteAddress: TronProviderUtils._mapAddress(voteAddress),
    voteCount: voteCount,
  );
}

extension ExtVoteWitnessContract on TronHttpVoteWitnessContract {
  TronVoteWitnessContract toContract() => TronVoteWitnessContract(
    ownerAddress: TronProviderUtils._mapAddressOrThrow(ownerAddress),
    votes: votes?.map((e) => e.toVote()).toList() ?? const [],
  );
}

extension ExtWitnessCreateContract on TronHttpWitnessCreateContract {
  TronWitnessCreateContract toContract() => TronWitnessCreateContract(
    ownerAddress: TronProviderUtils._mapAddressOrThrow(ownerAddress),
    url: TronProviderUtils._mapUtf8(url),
  );
}

extension ExtWitnessUpdateContract on TronHttpWitnessUpdateContract {
  TronWitnessUpdateContract toContract() => TronWitnessUpdateContract(
    ownerAddress: TronProviderUtils._mapAddressOrThrow(ownerAddress),
    updateUrl: TronProviderUtils._mapUtf8(updateUrl),
  );
}

extension ExtUpdateBrokerageContract on TronHttpUpdateBrokerageContract {
  TronUpdateBrokerageContract toContract() => TronUpdateBrokerageContract(
    ownerAddress: TronProviderUtils._mapAddressOrThrow(ownerAddress),
    brokerage: brokerage,
  );
}

extension ExtUpdateEnergyLimitContract on TronHttpUpdateEnergyLimitContract {
  TronUpdateEnergyLimitContract toContract() => TronUpdateEnergyLimitContract(
    ownerAddress: TronProviderUtils._mapAddressOrThrow(ownerAddress),
    contractAddress: TronProviderUtils._mapAddress(contractAddress),
    originEnergyLimit: originEnergyLimit,
  );
}

extension ExtUpdateSettingContract on TronHttpUpdateSettingContract {
  TronUpdateSettingContract toContract() => TronUpdateSettingContract(
    ownerAddress: TronProviderUtils._mapAddressOrThrow(ownerAddress),
    contractAddress: TronProviderUtils._mapAddress(contractAddress),
    consumeUserResourcePercent: consumeUserResourcePercent,
  );
}

extension ExtClearABIContract on TronHttpClearABIContract {
  TronClearABIContract toContract() => TronClearABIContract(
    ownerAddress: TronProviderUtils._mapAddressOrThrow(ownerAddress),
    contractAddress: TronProviderUtils._mapAddress(contractAddress),
  );
}

extension ExtSetAccountIdContract on TronHttpSetAccountIdContract {
  TronSetAccountIdContract toContract() => TronSetAccountIdContract(
    accountId: TronProviderUtils._mapUtf8(accountId),
    ownerAddress: TronProviderUtils._mapAddressOrThrow(ownerAddress),
  );
}

extension ExtProposalCreateContract on TronHttpProposalCreateContract {
  TronProposalCreateContract toContract() => TronProposalCreateContract(
    ownerAddress: TronProviderUtils._mapAddressOrThrow(ownerAddress),
    parameters:
        parameters?.map((k, v) => MapEntry(JsonParser.valueAsBigInt(k), v)) ??
        {},
  );
}

extension ExtProposalApproveContract on TronHttpProposalApproveContract {
  TronProposalApproveContract toContract() => TronProposalApproveContract(
    ownerAddress: TronProviderUtils._mapAddressOrThrow(ownerAddress),
    proposalId: proposalId,
    isAddApproval: isAddApproval,
  );
}

extension ExtProposalDeleteContract on TronHttpProposalDeleteContract {
  TronProposalDeleteContract toContract() => TronProposalDeleteContract(
    ownerAddress: TronProviderUtils._mapAddressOrThrow(ownerAddress),
    proposalId: proposalId,
  );
}

extension ExtExchangeCreateContract on TronHttpExchangeCreateContract {
  TronExchangeCreateContract toContract() => TronExchangeCreateContract(
    ownerAddress: TronProviderUtils._mapAddressOrThrow(ownerAddress),
    firstTokenId: TronProviderUtils._mapUtf8(firstTokenId),
    firstTokenBalance: firstTokenBalance,
    secondTokenId: TronProviderUtils._mapUtf8(secondTokenId),
    secondTokenBalance: secondTokenBalance,
  );
}

extension ExtExchangeInjectContract on TronHttpExchangeInjectContract {
  TronExchangeInjectContract toContract() => TronExchangeInjectContract(
    ownerAddress: TronProviderUtils._mapAddressOrThrow(ownerAddress),
    exchangeId: exchangeId,
    tokenId: TronProviderUtils._mapUtf8(tokenId),
    quant: quant,
  );
}

extension ExtExchangeWithdrawContract on TronHttpExchangeWithdrawContract {
  TronExchangeWithdrawContract toContract() => TronExchangeWithdrawContract(
    ownerAddress: TronProviderUtils._mapAddressOrThrow(ownerAddress),
    exchangeId: exchangeId,
    tokenId: TronProviderUtils._mapUtf8(tokenId),
    quant: quant,
  );
}

extension ExtExchangeTransactionContract
    on TronHttpExchangeTransactionContract {
  TronExchangeTransactionContract toContract() =>
      TronExchangeTransactionContract(
        ownerAddress: TronProviderUtils._mapAddressOrThrow(ownerAddress),
        exchangeId: exchangeId,
        tokenId: TronProviderUtils._mapUtf8(tokenId),
        quant: quant,
        expected: expected,
      );
}

extension ExtMarketCancelOrderContract on TronHttpMarketCancelOrderContract {
  TronMarketCancelOrderContract toContract() => TronMarketCancelOrderContract(
    ownerAddress: TronProviderUtils._mapAddressOrThrow(ownerAddress),
    orderId: TronProviderUtils._mapHex(orderId),
  );
}

extension ExtMarketSellAssetContract on TronHttpMarketSellAssetContract {
  TronMarketSellAssetContract toContract() => TronMarketSellAssetContract(
    ownerAddress: TronProviderUtils._mapAddressOrThrow(ownerAddress),
    sellTokenId: TronProviderUtils._mapUtf8(sellTokenId),
    sellTokenQuantity: sellTokenQuantity,
    buyTokenId: TronProviderUtils._mapUtf8(buyTokenId),
    buyTokenQuantity: buyTokenQuantity,
  );
}

extension ExtUnfreezeAssetContract on TronHttpUnfreezeAssetContract {
  TronUnfreezeAssetContract toContract() => TronUnfreezeAssetContract(
    ownerAddress: TronProviderUtils._mapAddressOrThrow(ownerAddress),
  );
}

extension ExtParticipateAssetIssueContract
    on TronHttpParticipateAssetIssueContract {
  TronParticipateAssetIssueContract toContract() =>
      TronParticipateAssetIssueContract(
        ownerAddress: TronProviderUtils._mapAddressOrThrow(ownerAddress),
        toAddress: TronProviderUtils._mapAddress(toAddress),
        assetName: TronProviderUtils._mapUtf8(assetName),
        amount: amount,
      );
}

extension ExtUpdateAssetContract on TronHttpUpdateAssetContract {
  TronUpdateAssetContract toContract() => TronUpdateAssetContract(
    ownerAddress: TronProviderUtils._mapAddressOrThrow(ownerAddress),
    description: TronProviderUtils._mapUtf8(description),
    url: TronProviderUtils._mapUtf8(url),
    newLimit: newLimit,
    newPublicLimit: newPublicLimit,
  );
}

extension ExtAssetIssueContractFrozenSupply
    on TronHttpAssetIssueContractFrozenSupply {
  TronAssetIssueContractFrozenSupply toFrozenSupply() =>
      TronAssetIssueContractFrozenSupply(
        frozenAmount: frozenAmount,
        frozenDays: frozenDays,
      );
}

extension ExtAssetIssueContractFrozenSupplyInt64StringCompatible
    on TronHttpAssetIssueContractFrozenSupplyInt64StringCompatible {
  TronAssetIssueContractFrozenSupply toFrozenSupply() =>
      TronAssetIssueContractFrozenSupply(
        frozenAmount: frozenAmount,
        frozenDays: frozenDays,
      );
}

extension ExtAssetIssueContractInt64StringCompatible
    on TronHttpAssetIssueContractInt64StringCompatible {
  TronAssetIssueContract toAssetIssueContract() => TronAssetIssueContract(
    id: id,
    ownerAddress: TronProviderUtils._mapAddressOrThrow(ownerAddress),
    name: TronProviderUtils._mapUtf8(name),
    abbr: TronProviderUtils._mapUtf8(abbr),
    totalSupply: totalSupply,
    frozenSupply:
        frozenSupply?.map((e) => e.toFrozenSupply()).toList() ?? const [],
    trxNum: trxNum,
    precision: precision,
    num: num_,
    startTime: startTime,
    endTime: endTime,
    order: order,
    voteScore: voteScore,
    description: TronProviderUtils._mapUtf8(description),
    url: TronProviderUtils._mapUtf8(url),
    freeAssetNetLimit: freeAssetNetLimit,
    publicFreeAssetNetLimit: publicFreeAssetNetLimit,
    publicFreeAssetNetUsage: publicFreeAssetNetUsage,
    publicLatestFreeNetTime: publicLatestFreeNetTime,
  );
}

extension ExtAssetIssueContract on TronHttpAssetIssueContract {
  TronAssetIssueContract toAssetIssueContract() => TronAssetIssueContract(
    id: id,
    ownerAddress: TronProviderUtils._mapAddressOrThrow(ownerAddress),
    name: TronProviderUtils._mapUtf8(name),
    abbr: TronProviderUtils._mapUtf8(abbr),
    totalSupply: totalSupply,
    frozenSupply:
        frozenSupply?.map((e) => e.toFrozenSupply()).toList() ?? const [],
    trxNum: trxNum,
    precision: precision,
    num: num_,
    startTime: startTime,
    endTime: endTime,
    order: order,
    voteScore: voteScore,
    description: TronProviderUtils._mapUtf8(description),
    url: TronProviderUtils._mapUtf8(url),
    freeAssetNetLimit: freeAssetNetLimit,
    publicFreeAssetNetLimit: publicFreeAssetNetLimit,
    publicFreeAssetNetUsage: publicFreeAssetNetUsage,
    publicLatestFreeNetTime: publicLatestFreeNetTime,
  );
}

extension ExtSmartContractABIEntryParam on TronHttpSmartContractABIEntryParam {
  TronSmartContractABIEntryParam toParam() =>
      TronSmartContractABIEntryParam(indexed: indexed, name: name, type: type);
}

extension ExtSmartContractABIEntry on TronHttpSmartContractABIEntry {
  TronSmartContractABIEntry toEntry() => TronSmartContractABIEntry(
    anonymous: anonymous,
    constant: constant,
    name: name,
    inputs: inputs?.map((e) => e.toParam()).toList() ?? const [],
    outputs: outputs?.map((e) => e.toParam()).toList() ?? const [],
    type:
        type == null
            ? null
            : TronSmartContractABIEntryEntryType.from(type!.value),
    payable: payable,
    stateMutability:
        stateMutability == null
            ? null
            : TronSmartContractABIEntryStateMutabilityType.from(
              stateMutability!.value,
            ),
  );
}

extension ExtSmartContractABI on TronHttpSmartContractABI {
  TronSmartContractABI toAbi() => TronSmartContractABI(
    entrys: entrys?.map((e) => e.toEntry()).toList() ?? const [],
  );
}

extension ExtSmartContractInt64StringCompatible
    on TronHttpSmartContractInt64StringCompatible {
  TronSmartContract toSmartContract() => TronSmartContract(
    originAddress: TronProviderUtils._mapAddress(originAddress),
    contractAddress: TronProviderUtils._mapAddress(contractAddress),
    abi: TronProviderUtils._mapObject(abi, (e) => e.toAbi()),
    bytecode: TronProviderUtils._hexToBytes(bytecode),
    callValue: callValue,
    consumeUserResourcePercent: consumeUserResourcePercent,
    name: name,
    originEnergyLimit: originEnergyLimit,
    codeHash: TronProviderUtils._hexToBytes(codeHash),
    trxHash: TronProviderUtils._hexToBytes(trxHash),
    version: version,
  );
}

extension ExtSmartContract on TronHttpSmartContract {
  TronSmartContract toSmartContract() => TronSmartContract(
    originAddress: TronProviderUtils._mapAddress(originAddress),
    contractAddress: TronProviderUtils._mapAddress(contractAddress),
    abi: TronProviderUtils._mapObject(abi, (e) => e.toAbi()),
    bytecode: TronProviderUtils._hexToBytes(bytecode),
    callValue: callValue,
    consumeUserResourcePercent: consumeUserResourcePercent,
    name: name,
    originEnergyLimit: originEnergyLimit,
    codeHash: TronProviderUtils._hexToBytes(codeHash),
    trxHash: TronProviderUtils._hexToBytes(trxHash),
    version: version,
  );
}

extension ExtCreateSmartContract on TronHttpCreateSmartContract {
  TronCreateSmartContract toContract() => TronCreateSmartContract(
    ownerAddress: TronProviderUtils._mapAddressOrThrow(ownerAddress),
    newContract: TronProviderUtils._mapObject(
      newContract,
      (e) => e.toSmartContract(),
    ),
    callTokenValue: callTokenValue,
    tokenId: tokenId,
  );
}

extension ExtCreateSmartContractInt64StringCompatible
    on TronHttpCreateSmartContractInt64StringCompatible {
  TronCreateSmartContract toContract() => TronCreateSmartContract(
    ownerAddress: TronProviderUtils._mapAddressOrThrow(ownerAddress),
    newContract: TronProviderUtils._mapObject(
      newContract,
      (e) => e.toSmartContract(),
    ),
    callTokenValue: callTokenValue,
    tokenId: tokenId,
  );
}

extension ExtTransactionContractParameterValue
    on TronHttpTransactionContractParameterValue {
  ITronContract toContract() => switch (this) {
    TronHttpTransactionContractParameterValueTransferContract(:final value) =>
      value.toContract(),
    TronHttpTransactionContractParameterValueTransferAssetContract(
      :final value,
    ) =>
      value.toContract(),
    TronHttpTransactionContractParameterValueFreezeBalanceContract(
      :final value,
    ) =>
      value.toContract(),
    TronHttpTransactionContractParameterValueFreezeBalanceV2Contract(
      :final value,
    ) =>
      value.toContract(),
    TronHttpTransactionContractParameterValueUnfreezeBalanceContract(
      :final value,
    ) =>
      value.toContract(),
    TronHttpTransactionContractParameterValueUnfreezeBalanceV2Contract(
      :final value,
    ) =>
      value.toContract(),
    TronHttpTransactionContractParameterValueDelegateResourceContract(
      :final value,
    ) =>
      value.toContract(),
    TronHttpTransactionContractParameterValueUnDelegateResourceContract(
      :final value,
    ) =>
      value.toContract(),
    TronHttpTransactionContractParameterValueAccountCreateContract(
      :final value,
    ) =>
      value.toContract(),
    TronHttpTransactionContractParameterValueAccountUpdateContract(
      :final value,
    ) =>
      value.toContract(),
    TronHttpTransactionContractParameterValueAccountPermissionUpdateContract(
      :final value,
    ) =>
      value.toContract(),
    TronHttpTransactionContractParameterValueWithdrawBalanceContract(
      :final value,
    ) =>
      value.toContract(),
    TronHttpTransactionContractParameterValueWithdrawExpireUnfreezeContract(
      :final value,
    ) =>
      value.toContract(),
    TronHttpTransactionContractParameterValueCancelAllUnfreezeV2Contract(
      :final value,
    ) =>
      value.toContract(),
    TronHttpTransactionContractParameterValueTriggerSmartContract(
      :final value,
    ) =>
      value.toContract(),
    TronHttpTransactionContractParameterValueVoteWitnessContract(
      :final value,
    ) =>
      value.toContract(),
    TronHttpTransactionContractParameterValueWitnessCreateContract(
      :final value,
    ) =>
      value.toContract(),
    TronHttpTransactionContractParameterValueWitnessUpdateContract(
      :final value,
    ) =>
      value.toContract(),
    TronHttpTransactionContractParameterValueUpdateBrokerageContract(
      :final value,
    ) =>
      value.toContract(),
    TronHttpTransactionContractParameterValueUpdateEnergyLimitContract(
      :final value,
    ) =>
      value.toContract(),
    TronHttpTransactionContractParameterValueUpdateSettingContract(
      :final value,
    ) =>
      value.toContract(),
    TronHttpTransactionContractParameterValueClearABIContract(:final value) =>
      value.toContract(),
    TronHttpTransactionContractParameterValueSetAccountIdContract(
      :final value,
    ) =>
      value.toContract(),
    TronHttpTransactionContractParameterValueProposalCreateContract(
      :final value,
    ) =>
      value.toContract(),
    TronHttpTransactionContractParameterValueProposalApproveContract(
      :final value,
    ) =>
      value.toContract(),
    TronHttpTransactionContractParameterValueProposalDeleteContract(
      :final value,
    ) =>
      value.toContract(),
    TronHttpTransactionContractParameterValueExchangeCreateContract(
      :final value,
    ) =>
      value.toContract(),
    TronHttpTransactionContractParameterValueExchangeInjectContract(
      :final value,
    ) =>
      value.toContract(),
    TronHttpTransactionContractParameterValueExchangeWithdrawContract(
      :final value,
    ) =>
      value.toContract(),
    TronHttpTransactionContractParameterValueExchangeTransactionContract(
      :final value,
    ) =>
      value.toContract(),
    TronHttpTransactionContractParameterValueMarketCancelOrderContract(
      :final value,
    ) =>
      value.toContract(),
    TronHttpTransactionContractParameterValueMarketSellAssetContract(
      :final value,
    ) =>
      value.toContract(),
    TronHttpTransactionContractParameterValueUnfreezeAssetContract(
      :final value,
    ) =>
      value.toContract(),
    TronHttpTransactionContractParameterValueParticipateAssetIssueContract(
      :final value,
    ) =>
      value.toContract(),
    TronHttpTransactionContractParameterValueUpdateAssetContract(
      :final value,
    ) =>
      value.toContract(),
    TronHttpTransactionContractParameterValueAssetIssueContract(:final value) =>
      value.toAssetIssueContract(),
    TronHttpTransactionContractParameterValueCreateSmartContract(
      :final value,
    ) =>
      value.toContract(),
    TronHttpTransactionContractParameterValueShieldedTransferContract(
      :final value,
    ) =>
      value.toProtobuf(),
  };
}

extension ExtShieldedTransferContract on TronHttpShieldedTransferContract {
  TronShieldedTransferContract toProtobuf() => TronShieldedTransferContract(
    bindingSignature: TronProviderUtils._hexToBytes(bindingSignature),
    fromAmount: fromAmount,
    toAmount: toAmount,
    receiveDescription:
        receiveDescription?.map((e) => e.toProtobuf()).toList() ?? [],
    transparentFromAddress: TronProviderUtils._mapHex(transparentFromAddress),
    transparentToAddress: TronProviderUtils._mapHex(transparentToAddress),
    spendDescription:
        spendDescription?.map((e) => e.toProtobuf()).toList() ?? [],
  );
}

extension ExtSpendDescription on TronHttpSpendDescription {
  TronSpendDescription toProtobuf() => TronSpendDescription(
    anchor: TronProviderUtils._hexToBytes(anchor),
    nullifier: TronProviderUtils._hexToBytes(nullifier),
    rk: TronProviderUtils._hexToBytes(rk),
    spendAuthoritySignature: TronProviderUtils._hexToBytes(
      spendAuthoritySignature,
    ),
    valueCommitment: TronProviderUtils._hexToBytes(valueCommitment),
    zkproof: TronProviderUtils._hexToBytes(zkproof),
  );
}

extension ExtReceiveDescription on TronHttpReceiveDescription {
  TronReceiveDescription toProtobuf() => TronReceiveDescription(
    cEnc: TronProviderUtils._hexToBytes(cEnc),
    cOut: TronProviderUtils._hexToBytes(cOut),
    epk: TronProviderUtils._hexToBytes(epk),
    noteCommitment: TronProviderUtils._hexToBytes(noteCommitment),
    valueCommitment: TronProviderUtils._hexToBytes(valueCommitment),
    zkproof: TronProviderUtils._hexToBytes(zkproof),
  );
}

extension ExtTransactionContract on TronHttpTransactionContract {
  TronTransactionContract toTransactionContract() {
    return TronTransactionContract(
      parameter: parameter?.value.toContract(),
      provider: TronProviderUtils._mapHex(provider),
      contractName: TronProviderUtils._mapUtf8(contractName),
      permissionId: permissionId,
    );
  }
}

extension ExtTransactionContractInt64StringCompatible
    on TronHttpTransactionContractInt64StringCompatible {
  TronTransactionContract toContract() => TronTransactionContract(
    parameter: parameter!.value.toContract(),
    contractName: TronProviderUtils._mapUtf8(contractName),
    permissionId: permissionId,
    provider: TronProviderUtils._mapHex(provider),
  );
}

extension ExtTransactionRawInt64StringCompatible
    on TronHttpTransactionRawInt64StringCompatible {
  TronTransactionraw toTransactionRaw() => TronTransactionraw(
    refBlockBytes: TronProviderUtils._hexToBytes(refBlockBytes),
    refBlockNum: refBlockNum,
    refBlockHash: TronProviderUtils._hexToBytes(refBlockHash),
    expiration: expiration,
    auths: auths?.map((e) => e.toAuthority()).toList() ?? const [],
    data: TronProviderUtils._mapHex(data),
    contract: contract?.map((e) => e.toContract()).toList() ?? const [],
    scripts: TronProviderUtils._hexToBytes(scripts),
    timestamp: timestamp,
    feeLimit: feeLimit,
  );
}

extension ExtTransactionRaw on TronHttpTransactionRaw {
  TronTransactionraw toTransactionRaw() => TronTransactionraw(
    refBlockBytes: TronProviderUtils._hexToBytes(refBlockBytes),
    refBlockNum: refBlockNum,
    refBlockHash: TronProviderUtils._hexToBytes(refBlockHash),
    expiration: expiration,
    auths: auths?.map((e) => e.toAuthority()).toList() ?? const [],
    data: TronProviderUtils._hexToBytes(data),
    contract:
        contract?.map((e) => e.toTransactionContract()).toList() ?? const [],
    scripts: TronProviderUtils._hexToBytes(scripts),
    timestamp: timestamp,
    feeLimit: feeLimit,
  );
}

extension ExtTransactionInt64StringCompatible
    on TronHttpTransactionInt64StringCompatible {
  TronTransaction toTransaction() {
    final raw = rawData;
    if (raw == null) {
      throw const BuError(
        OnChainErrorType.tronPlugin,
        'Transaction rawData is required.',
      );
    }
    return TronTransaction(
      rawData: raw.toTransactionRaw(),
      signature:
          signature?.map((e) => TronProviderUtils._mapHexOrThrow(e)).toList() ??
          const [],
      ret: ret?.map((e) => e.toTransactionResult()).toList() ?? const [],
    );
  }
}

extension ExtTransaction on TronHttpTransaction {
  TronTransaction toTransaction() {
    final raw = rawData;
    if (raw == null) {
      throw const BuError(
        OnChainErrorType.tronPlugin,
        'Transaction rawData is required.',
      );
    }
    return TronTransaction(
      rawData: raw.toTransactionRaw(),
      signature:
          signature?.map((e) => TronProviderUtils._mapHexOrThrow(e)).toList() ??
          const [],
      ret: ret?.map((e) => e.toTransactionResult()).toList() ?? const [],
    );
  }
}

extension ExtBlockHeaderRawInt64StringCompatible
    on TronHttpBlockHeaderRawInt64StringCompatible {
  TronBlockHeaderraw toBlockHeaderRaw() => TronBlockHeaderraw(
    timestamp: timestamp,
    txTrieRoot: TronProviderUtils._hexToBytes(txTrieRoot),
    parentHash: TronProviderUtils._hexToBytes(parentHash),
    number: number,
    witnessId: witnessId,
    witnessAddress: TronProviderUtils._hexToBytes(witnessAddress),
    version: version,
    accountStateRoot: TronProviderUtils._hexToBytes(accountStateRoot),
  );
}

extension ExtBlockHeaderRaw on TronHttpBlockHeaderRaw {
  TronBlockHeaderraw toBlockHeaderRaw() => TronBlockHeaderraw(
    timestamp: timestamp,
    txTrieRoot: TronProviderUtils._hexToBytes(txTrieRoot),
    parentHash: TronProviderUtils._hexToBytes(parentHash),
    number: number,
    witnessId: witnessId,
    witnessAddress: TronProviderUtils._hexToBytes(witnessAddress),
    version: version,
    accountStateRoot: TronProviderUtils._hexToBytes(accountStateRoot),
  );
}

extension ExtBlockHeaderInt64StringCompatible
    on TronHttpBlockHeaderInt64StringCompatible {
  TronBlockHeader toBlockHeader() => TronBlockHeader(
    rawData: TronProviderUtils._mapObject(rawData, (e) => e.toBlockHeaderRaw()),
    witnessSignature: TronProviderUtils._hexToBytes(witnessSignature),
  );
}

extension ExtBlockHeader on TronHttpBlockHeader {
  TronBlockHeader toBlockHeader() => TronBlockHeader(
    rawData: TronProviderUtils._mapObject(rawData, (e) => e.toBlockHeaderRaw()),
    witnessSignature: TronProviderUtils._hexToBytes(witnessSignature),
  );
}

extension ExtBlockInt64StringCompatible on TronHttpBlockInt64StringCompatible {
  /// Strict decode aborts on the
  /// first bad transaction; production RPC paths that must tolerate wild data
  /// (e.g. hex-ASCII owners seen on Nile) use [toBlockLenient] instead.
  TronBlock toBlock() => TronBlock(
    transactions:
        transactions?.map((e) => e.toTransaction()).toList() ?? const [],
    blockHeader: TronProviderUtils._mapObject(
      blockHeader,
      (e) => e.toBlockHeader(),
    ),
  );

  /// Lenient decode: transactions whose addresses fail parsing are skipped
  /// per-tx (the rest of the block still decodes).
  TronBlock toBlockLenient() => TronBlock(
    transactions:
        transactions
            ?.map((e) {
              try {
                return e.toTransaction();
              } on BuError catch (e) {
                if (e.type != OnChainErrorType.tronAddress) rethrow;
                return null;
              }
            })
            .whereType<TronTransaction>()
            .toList() ??
        const [],
    blockHeader: TronProviderUtils._mapObject(
      blockHeader,
      (e) => e.toBlockHeader(),
    ),
  );
}

extension ExtBlock on TronHttpBlock {
  TronBlock toBlock() => TronBlock(
    transactions:
        transactions?.map((e) => e.toTransaction()).toList() ?? const [],
    blockHeader: TronProviderUtils._mapObject(
      blockHeader,
      (e) => e.toBlockHeader(),
    ),
  );

  /// Lenient decode: transactions whose addresses fail parsing are skipped
  /// per-tx (the rest of the block still decodes).
  TronBlock toBlockLenient() => TronBlock(
    transactions:
        transactions
            ?.map((e) {
              try {
                return e.toTransaction();
              } on BuError catch (e) {
                if (e.type != OnChainErrorType.tronAddress) rethrow;
                return null;
              }
            })
            .whereType<TronTransaction>()
            .toList() ??
        const [],
    blockHeader: TronProviderUtils._mapObject(
      blockHeader,
      (e) => e.toBlockHeader(),
    ),
  );
}

extension ExtBlockListInt64StringCompatible
    on TronHttpBlockListInt64StringCompatible {
  protocol_api.TronBlockList toBlockList() => protocol_api.TronBlockList(
    block: block?.map((e) => e.toBlockLenient()).toList() ?? const [],
  );
}

extension ExtBlockList on TronHttpBlockList {
  protocol_api.TronBlockList toBlockList() => protocol_api.TronBlockList(
    block: block?.map((e) => e.toBlockLenient()).toList() ?? const [],
  );
}

// ---------------------------------------------------------------------------
// TransactionInfo / Extention / lists
// ---------------------------------------------------------------------------

extension ExtInternalTransactionCallValueInfo
    on TronHttpInternalTransactionCallValueInfo {
  TronInternalTransactionCallValueInfo toInfo() =>
      TronInternalTransactionCallValueInfo(
        callValue: callValue,
        tokenId: tokenId,
      );
}

extension ExtInternalTransaction on TronHttpInternalTransaction {
  TronInternalTransaction toInternalTransaction() => TronInternalTransaction(
    hash: TronProviderUtils._hexToBytes(hash),
    callerAddress: TronProviderUtils._mapAddressToBytes(callerAddress),
    transferToAddress: TronProviderUtils._mapAddressToBytes(transferToAddress),
    callValueInfo: callValueInfo?.map((e) => e.toInfo()).toList() ?? const [],
    note: TronProviderUtils._mapUtf8(note),
    rejected: rejected,
    extra: extra,
  );
}

extension ExtTransactionInfoInt64StringCompatible
    on TronHttpTransactionInfoInt64StringCompatible {
  TronTransactionInfo toTransactionInfo() => TronTransactionInfo(
    id: TronProviderUtils._mapHex(id),
    fee: fee,
    blockNumber: blockNumber,
    blockTimeStamp: blockTimeStamp,
    contractResult:
        contractResult
            ?.map((e) => TronProviderUtils._mapHexOrThrow(e))
            .toList() ??
        const [],
    contractAddress: TronProviderUtils._mapAddressToBytes(contractAddress),
    receipt: null,
    log: const [],
    result: result == null ? null : TronTransactionInfocode.from(result!.value),
    resMessage: TronProviderUtils._mapUtf8(resMessage),
    assetIssueID: assetIssueID,
    withdrawAmount: withdrawAmount,
    unfreezeAmount: unfreezeAmount,
    internalTransactions:
        internalTransactions?.map((e) => e.toProtobuf()).toList() ?? const [],
    exchangeReceivedAmount: exchangeReceivedAmount,
    exchangeInjectAnotherAmount: exchangeInjectAnotherAmount,
    exchangeWithdrawAnotherAmount: exchangeWithdrawAnotherAmount,
    exchangeId: exchangeId,
    shieldedTransactionFee: shieldedTransactionFee,
    orderId: TronProviderUtils._mapHex(orderId),
    orderDetails: const [],
    packingFee: packingFee,
    withdrawExpireAmount: withdrawExpireAmount,
    cancelUnfreezeV2Amount: cancelUnfreezeV2Amount ?? {},
  );
}

extension ExtInternalTransactionInt64StringCompatible
    on TronHttpInternalTransactionInt64StringCompatible {
  TronInternalTransaction toProtobuf() => TronInternalTransaction(
    transferToAddress: TronProviderUtils._mapAddressToBytes(transferToAddress),
    rejected: rejected,
    note: TronProviderUtils._mapUtf8(note),
    hash: TronProviderUtils._mapHex(hash),
    extra: extra,
    callerAddress: TronProviderUtils._mapAddressToBytes(callerAddress),
    callValueInfo: callValueInfo?.map((e) => e.toProtobuf()).toList() ?? [],
  );
}

extension ExtInternalTransactionCallValueInfoInt64StringCompatible
    on TronHttpInternalTransactionCallValueInfoInt64StringCompatible {
  TronInternalTransactionCallValueInfo toProtobuf() =>
      TronInternalTransactionCallValueInfo(
        callValue: callValue,
        tokenId: tokenId,
      );
}

extension ExtTransactionInfo on TronHttpTransactionInfo {
  TronTransactionInfo toTransactionInfo() => TronTransactionInfo(
    id: TronProviderUtils._mapHex(id),
    fee: fee,
    blockNumber: blockNumber,
    blockTimeStamp: blockTimeStamp,
    contractResult:
        contractResult
            ?.map((e) => TronProviderUtils._mapHexOrThrow(e))
            .toList() ??
        const [],
    contractAddress: TronProviderUtils._mapAddressToBytes(contractAddress),
    receipt: null,
    log: const [],
    result: result == null ? null : TronTransactionInfocode.from(result!.value),
    resMessage: TronProviderUtils._mapUtf8(resMessage),
    assetIssueID: assetIssueID,
    withdrawAmount: withdrawAmount,
    unfreezeAmount: unfreezeAmount,
    internalTransactions:
        internalTransactions?.map((e) => e.toInternalTransaction()).toList() ??
        const [],
    exchangeReceivedAmount: exchangeReceivedAmount,
    exchangeInjectAnotherAmount: exchangeInjectAnotherAmount,
    exchangeWithdrawAnotherAmount: exchangeWithdrawAnotherAmount,
    exchangeId: exchangeId,
    shieldedTransactionFee: shieldedTransactionFee,
    orderId: TronProviderUtils._mapHex(orderId),
    orderDetails: const [],
    packingFee: packingFee,
    withdrawExpireAmount: withdrawExpireAmount,
    cancelUnfreezeV2Amount: TronProviderUtils._mapBigIntMap(
      cancelUnfreezeV2Amount,
    ),
  );
}

extension ExtReturn on TronHttpReturn {
  protocol_api.TronReturn toReturn() => protocol_api.TronReturn(
    result: result,
    code:
        code == null
            ? null
            : protocol_api.TronReturnresponseCode.from(code!.value),
    message: TronProviderUtils._mapUtf8(message),
  );
}

extension ExtTransactionExtention on TronHttpTransactionExtention {
  protocol_api.TronTransactionExtention toTransactionExtention() =>
      protocol_api.TronTransactionExtention(
        transaction: TronProviderUtils._mapObject(
          transaction,
          (e) => e.toTransaction(),
        ),
        txid: TronProviderUtils._hexToBytes(txid),
        constantResult:
            constantResult
                ?.map((e) => TronProviderUtils._mapHexOrThrow(e))
                .toList() ??
            const [],
        result: TronProviderUtils._mapObject(result, (e) => e.toReturn()),
        energyUsed: energyUsed,
        logs: const [],
        internalTransactions:
            internalTransactions
                ?.map((e) => e.toInternalTransaction())
                .toList() ??
            const [],
        energyPenalty: energyPenalty,
      );
}

extension ExtTransactionIdList on TronHttpTransactionIdList {
  protocol_api.TronTransactionIdList toTransactionIdList() =>
      protocol_api.TronTransactionIdList(txId: txId ?? const []);
}

extension ExtTransactionSignWeight on TronHttpTransactionSignWeight {
  protocol_api.TronTransactionSignWeight toTransactionSignWeight() =>
      protocol_api.TronTransactionSignWeight(
        permission: TronProviderUtils._mapObject(
          permission,
          (e) => e.toPermission(),
        ),
        approvedList:
            approvedList
                ?.map((e) => TronProviderUtils._mapHexOrThrow(e))
                .toList() ??
            const [],
        currentWeight: currentWeight,
        result: null,
        transaction: TronProviderUtils._mapObject(
          transaction,
          (e) => e.toTransactionExtention(),
        ),
      );
}

extension ExtTransactionApprovedList on TronHttpTransactionApprovedList {
  protocol_api.TronTransactionApprovedList toTransactionApprovedList() =>
      protocol_api.TronTransactionApprovedList(
        approvedList:
            approvedList
                ?.map((e) => TronProviderUtils._mapHexOrThrow(e))
                .toList() ??
            const [],
        result: null,
        transaction: TronProviderUtils._mapObject(
          transaction,
          (e) => e.toTransactionExtention(),
        ),
      );
}

// ---------------------------------------------------------------------------
// Asset list / proposal / node / balance / block balance
// ---------------------------------------------------------------------------

extension ExtAssetIssueListInt64StringCompatible
    on TronHttpAssetIssueListInt64StringCompatible {
  protocol_api.TronAssetIssueList toAssetIssueList() =>
      protocol_api.TronAssetIssueList(
        assetIssue:
            assetIssue?.map((e) => e.toAssetIssueContract()).toList() ??
            const [],
      );
}

extension ExtAssetIssueList on TronHttpAssetIssueList {
  protocol_api.TronAssetIssueList toAssetIssueList() =>
      protocol_api.TronAssetIssueList(
        assetIssue:
            assetIssue?.map((e) => e.toAssetIssueContract()).toList() ??
            const [],
      );
}

extension ExtProposalInt64StringCompatible
    on TronHttpProposalInt64StringCompatible {
  TronProposal toProposal() => TronProposal(
    proposalId: proposalId,
    proposerAddress: TronProviderUtils._mapAddressToBytes(proposerAddress),
    parameters:
        parameters?.map((k, v) => MapEntry(BigintUtils.parse(k), v)) ?? {},
    expirationTime: expirationTime,
    createTime: createTime,
    approvals:
        approvals?.map((e) => TronProviderUtils._mapHexOrThrow(e)).toList() ??
        const [],
    state: state == null ? null : TronProposalState.from(state!.value),
  );
}

extension ExtProposal on TronHttpProposal {
  TronProposal toProposal() => TronProposal(
    proposalId: proposalId,
    proposerAddress: TronProviderUtils._mapAddressToBytes(proposerAddress),
    parameters:
        parameters?.map((k, v) => MapEntry(BigintUtils.parse(k), v)) ?? {},
    expirationTime: expirationTime,
    createTime: createTime,
    approvals:
        approvals?.map((e) => TronProviderUtils._mapHexOrThrow(e)).toList() ??
        const [],
    state: state == null ? null : TronProposalState.from(state!.value),
  );
}

extension ExtProposalListInt64StringCompatible
    on TronHttpProposalListInt64StringCompatible {
  protocol_api.TronProposalList toProposalList() =>
      protocol_api.TronProposalList(
        proposals: proposals?.map((e) => e.toProposal()).toList() ?? const [],
      );
}

extension ExtProposalList on TronHttpProposalList {
  protocol_api.TronProposalList toProposalList() =>
      protocol_api.TronProposalList(
        proposals: proposals?.map((e) => e.toProposal()).toList() ?? const [],
      );
}

extension ExtNodeInfoInt64StringCompatible
    on TronHttpNodeInfoInt64StringCompatible {
  TronNodeInfo toNodeInfo() => TronNodeInfo(
    beginSyncNum: beginSyncNum,
    block: block,
    solidityBlock: solidityBlock,
    currentConnectCount: currentConnectCount,
    activeConnectCount: activeConnectCount,
    passiveConnectCount: passiveConnectCount,
    totalFlow: totalFlow,
    configNodeInfo: null,
    machineInfo: null,
    cheatWitnessInfoMap: cheatWitnessInfoMap ?? const {},
    peerInfoList: peerList?.map((e) => e.toProtobuf()).toList() ?? [],
  );
}

extension ExtNodeInfoPeerInfoInt64StringCompatible
    on TronHttpNodeInfoPeerInfoInt64StringCompatible {
  TronNodeInfoPeerInfo toProtobuf() => TronNodeInfoPeerInfo(
    avgLatency: avgLatency?.toDouble(),
    blockInPorcSize: blockInPorcSize,
    connectTime: connectTime,
    disconnectTimes: disconnectTimes,
    headBlockTimeWeBothHave: headBlockTimeWeBothHave,
    headBlockWeBothHave: headBlockWeBothHave,
    host: host,
    inFlow: inFlow,
    isActive: active,
    lastBlockUpdateTime: lastBlockUpdateTime,
    lastSyncBlock: lastSyncBlock,
    localDisconnectReason: localDisconnectReason,
    needSyncFromPeer: needSyncFromPeer,
    needSyncFromUs: needSyncFromUs,
    nodeCount: nodeCount,
    nodeId: nodeId,
    port: port,
    remainNum: remainNum,
    remoteDisconnectReason: remoteDisconnectReason,
    score: score,
    syncBlockRequestedSize: syncBlockRequestedSize,
    syncFlag: syncFlag,
    syncToFetchSize: syncToFetchSize,
    syncToFetchSizePeekNum: syncToFetchSizePeekNum,
    unFetchSynNum: unFetchSynNum,
  );
}

extension ExtNodeInfoPeerInfo on TronHttpNodeInfoPeerInfo {
  TronNodeInfoPeerInfo toProtobuf() => TronNodeInfoPeerInfo(
    avgLatency: avgLatency?.toDouble(),
    blockInPorcSize: blockInPorcSize,
    connectTime: connectTime,
    disconnectTimes: disconnectTimes,
    headBlockTimeWeBothHave: headBlockTimeWeBothHave,
    headBlockWeBothHave: headBlockWeBothHave,
    host: host,
    inFlow: inFlow,
    isActive: active,
    lastBlockUpdateTime: lastBlockUpdateTime,
    lastSyncBlock: lastSyncBlock,
    localDisconnectReason: localDisconnectReason,
    needSyncFromPeer: needSyncFromPeer,
    needSyncFromUs: needSyncFromUs,
    nodeCount: nodeCount,
    nodeId: nodeId,
    port: port,
    remainNum: remainNum,
    remoteDisconnectReason: remoteDisconnectReason,
    score: score,
    syncBlockRequestedSize: syncBlockRequestedSize,
    syncFlag: syncFlag,
    syncToFetchSize: syncToFetchSize,
    syncToFetchSizePeekNum: syncToFetchSizePeekNum,
    unFetchSynNum: unFetchSynNum,
  );
}

extension ExtNodeInfoMachineInfoDeadLockThreadInfo
    on TronHttpNodeInfoMachineInfoDeadLockThreadInfo {
  TronNodeInfoMachineInfoDeadLockThreadInfo toProtobuf() {
    return TronNodeInfoMachineInfoDeadLockThreadInfo(
      blockTime: blockTime,
      lockName: lockName,
      lockOwner: lockOwner,
      name: name,
      stackTrace: stackTrace,
      state: state,
      waitTime: waitTime,
    );
  }
}

extension ExtNodeInfoMachineInfo on TronHttpNodeInfoMachineInfo {
  TronNodeInfoMachineInfo toProtobuf() => TronNodeInfoMachineInfo(
    cpuCount: cpuCount,
    cpuRate: cpuRate?.toDouble(),
    deadLockThreadCount: deadLockThreadCount,

    deadLockThreadInfoList:
        deadLockThreadInfoList?.map((e) => e.toProtobuf()).toList() ?? [],
    freeMemory: freeMemory,
    javaVersion: javaVersion,
    jvmFreeMemory: jvmFreeMemory,
    jvmTotalMemory: jvmTotalMemory,
    osName: osName,
    threadCount: threadCount,
    totalMemory: totalMemory,
    processCpuRate: processCpuRate?.toDouble(),
  );
}

extension ExtNodeInfo on TronHttpNodeInfo {
  TronNodeInfo toNodeInfo() => TronNodeInfo(
    beginSyncNum: beginSyncNum,
    block: block,
    solidityBlock: solidityBlock,
    currentConnectCount: currentConnectCount,
    activeConnectCount: activeConnectCount,
    passiveConnectCount: passiveConnectCount,
    totalFlow: totalFlow,
    configNodeInfo: null,
    machineInfo: machineInfo?.toProtobuf(),
    cheatWitnessInfoMap: cheatWitnessInfoMap ?? const {},
    peerInfoList: peerList?.map((e) => e.toProtobuf()).toList() ?? [],
  );
}

extension ExtNode on TronHttpNode {
  protocol_api.TronNode toNode() => protocol_api.TronNode(
    address: TronProviderUtils._mapObject(
      address,
      (e) => protocol_api.TronNodeAddress(
        host: TronProviderUtils._mapUtf8(e.host),
        port: e.port,
      ),
    ),
  );
}

extension ExtNodeList on TronHttpNodeList {
  protocol_api.TronNodeList toNodeList() => protocol_api.TronNodeList(
    nodes: nodes?.map((e) => e.toNode()).toList() ?? const [],
  );
}

extension ExtBlockBalanceTraceBlockIdentifier
    on TronHttpBlockBalanceTraceBlockIdentifier {
  TronBlockBalanceTraceBlockIdentifier toIdentifier() =>
      TronBlockBalanceTraceBlockIdentifier(
        hash: TronProviderUtils._hexToBytes(hash),
        number: number,
      );
}

extension ExtAccountBalanceResponse on TronHttpAccountBalanceResponse {
  TronAccountBalanceResponse toAccountBalanceResponse() =>
      TronAccountBalanceResponse(
        balance: balance,
        blockIdentifier: TronProviderUtils._mapObject(
          blockIdentifier,
          (e) => e.toIdentifier(),
        ),
      );
}

extension ExtBlockBalanceTrace on TronHttpBlockBalanceTrace {
  TronBlockBalanceTrace toBlockBalanceTrace() => TronBlockBalanceTrace(
    blockIdentifier: TronProviderUtils._mapObject(
      blockIdentifier,
      (e) => e.toIdentifier(),
    ),
    timestamp: timestamp,
    transactionBalanceTrace: const [],
  );
}

extension ExtContractStateInt64StringCompatible
    on TronHttpContractStateInt64StringCompatible {
  TronContractState toContractState() => TronContractState(
    energyUsage: energyUsage,
    energyFactor: energyFactor,
    updateCycle: updateCycle,
  );
}

extension ExtContractState on TronHttpContractState {
  TronContractState toContractState() => TronContractState(
    energyUsage: energyUsage,
    energyFactor: energyFactor,
    updateCycle: updateCycle,
  );
}

extension ExtSmartContractDataWrapperInt64StringCompatible
    on TronHttpSmartContractDataWrapperInt64StringCompatible {
  TronSmartContractDataWrapper toSmartContractDataWrapper() =>
      TronSmartContractDataWrapper(
        smartContract: TronProviderUtils._mapObject(
          smartContract,
          (e) => e.toSmartContract(),
        ),
        runtimecode: TronProviderUtils._hexToBytes(runtimecode),
        contractState: TronProviderUtils._mapObject(
          contractState,
          (e) => e.toContractState(),
        ),
      );
}

extension ExtSmartContractDataWrapper on TronHttpSmartContractDataWrapper {
  TronSmartContractDataWrapper toSmartContractDataWrapper() =>
      TronSmartContractDataWrapper(
        smartContract: TronProviderUtils._mapObject(
          smartContract,
          (e) => e.toSmartContract(),
        ),
        runtimecode: TronProviderUtils._hexToBytes(runtimecode),
        contractState: TronProviderUtils._mapObject(
          contractState,
          (e) => e.toContractState(),
        ),
      );
}

extension ExtAccountPermissionUpdateContractInt64StringCompatible
    on TronHttpAccountPermissionUpdateContractInt64StringCompatible {
  TronAccountPermissionUpdateContract toContract() =>
      TronAccountPermissionUpdateContract(
        ownerAddress: TronProviderUtils._mapAddressOrThrow(ownerAddress),
        owner: TronProviderUtils._mapObject(owner, (e) => e.toPermission()),
        witness: TronProviderUtils._mapObject(witness, (e) => e.toPermission()),
        actives: actives?.map((e) => e.toPermission()).toList() ?? const [],
      );
}

extension ExtDelegateResourceContractInt64StringCompatible
    on TronHttpDelegateResourceContractInt64StringCompatible {
  TronDelegateResourceContract toContract() => TronDelegateResourceContract(
    ownerAddress: TronProviderUtils._mapAddressOrThrow(ownerAddress),
    resource: resource?.toProtobuf(),
    balance: balance,
    receiverAddress: TronProviderUtils._mapAddress(receiverAddress),
    lock: lock,
    lockPeriod: lockPeriod,
  );
}

extension ExtExchangeCreateContractInt64StringCompatible
    on TronHttpExchangeCreateContractInt64StringCompatible {
  TronExchangeCreateContract toContract() => TronExchangeCreateContract(
    ownerAddress: TronProviderUtils._mapAddressOrThrow(ownerAddress),
    firstTokenId: TronProviderUtils._mapUtf8(firstTokenId),
    firstTokenBalance: firstTokenBalance,
    secondTokenId: TronProviderUtils._mapUtf8(secondTokenId),
    secondTokenBalance: secondTokenBalance,
  );
}

extension ExtExchangeInjectContractInt64StringCompatible
    on TronHttpExchangeInjectContractInt64StringCompatible {
  TronExchangeInjectContract toContract() => TronExchangeInjectContract(
    ownerAddress: TronProviderUtils._mapAddressOrThrow(ownerAddress),
    exchangeId: exchangeId,
    tokenId: TronProviderUtils._mapUtf8(tokenId),
    quant: quant,
  );
}

extension ExtExchangeWithdrawContractInt64StringCompatible
    on TronHttpExchangeWithdrawContractInt64StringCompatible {
  TronExchangeWithdrawContract toContract() => TronExchangeWithdrawContract(
    ownerAddress: TronProviderUtils._mapAddressOrThrow(ownerAddress),
    exchangeId: exchangeId,
    tokenId: TronProviderUtils._mapUtf8(tokenId),
    quant: quant,
  );
}

extension ExtExchangeTransactionContractInt64StringCompatible
    on TronHttpExchangeTransactionContractInt64StringCompatible {
  TronExchangeTransactionContract toContract() =>
      TronExchangeTransactionContract(
        ownerAddress: TronProviderUtils._mapAddressOrThrow(ownerAddress),
        exchangeId: exchangeId,
        tokenId: TronProviderUtils._mapUtf8(tokenId),
        quant: quant,
        expected: expected,
      );
}

extension ExtFreezeBalanceV2ContractInt64StringCompatible
    on TronHttpFreezeBalanceV2ContractInt64StringCompatible {
  TronFreezeBalanceV2Contract toContract() => TronFreezeBalanceV2Contract(
    ownerAddress: TronProviderUtils._mapAddressOrThrow(ownerAddress),
    frozenBalance: frozenBalance,
    resource: resource?.toProtobuf(),
  );
}

extension ExtFreezeBalanceContractInt64StringCompatible
    on TronHttpFreezeBalanceContractInt64StringCompatible {
  TronFreezeBalanceContract toContract() => TronFreezeBalanceContract(
    ownerAddress: TronProviderUtils._mapAddressOrThrow(ownerAddress),
    frozenBalance: frozenBalance,
    frozenDuration: frozenDuration,
    resource: resource?.toProtobuf(),
    receiverAddress: TronProviderUtils._mapAddress(receiverAddress),
  );
}

extension ExtMarketSellAssetContractInt64StringCompatible
    on TronHttpMarketSellAssetContractInt64StringCompatible {
  TronMarketSellAssetContract toContract() => TronMarketSellAssetContract(
    ownerAddress: TronProviderUtils._mapAddressOrThrow(ownerAddress),
    sellTokenId: TronProviderUtils._mapUtf8(sellTokenId),
    sellTokenQuantity: sellTokenQuantity,
    buyTokenId: TronProviderUtils._mapUtf8(buyTokenId),
    buyTokenQuantity: buyTokenQuantity,
  );
}

extension ExtParticipateAssetIssueContractInt64StringCompatible
    on TronHttpParticipateAssetIssueContractInt64StringCompatible {
  TronParticipateAssetIssueContract toContract() =>
      TronParticipateAssetIssueContract(
        ownerAddress: TronProviderUtils._mapAddressOrThrow(ownerAddress),
        toAddress: TronProviderUtils._mapAddress(toAddress),
        assetName: TronProviderUtils._mapUtf8(assetName),
        amount: amount,
      );
}

extension ExtProposalApproveContractInt64StringCompatible
    on TronHttpProposalApproveContractInt64StringCompatible {
  TronProposalApproveContract toContract() => TronProposalApproveContract(
    ownerAddress: TronProviderUtils._mapAddressOrThrow(ownerAddress),
    proposalId: proposalId,
    isAddApproval: isAddApproval,
  );
}

extension ExtProposalCreateContractInt64StringCompatible
    on TronHttpProposalCreateContractInt64StringCompatible {
  TronProposalCreateContract toContract() => TronProposalCreateContract(
    ownerAddress: TronProviderUtils._mapAddressOrThrow(ownerAddress),
    parameters:
        parameters?.map((k, v) => MapEntry(JsonParser.valueAsBigInt(k), v)) ??
        {},
  );
}

extension ExtProposalDeleteContractInt64StringCompatible
    on TronHttpProposalDeleteContractInt64StringCompatible {
  TronProposalDeleteContract toContract() => TronProposalDeleteContract(
    ownerAddress: TronProviderUtils._mapAddressOrThrow(ownerAddress),
    proposalId: proposalId,
  );
}

extension ExtShieldedTransferContractInt64StringCompatible
    on TronHttpShieldedTransferContractInt64StringCompatible {
  TronShieldedTransferContract toContract() => TronShieldedTransferContract(
    bindingSignature: TronProviderUtils._hexToBytes(bindingSignature),
    fromAmount: fromAmount,
    toAmount: toAmount,
    receiveDescription:
        receiveDescription?.map((e) => e.toProtobuf()).toList() ?? [],
    transparentFromAddress: TronProviderUtils._mapHex(transparentFromAddress),
    transparentToAddress: TronProviderUtils._mapHex(transparentToAddress),
    spendDescription:
        spendDescription?.map((e) => e.toProtobuf()).toList() ?? [],
  );
}

extension ExtUnDelegateResourceContractInt64StringCompatible
    on TronHttpUnDelegateResourceContractInt64StringCompatible {
  TronUnDelegateResourceContract toContract() => TronUnDelegateResourceContract(
    ownerAddress: TronProviderUtils._mapAddressOrThrow(ownerAddress),
    resource: resource?.toProtobuf(),
    balance: balance,
    receiverAddress: TronProviderUtils._mapAddress(receiverAddress),
  );
}

extension ExtTronHttpAccountFreezeV2Type on TronHttpAccountFreezeV2Type {
  TronResourceCode toProtobuf() => TronResourceCode.from(value);
}

extension ExtUnfreezeBalanceV2ContractInt64StringCompatible
    on TronHttpUnfreezeBalanceV2ContractInt64StringCompatible {
  TronUnfreezeBalanceV2Contract toContract() => TronUnfreezeBalanceV2Contract(
    ownerAddress: TronProviderUtils._mapAddressOrThrow(ownerAddress),
    unfreezeBalance: unfreezeBalance,
    resource: resource?.toProtobuf(),
  );
}

extension ExtUpdateAssetContractInt64StringCompatible
    on TronHttpUpdateAssetContractInt64StringCompatible {
  TronUpdateAssetContract toContract() => TronUpdateAssetContract(
    ownerAddress: TronProviderUtils._mapAddressOrThrow(ownerAddress),
    description: TronProviderUtils._mapUtf8(description),
    url: TronProviderUtils._mapUtf8(url),
    newLimit: newLimit,
    newPublicLimit: newPublicLimit,
  );
}

extension ExtUpdateEnergyLimitContractInt64StringCompatible
    on TronHttpUpdateEnergyLimitContractInt64StringCompatible {
  TronUpdateEnergyLimitContract toContract() => TronUpdateEnergyLimitContract(
    ownerAddress: TronProviderUtils._mapAddressOrThrow(ownerAddress),
    contractAddress: TronProviderUtils._mapAddress(contractAddress),
    originEnergyLimit: originEnergyLimit,
  );
}

extension ExtUpdateSettingContractInt64StringCompatible
    on TronHttpUpdateSettingContractInt64StringCompatible {
  TronUpdateSettingContract toContract() => TronUpdateSettingContract(
    ownerAddress: TronProviderUtils._mapAddressOrThrow(ownerAddress),
    contractAddress: TronProviderUtils._mapAddress(contractAddress),
    consumeUserResourcePercent: consumeUserResourcePercent,
  );
}

extension ExtVoteWitnessContractInt64StringCompatible
    on TronHttpVoteWitnessContractInt64StringCompatible {
  TronVoteWitnessContract toContract() => TronVoteWitnessContract(
    ownerAddress: TronProviderUtils._mapAddressOrThrow(ownerAddress),
    votes: votes?.map((e) => e.toProtobuf()).toList() ?? const [],
  );
}

extension ExtVoteWitnessContractVoteInt64StringCompatible
    on TronHttpVoteWitnessContractVoteInt64StringCompatible {
  TronVoteWitnessContractVote toProtobuf() => TronVoteWitnessContractVote(
    voteAddress: TronProviderUtils._mapAddress(voteAddress),
    voteCount: voteCount,
  );
}

extension ExtTransactionContractParameterValue2
    on TronHttpTransactionContractInt64StringCompatibleParameterValue {
  ITronContract toContract() => switch (this) {
    TronHttpTransactionContractInt64StringCompatibleParameterValueAccountCreateContract(
      :final value,
    ) =>
      value.toContract(),
    TronHttpTransactionContractInt64StringCompatibleParameterValueAccountPermissionUpdateContractInt64StringCompatible(
      :final value,
    ) =>
      value.toContract(),
    TronHttpTransactionContractInt64StringCompatibleParameterValueAccountUpdateContract(
      :final value,
    ) =>
      value.toContract(),
    TronHttpTransactionContractInt64StringCompatibleParameterValueAssetIssueContractInt64StringCompatible(
      :final value,
    ) =>
      value.toAssetIssueContract(),

    TronHttpTransactionContractInt64StringCompatibleParameterValueCancelAllUnfreezeV2Contract(
      :final value,
    ) =>
      value.toContract(),

    TronHttpTransactionContractInt64StringCompatibleParameterValueClearABIContract(
      :final value,
    ) =>
      value.toContract(),

    TronHttpTransactionContractInt64StringCompatibleParameterValueCreateSmartContractInt64StringCompatible(
      :final value,
    ) =>
      value.toContract(),

    TronHttpTransactionContractInt64StringCompatibleParameterValueDelegateResourceContractInt64StringCompatible(
      :final value,
    ) =>
      value.toContract(),

    TronHttpTransactionContractInt64StringCompatibleParameterValueExchangeCreateContractInt64StringCompatible(
      :final value,
    ) =>
      value.toContract(),

    TronHttpTransactionContractInt64StringCompatibleParameterValueExchangeInjectContractInt64StringCompatible(
      :final value,
    ) =>
      value.toContract(),

    TronHttpTransactionContractInt64StringCompatibleParameterValueExchangeTransactionContractInt64StringCompatible(
      :final value,
    ) =>
      value.toContract(),

    TronHttpTransactionContractInt64StringCompatibleParameterValueExchangeWithdrawContractInt64StringCompatible(
      :final value,
    ) =>
      value.toContract(),

    TronHttpTransactionContractInt64StringCompatibleParameterValueFreezeBalanceContractInt64StringCompatible(
      :final value,
    ) =>
      value.toContract(),

    TronHttpTransactionContractInt64StringCompatibleParameterValueFreezeBalanceV2ContractInt64StringCompatible(
      :final value,
    ) =>
      value.toContract(),

    TronHttpTransactionContractInt64StringCompatibleParameterValueMarketCancelOrderContract(
      :final value,
    ) =>
      value.toContract(),

    TronHttpTransactionContractInt64StringCompatibleParameterValueMarketSellAssetContractInt64StringCompatible(
      :final value,
    ) =>
      value.toContract(),

    TronHttpTransactionContractInt64StringCompatibleParameterValueParticipateAssetIssueContractInt64StringCompatible(
      :final value,
    ) =>
      value.toContract(),

    TronHttpTransactionContractInt64StringCompatibleParameterValueProposalApproveContractInt64StringCompatible(
      :final value,
    ) =>
      value.toContract(),

    TronHttpTransactionContractInt64StringCompatibleParameterValueProposalCreateContractInt64StringCompatible(
      :final value,
    ) =>
      value.toContract(),

    TronHttpTransactionContractInt64StringCompatibleParameterValueProposalDeleteContractInt64StringCompatible(
      :final value,
    ) =>
      value.toContract(),

    TronHttpTransactionContractInt64StringCompatibleParameterValueSetAccountIdContract(
      :final value,
    ) =>
      value.toContract(),

    TronHttpTransactionContractInt64StringCompatibleParameterValueShieldedTransferContractInt64StringCompatible(
      :final value,
    ) =>
      value.toContract(),

    TronHttpTransactionContractInt64StringCompatibleParameterValueTransferAssetContractInt64StringCompatible(
      :final value,
    ) =>
      value.toContract(),

    TronHttpTransactionContractInt64StringCompatibleParameterValueTransferContractInt64StringCompatible(
      :final value,
    ) =>
      value.toContract(),

    TronHttpTransactionContractInt64StringCompatibleParameterValueTriggerSmartContractInt64StringCompatible(
      :final value,
    ) =>
      value.toContract(),

    TronHttpTransactionContractInt64StringCompatibleParameterValueUnDelegateResourceContractInt64StringCompatible(
      :final value,
    ) =>
      value.toContract(),

    TronHttpTransactionContractInt64StringCompatibleParameterValueUnfreezeAssetContract(
      :final value,
    ) =>
      value.toContract(),

    TronHttpTransactionContractInt64StringCompatibleParameterValueUnfreezeBalanceContract(
      :final value,
    ) =>
      value.toContract(),

    TronHttpTransactionContractInt64StringCompatibleParameterValueUnfreezeBalanceV2ContractInt64StringCompatible(
      :final value,
    ) =>
      value.toContract(),

    TronHttpTransactionContractInt64StringCompatibleParameterValueUpdateAssetContractInt64StringCompatible(
      :final value,
    ) =>
      value.toContract(),

    TronHttpTransactionContractInt64StringCompatibleParameterValueUpdateBrokerageContract(
      :final value,
    ) =>
      value.toContract(),

    TronHttpTransactionContractInt64StringCompatibleParameterValueUpdateEnergyLimitContractInt64StringCompatible(
      :final value,
    ) =>
      value.toContract(),

    TronHttpTransactionContractInt64StringCompatibleParameterValueUpdateSettingContractInt64StringCompatible(
      :final value,
    ) =>
      value.toContract(),

    TronHttpTransactionContractInt64StringCompatibleParameterValueVoteWitnessContractInt64StringCompatible(
      :final value,
    ) =>
      value.toContract(),

    TronHttpTransactionContractInt64StringCompatibleParameterValueWithdrawBalanceContract(
      :final value,
    ) =>
      value.toContract(),

    TronHttpTransactionContractInt64StringCompatibleParameterValueWithdrawExpireUnfreezeContract(
      :final value,
    ) =>
      value.toContract(),

    TronHttpTransactionContractInt64StringCompatibleParameterValueWitnessCreateContract(
      :final value,
    ) =>
      value.toContract(),

    TronHttpTransactionContractInt64StringCompatibleParameterValueWitnessUpdateContract(
      :final value,
    ) =>
      value.toContract(),
  };
}

extension ExtTronTransactionExtention on TronTransactionExtention {
  bool get isSuccess =>
      result?.result == true &&
      transaction != null &&
      !transaction!.ret.any(
        (e) =>
            e.ret == TronTransactionResultcode.failed ||
            (e.contractRet != null &&
                e.contractRet != TronTransactionResultcontractResult.success),
      );
  String? get error => StringUtils.tryDecode(result?.message);
}
