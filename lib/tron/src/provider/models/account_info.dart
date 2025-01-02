import 'package:on_chain/tron/src/models/contract/base_contract/common.dart';
import 'package:on_chain/tron/src/models/contract/account/permission_type.dart';
import 'package:blockchain_utils/blockchain_utils.dart';

class TronAccountModel {
  final String? accountName;
  final String address;
  final BigInt balance;
  final BigInt createTime;
  final BigInt? latestOperationTime;
  final List<FrozenSupplyModel> frozenSupply;
  final String? assetIssuedName;
  final int? freeNetUsage;
  final BigInt? latestConsumeFreeTime;
  final int netWindowSize;
  final bool netWindowOptimized;
  final TronAccountResourceModel accountResource;
  final AccountPermissionModel ownerPermission;

  final List<AccountPermissionModel> activePermissions;
  final AccountPermissionModel? witnessPermission;
  final List<FrozenV2Model> frozenV2;
  final List<UnfrozenV2Model> unfrozenV2;
  final List<AssetV2Model> assetV2;
  final String? assetIssuedID;
  final List<FreeAssetNetUsageV2Model> freeAssetNetUsageV2;
  final bool? assetOptimized;

  const TronAccountModel._({
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

  factory TronAccountModel.fromJson(Map<String, dynamic> json) {
    return TronAccountModel._(
      accountName: json['account_name'],
      address: json['address'],
      balance: BigintUtils.parse(json['balance'] ?? BigInt.zero),
      createTime: BigintUtils.parse(json['create_time']),
      latestOperationTime: BigintUtils.tryParse(json['latest_opration_time']),
      frozenSupply: (json['frozen_supply'] as List?)
              ?.map((supply) => FrozenSupplyModel.fromJson(supply))
              .toList() ??
          <FrozenSupplyModel>[],
      assetIssuedName: json['asset_issued_name'],
      freeNetUsage: json['free_net_usage'],
      latestConsumeFreeTime:
          BigintUtils.tryParse(json['latest_consume_free_time']),
      netWindowSize: json['net_window_size'],
      netWindowOptimized: json['net_window_optimized'],
      accountResource:
          TronAccountResourceModel.fromJson(json['account_resource']),
      ownerPermission:
          AccountPermissionModel.fromJson(json['owner_permission']),
      activePermissions: (json['active_permission'] as List<dynamic>)
          .map((permission) => AccountPermissionModel.fromJson(permission))
          .toList(),
      witnessPermission: json['witness_permission'] == null
          ? null
          : AccountPermissionModel.fromJson(json['witness_permission']),
      frozenV2: (json['frozenV2'] as List<dynamic>)
          .map((frozen) => FrozenV2Model.fromJson(frozen))
          .toList(),
      unfrozenV2: (json['unfrozenV2'] as List?)
              ?.map((unfrozen) => UnfrozenV2Model.fromJson(unfrozen))
              .toList() ??
          <UnfrozenV2Model>[],
      assetV2: (json['assetV2'] as List?)
              ?.map((asset) => AssetV2Model.fromJson(asset))
              .toList() ??
          <AssetV2Model>[],
      assetIssuedID: json['asset_issued_ID'],
      freeAssetNetUsageV2: (json['free_asset_net_usageV2'] as List?)
              ?.map((usage) => FreeAssetNetUsageV2Model.fromJson(usage))
              .toList() ??
          <FreeAssetNetUsageV2Model>[],
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

class AccountPermissionModel {
  final String type;
  final int? id;
  final String? permissionName;
  final BigInt threshold;
  final String? operations;
  final List<PermissionKeysModel> keys;

  AccountPermissionModel._({
    required this.type,
    this.id,
    required this.permissionName,
    required this.threshold,
    this.operations,
    required this.keys,
  });

  factory AccountPermissionModel.fromJson(Map<String, dynamic> json) {
    return AccountPermissionModel._(
      type: json['type'] ?? PermissionType.owner.name,
      id: json['id'],
      permissionName: json['permission_name'],
      threshold: BigintUtils.parse(json['threshold']),
      operations: json['operations'],
      keys: (json['keys'] as List?)
              ?.map((e) => PermissionKeysModel.fromJson(e))
              .toList() ??
          <PermissionKeysModel>[],
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

class PermissionKeysModel {
  PermissionKeysModel._({required this.address, required this.weight});
  factory PermissionKeysModel.fromJson(Map<String, dynamic> json) {
    return PermissionKeysModel._(
        address: json['address'], weight: BigintUtils.parse(json['weight']));
  }
  final String address;
  final BigInt weight;

  @override
  String toString() {
    return 'PermissionKeys(address: $address, weight: $weight)';
  }
}

class FrozenSupplyModel {
  final BigInt frozenBalance;
  final BigInt expireTime;

  FrozenSupplyModel._({
    required this.frozenBalance,
    required this.expireTime,
  });

  factory FrozenSupplyModel.fromJson(Map<String, dynamic> json) {
    return FrozenSupplyModel._(
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

class FrozenV2Model {
  final BigInt amount;
  final String type;

  FrozenV2Model._({
    required this.amount,
    required this.type,
  });

  factory FrozenV2Model.fromJson(Map<String, dynamic> json) {
    return FrozenV2Model._(
      amount: BigintUtils.tryParse(json['amount']) ?? BigInt.zero,
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

class UnfrozenV2Model {
  final String? type;
  final BigInt unfreezeAmount;
  final BigInt unfreezeExpireTime;

  UnfrozenV2Model._({
    required this.type,
    required this.unfreezeAmount,
    required this.unfreezeExpireTime,
  });

  factory UnfrozenV2Model.fromJson(Map<String, dynamic> json) {
    return UnfrozenV2Model._(
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

class AssetV2Model {
  final String key;
  final BigInt value;

  AssetV2Model._({
    required this.key,
    required this.value,
  });

  factory AssetV2Model.fromJson(Map<String, dynamic> json) {
    return AssetV2Model._(
      key: json['key'],
      value: BigintUtils.parse(json['value']),
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

class FreeAssetNetUsageV2Model {
  final String key;
  final BigInt value;

  FreeAssetNetUsageV2Model._({
    required this.key,
    required this.value,
  });

  factory FreeAssetNetUsageV2Model.fromJson(Map<String, dynamic> json) {
    return FreeAssetNetUsageV2Model._(
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

class TronAccountResourceModel {
  final int energyWindowSize;
  final BigInt? delegatedFrozenV2BalanceForEnergy;
  final bool energyWindowOptimized;

  TronAccountResourceModel._({
    required this.energyWindowSize,
    required this.delegatedFrozenV2BalanceForEnergy,
    required this.energyWindowOptimized,
  });

  factory TronAccountResourceModel.fromJson(Map<String, dynamic> json) {
    return TronAccountResourceModel._(
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
