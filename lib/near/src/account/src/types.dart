import 'package:blockchain_utils/utils/utils.dart';

class NearAccountStateBalance {
  final BigInt total;
  final BigInt usedOnStorage;
  final BigInt locked;
  final BigInt available;

  const NearAccountStateBalance({
    required this.total,
    required this.usedOnStorage,
    required this.locked,
    required this.available,
  });

  factory NearAccountStateBalance.fromJson(Map<String, dynamic> json) {
    return NearAccountStateBalance(
      total: json.valueAsBigInt('total'),
      usedOnStorage: json.valueAsBigInt('usedOnStorage'),
      locked: json.valueAsBigInt('locked'),
      available: json.valueAsBigInt('available'),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'total': total.toString(),
      'usedOnStorage': usedOnStorage.toString(),
      'locked': locked.toString(),
      'available': available.toString(),
    };
  }
}

class NearAccountState {
  final NearAccountStateBalance balance;
  final num storageUsage;
  final String codeHash;

  const NearAccountState({
    required this.balance,
    required this.storageUsage,
    required this.codeHash,
  });

  factory NearAccountState.fromJson(Map<String, dynamic> json) {
    return NearAccountState(
      balance: json.valueTo(
        key: 'balance',
        parse: (Map<String, dynamic> v) => NearAccountStateBalance.fromJson(v),
      ),
      storageUsage: json.valueAsNum('storageUsage'),
      codeHash: json.valueAsString('codeHash'),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'balance': balance.toJson(),
      'storageUsage': storageUsage,
      'codeHash': codeHash,
    };
  }
}
