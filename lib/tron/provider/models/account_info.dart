import 'package:on_chain/tron/models/contract/base_contract/common.dart';
import 'package:on_chain/tron/models/contract/account/permission_type.dart';
import 'package:blockchain_utils/blockchain_utils.dart';

class TronAccount {
  final String? accountName;
  final String address;
  final BigInt balance;
  final BigInt createTime;
  final BigInt? latestOperationTime;
  final List<FrozenSupply> frozenSupply;
  final String? assetIssuedName;
  final int? freeNetUsage;
  final BigInt? latestConsumeFreeTime;
  final int netWindowSize;
  final bool netWindowOptimized;
  final TronAccountResource accountResource;
  final AccountPermission ownerPermission;

  final List<AccountPermission> activePermissions;
  final AccountPermission? witnessPermission;
  final List<FrozenV2> frozenV2;
  final List<UnfrozenV2> unfrozenV2;
  final List<AssetV2> assetV2;
  final String? assetIssuedID;
  final List<FreeAssetNetUsageV2> freeAssetNetUsageV2;
  final bool assetOptimized;

  const TronAccount._({
    this.accountName,
    required this.address,
    required this.balance,
    required this.createTime,
    required this.latestOperationTime,
    required this.frozenSupply,
    required this.assetIssuedName,
    required this.freeNetUsage,
    required this.latestConsumeFreeTime,
    required this.netWindowSize,
    required this.netWindowOptimized,
    required this.accountResource,
    required this.ownerPermission,
    required this.activePermissions,
    required this.witnessPermission,
    required this.frozenV2,
    required this.unfrozenV2,
    required this.assetV2,
    required this.assetIssuedID,
    required this.freeAssetNetUsageV2,
    required this.assetOptimized,
  });

  factory TronAccount.fromJson(Map<String, dynamic> json) {
    return TronAccount._(
      accountName: json['account_name'],
      address: json['address'],
      balance: BigintUtils.parse(json['balance'] ?? BigInt.zero),
      createTime: BigintUtils.parse(json['create_time']),
      latestOperationTime: BigintUtils.tryParse(json['latest_opration_time']),
      frozenSupply: (json['frozen_supply'] as List?)
              ?.map((supply) => FrozenSupply.fromJson(supply))
              .toList() ??
          <FrozenSupply>[],
      assetIssuedName: json['asset_issued_name'],
      freeNetUsage: json['free_net_usage'],
      latestConsumeFreeTime:
          BigintUtils.tryParse(json['latest_consume_free_time']),
      netWindowSize: json['net_window_size'],
      netWindowOptimized: json['net_window_optimized'],
      accountResource: TronAccountResource.fromJson(json['account_resource']),
      ownerPermission: AccountPermission.fromJson(json['owner_permission']),
      activePermissions: (json['active_permission'] as List<dynamic>)
          .map((permission) => AccountPermission.fromJson(permission))
          .toList(),
      witnessPermission: json["witness_permission"] == null
          ? null
          : AccountPermission.fromJson(json['witness_permission']),
      frozenV2: (json['frozenV2'] as List<dynamic>)
          .map((frozen) => FrozenV2.fromJson(frozen))
          .toList(),
      unfrozenV2: (json['unfrozenV2'] as List?)
              ?.map((unfrozen) => UnfrozenV2.fromJson(unfrozen))
              .toList() ??
          <UnfrozenV2>[],
      assetV2: (json['assetV2'] as List?)
              ?.map((asset) => AssetV2.fromJson(asset))
              .toList() ??
          <AssetV2>[],
      assetIssuedID: json['asset_issued_ID'],
      freeAssetNetUsageV2: (json['free_asset_net_usageV2'] as List?)
              ?.map((usage) => FreeAssetNetUsageV2.fromJson(usage))
              .toList() ??
          <FreeAssetNetUsageV2>[],
      assetOptimized: json['asset_optimized'],
    );
  }

  @override
  String toString() {
    return '''
      TronAccount {
        accountName: $accountName,
        address: $address,
        balance: $balance,
        createTime: $createTime,
        latestOperationTime: $latestOperationTime,
        frozenSupply: $frozenSupply,
        assetIssuedName: $assetIssuedName,
        freeNetUsage: $freeNetUsage,
        latestConsumeFreeTime: $latestConsumeFreeTime,
        netWindowSize: $netWindowSize,
        netWindowOptimized: $netWindowOptimized,
        accountResource: $accountResource,
        ownerPermission: $ownerPermission,
        activePermissions: $activePermissions,
        frozenV2: $frozenV2,
        unfrozenV2: $unfrozenV2,
        assetV2: $assetV2,
        assetIssuedID: $assetIssuedID,
        freeAssetNetUsageV2: $freeAssetNetUsageV2,
        assetOptimized: $assetOptimized
      }
    ''';
  }
}

class AccountPermission {
  final String type;
  final int? id;
  final String? permissionName;
  final BigInt threshold;
  final String? operations;
  final List<PermissionKeys> keys;

  AccountPermission._({
    required this.type,
    this.id,
    required this.permissionName,
    required this.threshold,
    this.operations,
    required this.keys,
  });

  factory AccountPermission.fromJson(Map<String, dynamic> json) {
    return AccountPermission._(
      type: json['type'] ?? PermissionType.owner.name,
      id: json['id'],
      permissionName: json['permission_name'],
      threshold: BigintUtils.parse(json['threshold']),
      operations: json['operations'],
      keys: (json['keys'] as List?)
              ?.map((e) => PermissionKeys.fromJson(e))
              .toList() ??
          <PermissionKeys>[],
    );
  }

  @override
  String toString() {
    return '''
      ActivePermission {
        type: $type,
        id: $id,
        permissionName: $permissionName,
        threshold: $threshold,
        operations: $operations,
        keys: $keys
      }
    ''';
  }
}

class PermissionKeys {
  PermissionKeys._({required this.address, required this.weight});
  factory PermissionKeys.fromJson(Map<String, dynamic> json) {
    return PermissionKeys._(
        address: json["address"], weight: BigintUtils.parse(json["weight"]));
  }
  final String address;
  final BigInt weight;

  @override
  String toString() {
    return 'PermissionKeys(address: $address, weight: $weight)';
  }
}

class FrozenSupply {
  final BigInt frozenBalance;
  final BigInt expireTime;

  FrozenSupply._({
    required this.frozenBalance,
    required this.expireTime,
  });

  factory FrozenSupply.fromJson(Map<String, dynamic> json) {
    return FrozenSupply._(
      frozenBalance: BigInt.from(json['frozen_balance']),
      expireTime: BigInt.from(json['expire_time']),
    );
  }

  @override
  String toString() {
    return '''
      FrozenSupply {
        frozenBalance: $frozenBalance,
        expireTime: $expireTime
      }
    ''';
  }
}

class FrozenV2 {
  final BigInt amount;
  final String type;

  FrozenV2._({
    required this.amount,
    required this.type,
  });

  factory FrozenV2.fromJson(Map<String, dynamic> json) {
    return FrozenV2._(
      amount: BigintUtils.tryParse(json["amount"]) ?? BigInt.zero,
      type: json['type'] ?? ResourceCode.bandWidth.name,
    );
  }

  @override
  String toString() {
    return '''
      FrozenV2 {
        amount: $amount,
        type: $type
      }
    ''';
  }
}

class UnfrozenV2 {
  final String? type;
  final BigInt unfreezeAmount;
  final BigInt unfreezeExpireTime;

  UnfrozenV2._({
    required this.type,
    required this.unfreezeAmount,
    required this.unfreezeExpireTime,
  });

  factory UnfrozenV2.fromJson(Map<String, dynamic> json) {
    return UnfrozenV2._(
      type: json['type'],
      unfreezeAmount: BigintUtils.parse(json['unfreeze_amount']),
      unfreezeExpireTime: BigintUtils.parse(json['unfreeze_expire_time']),
    );
  }

  @override
  String toString() {
    return '''
      UnfrozenV2 {
        type: $type,
        unfreezeAmount: $unfreezeAmount,
        unfreezeExpireTime: $unfreezeExpireTime
      }
    ''';
  }
}

class AssetV2 {
  final String key;
  final BigInt value;

  AssetV2._({
    required this.key,
    required this.value,
  });

  factory AssetV2.fromJson(Map<String, dynamic> json) {
    return AssetV2._(
      key: json['key'],
      value: BigintUtils.parse(json["value"]),
    );
  }

  @override
  String toString() {
    return '''
      AssetV2 {
        key: $key,
        value: $value
      }
    ''';
  }
}

class FreeAssetNetUsageV2 {
  final String key;
  final BigInt value;

  FreeAssetNetUsageV2._({
    required this.key,
    required this.value,
  });

  factory FreeAssetNetUsageV2.fromJson(Map<String, dynamic> json) {
    return FreeAssetNetUsageV2._(
      key: json['key'],
      value: BigintUtils.parse(json['value']),
    );
  }

  @override
  String toString() {
    return '''
      FreeAssetNetUsageV2 {
        key: $key,
        value: $value
      }
    ''';
  }
}

class TronAccountResource {
  final int energyWindowSize;
  final BigInt? delegatedFrozenV2BalanceForEnergy;
  final bool energyWindowOptimized;

  TronAccountResource._({
    required this.energyWindowSize,
    required this.delegatedFrozenV2BalanceForEnergy,
    required this.energyWindowOptimized,
  });

  factory TronAccountResource.fromJson(Map<String, dynamic> json) {
    return TronAccountResource._(
      energyWindowSize: json['energy_window_size'],
      delegatedFrozenV2BalanceForEnergy:
          BigintUtils.tryParse(json['delegated_frozenV2_balance_for_energy']),
      energyWindowOptimized: json['energy_window_optimized'],
    );
  }

  @override
  String toString() {
    return '''
      TronAccountResource {
        energyWindowSize: $energyWindowSize,
        delegatedFrozenV2BalanceForEnergy: $delegatedFrozenV2BalanceForEnergy,
        energyWindowOptimized: $energyWindowOptimized
      }
    ''';
  }
}
