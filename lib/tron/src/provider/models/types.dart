// GENERATED CODE - DO NOT MODIFY BY HAND
// Source: OpenAPI 3.1.0
// java-tron HTTP API 1.0.0

import 'package:blockchain_utils/blockchain_utils.dart';

/// Parses a java-tron protobuf map field. On the wire it arrives either as
/// a plain JSON object or — the actual java-tron shape — as a list of
/// `{"key": k, "value": v}` entries. Entry keys may be numbers or strings;
/// entry values are decoded with [parse].
Map<String, V> _tronMapFromJson<V>(
  dynamic json,
  V Function(dynamic value) parse,
) {
  if (json is List) {
    final out = <String, V>{};
    for (final e in json) {
      if (e is! Map) continue;
      final m = e is Map<String, dynamic> ? e : Map<String, dynamic>.from(e);
      final k = m['key'];
      out[k.toString()] = parse(m['value']);
    }
    return out;
  }
  if (json is Map) {
    final m =
        json is Map<String, dynamic> ? json : Map<String, dynamic>.from(json);
    return m.map((k, v) => MapEntry(k.toString(), parse(v)));
  }
  return <String, V>{};
}

/// Serializes a protobuf map field to the canonical java-tron wire shape:
/// a list of `{"key": k, "value": v}` entries.
List<Map<String, dynamic>> _tronMapToJson<V>(Map<String, V> map) => [
  for (final e in map.entries) {'key': e.key, 'value': e.value},
];

sealed class TronHttpEstimateEnergyRequest {
  const TronHttpEstimateEnergyRequest();

  factory TronHttpEstimateEnergyRequest.fromJson(dynamic json) {
    throw CoreErrors.invalidOperationArguments(
      'TronHttpEstimateEnergyRequest',
      reason: 'Cannot parse TronHttpEstimateEnergyRequest from $json',
    );
  }

  dynamic toJson();
}

class TronHttpEstimateEnergyRequestEstimateEnergyRequestRequiresContractAddress1
    extends TronHttpEstimateEnergyRequest {
  final dynamic value;
  const TronHttpEstimateEnergyRequestEstimateEnergyRequestRequiresContractAddress1(
    this.value,
  );

  @override
  dynamic toJson() => value;
}

class TronHttpEstimateEnergyRequestEstimateEnergyRequestRequiresData2
    extends TronHttpEstimateEnergyRequest {
  final dynamic value;
  const TronHttpEstimateEnergyRequestEstimateEnergyRequestRequiresData2(
    this.value,
  );

  @override
  dynamic toJson() => value;
}

sealed class TronHttpTriggerConstantContractRequest {
  const TronHttpTriggerConstantContractRequest();

  factory TronHttpTriggerConstantContractRequest.fromJson(dynamic json) {
    throw CoreErrors.invalidOperationArguments(
      'TronHttpTriggerConstantContractRequest',
      reason: 'Cannot parse TronHttpTriggerConstantContractRequest from $json',
    );
  }

  dynamic toJson();
}

class TronHttpTriggerConstantContractRequestTriggerConstantContractRequestRequiresContractAddress1
    extends TronHttpTriggerConstantContractRequest {
  final dynamic value;
  const TronHttpTriggerConstantContractRequestTriggerConstantContractRequestRequiresContractAddress1(
    this.value,
  );

  @override
  dynamic toJson() => value;
}

class TronHttpTriggerConstantContractRequestTriggerConstantContractRequestRequiresData2
    extends TronHttpTriggerConstantContractRequest {
  final dynamic value;
  const TronHttpTriggerConstantContractRequestTriggerConstantContractRequestRequiresData2(
    this.value,
  );

  @override
  dynamic toJson() => value;
}

/// Account type accepted as a Protobuf enum name or its numeric value.
sealed class TronHttpAccountCreateContractRequestType {
  const TronHttpAccountCreateContractRequestType();

  factory TronHttpAccountCreateContractRequestType.fromJson(dynamic json) {
    if (json is String) {
      return TronHttpAccountCreateContractRequestTypeAccountTypeName(json);
    }
    if (json is num) {
      return TronHttpAccountCreateContractRequestTypeAccountTypeNumber(
        json.toInt(),
      );
    }
    throw CoreErrors.invalidOperationArguments(
      'TronHttpAccountCreateContractRequestType',
      reason:
          'Cannot parse TronHttpAccountCreateContractRequestType from $json',
    );
  }

  dynamic toJson();
}

class TronHttpAccountCreateContractRequestTypeAccountTypeName
    extends TronHttpAccountCreateContractRequestType {
  final String value;
  const TronHttpAccountCreateContractRequestTypeAccountTypeName(this.value);

  @override
  dynamic toJson() => value;
}

class TronHttpAccountCreateContractRequestTypeAccountTypeNumber
    extends TronHttpAccountCreateContractRequestType {
  final int value;
  const TronHttpAccountCreateContractRequestTypeAccountTypeNumber(this.value);

  @override
  dynamic toJson() => value;
}

/// Account, contract, or resource type.
enum TronHttpAccountFreezeV2Type {
  bandwidth("BANDWIDTH"),
  energy("ENERGY"),
  tronPower("TRON_POWER");

  final String value;
  const TronHttpAccountFreezeV2Type(this.value);

  static TronHttpAccountFreezeV2Type fromJson(dynamic json) {
    final value = json is String ? json : json?.toString();
    return values.firstWhere(
      (e) => e.value == value,
      orElse:
          () =>
              throw BuError(
                DefaultErrorType.invalidArgument,
                "Invalid TronHttpAccountFreezeV2Type.",
              ),
    );
  }

  String toJson() => value;
}

/// Account, contract, or resource type.
enum TronHttpAccountType {
  normal("Normal"),
  assetIssue("AssetIssue"),
  contract("Contract");

  final String value;
  const TronHttpAccountType(this.value);

  static TronHttpAccountType fromJson(dynamic json) {
    final value = json is String ? json : json?.toString();
    return values.firstWhere(
      (e) => e.value == value,
      orElse:
          () =>
              throw BuError(
                DefaultErrorType.invalidArgument,
                "Invalid TronHttpAccountType.",
              ),
    );
  }

  String toJson() => value;
}

/// Resource type.
enum TronHttpDelegateResourceContractRequestResource {
  bandwidth("BANDWIDTH"),
  energy("ENERGY");

  final String value;
  const TronHttpDelegateResourceContractRequestResource(this.value);

  static TronHttpDelegateResourceContractRequestResource fromJson(
    dynamic json,
  ) {
    final value = json is String ? json : json?.toString();
    return values.firstWhere(
      (e) => e.value == value,
      orElse:
          () =>
              throw BuError(
                DefaultErrorType.invalidArgument,
                "Invalid TronHttpDelegateResourceContractRequestResource.",
              ),
    );
  }

  String toJson() => value;
}

/// Resource type to freeze. TRON_POWER is accepted only when the chain supports the new resource model (`supportAllowNewResourceModel()`).
enum TronHttpFreezeBalanceContractRequestResource {
  bandwidth("BANDWIDTH"),
  energy("ENERGY"),
  tronPower("TRON_POWER");

  final String value;
  const TronHttpFreezeBalanceContractRequestResource(this.value);

  static TronHttpFreezeBalanceContractRequestResource fromJson(dynamic json) {
    final value = json is String ? json : json?.toString();
    return values.firstWhere(
      (e) => e.value == value,
      orElse:
          () =>
              throw BuError(
                DefaultErrorType.invalidArgument,
                "Invalid TronHttpFreezeBalanceContractRequestResource.",
              ),
    );
  }

  String toJson() => value;
}

/// Account, contract, or resource type.
enum TronHttpPermissionType {
  owner("Owner"),
  witness("Witness"),
  active("Active");

  final String value;
  const TronHttpPermissionType(this.value);

  static TronHttpPermissionType fromJson(dynamic json) {
    final value = json is String ? json : json?.toString();
    return values.firstWhere(
      (e) => e.value == value,
      orElse:
          () =>
              throw BuError(
                DefaultErrorType.invalidArgument,
                "Invalid TronHttpPermissionType.",
              ),
    );
  }

  String toJson() => value;
}

enum TronHttpProposalState {
  pending("PENDING"),
  disapproved("DISAPPROVED"),
  approved("APPROVED"),
  canceled("CANCELED");

  final String value;
  const TronHttpProposalState(this.value);

  static TronHttpProposalState fromJson(dynamic json) {
    final value = json is String ? json : json?.toString();
    return values.firstWhere(
      (e) => e.value == value,
      orElse:
          () =>
              throw BuError(
                DefaultErrorType.invalidArgument,
                "Invalid TronHttpProposalState.",
              ),
    );
  }

  String toJson() => value;
}

sealed class TronHttpResponseWalletBroadcasthexPost {
  const TronHttpResponseWalletBroadcasthexPost();

  factory TronHttpResponseWalletBroadcasthexPost.fromJson(dynamic json) {
    if (json is Map) {
      final map =
          json is Map<String, dynamic> ? json : Map<String, dynamic>.from(json);
      if (map.hasValue('Error')) {
        return TronHttpResponseWalletBroadcasthexPostJavaTronError(
          TronHttpJavaTronError.fromJson(map),
        );
      }
      if (map.hasValue('result') &&
          map.hasValue('code') &&
          map.hasValue('message') &&
          map.hasValue('txid') &&
          map.hasValue('transaction')) {
        return TronHttpResponseWalletBroadcasthexPostBroadcasthexPostResultObject1.fromJson(
          map,
        );
      }
    }
    throw CoreErrors.invalidOperationArguments(
      'TronHttpResponseWalletBroadcasthexPost',
      reason: 'Cannot parse TronHttpResponseWalletBroadcasthexPost from $json',
    );
  }

  dynamic toJson();
}

class TronHttpResponseWalletBroadcasthexPostBroadcasthexPostResultObject1
    extends TronHttpResponseWalletBroadcasthexPost {
  final bool? result;
  final String? code;
  final String? message;
  final String? txid;
  final String? transaction;

  const TronHttpResponseWalletBroadcasthexPostBroadcasthexPostResultObject1({
    this.result,
    this.code,
    this.message,
    this.txid,
    this.transaction,
  });

  factory TronHttpResponseWalletBroadcasthexPostBroadcasthexPostResultObject1.fromJson(
    Map<String, dynamic> json,
  ) {
    return TronHttpResponseWalletBroadcasthexPostBroadcasthexPostResultObject1(
      result: json.valueAsBool('result'),
      code:
          (json['code'] is num
              ? json['code'].toString()
              : json.valueAsString('code')),
      message:
          (json['message'] is num
              ? json['message'].toString()
              : json.valueAsString('message')),
      txid:
          (json['txid'] is num
              ? json['txid'].toString()
              : json.valueAsString('txid')),
      transaction:
          (json['transaction'] is num
              ? json['transaction'].toString()
              : json.valueAsString('transaction')),
    );
  }

  @override
  Map<String, dynamic> toJson() => {
    'result': result,
    'code': code,
    'message': message,
    'txid': txid,
    'transaction': transaction,
  };
}

class TronHttpResponseWalletBroadcasthexPostJavaTronError
    extends TronHttpResponseWalletBroadcasthexPost {
  final TronHttpJavaTronError value;
  const TronHttpResponseWalletBroadcasthexPostJavaTronError(this.value);

  @override
  dynamic toJson() => value.toJson();
}

sealed class TronHttpResponseWalletBroadcasttransactionPost {
  const TronHttpResponseWalletBroadcasttransactionPost();

  factory TronHttpResponseWalletBroadcasttransactionPost.fromJson(
    dynamic json,
  ) {
    if (json is Map) {
      final map =
          json is Map<String, dynamic> ? json : Map<String, dynamic>.from(json);
      if (map.hasValue('Error')) {
        return TronHttpResponseWalletBroadcasttransactionPostJavaTronError(
          TronHttpJavaTronError.fromJson(map),
        );
      }
      if (map.hasValue('result') &&
          map.hasValue('code') &&
          map.hasValue('message') &&
          map.hasValue('txid')) {
        return TronHttpResponseWalletBroadcasttransactionPostBroadcasttransactionPostResultObject1.fromJson(
          map,
        );
      }
    }
    throw CoreErrors.invalidOperationArguments(
      'TronHttpResponseWalletBroadcasttransactionPost',
      reason:
          'Cannot parse TronHttpResponseWalletBroadcasttransactionPost from $json',
    );
  }

  dynamic toJson();
}

class TronHttpResponseWalletBroadcasttransactionPostBroadcasttransactionPostResultObject1
    extends TronHttpResponseWalletBroadcasttransactionPost {
  final bool? result;
  final String? code;
  final String? message;
  final String? txid;

  const TronHttpResponseWalletBroadcasttransactionPostBroadcasttransactionPostResultObject1({
    this.result,
    this.code,
    this.message,
    this.txid,
  });

  factory TronHttpResponseWalletBroadcasttransactionPostBroadcasttransactionPostResultObject1.fromJson(
    Map<String, dynamic> json,
  ) {
    return TronHttpResponseWalletBroadcasttransactionPostBroadcasttransactionPostResultObject1(
      result: json.valueAsBool('result'),
      code:
          (json['code'] is num
              ? json['code'].toString()
              : json.valueAsString('code')),
      message:
          (json['message'] is num
              ? json['message'].toString()
              : json.valueAsString('message')),
      txid:
          (json['txid'] is num
              ? json['txid'].toString()
              : json.valueAsString('txid')),
    );
  }

  @override
  Map<String, dynamic> toJson() => {
    'result': result,
    'code': code,
    'message': message,
    'txid': txid,
  };
}

class TronHttpResponseWalletBroadcasttransactionPostJavaTronError
    extends TronHttpResponseWalletBroadcasttransactionPost {
  final TronHttpJavaTronError value;
  const TronHttpResponseWalletBroadcasttransactionPostJavaTronError(this.value);

  @override
  dynamic toJson() => value.toJson();
}

sealed class TronHttpResponseWalletCreateaccountPost {
  const TronHttpResponseWalletCreateaccountPost();

  factory TronHttpResponseWalletCreateaccountPost.fromJson(dynamic json) {
    if (json is Map) {
      final map =
          json is Map<String, dynamic> ? json : Map<String, dynamic>.from(json);
      if (map.hasValue('Error')) {
        return TronHttpResponseWalletCreateaccountPostJavaTronError(
          TronHttpJavaTronError.fromJson(map),
        );
      }
      if (map.hasValue('contract_address') ||
          map.hasValue('raw_data') ||
          map.hasValue('raw_data_hex') ||
          map.hasValue('ret') ||
          map.hasValue('signature') ||
          map.hasValue('txID') ||
          map.hasValue('visible')) {
        return TronHttpResponseWalletCreateaccountPostTransaction(
          TronHttpTransaction.fromJson(map),
        );
      }
    }
    throw CoreErrors.invalidOperationArguments(
      'TronHttpResponseWalletCreateaccountPost',
      reason: 'Cannot parse TronHttpResponseWalletCreateaccountPost from $json',
    );
  }

  dynamic toJson();
}

class TronHttpResponseWalletCreateaccountPostTransaction
    extends TronHttpResponseWalletCreateaccountPost {
  final TronHttpTransaction value;
  const TronHttpResponseWalletCreateaccountPostTransaction(this.value);

  @override
  dynamic toJson() => value.toJson();
}

class TronHttpResponseWalletCreateaccountPostJavaTronError
    extends TronHttpResponseWalletCreateaccountPost {
  final TronHttpJavaTronError value;
  const TronHttpResponseWalletCreateaccountPostJavaTronError(this.value);

  @override
  dynamic toJson() => value.toJson();
}

sealed class TronHttpResponseWalletEstimateenergyPost {
  const TronHttpResponseWalletEstimateenergyPost();

  factory TronHttpResponseWalletEstimateenergyPost.fromJson(dynamic json) {
    if (json is Map) {
      final map =
          json is Map<String, dynamic> ? json : Map<String, dynamic>.from(json);
      if (map.hasValue('Error')) {
        return TronHttpResponseWalletEstimateenergyPostJavaTronError(
          TronHttpJavaTronError.fromJson(map),
        );
      }
      if (map.hasValue('result') && map.hasValue('energy_required')) {
        return TronHttpResponseWalletEstimateenergyPostEstimateenergyPostResultObject1.fromJson(
          map,
        );
      }
    }
    throw CoreErrors.invalidOperationArguments(
      'TronHttpResponseWalletEstimateenergyPost',
      reason:
          'Cannot parse TronHttpResponseWalletEstimateenergyPost from $json',
    );
  }

  dynamic toJson();
}

class TronHttpResponseWalletEstimateenergyPostEstimateenergyPostResultObject1
    extends TronHttpResponseWalletEstimateenergyPost {
  final TronHttpResponseWalletEstimateenergyPostEstimateenergyPostResultObject1Result?
  result;
  final BigInt? energyRequired;

  const TronHttpResponseWalletEstimateenergyPostEstimateenergyPostResultObject1({
    this.result,
    this.energyRequired,
  });

  factory TronHttpResponseWalletEstimateenergyPostEstimateenergyPostResultObject1.fromJson(
    Map<String, dynamic> json,
  ) {
    return TronHttpResponseWalletEstimateenergyPostEstimateenergyPostResultObject1(
      result: json.valueTo<
        TronHttpResponseWalletEstimateenergyPostEstimateenergyPostResultObject1Result?,
        Map<String, dynamic>
      >(
        key: 'result',
        parse:
            (v) =>
                TronHttpResponseWalletEstimateenergyPostEstimateenergyPostResultObject1Result.fromJson(
                  v,
                ),
      ),
      energyRequired: json.valueAsBigInt('energy_required'),
    );
  }

  @override
  Map<String, dynamic> toJson() => {
    'result': result?.toJson(),
    'energy_required': energyRequired,
  };
}

class TronHttpResponseWalletEstimateenergyPostJavaTronError
    extends TronHttpResponseWalletEstimateenergyPost {
  final TronHttpJavaTronError value;
  const TronHttpResponseWalletEstimateenergyPostJavaTronError(this.value);

  @override
  dynamic toJson() => value.toJson();
}

sealed class TronHttpResponseWalletGetBrokerageGet {
  const TronHttpResponseWalletGetBrokerageGet();

  factory TronHttpResponseWalletGetBrokerageGet.fromJson(dynamic json) {
    if (json is Map) {
      final map =
          json is Map<String, dynamic> ? json : Map<String, dynamic>.from(json);
      if (map.hasValue('Error')) {
        return TronHttpResponseWalletGetBrokerageGetJavaTronError(
          TronHttpJavaTronError.fromJson(map),
        );
      }
      if (map.hasValue('brokerage') && map.hasValue('Error')) {
        return TronHttpResponseWalletGetBrokerageGetGetBrokerageGetResultObject1.fromJson(
          map,
        );
      }
    }
    throw CoreErrors.invalidOperationArguments(
      'TronHttpResponseWalletGetBrokerageGet',
      reason: 'Cannot parse TronHttpResponseWalletGetBrokerageGet from $json',
    );
  }

  dynamic toJson();
}

class TronHttpResponseWalletGetBrokerageGetGetBrokerageGetResultObject1
    extends TronHttpResponseWalletGetBrokerageGet {
  /// Witness brokerage percentage, from 0 to 100.
  final int? brokerage;
  final String? error;

  const TronHttpResponseWalletGetBrokerageGetGetBrokerageGetResultObject1({
    this.brokerage,
    this.error,
  });

  factory TronHttpResponseWalletGetBrokerageGetGetBrokerageGetResultObject1.fromJson(
    Map<String, dynamic> json,
  ) {
    return TronHttpResponseWalletGetBrokerageGetGetBrokerageGetResultObject1(
      brokerage: json.valueAsInt('brokerage'),
      error:
          (json['Error'] is num
              ? json['Error'].toString()
              : json.valueAsString('Error')),
    );
  }

  @override
  Map<String, dynamic> toJson() => {'brokerage': brokerage, 'Error': error};
}

class TronHttpResponseWalletGetBrokerageGetJavaTronError
    extends TronHttpResponseWalletGetBrokerageGet {
  final TronHttpJavaTronError value;
  const TronHttpResponseWalletGetBrokerageGetJavaTronError(this.value);

  @override
  dynamic toJson() => value.toJson();
}

sealed class TronHttpResponseWalletGetRewardGet {
  const TronHttpResponseWalletGetRewardGet();

  factory TronHttpResponseWalletGetRewardGet.fromJson(dynamic json) {
    if (json is Map) {
      final map =
          json is Map<String, dynamic> ? json : Map<String, dynamic>.from(json);
      if (map.hasValue('Error')) {
        return TronHttpResponseWalletGetRewardGetJavaTronError(
          TronHttpJavaTronError.fromJson(map),
        );
      }
      if (map.hasValue('reward')) {
        return TronHttpResponseWalletGetRewardGetGetRewardGetResultRequiresReward1.fromJson(
          map,
        );
      }
    }
    throw CoreErrors.invalidOperationArguments(
      'TronHttpResponseWalletGetRewardGet',
      reason: 'Cannot parse TronHttpResponseWalletGetRewardGet from $json',
    );
  }

  dynamic toJson();
}

class TronHttpResponseWalletGetRewardGetGetRewardGetResultRequiresReward1
    extends TronHttpResponseWalletGetRewardGet {
  final BigInt reward;
  final String? error;

  const TronHttpResponseWalletGetRewardGetGetRewardGetResultRequiresReward1({
    required this.reward,
    this.error,
  });

  factory TronHttpResponseWalletGetRewardGetGetRewardGetResultRequiresReward1.fromJson(
    Map<String, dynamic> json,
  ) {
    return TronHttpResponseWalletGetRewardGetGetRewardGetResultRequiresReward1(
      reward: json.valueAsBigInt('reward'),
      error:
          (json['Error'] is num
              ? json['Error'].toString()
              : json.valueAsString('Error')),
    );
  }

  @override
  Map<String, dynamic> toJson() => {'reward': reward, 'Error': error};
}

class TronHttpResponseWalletGetRewardGetJavaTronError
    extends TronHttpResponseWalletGetRewardGet {
  final TronHttpJavaTronError value;
  const TronHttpResponseWalletGetRewardGetJavaTronError(this.value);

  @override
  dynamic toJson() => value.toJson();
}

sealed class TronHttpResponseWalletGetRewardPost {
  const TronHttpResponseWalletGetRewardPost();

  factory TronHttpResponseWalletGetRewardPost.fromJson(dynamic json) {
    if (json is Map) {
      final map =
          json is Map<String, dynamic> ? json : Map<String, dynamic>.from(json);
      if (map.hasValue('Error')) {
        return TronHttpResponseWalletGetRewardPostJavaTronError(
          TronHttpJavaTronError.fromJson(map),
        );
      }
      if (map.hasValue('reward')) {
        return TronHttpResponseWalletGetRewardPostGetRewardPostResultRequiresReward1.fromJson(
          map,
        );
      }
    }
    throw CoreErrors.invalidOperationArguments(
      'TronHttpResponseWalletGetRewardPost',
      reason: 'Cannot parse TronHttpResponseWalletGetRewardPost from $json',
    );
  }

  dynamic toJson();
}

class TronHttpResponseWalletGetRewardPostGetRewardPostResultRequiresReward1
    extends TronHttpResponseWalletGetRewardPost {
  final BigInt reward;
  final String? error;

  const TronHttpResponseWalletGetRewardPostGetRewardPostResultRequiresReward1({
    required this.reward,
    this.error,
  });

  factory TronHttpResponseWalletGetRewardPostGetRewardPostResultRequiresReward1.fromJson(
    Map<String, dynamic> json,
  ) {
    return TronHttpResponseWalletGetRewardPostGetRewardPostResultRequiresReward1(
      reward: json.valueAsBigInt('reward'),
      error:
          (json['Error'] is num
              ? json['Error'].toString()
              : json.valueAsString('Error')),
    );
  }

  @override
  Map<String, dynamic> toJson() => {'reward': reward, 'Error': error};
}

class TronHttpResponseWalletGetRewardPostJavaTronError
    extends TronHttpResponseWalletGetRewardPost {
  final TronHttpJavaTronError value;
  const TronHttpResponseWalletGetRewardPostJavaTronError(this.value);

  @override
  dynamic toJson() => value.toJson();
}

sealed class TronHttpResponseWalletGetaccountGet {
  const TronHttpResponseWalletGetaccountGet();

  factory TronHttpResponseWalletGetaccountGet.fromJson(dynamic json) {
    if (json is Map) {
      final map =
          json is Map<String, dynamic> ? json : Map<String, dynamic>.from(json);
      if (map.hasValue('Error')) {
        return TronHttpResponseWalletGetaccountGetJavaTronError(
          TronHttpJavaTronError.fromJson(map),
        );
      }
      if (map.hasValue('account_id') ||
          map.hasValue('account_name') ||
          map.hasValue('account_resource') ||
          map.hasValue('acquired_delegated_frozenV2_balance_for_bandwidth') ||
          map.hasValue('acquired_delegated_frozen_balance_for_bandwidth') ||
          map.hasValue('active_permission') ||
          map.hasValue('address') ||
          map.hasValue('allowance') ||
          map.hasValue('asset') ||
          map.hasValue('assetV2') ||
          map.hasValue('asset_issued_ID') ||
          map.hasValue('asset_issued_name') ||
          map.hasValue('asset_optimized') ||
          map.hasValue('balance') ||
          map.hasValue('code') ||
          map.hasValue('codeHash') ||
          map.hasValue('create_time') ||
          map.hasValue('delegated_frozenV2_balance_for_bandwidth') ||
          map.hasValue('delegated_frozen_balance_for_bandwidth') ||
          map.hasValue('free_asset_net_usage') ||
          map.hasValue('free_asset_net_usageV2') ||
          map.hasValue('free_net_usage') ||
          map.hasValue('frozen') ||
          map.hasValue('frozenV2') ||
          map.hasValue('frozen_supply') ||
          map.hasValue('is_committee') ||
          map.hasValue('is_witness') ||
          map.hasValue('latest_asset_operation_time') ||
          map.hasValue('latest_asset_operation_timeV2') ||
          map.hasValue('latest_consume_free_time') ||
          map.hasValue('latest_consume_time') ||
          map.hasValue('latest_opration_time') ||
          map.hasValue('latest_withdraw_time') ||
          map.hasValue('net_usage') ||
          map.hasValue('net_window_optimized') ||
          map.hasValue('net_window_size') ||
          map.hasValue('old_tron_power') ||
          map.hasValue('owner_permission') ||
          map.hasValue('tron_power') ||
          map.hasValue('type') ||
          map.hasValue('unfrozenV2') ||
          map.hasValue('votes') ||
          map.hasValue('witness_permission')) {
        return TronHttpResponseWalletGetaccountGetAccountInt64StringCompatible(
          TronHttpAccountInt64StringCompatible.fromJson(map),
        );
      }
    }
    throw CoreErrors.invalidOperationArguments(
      'TronHttpResponseWalletGetaccountGet',
      reason: 'Cannot parse TronHttpResponseWalletGetaccountGet from $json',
    );
  }

  dynamic toJson();
}

class TronHttpResponseWalletGetaccountGetAccountInt64StringCompatible
    extends TronHttpResponseWalletGetaccountGet {
  final TronHttpAccountInt64StringCompatible value;
  const TronHttpResponseWalletGetaccountGetAccountInt64StringCompatible(
    this.value,
  );

  @override
  dynamic toJson() => value.toJson();
}

class TronHttpResponseWalletGetaccountGetJavaTronError
    extends TronHttpResponseWalletGetaccountGet {
  final TronHttpJavaTronError value;
  const TronHttpResponseWalletGetaccountGetJavaTronError(this.value);

  @override
  dynamic toJson() => value.toJson();
}

sealed class TronHttpResponseWalletGetaccountPost {
  const TronHttpResponseWalletGetaccountPost();

  factory TronHttpResponseWalletGetaccountPost.fromJson(dynamic json) {
    if (json is Map) {
      final map =
          json is Map<String, dynamic> ? json : Map<String, dynamic>.from(json);
      if (map.hasValue('Error')) {
        return TronHttpResponseWalletGetaccountPostJavaTronError(
          TronHttpJavaTronError.fromJson(map),
        );
      }
      if (map.hasValue('account_id') ||
          map.hasValue('account_name') ||
          map.hasValue('account_resource') ||
          map.hasValue('acquired_delegated_frozenV2_balance_for_bandwidth') ||
          map.hasValue('acquired_delegated_frozen_balance_for_bandwidth') ||
          map.hasValue('active_permission') ||
          map.hasValue('address') ||
          map.hasValue('allowance') ||
          map.hasValue('asset') ||
          map.hasValue('assetV2') ||
          map.hasValue('asset_issued_ID') ||
          map.hasValue('asset_issued_name') ||
          map.hasValue('asset_optimized') ||
          map.hasValue('balance') ||
          map.hasValue('code') ||
          map.hasValue('codeHash') ||
          map.hasValue('create_time') ||
          map.hasValue('delegated_frozenV2_balance_for_bandwidth') ||
          map.hasValue('delegated_frozen_balance_for_bandwidth') ||
          map.hasValue('free_asset_net_usage') ||
          map.hasValue('free_asset_net_usageV2') ||
          map.hasValue('free_net_usage') ||
          map.hasValue('frozen') ||
          map.hasValue('frozenV2') ||
          map.hasValue('frozen_supply') ||
          map.hasValue('is_committee') ||
          map.hasValue('is_witness') ||
          map.hasValue('latest_asset_operation_time') ||
          map.hasValue('latest_asset_operation_timeV2') ||
          map.hasValue('latest_consume_free_time') ||
          map.hasValue('latest_consume_time') ||
          map.hasValue('latest_opration_time') ||
          map.hasValue('latest_withdraw_time') ||
          map.hasValue('net_usage') ||
          map.hasValue('net_window_optimized') ||
          map.hasValue('net_window_size') ||
          map.hasValue('old_tron_power') ||
          map.hasValue('owner_permission') ||
          map.hasValue('tron_power') ||
          map.hasValue('type') ||
          map.hasValue('unfrozenV2') ||
          map.hasValue('votes') ||
          map.hasValue('witness_permission')) {
        return TronHttpResponseWalletGetaccountPostAccount(
          TronHttpAccount.fromJson(map),
        );
      }
    }
    throw CoreErrors.invalidOperationArguments(
      'TronHttpResponseWalletGetaccountPost',
      reason: 'Cannot parse TronHttpResponseWalletGetaccountPost from $json',
    );
  }

  dynamic toJson();
}

class TronHttpResponseWalletGetaccountPostAccount
    extends TronHttpResponseWalletGetaccountPost {
  final TronHttpAccount value;
  const TronHttpResponseWalletGetaccountPostAccount(this.value);

  @override
  dynamic toJson() => value.toJson();
}

class TronHttpResponseWalletGetaccountPostJavaTronError
    extends TronHttpResponseWalletGetaccountPost {
  final TronHttpJavaTronError value;
  const TronHttpResponseWalletGetaccountPostJavaTronError(this.value);

  @override
  dynamic toJson() => value.toJson();
}

sealed class TronHttpResponseWalletGetaccountbalancePost {
  const TronHttpResponseWalletGetaccountbalancePost();

  factory TronHttpResponseWalletGetaccountbalancePost.fromJson(dynamic json) {
    if (json is Map) {
      final map =
          json is Map<String, dynamic> ? json : Map<String, dynamic>.from(json);
      if (map.hasValue('Error')) {
        return TronHttpResponseWalletGetaccountbalancePostJavaTronError(
          TronHttpJavaTronError.fromJson(map),
        );
      }
      if (map.hasValue('balance') || map.hasValue('block_identifier')) {
        return TronHttpResponseWalletGetaccountbalancePostAccountBalanceResponse(
          TronHttpAccountBalanceResponse.fromJson(map),
        );
      }
    }
    throw CoreErrors.invalidOperationArguments(
      'TronHttpResponseWalletGetaccountbalancePost',
      reason:
          'Cannot parse TronHttpResponseWalletGetaccountbalancePost from $json',
    );
  }

  dynamic toJson();
}

class TronHttpResponseWalletGetaccountbalancePostAccountBalanceResponse
    extends TronHttpResponseWalletGetaccountbalancePost {
  final TronHttpAccountBalanceResponse value;
  const TronHttpResponseWalletGetaccountbalancePostAccountBalanceResponse(
    this.value,
  );

  @override
  dynamic toJson() => value.toJson();
}

class TronHttpResponseWalletGetaccountbalancePostJavaTronError
    extends TronHttpResponseWalletGetaccountbalancePost {
  final TronHttpJavaTronError value;
  const TronHttpResponseWalletGetaccountbalancePostJavaTronError(this.value);

  @override
  dynamic toJson() => value.toJson();
}

sealed class TronHttpResponseWalletGetaccountnetGet {
  const TronHttpResponseWalletGetaccountnetGet();

  factory TronHttpResponseWalletGetaccountnetGet.fromJson(dynamic json) {
    if (json is Map) {
      final map =
          json is Map<String, dynamic> ? json : Map<String, dynamic>.from(json);
      if (map.hasValue('Error')) {
        return TronHttpResponseWalletGetaccountnetGetJavaTronError(
          TronHttpJavaTronError.fromJson(map),
        );
      }
      if (map.hasValue('NetLimit') ||
          map.hasValue('NetUsed') ||
          map.hasValue('TotalNetLimit') ||
          map.hasValue('TotalNetWeight') ||
          map.hasValue('assetNetLimit') ||
          map.hasValue('assetNetUsed') ||
          map.hasValue('freeNetLimit') ||
          map.hasValue('freeNetUsed')) {
        return TronHttpResponseWalletGetaccountnetGetAccountNetMessageInt64StringCompatible(
          TronHttpAccountNetMessageInt64StringCompatible.fromJson(map),
        );
      }
    }
    throw CoreErrors.invalidOperationArguments(
      'TronHttpResponseWalletGetaccountnetGet',
      reason: 'Cannot parse TronHttpResponseWalletGetaccountnetGet from $json',
    );
  }

  dynamic toJson();
}

class TronHttpResponseWalletGetaccountnetGetAccountNetMessageInt64StringCompatible
    extends TronHttpResponseWalletGetaccountnetGet {
  final TronHttpAccountNetMessageInt64StringCompatible value;
  const TronHttpResponseWalletGetaccountnetGetAccountNetMessageInt64StringCompatible(
    this.value,
  );

  @override
  dynamic toJson() => value.toJson();
}

class TronHttpResponseWalletGetaccountnetGetJavaTronError
    extends TronHttpResponseWalletGetaccountnetGet {
  final TronHttpJavaTronError value;
  const TronHttpResponseWalletGetaccountnetGetJavaTronError(this.value);

  @override
  dynamic toJson() => value.toJson();
}

sealed class TronHttpResponseWalletGetaccountnetPost {
  const TronHttpResponseWalletGetaccountnetPost();

  factory TronHttpResponseWalletGetaccountnetPost.fromJson(dynamic json) {
    if (json is Map) {
      final map =
          json is Map<String, dynamic> ? json : Map<String, dynamic>.from(json);
      if (map.hasValue('Error')) {
        return TronHttpResponseWalletGetaccountnetPostJavaTronError(
          TronHttpJavaTronError.fromJson(map),
        );
      }
      if (map.hasValue('NetLimit') ||
          map.hasValue('NetUsed') ||
          map.hasValue('TotalNetLimit') ||
          map.hasValue('TotalNetWeight') ||
          map.hasValue('assetNetLimit') ||
          map.hasValue('assetNetUsed') ||
          map.hasValue('freeNetLimit') ||
          map.hasValue('freeNetUsed')) {
        return TronHttpResponseWalletGetaccountnetPostAccountNetMessage(
          TronHttpAccountNetMessage.fromJson(map),
        );
      }
    }
    throw CoreErrors.invalidOperationArguments(
      'TronHttpResponseWalletGetaccountnetPost',
      reason: 'Cannot parse TronHttpResponseWalletGetaccountnetPost from $json',
    );
  }

  dynamic toJson();
}

class TronHttpResponseWalletGetaccountnetPostAccountNetMessage
    extends TronHttpResponseWalletGetaccountnetPost {
  final TronHttpAccountNetMessage value;
  const TronHttpResponseWalletGetaccountnetPostAccountNetMessage(this.value);

  @override
  dynamic toJson() => value.toJson();
}

class TronHttpResponseWalletGetaccountnetPostJavaTronError
    extends TronHttpResponseWalletGetaccountnetPost {
  final TronHttpJavaTronError value;
  const TronHttpResponseWalletGetaccountnetPostJavaTronError(this.value);

  @override
  dynamic toJson() => value.toJson();
}

sealed class TronHttpResponseWalletGetaccountresourceGet {
  const TronHttpResponseWalletGetaccountresourceGet();

  factory TronHttpResponseWalletGetaccountresourceGet.fromJson(dynamic json) {
    if (json is Map) {
      final map =
          json is Map<String, dynamic> ? json : Map<String, dynamic>.from(json);
      if (map.hasValue('Error')) {
        return TronHttpResponseWalletGetaccountresourceGetJavaTronError(
          TronHttpJavaTronError.fromJson(map),
        );
      }
      if (map.hasValue('EnergyLimit') ||
          map.hasValue('EnergyUsed') ||
          map.hasValue('NetLimit') ||
          map.hasValue('NetUsed') ||
          map.hasValue('TotalEnergyLimit') ||
          map.hasValue('TotalEnergyWeight') ||
          map.hasValue('TotalNetLimit') ||
          map.hasValue('TotalNetWeight') ||
          map.hasValue('TotalTronPowerWeight') ||
          map.hasValue('assetNetLimit') ||
          map.hasValue('assetNetUsed') ||
          map.hasValue('freeNetLimit') ||
          map.hasValue('freeNetUsed') ||
          map.hasValue('storageLimit') ||
          map.hasValue('storageUsed') ||
          map.hasValue('tronPowerLimit') ||
          map.hasValue('tronPowerUsed')) {
        return TronHttpResponseWalletGetaccountresourceGetAccountResourceMessageInt64StringCompatible(
          TronHttpAccountResourceMessageInt64StringCompatible.fromJson(map),
        );
      }
    }
    throw CoreErrors.invalidOperationArguments(
      'TronHttpResponseWalletGetaccountresourceGet',
      reason:
          'Cannot parse TronHttpResponseWalletGetaccountresourceGet from $json',
    );
  }

  dynamic toJson();
}

class TronHttpResponseWalletGetaccountresourceGetAccountResourceMessageInt64StringCompatible
    extends TronHttpResponseWalletGetaccountresourceGet {
  final TronHttpAccountResourceMessageInt64StringCompatible value;
  const TronHttpResponseWalletGetaccountresourceGetAccountResourceMessageInt64StringCompatible(
    this.value,
  );

  @override
  dynamic toJson() => value.toJson();
}

class TronHttpResponseWalletGetaccountresourceGetJavaTronError
    extends TronHttpResponseWalletGetaccountresourceGet {
  final TronHttpJavaTronError value;
  const TronHttpResponseWalletGetaccountresourceGetJavaTronError(this.value);

  @override
  dynamic toJson() => value.toJson();
}

sealed class TronHttpResponseWalletGetaccountresourcePost {
  const TronHttpResponseWalletGetaccountresourcePost();

  factory TronHttpResponseWalletGetaccountresourcePost.fromJson(dynamic json) {
    if (json is Map) {
      final map =
          json is Map<String, dynamic> ? json : Map<String, dynamic>.from(json);
      if (map.hasValue('Error')) {
        return TronHttpResponseWalletGetaccountresourcePostJavaTronError(
          TronHttpJavaTronError.fromJson(map),
        );
      }
      if (map.hasValue('EnergyLimit') ||
          map.hasValue('EnergyUsed') ||
          map.hasValue('NetLimit') ||
          map.hasValue('NetUsed') ||
          map.hasValue('TotalEnergyLimit') ||
          map.hasValue('TotalEnergyWeight') ||
          map.hasValue('TotalNetLimit') ||
          map.hasValue('TotalNetWeight') ||
          map.hasValue('TotalTronPowerWeight') ||
          map.hasValue('assetNetLimit') ||
          map.hasValue('assetNetUsed') ||
          map.hasValue('freeNetLimit') ||
          map.hasValue('freeNetUsed') ||
          map.hasValue('storageLimit') ||
          map.hasValue('storageUsed') ||
          map.hasValue('tronPowerLimit') ||
          map.hasValue('tronPowerUsed')) {
        return TronHttpResponseWalletGetaccountresourcePostAccountResourceMessage(
          TronHttpAccountResourceMessage.fromJson(map),
        );
      }
    }
    throw CoreErrors.invalidOperationArguments(
      'TronHttpResponseWalletGetaccountresourcePost',
      reason:
          'Cannot parse TronHttpResponseWalletGetaccountresourcePost from $json',
    );
  }

  dynamic toJson();
}

class TronHttpResponseWalletGetaccountresourcePostAccountResourceMessage
    extends TronHttpResponseWalletGetaccountresourcePost {
  final TronHttpAccountResourceMessage value;
  const TronHttpResponseWalletGetaccountresourcePostAccountResourceMessage(
    this.value,
  );

  @override
  dynamic toJson() => value.toJson();
}

class TronHttpResponseWalletGetaccountresourcePostJavaTronError
    extends TronHttpResponseWalletGetaccountresourcePost {
  final TronHttpJavaTronError value;
  const TronHttpResponseWalletGetaccountresourcePostJavaTronError(this.value);

  @override
  dynamic toJson() => value.toJson();
}

sealed class TronHttpResponseWalletGetapprovedlistPost {
  const TronHttpResponseWalletGetapprovedlistPost();

  factory TronHttpResponseWalletGetapprovedlistPost.fromJson(dynamic json) {
    if (json is Map) {
      final map =
          json is Map<String, dynamic> ? json : Map<String, dynamic>.from(json);
      if (map.hasValue('Error')) {
        return TronHttpResponseWalletGetapprovedlistPostJavaTronError(
          TronHttpJavaTronError.fromJson(map),
        );
      }
      if (map.hasValue('approved_list') ||
          map.hasValue('result') ||
          map.hasValue('transaction')) {
        return TronHttpResponseWalletGetapprovedlistPostTransactionApprovedList(
          TronHttpTransactionApprovedList.fromJson(map),
        );
      }
    }
    throw CoreErrors.invalidOperationArguments(
      'TronHttpResponseWalletGetapprovedlistPost',
      reason:
          'Cannot parse TronHttpResponseWalletGetapprovedlistPost from $json',
    );
  }

  dynamic toJson();
}

class TronHttpResponseWalletGetapprovedlistPostTransactionApprovedList
    extends TronHttpResponseWalletGetapprovedlistPost {
  final TronHttpTransactionApprovedList value;
  const TronHttpResponseWalletGetapprovedlistPostTransactionApprovedList(
    this.value,
  );

  @override
  dynamic toJson() => value.toJson();
}

class TronHttpResponseWalletGetapprovedlistPostJavaTronError
    extends TronHttpResponseWalletGetapprovedlistPost {
  final TronHttpJavaTronError value;
  const TronHttpResponseWalletGetapprovedlistPostJavaTronError(this.value);

  @override
  dynamic toJson() => value.toJson();
}

sealed class TronHttpResponseWalletGetassetissuebyidGet {
  const TronHttpResponseWalletGetassetissuebyidGet();

  factory TronHttpResponseWalletGetassetissuebyidGet.fromJson(dynamic json) {
    if (json is Map) {
      final map =
          json is Map<String, dynamic> ? json : Map<String, dynamic>.from(json);
      if (map.hasValue('Error')) {
        return TronHttpResponseWalletGetassetissuebyidGetJavaTronError(
          TronHttpJavaTronError.fromJson(map),
        );
      }
      if (map.hasValue('abbr') ||
          map.hasValue('description') ||
          map.hasValue('end_time') ||
          map.hasValue('free_asset_net_limit') ||
          map.hasValue('frozen_supply') ||
          map.hasValue('id') ||
          map.hasValue('name') ||
          map.hasValue('num') ||
          map.hasValue('order') ||
          map.hasValue('owner_address') ||
          map.hasValue('precision') ||
          map.hasValue('public_free_asset_net_limit') ||
          map.hasValue('public_free_asset_net_usage') ||
          map.hasValue('public_latest_free_net_time') ||
          map.hasValue('start_time') ||
          map.hasValue('total_supply') ||
          map.hasValue('trx_num') ||
          map.hasValue('url') ||
          map.hasValue('vote_score')) {
        return TronHttpResponseWalletGetassetissuebyidGetAssetIssueContractInt64StringCompatible(
          TronHttpAssetIssueContractInt64StringCompatible.fromJson(map),
        );
      }
    }
    throw CoreErrors.invalidOperationArguments(
      'TronHttpResponseWalletGetassetissuebyidGet',
      reason:
          'Cannot parse TronHttpResponseWalletGetassetissuebyidGet from $json',
    );
  }

  dynamic toJson();
}

class TronHttpResponseWalletGetassetissuebyidGetAssetIssueContractInt64StringCompatible
    extends TronHttpResponseWalletGetassetissuebyidGet {
  final TronHttpAssetIssueContractInt64StringCompatible value;
  const TronHttpResponseWalletGetassetissuebyidGetAssetIssueContractInt64StringCompatible(
    this.value,
  );

  @override
  dynamic toJson() => value.toJson();
}

class TronHttpResponseWalletGetassetissuebyidGetJavaTronError
    extends TronHttpResponseWalletGetassetissuebyidGet {
  final TronHttpJavaTronError value;
  const TronHttpResponseWalletGetassetissuebyidGetJavaTronError(this.value);

  @override
  dynamic toJson() => value.toJson();
}

sealed class TronHttpResponseWalletGetassetissuebyidPost {
  const TronHttpResponseWalletGetassetissuebyidPost();

  factory TronHttpResponseWalletGetassetissuebyidPost.fromJson(dynamic json) {
    if (json is Map) {
      final map =
          json is Map<String, dynamic> ? json : Map<String, dynamic>.from(json);
      if (map.hasValue('Error')) {
        return TronHttpResponseWalletGetassetissuebyidPostJavaTronError(
          TronHttpJavaTronError.fromJson(map),
        );
      }
      if (map.hasValue('abbr') ||
          map.hasValue('description') ||
          map.hasValue('end_time') ||
          map.hasValue('free_asset_net_limit') ||
          map.hasValue('frozen_supply') ||
          map.hasValue('id') ||
          map.hasValue('name') ||
          map.hasValue('num') ||
          map.hasValue('order') ||
          map.hasValue('owner_address') ||
          map.hasValue('precision') ||
          map.hasValue('public_free_asset_net_limit') ||
          map.hasValue('public_free_asset_net_usage') ||
          map.hasValue('public_latest_free_net_time') ||
          map.hasValue('start_time') ||
          map.hasValue('total_supply') ||
          map.hasValue('trx_num') ||
          map.hasValue('url') ||
          map.hasValue('vote_score')) {
        return TronHttpResponseWalletGetassetissuebyidPostAssetIssueContract(
          TronHttpAssetIssueContract.fromJson(map),
        );
      }
    }
    throw CoreErrors.invalidOperationArguments(
      'TronHttpResponseWalletGetassetissuebyidPost',
      reason:
          'Cannot parse TronHttpResponseWalletGetassetissuebyidPost from $json',
    );
  }

  dynamic toJson();
}

class TronHttpResponseWalletGetassetissuebyidPostAssetIssueContract
    extends TronHttpResponseWalletGetassetissuebyidPost {
  final TronHttpAssetIssueContract value;
  const TronHttpResponseWalletGetassetissuebyidPostAssetIssueContract(
    this.value,
  );

  @override
  dynamic toJson() => value.toJson();
}

class TronHttpResponseWalletGetassetissuebyidPostJavaTronError
    extends TronHttpResponseWalletGetassetissuebyidPost {
  final TronHttpJavaTronError value;
  const TronHttpResponseWalletGetassetissuebyidPostJavaTronError(this.value);

  @override
  dynamic toJson() => value.toJson();
}

sealed class TronHttpResponseWalletGetassetissuelistbynameGet {
  const TronHttpResponseWalletGetassetissuelistbynameGet();

  factory TronHttpResponseWalletGetassetissuelistbynameGet.fromJson(
    dynamic json,
  ) {
    if (json is Map) {
      final map =
          json is Map<String, dynamic> ? json : Map<String, dynamic>.from(json);
      if (map.hasValue('Error')) {
        return TronHttpResponseWalletGetassetissuelistbynameGetJavaTronError(
          TronHttpJavaTronError.fromJson(map),
        );
      }
      if (map.hasValue('assetIssue')) {
        return TronHttpResponseWalletGetassetissuelistbynameGetAssetIssueListInt64StringCompatible(
          TronHttpAssetIssueListInt64StringCompatible.fromJson(map),
        );
      }
    }
    throw CoreErrors.invalidOperationArguments(
      'TronHttpResponseWalletGetassetissuelistbynameGet',
      reason:
          'Cannot parse TronHttpResponseWalletGetassetissuelistbynameGet from $json',
    );
  }

  dynamic toJson();
}

class TronHttpResponseWalletGetassetissuelistbynameGetAssetIssueListInt64StringCompatible
    extends TronHttpResponseWalletGetassetissuelistbynameGet {
  final TronHttpAssetIssueListInt64StringCompatible value;
  const TronHttpResponseWalletGetassetissuelistbynameGetAssetIssueListInt64StringCompatible(
    this.value,
  );

  @override
  dynamic toJson() => value.toJson();
}

class TronHttpResponseWalletGetassetissuelistbynameGetJavaTronError
    extends TronHttpResponseWalletGetassetissuelistbynameGet {
  final TronHttpJavaTronError value;
  const TronHttpResponseWalletGetassetissuelistbynameGetJavaTronError(
    this.value,
  );

  @override
  dynamic toJson() => value.toJson();
}

sealed class TronHttpResponseWalletGetassetissuelistbynamePost {
  const TronHttpResponseWalletGetassetissuelistbynamePost();

  factory TronHttpResponseWalletGetassetissuelistbynamePost.fromJson(
    dynamic json,
  ) {
    if (json is Map) {
      final map =
          json is Map<String, dynamic> ? json : Map<String, dynamic>.from(json);
      if (map.hasValue('Error')) {
        return TronHttpResponseWalletGetassetissuelistbynamePostJavaTronError(
          TronHttpJavaTronError.fromJson(map),
        );
      }
      if (map.hasValue('assetIssue')) {
        return TronHttpResponseWalletGetassetissuelistbynamePostAssetIssueList(
          TronHttpAssetIssueList.fromJson(map),
        );
      }
    }
    throw CoreErrors.invalidOperationArguments(
      'TronHttpResponseWalletGetassetissuelistbynamePost',
      reason:
          'Cannot parse TronHttpResponseWalletGetassetissuelistbynamePost from $json',
    );
  }

  dynamic toJson();
}

class TronHttpResponseWalletGetassetissuelistbynamePostAssetIssueList
    extends TronHttpResponseWalletGetassetissuelistbynamePost {
  final TronHttpAssetIssueList value;
  const TronHttpResponseWalletGetassetissuelistbynamePostAssetIssueList(
    this.value,
  );

  @override
  dynamic toJson() => value.toJson();
}

class TronHttpResponseWalletGetassetissuelistbynamePostJavaTronError
    extends TronHttpResponseWalletGetassetissuelistbynamePost {
  final TronHttpJavaTronError value;
  const TronHttpResponseWalletGetassetissuelistbynamePostJavaTronError(
    this.value,
  );

  @override
  dynamic toJson() => value.toJson();
}

sealed class TronHttpResponseWalletGetavailableunfreezecountGet {
  const TronHttpResponseWalletGetavailableunfreezecountGet();

  factory TronHttpResponseWalletGetavailableunfreezecountGet.fromJson(
    dynamic json,
  ) {
    if (json is Map) {
      final map =
          json is Map<String, dynamic> ? json : Map<String, dynamic>.from(json);
      if (map.hasValue('Error')) {
        return TronHttpResponseWalletGetavailableunfreezecountGetJavaTronError(
          TronHttpJavaTronError.fromJson(map),
        );
      }
      if (map.hasValue('count')) {
        return TronHttpResponseWalletGetavailableunfreezecountGetGetAvailableUnfreezeCountResponseMessageInt64StringCompatible(
          TronHttpGetAvailableUnfreezeCountResponseMessageInt64StringCompatible.fromJson(
            map,
          ),
        );
      }
    }
    throw CoreErrors.invalidOperationArguments(
      'TronHttpResponseWalletGetavailableunfreezecountGet',
      reason:
          'Cannot parse TronHttpResponseWalletGetavailableunfreezecountGet from $json',
    );
  }

  dynamic toJson();
}

class TronHttpResponseWalletGetavailableunfreezecountGetGetAvailableUnfreezeCountResponseMessageInt64StringCompatible
    extends TronHttpResponseWalletGetavailableunfreezecountGet {
  final TronHttpGetAvailableUnfreezeCountResponseMessageInt64StringCompatible
  value;
  const TronHttpResponseWalletGetavailableunfreezecountGetGetAvailableUnfreezeCountResponseMessageInt64StringCompatible(
    this.value,
  );

  @override
  dynamic toJson() => value.toJson();
}

class TronHttpResponseWalletGetavailableunfreezecountGetJavaTronError
    extends TronHttpResponseWalletGetavailableunfreezecountGet {
  final TronHttpJavaTronError value;
  const TronHttpResponseWalletGetavailableunfreezecountGetJavaTronError(
    this.value,
  );

  @override
  dynamic toJson() => value.toJson();
}

sealed class TronHttpResponseWalletGetavailableunfreezecountPost {
  const TronHttpResponseWalletGetavailableunfreezecountPost();

  factory TronHttpResponseWalletGetavailableunfreezecountPost.fromJson(
    dynamic json,
  ) {
    if (json is Map) {
      final map =
          json is Map<String, dynamic> ? json : Map<String, dynamic>.from(json);
      if (map.hasValue('Error')) {
        return TronHttpResponseWalletGetavailableunfreezecountPostJavaTronError(
          TronHttpJavaTronError.fromJson(map),
        );
      }
      if (map.hasValue('count')) {
        return TronHttpResponseWalletGetavailableunfreezecountPostGetAvailableUnfreezeCountResponseMessage(
          TronHttpGetAvailableUnfreezeCountResponseMessage.fromJson(map),
        );
      }
    }
    throw CoreErrors.invalidOperationArguments(
      'TronHttpResponseWalletGetavailableunfreezecountPost',
      reason:
          'Cannot parse TronHttpResponseWalletGetavailableunfreezecountPost from $json',
    );
  }

  dynamic toJson();
}

class TronHttpResponseWalletGetavailableunfreezecountPostGetAvailableUnfreezeCountResponseMessage
    extends TronHttpResponseWalletGetavailableunfreezecountPost {
  final TronHttpGetAvailableUnfreezeCountResponseMessage value;
  const TronHttpResponseWalletGetavailableunfreezecountPostGetAvailableUnfreezeCountResponseMessage(
    this.value,
  );

  @override
  dynamic toJson() => value.toJson();
}

class TronHttpResponseWalletGetavailableunfreezecountPostJavaTronError
    extends TronHttpResponseWalletGetavailableunfreezecountPost {
  final TronHttpJavaTronError value;
  const TronHttpResponseWalletGetavailableunfreezecountPostJavaTronError(
    this.value,
  );

  @override
  dynamic toJson() => value.toJson();
}

sealed class TronHttpResponseWalletGetblockGet {
  const TronHttpResponseWalletGetblockGet();

  factory TronHttpResponseWalletGetblockGet.fromJson(dynamic json) {
    if (json is Map) {
      final map =
          json is Map<String, dynamic> ? json : Map<String, dynamic>.from(json);
      if (map.hasValue('Error')) {
        return TronHttpResponseWalletGetblockGetJavaTronError(
          TronHttpJavaTronError.fromJson(map),
        );
      }
      if (map.hasValue('blockID') ||
          map.hasValue('block_header') ||
          map.hasValue('transactions')) {
        return TronHttpResponseWalletGetblockGetBlockInt64StringCompatible(
          TronHttpBlockInt64StringCompatible.fromJson(map),
        );
      }
    }
    throw CoreErrors.invalidOperationArguments(
      'TronHttpResponseWalletGetblockGet',
      reason: 'Cannot parse TronHttpResponseWalletGetblockGet from $json',
    );
  }

  dynamic toJson();
}

class TronHttpResponseWalletGetblockGetBlockInt64StringCompatible
    extends TronHttpResponseWalletGetblockGet {
  final TronHttpBlockInt64StringCompatible value;
  const TronHttpResponseWalletGetblockGetBlockInt64StringCompatible(this.value);

  @override
  dynamic toJson() => value.toJson();
}

class TronHttpResponseWalletGetblockGetJavaTronError
    extends TronHttpResponseWalletGetblockGet {
  final TronHttpJavaTronError value;
  const TronHttpResponseWalletGetblockGetJavaTronError(this.value);

  @override
  dynamic toJson() => value.toJson();
}

sealed class TronHttpResponseWalletGetblockPost {
  const TronHttpResponseWalletGetblockPost();

  factory TronHttpResponseWalletGetblockPost.fromJson(dynamic json) {
    if (json is Map) {
      final map =
          json is Map<String, dynamic> ? json : Map<String, dynamic>.from(json);
      if (map.hasValue('Error')) {
        return TronHttpResponseWalletGetblockPostJavaTronError(
          TronHttpJavaTronError.fromJson(map),
        );
      }
      if (map.hasValue('blockID') ||
          map.hasValue('block_header') ||
          map.hasValue('transactions')) {
        return TronHttpResponseWalletGetblockPostBlock(
          TronHttpBlock.fromJson(map),
        );
      }
    }
    throw CoreErrors.invalidOperationArguments(
      'TronHttpResponseWalletGetblockPost',
      reason: 'Cannot parse TronHttpResponseWalletGetblockPost from $json',
    );
  }

  dynamic toJson();
}

class TronHttpResponseWalletGetblockPostBlock
    extends TronHttpResponseWalletGetblockPost {
  final TronHttpBlock value;
  const TronHttpResponseWalletGetblockPostBlock(this.value);

  @override
  dynamic toJson() => value.toJson();
}

class TronHttpResponseWalletGetblockPostJavaTronError
    extends TronHttpResponseWalletGetblockPost {
  final TronHttpJavaTronError value;
  const TronHttpResponseWalletGetblockPostJavaTronError(this.value);

  @override
  dynamic toJson() => value.toJson();
}

sealed class TronHttpResponseWalletGetblockbalancePost {
  const TronHttpResponseWalletGetblockbalancePost();

  factory TronHttpResponseWalletGetblockbalancePost.fromJson(dynamic json) {
    if (json is Map) {
      final map =
          json is Map<String, dynamic> ? json : Map<String, dynamic>.from(json);
      if (map.hasValue('Error')) {
        return TronHttpResponseWalletGetblockbalancePostJavaTronError(
          TronHttpJavaTronError.fromJson(map),
        );
      }
      if (map.hasValue('block_identifier') ||
          map.hasValue('timestamp') ||
          map.hasValue('transaction_balance_trace')) {
        return TronHttpResponseWalletGetblockbalancePostBlockBalanceTrace(
          TronHttpBlockBalanceTrace.fromJson(map),
        );
      }
    }
    throw CoreErrors.invalidOperationArguments(
      'TronHttpResponseWalletGetblockbalancePost',
      reason:
          'Cannot parse TronHttpResponseWalletGetblockbalancePost from $json',
    );
  }

  dynamic toJson();
}

class TronHttpResponseWalletGetblockbalancePostBlockBalanceTrace
    extends TronHttpResponseWalletGetblockbalancePost {
  final TronHttpBlockBalanceTrace value;
  const TronHttpResponseWalletGetblockbalancePostBlockBalanceTrace(this.value);

  @override
  dynamic toJson() => value.toJson();
}

class TronHttpResponseWalletGetblockbalancePostJavaTronError
    extends TronHttpResponseWalletGetblockbalancePost {
  final TronHttpJavaTronError value;
  const TronHttpResponseWalletGetblockbalancePostJavaTronError(this.value);

  @override
  dynamic toJson() => value.toJson();
}

sealed class TronHttpResponseWalletGetblockbylimitnextGet {
  const TronHttpResponseWalletGetblockbylimitnextGet();

  factory TronHttpResponseWalletGetblockbylimitnextGet.fromJson(dynamic json) {
    if (json is Map) {
      final map =
          json is Map<String, dynamic> ? json : Map<String, dynamic>.from(json);
      if (map.hasValue('Error')) {
        return TronHttpResponseWalletGetblockbylimitnextGetJavaTronError(
          TronHttpJavaTronError.fromJson(map),
        );
      }
      if (map.hasValue('block')) {
        return TronHttpResponseWalletGetblockbylimitnextGetBlockListInt64StringCompatible(
          TronHttpBlockListInt64StringCompatible.fromJson(map),
        );
      }
    }
    throw CoreErrors.invalidOperationArguments(
      'TronHttpResponseWalletGetblockbylimitnextGet',
      reason:
          'Cannot parse TronHttpResponseWalletGetblockbylimitnextGet from $json',
    );
  }

  dynamic toJson();
}

class TronHttpResponseWalletGetblockbylimitnextGetBlockListInt64StringCompatible
    extends TronHttpResponseWalletGetblockbylimitnextGet {
  final TronHttpBlockListInt64StringCompatible value;
  const TronHttpResponseWalletGetblockbylimitnextGetBlockListInt64StringCompatible(
    this.value,
  );

  @override
  dynamic toJson() => value.toJson();
}

class TronHttpResponseWalletGetblockbylimitnextGetJavaTronError
    extends TronHttpResponseWalletGetblockbylimitnextGet {
  final TronHttpJavaTronError value;
  const TronHttpResponseWalletGetblockbylimitnextGetJavaTronError(this.value);

  @override
  dynamic toJson() => value.toJson();
}

sealed class TronHttpResponseWalletGetblockbylimitnextPost {
  const TronHttpResponseWalletGetblockbylimitnextPost();

  factory TronHttpResponseWalletGetblockbylimitnextPost.fromJson(dynamic json) {
    if (json is Map) {
      final map =
          json is Map<String, dynamic> ? json : Map<String, dynamic>.from(json);
      if (map.hasValue('Error')) {
        return TronHttpResponseWalletGetblockbylimitnextPostJavaTronError(
          TronHttpJavaTronError.fromJson(map),
        );
      }
      if (map.hasValue('block')) {
        return TronHttpResponseWalletGetblockbylimitnextPostBlockList(
          TronHttpBlockList.fromJson(map),
        );
      }
    }
    throw CoreErrors.invalidOperationArguments(
      'TronHttpResponseWalletGetblockbylimitnextPost',
      reason:
          'Cannot parse TronHttpResponseWalletGetblockbylimitnextPost from $json',
    );
  }

  dynamic toJson();
}

class TronHttpResponseWalletGetblockbylimitnextPostBlockList
    extends TronHttpResponseWalletGetblockbylimitnextPost {
  final TronHttpBlockList value;
  const TronHttpResponseWalletGetblockbylimitnextPostBlockList(this.value);

  @override
  dynamic toJson() => value.toJson();
}

class TronHttpResponseWalletGetblockbylimitnextPostJavaTronError
    extends TronHttpResponseWalletGetblockbylimitnextPost {
  final TronHttpJavaTronError value;
  const TronHttpResponseWalletGetblockbylimitnextPostJavaTronError(this.value);

  @override
  dynamic toJson() => value.toJson();
}

sealed class TronHttpResponseWalletGetburntrxGet {
  const TronHttpResponseWalletGetburntrxGet();

  factory TronHttpResponseWalletGetburntrxGet.fromJson(dynamic json) {
    if (json is Map) {
      final map =
          json is Map<String, dynamic> ? json : Map<String, dynamic>.from(json);
      if (map.hasValue('Error')) {
        return TronHttpResponseWalletGetburntrxGetJavaTronError(
          TronHttpJavaTronError.fromJson(map),
        );
      }
      if (map.hasValue('burnTrxAmount')) {
        return TronHttpResponseWalletGetburntrxGetGetburntrxGetResultObject1.fromJson(
          map,
        );
      }
    }
    throw CoreErrors.invalidOperationArguments(
      'TronHttpResponseWalletGetburntrxGet',
      reason: 'Cannot parse TronHttpResponseWalletGetburntrxGet from $json',
    );
  }

  dynamic toJson();
}

class TronHttpResponseWalletGetburntrxGetGetburntrxGetResultObject1
    extends TronHttpResponseWalletGetburntrxGet {
  final BigInt? burnTrxAmount;

  const TronHttpResponseWalletGetburntrxGetGetburntrxGetResultObject1({
    this.burnTrxAmount,
  });

  factory TronHttpResponseWalletGetburntrxGetGetburntrxGetResultObject1.fromJson(
    Map<String, dynamic> json,
  ) {
    return TronHttpResponseWalletGetburntrxGetGetburntrxGetResultObject1(
      burnTrxAmount: json.valueAsBigInt('burnTrxAmount'),
    );
  }

  @override
  Map<String, dynamic> toJson() => {'burnTrxAmount': burnTrxAmount};
}

class TronHttpResponseWalletGetburntrxGetJavaTronError
    extends TronHttpResponseWalletGetburntrxGet {
  final TronHttpJavaTronError value;
  const TronHttpResponseWalletGetburntrxGetJavaTronError(this.value);

  @override
  dynamic toJson() => value.toJson();
}

sealed class TronHttpResponseWalletGetburntrxPost {
  const TronHttpResponseWalletGetburntrxPost();

  factory TronHttpResponseWalletGetburntrxPost.fromJson(dynamic json) {
    if (json is Map) {
      final map =
          json is Map<String, dynamic> ? json : Map<String, dynamic>.from(json);
      if (map.hasValue('Error')) {
        return TronHttpResponseWalletGetburntrxPostJavaTronError(
          TronHttpJavaTronError.fromJson(map),
        );
      }
      if (map.hasValue('burnTrxAmount')) {
        return TronHttpResponseWalletGetburntrxPostGetburntrxPostResultObject1.fromJson(
          map,
        );
      }
    }
    throw CoreErrors.invalidOperationArguments(
      'TronHttpResponseWalletGetburntrxPost',
      reason: 'Cannot parse TronHttpResponseWalletGetburntrxPost from $json',
    );
  }

  dynamic toJson();
}

class TronHttpResponseWalletGetburntrxPostGetburntrxPostResultObject1
    extends TronHttpResponseWalletGetburntrxPost {
  final BigInt? burnTrxAmount;

  const TronHttpResponseWalletGetburntrxPostGetburntrxPostResultObject1({
    this.burnTrxAmount,
  });

  factory TronHttpResponseWalletGetburntrxPostGetburntrxPostResultObject1.fromJson(
    Map<String, dynamic> json,
  ) {
    return TronHttpResponseWalletGetburntrxPostGetburntrxPostResultObject1(
      burnTrxAmount: json.valueAsBigInt('burnTrxAmount'),
    );
  }

  @override
  Map<String, dynamic> toJson() => {'burnTrxAmount': burnTrxAmount};
}

class TronHttpResponseWalletGetburntrxPostJavaTronError
    extends TronHttpResponseWalletGetburntrxPost {
  final TronHttpJavaTronError value;
  const TronHttpResponseWalletGetburntrxPostJavaTronError(this.value);

  @override
  dynamic toJson() => value.toJson();
}

sealed class TronHttpResponseWalletGetcandelegatedmaxsizeGet {
  const TronHttpResponseWalletGetcandelegatedmaxsizeGet();

  factory TronHttpResponseWalletGetcandelegatedmaxsizeGet.fromJson(
    dynamic json,
  ) {
    if (json is Map) {
      final map =
          json is Map<String, dynamic> ? json : Map<String, dynamic>.from(json);
      if (map.hasValue('Error')) {
        return TronHttpResponseWalletGetcandelegatedmaxsizeGetJavaTronError(
          TronHttpJavaTronError.fromJson(map),
        );
      }
      if (map.hasValue('max_size')) {
        return TronHttpResponseWalletGetcandelegatedmaxsizeGetCanDelegatedMaxSizeResponseMessageInt64StringCompatible(
          TronHttpCanDelegatedMaxSizeResponseMessageInt64StringCompatible.fromJson(
            map,
          ),
        );
      }
    }
    throw CoreErrors.invalidOperationArguments(
      'TronHttpResponseWalletGetcandelegatedmaxsizeGet',
      reason:
          'Cannot parse TronHttpResponseWalletGetcandelegatedmaxsizeGet from $json',
    );
  }

  dynamic toJson();
}

class TronHttpResponseWalletGetcandelegatedmaxsizeGetCanDelegatedMaxSizeResponseMessageInt64StringCompatible
    extends TronHttpResponseWalletGetcandelegatedmaxsizeGet {
  final TronHttpCanDelegatedMaxSizeResponseMessageInt64StringCompatible value;
  const TronHttpResponseWalletGetcandelegatedmaxsizeGetCanDelegatedMaxSizeResponseMessageInt64StringCompatible(
    this.value,
  );

  @override
  dynamic toJson() => value.toJson();
}

class TronHttpResponseWalletGetcandelegatedmaxsizeGetJavaTronError
    extends TronHttpResponseWalletGetcandelegatedmaxsizeGet {
  final TronHttpJavaTronError value;
  const TronHttpResponseWalletGetcandelegatedmaxsizeGetJavaTronError(
    this.value,
  );

  @override
  dynamic toJson() => value.toJson();
}

sealed class TronHttpResponseWalletGetcandelegatedmaxsizePost {
  const TronHttpResponseWalletGetcandelegatedmaxsizePost();

  factory TronHttpResponseWalletGetcandelegatedmaxsizePost.fromJson(
    dynamic json,
  ) {
    if (json is Map) {
      final map =
          json is Map<String, dynamic> ? json : Map<String, dynamic>.from(json);
      if (map.hasValue('Error')) {
        return TronHttpResponseWalletGetcandelegatedmaxsizePostJavaTronError(
          TronHttpJavaTronError.fromJson(map),
        );
      }
      if (map.hasValue('max_size')) {
        return TronHttpResponseWalletGetcandelegatedmaxsizePostCanDelegatedMaxSizeResponseMessage(
          TronHttpCanDelegatedMaxSizeResponseMessage.fromJson(map),
        );
      }
    }
    throw CoreErrors.invalidOperationArguments(
      'TronHttpResponseWalletGetcandelegatedmaxsizePost',
      reason:
          'Cannot parse TronHttpResponseWalletGetcandelegatedmaxsizePost from $json',
    );
  }

  dynamic toJson();
}

class TronHttpResponseWalletGetcandelegatedmaxsizePostCanDelegatedMaxSizeResponseMessage
    extends TronHttpResponseWalletGetcandelegatedmaxsizePost {
  final TronHttpCanDelegatedMaxSizeResponseMessage value;
  const TronHttpResponseWalletGetcandelegatedmaxsizePostCanDelegatedMaxSizeResponseMessage(
    this.value,
  );

  @override
  dynamic toJson() => value.toJson();
}

class TronHttpResponseWalletGetcandelegatedmaxsizePostJavaTronError
    extends TronHttpResponseWalletGetcandelegatedmaxsizePost {
  final TronHttpJavaTronError value;
  const TronHttpResponseWalletGetcandelegatedmaxsizePostJavaTronError(
    this.value,
  );

  @override
  dynamic toJson() => value.toJson();
}

sealed class TronHttpResponseWalletGetcanwithdrawunfreezeamountGet {
  const TronHttpResponseWalletGetcanwithdrawunfreezeamountGet();

  factory TronHttpResponseWalletGetcanwithdrawunfreezeamountGet.fromJson(
    dynamic json,
  ) {
    if (json is Map) {
      final map =
          json is Map<String, dynamic> ? json : Map<String, dynamic>.from(json);
      if (map.hasValue('Error')) {
        return TronHttpResponseWalletGetcanwithdrawunfreezeamountGetJavaTronError(
          TronHttpJavaTronError.fromJson(map),
        );
      }
      if (map.hasValue('amount')) {
        return TronHttpResponseWalletGetcanwithdrawunfreezeamountGetCanWithdrawUnfreezeAmountResponseMessageInt64StringCompatible(
          TronHttpCanWithdrawUnfreezeAmountResponseMessageInt64StringCompatible.fromJson(
            map,
          ),
        );
      }
    }
    throw CoreErrors.invalidOperationArguments(
      'TronHttpResponseWalletGetcanwithdrawunfreezeamountGet',
      reason:
          'Cannot parse TronHttpResponseWalletGetcanwithdrawunfreezeamountGet from $json',
    );
  }

  dynamic toJson();
}

class TronHttpResponseWalletGetcanwithdrawunfreezeamountGetCanWithdrawUnfreezeAmountResponseMessageInt64StringCompatible
    extends TronHttpResponseWalletGetcanwithdrawunfreezeamountGet {
  final TronHttpCanWithdrawUnfreezeAmountResponseMessageInt64StringCompatible
  value;
  const TronHttpResponseWalletGetcanwithdrawunfreezeamountGetCanWithdrawUnfreezeAmountResponseMessageInt64StringCompatible(
    this.value,
  );

  @override
  dynamic toJson() => value.toJson();
}

class TronHttpResponseWalletGetcanwithdrawunfreezeamountGetJavaTronError
    extends TronHttpResponseWalletGetcanwithdrawunfreezeamountGet {
  final TronHttpJavaTronError value;
  const TronHttpResponseWalletGetcanwithdrawunfreezeamountGetJavaTronError(
    this.value,
  );

  @override
  dynamic toJson() => value.toJson();
}

sealed class TronHttpResponseWalletGetcanwithdrawunfreezeamountPost {
  const TronHttpResponseWalletGetcanwithdrawunfreezeamountPost();

  factory TronHttpResponseWalletGetcanwithdrawunfreezeamountPost.fromJson(
    dynamic json,
  ) {
    if (json is Map) {
      final map =
          json is Map<String, dynamic> ? json : Map<String, dynamic>.from(json);
      if (map.hasValue('Error')) {
        return TronHttpResponseWalletGetcanwithdrawunfreezeamountPostJavaTronError(
          TronHttpJavaTronError.fromJson(map),
        );
      }
      if (map.hasValue('amount')) {
        return TronHttpResponseWalletGetcanwithdrawunfreezeamountPostCanWithdrawUnfreezeAmountResponseMessage(
          TronHttpCanWithdrawUnfreezeAmountResponseMessage.fromJson(map),
        );
      }
    }
    throw CoreErrors.invalidOperationArguments(
      'TronHttpResponseWalletGetcanwithdrawunfreezeamountPost',
      reason:
          'Cannot parse TronHttpResponseWalletGetcanwithdrawunfreezeamountPost from $json',
    );
  }

  dynamic toJson();
}

class TronHttpResponseWalletGetcanwithdrawunfreezeamountPostCanWithdrawUnfreezeAmountResponseMessage
    extends TronHttpResponseWalletGetcanwithdrawunfreezeamountPost {
  final TronHttpCanWithdrawUnfreezeAmountResponseMessage value;
  const TronHttpResponseWalletGetcanwithdrawunfreezeamountPostCanWithdrawUnfreezeAmountResponseMessage(
    this.value,
  );

  @override
  dynamic toJson() => value.toJson();
}

class TronHttpResponseWalletGetcanwithdrawunfreezeamountPostJavaTronError
    extends TronHttpResponseWalletGetcanwithdrawunfreezeamountPost {
  final TronHttpJavaTronError value;
  const TronHttpResponseWalletGetcanwithdrawunfreezeamountPostJavaTronError(
    this.value,
  );

  @override
  dynamic toJson() => value.toJson();
}

sealed class TronHttpResponseWalletGetchainparametersGet {
  const TronHttpResponseWalletGetchainparametersGet();

  factory TronHttpResponseWalletGetchainparametersGet.fromJson(dynamic json) {
    if (json is Map) {
      final map =
          json is Map<String, dynamic> ? json : Map<String, dynamic>.from(json);
      if (map.hasValue('Error')) {
        return TronHttpResponseWalletGetchainparametersGetJavaTronError(
          TronHttpJavaTronError.fromJson(map),
        );
      }
      if (map.hasValue('chainParameter')) {
        return TronHttpResponseWalletGetchainparametersGetChainParametersInt64StringCompatible(
          TronHttpChainParametersInt64StringCompatible.fromJson(map),
        );
      }
    }
    throw CoreErrors.invalidOperationArguments(
      'TronHttpResponseWalletGetchainparametersGet',
      reason:
          'Cannot parse TronHttpResponseWalletGetchainparametersGet from $json',
    );
  }

  dynamic toJson();
}

class TronHttpResponseWalletGetchainparametersGetChainParametersInt64StringCompatible
    extends TronHttpResponseWalletGetchainparametersGet {
  final TronHttpChainParametersInt64StringCompatible value;
  const TronHttpResponseWalletGetchainparametersGetChainParametersInt64StringCompatible(
    this.value,
  );

  @override
  dynamic toJson() => value.toJson();
}

class TronHttpResponseWalletGetchainparametersGetJavaTronError
    extends TronHttpResponseWalletGetchainparametersGet {
  final TronHttpJavaTronError value;
  const TronHttpResponseWalletGetchainparametersGetJavaTronError(this.value);

  @override
  dynamic toJson() => value.toJson();
}

sealed class TronHttpResponseWalletGetchainparametersPost {
  const TronHttpResponseWalletGetchainparametersPost();

  factory TronHttpResponseWalletGetchainparametersPost.fromJson(dynamic json) {
    if (json is Map) {
      final map =
          json is Map<String, dynamic> ? json : Map<String, dynamic>.from(json);
      if (map.hasValue('Error')) {
        return TronHttpResponseWalletGetchainparametersPostJavaTronError(
          TronHttpJavaTronError.fromJson(map),
        );
      }
      if (map.hasValue('chainParameter')) {
        return TronHttpResponseWalletGetchainparametersPostChainParameters(
          TronHttpChainParameters.fromJson(map),
        );
      }
    }
    throw CoreErrors.invalidOperationArguments(
      'TronHttpResponseWalletGetchainparametersPost',
      reason:
          'Cannot parse TronHttpResponseWalletGetchainparametersPost from $json',
    );
  }

  dynamic toJson();
}

class TronHttpResponseWalletGetchainparametersPostChainParameters
    extends TronHttpResponseWalletGetchainparametersPost {
  final TronHttpChainParameters value;
  const TronHttpResponseWalletGetchainparametersPostChainParameters(this.value);

  @override
  dynamic toJson() => value.toJson();
}

class TronHttpResponseWalletGetchainparametersPostJavaTronError
    extends TronHttpResponseWalletGetchainparametersPost {
  final TronHttpJavaTronError value;
  const TronHttpResponseWalletGetchainparametersPostJavaTronError(this.value);

  @override
  dynamic toJson() => value.toJson();
}

sealed class TronHttpResponseWalletGetcontractGet {
  const TronHttpResponseWalletGetcontractGet();

  factory TronHttpResponseWalletGetcontractGet.fromJson(dynamic json) {
    if (json is Map) {
      final map =
          json is Map<String, dynamic> ? json : Map<String, dynamic>.from(json);
      if (map.hasValue('Error')) {
        return TronHttpResponseWalletGetcontractGetJavaTronError(
          TronHttpJavaTronError.fromJson(map),
        );
      }
      if (map.hasValue('abi') ||
          map.hasValue('bytecode') ||
          map.hasValue('call_value') ||
          map.hasValue('code_hash') ||
          map.hasValue('consume_user_resource_percent') ||
          map.hasValue('contract_address') ||
          map.hasValue('name') ||
          map.hasValue('origin_address') ||
          map.hasValue('origin_energy_limit') ||
          map.hasValue('trx_hash') ||
          map.hasValue('version')) {
        return TronHttpResponseWalletGetcontractGetSmartContractInt64StringCompatible(
          TronHttpSmartContractInt64StringCompatible.fromJson(map),
        );
      }
    }
    throw CoreErrors.invalidOperationArguments(
      'TronHttpResponseWalletGetcontractGet',
      reason: 'Cannot parse TronHttpResponseWalletGetcontractGet from $json',
    );
  }

  dynamic toJson();
}

class TronHttpResponseWalletGetcontractGetSmartContractInt64StringCompatible
    extends TronHttpResponseWalletGetcontractGet {
  final TronHttpSmartContractInt64StringCompatible value;
  const TronHttpResponseWalletGetcontractGetSmartContractInt64StringCompatible(
    this.value,
  );

  @override
  dynamic toJson() => value.toJson();
}

class TronHttpResponseWalletGetcontractGetJavaTronError
    extends TronHttpResponseWalletGetcontractGet {
  final TronHttpJavaTronError value;
  const TronHttpResponseWalletGetcontractGetJavaTronError(this.value);

  @override
  dynamic toJson() => value.toJson();
}

sealed class TronHttpResponseWalletGetcontractPost {
  const TronHttpResponseWalletGetcontractPost();

  factory TronHttpResponseWalletGetcontractPost.fromJson(dynamic json) {
    if (json is Map) {
      final map =
          json is Map<String, dynamic> ? json : Map<String, dynamic>.from(json);
      if (map.hasValue('Error')) {
        return TronHttpResponseWalletGetcontractPostJavaTronError(
          TronHttpJavaTronError.fromJson(map),
        );
      }
      if (map.hasValue('abi') ||
          map.hasValue('bytecode') ||
          map.hasValue('call_value') ||
          map.hasValue('code_hash') ||
          map.hasValue('consume_user_resource_percent') ||
          map.hasValue('contract_address') ||
          map.hasValue('name') ||
          map.hasValue('origin_address') ||
          map.hasValue('origin_energy_limit') ||
          map.hasValue('trx_hash') ||
          map.hasValue('version')) {
        return TronHttpResponseWalletGetcontractPostSmartContract(
          TronHttpSmartContract.fromJson(map),
        );
      }
    }
    throw CoreErrors.invalidOperationArguments(
      'TronHttpResponseWalletGetcontractPost',
      reason: 'Cannot parse TronHttpResponseWalletGetcontractPost from $json',
    );
  }

  dynamic toJson();
}

class TronHttpResponseWalletGetcontractPostSmartContract
    extends TronHttpResponseWalletGetcontractPost {
  final TronHttpSmartContract value;
  const TronHttpResponseWalletGetcontractPostSmartContract(this.value);

  @override
  dynamic toJson() => value.toJson();
}

class TronHttpResponseWalletGetcontractPostJavaTronError
    extends TronHttpResponseWalletGetcontractPost {
  final TronHttpJavaTronError value;
  const TronHttpResponseWalletGetcontractPostJavaTronError(this.value);

  @override
  dynamic toJson() => value.toJson();
}

sealed class TronHttpResponseWalletGetcontractinfoGet {
  const TronHttpResponseWalletGetcontractinfoGet();

  factory TronHttpResponseWalletGetcontractinfoGet.fromJson(dynamic json) {
    if (json is Map) {
      final map =
          json is Map<String, dynamic> ? json : Map<String, dynamic>.from(json);
      if (map.hasValue('Error')) {
        return TronHttpResponseWalletGetcontractinfoGetJavaTronError(
          TronHttpJavaTronError.fromJson(map),
        );
      }
      if (map.hasValue('contract_state') ||
          map.hasValue('runtimecode') ||
          map.hasValue('smart_contract')) {
        return TronHttpResponseWalletGetcontractinfoGetSmartContractDataWrapperInt64StringCompatible(
          TronHttpSmartContractDataWrapperInt64StringCompatible.fromJson(map),
        );
      }
    }
    throw CoreErrors.invalidOperationArguments(
      'TronHttpResponseWalletGetcontractinfoGet',
      reason:
          'Cannot parse TronHttpResponseWalletGetcontractinfoGet from $json',
    );
  }

  dynamic toJson();
}

class TronHttpResponseWalletGetcontractinfoGetSmartContractDataWrapperInt64StringCompatible
    extends TronHttpResponseWalletGetcontractinfoGet {
  final TronHttpSmartContractDataWrapperInt64StringCompatible value;
  const TronHttpResponseWalletGetcontractinfoGetSmartContractDataWrapperInt64StringCompatible(
    this.value,
  );

  @override
  dynamic toJson() => value.toJson();
}

class TronHttpResponseWalletGetcontractinfoGetJavaTronError
    extends TronHttpResponseWalletGetcontractinfoGet {
  final TronHttpJavaTronError value;
  const TronHttpResponseWalletGetcontractinfoGetJavaTronError(this.value);

  @override
  dynamic toJson() => value.toJson();
}

sealed class TronHttpResponseWalletGetcontractinfoPost {
  const TronHttpResponseWalletGetcontractinfoPost();

  factory TronHttpResponseWalletGetcontractinfoPost.fromJson(dynamic json) {
    if (json is Map) {
      final map =
          json is Map<String, dynamic> ? json : Map<String, dynamic>.from(json);
      if (map.hasValue('Error')) {
        return TronHttpResponseWalletGetcontractinfoPostJavaTronError(
          TronHttpJavaTronError.fromJson(map),
        );
      }
      if (map.hasValue('contract_state') ||
          map.hasValue('runtimecode') ||
          map.hasValue('smart_contract')) {
        return TronHttpResponseWalletGetcontractinfoPostSmartContractDataWrapper(
          TronHttpSmartContractDataWrapper.fromJson(map),
        );
      }
    }
    throw CoreErrors.invalidOperationArguments(
      'TronHttpResponseWalletGetcontractinfoPost',
      reason:
          'Cannot parse TronHttpResponseWalletGetcontractinfoPost from $json',
    );
  }

  dynamic toJson();
}

class TronHttpResponseWalletGetcontractinfoPostSmartContractDataWrapper
    extends TronHttpResponseWalletGetcontractinfoPost {
  final TronHttpSmartContractDataWrapper value;
  const TronHttpResponseWalletGetcontractinfoPostSmartContractDataWrapper(
    this.value,
  );

  @override
  dynamic toJson() => value.toJson();
}

class TronHttpResponseWalletGetcontractinfoPostJavaTronError
    extends TronHttpResponseWalletGetcontractinfoPost {
  final TronHttpJavaTronError value;
  const TronHttpResponseWalletGetcontractinfoPostJavaTronError(this.value);

  @override
  dynamic toJson() => value.toJson();
}

sealed class TronHttpResponseWalletGetdelegatedresourceGet {
  const TronHttpResponseWalletGetdelegatedresourceGet();

  factory TronHttpResponseWalletGetdelegatedresourceGet.fromJson(dynamic json) {
    if (json is Map) {
      final map =
          json is Map<String, dynamic> ? json : Map<String, dynamic>.from(json);
      if (map.hasValue('Error')) {
        return TronHttpResponseWalletGetdelegatedresourceGetJavaTronError(
          TronHttpJavaTronError.fromJson(map),
        );
      }
      if (map.hasValue('delegatedResource')) {
        return TronHttpResponseWalletGetdelegatedresourceGetDelegatedResourceListInt64StringCompatible(
          TronHttpDelegatedResourceListInt64StringCompatible.fromJson(map),
        );
      }
    }
    throw CoreErrors.invalidOperationArguments(
      'TronHttpResponseWalletGetdelegatedresourceGet',
      reason:
          'Cannot parse TronHttpResponseWalletGetdelegatedresourceGet from $json',
    );
  }

  dynamic toJson();
}

class TronHttpResponseWalletGetdelegatedresourceGetDelegatedResourceListInt64StringCompatible
    extends TronHttpResponseWalletGetdelegatedresourceGet {
  final TronHttpDelegatedResourceListInt64StringCompatible value;
  const TronHttpResponseWalletGetdelegatedresourceGetDelegatedResourceListInt64StringCompatible(
    this.value,
  );

  @override
  dynamic toJson() => value.toJson();
}

class TronHttpResponseWalletGetdelegatedresourceGetJavaTronError
    extends TronHttpResponseWalletGetdelegatedresourceGet {
  final TronHttpJavaTronError value;
  const TronHttpResponseWalletGetdelegatedresourceGetJavaTronError(this.value);

  @override
  dynamic toJson() => value.toJson();
}

sealed class TronHttpResponseWalletGetdelegatedresourcePost {
  const TronHttpResponseWalletGetdelegatedresourcePost();

  factory TronHttpResponseWalletGetdelegatedresourcePost.fromJson(
    dynamic json,
  ) {
    if (json is Map) {
      final map =
          json is Map<String, dynamic> ? json : Map<String, dynamic>.from(json);
      if (map.hasValue('Error')) {
        return TronHttpResponseWalletGetdelegatedresourcePostJavaTronError(
          TronHttpJavaTronError.fromJson(map),
        );
      }
      if (map.hasValue('delegatedResource')) {
        return TronHttpResponseWalletGetdelegatedresourcePostDelegatedResourceList(
          TronHttpDelegatedResourceList.fromJson(map),
        );
      }
    }
    throw CoreErrors.invalidOperationArguments(
      'TronHttpResponseWalletGetdelegatedresourcePost',
      reason:
          'Cannot parse TronHttpResponseWalletGetdelegatedresourcePost from $json',
    );
  }

  dynamic toJson();
}

class TronHttpResponseWalletGetdelegatedresourcePostDelegatedResourceList
    extends TronHttpResponseWalletGetdelegatedresourcePost {
  final TronHttpDelegatedResourceList value;
  const TronHttpResponseWalletGetdelegatedresourcePostDelegatedResourceList(
    this.value,
  );

  @override
  dynamic toJson() => value.toJson();
}

class TronHttpResponseWalletGetdelegatedresourcePostJavaTronError
    extends TronHttpResponseWalletGetdelegatedresourcePost {
  final TronHttpJavaTronError value;
  const TronHttpResponseWalletGetdelegatedresourcePostJavaTronError(this.value);

  @override
  dynamic toJson() => value.toJson();
}

sealed class TronHttpResponseWalletGetdelegatedresourceaccountindexGet {
  const TronHttpResponseWalletGetdelegatedresourceaccountindexGet();

  factory TronHttpResponseWalletGetdelegatedresourceaccountindexGet.fromJson(
    dynamic json,
  ) {
    if (json is Map) {
      final map =
          json is Map<String, dynamic> ? json : Map<String, dynamic>.from(json);
      if (map.hasValue('Error')) {
        return TronHttpResponseWalletGetdelegatedresourceaccountindexGetJavaTronError(
          TronHttpJavaTronError.fromJson(map),
        );
      }
      if (map.hasValue('account') ||
          map.hasValue('fromAccounts') ||
          map.hasValue('timestamp') ||
          map.hasValue('toAccounts')) {
        return TronHttpResponseWalletGetdelegatedresourceaccountindexGetDelegatedResourceAccountIndexInt64StringCompatible(
          TronHttpDelegatedResourceAccountIndexInt64StringCompatible.fromJson(
            map,
          ),
        );
      }
    }
    throw CoreErrors.invalidOperationArguments(
      'TronHttpResponseWalletGetdelegatedresourceaccountindexGet',
      reason:
          'Cannot parse TronHttpResponseWalletGetdelegatedresourceaccountindexGet from $json',
    );
  }

  dynamic toJson();
}

class TronHttpResponseWalletGetdelegatedresourceaccountindexGetDelegatedResourceAccountIndexInt64StringCompatible
    extends TronHttpResponseWalletGetdelegatedresourceaccountindexGet {
  final TronHttpDelegatedResourceAccountIndexInt64StringCompatible value;
  const TronHttpResponseWalletGetdelegatedresourceaccountindexGetDelegatedResourceAccountIndexInt64StringCompatible(
    this.value,
  );

  @override
  dynamic toJson() => value.toJson();
}

class TronHttpResponseWalletGetdelegatedresourceaccountindexGetJavaTronError
    extends TronHttpResponseWalletGetdelegatedresourceaccountindexGet {
  final TronHttpJavaTronError value;
  const TronHttpResponseWalletGetdelegatedresourceaccountindexGetJavaTronError(
    this.value,
  );

  @override
  dynamic toJson() => value.toJson();
}

sealed class TronHttpResponseWalletGetdelegatedresourceaccountindexPost {
  const TronHttpResponseWalletGetdelegatedresourceaccountindexPost();

  factory TronHttpResponseWalletGetdelegatedresourceaccountindexPost.fromJson(
    dynamic json,
  ) {
    if (json is Map) {
      final map =
          json is Map<String, dynamic> ? json : Map<String, dynamic>.from(json);
      if (map.hasValue('Error')) {
        return TronHttpResponseWalletGetdelegatedresourceaccountindexPostJavaTronError(
          TronHttpJavaTronError.fromJson(map),
        );
      }
      if (map.hasValue('account') ||
          map.hasValue('fromAccounts') ||
          map.hasValue('timestamp') ||
          map.hasValue('toAccounts')) {
        return TronHttpResponseWalletGetdelegatedresourceaccountindexPostDelegatedResourceAccountIndex(
          TronHttpDelegatedResourceAccountIndex.fromJson(map),
        );
      }
    }
    throw CoreErrors.invalidOperationArguments(
      'TronHttpResponseWalletGetdelegatedresourceaccountindexPost',
      reason:
          'Cannot parse TronHttpResponseWalletGetdelegatedresourceaccountindexPost from $json',
    );
  }

  dynamic toJson();
}

class TronHttpResponseWalletGetdelegatedresourceaccountindexPostDelegatedResourceAccountIndex
    extends TronHttpResponseWalletGetdelegatedresourceaccountindexPost {
  final TronHttpDelegatedResourceAccountIndex value;
  const TronHttpResponseWalletGetdelegatedresourceaccountindexPostDelegatedResourceAccountIndex(
    this.value,
  );

  @override
  dynamic toJson() => value.toJson();
}

class TronHttpResponseWalletGetdelegatedresourceaccountindexPostJavaTronError
    extends TronHttpResponseWalletGetdelegatedresourceaccountindexPost {
  final TronHttpJavaTronError value;
  const TronHttpResponseWalletGetdelegatedresourceaccountindexPostJavaTronError(
    this.value,
  );

  @override
  dynamic toJson() => value.toJson();
}

sealed class TronHttpResponseWalletGetenergypricesGet {
  const TronHttpResponseWalletGetenergypricesGet();

  factory TronHttpResponseWalletGetenergypricesGet.fromJson(dynamic json) {
    if (json is Map) {
      final map =
          json is Map<String, dynamic> ? json : Map<String, dynamic>.from(json);
      if (map.hasValue('Error')) {
        return TronHttpResponseWalletGetenergypricesGetJavaTronError(
          TronHttpJavaTronError.fromJson(map),
        );
      }
      if (map.hasValue('prices')) {
        return TronHttpResponseWalletGetenergypricesGetPricesResponseMessage(
          TronHttpPricesResponseMessage.fromJson(map),
        );
      }
    }
    throw CoreErrors.invalidOperationArguments(
      'TronHttpResponseWalletGetenergypricesGet',
      reason:
          'Cannot parse TronHttpResponseWalletGetenergypricesGet from $json',
    );
  }

  dynamic toJson();
}

class TronHttpResponseWalletGetenergypricesGetPricesResponseMessage
    extends TronHttpResponseWalletGetenergypricesGet {
  final TronHttpPricesResponseMessage value;
  const TronHttpResponseWalletGetenergypricesGetPricesResponseMessage(
    this.value,
  );

  @override
  dynamic toJson() => value.toJson();
}

class TronHttpResponseWalletGetenergypricesGetJavaTronError
    extends TronHttpResponseWalletGetenergypricesGet {
  final TronHttpJavaTronError value;
  const TronHttpResponseWalletGetenergypricesGetJavaTronError(this.value);

  @override
  dynamic toJson() => value.toJson();
}

sealed class TronHttpResponseWalletGetnextmaintenancetimeGet {
  const TronHttpResponseWalletGetnextmaintenancetimeGet();

  factory TronHttpResponseWalletGetnextmaintenancetimeGet.fromJson(
    dynamic json,
  ) {
    if (json is Map) {
      final map =
          json is Map<String, dynamic> ? json : Map<String, dynamic>.from(json);
      if (map.hasValue('Error')) {
        return TronHttpResponseWalletGetnextmaintenancetimeGetJavaTronError(
          TronHttpJavaTronError.fromJson(map),
        );
      }
      if (map.hasValue('num')) {
        return TronHttpResponseWalletGetnextmaintenancetimeGetGetnextmaintenancetimeGetResultRequiresNum1.fromJson(
          map,
        );
      }
    }
    throw CoreErrors.invalidOperationArguments(
      'TronHttpResponseWalletGetnextmaintenancetimeGet',
      reason:
          'Cannot parse TronHttpResponseWalletGetnextmaintenancetimeGet from $json',
    );
  }

  dynamic toJson();
}

class TronHttpResponseWalletGetnextmaintenancetimeGetGetnextmaintenancetimeGetResultRequiresNum1
    extends TronHttpResponseWalletGetnextmaintenancetimeGet {
  /// Unix timestamp in milliseconds of the next maintenance cycle.
  final BigInt num_;

  const TronHttpResponseWalletGetnextmaintenancetimeGetGetnextmaintenancetimeGetResultRequiresNum1({
    required this.num_,
  });

  factory TronHttpResponseWalletGetnextmaintenancetimeGetGetnextmaintenancetimeGetResultRequiresNum1.fromJson(
    Map<String, dynamic> json,
  ) {
    return TronHttpResponseWalletGetnextmaintenancetimeGetGetnextmaintenancetimeGetResultRequiresNum1(
      num_: json.valueAsBigInt('num'),
    );
  }

  @override
  Map<String, dynamic> toJson() => {'num': num_};
}

class TronHttpResponseWalletGetnextmaintenancetimeGetJavaTronError
    extends TronHttpResponseWalletGetnextmaintenancetimeGet {
  final TronHttpJavaTronError value;
  const TronHttpResponseWalletGetnextmaintenancetimeGetJavaTronError(
    this.value,
  );

  @override
  dynamic toJson() => value.toJson();
}

sealed class TronHttpResponseWalletGetnextmaintenancetimePost {
  const TronHttpResponseWalletGetnextmaintenancetimePost();

  factory TronHttpResponseWalletGetnextmaintenancetimePost.fromJson(
    dynamic json,
  ) {
    if (json is Map) {
      final map =
          json is Map<String, dynamic> ? json : Map<String, dynamic>.from(json);
      if (map.hasValue('Error')) {
        return TronHttpResponseWalletGetnextmaintenancetimePostJavaTronError(
          TronHttpJavaTronError.fromJson(map),
        );
      }
      if (map.hasValue('num')) {
        return TronHttpResponseWalletGetnextmaintenancetimePostGetnextmaintenancetimePostResultRequiresNum1.fromJson(
          map,
        );
      }
    }
    throw CoreErrors.invalidOperationArguments(
      'TronHttpResponseWalletGetnextmaintenancetimePost',
      reason:
          'Cannot parse TronHttpResponseWalletGetnextmaintenancetimePost from $json',
    );
  }

  dynamic toJson();
}

class TronHttpResponseWalletGetnextmaintenancetimePostGetnextmaintenancetimePostResultRequiresNum1
    extends TronHttpResponseWalletGetnextmaintenancetimePost {
  /// Unix timestamp in milliseconds of the next maintenance cycle.
  final BigInt num_;

  const TronHttpResponseWalletGetnextmaintenancetimePostGetnextmaintenancetimePostResultRequiresNum1({
    required this.num_,
  });

  factory TronHttpResponseWalletGetnextmaintenancetimePostGetnextmaintenancetimePostResultRequiresNum1.fromJson(
    Map<String, dynamic> json,
  ) {
    return TronHttpResponseWalletGetnextmaintenancetimePostGetnextmaintenancetimePostResultRequiresNum1(
      num_: json.valueAsBigInt('num'),
    );
  }

  @override
  Map<String, dynamic> toJson() => {'num': num_};
}

class TronHttpResponseWalletGetnextmaintenancetimePostJavaTronError
    extends TronHttpResponseWalletGetnextmaintenancetimePost {
  final TronHttpJavaTronError value;
  const TronHttpResponseWalletGetnextmaintenancetimePostJavaTronError(
    this.value,
  );

  @override
  dynamic toJson() => value.toJson();
}

sealed class TronHttpResponseWalletGetnodeinfoGet {
  const TronHttpResponseWalletGetnodeinfoGet();

  factory TronHttpResponseWalletGetnodeinfoGet.fromJson(dynamic json) {
    if (json is Map) {
      final map =
          json is Map<String, dynamic> ? json : Map<String, dynamic>.from(json);
      if (map.hasValue('Error')) {
        return TronHttpResponseWalletGetnodeinfoGetJavaTronError(
          TronHttpJavaTronError.fromJson(map),
        );
      }
      if (map.hasValue('activeConnectCount') ||
          map.hasValue('beginSyncNum') ||
          map.hasValue('block') ||
          map.hasValue('cheatWitnessInfoMap') ||
          map.hasValue('configNodeInfo') ||
          map.hasValue('currentConnectCount') ||
          map.hasValue('machineInfo') ||
          map.hasValue('passiveConnectCount') ||
          map.hasValue('peerList') ||
          map.hasValue('solidityBlock') ||
          map.hasValue('totalFlow')) {
        return TronHttpResponseWalletGetnodeinfoGetNodeInfoInt64StringCompatible(
          TronHttpNodeInfoInt64StringCompatible.fromJson(map),
        );
      }
    }
    throw CoreErrors.invalidOperationArguments(
      'TronHttpResponseWalletGetnodeinfoGet',
      reason: 'Cannot parse TronHttpResponseWalletGetnodeinfoGet from $json',
    );
  }

  dynamic toJson();
}

class TronHttpResponseWalletGetnodeinfoGetNodeInfoInt64StringCompatible
    extends TronHttpResponseWalletGetnodeinfoGet {
  final TronHttpNodeInfoInt64StringCompatible value;
  const TronHttpResponseWalletGetnodeinfoGetNodeInfoInt64StringCompatible(
    this.value,
  );

  @override
  dynamic toJson() => value.toJson();
}

class TronHttpResponseWalletGetnodeinfoGetJavaTronError
    extends TronHttpResponseWalletGetnodeinfoGet {
  final TronHttpJavaTronError value;
  const TronHttpResponseWalletGetnodeinfoGetJavaTronError(this.value);

  @override
  dynamic toJson() => value.toJson();
}

sealed class TronHttpResponseWalletGetnodeinfoPost {
  const TronHttpResponseWalletGetnodeinfoPost();

  factory TronHttpResponseWalletGetnodeinfoPost.fromJson(dynamic json) {
    if (json is Map) {
      final map =
          json is Map<String, dynamic> ? json : Map<String, dynamic>.from(json);
      if (map.hasValue('Error')) {
        return TronHttpResponseWalletGetnodeinfoPostJavaTronError(
          TronHttpJavaTronError.fromJson(map),
        );
      }
      if (map.hasValue('activeConnectCount') ||
          map.hasValue('beginSyncNum') ||
          map.hasValue('block') ||
          map.hasValue('cheatWitnessInfoMap') ||
          map.hasValue('configNodeInfo') ||
          map.hasValue('currentConnectCount') ||
          map.hasValue('machineInfo') ||
          map.hasValue('passiveConnectCount') ||
          map.hasValue('peerList') ||
          map.hasValue('solidityBlock') ||
          map.hasValue('totalFlow')) {
        return TronHttpResponseWalletGetnodeinfoPostNodeInfo(
          TronHttpNodeInfo.fromJson(map),
        );
      }
    }
    throw CoreErrors.invalidOperationArguments(
      'TronHttpResponseWalletGetnodeinfoPost',
      reason: 'Cannot parse TronHttpResponseWalletGetnodeinfoPost from $json',
    );
  }

  dynamic toJson();
}

class TronHttpResponseWalletGetnodeinfoPostNodeInfo
    extends TronHttpResponseWalletGetnodeinfoPost {
  final TronHttpNodeInfo value;
  const TronHttpResponseWalletGetnodeinfoPostNodeInfo(this.value);

  @override
  dynamic toJson() => value.toJson();
}

class TronHttpResponseWalletGetnodeinfoPostJavaTronError
    extends TronHttpResponseWalletGetnodeinfoPost {
  final TronHttpJavaTronError value;
  const TronHttpResponseWalletGetnodeinfoPostJavaTronError(this.value);

  @override
  dynamic toJson() => value.toJson();
}

sealed class TronHttpResponseWalletGetnowblockGet {
  const TronHttpResponseWalletGetnowblockGet();

  factory TronHttpResponseWalletGetnowblockGet.fromJson(dynamic json) {
    if (json is Map) {
      final map =
          json is Map<String, dynamic> ? json : Map<String, dynamic>.from(json);
      if (map.hasValue('Error')) {
        return TronHttpResponseWalletGetnowblockGetJavaTronError(
          TronHttpJavaTronError.fromJson(map),
        );
      }
      if (map.hasValue('blockID') ||
          map.hasValue('block_header') ||
          map.hasValue('transactions')) {
        return TronHttpResponseWalletGetnowblockGetBlockInt64StringCompatible(
          TronHttpBlockInt64StringCompatible.fromJson(map),
        );
      }
    }
    throw CoreErrors.invalidOperationArguments(
      'TronHttpResponseWalletGetnowblockGet',
      reason: 'Cannot parse TronHttpResponseWalletGetnowblockGet from $json',
    );
  }

  dynamic toJson();
}

class TronHttpResponseWalletGetnowblockGetBlockInt64StringCompatible
    extends TronHttpResponseWalletGetnowblockGet {
  final TronHttpBlockInt64StringCompatible value;
  const TronHttpResponseWalletGetnowblockGetBlockInt64StringCompatible(
    this.value,
  );

  @override
  dynamic toJson() => value.toJson();
}

class TronHttpResponseWalletGetnowblockGetJavaTronError
    extends TronHttpResponseWalletGetnowblockGet {
  final TronHttpJavaTronError value;
  const TronHttpResponseWalletGetnowblockGetJavaTronError(this.value);

  @override
  dynamic toJson() => value.toJson();
}

sealed class TronHttpResponseWalletGetnowblockPost {
  const TronHttpResponseWalletGetnowblockPost();

  factory TronHttpResponseWalletGetnowblockPost.fromJson(dynamic json) {
    if (json is Map) {
      final map =
          json is Map<String, dynamic> ? json : Map<String, dynamic>.from(json);
      if (map.hasValue('Error')) {
        return TronHttpResponseWalletGetnowblockPostJavaTronError(
          TronHttpJavaTronError.fromJson(map),
        );
      }
      if (map.hasValue('blockID') ||
          map.hasValue('block_header') ||
          map.hasValue('transactions')) {
        return TronHttpResponseWalletGetnowblockPostBlock(
          TronHttpBlock.fromJson(map),
        );
      }
    }
    throw CoreErrors.invalidOperationArguments(
      'TronHttpResponseWalletGetnowblockPost',
      reason: 'Cannot parse TronHttpResponseWalletGetnowblockPost from $json',
    );
  }

  dynamic toJson();
}

class TronHttpResponseWalletGetnowblockPostBlock
    extends TronHttpResponseWalletGetnowblockPost {
  final TronHttpBlock value;
  const TronHttpResponseWalletGetnowblockPostBlock(this.value);

  @override
  dynamic toJson() => value.toJson();
}

class TronHttpResponseWalletGetnowblockPostJavaTronError
    extends TronHttpResponseWalletGetnowblockPost {
  final TronHttpJavaTronError value;
  const TronHttpResponseWalletGetnowblockPostJavaTronError(this.value);

  @override
  dynamic toJson() => value.toJson();
}

sealed class TronHttpResponseWalletGetpendingsizeGet {
  const TronHttpResponseWalletGetpendingsizeGet();

  factory TronHttpResponseWalletGetpendingsizeGet.fromJson(dynamic json) {
    if (json is Map) {
      final map =
          json is Map<String, dynamic> ? json : Map<String, dynamic>.from(json);
      if (map.hasValue('Error')) {
        return TronHttpResponseWalletGetpendingsizeGetJavaTronError(
          TronHttpJavaTronError.fromJson(map),
        );
      }
      if (map.hasValue('pendingSize')) {
        return TronHttpResponseWalletGetpendingsizeGetGetpendingsizeGetResultObject1.fromJson(
          map,
        );
      }
    }
    throw CoreErrors.invalidOperationArguments(
      'TronHttpResponseWalletGetpendingsizeGet',
      reason: 'Cannot parse TronHttpResponseWalletGetpendingsizeGet from $json',
    );
  }

  dynamic toJson();
}

class TronHttpResponseWalletGetpendingsizeGetGetpendingsizeGetResultObject1
    extends TronHttpResponseWalletGetpendingsizeGet {
  final BigInt? pendingSize;

  const TronHttpResponseWalletGetpendingsizeGetGetpendingsizeGetResultObject1({
    this.pendingSize,
  });

  factory TronHttpResponseWalletGetpendingsizeGetGetpendingsizeGetResultObject1.fromJson(
    Map<String, dynamic> json,
  ) {
    return TronHttpResponseWalletGetpendingsizeGetGetpendingsizeGetResultObject1(
      pendingSize: json.valueAsBigInt('pendingSize'),
    );
  }

  @override
  Map<String, dynamic> toJson() => {'pendingSize': pendingSize};
}

class TronHttpResponseWalletGetpendingsizeGetJavaTronError
    extends TronHttpResponseWalletGetpendingsizeGet {
  final TronHttpJavaTronError value;
  const TronHttpResponseWalletGetpendingsizeGetJavaTronError(this.value);

  @override
  dynamic toJson() => value.toJson();
}

sealed class TronHttpResponseWalletGetpendingsizePost {
  const TronHttpResponseWalletGetpendingsizePost();

  factory TronHttpResponseWalletGetpendingsizePost.fromJson(dynamic json) {
    if (json is Map) {
      final map =
          json is Map<String, dynamic> ? json : Map<String, dynamic>.from(json);
      if (map.hasValue('Error')) {
        return TronHttpResponseWalletGetpendingsizePostJavaTronError(
          TronHttpJavaTronError.fromJson(map),
        );
      }
      if (map.hasValue('pendingSize')) {
        return TronHttpResponseWalletGetpendingsizePostGetpendingsizePostResultObject1.fromJson(
          map,
        );
      }
    }
    throw CoreErrors.invalidOperationArguments(
      'TronHttpResponseWalletGetpendingsizePost',
      reason:
          'Cannot parse TronHttpResponseWalletGetpendingsizePost from $json',
    );
  }

  dynamic toJson();
}

class TronHttpResponseWalletGetpendingsizePostGetpendingsizePostResultObject1
    extends TronHttpResponseWalletGetpendingsizePost {
  final BigInt? pendingSize;

  const TronHttpResponseWalletGetpendingsizePostGetpendingsizePostResultObject1({
    this.pendingSize,
  });

  factory TronHttpResponseWalletGetpendingsizePostGetpendingsizePostResultObject1.fromJson(
    Map<String, dynamic> json,
  ) {
    return TronHttpResponseWalletGetpendingsizePostGetpendingsizePostResultObject1(
      pendingSize: json.valueAsBigInt('pendingSize'),
    );
  }

  @override
  Map<String, dynamic> toJson() => {'pendingSize': pendingSize};
}

class TronHttpResponseWalletGetpendingsizePostJavaTronError
    extends TronHttpResponseWalletGetpendingsizePost {
  final TronHttpJavaTronError value;
  const TronHttpResponseWalletGetpendingsizePostJavaTronError(this.value);

  @override
  dynamic toJson() => value.toJson();
}

sealed class TronHttpResponseWalletGetproposalbyidGet {
  const TronHttpResponseWalletGetproposalbyidGet();

  factory TronHttpResponseWalletGetproposalbyidGet.fromJson(dynamic json) {
    if (json is Map) {
      final map =
          json is Map<String, dynamic> ? json : Map<String, dynamic>.from(json);
      if (map.hasValue('Error')) {
        return TronHttpResponseWalletGetproposalbyidGetJavaTronError(
          TronHttpJavaTronError.fromJson(map),
        );
      }
      if (map.hasValue('approvals') ||
          map.hasValue('create_time') ||
          map.hasValue('expiration_time') ||
          map.hasValue('parameters') ||
          map.hasValue('proposal_id') ||
          map.hasValue('proposer_address') ||
          map.hasValue('state')) {
        return TronHttpResponseWalletGetproposalbyidGetProposalInt64StringCompatible(
          TronHttpProposalInt64StringCompatible.fromJson(map),
        );
      }
    }
    throw CoreErrors.invalidOperationArguments(
      'TronHttpResponseWalletGetproposalbyidGet',
      reason:
          'Cannot parse TronHttpResponseWalletGetproposalbyidGet from $json',
    );
  }

  dynamic toJson();
}

class TronHttpResponseWalletGetproposalbyidGetProposalInt64StringCompatible
    extends TronHttpResponseWalletGetproposalbyidGet {
  final TronHttpProposalInt64StringCompatible value;
  const TronHttpResponseWalletGetproposalbyidGetProposalInt64StringCompatible(
    this.value,
  );

  @override
  dynamic toJson() => value.toJson();
}

class TronHttpResponseWalletGetproposalbyidGetJavaTronError
    extends TronHttpResponseWalletGetproposalbyidGet {
  final TronHttpJavaTronError value;
  const TronHttpResponseWalletGetproposalbyidGetJavaTronError(this.value);

  @override
  dynamic toJson() => value.toJson();
}

sealed class TronHttpResponseWalletGetproposalbyidPost {
  const TronHttpResponseWalletGetproposalbyidPost();

  factory TronHttpResponseWalletGetproposalbyidPost.fromJson(dynamic json) {
    if (json is Map) {
      final map =
          json is Map<String, dynamic> ? json : Map<String, dynamic>.from(json);
      if (map.hasValue('Error')) {
        return TronHttpResponseWalletGetproposalbyidPostJavaTronError(
          TronHttpJavaTronError.fromJson(map),
        );
      }
      if (map.hasValue('approvals') ||
          map.hasValue('create_time') ||
          map.hasValue('expiration_time') ||
          map.hasValue('parameters') ||
          map.hasValue('proposal_id') ||
          map.hasValue('proposer_address') ||
          map.hasValue('state')) {
        return TronHttpResponseWalletGetproposalbyidPostProposal(
          TronHttpProposal.fromJson(map),
        );
      }
    }
    throw CoreErrors.invalidOperationArguments(
      'TronHttpResponseWalletGetproposalbyidPost',
      reason:
          'Cannot parse TronHttpResponseWalletGetproposalbyidPost from $json',
    );
  }

  dynamic toJson();
}

class TronHttpResponseWalletGetproposalbyidPostProposal
    extends TronHttpResponseWalletGetproposalbyidPost {
  final TronHttpProposal value;
  const TronHttpResponseWalletGetproposalbyidPostProposal(this.value);

  @override
  dynamic toJson() => value.toJson();
}

class TronHttpResponseWalletGetproposalbyidPostJavaTronError
    extends TronHttpResponseWalletGetproposalbyidPost {
  final TronHttpJavaTronError value;
  const TronHttpResponseWalletGetproposalbyidPostJavaTronError(this.value);

  @override
  dynamic toJson() => value.toJson();
}

sealed class TronHttpResponseWalletGetsignweightPost {
  const TronHttpResponseWalletGetsignweightPost();

  factory TronHttpResponseWalletGetsignweightPost.fromJson(dynamic json) {
    if (json is Map) {
      final map =
          json is Map<String, dynamic> ? json : Map<String, dynamic>.from(json);
      if (map.hasValue('Error')) {
        return TronHttpResponseWalletGetsignweightPostJavaTronError(
          TronHttpJavaTronError.fromJson(map),
        );
      }
      if (map.hasValue('approved_list') ||
          map.hasValue('current_weight') ||
          map.hasValue('permission') ||
          map.hasValue('result') ||
          map.hasValue('transaction')) {
        return TronHttpResponseWalletGetsignweightPostTransactionSignWeight(
          TronHttpTransactionSignWeight.fromJson(map),
        );
      }
    }
    throw CoreErrors.invalidOperationArguments(
      'TronHttpResponseWalletGetsignweightPost',
      reason: 'Cannot parse TronHttpResponseWalletGetsignweightPost from $json',
    );
  }

  dynamic toJson();
}

class TronHttpResponseWalletGetsignweightPostTransactionSignWeight
    extends TronHttpResponseWalletGetsignweightPost {
  final TronHttpTransactionSignWeight value;
  const TronHttpResponseWalletGetsignweightPostTransactionSignWeight(
    this.value,
  );

  @override
  dynamic toJson() => value.toJson();
}

class TronHttpResponseWalletGetsignweightPostJavaTronError
    extends TronHttpResponseWalletGetsignweightPost {
  final TronHttpJavaTronError value;
  const TronHttpResponseWalletGetsignweightPostJavaTronError(this.value);

  @override
  dynamic toJson() => value.toJson();
}

sealed class TronHttpResponseWalletGettransactionbyidGet {
  const TronHttpResponseWalletGettransactionbyidGet();

  factory TronHttpResponseWalletGettransactionbyidGet.fromJson(dynamic json) {
    if (json is Map) {
      final map =
          json is Map<String, dynamic> ? json : Map<String, dynamic>.from(json);
      if (map.hasValue('Error')) {
        return TronHttpResponseWalletGettransactionbyidGetJavaTronError(
          TronHttpJavaTronError.fromJson(map),
        );
      }
      if (map.hasValue('contract_address') ||
          map.hasValue('raw_data') ||
          map.hasValue('raw_data_hex') ||
          map.hasValue('ret') ||
          map.hasValue('signature') ||
          map.hasValue('txID') ||
          map.hasValue('visible')) {
        return TronHttpResponseWalletGettransactionbyidGetTransactionInt64StringCompatible(
          TronHttpTransactionInt64StringCompatible.fromJson(map),
        );
      }
    }
    throw CoreErrors.invalidOperationArguments(
      'TronHttpResponseWalletGettransactionbyidGet',
      reason:
          'Cannot parse TronHttpResponseWalletGettransactionbyidGet from $json',
    );
  }

  dynamic toJson();
}

class TronHttpResponseWalletGettransactionbyidGetTransactionInt64StringCompatible
    extends TronHttpResponseWalletGettransactionbyidGet {
  final TronHttpTransactionInt64StringCompatible value;
  const TronHttpResponseWalletGettransactionbyidGetTransactionInt64StringCompatible(
    this.value,
  );

  @override
  dynamic toJson() => value.toJson();
}

class TronHttpResponseWalletGettransactionbyidGetJavaTronError
    extends TronHttpResponseWalletGettransactionbyidGet {
  final TronHttpJavaTronError value;
  const TronHttpResponseWalletGettransactionbyidGetJavaTronError(this.value);

  @override
  dynamic toJson() => value.toJson();
}

sealed class TronHttpResponseWalletGettransactioncountbyblocknumGet {
  const TronHttpResponseWalletGettransactioncountbyblocknumGet();

  factory TronHttpResponseWalletGettransactioncountbyblocknumGet.fromJson(
    dynamic json,
  ) {
    if (json is Map) {
      final map =
          json is Map<String, dynamic> ? json : Map<String, dynamic>.from(json);
      if (map.hasValue('Error')) {
        return TronHttpResponseWalletGettransactioncountbyblocknumGetJavaTronError(
          TronHttpJavaTronError.fromJson(map),
        );
      }
      if (map.hasValue('count')) {
        return TronHttpResponseWalletGettransactioncountbyblocknumGetGettransactioncountbyblocknumGetResultObject1.fromJson(
          map,
        );
      }
    }
    throw CoreErrors.invalidOperationArguments(
      'TronHttpResponseWalletGettransactioncountbyblocknumGet',
      reason:
          'Cannot parse TronHttpResponseWalletGettransactioncountbyblocknumGet from $json',
    );
  }

  dynamic toJson();
}

class TronHttpResponseWalletGettransactioncountbyblocknumGetGettransactioncountbyblocknumGetResultObject1
    extends TronHttpResponseWalletGettransactioncountbyblocknumGet {
  final BigInt? count;

  const TronHttpResponseWalletGettransactioncountbyblocknumGetGettransactioncountbyblocknumGetResultObject1({
    this.count,
  });

  factory TronHttpResponseWalletGettransactioncountbyblocknumGetGettransactioncountbyblocknumGetResultObject1.fromJson(
    Map<String, dynamic> json,
  ) {
    return TronHttpResponseWalletGettransactioncountbyblocknumGetGettransactioncountbyblocknumGetResultObject1(
      count: json.valueAsBigInt('count'),
    );
  }

  @override
  Map<String, dynamic> toJson() => {'count': count};
}

class TronHttpResponseWalletGettransactioncountbyblocknumGetJavaTronError
    extends TronHttpResponseWalletGettransactioncountbyblocknumGet {
  final TronHttpJavaTronError value;
  const TronHttpResponseWalletGettransactioncountbyblocknumGetJavaTronError(
    this.value,
  );

  @override
  dynamic toJson() => value.toJson();
}

sealed class TronHttpResponseWalletGettransactioncountbyblocknumPost {
  const TronHttpResponseWalletGettransactioncountbyblocknumPost();

  factory TronHttpResponseWalletGettransactioncountbyblocknumPost.fromJson(
    dynamic json,
  ) {
    if (json is Map) {
      final map =
          json is Map<String, dynamic> ? json : Map<String, dynamic>.from(json);
      if (map.hasValue('Error')) {
        return TronHttpResponseWalletGettransactioncountbyblocknumPostJavaTronError(
          TronHttpJavaTronError.fromJson(map),
        );
      }
      if (map.hasValue('count')) {
        return TronHttpResponseWalletGettransactioncountbyblocknumPostGettransactioncountbyblocknumPostResultObject1.fromJson(
          map,
        );
      }
    }
    throw CoreErrors.invalidOperationArguments(
      'TronHttpResponseWalletGettransactioncountbyblocknumPost',
      reason:
          'Cannot parse TronHttpResponseWalletGettransactioncountbyblocknumPost from $json',
    );
  }

  dynamic toJson();
}

class TronHttpResponseWalletGettransactioncountbyblocknumPostGettransactioncountbyblocknumPostResultObject1
    extends TronHttpResponseWalletGettransactioncountbyblocknumPost {
  final BigInt? count;

  const TronHttpResponseWalletGettransactioncountbyblocknumPostGettransactioncountbyblocknumPostResultObject1({
    this.count,
  });

  factory TronHttpResponseWalletGettransactioncountbyblocknumPostGettransactioncountbyblocknumPostResultObject1.fromJson(
    Map<String, dynamic> json,
  ) {
    return TronHttpResponseWalletGettransactioncountbyblocknumPostGettransactioncountbyblocknumPostResultObject1(
      count: json.valueAsBigInt('count'),
    );
  }

  @override
  Map<String, dynamic> toJson() => {'count': count};
}

class TronHttpResponseWalletGettransactioncountbyblocknumPostJavaTronError
    extends TronHttpResponseWalletGettransactioncountbyblocknumPost {
  final TronHttpJavaTronError value;
  const TronHttpResponseWalletGettransactioncountbyblocknumPostJavaTronError(
    this.value,
  );

  @override
  dynamic toJson() => value.toJson();
}

sealed class TronHttpResponseWalletGettransactioninfobyblocknumGet {
  const TronHttpResponseWalletGettransactioninfobyblocknumGet();

  factory TronHttpResponseWalletGettransactioninfobyblocknumGet.fromJson(
    dynamic json,
  ) {
    if (json is List) {
      return TronHttpResponseWalletGettransactioninfobyblocknumGetGettransactioninfobyblocknumGetResultArray1(
        json
            .map(
              (e) => TronHttpTransactionInfoInt64StringCompatible.fromJson(e),
            )
            .toList(),
      );
    }
    if (json is Map) {
      final map =
          json is Map<String, dynamic> ? json : Map<String, dynamic>.from(json);
      if (map.hasValue('Error')) {
        return TronHttpResponseWalletGettransactioninfobyblocknumGetJavaTronError(
          TronHttpJavaTronError.fromJson(map),
        );
      }
      return TronHttpResponseWalletGettransactioninfobyblocknumGetGettransactioninfobyblocknumGetResultEmpty2.fromJson(
        map,
      );
    }
    throw CoreErrors.invalidOperationArguments(
      'TronHttpResponseWalletGettransactioninfobyblocknumGet',
      reason:
          'Cannot parse TronHttpResponseWalletGettransactioninfobyblocknumGet from $json',
    );
  }

  dynamic toJson();
}

class TronHttpResponseWalletGettransactioninfobyblocknumGetGettransactioninfobyblocknumGetResultArray1
    extends TronHttpResponseWalletGettransactioninfobyblocknumGet {
  final List<TronHttpTransactionInfoInt64StringCompatible> value;
  const TronHttpResponseWalletGettransactioninfobyblocknumGetGettransactioninfobyblocknumGetResultArray1(
    this.value,
  );

  @override
  dynamic toJson() => value.map((e) => e.toJson()).toList();
}

class TronHttpResponseWalletGettransactioninfobyblocknumGetGettransactioninfobyblocknumGetResultEmpty2
    extends TronHttpResponseWalletGettransactioninfobyblocknumGet {
  final Map<String, dynamic> values;
  const TronHttpResponseWalletGettransactioninfobyblocknumGetGettransactioninfobyblocknumGetResultEmpty2(
    this.values,
  );

  factory TronHttpResponseWalletGettransactioninfobyblocknumGetGettransactioninfobyblocknumGetResultEmpty2.fromJson(
    Map<String, dynamic> json,
  ) =>
      TronHttpResponseWalletGettransactioninfobyblocknumGetGettransactioninfobyblocknumGetResultEmpty2(
        json.map((k, v) => MapEntry(k, v)),
      );

  @override
  Map<String, dynamic> toJson() => values.map((k, v) => MapEntry(k, v));
}

class TronHttpResponseWalletGettransactioninfobyblocknumGetJavaTronError
    extends TronHttpResponseWalletGettransactioninfobyblocknumGet {
  final TronHttpJavaTronError value;
  const TronHttpResponseWalletGettransactioninfobyblocknumGetJavaTronError(
    this.value,
  );

  @override
  dynamic toJson() => value.toJson();
}

sealed class TronHttpResponseWalletGettransactioninfobyblocknumPost {
  const TronHttpResponseWalletGettransactioninfobyblocknumPost();

  factory TronHttpResponseWalletGettransactioninfobyblocknumPost.fromJson(
    dynamic json,
  ) {
    if (json is List) {
      return TronHttpResponseWalletGettransactioninfobyblocknumPostGettransactioninfobyblocknumPostResultArray1(
        json.map((e) => TronHttpTransactionInfo.fromJson(e)).toList(),
      );
    }
    if (json is Map) {
      final map =
          json is Map<String, dynamic> ? json : Map<String, dynamic>.from(json);
      if (map.hasValue('Error')) {
        return TronHttpResponseWalletGettransactioninfobyblocknumPostJavaTronError(
          TronHttpJavaTronError.fromJson(map),
        );
      }
      return TronHttpResponseWalletGettransactioninfobyblocknumPostGettransactioninfobyblocknumPostResultEmpty2.fromJson(
        map,
      );
    }
    throw CoreErrors.invalidOperationArguments(
      'TronHttpResponseWalletGettransactioninfobyblocknumPost',
      reason:
          'Cannot parse TronHttpResponseWalletGettransactioninfobyblocknumPost from $json',
    );
  }

  dynamic toJson();
}

class TronHttpResponseWalletGettransactioninfobyblocknumPostGettransactioninfobyblocknumPostResultArray1
    extends TronHttpResponseWalletGettransactioninfobyblocknumPost {
  final List<TronHttpTransactionInfo> value;
  const TronHttpResponseWalletGettransactioninfobyblocknumPostGettransactioninfobyblocknumPostResultArray1(
    this.value,
  );

  @override
  dynamic toJson() => value.map((e) => e.toJson()).toList();
}

class TronHttpResponseWalletGettransactioninfobyblocknumPostGettransactioninfobyblocknumPostResultEmpty2
    extends TronHttpResponseWalletGettransactioninfobyblocknumPost {
  final Map<String, dynamic> values;
  const TronHttpResponseWalletGettransactioninfobyblocknumPostGettransactioninfobyblocknumPostResultEmpty2(
    this.values,
  );

  factory TronHttpResponseWalletGettransactioninfobyblocknumPostGettransactioninfobyblocknumPostResultEmpty2.fromJson(
    Map<String, dynamic> json,
  ) =>
      TronHttpResponseWalletGettransactioninfobyblocknumPostGettransactioninfobyblocknumPostResultEmpty2(
        json.map((k, v) => MapEntry(k, v)),
      );

  @override
  Map<String, dynamic> toJson() => values.map((k, v) => MapEntry(k, v));
}

class TronHttpResponseWalletGettransactioninfobyblocknumPostJavaTronError
    extends TronHttpResponseWalletGettransactioninfobyblocknumPost {
  final TronHttpJavaTronError value;
  const TronHttpResponseWalletGettransactioninfobyblocknumPostJavaTronError(
    this.value,
  );

  @override
  dynamic toJson() => value.toJson();
}

sealed class TronHttpResponseWalletGettransactioninfobyidGet {
  const TronHttpResponseWalletGettransactioninfobyidGet();

  factory TronHttpResponseWalletGettransactioninfobyidGet.fromJson(
    dynamic json,
  ) {
    if (json is Map) {
      final map =
          json is Map<String, dynamic> ? json : Map<String, dynamic>.from(json);
      if (map.hasValue('Error')) {
        return TronHttpResponseWalletGettransactioninfobyidGetJavaTronError(
          TronHttpJavaTronError.fromJson(map),
        );
      }
      if (map.hasValue('assetIssueID') ||
          map.hasValue('blockNumber') ||
          map.hasValue('blockTimeStamp') ||
          map.hasValue('cancel_unfreezeV2_amount') ||
          map.hasValue('contractResult') ||
          map.hasValue('contract_address') ||
          map.hasValue('exchange_id') ||
          map.hasValue('exchange_inject_another_amount') ||
          map.hasValue('exchange_received_amount') ||
          map.hasValue('exchange_withdraw_another_amount') ||
          map.hasValue('fee') ||
          map.hasValue('id') ||
          map.hasValue('internal_transactions') ||
          map.hasValue('log') ||
          map.hasValue('orderDetails') ||
          map.hasValue('orderId') ||
          map.hasValue('packingFee') ||
          map.hasValue('receipt') ||
          map.hasValue('resMessage') ||
          map.hasValue('result') ||
          map.hasValue('shielded_transaction_fee') ||
          map.hasValue('unfreeze_amount') ||
          map.hasValue('withdraw_amount') ||
          map.hasValue('withdraw_expire_amount')) {
        return TronHttpResponseWalletGettransactioninfobyidGetTransactionInfoInt64StringCompatible(
          TronHttpTransactionInfoInt64StringCompatible.fromJson(map),
        );
      }
    }
    throw CoreErrors.invalidOperationArguments(
      'TronHttpResponseWalletGettransactioninfobyidGet',
      reason:
          'Cannot parse TronHttpResponseWalletGettransactioninfobyidGet from $json',
    );
  }

  dynamic toJson();
}

class TronHttpResponseWalletGettransactioninfobyidGetTransactionInfoInt64StringCompatible
    extends TronHttpResponseWalletGettransactioninfobyidGet {
  final TronHttpTransactionInfoInt64StringCompatible value;
  const TronHttpResponseWalletGettransactioninfobyidGetTransactionInfoInt64StringCompatible(
    this.value,
  );

  @override
  dynamic toJson() => value.toJson();
}

class TronHttpResponseWalletGettransactioninfobyidGetJavaTronError
    extends TronHttpResponseWalletGettransactioninfobyidGet {
  final TronHttpJavaTronError value;
  const TronHttpResponseWalletGettransactioninfobyidGetJavaTronError(
    this.value,
  );

  @override
  dynamic toJson() => value.toJson();
}

sealed class TronHttpResponseWalletGettransactioninfobyidPost {
  const TronHttpResponseWalletGettransactioninfobyidPost();

  factory TronHttpResponseWalletGettransactioninfobyidPost.fromJson(
    dynamic json,
  ) {
    if (json is Map) {
      final map =
          json is Map<String, dynamic> ? json : Map<String, dynamic>.from(json);
      if (map.hasValue('Error')) {
        return TronHttpResponseWalletGettransactioninfobyidPostJavaTronError(
          TronHttpJavaTronError.fromJson(map),
        );
      }
      if (map.hasValue('assetIssueID') ||
          map.hasValue('blockNumber') ||
          map.hasValue('blockTimeStamp') ||
          map.hasValue('cancel_unfreezeV2_amount') ||
          map.hasValue('contractResult') ||
          map.hasValue('contract_address') ||
          map.hasValue('exchange_id') ||
          map.hasValue('exchange_inject_another_amount') ||
          map.hasValue('exchange_received_amount') ||
          map.hasValue('exchange_withdraw_another_amount') ||
          map.hasValue('fee') ||
          map.hasValue('id') ||
          map.hasValue('internal_transactions') ||
          map.hasValue('log') ||
          map.hasValue('orderDetails') ||
          map.hasValue('orderId') ||
          map.hasValue('packingFee') ||
          map.hasValue('receipt') ||
          map.hasValue('resMessage') ||
          map.hasValue('result') ||
          map.hasValue('shielded_transaction_fee') ||
          map.hasValue('unfreeze_amount') ||
          map.hasValue('withdraw_amount') ||
          map.hasValue('withdraw_expire_amount')) {
        return TronHttpResponseWalletGettransactioninfobyidPostTransactionInfo(
          TronHttpTransactionInfo.fromJson(map),
        );
      }
    }
    throw CoreErrors.invalidOperationArguments(
      'TronHttpResponseWalletGettransactioninfobyidPost',
      reason:
          'Cannot parse TronHttpResponseWalletGettransactioninfobyidPost from $json',
    );
  }

  dynamic toJson();
}

class TronHttpResponseWalletGettransactioninfobyidPostTransactionInfo
    extends TronHttpResponseWalletGettransactioninfobyidPost {
  final TronHttpTransactionInfo value;
  const TronHttpResponseWalletGettransactioninfobyidPostTransactionInfo(
    this.value,
  );

  @override
  dynamic toJson() => value.toJson();
}

class TronHttpResponseWalletGettransactioninfobyidPostJavaTronError
    extends TronHttpResponseWalletGettransactioninfobyidPost {
  final TronHttpJavaTronError value;
  const TronHttpResponseWalletGettransactioninfobyidPostJavaTronError(
    this.value,
  );

  @override
  dynamic toJson() => value.toJson();
}

sealed class TronHttpResponseWalletGettransactionlistfrompendingGet {
  const TronHttpResponseWalletGettransactionlistfrompendingGet();

  factory TronHttpResponseWalletGettransactionlistfrompendingGet.fromJson(
    dynamic json,
  ) {
    if (json is Map) {
      final map =
          json is Map<String, dynamic> ? json : Map<String, dynamic>.from(json);
      if (map.hasValue('Error')) {
        return TronHttpResponseWalletGettransactionlistfrompendingGetJavaTronError(
          TronHttpJavaTronError.fromJson(map),
        );
      }
      if (map.hasValue('txId')) {
        return TronHttpResponseWalletGettransactionlistfrompendingGetTransactionIdList(
          TronHttpTransactionIdList.fromJson(map),
        );
      }
    }
    throw CoreErrors.invalidOperationArguments(
      'TronHttpResponseWalletGettransactionlistfrompendingGet',
      reason:
          'Cannot parse TronHttpResponseWalletGettransactionlistfrompendingGet from $json',
    );
  }

  dynamic toJson();
}

class TronHttpResponseWalletGettransactionlistfrompendingGetTransactionIdList
    extends TronHttpResponseWalletGettransactionlistfrompendingGet {
  final TronHttpTransactionIdList value;
  const TronHttpResponseWalletGettransactionlistfrompendingGetTransactionIdList(
    this.value,
  );

  @override
  dynamic toJson() => value.toJson();
}

class TronHttpResponseWalletGettransactionlistfrompendingGetJavaTronError
    extends TronHttpResponseWalletGettransactionlistfrompendingGet {
  final TronHttpJavaTronError value;
  const TronHttpResponseWalletGettransactionlistfrompendingGetJavaTronError(
    this.value,
  );

  @override
  dynamic toJson() => value.toJson();
}

sealed class TronHttpResponseWalletListnodesGet {
  const TronHttpResponseWalletListnodesGet();

  factory TronHttpResponseWalletListnodesGet.fromJson(dynamic json) {
    if (json is Map) {
      final map =
          json is Map<String, dynamic> ? json : Map<String, dynamic>.from(json);
      if (map.hasValue('Error')) {
        return TronHttpResponseWalletListnodesGetJavaTronError(
          TronHttpJavaTronError.fromJson(map),
        );
      }
      if (map.hasValue('nodes')) {
        return TronHttpResponseWalletListnodesGetNodeList(
          TronHttpNodeList.fromJson(map),
        );
      }
    }
    throw CoreErrors.invalidOperationArguments(
      'TronHttpResponseWalletListnodesGet',
      reason: 'Cannot parse TronHttpResponseWalletListnodesGet from $json',
    );
  }

  dynamic toJson();
}

class TronHttpResponseWalletListnodesGetNodeList
    extends TronHttpResponseWalletListnodesGet {
  final TronHttpNodeList value;
  const TronHttpResponseWalletListnodesGetNodeList(this.value);

  @override
  dynamic toJson() => value.toJson();
}

class TronHttpResponseWalletListnodesGetJavaTronError
    extends TronHttpResponseWalletListnodesGet {
  final TronHttpJavaTronError value;
  const TronHttpResponseWalletListnodesGetJavaTronError(this.value);

  @override
  dynamic toJson() => value.toJson();
}

sealed class TronHttpResponseWalletListproposalsGet {
  const TronHttpResponseWalletListproposalsGet();

  factory TronHttpResponseWalletListproposalsGet.fromJson(dynamic json) {
    if (json is Map) {
      final map =
          json is Map<String, dynamic> ? json : Map<String, dynamic>.from(json);
      if (map.hasValue('Error')) {
        return TronHttpResponseWalletListproposalsGetJavaTronError(
          TronHttpJavaTronError.fromJson(map),
        );
      }
      if (map.hasValue('proposals')) {
        return TronHttpResponseWalletListproposalsGetProposalListInt64StringCompatible(
          TronHttpProposalListInt64StringCompatible.fromJson(map),
        );
      }
    }
    throw CoreErrors.invalidOperationArguments(
      'TronHttpResponseWalletListproposalsGet',
      reason: 'Cannot parse TronHttpResponseWalletListproposalsGet from $json',
    );
  }

  dynamic toJson();
}

class TronHttpResponseWalletListproposalsGetProposalListInt64StringCompatible
    extends TronHttpResponseWalletListproposalsGet {
  final TronHttpProposalListInt64StringCompatible value;
  const TronHttpResponseWalletListproposalsGetProposalListInt64StringCompatible(
    this.value,
  );

  @override
  dynamic toJson() => value.toJson();
}

class TronHttpResponseWalletListproposalsGetJavaTronError
    extends TronHttpResponseWalletListproposalsGet {
  final TronHttpJavaTronError value;
  const TronHttpResponseWalletListproposalsGetJavaTronError(this.value);

  @override
  dynamic toJson() => value.toJson();
}

sealed class TronHttpResponseWalletListproposalsPost {
  const TronHttpResponseWalletListproposalsPost();

  factory TronHttpResponseWalletListproposalsPost.fromJson(dynamic json) {
    if (json is Map) {
      final map =
          json is Map<String, dynamic> ? json : Map<String, dynamic>.from(json);
      if (map.hasValue('Error')) {
        return TronHttpResponseWalletListproposalsPostJavaTronError(
          TronHttpJavaTronError.fromJson(map),
        );
      }
      if (map.hasValue('proposals')) {
        return TronHttpResponseWalletListproposalsPostProposalList(
          TronHttpProposalList.fromJson(map),
        );
      }
    }
    throw CoreErrors.invalidOperationArguments(
      'TronHttpResponseWalletListproposalsPost',
      reason: 'Cannot parse TronHttpResponseWalletListproposalsPost from $json',
    );
  }

  dynamic toJson();
}

class TronHttpResponseWalletListproposalsPostProposalList
    extends TronHttpResponseWalletListproposalsPost {
  final TronHttpProposalList value;
  const TronHttpResponseWalletListproposalsPostProposalList(this.value);

  @override
  dynamic toJson() => value.toJson();
}

class TronHttpResponseWalletListproposalsPostJavaTronError
    extends TronHttpResponseWalletListproposalsPost {
  final TronHttpJavaTronError value;
  const TronHttpResponseWalletListproposalsPostJavaTronError(this.value);

  @override
  dynamic toJson() => value.toJson();
}

sealed class TronHttpResponseWalletListwitnessesGet {
  const TronHttpResponseWalletListwitnessesGet();

  factory TronHttpResponseWalletListwitnessesGet.fromJson(dynamic json) {
    if (json is Map) {
      final map =
          json is Map<String, dynamic> ? json : Map<String, dynamic>.from(json);
      if (map.hasValue('Error')) {
        return TronHttpResponseWalletListwitnessesGetJavaTronError(
          TronHttpJavaTronError.fromJson(map),
        );
      }
      if (map.hasValue('witnesses')) {
        return TronHttpResponseWalletListwitnessesGetWitnessListInt64StringCompatible(
          TronHttpWitnessListInt64StringCompatible.fromJson(map),
        );
      }
    }
    throw CoreErrors.invalidOperationArguments(
      'TronHttpResponseWalletListwitnessesGet',
      reason: 'Cannot parse TronHttpResponseWalletListwitnessesGet from $json',
    );
  }

  dynamic toJson();
}

class TronHttpResponseWalletListwitnessesGetWitnessListInt64StringCompatible
    extends TronHttpResponseWalletListwitnessesGet {
  final TronHttpWitnessListInt64StringCompatible value;
  const TronHttpResponseWalletListwitnessesGetWitnessListInt64StringCompatible(
    this.value,
  );

  @override
  dynamic toJson() => value.toJson();
}

class TronHttpResponseWalletListwitnessesGetJavaTronError
    extends TronHttpResponseWalletListwitnessesGet {
  final TronHttpJavaTronError value;
  const TronHttpResponseWalletListwitnessesGetJavaTronError(this.value);

  @override
  dynamic toJson() => value.toJson();
}

sealed class TronHttpResponseWalletListwitnessesPost {
  const TronHttpResponseWalletListwitnessesPost();

  factory TronHttpResponseWalletListwitnessesPost.fromJson(dynamic json) {
    if (json is Map) {
      final map =
          json is Map<String, dynamic> ? json : Map<String, dynamic>.from(json);
      if (map.hasValue('Error')) {
        return TronHttpResponseWalletListwitnessesPostJavaTronError(
          TronHttpJavaTronError.fromJson(map),
        );
      }
      if (map.hasValue('witnesses')) {
        return TronHttpResponseWalletListwitnessesPostWitnessList(
          TronHttpWitnessList.fromJson(map),
        );
      }
    }
    throw CoreErrors.invalidOperationArguments(
      'TronHttpResponseWalletListwitnessesPost',
      reason: 'Cannot parse TronHttpResponseWalletListwitnessesPost from $json',
    );
  }

  dynamic toJson();
}

class TronHttpResponseWalletListwitnessesPostWitnessList
    extends TronHttpResponseWalletListwitnessesPost {
  final TronHttpWitnessList value;
  const TronHttpResponseWalletListwitnessesPostWitnessList(this.value);

  @override
  dynamic toJson() => value.toJson();
}

class TronHttpResponseWalletListwitnessesPostJavaTronError
    extends TronHttpResponseWalletListwitnessesPost {
  final TronHttpJavaTronError value;
  const TronHttpResponseWalletListwitnessesPostJavaTronError(this.value);

  @override
  dynamic toJson() => value.toJson();
}

sealed class TronHttpResponseWalletTriggersmartcontractPost {
  const TronHttpResponseWalletTriggersmartcontractPost();

  factory TronHttpResponseWalletTriggersmartcontractPost.fromJson(
    dynamic json,
  ) {
    if (json is Map) {
      final map =
          json is Map<String, dynamic> ? json : Map<String, dynamic>.from(json);
      if (map.hasValue('Error')) {
        return TronHttpResponseWalletTriggersmartcontractPostJavaTronError(
          TronHttpJavaTronError.fromJson(map),
        );
      }
      if (map.hasValue('constant_result') ||
          map.hasValue('energy_penalty') ||
          map.hasValue('energy_used') ||
          map.hasValue('internal_transactions') ||
          map.hasValue('logs') ||
          map.hasValue('result') ||
          map.hasValue('transaction') ||
          map.hasValue('txid')) {
        return TronHttpResponseWalletTriggersmartcontractPostTransactionExtention(
          TronHttpTransactionExtention.fromJson(map),
        );
      }
    }
    throw CoreErrors.invalidOperationArguments(
      'TronHttpResponseWalletTriggersmartcontractPost',
      reason:
          'Cannot parse TronHttpResponseWalletTriggersmartcontractPost from $json',
    );
  }

  dynamic toJson();
}

class TronHttpResponseWalletTriggersmartcontractPostTransactionExtention
    extends TronHttpResponseWalletTriggersmartcontractPost {
  final TronHttpTransactionExtention value;
  const TronHttpResponseWalletTriggersmartcontractPostTransactionExtention(
    this.value,
  );

  @override
  dynamic toJson() => value.toJson();
}

class TronHttpResponseWalletTriggersmartcontractPostJavaTronError
    extends TronHttpResponseWalletTriggersmartcontractPost {
  final TronHttpJavaTronError value;
  const TronHttpResponseWalletTriggersmartcontractPostJavaTronError(this.value);

  @override
  dynamic toJson() => value.toJson();
}

sealed class TronHttpResponseWalletValidateaddressGet {
  const TronHttpResponseWalletValidateaddressGet();

  factory TronHttpResponseWalletValidateaddressGet.fromJson(dynamic json) {
    if (json is Map) {
      final map =
          json is Map<String, dynamic> ? json : Map<String, dynamic>.from(json);
      if (map.hasValue('Error')) {
        return TronHttpResponseWalletValidateaddressGetJavaTronError(
          TronHttpJavaTronError.fromJson(map),
        );
      }
      if (map.hasValue('result') && map.hasValue('message')) {
        return TronHttpResponseWalletValidateaddressGetValidateaddressGetResultObject1.fromJson(
          map,
        );
      }
    }
    throw CoreErrors.invalidOperationArguments(
      'TronHttpResponseWalletValidateaddressGet',
      reason:
          'Cannot parse TronHttpResponseWalletValidateaddressGet from $json',
    );
  }

  dynamic toJson();
}

class TronHttpResponseWalletValidateaddressGetValidateaddressGetResultObject1
    extends TronHttpResponseWalletValidateaddressGet {
  final bool? result;
  final String? message;

  const TronHttpResponseWalletValidateaddressGetValidateaddressGetResultObject1({
    this.result,
    this.message,
  });

  factory TronHttpResponseWalletValidateaddressGetValidateaddressGetResultObject1.fromJson(
    Map<String, dynamic> json,
  ) {
    return TronHttpResponseWalletValidateaddressGetValidateaddressGetResultObject1(
      result: json.valueAsBool('result'),
      message:
          (json['message'] is num
              ? json['message'].toString()
              : json.valueAsString('message')),
    );
  }

  @override
  Map<String, dynamic> toJson() => {'result': result, 'message': message};
}

class TronHttpResponseWalletValidateaddressGetJavaTronError
    extends TronHttpResponseWalletValidateaddressGet {
  final TronHttpJavaTronError value;
  const TronHttpResponseWalletValidateaddressGetJavaTronError(this.value);

  @override
  dynamic toJson() => value.toJson();
}

enum TronHttpReturnCode {
  success("SUCCESS"),
  sigerror("SIGERROR"),
  contractValidateError("CONTRACT_VALIDATE_ERROR"),
  contractExeError("CONTRACT_EXE_ERROR"),
  bandwithError("BANDWITH_ERROR"),
  dupTransactionError("DUP_TRANSACTION_ERROR"),
  taposError("TAPOS_ERROR"),
  tooBigTransactionError("TOO_BIG_TRANSACTION_ERROR"),
  transactionExpirationError("TRANSACTION_EXPIRATION_ERROR"),
  serverBusy("SERVER_BUSY"),
  noConnection("NO_CONNECTION"),
  notEnoughEffectiveConnection("NOT_ENOUGH_EFFECTIVE_CONNECTION"),
  blockUnsolidified("BLOCK_UNSOLIDIFIED"),
  otherError("OTHER_ERROR");

  final String value;
  const TronHttpReturnCode(this.value);

  static TronHttpReturnCode fromJson(dynamic json) {
    final value = json is String ? json : json?.toString();
    return values.firstWhere(
      (e) => e.value == value,
      orElse:
          () =>
              throw BuError(
                DefaultErrorType.invalidArgument,
                "Invalid TronHttpReturnCode.",
              ),
    );
  }

  String toJson() => value;
}

enum TronHttpSmartContractABIEntryStateMutability {
  unknownMutabilityType("UnknownMutabilityType"),
  pure("Pure"),
  view("View"),
  nonpayable("Nonpayable"),
  payable("Payable");

  final String value;
  const TronHttpSmartContractABIEntryStateMutability(this.value);

  static TronHttpSmartContractABIEntryStateMutability fromJson(dynamic json) {
    final value = json is String ? json : json?.toString();
    return values.firstWhere(
      (e) => e.value == value,
      orElse:
          () =>
              throw BuError(
                DefaultErrorType.invalidArgument,
                "Invalid TronHttpSmartContractABIEntryStateMutability.",
              ),
    );
  }

  String toJson() => value;
}

/// Account, contract, or resource type.
enum TronHttpSmartContractABIEntryType {
  unknownEntryType("UnknownEntryType"),
  constructor("Constructor"),
  function("Function"),
  event("Event"),
  fallback("Fallback"),
  receive("Receive"),
  error("Error");

  final String value;
  const TronHttpSmartContractABIEntryType(this.value);

  static TronHttpSmartContractABIEntryType fromJson(dynamic json) {
    final value = json is String ? json : json?.toString();
    return values.firstWhere(
      (e) => e.value == value,
      orElse:
          () =>
              throw BuError(
                DefaultErrorType.invalidArgument,
                "Invalid TronHttpSmartContractABIEntryType.",
              ),
    );
  }

  String toJson() => value;
}

enum TronHttpTransactionApprovedListResultCode {
  success("SUCCESS"),
  signatureFormatError("SIGNATURE_FORMAT_ERROR"),
  computeAddressError("COMPUTE_ADDRESS_ERROR"),
  otherError("OTHER_ERROR");

  final String value;
  const TronHttpTransactionApprovedListResultCode(this.value);

  static TronHttpTransactionApprovedListResultCode fromJson(dynamic json) {
    final value = json is String ? json : json?.toString();
    return values.firstWhere(
      (e) => e.value == value,
      orElse:
          () =>
              throw BuError(
                DefaultErrorType.invalidArgument,
                "Invalid TronHttpTransactionApprovedListResultCode.",
              ),
    );
  }

  String toJson() => value;
}

/// Hex string, amount, or value field accepted by this endpoint.
sealed class TronHttpTransactionContractInt64StringCompatibleParameterValue {
  const TronHttpTransactionContractInt64StringCompatibleParameterValue();

  /// Parses `value` using the parent `parameter.type_url` (e.g.
  /// `type.googleapis.com/protocol.TransferContract`) as the discriminator.
  /// Falls back to structural matching when [typeUrl] is null or unknown.
  factory TronHttpTransactionContractInt64StringCompatibleParameterValue.fromJsonWithTypeUrl(
    dynamic json, [
    String? typeUrl,
  ]) {
    if (json is Map) {
      final map =
          json is Map<String, dynamic> ? json : Map<String, dynamic>.from(json);
      final typeName =
          typeUrl == null || typeUrl.isEmpty ? null : typeUrl.split('.').last;
      switch (typeName) {
        case 'AccountCreateContract':
          return TronHttpTransactionContractInt64StringCompatibleParameterValueAccountCreateContract(
            TronHttpAccountCreateContract.fromJson(map),
          );
        case 'AccountPermissionUpdateContract':
          return TronHttpTransactionContractInt64StringCompatibleParameterValueAccountPermissionUpdateContractInt64StringCompatible(
            TronHttpAccountPermissionUpdateContractInt64StringCompatible.fromJson(
              map,
            ),
          );
        case 'AccountUpdateContract':
          return TronHttpTransactionContractInt64StringCompatibleParameterValueAccountUpdateContract(
            TronHttpAccountUpdateContract.fromJson(map),
          );
        case 'AssetIssueContract':
          return TronHttpTransactionContractInt64StringCompatibleParameterValueAssetIssueContractInt64StringCompatible(
            TronHttpAssetIssueContractInt64StringCompatible.fromJson(map),
          );
        case 'CancelAllUnfreezeV2Contract':
          return TronHttpTransactionContractInt64StringCompatibleParameterValueCancelAllUnfreezeV2Contract(
            TronHttpCancelAllUnfreezeV2Contract.fromJson(map),
          );
        case 'ClearABIContract':
          return TronHttpTransactionContractInt64StringCompatibleParameterValueClearABIContract(
            TronHttpClearABIContract.fromJson(map),
          );
        case 'CreateSmartContract':
          return TronHttpTransactionContractInt64StringCompatibleParameterValueCreateSmartContractInt64StringCompatible(
            TronHttpCreateSmartContractInt64StringCompatible.fromJson(map),
          );
        case 'DelegateResourceContract':
          return TronHttpTransactionContractInt64StringCompatibleParameterValueDelegateResourceContractInt64StringCompatible(
            TronHttpDelegateResourceContractInt64StringCompatible.fromJson(map),
          );
        case 'ExchangeCreateContract':
          return TronHttpTransactionContractInt64StringCompatibleParameterValueExchangeCreateContractInt64StringCompatible(
            TronHttpExchangeCreateContractInt64StringCompatible.fromJson(map),
          );
        case 'ExchangeInjectContract':
          return TronHttpTransactionContractInt64StringCompatibleParameterValueExchangeInjectContractInt64StringCompatible(
            TronHttpExchangeInjectContractInt64StringCompatible.fromJson(map),
          );
        case 'ExchangeTransactionContract':
          return TronHttpTransactionContractInt64StringCompatibleParameterValueExchangeTransactionContractInt64StringCompatible(
            TronHttpExchangeTransactionContractInt64StringCompatible.fromJson(
              map,
            ),
          );
        case 'ExchangeWithdrawContract':
          return TronHttpTransactionContractInt64StringCompatibleParameterValueExchangeWithdrawContractInt64StringCompatible(
            TronHttpExchangeWithdrawContractInt64StringCompatible.fromJson(map),
          );
        case 'FreezeBalanceContract':
          return TronHttpTransactionContractInt64StringCompatibleParameterValueFreezeBalanceContractInt64StringCompatible(
            TronHttpFreezeBalanceContractInt64StringCompatible.fromJson(map),
          );
        case 'FreezeBalanceV2Contract':
          return TronHttpTransactionContractInt64StringCompatibleParameterValueFreezeBalanceV2ContractInt64StringCompatible(
            TronHttpFreezeBalanceV2ContractInt64StringCompatible.fromJson(map),
          );
        case 'MarketCancelOrderContract':
          return TronHttpTransactionContractInt64StringCompatibleParameterValueMarketCancelOrderContract(
            TronHttpMarketCancelOrderContract.fromJson(map),
          );
        case 'MarketSellAssetContract':
          return TronHttpTransactionContractInt64StringCompatibleParameterValueMarketSellAssetContractInt64StringCompatible(
            TronHttpMarketSellAssetContractInt64StringCompatible.fromJson(map),
          );
        case 'ParticipateAssetIssueContract':
          return TronHttpTransactionContractInt64StringCompatibleParameterValueParticipateAssetIssueContractInt64StringCompatible(
            TronHttpParticipateAssetIssueContractInt64StringCompatible.fromJson(
              map,
            ),
          );
        case 'ProposalApproveContract':
          return TronHttpTransactionContractInt64StringCompatibleParameterValueProposalApproveContractInt64StringCompatible(
            TronHttpProposalApproveContractInt64StringCompatible.fromJson(map),
          );
        case 'ProposalCreateContract':
          return TronHttpTransactionContractInt64StringCompatibleParameterValueProposalCreateContractInt64StringCompatible(
            TronHttpProposalCreateContractInt64StringCompatible.fromJson(map),
          );
        case 'ProposalDeleteContract':
          return TronHttpTransactionContractInt64StringCompatibleParameterValueProposalDeleteContractInt64StringCompatible(
            TronHttpProposalDeleteContractInt64StringCompatible.fromJson(map),
          );
        case 'SetAccountIdContract':
          return TronHttpTransactionContractInt64StringCompatibleParameterValueSetAccountIdContract(
            TronHttpSetAccountIdContract.fromJson(map),
          );
        case 'ShieldedTransferContract':
          return TronHttpTransactionContractInt64StringCompatibleParameterValueShieldedTransferContractInt64StringCompatible(
            TronHttpShieldedTransferContractInt64StringCompatible.fromJson(map),
          );
        case 'TransferAssetContract':
          return TronHttpTransactionContractInt64StringCompatibleParameterValueTransferAssetContractInt64StringCompatible(
            TronHttpTransferAssetContractInt64StringCompatible.fromJson(map),
          );
        case 'TransferContract':
          return TronHttpTransactionContractInt64StringCompatibleParameterValueTransferContractInt64StringCompatible(
            TronHttpTransferContractInt64StringCompatible.fromJson(map),
          );
        case 'TriggerSmartContract':
          return TronHttpTransactionContractInt64StringCompatibleParameterValueTriggerSmartContractInt64StringCompatible(
            TronHttpTriggerSmartContractInt64StringCompatible.fromJson(map),
          );
        case 'UnDelegateResourceContract':
          return TronHttpTransactionContractInt64StringCompatibleParameterValueUnDelegateResourceContractInt64StringCompatible(
            TronHttpUnDelegateResourceContractInt64StringCompatible.fromJson(
              map,
            ),
          );
        case 'UnfreezeAssetContract':
          return TronHttpTransactionContractInt64StringCompatibleParameterValueUnfreezeAssetContract(
            TronHttpUnfreezeAssetContract.fromJson(map),
          );
        case 'UnfreezeBalanceContract':
          return TronHttpTransactionContractInt64StringCompatibleParameterValueUnfreezeBalanceContract(
            TronHttpUnfreezeBalanceContract.fromJson(map),
          );
        case 'UnfreezeBalanceV2Contract':
          return TronHttpTransactionContractInt64StringCompatibleParameterValueUnfreezeBalanceV2ContractInt64StringCompatible(
            TronHttpUnfreezeBalanceV2ContractInt64StringCompatible.fromJson(
              map,
            ),
          );
        case 'UpdateAssetContract':
          return TronHttpTransactionContractInt64StringCompatibleParameterValueUpdateAssetContractInt64StringCompatible(
            TronHttpUpdateAssetContractInt64StringCompatible.fromJson(map),
          );
        case 'UpdateBrokerageContract':
          return TronHttpTransactionContractInt64StringCompatibleParameterValueUpdateBrokerageContract(
            TronHttpUpdateBrokerageContract.fromJson(map),
          );
        case 'UpdateEnergyLimitContract':
          return TronHttpTransactionContractInt64StringCompatibleParameterValueUpdateEnergyLimitContractInt64StringCompatible(
            TronHttpUpdateEnergyLimitContractInt64StringCompatible.fromJson(
              map,
            ),
          );
        case 'UpdateSettingContract':
          return TronHttpTransactionContractInt64StringCompatibleParameterValueUpdateSettingContractInt64StringCompatible(
            TronHttpUpdateSettingContractInt64StringCompatible.fromJson(map),
          );
        case 'VoteWitnessContract':
          return TronHttpTransactionContractInt64StringCompatibleParameterValueVoteWitnessContractInt64StringCompatible(
            TronHttpVoteWitnessContractInt64StringCompatible.fromJson(map),
          );
        case 'WithdrawBalanceContract':
          return TronHttpTransactionContractInt64StringCompatibleParameterValueWithdrawBalanceContract(
            TronHttpWithdrawBalanceContract.fromJson(map),
          );
        case 'WithdrawExpireUnfreezeContract':
          return TronHttpTransactionContractInt64StringCompatibleParameterValueWithdrawExpireUnfreezeContract(
            TronHttpWithdrawExpireUnfreezeContract.fromJson(map),
          );
        case 'WitnessCreateContract':
          return TronHttpTransactionContractInt64StringCompatibleParameterValueWitnessCreateContract(
            TronHttpWitnessCreateContract.fromJson(map),
          );
        case 'WitnessUpdateContract':
          return TronHttpTransactionContractInt64StringCompatibleParameterValueWitnessUpdateContract(
            TronHttpWitnessUpdateContract.fromJson(map),
          );
        default:
          return TronHttpTransactionContractInt64StringCompatibleParameterValue.fromJson(
            map,
          );
      }
    }
    return TronHttpTransactionContractInt64StringCompatibleParameterValue.fromJson(
      json,
    );
  }

  factory TronHttpTransactionContractInt64StringCompatibleParameterValue.fromJson(
    dynamic json,
  ) {
    if (json is Map) {
      final map =
          json is Map<String, dynamic> ? json : Map<String, dynamic>.from(json);
      if (map.hasValue('frozen_duration')) {
        return TronHttpTransactionContractInt64StringCompatibleParameterValueFreezeBalanceContractInt64StringCompatible(
          TronHttpFreezeBalanceContractInt64StringCompatible.fromJson(map),
        );
      }
      if (map.hasValue('actives') ||
          map.hasValue('owner') ||
          map.hasValue('witness')) {
        return TronHttpTransactionContractInt64StringCompatibleParameterValueAccountPermissionUpdateContractInt64StringCompatible(
          TronHttpAccountPermissionUpdateContractInt64StringCompatible.fromJson(
            map,
          ),
        );
      }
      if (map.hasValue('account_name')) {
        return TronHttpTransactionContractInt64StringCompatibleParameterValueAccountUpdateContract(
          TronHttpAccountUpdateContract.fromJson(map),
        );
      }
      if (map.hasValue('abbr') ||
          map.hasValue('end_time') ||
          map.hasValue('free_asset_net_limit') ||
          map.hasValue('frozen_supply') ||
          map.hasValue('id') ||
          map.hasValue('name') ||
          map.hasValue('num') ||
          map.hasValue('order') ||
          map.hasValue('precision') ||
          map.hasValue('public_free_asset_net_limit') ||
          map.hasValue('public_free_asset_net_usage') ||
          map.hasValue('public_latest_free_net_time') ||
          map.hasValue('start_time') ||
          map.hasValue('total_supply') ||
          map.hasValue('trx_num') ||
          map.hasValue('vote_score')) {
        return TronHttpTransactionContractInt64StringCompatibleParameterValueAssetIssueContractInt64StringCompatible(
          TronHttpAssetIssueContractInt64StringCompatible.fromJson(map),
        );
      }
      if (map.hasValue('new_contract')) {
        return TronHttpTransactionContractInt64StringCompatibleParameterValueCreateSmartContractInt64StringCompatible(
          TronHttpCreateSmartContractInt64StringCompatible.fromJson(map),
        );
      }
      if (map.hasValue('lock') || map.hasValue('lock_period')) {
        return TronHttpTransactionContractInt64StringCompatibleParameterValueDelegateResourceContractInt64StringCompatible(
          TronHttpDelegateResourceContractInt64StringCompatible.fromJson(map),
        );
      }
      if (map.hasValue('first_token_balance') ||
          map.hasValue('first_token_id') ||
          map.hasValue('second_token_balance') ||
          map.hasValue('second_token_id')) {
        return TronHttpTransactionContractInt64StringCompatibleParameterValueExchangeCreateContractInt64StringCompatible(
          TronHttpExchangeCreateContractInt64StringCompatible.fromJson(map),
        );
      }
      if (map.hasValue('expected')) {
        return TronHttpTransactionContractInt64StringCompatibleParameterValueExchangeTransactionContractInt64StringCompatible(
          TronHttpExchangeTransactionContractInt64StringCompatible.fromJson(
            map,
          ),
        );
      }
      if (map.hasValue('account_address') || map.hasValue('type')) {
        return TronHttpTransactionContractInt64StringCompatibleParameterValueAccountCreateContract(
          TronHttpAccountCreateContract.fromJson(map),
        );
      }
      if (map.hasValue('order_id')) {
        return TronHttpTransactionContractInt64StringCompatibleParameterValueMarketCancelOrderContract(
          TronHttpMarketCancelOrderContract.fromJson(map),
        );
      }
      if (map.hasValue('buy_token_id') ||
          map.hasValue('buy_token_quantity') ||
          map.hasValue('sell_token_id') ||
          map.hasValue('sell_token_quantity')) {
        return TronHttpTransactionContractInt64StringCompatibleParameterValueMarketSellAssetContractInt64StringCompatible(
          TronHttpMarketSellAssetContractInt64StringCompatible.fromJson(map),
        );
      }
      if (map.hasValue('is_add_approval')) {
        return TronHttpTransactionContractInt64StringCompatibleParameterValueProposalApproveContractInt64StringCompatible(
          TronHttpProposalApproveContractInt64StringCompatible.fromJson(map),
        );
      }
      if (map.hasValue('parameters')) {
        return TronHttpTransactionContractInt64StringCompatibleParameterValueProposalCreateContractInt64StringCompatible(
          TronHttpProposalCreateContractInt64StringCompatible.fromJson(map),
        );
      }
      if (map.hasValue('account_id')) {
        return TronHttpTransactionContractInt64StringCompatibleParameterValueSetAccountIdContract(
          TronHttpSetAccountIdContract.fromJson(map),
        );
      }
      if (map.hasValue('binding_signature') ||
          map.hasValue('from_amount') ||
          map.hasValue('receive_description') ||
          map.hasValue('spend_description') ||
          map.hasValue('to_amount') ||
          map.hasValue('transparent_from_address') ||
          map.hasValue('transparent_to_address')) {
        return TronHttpTransactionContractInt64StringCompatibleParameterValueShieldedTransferContractInt64StringCompatible(
          TronHttpShieldedTransferContractInt64StringCompatible.fromJson(map),
        );
      }
      if (map.hasValue('update_url')) {
        return TronHttpTransactionContractInt64StringCompatibleParameterValueWitnessUpdateContract(
          TronHttpWitnessUpdateContract.fromJson(map),
        );
      }
      if (map.hasValue('unfreeze_balance')) {
        return TronHttpTransactionContractInt64StringCompatibleParameterValueUnfreezeBalanceV2ContractInt64StringCompatible(
          TronHttpUnfreezeBalanceV2ContractInt64StringCompatible.fromJson(map),
        );
      }
      if (map.hasValue('new_limit') || map.hasValue('new_public_limit')) {
        return TronHttpTransactionContractInt64StringCompatibleParameterValueUpdateAssetContractInt64StringCompatible(
          TronHttpUpdateAssetContractInt64StringCompatible.fromJson(map),
        );
      }
      if (map.hasValue('brokerage')) {
        return TronHttpTransactionContractInt64StringCompatibleParameterValueUpdateBrokerageContract(
          TronHttpUpdateBrokerageContract.fromJson(map),
        );
      }
      if (map.hasValue('origin_energy_limit')) {
        return TronHttpTransactionContractInt64StringCompatibleParameterValueUpdateEnergyLimitContractInt64StringCompatible(
          TronHttpUpdateEnergyLimitContractInt64StringCompatible.fromJson(map),
        );
      }
      if (map.hasValue('consume_user_resource_percent')) {
        return TronHttpTransactionContractInt64StringCompatibleParameterValueUpdateSettingContractInt64StringCompatible(
          TronHttpUpdateSettingContractInt64StringCompatible.fromJson(map),
        );
      }
      if (map.hasValue('support') || map.hasValue('votes')) {
        return TronHttpTransactionContractInt64StringCompatibleParameterValueVoteWitnessContractInt64StringCompatible(
          TronHttpVoteWitnessContractInt64StringCompatible.fromJson(map),
        );
      }
      if (map.hasValue('call_value') || map.hasValue('data')) {
        return TronHttpTransactionContractInt64StringCompatibleParameterValueTriggerSmartContractInt64StringCompatible(
          TronHttpTriggerSmartContractInt64StringCompatible.fromJson(map),
        );
      }
      if (map.hasValue('exchange_id') &&
          map.hasValue('owner_address') &&
          map.hasValue('quant') &&
          map.hasValue('token_id')) {
        return TronHttpTransactionContractInt64StringCompatibleParameterValueExchangeInjectContractInt64StringCompatible(
          TronHttpExchangeInjectContractInt64StringCompatible.fromJson(map),
        );
      }
      if (map.hasValue('exchange_id') &&
          map.hasValue('owner_address') &&
          map.hasValue('quant') &&
          map.hasValue('token_id')) {
        return TronHttpTransactionContractInt64StringCompatibleParameterValueExchangeWithdrawContractInt64StringCompatible(
          TronHttpExchangeWithdrawContractInt64StringCompatible.fromJson(map),
        );
      }
      if (map.hasValue('amount') &&
          map.hasValue('asset_name') &&
          map.hasValue('owner_address') &&
          map.hasValue('to_address')) {
        return TronHttpTransactionContractInt64StringCompatibleParameterValueParticipateAssetIssueContractInt64StringCompatible(
          TronHttpParticipateAssetIssueContractInt64StringCompatible.fromJson(
            map,
          ),
        );
      }
      if (map.hasValue('amount') &&
          map.hasValue('asset_name') &&
          map.hasValue('owner_address') &&
          map.hasValue('to_address')) {
        return TronHttpTransactionContractInt64StringCompatibleParameterValueTransferAssetContractInt64StringCompatible(
          TronHttpTransferAssetContractInt64StringCompatible.fromJson(map),
        );
      }
      if (map.hasValue('balance') &&
          map.hasValue('owner_address') &&
          map.hasValue('receiver_address') &&
          map.hasValue('resource')) {
        return TronHttpTransactionContractInt64StringCompatibleParameterValueUnDelegateResourceContractInt64StringCompatible(
          TronHttpUnDelegateResourceContractInt64StringCompatible.fromJson(map),
        );
      }
      if (map.hasValue('frozen_balance') &&
          map.hasValue('owner_address') &&
          map.hasValue('resource')) {
        return TronHttpTransactionContractInt64StringCompatibleParameterValueFreezeBalanceV2ContractInt64StringCompatible(
          TronHttpFreezeBalanceV2ContractInt64StringCompatible.fromJson(map),
        );
      }
      if (map.hasValue('amount') &&
          map.hasValue('owner_address') &&
          map.hasValue('to_address')) {
        return TronHttpTransactionContractInt64StringCompatibleParameterValueTransferContractInt64StringCompatible(
          TronHttpTransferContractInt64StringCompatible.fromJson(map),
        );
      }
      if (map.hasValue('owner_address') &&
          map.hasValue('receiver_address') &&
          map.hasValue('resource')) {
        return TronHttpTransactionContractInt64StringCompatibleParameterValueUnfreezeBalanceContract(
          TronHttpUnfreezeBalanceContract.fromJson(map),
        );
      }
      if (map.hasValue('contract_address') && map.hasValue('owner_address')) {
        return TronHttpTransactionContractInt64StringCompatibleParameterValueClearABIContract(
          TronHttpClearABIContract.fromJson(map),
        );
      }
      if (map.hasValue('owner_address') && map.hasValue('proposal_id')) {
        return TronHttpTransactionContractInt64StringCompatibleParameterValueProposalDeleteContractInt64StringCompatible(
          TronHttpProposalDeleteContractInt64StringCompatible.fromJson(map),
        );
      }
      if (map.hasValue('owner_address') && map.hasValue('url')) {
        return TronHttpTransactionContractInt64StringCompatibleParameterValueWitnessCreateContract(
          TronHttpWitnessCreateContract.fromJson(map),
        );
      }
      if (map.hasValue('owner_address')) {
        return TronHttpTransactionContractInt64StringCompatibleParameterValueCancelAllUnfreezeV2Contract(
          TronHttpCancelAllUnfreezeV2Contract.fromJson(map),
        );
      }
      if (map.hasValue('owner_address')) {
        return TronHttpTransactionContractInt64StringCompatibleParameterValueUnfreezeAssetContract(
          TronHttpUnfreezeAssetContract.fromJson(map),
        );
      }
      if (map.hasValue('owner_address')) {
        return TronHttpTransactionContractInt64StringCompatibleParameterValueWithdrawBalanceContract(
          TronHttpWithdrawBalanceContract.fromJson(map),
        );
      }
      if (map.hasValue('owner_address')) {
        return TronHttpTransactionContractInt64StringCompatibleParameterValueWithdrawExpireUnfreezeContract(
          TronHttpWithdrawExpireUnfreezeContract.fromJson(map),
        );
      }
      try {
        return TronHttpTransactionContractInt64StringCompatibleParameterValueExchangeInjectContractInt64StringCompatible(
          TronHttpExchangeInjectContractInt64StringCompatible.fromJson(map),
        );
      } catch (_) {}
      try {
        return TronHttpTransactionContractInt64StringCompatibleParameterValueExchangeWithdrawContractInt64StringCompatible(
          TronHttpExchangeWithdrawContractInt64StringCompatible.fromJson(map),
        );
      } catch (_) {}
      try {
        return TronHttpTransactionContractInt64StringCompatibleParameterValueParticipateAssetIssueContractInt64StringCompatible(
          TronHttpParticipateAssetIssueContractInt64StringCompatible.fromJson(
            map,
          ),
        );
      } catch (_) {}
      try {
        return TronHttpTransactionContractInt64StringCompatibleParameterValueTransferAssetContractInt64StringCompatible(
          TronHttpTransferAssetContractInt64StringCompatible.fromJson(map),
        );
      } catch (_) {}
      try {
        return TronHttpTransactionContractInt64StringCompatibleParameterValueUnDelegateResourceContractInt64StringCompatible(
          TronHttpUnDelegateResourceContractInt64StringCompatible.fromJson(map),
        );
      } catch (_) {}
      try {
        return TronHttpTransactionContractInt64StringCompatibleParameterValueFreezeBalanceV2ContractInt64StringCompatible(
          TronHttpFreezeBalanceV2ContractInt64StringCompatible.fromJson(map),
        );
      } catch (_) {}
      try {
        return TronHttpTransactionContractInt64StringCompatibleParameterValueTransferContractInt64StringCompatible(
          TronHttpTransferContractInt64StringCompatible.fromJson(map),
        );
      } catch (_) {}
      try {
        return TronHttpTransactionContractInt64StringCompatibleParameterValueUnfreezeBalanceContract(
          TronHttpUnfreezeBalanceContract.fromJson(map),
        );
      } catch (_) {}
      try {
        return TronHttpTransactionContractInt64StringCompatibleParameterValueClearABIContract(
          TronHttpClearABIContract.fromJson(map),
        );
      } catch (_) {}
      try {
        return TronHttpTransactionContractInt64StringCompatibleParameterValueProposalDeleteContractInt64StringCompatible(
          TronHttpProposalDeleteContractInt64StringCompatible.fromJson(map),
        );
      } catch (_) {}
      try {
        return TronHttpTransactionContractInt64StringCompatibleParameterValueWitnessCreateContract(
          TronHttpWitnessCreateContract.fromJson(map),
        );
      } catch (_) {}
      try {
        return TronHttpTransactionContractInt64StringCompatibleParameterValueCancelAllUnfreezeV2Contract(
          TronHttpCancelAllUnfreezeV2Contract.fromJson(map),
        );
      } catch (_) {}
      try {
        return TronHttpTransactionContractInt64StringCompatibleParameterValueUnfreezeAssetContract(
          TronHttpUnfreezeAssetContract.fromJson(map),
        );
      } catch (_) {}
      try {
        return TronHttpTransactionContractInt64StringCompatibleParameterValueWithdrawBalanceContract(
          TronHttpWithdrawBalanceContract.fromJson(map),
        );
      } catch (_) {}
      try {
        return TronHttpTransactionContractInt64StringCompatibleParameterValueWithdrawExpireUnfreezeContract(
          TronHttpWithdrawExpireUnfreezeContract.fromJson(map),
        );
      } catch (_) {}
    }
    throw CoreErrors.invalidOperationArguments(
      'TronHttpTransactionContractInt64StringCompatibleParameterValue',
      reason:
          'Cannot parse TronHttpTransactionContractInt64StringCompatibleParameterValue from $json',
    );
  }

  dynamic toJson();
}

class TronHttpTransactionContractInt64StringCompatibleParameterValueAccountCreateContract
    extends TronHttpTransactionContractInt64StringCompatibleParameterValue {
  final TronHttpAccountCreateContract value;
  const TronHttpTransactionContractInt64StringCompatibleParameterValueAccountCreateContract(
    this.value,
  );

  @override
  dynamic toJson() => value.toJson();
}

class TronHttpTransactionContractInt64StringCompatibleParameterValueAccountPermissionUpdateContractInt64StringCompatible
    extends TronHttpTransactionContractInt64StringCompatibleParameterValue {
  final TronHttpAccountPermissionUpdateContractInt64StringCompatible value;
  const TronHttpTransactionContractInt64StringCompatibleParameterValueAccountPermissionUpdateContractInt64StringCompatible(
    this.value,
  );

  @override
  dynamic toJson() => value.toJson();
}

class TronHttpTransactionContractInt64StringCompatibleParameterValueAccountUpdateContract
    extends TronHttpTransactionContractInt64StringCompatibleParameterValue {
  final TronHttpAccountUpdateContract value;
  const TronHttpTransactionContractInt64StringCompatibleParameterValueAccountUpdateContract(
    this.value,
  );

  @override
  dynamic toJson() => value.toJson();
}

class TronHttpTransactionContractInt64StringCompatibleParameterValueAssetIssueContractInt64StringCompatible
    extends TronHttpTransactionContractInt64StringCompatibleParameterValue {
  final TronHttpAssetIssueContractInt64StringCompatible value;
  const TronHttpTransactionContractInt64StringCompatibleParameterValueAssetIssueContractInt64StringCompatible(
    this.value,
  );

  @override
  dynamic toJson() => value.toJson();
}

class TronHttpTransactionContractInt64StringCompatibleParameterValueCancelAllUnfreezeV2Contract
    extends TronHttpTransactionContractInt64StringCompatibleParameterValue {
  final TronHttpCancelAllUnfreezeV2Contract value;
  const TronHttpTransactionContractInt64StringCompatibleParameterValueCancelAllUnfreezeV2Contract(
    this.value,
  );

  @override
  dynamic toJson() => value.toJson();
}

class TronHttpTransactionContractInt64StringCompatibleParameterValueClearABIContract
    extends TronHttpTransactionContractInt64StringCompatibleParameterValue {
  final TronHttpClearABIContract value;
  const TronHttpTransactionContractInt64StringCompatibleParameterValueClearABIContract(
    this.value,
  );

  @override
  dynamic toJson() => value.toJson();
}

class TronHttpTransactionContractInt64StringCompatibleParameterValueCreateSmartContractInt64StringCompatible
    extends TronHttpTransactionContractInt64StringCompatibleParameterValue {
  final TronHttpCreateSmartContractInt64StringCompatible value;
  const TronHttpTransactionContractInt64StringCompatibleParameterValueCreateSmartContractInt64StringCompatible(
    this.value,
  );

  @override
  dynamic toJson() => value.toJson();
}

class TronHttpTransactionContractInt64StringCompatibleParameterValueDelegateResourceContractInt64StringCompatible
    extends TronHttpTransactionContractInt64StringCompatibleParameterValue {
  final TronHttpDelegateResourceContractInt64StringCompatible value;
  const TronHttpTransactionContractInt64StringCompatibleParameterValueDelegateResourceContractInt64StringCompatible(
    this.value,
  );

  @override
  dynamic toJson() => value.toJson();
}

class TronHttpTransactionContractInt64StringCompatibleParameterValueExchangeCreateContractInt64StringCompatible
    extends TronHttpTransactionContractInt64StringCompatibleParameterValue {
  final TronHttpExchangeCreateContractInt64StringCompatible value;
  const TronHttpTransactionContractInt64StringCompatibleParameterValueExchangeCreateContractInt64StringCompatible(
    this.value,
  );

  @override
  dynamic toJson() => value.toJson();
}

class TronHttpTransactionContractInt64StringCompatibleParameterValueExchangeInjectContractInt64StringCompatible
    extends TronHttpTransactionContractInt64StringCompatibleParameterValue {
  final TronHttpExchangeInjectContractInt64StringCompatible value;
  const TronHttpTransactionContractInt64StringCompatibleParameterValueExchangeInjectContractInt64StringCompatible(
    this.value,
  );

  @override
  dynamic toJson() => value.toJson();
}

class TronHttpTransactionContractInt64StringCompatibleParameterValueExchangeTransactionContractInt64StringCompatible
    extends TronHttpTransactionContractInt64StringCompatibleParameterValue {
  final TronHttpExchangeTransactionContractInt64StringCompatible value;
  const TronHttpTransactionContractInt64StringCompatibleParameterValueExchangeTransactionContractInt64StringCompatible(
    this.value,
  );

  @override
  dynamic toJson() => value.toJson();
}

class TronHttpTransactionContractInt64StringCompatibleParameterValueExchangeWithdrawContractInt64StringCompatible
    extends TronHttpTransactionContractInt64StringCompatibleParameterValue {
  final TronHttpExchangeWithdrawContractInt64StringCompatible value;
  const TronHttpTransactionContractInt64StringCompatibleParameterValueExchangeWithdrawContractInt64StringCompatible(
    this.value,
  );

  @override
  dynamic toJson() => value.toJson();
}

class TronHttpTransactionContractInt64StringCompatibleParameterValueFreezeBalanceContractInt64StringCompatible
    extends TronHttpTransactionContractInt64StringCompatibleParameterValue {
  final TronHttpFreezeBalanceContractInt64StringCompatible value;
  const TronHttpTransactionContractInt64StringCompatibleParameterValueFreezeBalanceContractInt64StringCompatible(
    this.value,
  );

  @override
  dynamic toJson() => value.toJson();
}

class TronHttpTransactionContractInt64StringCompatibleParameterValueFreezeBalanceV2ContractInt64StringCompatible
    extends TronHttpTransactionContractInt64StringCompatibleParameterValue {
  final TronHttpFreezeBalanceV2ContractInt64StringCompatible value;
  const TronHttpTransactionContractInt64StringCompatibleParameterValueFreezeBalanceV2ContractInt64StringCompatible(
    this.value,
  );

  @override
  dynamic toJson() => value.toJson();
}

class TronHttpTransactionContractInt64StringCompatibleParameterValueMarketCancelOrderContract
    extends TronHttpTransactionContractInt64StringCompatibleParameterValue {
  final TronHttpMarketCancelOrderContract value;
  const TronHttpTransactionContractInt64StringCompatibleParameterValueMarketCancelOrderContract(
    this.value,
  );

  @override
  dynamic toJson() => value.toJson();
}

class TronHttpTransactionContractInt64StringCompatibleParameterValueMarketSellAssetContractInt64StringCompatible
    extends TronHttpTransactionContractInt64StringCompatibleParameterValue {
  final TronHttpMarketSellAssetContractInt64StringCompatible value;
  const TronHttpTransactionContractInt64StringCompatibleParameterValueMarketSellAssetContractInt64StringCompatible(
    this.value,
  );

  @override
  dynamic toJson() => value.toJson();
}

class TronHttpTransactionContractInt64StringCompatibleParameterValueParticipateAssetIssueContractInt64StringCompatible
    extends TronHttpTransactionContractInt64StringCompatibleParameterValue {
  final TronHttpParticipateAssetIssueContractInt64StringCompatible value;
  const TronHttpTransactionContractInt64StringCompatibleParameterValueParticipateAssetIssueContractInt64StringCompatible(
    this.value,
  );

  @override
  dynamic toJson() => value.toJson();
}

class TronHttpTransactionContractInt64StringCompatibleParameterValueProposalApproveContractInt64StringCompatible
    extends TronHttpTransactionContractInt64StringCompatibleParameterValue {
  final TronHttpProposalApproveContractInt64StringCompatible value;
  const TronHttpTransactionContractInt64StringCompatibleParameterValueProposalApproveContractInt64StringCompatible(
    this.value,
  );

  @override
  dynamic toJson() => value.toJson();
}

class TronHttpTransactionContractInt64StringCompatibleParameterValueProposalCreateContractInt64StringCompatible
    extends TronHttpTransactionContractInt64StringCompatibleParameterValue {
  final TronHttpProposalCreateContractInt64StringCompatible value;
  const TronHttpTransactionContractInt64StringCompatibleParameterValueProposalCreateContractInt64StringCompatible(
    this.value,
  );

  @override
  dynamic toJson() => value.toJson();
}

class TronHttpTransactionContractInt64StringCompatibleParameterValueProposalDeleteContractInt64StringCompatible
    extends TronHttpTransactionContractInt64StringCompatibleParameterValue {
  final TronHttpProposalDeleteContractInt64StringCompatible value;
  const TronHttpTransactionContractInt64StringCompatibleParameterValueProposalDeleteContractInt64StringCompatible(
    this.value,
  );

  @override
  dynamic toJson() => value.toJson();
}

class TronHttpTransactionContractInt64StringCompatibleParameterValueSetAccountIdContract
    extends TronHttpTransactionContractInt64StringCompatibleParameterValue {
  final TronHttpSetAccountIdContract value;
  const TronHttpTransactionContractInt64StringCompatibleParameterValueSetAccountIdContract(
    this.value,
  );

  @override
  dynamic toJson() => value.toJson();
}

class TronHttpTransactionContractInt64StringCompatibleParameterValueShieldedTransferContractInt64StringCompatible
    extends TronHttpTransactionContractInt64StringCompatibleParameterValue {
  final TronHttpShieldedTransferContractInt64StringCompatible value;
  const TronHttpTransactionContractInt64StringCompatibleParameterValueShieldedTransferContractInt64StringCompatible(
    this.value,
  );

  @override
  dynamic toJson() => value.toJson();
}

class TronHttpTransactionContractInt64StringCompatibleParameterValueTransferAssetContractInt64StringCompatible
    extends TronHttpTransactionContractInt64StringCompatibleParameterValue {
  final TronHttpTransferAssetContractInt64StringCompatible value;
  const TronHttpTransactionContractInt64StringCompatibleParameterValueTransferAssetContractInt64StringCompatible(
    this.value,
  );

  @override
  dynamic toJson() => value.toJson();
}

class TronHttpTransactionContractInt64StringCompatibleParameterValueTransferContractInt64StringCompatible
    extends TronHttpTransactionContractInt64StringCompatibleParameterValue {
  final TronHttpTransferContractInt64StringCompatible value;
  const TronHttpTransactionContractInt64StringCompatibleParameterValueTransferContractInt64StringCompatible(
    this.value,
  );

  @override
  dynamic toJson() => value.toJson();
}

class TronHttpTransactionContractInt64StringCompatibleParameterValueTriggerSmartContractInt64StringCompatible
    extends TronHttpTransactionContractInt64StringCompatibleParameterValue {
  final TronHttpTriggerSmartContractInt64StringCompatible value;
  const TronHttpTransactionContractInt64StringCompatibleParameterValueTriggerSmartContractInt64StringCompatible(
    this.value,
  );

  @override
  dynamic toJson() => value.toJson();
}

class TronHttpTransactionContractInt64StringCompatibleParameterValueUnDelegateResourceContractInt64StringCompatible
    extends TronHttpTransactionContractInt64StringCompatibleParameterValue {
  final TronHttpUnDelegateResourceContractInt64StringCompatible value;
  const TronHttpTransactionContractInt64StringCompatibleParameterValueUnDelegateResourceContractInt64StringCompatible(
    this.value,
  );

  @override
  dynamic toJson() => value.toJson();
}

class TronHttpTransactionContractInt64StringCompatibleParameterValueUnfreezeAssetContract
    extends TronHttpTransactionContractInt64StringCompatibleParameterValue {
  final TronHttpUnfreezeAssetContract value;
  const TronHttpTransactionContractInt64StringCompatibleParameterValueUnfreezeAssetContract(
    this.value,
  );

  @override
  dynamic toJson() => value.toJson();
}

class TronHttpTransactionContractInt64StringCompatibleParameterValueUnfreezeBalanceContract
    extends TronHttpTransactionContractInt64StringCompatibleParameterValue {
  final TronHttpUnfreezeBalanceContract value;
  const TronHttpTransactionContractInt64StringCompatibleParameterValueUnfreezeBalanceContract(
    this.value,
  );

  @override
  dynamic toJson() => value.toJson();
}

class TronHttpTransactionContractInt64StringCompatibleParameterValueUnfreezeBalanceV2ContractInt64StringCompatible
    extends TronHttpTransactionContractInt64StringCompatibleParameterValue {
  final TronHttpUnfreezeBalanceV2ContractInt64StringCompatible value;
  const TronHttpTransactionContractInt64StringCompatibleParameterValueUnfreezeBalanceV2ContractInt64StringCompatible(
    this.value,
  );

  @override
  dynamic toJson() => value.toJson();
}

class TronHttpTransactionContractInt64StringCompatibleParameterValueUpdateAssetContractInt64StringCompatible
    extends TronHttpTransactionContractInt64StringCompatibleParameterValue {
  final TronHttpUpdateAssetContractInt64StringCompatible value;
  const TronHttpTransactionContractInt64StringCompatibleParameterValueUpdateAssetContractInt64StringCompatible(
    this.value,
  );

  @override
  dynamic toJson() => value.toJson();
}

class TronHttpTransactionContractInt64StringCompatibleParameterValueUpdateBrokerageContract
    extends TronHttpTransactionContractInt64StringCompatibleParameterValue {
  final TronHttpUpdateBrokerageContract value;
  const TronHttpTransactionContractInt64StringCompatibleParameterValueUpdateBrokerageContract(
    this.value,
  );

  @override
  dynamic toJson() => value.toJson();
}

class TronHttpTransactionContractInt64StringCompatibleParameterValueUpdateEnergyLimitContractInt64StringCompatible
    extends TronHttpTransactionContractInt64StringCompatibleParameterValue {
  final TronHttpUpdateEnergyLimitContractInt64StringCompatible value;
  const TronHttpTransactionContractInt64StringCompatibleParameterValueUpdateEnergyLimitContractInt64StringCompatible(
    this.value,
  );

  @override
  dynamic toJson() => value.toJson();
}

class TronHttpTransactionContractInt64StringCompatibleParameterValueUpdateSettingContractInt64StringCompatible
    extends TronHttpTransactionContractInt64StringCompatibleParameterValue {
  final TronHttpUpdateSettingContractInt64StringCompatible value;
  const TronHttpTransactionContractInt64StringCompatibleParameterValueUpdateSettingContractInt64StringCompatible(
    this.value,
  );

  @override
  dynamic toJson() => value.toJson();
}

class TronHttpTransactionContractInt64StringCompatibleParameterValueVoteWitnessContractInt64StringCompatible
    extends TronHttpTransactionContractInt64StringCompatibleParameterValue {
  final TronHttpVoteWitnessContractInt64StringCompatible value;
  const TronHttpTransactionContractInt64StringCompatibleParameterValueVoteWitnessContractInt64StringCompatible(
    this.value,
  );

  @override
  dynamic toJson() => value.toJson();
}

class TronHttpTransactionContractInt64StringCompatibleParameterValueWithdrawBalanceContract
    extends TronHttpTransactionContractInt64StringCompatibleParameterValue {
  final TronHttpWithdrawBalanceContract value;
  const TronHttpTransactionContractInt64StringCompatibleParameterValueWithdrawBalanceContract(
    this.value,
  );

  @override
  dynamic toJson() => value.toJson();
}

class TronHttpTransactionContractInt64StringCompatibleParameterValueWithdrawExpireUnfreezeContract
    extends TronHttpTransactionContractInt64StringCompatibleParameterValue {
  final TronHttpWithdrawExpireUnfreezeContract value;
  const TronHttpTransactionContractInt64StringCompatibleParameterValueWithdrawExpireUnfreezeContract(
    this.value,
  );

  @override
  dynamic toJson() => value.toJson();
}

class TronHttpTransactionContractInt64StringCompatibleParameterValueWitnessCreateContract
    extends TronHttpTransactionContractInt64StringCompatibleParameterValue {
  final TronHttpWitnessCreateContract value;
  const TronHttpTransactionContractInt64StringCompatibleParameterValueWitnessCreateContract(
    this.value,
  );

  @override
  dynamic toJson() => value.toJson();
}

class TronHttpTransactionContractInt64StringCompatibleParameterValueWitnessUpdateContract
    extends TronHttpTransactionContractInt64StringCompatibleParameterValue {
  final TronHttpWitnessUpdateContract value;
  const TronHttpTransactionContractInt64StringCompatibleParameterValueWitnessUpdateContract(
    this.value,
  );

  @override
  dynamic toJson() => value.toJson();
}

/// Hex string, amount, or value field accepted by this endpoint.
sealed class TronHttpTransactionContractParameterValue {
  const TronHttpTransactionContractParameterValue();

  /// Parses `value` using the parent `parameter.type_url` (e.g.
  /// `type.googleapis.com/protocol.TransferContract`) as the discriminator.
  /// Falls back to structural matching when [typeUrl] is null or unknown.
  factory TronHttpTransactionContractParameterValue.fromJsonWithTypeUrl(
    dynamic json, [
    String? typeUrl,
  ]) {
    if (json is Map) {
      final map =
          json is Map<String, dynamic> ? json : Map<String, dynamic>.from(json);
      final typeName =
          typeUrl == null || typeUrl.isEmpty ? null : typeUrl.split('.').last;
      switch (typeName) {
        case 'AccountCreateContract':
          return TronHttpTransactionContractParameterValueAccountCreateContract(
            TronHttpAccountCreateContract.fromJson(map),
          );
        case 'AccountPermissionUpdateContract':
          return TronHttpTransactionContractParameterValueAccountPermissionUpdateContract(
            TronHttpAccountPermissionUpdateContract.fromJson(map),
          );
        case 'AccountUpdateContract':
          return TronHttpTransactionContractParameterValueAccountUpdateContract(
            TronHttpAccountUpdateContract.fromJson(map),
          );
        case 'AssetIssueContract':
          return TronHttpTransactionContractParameterValueAssetIssueContract(
            TronHttpAssetIssueContract.fromJson(map),
          );
        case 'CancelAllUnfreezeV2Contract':
          return TronHttpTransactionContractParameterValueCancelAllUnfreezeV2Contract(
            TronHttpCancelAllUnfreezeV2Contract.fromJson(map),
          );
        case 'ClearABIContract':
          return TronHttpTransactionContractParameterValueClearABIContract(
            TronHttpClearABIContract.fromJson(map),
          );
        case 'CreateSmartContract':
          return TronHttpTransactionContractParameterValueCreateSmartContract(
            TronHttpCreateSmartContract.fromJson(map),
          );
        case 'DelegateResourceContract':
          return TronHttpTransactionContractParameterValueDelegateResourceContract(
            TronHttpDelegateResourceContract.fromJson(map),
          );
        case 'ExchangeCreateContract':
          return TronHttpTransactionContractParameterValueExchangeCreateContract(
            TronHttpExchangeCreateContract.fromJson(map),
          );
        case 'ExchangeInjectContract':
          return TronHttpTransactionContractParameterValueExchangeInjectContract(
            TronHttpExchangeInjectContract.fromJson(map),
          );
        case 'ExchangeTransactionContract':
          return TronHttpTransactionContractParameterValueExchangeTransactionContract(
            TronHttpExchangeTransactionContract.fromJson(map),
          );
        case 'ExchangeWithdrawContract':
          return TronHttpTransactionContractParameterValueExchangeWithdrawContract(
            TronHttpExchangeWithdrawContract.fromJson(map),
          );
        case 'FreezeBalanceContract':
          return TronHttpTransactionContractParameterValueFreezeBalanceContract(
            TronHttpFreezeBalanceContract.fromJson(map),
          );
        case 'FreezeBalanceV2Contract':
          return TronHttpTransactionContractParameterValueFreezeBalanceV2Contract(
            TronHttpFreezeBalanceV2Contract.fromJson(map),
          );
        case 'MarketCancelOrderContract':
          return TronHttpTransactionContractParameterValueMarketCancelOrderContract(
            TronHttpMarketCancelOrderContract.fromJson(map),
          );
        case 'MarketSellAssetContract':
          return TronHttpTransactionContractParameterValueMarketSellAssetContract(
            TronHttpMarketSellAssetContract.fromJson(map),
          );
        case 'ParticipateAssetIssueContract':
          return TronHttpTransactionContractParameterValueParticipateAssetIssueContract(
            TronHttpParticipateAssetIssueContract.fromJson(map),
          );
        case 'ProposalApproveContract':
          return TronHttpTransactionContractParameterValueProposalApproveContract(
            TronHttpProposalApproveContract.fromJson(map),
          );
        case 'ProposalCreateContract':
          return TronHttpTransactionContractParameterValueProposalCreateContract(
            TronHttpProposalCreateContract.fromJson(map),
          );
        case 'ProposalDeleteContract':
          return TronHttpTransactionContractParameterValueProposalDeleteContract(
            TronHttpProposalDeleteContract.fromJson(map),
          );
        case 'SetAccountIdContract':
          return TronHttpTransactionContractParameterValueSetAccountIdContract(
            TronHttpSetAccountIdContract.fromJson(map),
          );
        case 'ShieldedTransferContract':
          return TronHttpTransactionContractParameterValueShieldedTransferContract(
            TronHttpShieldedTransferContract.fromJson(map),
          );
        case 'TransferAssetContract':
          return TronHttpTransactionContractParameterValueTransferAssetContract(
            TronHttpTransferAssetContract.fromJson(map),
          );
        case 'TransferContract':
          return TronHttpTransactionContractParameterValueTransferContract(
            TronHttpTransferContract.fromJson(map),
          );
        case 'TriggerSmartContract':
          return TronHttpTransactionContractParameterValueTriggerSmartContract(
            TronHttpTriggerSmartContract.fromJson(map),
          );
        case 'UnDelegateResourceContract':
          return TronHttpTransactionContractParameterValueUnDelegateResourceContract(
            TronHttpUnDelegateResourceContract.fromJson(map),
          );
        case 'UnfreezeAssetContract':
          return TronHttpTransactionContractParameterValueUnfreezeAssetContract(
            TronHttpUnfreezeAssetContract.fromJson(map),
          );
        case 'UnfreezeBalanceContract':
          return TronHttpTransactionContractParameterValueUnfreezeBalanceContract(
            TronHttpUnfreezeBalanceContract.fromJson(map),
          );
        case 'UnfreezeBalanceV2Contract':
          return TronHttpTransactionContractParameterValueUnfreezeBalanceV2Contract(
            TronHttpUnfreezeBalanceV2Contract.fromJson(map),
          );
        case 'UpdateAssetContract':
          return TronHttpTransactionContractParameterValueUpdateAssetContract(
            TronHttpUpdateAssetContract.fromJson(map),
          );
        case 'UpdateBrokerageContract':
          return TronHttpTransactionContractParameterValueUpdateBrokerageContract(
            TronHttpUpdateBrokerageContract.fromJson(map),
          );
        case 'UpdateEnergyLimitContract':
          return TronHttpTransactionContractParameterValueUpdateEnergyLimitContract(
            TronHttpUpdateEnergyLimitContract.fromJson(map),
          );
        case 'UpdateSettingContract':
          return TronHttpTransactionContractParameterValueUpdateSettingContract(
            TronHttpUpdateSettingContract.fromJson(map),
          );
        case 'VoteWitnessContract':
          return TronHttpTransactionContractParameterValueVoteWitnessContract(
            TronHttpVoteWitnessContract.fromJson(map),
          );
        case 'WithdrawBalanceContract':
          return TronHttpTransactionContractParameterValueWithdrawBalanceContract(
            TronHttpWithdrawBalanceContract.fromJson(map),
          );
        case 'WithdrawExpireUnfreezeContract':
          return TronHttpTransactionContractParameterValueWithdrawExpireUnfreezeContract(
            TronHttpWithdrawExpireUnfreezeContract.fromJson(map),
          );
        case 'WitnessCreateContract':
          return TronHttpTransactionContractParameterValueWitnessCreateContract(
            TronHttpWitnessCreateContract.fromJson(map),
          );
        case 'WitnessUpdateContract':
          return TronHttpTransactionContractParameterValueWitnessUpdateContract(
            TronHttpWitnessUpdateContract.fromJson(map),
          );
        default:
          return TronHttpTransactionContractParameterValue.fromJson(map);
      }
    }
    return TronHttpTransactionContractParameterValue.fromJson(json);
  }

  factory TronHttpTransactionContractParameterValue.fromJson(dynamic json) {
    if (json is Map) {
      final map =
          json is Map<String, dynamic> ? json : Map<String, dynamic>.from(json);
      if (map.hasValue('frozen_duration')) {
        return TronHttpTransactionContractParameterValueFreezeBalanceContract(
          TronHttpFreezeBalanceContract.fromJson(map),
        );
      }
      if (map.hasValue('actives') ||
          map.hasValue('owner') ||
          map.hasValue('witness')) {
        return TronHttpTransactionContractParameterValueAccountPermissionUpdateContract(
          TronHttpAccountPermissionUpdateContract.fromJson(map),
        );
      }
      if (map.hasValue('account_name')) {
        return TronHttpTransactionContractParameterValueAccountUpdateContract(
          TronHttpAccountUpdateContract.fromJson(map),
        );
      }
      if (map.hasValue('abbr') ||
          map.hasValue('end_time') ||
          map.hasValue('free_asset_net_limit') ||
          map.hasValue('frozen_supply') ||
          map.hasValue('id') ||
          map.hasValue('name') ||
          map.hasValue('num') ||
          map.hasValue('order') ||
          map.hasValue('precision') ||
          map.hasValue('public_free_asset_net_limit') ||
          map.hasValue('public_free_asset_net_usage') ||
          map.hasValue('public_latest_free_net_time') ||
          map.hasValue('start_time') ||
          map.hasValue('total_supply') ||
          map.hasValue('trx_num') ||
          map.hasValue('vote_score')) {
        return TronHttpTransactionContractParameterValueAssetIssueContract(
          TronHttpAssetIssueContract.fromJson(map),
        );
      }
      if (map.hasValue('new_contract')) {
        return TronHttpTransactionContractParameterValueCreateSmartContract(
          TronHttpCreateSmartContract.fromJson(map),
        );
      }
      if (map.hasValue('lock') || map.hasValue('lock_period')) {
        return TronHttpTransactionContractParameterValueDelegateResourceContract(
          TronHttpDelegateResourceContract.fromJson(map),
        );
      }
      if (map.hasValue('first_token_balance') ||
          map.hasValue('first_token_id') ||
          map.hasValue('second_token_balance') ||
          map.hasValue('second_token_id')) {
        return TronHttpTransactionContractParameterValueExchangeCreateContract(
          TronHttpExchangeCreateContract.fromJson(map),
        );
      }
      if (map.hasValue('expected')) {
        return TronHttpTransactionContractParameterValueExchangeTransactionContract(
          TronHttpExchangeTransactionContract.fromJson(map),
        );
      }
      if (map.hasValue('account_address') || map.hasValue('type')) {
        return TronHttpTransactionContractParameterValueAccountCreateContract(
          TronHttpAccountCreateContract.fromJson(map),
        );
      }
      if (map.hasValue('order_id')) {
        return TronHttpTransactionContractParameterValueMarketCancelOrderContract(
          TronHttpMarketCancelOrderContract.fromJson(map),
        );
      }
      if (map.hasValue('buy_token_id') ||
          map.hasValue('buy_token_quantity') ||
          map.hasValue('sell_token_id') ||
          map.hasValue('sell_token_quantity')) {
        return TronHttpTransactionContractParameterValueMarketSellAssetContract(
          TronHttpMarketSellAssetContract.fromJson(map),
        );
      }
      if (map.hasValue('is_add_approval')) {
        return TronHttpTransactionContractParameterValueProposalApproveContract(
          TronHttpProposalApproveContract.fromJson(map),
        );
      }
      if (map.hasValue('parameters')) {
        return TronHttpTransactionContractParameterValueProposalCreateContract(
          TronHttpProposalCreateContract.fromJson(map),
        );
      }
      if (map.hasValue('account_id')) {
        return TronHttpTransactionContractParameterValueSetAccountIdContract(
          TronHttpSetAccountIdContract.fromJson(map),
        );
      }
      if (map.hasValue('binding_signature') ||
          map.hasValue('from_amount') ||
          map.hasValue('receive_description') ||
          map.hasValue('spend_description') ||
          map.hasValue('to_amount') ||
          map.hasValue('transparent_from_address') ||
          map.hasValue('transparent_to_address')) {
        return TronHttpTransactionContractParameterValueShieldedTransferContract(
          TronHttpShieldedTransferContract.fromJson(map),
        );
      }
      if (map.hasValue('update_url')) {
        return TronHttpTransactionContractParameterValueWitnessUpdateContract(
          TronHttpWitnessUpdateContract.fromJson(map),
        );
      }
      if (map.hasValue('unfreeze_balance')) {
        return TronHttpTransactionContractParameterValueUnfreezeBalanceV2Contract(
          TronHttpUnfreezeBalanceV2Contract.fromJson(map),
        );
      }
      if (map.hasValue('new_limit') || map.hasValue('new_public_limit')) {
        return TronHttpTransactionContractParameterValueUpdateAssetContract(
          TronHttpUpdateAssetContract.fromJson(map),
        );
      }
      if (map.hasValue('brokerage')) {
        return TronHttpTransactionContractParameterValueUpdateBrokerageContract(
          TronHttpUpdateBrokerageContract.fromJson(map),
        );
      }
      if (map.hasValue('origin_energy_limit')) {
        return TronHttpTransactionContractParameterValueUpdateEnergyLimitContract(
          TronHttpUpdateEnergyLimitContract.fromJson(map),
        );
      }
      if (map.hasValue('consume_user_resource_percent')) {
        return TronHttpTransactionContractParameterValueUpdateSettingContract(
          TronHttpUpdateSettingContract.fromJson(map),
        );
      }
      if (map.hasValue('support') || map.hasValue('votes')) {
        return TronHttpTransactionContractParameterValueVoteWitnessContract(
          TronHttpVoteWitnessContract.fromJson(map),
        );
      }
      if (map.hasValue('call_value') || map.hasValue('data')) {
        return TronHttpTransactionContractParameterValueTriggerSmartContract(
          TronHttpTriggerSmartContract.fromJson(map),
        );
      }
      if (map.hasValue('exchange_id') &&
          map.hasValue('owner_address') &&
          map.hasValue('quant') &&
          map.hasValue('token_id')) {
        return TronHttpTransactionContractParameterValueExchangeInjectContract(
          TronHttpExchangeInjectContract.fromJson(map),
        );
      }
      if (map.hasValue('exchange_id') &&
          map.hasValue('owner_address') &&
          map.hasValue('quant') &&
          map.hasValue('token_id')) {
        return TronHttpTransactionContractParameterValueExchangeWithdrawContract(
          TronHttpExchangeWithdrawContract.fromJson(map),
        );
      }
      if (map.hasValue('amount') &&
          map.hasValue('asset_name') &&
          map.hasValue('owner_address') &&
          map.hasValue('to_address')) {
        return TronHttpTransactionContractParameterValueParticipateAssetIssueContract(
          TronHttpParticipateAssetIssueContract.fromJson(map),
        );
      }
      if (map.hasValue('amount') &&
          map.hasValue('asset_name') &&
          map.hasValue('owner_address') &&
          map.hasValue('to_address')) {
        return TronHttpTransactionContractParameterValueTransferAssetContract(
          TronHttpTransferAssetContract.fromJson(map),
        );
      }
      if (map.hasValue('balance') &&
          map.hasValue('owner_address') &&
          map.hasValue('receiver_address') &&
          map.hasValue('resource')) {
        return TronHttpTransactionContractParameterValueUnDelegateResourceContract(
          TronHttpUnDelegateResourceContract.fromJson(map),
        );
      }
      if (map.hasValue('frozen_balance') &&
          map.hasValue('owner_address') &&
          map.hasValue('resource')) {
        return TronHttpTransactionContractParameterValueFreezeBalanceV2Contract(
          TronHttpFreezeBalanceV2Contract.fromJson(map),
        );
      }
      if (map.hasValue('amount') &&
          map.hasValue('owner_address') &&
          map.hasValue('to_address')) {
        return TronHttpTransactionContractParameterValueTransferContract(
          TronHttpTransferContract.fromJson(map),
        );
      }
      if (map.hasValue('owner_address') &&
          map.hasValue('receiver_address') &&
          map.hasValue('resource')) {
        return TronHttpTransactionContractParameterValueUnfreezeBalanceContract(
          TronHttpUnfreezeBalanceContract.fromJson(map),
        );
      }
      if (map.hasValue('contract_address') && map.hasValue('owner_address')) {
        return TronHttpTransactionContractParameterValueClearABIContract(
          TronHttpClearABIContract.fromJson(map),
        );
      }
      if (map.hasValue('owner_address') && map.hasValue('proposal_id')) {
        return TronHttpTransactionContractParameterValueProposalDeleteContract(
          TronHttpProposalDeleteContract.fromJson(map),
        );
      }
      if (map.hasValue('owner_address') && map.hasValue('url')) {
        return TronHttpTransactionContractParameterValueWitnessCreateContract(
          TronHttpWitnessCreateContract.fromJson(map),
        );
      }
      if (map.hasValue('owner_address')) {
        return TronHttpTransactionContractParameterValueCancelAllUnfreezeV2Contract(
          TronHttpCancelAllUnfreezeV2Contract.fromJson(map),
        );
      }
      if (map.hasValue('owner_address')) {
        return TronHttpTransactionContractParameterValueUnfreezeAssetContract(
          TronHttpUnfreezeAssetContract.fromJson(map),
        );
      }
      if (map.hasValue('owner_address')) {
        return TronHttpTransactionContractParameterValueWithdrawBalanceContract(
          TronHttpWithdrawBalanceContract.fromJson(map),
        );
      }
      if (map.hasValue('owner_address')) {
        return TronHttpTransactionContractParameterValueWithdrawExpireUnfreezeContract(
          TronHttpWithdrawExpireUnfreezeContract.fromJson(map),
        );
      }
      try {
        return TronHttpTransactionContractParameterValueExchangeInjectContract(
          TronHttpExchangeInjectContract.fromJson(map),
        );
      } catch (_) {}
      try {
        return TronHttpTransactionContractParameterValueExchangeWithdrawContract(
          TronHttpExchangeWithdrawContract.fromJson(map),
        );
      } catch (_) {}
      try {
        return TronHttpTransactionContractParameterValueParticipateAssetIssueContract(
          TronHttpParticipateAssetIssueContract.fromJson(map),
        );
      } catch (_) {}
      try {
        return TronHttpTransactionContractParameterValueTransferAssetContract(
          TronHttpTransferAssetContract.fromJson(map),
        );
      } catch (_) {}
      try {
        return TronHttpTransactionContractParameterValueUnDelegateResourceContract(
          TronHttpUnDelegateResourceContract.fromJson(map),
        );
      } catch (_) {}
      try {
        return TronHttpTransactionContractParameterValueFreezeBalanceV2Contract(
          TronHttpFreezeBalanceV2Contract.fromJson(map),
        );
      } catch (_) {}
      try {
        return TronHttpTransactionContractParameterValueTransferContract(
          TronHttpTransferContract.fromJson(map),
        );
      } catch (_) {}
      try {
        return TronHttpTransactionContractParameterValueUnfreezeBalanceContract(
          TronHttpUnfreezeBalanceContract.fromJson(map),
        );
      } catch (_) {}
      try {
        return TronHttpTransactionContractParameterValueClearABIContract(
          TronHttpClearABIContract.fromJson(map),
        );
      } catch (_) {}
      try {
        return TronHttpTransactionContractParameterValueProposalDeleteContract(
          TronHttpProposalDeleteContract.fromJson(map),
        );
      } catch (_) {}
      try {
        return TronHttpTransactionContractParameterValueWitnessCreateContract(
          TronHttpWitnessCreateContract.fromJson(map),
        );
      } catch (_) {}
      try {
        return TronHttpTransactionContractParameterValueCancelAllUnfreezeV2Contract(
          TronHttpCancelAllUnfreezeV2Contract.fromJson(map),
        );
      } catch (_) {}
      try {
        return TronHttpTransactionContractParameterValueUnfreezeAssetContract(
          TronHttpUnfreezeAssetContract.fromJson(map),
        );
      } catch (_) {}
      try {
        return TronHttpTransactionContractParameterValueWithdrawBalanceContract(
          TronHttpWithdrawBalanceContract.fromJson(map),
        );
      } catch (_) {}
      try {
        return TronHttpTransactionContractParameterValueWithdrawExpireUnfreezeContract(
          TronHttpWithdrawExpireUnfreezeContract.fromJson(map),
        );
      } catch (_) {}
    }
    throw CoreErrors.invalidOperationArguments(
      'TronHttpTransactionContractParameterValue',
      reason:
          'Cannot parse TronHttpTransactionContractParameterValue from $json',
    );
  }

  dynamic toJson();
}

class TronHttpTransactionContractParameterValueAccountCreateContract
    extends TronHttpTransactionContractParameterValue {
  final TronHttpAccountCreateContract value;
  const TronHttpTransactionContractParameterValueAccountCreateContract(
    this.value,
  );

  @override
  dynamic toJson() => value.toJson();
}

class TronHttpTransactionContractParameterValueAccountPermissionUpdateContract
    extends TronHttpTransactionContractParameterValue {
  final TronHttpAccountPermissionUpdateContract value;
  const TronHttpTransactionContractParameterValueAccountPermissionUpdateContract(
    this.value,
  );

  @override
  dynamic toJson() => value.toJson();
}

class TronHttpTransactionContractParameterValueAccountUpdateContract
    extends TronHttpTransactionContractParameterValue {
  final TronHttpAccountUpdateContract value;
  const TronHttpTransactionContractParameterValueAccountUpdateContract(
    this.value,
  );

  @override
  dynamic toJson() => value.toJson();
}

class TronHttpTransactionContractParameterValueAssetIssueContract
    extends TronHttpTransactionContractParameterValue {
  final TronHttpAssetIssueContract value;
  const TronHttpTransactionContractParameterValueAssetIssueContract(this.value);

  @override
  dynamic toJson() => value.toJson();
}

class TronHttpTransactionContractParameterValueCancelAllUnfreezeV2Contract
    extends TronHttpTransactionContractParameterValue {
  final TronHttpCancelAllUnfreezeV2Contract value;
  const TronHttpTransactionContractParameterValueCancelAllUnfreezeV2Contract(
    this.value,
  );

  @override
  dynamic toJson() => value.toJson();
}

class TronHttpTransactionContractParameterValueClearABIContract
    extends TronHttpTransactionContractParameterValue {
  final TronHttpClearABIContract value;
  const TronHttpTransactionContractParameterValueClearABIContract(this.value);

  @override
  dynamic toJson() => value.toJson();
}

class TronHttpTransactionContractParameterValueCreateSmartContract
    extends TronHttpTransactionContractParameterValue {
  final TronHttpCreateSmartContract value;
  const TronHttpTransactionContractParameterValueCreateSmartContract(
    this.value,
  );

  @override
  dynamic toJson() => value.toJson();
}

class TronHttpTransactionContractParameterValueDelegateResourceContract
    extends TronHttpTransactionContractParameterValue {
  final TronHttpDelegateResourceContract value;
  const TronHttpTransactionContractParameterValueDelegateResourceContract(
    this.value,
  );

  @override
  dynamic toJson() => value.toJson();
}

class TronHttpTransactionContractParameterValueExchangeCreateContract
    extends TronHttpTransactionContractParameterValue {
  final TronHttpExchangeCreateContract value;
  const TronHttpTransactionContractParameterValueExchangeCreateContract(
    this.value,
  );

  @override
  dynamic toJson() => value.toJson();
}

class TronHttpTransactionContractParameterValueExchangeInjectContract
    extends TronHttpTransactionContractParameterValue {
  final TronHttpExchangeInjectContract value;
  const TronHttpTransactionContractParameterValueExchangeInjectContract(
    this.value,
  );

  @override
  dynamic toJson() => value.toJson();
}

class TronHttpTransactionContractParameterValueExchangeTransactionContract
    extends TronHttpTransactionContractParameterValue {
  final TronHttpExchangeTransactionContract value;
  const TronHttpTransactionContractParameterValueExchangeTransactionContract(
    this.value,
  );

  @override
  dynamic toJson() => value.toJson();
}

class TronHttpTransactionContractParameterValueExchangeWithdrawContract
    extends TronHttpTransactionContractParameterValue {
  final TronHttpExchangeWithdrawContract value;
  const TronHttpTransactionContractParameterValueExchangeWithdrawContract(
    this.value,
  );

  @override
  dynamic toJson() => value.toJson();
}

class TronHttpTransactionContractParameterValueFreezeBalanceContract
    extends TronHttpTransactionContractParameterValue {
  final TronHttpFreezeBalanceContract value;
  const TronHttpTransactionContractParameterValueFreezeBalanceContract(
    this.value,
  );

  @override
  dynamic toJson() => value.toJson();
}

class TronHttpTransactionContractParameterValueFreezeBalanceV2Contract
    extends TronHttpTransactionContractParameterValue {
  final TronHttpFreezeBalanceV2Contract value;
  const TronHttpTransactionContractParameterValueFreezeBalanceV2Contract(
    this.value,
  );

  @override
  dynamic toJson() => value.toJson();
}

class TronHttpTransactionContractParameterValueMarketCancelOrderContract
    extends TronHttpTransactionContractParameterValue {
  final TronHttpMarketCancelOrderContract value;
  const TronHttpTransactionContractParameterValueMarketCancelOrderContract(
    this.value,
  );

  @override
  dynamic toJson() => value.toJson();
}

class TronHttpTransactionContractParameterValueMarketSellAssetContract
    extends TronHttpTransactionContractParameterValue {
  final TronHttpMarketSellAssetContract value;
  const TronHttpTransactionContractParameterValueMarketSellAssetContract(
    this.value,
  );

  @override
  dynamic toJson() => value.toJson();
}

class TronHttpTransactionContractParameterValueParticipateAssetIssueContract
    extends TronHttpTransactionContractParameterValue {
  final TronHttpParticipateAssetIssueContract value;
  const TronHttpTransactionContractParameterValueParticipateAssetIssueContract(
    this.value,
  );

  @override
  dynamic toJson() => value.toJson();
}

class TronHttpTransactionContractParameterValueProposalApproveContract
    extends TronHttpTransactionContractParameterValue {
  final TronHttpProposalApproveContract value;
  const TronHttpTransactionContractParameterValueProposalApproveContract(
    this.value,
  );

  @override
  dynamic toJson() => value.toJson();
}

class TronHttpTransactionContractParameterValueProposalCreateContract
    extends TronHttpTransactionContractParameterValue {
  final TronHttpProposalCreateContract value;
  const TronHttpTransactionContractParameterValueProposalCreateContract(
    this.value,
  );

  @override
  dynamic toJson() => value.toJson();
}

class TronHttpTransactionContractParameterValueProposalDeleteContract
    extends TronHttpTransactionContractParameterValue {
  final TronHttpProposalDeleteContract value;
  const TronHttpTransactionContractParameterValueProposalDeleteContract(
    this.value,
  );

  @override
  dynamic toJson() => value.toJson();
}

class TronHttpTransactionContractParameterValueSetAccountIdContract
    extends TronHttpTransactionContractParameterValue {
  final TronHttpSetAccountIdContract value;
  const TronHttpTransactionContractParameterValueSetAccountIdContract(
    this.value,
  );

  @override
  dynamic toJson() => value.toJson();
}

class TronHttpTransactionContractParameterValueShieldedTransferContract
    extends TronHttpTransactionContractParameterValue {
  final TronHttpShieldedTransferContract value;
  const TronHttpTransactionContractParameterValueShieldedTransferContract(
    this.value,
  );

  @override
  dynamic toJson() => value.toJson();
}

class TronHttpTransactionContractParameterValueTransferAssetContract
    extends TronHttpTransactionContractParameterValue {
  final TronHttpTransferAssetContract value;
  const TronHttpTransactionContractParameterValueTransferAssetContract(
    this.value,
  );

  @override
  dynamic toJson() => value.toJson();
}

class TronHttpTransactionContractParameterValueTransferContract
    extends TronHttpTransactionContractParameterValue {
  final TronHttpTransferContract value;
  const TronHttpTransactionContractParameterValueTransferContract(this.value);

  @override
  dynamic toJson() => value.toJson();
}

class TronHttpTransactionContractParameterValueTriggerSmartContract
    extends TronHttpTransactionContractParameterValue {
  final TronHttpTriggerSmartContract value;
  const TronHttpTransactionContractParameterValueTriggerSmartContract(
    this.value,
  );

  @override
  dynamic toJson() => value.toJson();
}

class TronHttpTransactionContractParameterValueUnDelegateResourceContract
    extends TronHttpTransactionContractParameterValue {
  final TronHttpUnDelegateResourceContract value;
  const TronHttpTransactionContractParameterValueUnDelegateResourceContract(
    this.value,
  );

  @override
  dynamic toJson() => value.toJson();
}

class TronHttpTransactionContractParameterValueUnfreezeAssetContract
    extends TronHttpTransactionContractParameterValue {
  final TronHttpUnfreezeAssetContract value;
  const TronHttpTransactionContractParameterValueUnfreezeAssetContract(
    this.value,
  );

  @override
  dynamic toJson() => value.toJson();
}

class TronHttpTransactionContractParameterValueUnfreezeBalanceContract
    extends TronHttpTransactionContractParameterValue {
  final TronHttpUnfreezeBalanceContract value;
  const TronHttpTransactionContractParameterValueUnfreezeBalanceContract(
    this.value,
  );

  @override
  dynamic toJson() => value.toJson();
}

class TronHttpTransactionContractParameterValueUnfreezeBalanceV2Contract
    extends TronHttpTransactionContractParameterValue {
  final TronHttpUnfreezeBalanceV2Contract value;
  const TronHttpTransactionContractParameterValueUnfreezeBalanceV2Contract(
    this.value,
  );

  @override
  dynamic toJson() => value.toJson();
}

class TronHttpTransactionContractParameterValueUpdateAssetContract
    extends TronHttpTransactionContractParameterValue {
  final TronHttpUpdateAssetContract value;
  const TronHttpTransactionContractParameterValueUpdateAssetContract(
    this.value,
  );

  @override
  dynamic toJson() => value.toJson();
}

class TronHttpTransactionContractParameterValueUpdateBrokerageContract
    extends TronHttpTransactionContractParameterValue {
  final TronHttpUpdateBrokerageContract value;
  const TronHttpTransactionContractParameterValueUpdateBrokerageContract(
    this.value,
  );

  @override
  dynamic toJson() => value.toJson();
}

class TronHttpTransactionContractParameterValueUpdateEnergyLimitContract
    extends TronHttpTransactionContractParameterValue {
  final TronHttpUpdateEnergyLimitContract value;
  const TronHttpTransactionContractParameterValueUpdateEnergyLimitContract(
    this.value,
  );

  @override
  dynamic toJson() => value.toJson();
}

class TronHttpTransactionContractParameterValueUpdateSettingContract
    extends TronHttpTransactionContractParameterValue {
  final TronHttpUpdateSettingContract value;
  const TronHttpTransactionContractParameterValueUpdateSettingContract(
    this.value,
  );

  @override
  dynamic toJson() => value.toJson();
}

class TronHttpTransactionContractParameterValueVoteWitnessContract
    extends TronHttpTransactionContractParameterValue {
  final TronHttpVoteWitnessContract value;
  const TronHttpTransactionContractParameterValueVoteWitnessContract(
    this.value,
  );

  @override
  dynamic toJson() => value.toJson();
}

class TronHttpTransactionContractParameterValueWithdrawBalanceContract
    extends TronHttpTransactionContractParameterValue {
  final TronHttpWithdrawBalanceContract value;
  const TronHttpTransactionContractParameterValueWithdrawBalanceContract(
    this.value,
  );

  @override
  dynamic toJson() => value.toJson();
}

class TronHttpTransactionContractParameterValueWithdrawExpireUnfreezeContract
    extends TronHttpTransactionContractParameterValue {
  final TronHttpWithdrawExpireUnfreezeContract value;
  const TronHttpTransactionContractParameterValueWithdrawExpireUnfreezeContract(
    this.value,
  );

  @override
  dynamic toJson() => value.toJson();
}

class TronHttpTransactionContractParameterValueWitnessCreateContract
    extends TronHttpTransactionContractParameterValue {
  final TronHttpWitnessCreateContract value;
  const TronHttpTransactionContractParameterValueWitnessCreateContract(
    this.value,
  );

  @override
  dynamic toJson() => value.toJson();
}

class TronHttpTransactionContractParameterValueWitnessUpdateContract
    extends TronHttpTransactionContractParameterValue {
  final TronHttpWitnessUpdateContract value;
  const TronHttpTransactionContractParameterValueWitnessUpdateContract(
    this.value,
  );

  @override
  dynamic toJson() => value.toJson();
}

/// Account, contract, or resource type.
enum TronHttpTransactionContractType {
  accountCreateContract("AccountCreateContract"),
  transferContract("TransferContract"),
  transferAssetContract("TransferAssetContract"),
  voteAssetContract("VoteAssetContract"),
  voteWitnessContract("VoteWitnessContract"),
  witnessCreateContract("WitnessCreateContract"),
  assetIssueContract("AssetIssueContract"),
  witnessUpdateContract("WitnessUpdateContract"),
  participateAssetIssueContract("ParticipateAssetIssueContract"),
  accountUpdateContract("AccountUpdateContract"),
  freezeBalanceContract("FreezeBalanceContract"),
  unfreezeBalanceContract("UnfreezeBalanceContract"),
  withdrawBalanceContract("WithdrawBalanceContract"),
  unfreezeAssetContract("UnfreezeAssetContract"),
  updateAssetContract("UpdateAssetContract"),
  proposalCreateContract("ProposalCreateContract"),
  proposalApproveContract("ProposalApproveContract"),
  proposalDeleteContract("ProposalDeleteContract"),
  setAccountIdContract("SetAccountIdContract"),
  customContract("CustomContract"),
  createSmartContract("CreateSmartContract"),
  triggerSmartContract("TriggerSmartContract"),
  getContract("GetContract"),
  updateSettingContract("UpdateSettingContract"),
  exchangeCreateContract("ExchangeCreateContract"),
  exchangeInjectContract("ExchangeInjectContract"),
  exchangeWithdrawContract("ExchangeWithdrawContract"),
  exchangeTransactionContract("ExchangeTransactionContract"),
  updateEnergyLimitContract("UpdateEnergyLimitContract"),
  accountPermissionUpdateContract("AccountPermissionUpdateContract"),
  clearABIContract("ClearABIContract"),
  updateBrokerageContract("UpdateBrokerageContract"),
  shieldedTransferContract("ShieldedTransferContract"),
  marketSellAssetContract("MarketSellAssetContract"),
  marketCancelOrderContract("MarketCancelOrderContract"),
  freezeBalanceV2Contract("FreezeBalanceV2Contract"),
  unfreezeBalanceV2Contract("UnfreezeBalanceV2Contract"),
  withdrawExpireUnfreezeContract("WithdrawExpireUnfreezeContract"),
  delegateResourceContract("DelegateResourceContract"),
  unDelegateResourceContract("UnDelegateResourceContract"),
  cancelAllUnfreezeV2Contract("CancelAllUnfreezeV2Contract");

  final String value;
  const TronHttpTransactionContractType(this.value);

  static TronHttpTransactionContractType fromJson(dynamic json) {
    final value = json is String ? json : json?.toString();
    return values.firstWhere(
      (e) => e.value == value,
      orElse:
          () =>
              throw BuError(
                DefaultErrorType.invalidArgument,
                "Invalid TronHttpTransactionContractType.",
              ),
    );
  }

  String toJson() => value;
}

enum TronHttpTransactionResultContractRet {
  default_("DEFAULT"),
  success("SUCCESS"),
  revert("REVERT"),
  badJumpDestination("BAD_JUMP_DESTINATION"),
  outOfMemory("OUT_OF_MEMORY"),
  precompiledContract("PRECOMPILED_CONTRACT"),
  stackTooSmall("STACK_TOO_SMALL"),
  stackTooLarge("STACK_TOO_LARGE"),
  illegalOperation("ILLEGAL_OPERATION"),
  stackOverflow("STACK_OVERFLOW"),
  outOfEnergy("OUT_OF_ENERGY"),
  outOfTime("OUT_OF_TIME"),
  jvmStackOverFlow("JVM_STACK_OVER_FLOW"),
  unknown("UNKNOWN"),
  transferFailed("TRANSFER_FAILED"),
  invalidCode("INVALID_CODE");

  final String value;
  const TronHttpTransactionResultContractRet(this.value);

  static TronHttpTransactionResultContractRet fromJson(dynamic json) {
    final value = json is String ? json : json?.toString();
    return values.firstWhere(
      (e) => e.value == value,
      orElse:
          () =>
              throw BuError(
                DefaultErrorType.invalidArgument,
                "Invalid TronHttpTransactionResultContractRet.",
              ),
    );
  }

  String toJson() => value;
}

enum TronHttpTransactionResultRet {
  sucess("SUCESS"),
  failed("FAILED");

  final String value;
  const TronHttpTransactionResultRet(this.value);

  static TronHttpTransactionResultRet fromJson(dynamic json) {
    final value = json is String ? json : json?.toString();
    return values.firstWhere(
      (e) => e.value == value,
      orElse:
          () =>
              throw BuError(
                DefaultErrorType.invalidArgument,
                "Invalid TronHttpTransactionResultRet.",
              ),
    );
  }

  String toJson() => value;
}

enum TronHttpTransactionSignWeightResultCode {
  enoughPermission("ENOUGH_PERMISSION"),
  notEnoughPermission("NOT_ENOUGH_PERMISSION"),
  signatureFormatError("SIGNATURE_FORMAT_ERROR"),
  computeAddressError("COMPUTE_ADDRESS_ERROR"),
  permissionError("PERMISSION_ERROR"),
  otherError("OTHER_ERROR");

  final String value;
  const TronHttpTransactionSignWeightResultCode(this.value);

  static TronHttpTransactionSignWeightResultCode fromJson(dynamic json) {
    final value = json is String ? json : json?.toString();
    return values.firstWhere(
      (e) => e.value == value,
      orElse:
          () =>
              throw BuError(
                DefaultErrorType.invalidArgument,
                "Invalid TronHttpTransactionSignWeightResultCode.",
              ),
    );
  }

  String toJson() => value;
}

class TronHttpAccount {
  /// New account name encoded as expected by java-tron.
  final String? accountName;

  /// Account, contract, or resource type.
  final TronHttpAccountType? type;

  /// Account or contract address accepted by this endpoint.
  final String? address;

  /// Resource amount in sun, where 1 TRX equals 1,000,000 sun.
  final BigInt? balance;

  /// Witness vote entries.
  final List<TronHttpVote>? votes;
  final List<TronHttpAccountFrozen>? frozen;
  final BigInt? netUsage;
  final BigInt? acquiredDelegatedFrozenBalanceForBandwidth;
  final BigInt? delegatedFrozenBalanceForBandwidth;
  final BigInt? oldTronPower;
  final TronHttpAccountFrozen? tronPower;
  final bool? assetOptimized;
  final BigInt? createTime;
  final BigInt? latestOprationTime;
  final BigInt? allowance;
  final BigInt? latestWithdrawTime;
  final String? code;
  final bool? isWitness;
  final bool? isCommittee;

  /// Frozen supply schedules for an asset issue.
  final List<TronHttpAccountFrozen>? frozenSupply;
  final String? assetIssuedName;
  final String? assetIssuedID;
  final BigInt? freeNetUsage;
  final BigInt? latestConsumeTime;
  final BigInt? latestConsumeFreeTime;
  final String? accountId;
  final BigInt? netWindowSize;
  final bool? netWindowOptimized;
  final TronHttpAccountAccountResource? accountResource;
  final String? codeHash;
  final TronHttpPermission? ownerPermission;
  final TronHttpPermission? witnessPermission;
  final List<TronHttpPermission>? activePermission;
  final List<TronHttpAccountFreezeV2>? frozenV2;
  final List<TronHttpAccountUnFreezeV2>? unfrozenV2;
  final BigInt? delegatedFrozenV2BalanceForBandwidth;
  final BigInt? acquiredDelegatedFrozenV2BalanceForBandwidth;
  final Map<String, BigInt>? asset;
  final Map<String, BigInt>? assetV2;
  final Map<String, BigInt>? latestAssetOperationTime;
  final Map<String, BigInt>? latestAssetOperationTimeV2;
  final Map<String, BigInt>? freeAssetNetUsage;
  final Map<String, BigInt>? freeAssetNetUsageV2;

  const TronHttpAccount({
    this.accountName,
    this.type,
    this.address,
    this.balance,
    this.votes,
    this.frozen,
    this.netUsage,
    this.acquiredDelegatedFrozenBalanceForBandwidth,
    this.delegatedFrozenBalanceForBandwidth,
    this.oldTronPower,
    this.tronPower,
    this.assetOptimized,
    this.createTime,
    this.latestOprationTime,
    this.allowance,
    this.latestWithdrawTime,
    this.code,
    this.isWitness,
    this.isCommittee,
    this.frozenSupply,
    this.assetIssuedName,
    this.assetIssuedID,
    this.freeNetUsage,
    this.latestConsumeTime,
    this.latestConsumeFreeTime,
    this.accountId,
    this.netWindowSize,
    this.netWindowOptimized,
    this.accountResource,
    this.codeHash,
    this.ownerPermission,
    this.witnessPermission,
    this.activePermission,
    this.frozenV2,
    this.unfrozenV2,
    this.delegatedFrozenV2BalanceForBandwidth,
    this.acquiredDelegatedFrozenV2BalanceForBandwidth,
    this.asset,
    this.assetV2,
    this.latestAssetOperationTime,
    this.latestAssetOperationTimeV2,
    this.freeAssetNetUsage,
    this.freeAssetNetUsageV2,
  });

  factory TronHttpAccount.fromJson(Map<String, dynamic> json) {
    return TronHttpAccount(
      accountName:
          (json['account_name'] is num
              ? json['account_name'].toString()
              : json.valueAsString('account_name')),
      type:
          json.hasValue('type')
              ? TronHttpAccountType.fromJson(json['type'])
              : null,
      address:
          (json['address'] is num
              ? json['address'].toString()
              : json.valueAsString('address')),
      balance: json.valueAsBigInt('balance'),
      votes:
          json.hasValue('votes')
              ? json
                  .valueEnsureAsList<Map<String, dynamic>>('votes')
                  .map((e) => TronHttpVote.fromJson(e))
                  .toList()
              : null,
      frozen:
          json.hasValue('frozen')
              ? json
                  .valueEnsureAsList<Map<String, dynamic>>('frozen')
                  .map((e) => TronHttpAccountFrozen.fromJson(e))
                  .toList()
              : null,
      netUsage: json.valueAsBigInt('net_usage'),
      acquiredDelegatedFrozenBalanceForBandwidth: json.valueAsBigInt(
        'acquired_delegated_frozen_balance_for_bandwidth',
      ),
      delegatedFrozenBalanceForBandwidth: json.valueAsBigInt(
        'delegated_frozen_balance_for_bandwidth',
      ),
      oldTronPower: json.valueAsBigInt('old_tron_power'),
      tronPower: json.valueTo<TronHttpAccountFrozen?, Map<String, dynamic>>(
        key: 'tron_power',
        parse: (v) => TronHttpAccountFrozen.fromJson(v),
      ),
      assetOptimized: json.valueAsBool('asset_optimized'),
      createTime: json.valueAsBigInt('create_time'),
      latestOprationTime: json.valueAsBigInt('latest_opration_time'),
      allowance: json.valueAsBigInt('allowance'),
      latestWithdrawTime: json.valueAsBigInt('latest_withdraw_time'),
      code:
          (json['code'] is num
              ? json['code'].toString()
              : json.valueAsString('code')),
      isWitness: json.valueAsBool('is_witness'),
      isCommittee: json.valueAsBool('is_committee'),
      frozenSupply:
          json.hasValue('frozen_supply')
              ? json
                  .valueEnsureAsList<Map<String, dynamic>>('frozen_supply')
                  .map((e) => TronHttpAccountFrozen.fromJson(e))
                  .toList()
              : null,
      assetIssuedName:
          (json['asset_issued_name'] is num
              ? json['asset_issued_name'].toString()
              : json.valueAsString('asset_issued_name')),
      assetIssuedID:
          (json['asset_issued_ID'] is num
              ? json['asset_issued_ID'].toString()
              : json.valueAsString('asset_issued_ID')),
      freeNetUsage: json.valueAsBigInt('free_net_usage'),
      latestConsumeTime: json.valueAsBigInt('latest_consume_time'),
      latestConsumeFreeTime: json.valueAsBigInt('latest_consume_free_time'),
      accountId:
          (json['account_id'] is num
              ? json['account_id'].toString()
              : json.valueAsString('account_id')),
      netWindowSize: json.valueAsBigInt('net_window_size'),
      netWindowOptimized: json.valueAsBool('net_window_optimized'),
      accountResource: json
          .valueTo<TronHttpAccountAccountResource?, Map<String, dynamic>>(
            key: 'account_resource',
            parse: (v) => TronHttpAccountAccountResource.fromJson(v),
          ),
      codeHash:
          (json['codeHash'] is num
              ? json['codeHash'].toString()
              : json.valueAsString('codeHash')),
      ownerPermission: json.valueTo<TronHttpPermission?, Map<String, dynamic>>(
        key: 'owner_permission',
        parse: (v) => TronHttpPermission.fromJson(v),
      ),
      witnessPermission: json
          .valueTo<TronHttpPermission?, Map<String, dynamic>>(
            key: 'witness_permission',
            parse: (v) => TronHttpPermission.fromJson(v),
          ),
      activePermission:
          json.hasValue('active_permission')
              ? json
                  .valueEnsureAsList<Map<String, dynamic>>('active_permission')
                  .map((e) => TronHttpPermission.fromJson(e))
                  .toList()
              : null,
      frozenV2:
          json.hasValue('frozenV2')
              ? json
                  .valueEnsureAsList<Map<String, dynamic>>('frozenV2')
                  .map((e) => TronHttpAccountFreezeV2.fromJson(e))
                  .toList()
              : null,
      unfrozenV2:
          json.hasValue('unfrozenV2')
              ? json
                  .valueEnsureAsList<Map<String, dynamic>>('unfrozenV2')
                  .map((e) => TronHttpAccountUnFreezeV2.fromJson(e))
                  .toList()
              : null,
      delegatedFrozenV2BalanceForBandwidth: json.valueAsBigInt(
        'delegated_frozenV2_balance_for_bandwidth',
      ),
      acquiredDelegatedFrozenV2BalanceForBandwidth: json.valueAsBigInt(
        'acquired_delegated_frozenV2_balance_for_bandwidth',
      ),
      asset:
          json.hasValue('asset')
              ? _tronMapFromJson<BigInt>(
                json['asset'],
                JsonParser.valueAsBigInt<BigInt>,
              )
              : null,
      assetV2:
          json.hasValue('assetV2')
              ? _tronMapFromJson<BigInt>(
                json['assetV2'],
                JsonParser.valueAsBigInt<BigInt>,
              )
              : null,
      latestAssetOperationTime:
          json.hasValue('latest_asset_operation_time')
              ? _tronMapFromJson<BigInt>(
                json['latest_asset_operation_time'],
                JsonParser.valueAsBigInt<BigInt>,
              )
              : null,
      latestAssetOperationTimeV2:
          json.hasValue('latest_asset_operation_timeV2')
              ? _tronMapFromJson<BigInt>(
                json['latest_asset_operation_timeV2'],
                JsonParser.valueAsBigInt<BigInt>,
              )
              : null,
      freeAssetNetUsage:
          json.hasValue('free_asset_net_usage')
              ? _tronMapFromJson<BigInt>(
                json['free_asset_net_usage'],
                JsonParser.valueAsBigInt<BigInt>,
              )
              : null,
      freeAssetNetUsageV2:
          json.hasValue('free_asset_net_usageV2')
              ? _tronMapFromJson<BigInt>(
                json['free_asset_net_usageV2'],
                JsonParser.valueAsBigInt<BigInt>,
              )
              : null,
    );
  }

  Map<String, dynamic> toJson() => {
    'account_name': accountName,
    'type': type?.toJson(),
    'address': address,
    'balance': balance,
    'votes': votes?.map((e) => e.toJson()).toList(),
    'frozen': frozen?.map((e) => e.toJson()).toList(),
    'net_usage': netUsage,
    'acquired_delegated_frozen_balance_for_bandwidth':
        acquiredDelegatedFrozenBalanceForBandwidth,
    'delegated_frozen_balance_for_bandwidth':
        delegatedFrozenBalanceForBandwidth,
    'old_tron_power': oldTronPower,
    'tron_power': tronPower?.toJson(),
    'asset_optimized': assetOptimized,
    'create_time': createTime,
    'latest_opration_time': latestOprationTime,
    'allowance': allowance,
    'latest_withdraw_time': latestWithdrawTime,
    'code': code,
    'is_witness': isWitness,
    'is_committee': isCommittee,
    'frozen_supply': frozenSupply?.map((e) => e.toJson()).toList(),
    'asset_issued_name': assetIssuedName,
    'asset_issued_ID': assetIssuedID,
    'free_net_usage': freeNetUsage,
    'latest_consume_time': latestConsumeTime,
    'latest_consume_free_time': latestConsumeFreeTime,
    'account_id': accountId,
    'net_window_size': netWindowSize,
    'net_window_optimized': netWindowOptimized,
    'account_resource': accountResource?.toJson(),
    'codeHash': codeHash,
    'owner_permission': ownerPermission?.toJson(),
    'witness_permission': witnessPermission?.toJson(),
    'active_permission': activePermission?.map((e) => e.toJson()).toList(),
    'frozenV2': frozenV2?.map((e) => e.toJson()).toList(),
    'unfrozenV2': unfrozenV2?.map((e) => e.toJson()).toList(),
    'delegated_frozenV2_balance_for_bandwidth':
        delegatedFrozenV2BalanceForBandwidth,
    'acquired_delegated_frozenV2_balance_for_bandwidth':
        acquiredDelegatedFrozenV2BalanceForBandwidth,
    'asset': asset == null ? null : _tronMapToJson(asset!),
    'assetV2': assetV2 == null ? null : _tronMapToJson(assetV2!),
    'latest_asset_operation_time':
        latestAssetOperationTime == null
            ? null
            : _tronMapToJson(latestAssetOperationTime!),
    'latest_asset_operation_timeV2':
        latestAssetOperationTimeV2 == null
            ? null
            : _tronMapToJson(latestAssetOperationTimeV2!),
    'free_asset_net_usage':
        freeAssetNetUsage == null ? null : _tronMapToJson(freeAssetNetUsage!),
    'free_asset_net_usageV2':
        freeAssetNetUsageV2 == null
            ? null
            : _tronMapToJson(freeAssetNetUsageV2!),
  };
}

class TronHttpAccountAccountResource {
  final BigInt? energyUsage;
  final TronHttpAccountFrozen? frozenBalanceForEnergy;
  final BigInt? latestConsumeTimeForEnergy;
  final BigInt? acquiredDelegatedFrozenBalanceForEnergy;
  final BigInt? delegatedFrozenBalanceForEnergy;
  final BigInt? storageLimit;
  final BigInt? storageUsage;
  final BigInt? latestExchangeStorageTime;
  final BigInt? energyWindowSize;
  final BigInt? delegatedFrozenV2BalanceForEnergy;
  final BigInt? acquiredDelegatedFrozenV2BalanceForEnergy;
  final bool? energyWindowOptimized;

  const TronHttpAccountAccountResource({
    this.energyUsage,
    this.frozenBalanceForEnergy,
    this.latestConsumeTimeForEnergy,
    this.acquiredDelegatedFrozenBalanceForEnergy,
    this.delegatedFrozenBalanceForEnergy,
    this.storageLimit,
    this.storageUsage,
    this.latestExchangeStorageTime,
    this.energyWindowSize,
    this.delegatedFrozenV2BalanceForEnergy,
    this.acquiredDelegatedFrozenV2BalanceForEnergy,
    this.energyWindowOptimized,
  });

  factory TronHttpAccountAccountResource.fromJson(Map<String, dynamic> json) {
    return TronHttpAccountAccountResource(
      energyUsage: json.valueAsBigInt('energy_usage'),
      frozenBalanceForEnergy: json
          .valueTo<TronHttpAccountFrozen?, Map<String, dynamic>>(
            key: 'frozen_balance_for_energy',
            parse: (v) => TronHttpAccountFrozen.fromJson(v),
          ),
      latestConsumeTimeForEnergy: json.valueAsBigInt(
        'latest_consume_time_for_energy',
      ),
      acquiredDelegatedFrozenBalanceForEnergy: json.valueAsBigInt(
        'acquired_delegated_frozen_balance_for_energy',
      ),
      delegatedFrozenBalanceForEnergy: json.valueAsBigInt(
        'delegated_frozen_balance_for_energy',
      ),
      storageLimit: json.valueAsBigInt('storage_limit'),
      storageUsage: json.valueAsBigInt('storage_usage'),
      latestExchangeStorageTime: json.valueAsBigInt(
        'latest_exchange_storage_time',
      ),
      energyWindowSize: json.valueAsBigInt('energy_window_size'),
      delegatedFrozenV2BalanceForEnergy: json.valueAsBigInt(
        'delegated_frozenV2_balance_for_energy',
      ),
      acquiredDelegatedFrozenV2BalanceForEnergy: json.valueAsBigInt(
        'acquired_delegated_frozenV2_balance_for_energy',
      ),
      energyWindowOptimized: json.valueAsBool('energy_window_optimized'),
    );
  }

  Map<String, dynamic> toJson() => {
    'energy_usage': energyUsage,
    'frozen_balance_for_energy': frozenBalanceForEnergy?.toJson(),
    'latest_consume_time_for_energy': latestConsumeTimeForEnergy,
    'acquired_delegated_frozen_balance_for_energy':
        acquiredDelegatedFrozenBalanceForEnergy,
    'delegated_frozen_balance_for_energy': delegatedFrozenBalanceForEnergy,
    'storage_limit': storageLimit,
    'storage_usage': storageUsage,
    'latest_exchange_storage_time': latestExchangeStorageTime,
    'energy_window_size': energyWindowSize,
    'delegated_frozenV2_balance_for_energy': delegatedFrozenV2BalanceForEnergy,
    'acquired_delegated_frozenV2_balance_for_energy':
        acquiredDelegatedFrozenV2BalanceForEnergy,
    'energy_window_optimized': energyWindowOptimized,
  };
}

class TronHttpAccountAccountResourceInt64StringCompatible {
  final BigInt? energyUsage;
  final TronHttpAccountFrozenInt64StringCompatible? frozenBalanceForEnergy;
  final BigInt? latestConsumeTimeForEnergy;
  final BigInt? acquiredDelegatedFrozenBalanceForEnergy;
  final BigInt? delegatedFrozenBalanceForEnergy;
  final BigInt? storageLimit;
  final BigInt? storageUsage;
  final BigInt? latestExchangeStorageTime;
  final BigInt? energyWindowSize;
  final BigInt? delegatedFrozenV2BalanceForEnergy;
  final BigInt? acquiredDelegatedFrozenV2BalanceForEnergy;
  final bool? energyWindowOptimized;

  const TronHttpAccountAccountResourceInt64StringCompatible({
    this.energyUsage,
    this.frozenBalanceForEnergy,
    this.latestConsumeTimeForEnergy,
    this.acquiredDelegatedFrozenBalanceForEnergy,
    this.delegatedFrozenBalanceForEnergy,
    this.storageLimit,
    this.storageUsage,
    this.latestExchangeStorageTime,
    this.energyWindowSize,
    this.delegatedFrozenV2BalanceForEnergy,
    this.acquiredDelegatedFrozenV2BalanceForEnergy,
    this.energyWindowOptimized,
  });

  factory TronHttpAccountAccountResourceInt64StringCompatible.fromJson(
    Map<String, dynamic> json,
  ) {
    return TronHttpAccountAccountResourceInt64StringCompatible(
      energyUsage: json.valueAsBigInt('energy_usage'),
      frozenBalanceForEnergy: json.valueTo<
        TronHttpAccountFrozenInt64StringCompatible?,
        Map<String, dynamic>
      >(
        key: 'frozen_balance_for_energy',
        parse: (v) => TronHttpAccountFrozenInt64StringCompatible.fromJson(v),
      ),
      latestConsumeTimeForEnergy: json.valueAsBigInt(
        'latest_consume_time_for_energy',
      ),
      acquiredDelegatedFrozenBalanceForEnergy: json.valueAsBigInt(
        'acquired_delegated_frozen_balance_for_energy',
      ),
      delegatedFrozenBalanceForEnergy: json.valueAsBigInt(
        'delegated_frozen_balance_for_energy',
      ),
      storageLimit: json.valueAsBigInt('storage_limit'),
      storageUsage: json.valueAsBigInt('storage_usage'),
      latestExchangeStorageTime: json.valueAsBigInt(
        'latest_exchange_storage_time',
      ),
      energyWindowSize: json.valueAsBigInt('energy_window_size'),
      delegatedFrozenV2BalanceForEnergy: json.valueAsBigInt(
        'delegated_frozenV2_balance_for_energy',
      ),
      acquiredDelegatedFrozenV2BalanceForEnergy: json.valueAsBigInt(
        'acquired_delegated_frozenV2_balance_for_energy',
      ),
      energyWindowOptimized: json.valueAsBool('energy_window_optimized'),
    );
  }

  Map<String, dynamic> toJson() => {
    'energy_usage': energyUsage,
    'frozen_balance_for_energy': frozenBalanceForEnergy?.toJson(),
    'latest_consume_time_for_energy': latestConsumeTimeForEnergy,
    'acquired_delegated_frozen_balance_for_energy':
        acquiredDelegatedFrozenBalanceForEnergy,
    'delegated_frozen_balance_for_energy': delegatedFrozenBalanceForEnergy,
    'storage_limit': storageLimit,
    'storage_usage': storageUsage,
    'latest_exchange_storage_time': latestExchangeStorageTime,
    'energy_window_size': energyWindowSize,
    'delegated_frozenV2_balance_for_energy': delegatedFrozenV2BalanceForEnergy,
    'acquired_delegated_frozenV2_balance_for_energy':
        acquiredDelegatedFrozenV2BalanceForEnergy,
    'energy_window_optimized': energyWindowOptimized,
  };
}

/// Account identifier used by the query.
class TronHttpAccountBalanceAccountIdentifierRequest {
  /// Account or contract address accepted by this endpoint.
  final String address;

  const TronHttpAccountBalanceAccountIdentifierRequest({required this.address});

  factory TronHttpAccountBalanceAccountIdentifierRequest.fromJson(
    Map<String, dynamic> json,
  ) {
    return TronHttpAccountBalanceAccountIdentifierRequest(
      address:
          (json['address'] is num
              ? json['address'].toString()
              : json.valueAsString('address')),
    );
  }

  Map<String, dynamic> toJson() => {'address': address};
}

/// Block identifier used by the query.
class TronHttpAccountBalanceBlockIdentifierRequest {
  /// Block or transaction hash.
  final String hash;

  /// Block number or numeric query value.
  final BigInt? number;

  const TronHttpAccountBalanceBlockIdentifierRequest({
    required this.hash,
    this.number,
  });

  factory TronHttpAccountBalanceBlockIdentifierRequest.fromJson(
    Map<String, dynamic> json,
  ) {
    return TronHttpAccountBalanceBlockIdentifierRequest(
      hash:
          (json['hash'] is num
              ? json['hash'].toString()
              : json.valueAsString('hash')),
      number: json.valueAsBigInt('number'),
    );
  }

  Map<String, dynamic> toJson() => {'hash': hash, 'number': number};
}

class TronHttpAccountBalanceRequestRequest {
  final TronHttpAccountBalanceAccountIdentifierRequest accountIdentifier;
  final TronHttpAccountBalanceBlockIdentifierRequest blockIdentifier;

  /// When true, addresses are encoded in base58check; when false or omitted, addresses are hex-encoded.
  final bool? visible;

  const TronHttpAccountBalanceRequestRequest({
    required this.accountIdentifier,
    required this.blockIdentifier,
    this.visible,
  });

  factory TronHttpAccountBalanceRequestRequest.fromJson(
    Map<String, dynamic> json,
  ) {
    return TronHttpAccountBalanceRequestRequest(
      accountIdentifier: json.valueTo<
        TronHttpAccountBalanceAccountIdentifierRequest,
        Map<String, dynamic>
      >(
        key: 'account_identifier',
        parse:
            (v) => TronHttpAccountBalanceAccountIdentifierRequest.fromJson(v),
      ),
      blockIdentifier: json.valueTo<
        TronHttpAccountBalanceBlockIdentifierRequest,
        Map<String, dynamic>
      >(
        key: 'block_identifier',
        parse: (v) => TronHttpAccountBalanceBlockIdentifierRequest.fromJson(v),
      ),
      visible: json.valueAsBool('visible'),
    );
  }

  Map<String, dynamic> toJson() => {
    'account_identifier': accountIdentifier.toJson(),
    'block_identifier': blockIdentifier.toJson(),
    'visible': visible,
  };
}

class TronHttpAccountBalanceResponse {
  /// Resource amount in sun, where 1 TRX equals 1,000,000 sun.
  final BigInt? balance;
  final TronHttpBlockBalanceTraceBlockIdentifier? blockIdentifier;

  const TronHttpAccountBalanceResponse({this.balance, this.blockIdentifier});

  factory TronHttpAccountBalanceResponse.fromJson(Map<String, dynamic> json) {
    return TronHttpAccountBalanceResponse(
      balance: json.valueAsBigInt('balance'),
      blockIdentifier: json.valueTo<
        TronHttpBlockBalanceTraceBlockIdentifier?,
        Map<String, dynamic>
      >(
        key: 'block_identifier',
        parse: (v) => TronHttpBlockBalanceTraceBlockIdentifier.fromJson(v),
      ),
    );
  }

  Map<String, dynamic> toJson() => {
    'balance': balance,
    'block_identifier': blockIdentifier?.toJson(),
  };
}

class TronHttpAccountCreateContract {
  /// Address of the account that owns or initiates the request.
  final String? ownerAddress;

  /// Address of the account to create.
  final String? accountAddress;

  /// Account, contract, or resource type.
  final TronHttpAccountType? type;

  const TronHttpAccountCreateContract({
    this.ownerAddress,
    this.accountAddress,
    this.type,
  });

  factory TronHttpAccountCreateContract.fromJson(Map<String, dynamic> json) {
    return TronHttpAccountCreateContract(
      ownerAddress:
          (json['owner_address'] is num
              ? json['owner_address'].toString()
              : json.valueAsString('owner_address')),
      accountAddress:
          (json['account_address'] is num
              ? json['account_address'].toString()
              : json.valueAsString('account_address')),
      type:
          json.hasValue('type')
              ? TronHttpAccountType.fromJson(json['type'])
              : null,
    );
  }

  Map<String, dynamic> toJson() => {
    'owner_address': ownerAddress,
    'account_address': accountAddress,
    'type': type?.toJson(),
  };
}

class TronHttpAccountCreateContractRequest {
  /// Address of the account that owns or initiates the request.
  final String ownerAddress;

  /// Address of the account to create.
  final String accountAddress;

  /// Account type accepted as a Protobuf enum name or its numeric value.
  final TronHttpAccountCreateContractRequestType? type;

  /// When true, addresses are encoded in base58check; when false or omitted, addresses are hex-encoded.
  final bool? visible;

  /// Permission id used to sign the transaction with a non-owner account permission.
  final int? permissionId;

  const TronHttpAccountCreateContractRequest({
    required this.ownerAddress,
    required this.accountAddress,
    this.type,
    this.visible,
    this.permissionId,
  });

  factory TronHttpAccountCreateContractRequest.fromJson(
    Map<String, dynamic> json,
  ) {
    return TronHttpAccountCreateContractRequest(
      ownerAddress:
          (json['owner_address'] is num
              ? json['owner_address'].toString()
              : json.valueAsString('owner_address')),
      accountAddress:
          (json['account_address'] is num
              ? json['account_address'].toString()
              : json.valueAsString('account_address')),
      type:
          json.hasValue('type')
              ? TronHttpAccountCreateContractRequestType.fromJson(json['type'])
              : null,
      visible: json.valueAsBool('visible'),
      permissionId: json.valueAsInt('Permission_id'),
    );
  }

  Map<String, dynamic> toJson() => {
    'owner_address': ownerAddress,
    'account_address': accountAddress,
    'type': type?.toJson(),
    'visible': visible,
    'Permission_id': permissionId,
  };
}

class TronHttpAccountFreezeV2 {
  /// Account, contract, or resource type.
  final TronHttpAccountFreezeV2Type? type;

  /// Amount in sun, where 1 TRX equals 1,000,000 sun.
  final BigInt? amount;

  const TronHttpAccountFreezeV2({this.type, this.amount});

  factory TronHttpAccountFreezeV2.fromJson(Map<String, dynamic> json) {
    return TronHttpAccountFreezeV2(
      type:
          json.hasValue('type')
              ? TronHttpAccountFreezeV2Type.fromJson(json['type'])
              : null,
      amount: json.valueAsBigInt('amount'),
    );
  }

  Map<String, dynamic> toJson() => {'type': type?.toJson(), 'amount': amount};
}

class TronHttpAccountFreezeV2Int64StringCompatible {
  /// Account, contract, or resource type.
  final TronHttpAccountFreezeV2Type? type;

  /// Amount in sun, where 1 TRX equals 1,000,000 sun.
  final BigInt? amount;

  const TronHttpAccountFreezeV2Int64StringCompatible({this.type, this.amount});

  factory TronHttpAccountFreezeV2Int64StringCompatible.fromJson(
    Map<String, dynamic> json,
  ) {
    return TronHttpAccountFreezeV2Int64StringCompatible(
      type:
          json.hasValue('type')
              ? TronHttpAccountFreezeV2Type.fromJson(json['type'])
              : null,
      amount: json.valueAsBigInt('amount'),
    );
  }

  Map<String, dynamic> toJson() => {'type': type?.toJson(), 'amount': amount};
}

class TronHttpAccountFrozen {
  /// Amount to freeze in sun, where 1 TRX equals 1,000,000 sun.
  final BigInt? frozenBalance;
  final BigInt? expireTime;

  const TronHttpAccountFrozen({this.frozenBalance, this.expireTime});

  factory TronHttpAccountFrozen.fromJson(Map<String, dynamic> json) {
    return TronHttpAccountFrozen(
      frozenBalance: json.valueAsBigInt('frozen_balance'),
      expireTime: json.valueAsBigInt('expire_time'),
    );
  }

  Map<String, dynamic> toJson() => {
    'frozen_balance': frozenBalance,
    'expire_time': expireTime,
  };
}

class TronHttpAccountFrozenInt64StringCompatible {
  /// Amount to freeze in sun, where 1 TRX equals 1,000,000 sun.
  final BigInt? frozenBalance;
  final BigInt? expireTime;

  const TronHttpAccountFrozenInt64StringCompatible({
    this.frozenBalance,
    this.expireTime,
  });

  factory TronHttpAccountFrozenInt64StringCompatible.fromJson(
    Map<String, dynamic> json,
  ) {
    return TronHttpAccountFrozenInt64StringCompatible(
      frozenBalance: json.valueAsBigInt('frozen_balance'),
      expireTime: json.valueAsBigInt('expire_time'),
    );
  }

  Map<String, dynamic> toJson() => {
    'frozen_balance': frozenBalance,
    'expire_time': expireTime,
  };
}

class TronHttpAccountId {
  /// Name encoded as expected by java-tron.
  final String? name;

  /// Account or contract address accepted by this endpoint.
  final String? address;

  const TronHttpAccountId({this.name, this.address});

  factory TronHttpAccountId.fromJson(Map<String, dynamic> json) {
    return TronHttpAccountId(
      name:
          (json['name'] is num
              ? json['name'].toString()
              : json.valueAsString('name')),
      address:
          (json['address'] is num
              ? json['address'].toString()
              : json.valueAsString('address')),
    );
  }

  Map<String, dynamic> toJson() => {'name': name, 'address': address};
}

class TronHttpAccountInt64StringCompatible {
  /// New account name encoded as expected by java-tron.
  final String? accountName;

  /// Account, contract, or resource type.
  final TronHttpAccountType? type;

  /// Account or contract address accepted by this endpoint.
  final String? address;

  /// Resource amount in sun, where 1 TRX equals 1,000,000 sun.
  final BigInt? balance;

  /// Witness vote entries.
  final List<TronHttpVoteInt64StringCompatible>? votes;
  final List<TronHttpAccountFrozenInt64StringCompatible>? frozen;
  final BigInt? netUsage;
  final BigInt? acquiredDelegatedFrozenBalanceForBandwidth;
  final BigInt? delegatedFrozenBalanceForBandwidth;
  final BigInt? oldTronPower;
  final TronHttpAccountFrozenInt64StringCompatible? tronPower;
  final bool? assetOptimized;
  final BigInt? createTime;
  final BigInt? latestOprationTime;
  final BigInt? allowance;
  final BigInt? latestWithdrawTime;
  final String? code;
  final bool? isWitness;
  final bool? isCommittee;

  /// Frozen supply schedules for an asset issue.
  final List<TronHttpAccountFrozenInt64StringCompatible>? frozenSupply;
  final String? assetIssuedName;
  final String? assetIssuedID;
  final BigInt? freeNetUsage;
  final BigInt? latestConsumeTime;
  final BigInt? latestConsumeFreeTime;
  final String? accountId;
  final BigInt? netWindowSize;
  final bool? netWindowOptimized;
  final TronHttpAccountAccountResourceInt64StringCompatible? accountResource;
  final String? codeHash;
  final TronHttpPermissionInt64StringCompatible? ownerPermission;
  final TronHttpPermissionInt64StringCompatible? witnessPermission;
  final List<TronHttpPermissionInt64StringCompatible>? activePermission;
  final List<TronHttpAccountFreezeV2Int64StringCompatible>? frozenV2;
  final List<TronHttpAccountUnFreezeV2Int64StringCompatible>? unfrozenV2;
  final BigInt? delegatedFrozenV2BalanceForBandwidth;
  final BigInt? acquiredDelegatedFrozenV2BalanceForBandwidth;
  final Map<String, BigInt>? asset;
  final Map<String, BigInt>? assetV2;
  final Map<String, BigInt>? latestAssetOperationTime;
  final Map<String, BigInt>? latestAssetOperationTimeV2;
  final Map<String, BigInt>? freeAssetNetUsage;
  final Map<String, BigInt>? freeAssetNetUsageV2;

  const TronHttpAccountInt64StringCompatible({
    this.accountName,
    this.type,
    this.address,
    this.balance,
    this.votes,
    this.frozen,
    this.netUsage,
    this.acquiredDelegatedFrozenBalanceForBandwidth,
    this.delegatedFrozenBalanceForBandwidth,
    this.oldTronPower,
    this.tronPower,
    this.assetOptimized,
    this.createTime,
    this.latestOprationTime,
    this.allowance,
    this.latestWithdrawTime,
    this.code,
    this.isWitness,
    this.isCommittee,
    this.frozenSupply,
    this.assetIssuedName,
    this.assetIssuedID,
    this.freeNetUsage,
    this.latestConsumeTime,
    this.latestConsumeFreeTime,
    this.accountId,
    this.netWindowSize,
    this.netWindowOptimized,
    this.accountResource,
    this.codeHash,
    this.ownerPermission,
    this.witnessPermission,
    this.activePermission,
    this.frozenV2,
    this.unfrozenV2,
    this.delegatedFrozenV2BalanceForBandwidth,
    this.acquiredDelegatedFrozenV2BalanceForBandwidth,
    this.asset,
    this.assetV2,
    this.latestAssetOperationTime,
    this.latestAssetOperationTimeV2,
    this.freeAssetNetUsage,
    this.freeAssetNetUsageV2,
  });

  factory TronHttpAccountInt64StringCompatible.fromJson(
    Map<String, dynamic> json,
  ) {
    return TronHttpAccountInt64StringCompatible(
      accountName:
          (json['account_name'] is num
              ? json['account_name'].toString()
              : json.valueAsString('account_name')),
      type:
          json.hasValue('type')
              ? TronHttpAccountType.fromJson(json['type'])
              : null,
      address:
          (json['address'] is num
              ? json['address'].toString()
              : json.valueAsString('address')),
      balance: json.valueAsBigInt('balance'),
      votes:
          json.hasValue('votes')
              ? json
                  .valueEnsureAsList<Map<String, dynamic>>('votes')
                  .map((e) => TronHttpVoteInt64StringCompatible.fromJson(e))
                  .toList()
              : null,
      frozen:
          json.hasValue('frozen')
              ? json
                  .valueEnsureAsList<Map<String, dynamic>>('frozen')
                  .map(
                    (e) =>
                        TronHttpAccountFrozenInt64StringCompatible.fromJson(e),
                  )
                  .toList()
              : null,
      netUsage: json.valueAsBigInt('net_usage'),
      acquiredDelegatedFrozenBalanceForBandwidth: json.valueAsBigInt(
        'acquired_delegated_frozen_balance_for_bandwidth',
      ),
      delegatedFrozenBalanceForBandwidth: json.valueAsBigInt(
        'delegated_frozen_balance_for_bandwidth',
      ),
      oldTronPower: json.valueAsBigInt('old_tron_power'),
      tronPower: json.valueTo<
        TronHttpAccountFrozenInt64StringCompatible?,
        Map<String, dynamic>
      >(
        key: 'tron_power',
        parse: (v) => TronHttpAccountFrozenInt64StringCompatible.fromJson(v),
      ),
      assetOptimized: json.valueAsBool('asset_optimized'),
      createTime: json.valueAsBigInt('create_time'),
      latestOprationTime: json.valueAsBigInt('latest_opration_time'),
      allowance: json.valueAsBigInt('allowance'),
      latestWithdrawTime: json.valueAsBigInt('latest_withdraw_time'),
      code:
          (json['code'] is num
              ? json['code'].toString()
              : json.valueAsString('code')),
      isWitness: json.valueAsBool('is_witness'),
      isCommittee: json.valueAsBool('is_committee'),
      frozenSupply:
          json.hasValue('frozen_supply')
              ? json
                  .valueEnsureAsList<Map<String, dynamic>>('frozen_supply')
                  .map(
                    (e) =>
                        TronHttpAccountFrozenInt64StringCompatible.fromJson(e),
                  )
                  .toList()
              : null,
      assetIssuedName:
          (json['asset_issued_name'] is num
              ? json['asset_issued_name'].toString()
              : json.valueAsString('asset_issued_name')),
      assetIssuedID:
          (json['asset_issued_ID'] is num
              ? json['asset_issued_ID'].toString()
              : json.valueAsString('asset_issued_ID')),
      freeNetUsage: json.valueAsBigInt('free_net_usage'),
      latestConsumeTime: json.valueAsBigInt('latest_consume_time'),
      latestConsumeFreeTime: json.valueAsBigInt('latest_consume_free_time'),
      accountId:
          (json['account_id'] is num
              ? json['account_id'].toString()
              : json.valueAsString('account_id')),
      netWindowSize: json.valueAsBigInt('net_window_size'),
      netWindowOptimized: json.valueAsBool('net_window_optimized'),
      accountResource: json.valueTo<
        TronHttpAccountAccountResourceInt64StringCompatible?,
        Map<String, dynamic>
      >(
        key: 'account_resource',
        parse:
            (v) =>
                TronHttpAccountAccountResourceInt64StringCompatible.fromJson(v),
      ),
      codeHash:
          (json['codeHash'] is num
              ? json['codeHash'].toString()
              : json.valueAsString('codeHash')),
      ownerPermission: json.valueTo<
        TronHttpPermissionInt64StringCompatible?,
        Map<String, dynamic>
      >(
        key: 'owner_permission',
        parse: (v) => TronHttpPermissionInt64StringCompatible.fromJson(v),
      ),
      witnessPermission: json.valueTo<
        TronHttpPermissionInt64StringCompatible?,
        Map<String, dynamic>
      >(
        key: 'witness_permission',
        parse: (v) => TronHttpPermissionInt64StringCompatible.fromJson(v),
      ),
      activePermission:
          json.hasValue('active_permission')
              ? json
                  .valueEnsureAsList<Map<String, dynamic>>('active_permission')
                  .map(
                    (e) => TronHttpPermissionInt64StringCompatible.fromJson(e),
                  )
                  .toList()
              : null,
      frozenV2:
          json.hasValue('frozenV2')
              ? json
                  .valueEnsureAsList<Map<String, dynamic>>('frozenV2')
                  .map(
                    (e) =>
                        TronHttpAccountFreezeV2Int64StringCompatible.fromJson(
                          e,
                        ),
                  )
                  .toList()
              : null,
      unfrozenV2:
          json.hasValue('unfrozenV2')
              ? json
                  .valueEnsureAsList<Map<String, dynamic>>('unfrozenV2')
                  .map(
                    (e) =>
                        TronHttpAccountUnFreezeV2Int64StringCompatible.fromJson(
                          e,
                        ),
                  )
                  .toList()
              : null,
      delegatedFrozenV2BalanceForBandwidth: json.valueAsBigInt(
        'delegated_frozenV2_balance_for_bandwidth',
      ),
      acquiredDelegatedFrozenV2BalanceForBandwidth: json.valueAsBigInt(
        'acquired_delegated_frozenV2_balance_for_bandwidth',
      ),
      asset:
          json.hasValue('asset')
              ? _tronMapFromJson<BigInt>(
                json['asset'],
                JsonParser.valueAsBigInt<BigInt>,
              )
              : null,
      assetV2:
          json.hasValue('assetV2')
              ? _tronMapFromJson<BigInt>(
                json['assetV2'],
                JsonParser.valueAsBigInt<BigInt>,
              )
              : null,
      latestAssetOperationTime:
          json.hasValue('latest_asset_operation_time')
              ? _tronMapFromJson<BigInt>(
                json['latest_asset_operation_time'],
                JsonParser.valueAsBigInt<BigInt>,
              )
              : null,
      latestAssetOperationTimeV2:
          json.hasValue('latest_asset_operation_timeV2')
              ? _tronMapFromJson<BigInt>(
                json['latest_asset_operation_timeV2'],
                JsonParser.valueAsBigInt<BigInt>,
              )
              : null,
      freeAssetNetUsage:
          json.hasValue('free_asset_net_usage')
              ? _tronMapFromJson<BigInt>(
                json['free_asset_net_usage'],
                JsonParser.valueAsBigInt<BigInt>,
              )
              : null,
      freeAssetNetUsageV2:
          json.hasValue('free_asset_net_usageV2')
              ? _tronMapFromJson<BigInt>(
                json['free_asset_net_usageV2'],
                JsonParser.valueAsBigInt<BigInt>,
              )
              : null,
    );
  }

  Map<String, dynamic> toJson() => {
    'account_name': accountName,
    'type': type?.toJson(),
    'address': address,
    'balance': balance,
    'votes': votes?.map((e) => e.toJson()).toList(),
    'frozen': frozen?.map((e) => e.toJson()).toList(),
    'net_usage': netUsage,
    'acquired_delegated_frozen_balance_for_bandwidth':
        acquiredDelegatedFrozenBalanceForBandwidth,
    'delegated_frozen_balance_for_bandwidth':
        delegatedFrozenBalanceForBandwidth,
    'old_tron_power': oldTronPower,
    'tron_power': tronPower?.toJson(),
    'asset_optimized': assetOptimized,
    'create_time': createTime,
    'latest_opration_time': latestOprationTime,
    'allowance': allowance,
    'latest_withdraw_time': latestWithdrawTime,
    'code': code,
    'is_witness': isWitness,
    'is_committee': isCommittee,
    'frozen_supply': frozenSupply?.map((e) => e.toJson()).toList(),
    'asset_issued_name': assetIssuedName,
    'asset_issued_ID': assetIssuedID,
    'free_net_usage': freeNetUsage,
    'latest_consume_time': latestConsumeTime,
    'latest_consume_free_time': latestConsumeFreeTime,
    'account_id': accountId,
    'net_window_size': netWindowSize,
    'net_window_optimized': netWindowOptimized,
    'account_resource': accountResource?.toJson(),
    'codeHash': codeHash,
    'owner_permission': ownerPermission?.toJson(),
    'witness_permission': witnessPermission?.toJson(),
    'active_permission': activePermission?.map((e) => e.toJson()).toList(),
    'frozenV2': frozenV2?.map((e) => e.toJson()).toList(),
    'unfrozenV2': unfrozenV2?.map((e) => e.toJson()).toList(),
    'delegated_frozenV2_balance_for_bandwidth':
        delegatedFrozenV2BalanceForBandwidth,
    'acquired_delegated_frozenV2_balance_for_bandwidth':
        acquiredDelegatedFrozenV2BalanceForBandwidth,
    'asset': asset == null ? null : _tronMapToJson(asset!),
    'assetV2': assetV2 == null ? null : _tronMapToJson(assetV2!),
    'latest_asset_operation_time':
        latestAssetOperationTime == null
            ? null
            : _tronMapToJson(latestAssetOperationTime!),
    'latest_asset_operation_timeV2':
        latestAssetOperationTimeV2 == null
            ? null
            : _tronMapToJson(latestAssetOperationTimeV2!),
    'free_asset_net_usage':
        freeAssetNetUsage == null ? null : _tronMapToJson(freeAssetNetUsage!),
    'free_asset_net_usageV2':
        freeAssetNetUsageV2 == null
            ? null
            : _tronMapToJson(freeAssetNetUsageV2!),
  };
}

class TronHttpAccountNetMessage {
  final BigInt? freeNetUsed;
  final BigInt? freeNetLimit;
  final BigInt? netUsed;
  final BigInt? netLimit;
  final BigInt? totalNetLimit;
  final BigInt? totalNetWeight;
  final Map<String, BigInt>? assetNetUsed;
  final Map<String, BigInt>? assetNetLimit;

  const TronHttpAccountNetMessage({
    this.freeNetUsed,
    this.freeNetLimit,
    this.netUsed,
    this.netLimit,
    this.totalNetLimit,
    this.totalNetWeight,
    this.assetNetUsed,
    this.assetNetLimit,
  });

  factory TronHttpAccountNetMessage.fromJson(Map<String, dynamic> json) {
    return TronHttpAccountNetMessage(
      freeNetUsed: json.valueAsBigInt('freeNetUsed'),
      freeNetLimit: json.valueAsBigInt('freeNetLimit'),
      netUsed: json.valueAsBigInt('NetUsed'),
      netLimit: json.valueAsBigInt('NetLimit'),
      totalNetLimit: json.valueAsBigInt('TotalNetLimit'),
      totalNetWeight: json.valueAsBigInt('TotalNetWeight'),
      assetNetUsed:
          json.hasValue('assetNetUsed')
              ? _tronMapFromJson<BigInt>(
                json['assetNetUsed'],
                JsonParser.valueAsBigInt<BigInt>,
              )
              : null,
      assetNetLimit:
          json.hasValue('assetNetLimit')
              ? _tronMapFromJson<BigInt>(
                json['assetNetLimit'],
                JsonParser.valueAsBigInt<BigInt>,
              )
              : null,
    );
  }

  Map<String, dynamic> toJson() => {
    'freeNetUsed': freeNetUsed,
    'freeNetLimit': freeNetLimit,
    'NetUsed': netUsed,
    'NetLimit': netLimit,
    'TotalNetLimit': totalNetLimit,
    'TotalNetWeight': totalNetWeight,
    'assetNetUsed': assetNetUsed == null ? null : _tronMapToJson(assetNetUsed!),
    'assetNetLimit':
        assetNetLimit == null ? null : _tronMapToJson(assetNetLimit!),
  };
}

class TronHttpAccountNetMessageInt64StringCompatible {
  final BigInt? freeNetUsed;
  final BigInt? freeNetLimit;
  final BigInt? netUsed;
  final BigInt? netLimit;
  final BigInt? totalNetLimit;
  final BigInt? totalNetWeight;
  final Map<String, BigInt>? assetNetUsed;
  final Map<String, BigInt>? assetNetLimit;

  const TronHttpAccountNetMessageInt64StringCompatible({
    this.freeNetUsed,
    this.freeNetLimit,
    this.netUsed,
    this.netLimit,
    this.totalNetLimit,
    this.totalNetWeight,
    this.assetNetUsed,
    this.assetNetLimit,
  });

  factory TronHttpAccountNetMessageInt64StringCompatible.fromJson(
    Map<String, dynamic> json,
  ) {
    return TronHttpAccountNetMessageInt64StringCompatible(
      freeNetUsed: json.valueAsBigInt('freeNetUsed'),
      freeNetLimit: json.valueAsBigInt('freeNetLimit'),
      netUsed: json.valueAsBigInt('NetUsed'),
      netLimit: json.valueAsBigInt('NetLimit'),
      totalNetLimit: json.valueAsBigInt('TotalNetLimit'),
      totalNetWeight: json.valueAsBigInt('TotalNetWeight'),
      assetNetUsed:
          json.hasValue('assetNetUsed')
              ? _tronMapFromJson<BigInt>(
                json['assetNetUsed'],
                JsonParser.valueAsBigInt<BigInt>,
              )
              : null,
      assetNetLimit:
          json.hasValue('assetNetLimit')
              ? _tronMapFromJson<BigInt>(
                json['assetNetLimit'],
                JsonParser.valueAsBigInt<BigInt>,
              )
              : null,
    );
  }

  Map<String, dynamic> toJson() => {
    'freeNetUsed': freeNetUsed,
    'freeNetLimit': freeNetLimit,
    'NetUsed': netUsed,
    'NetLimit': netLimit,
    'TotalNetLimit': totalNetLimit,
    'TotalNetWeight': totalNetWeight,
    'assetNetUsed': assetNetUsed == null ? null : _tronMapToJson(assetNetUsed!),
    'assetNetLimit':
        assetNetLimit == null ? null : _tronMapToJson(assetNetLimit!),
  };
}

class TronHttpAccountPermissionUpdateContract {
  /// Address of the account that owns or initiates the request.
  final String? ownerAddress;
  final TronHttpPermission? owner;
  final TronHttpPermission? witness;

  /// Active permission definitions for account permission update.
  final List<TronHttpPermission>? actives;

  const TronHttpAccountPermissionUpdateContract({
    this.ownerAddress,
    this.owner,
    this.witness,
    this.actives,
  });

  factory TronHttpAccountPermissionUpdateContract.fromJson(
    Map<String, dynamic> json,
  ) {
    return TronHttpAccountPermissionUpdateContract(
      ownerAddress:
          (json['owner_address'] is num
              ? json['owner_address'].toString()
              : json.valueAsString('owner_address')),
      owner: json.valueTo<TronHttpPermission?, Map<String, dynamic>>(
        key: 'owner',
        parse: (v) => TronHttpPermission.fromJson(v),
      ),
      witness: json.valueTo<TronHttpPermission?, Map<String, dynamic>>(
        key: 'witness',
        parse: (v) => TronHttpPermission.fromJson(v),
      ),
      actives:
          json.hasValue('actives')
              ? json
                  .valueEnsureAsList<Map<String, dynamic>>('actives')
                  .map((e) => TronHttpPermission.fromJson(e))
                  .toList()
              : null,
    );
  }

  Map<String, dynamic> toJson() => {
    'owner_address': ownerAddress,
    'owner': owner?.toJson(),
    'witness': witness?.toJson(),
    'actives': actives?.map((e) => e.toJson()).toList(),
  };
}

class TronHttpAccountPermissionUpdateContractInt64StringCompatible {
  /// Address of the account that owns or initiates the request.
  final String? ownerAddress;
  final TronHttpPermissionInt64StringCompatible? owner;
  final TronHttpPermissionInt64StringCompatible? witness;

  /// Active permission definitions for account permission update.
  final List<TronHttpPermissionInt64StringCompatible>? actives;

  const TronHttpAccountPermissionUpdateContractInt64StringCompatible({
    this.ownerAddress,
    this.owner,
    this.witness,
    this.actives,
  });

  factory TronHttpAccountPermissionUpdateContractInt64StringCompatible.fromJson(
    Map<String, dynamic> json,
  ) {
    return TronHttpAccountPermissionUpdateContractInt64StringCompatible(
      ownerAddress:
          (json['owner_address'] is num
              ? json['owner_address'].toString()
              : json.valueAsString('owner_address')),
      owner: json.valueTo<
        TronHttpPermissionInt64StringCompatible?,
        Map<String, dynamic>
      >(
        key: 'owner',
        parse: (v) => TronHttpPermissionInt64StringCompatible.fromJson(v),
      ),
      witness: json.valueTo<
        TronHttpPermissionInt64StringCompatible?,
        Map<String, dynamic>
      >(
        key: 'witness',
        parse: (v) => TronHttpPermissionInt64StringCompatible.fromJson(v),
      ),
      actives:
          json.hasValue('actives')
              ? json
                  .valueEnsureAsList<Map<String, dynamic>>('actives')
                  .map(
                    (e) => TronHttpPermissionInt64StringCompatible.fromJson(e),
                  )
                  .toList()
              : null,
    );
  }

  Map<String, dynamic> toJson() => {
    'owner_address': ownerAddress,
    'owner': owner?.toJson(),
    'witness': witness?.toJson(),
    'actives': actives?.map((e) => e.toJson()).toList(),
  };
}

class TronHttpAccountPermissionUpdateContractRequest {
  /// Address of the account that owns or initiates the request.
  final String ownerAddress;
  final TronHttpPermission owner;
  final TronHttpPermission? witness;

  /// Active permission definitions for account permission update.
  final List<TronHttpPermission> actives;

  /// When true, addresses are encoded in base58check; when false or omitted, addresses are hex-encoded.
  final bool? visible;

  /// Permission id used to sign the transaction with a non-owner account permission.
  final int? permissionId;

  const TronHttpAccountPermissionUpdateContractRequest({
    required this.ownerAddress,
    required this.owner,
    this.witness,
    required this.actives,
    this.visible,
    this.permissionId,
  });

  factory TronHttpAccountPermissionUpdateContractRequest.fromJson(
    Map<String, dynamic> json,
  ) {
    return TronHttpAccountPermissionUpdateContractRequest(
      ownerAddress:
          (json['owner_address'] is num
              ? json['owner_address'].toString()
              : json.valueAsString('owner_address')),
      owner: json.valueTo<TronHttpPermission, Map<String, dynamic>>(
        key: 'owner',
        parse: (v) => TronHttpPermission.fromJson(v),
      ),
      witness: json.valueTo<TronHttpPermission?, Map<String, dynamic>>(
        key: 'witness',
        parse: (v) => TronHttpPermission.fromJson(v),
      ),
      actives:
          json
              .valueEnsureAsList<Map<String, dynamic>>('actives')
              .map((e) => TronHttpPermission.fromJson(e))
              .toList(),
      visible: json.valueAsBool('visible'),
      permissionId: json.valueAsInt('Permission_id'),
    );
  }

  Map<String, dynamic> toJson() => {
    'owner_address': ownerAddress,
    'owner': owner.toJson(),
    'witness': witness?.toJson(),
    'actives': actives.map((e) => e.toJson()).toList(),
    'visible': visible,
    'Permission_id': permissionId,
  };
}

/// POST /wallet/getaccount (request)
/// POST /wallet/getaccountnet (request)
/// POST /wallet/getassetissuebyaccount (request)
class TronHttpAccountRequest {
  /// Account or contract address accepted by this endpoint.
  final String? address;

  /// When true, addresses are encoded in base58check; when false or omitted, addresses are hex-encoded.
  final bool? visible;

  const TronHttpAccountRequest({this.address, this.visible});

  factory TronHttpAccountRequest.fromJson(Map<String, dynamic> json) {
    return TronHttpAccountRequest(
      address:
          (json['address'] is num
              ? json['address'].toString()
              : json.valueAsString('address')),
      visible: json.valueAsBool('visible'),
    );
  }

  Map<String, dynamic> toJson() => {'address': address, 'visible': visible};
}

class TronHttpAccountResourceMessage {
  final BigInt? freeNetUsed;
  final BigInt? freeNetLimit;
  final BigInt? netUsed;
  final BigInt? netLimit;
  final BigInt? totalNetLimit;
  final BigInt? totalNetWeight;
  final BigInt? totalTronPowerWeight;
  final BigInt? tronPowerUsed;
  final BigInt? tronPowerLimit;
  final BigInt? energyUsed;
  final BigInt? energyLimit;
  final BigInt? totalEnergyLimit;
  final BigInt? totalEnergyWeight;
  final BigInt? storageUsed;
  final BigInt? storageLimit;
  final Map<String, BigInt>? assetNetUsed;
  final Map<String, BigInt>? assetNetLimit;

  const TronHttpAccountResourceMessage({
    this.freeNetUsed,
    this.freeNetLimit,
    this.netUsed,
    this.netLimit,
    this.totalNetLimit,
    this.totalNetWeight,
    this.totalTronPowerWeight,
    this.tronPowerUsed,
    this.tronPowerLimit,
    this.energyUsed,
    this.energyLimit,
    this.totalEnergyLimit,
    this.totalEnergyWeight,
    this.storageUsed,
    this.storageLimit,
    this.assetNetUsed,
    this.assetNetLimit,
  });

  factory TronHttpAccountResourceMessage.fromJson(Map<String, dynamic> json) {
    return TronHttpAccountResourceMessage(
      freeNetUsed: json.valueAsBigInt('freeNetUsed'),
      freeNetLimit: json.valueAsBigInt('freeNetLimit'),
      netUsed: json.valueAsBigInt('NetUsed'),
      netLimit: json.valueAsBigInt('NetLimit'),
      totalNetLimit: json.valueAsBigInt('TotalNetLimit'),
      totalNetWeight: json.valueAsBigInt('TotalNetWeight'),
      totalTronPowerWeight: json.valueAsBigInt('TotalTronPowerWeight'),
      tronPowerUsed: json.valueAsBigInt('tronPowerUsed'),
      tronPowerLimit: json.valueAsBigInt('tronPowerLimit'),
      energyUsed: json.valueAsBigInt('EnergyUsed'),
      energyLimit: json.valueAsBigInt('EnergyLimit'),
      totalEnergyLimit: json.valueAsBigInt('TotalEnergyLimit'),
      totalEnergyWeight: json.valueAsBigInt('TotalEnergyWeight'),
      storageUsed: json.valueAsBigInt('storageUsed'),
      storageLimit: json.valueAsBigInt('storageLimit'),
      assetNetUsed:
          json.hasValue('assetNetUsed')
              ? _tronMapFromJson<BigInt>(
                json['assetNetUsed'],
                JsonParser.valueAsBigInt<BigInt>,
              )
              : null,
      assetNetLimit:
          json.hasValue('assetNetLimit')
              ? _tronMapFromJson<BigInt>(
                json['assetNetLimit'],
                JsonParser.valueAsBigInt<BigInt>,
              )
              : null,
    );
  }

  Map<String, dynamic> toJson() => {
    'freeNetUsed': freeNetUsed,
    'freeNetLimit': freeNetLimit,
    'NetUsed': netUsed,
    'NetLimit': netLimit,
    'TotalNetLimit': totalNetLimit,
    'TotalNetWeight': totalNetWeight,
    'TotalTronPowerWeight': totalTronPowerWeight,
    'tronPowerUsed': tronPowerUsed,
    'tronPowerLimit': tronPowerLimit,
    'EnergyUsed': energyUsed,
    'EnergyLimit': energyLimit,
    'TotalEnergyLimit': totalEnergyLimit,
    'TotalEnergyWeight': totalEnergyWeight,
    'storageUsed': storageUsed,
    'storageLimit': storageLimit,
    'assetNetUsed': assetNetUsed == null ? null : _tronMapToJson(assetNetUsed!),
    'assetNetLimit':
        assetNetLimit == null ? null : _tronMapToJson(assetNetLimit!),
  };
}

class TronHttpAccountResourceMessageInt64StringCompatible {
  final BigInt? freeNetUsed;
  final BigInt? freeNetLimit;
  final BigInt? netUsed;
  final BigInt? netLimit;
  final BigInt? totalNetLimit;
  final BigInt? totalNetWeight;
  final BigInt? totalTronPowerWeight;
  final BigInt? tronPowerUsed;
  final BigInt? tronPowerLimit;
  final BigInt? energyUsed;
  final BigInt? energyLimit;
  final BigInt? totalEnergyLimit;
  final BigInt? totalEnergyWeight;
  final BigInt? storageUsed;
  final BigInt? storageLimit;
  final Map<String, BigInt>? assetNetUsed;
  final Map<String, BigInt>? assetNetLimit;

  const TronHttpAccountResourceMessageInt64StringCompatible({
    this.freeNetUsed,
    this.freeNetLimit,
    this.netUsed,
    this.netLimit,
    this.totalNetLimit,
    this.totalNetWeight,
    this.totalTronPowerWeight,
    this.tronPowerUsed,
    this.tronPowerLimit,
    this.energyUsed,
    this.energyLimit,
    this.totalEnergyLimit,
    this.totalEnergyWeight,
    this.storageUsed,
    this.storageLimit,
    this.assetNetUsed,
    this.assetNetLimit,
  });

  factory TronHttpAccountResourceMessageInt64StringCompatible.fromJson(
    Map<String, dynamic> json,
  ) {
    return TronHttpAccountResourceMessageInt64StringCompatible(
      freeNetUsed: json.valueAsBigInt('freeNetUsed'),
      freeNetLimit: json.valueAsBigInt('freeNetLimit'),
      netUsed: json.valueAsBigInt('NetUsed'),
      netLimit: json.valueAsBigInt('NetLimit'),
      totalNetLimit: json.valueAsBigInt('TotalNetLimit'),
      totalNetWeight: json.valueAsBigInt('TotalNetWeight'),
      totalTronPowerWeight: json.valueAsBigInt('TotalTronPowerWeight'),
      tronPowerUsed: json.valueAsBigInt('tronPowerUsed'),
      tronPowerLimit: json.valueAsBigInt('tronPowerLimit'),
      energyUsed: json.valueAsBigInt('EnergyUsed'),
      energyLimit: json.valueAsBigInt('EnergyLimit'),
      totalEnergyLimit: json.valueAsBigInt('TotalEnergyLimit'),
      totalEnergyWeight: json.valueAsBigInt('TotalEnergyWeight'),
      storageUsed: json.valueAsBigInt('storageUsed'),
      storageLimit: json.valueAsBigInt('storageLimit'),
      assetNetUsed:
          json.hasValue('assetNetUsed')
              ? _tronMapFromJson<BigInt>(
                json['assetNetUsed'],
                JsonParser.valueAsBigInt<BigInt>,
              )
              : null,
      assetNetLimit:
          json.hasValue('assetNetLimit')
              ? _tronMapFromJson<BigInt>(
                json['assetNetLimit'],
                JsonParser.valueAsBigInt<BigInt>,
              )
              : null,
    );
  }

  Map<String, dynamic> toJson() => {
    'freeNetUsed': freeNetUsed,
    'freeNetLimit': freeNetLimit,
    'NetUsed': netUsed,
    'NetLimit': netLimit,
    'TotalNetLimit': totalNetLimit,
    'TotalNetWeight': totalNetWeight,
    'TotalTronPowerWeight': totalTronPowerWeight,
    'tronPowerUsed': tronPowerUsed,
    'tronPowerLimit': tronPowerLimit,
    'EnergyUsed': energyUsed,
    'EnergyLimit': energyLimit,
    'TotalEnergyLimit': totalEnergyLimit,
    'TotalEnergyWeight': totalEnergyWeight,
    'storageUsed': storageUsed,
    'storageLimit': storageLimit,
    'assetNetUsed': assetNetUsed == null ? null : _tronMapToJson(assetNetUsed!),
    'assetNetLimit':
        assetNetLimit == null ? null : _tronMapToJson(assetNetLimit!),
  };
}

class TronHttpAccountUnFreezeV2 {
  /// Account, contract, or resource type.
  final TronHttpAccountFreezeV2Type? type;
  final BigInt? unfreezeAmount;
  final BigInt? unfreezeExpireTime;

  const TronHttpAccountUnFreezeV2({
    this.type,
    this.unfreezeAmount,
    this.unfreezeExpireTime,
  });

  factory TronHttpAccountUnFreezeV2.fromJson(Map<String, dynamic> json) {
    return TronHttpAccountUnFreezeV2(
      type:
          json.hasValue('type')
              ? TronHttpAccountFreezeV2Type.fromJson(json['type'])
              : null,
      unfreezeAmount: json.valueAsBigInt('unfreeze_amount'),
      unfreezeExpireTime: json.valueAsBigInt('unfreeze_expire_time'),
    );
  }

  Map<String, dynamic> toJson() => {
    'type': type?.toJson(),
    'unfreeze_amount': unfreezeAmount,
    'unfreeze_expire_time': unfreezeExpireTime,
  };
}

class TronHttpAccountUnFreezeV2Int64StringCompatible {
  /// Account, contract, or resource type.
  final TronHttpAccountFreezeV2Type? type;
  final BigInt? unfreezeAmount;
  final BigInt? unfreezeExpireTime;

  const TronHttpAccountUnFreezeV2Int64StringCompatible({
    this.type,
    this.unfreezeAmount,
    this.unfreezeExpireTime,
  });

  factory TronHttpAccountUnFreezeV2Int64StringCompatible.fromJson(
    Map<String, dynamic> json,
  ) {
    return TronHttpAccountUnFreezeV2Int64StringCompatible(
      type:
          json.hasValue('type')
              ? TronHttpAccountFreezeV2Type.fromJson(json['type'])
              : null,
      unfreezeAmount: json.valueAsBigInt('unfreeze_amount'),
      unfreezeExpireTime: json.valueAsBigInt('unfreeze_expire_time'),
    );
  }

  Map<String, dynamic> toJson() => {
    'type': type?.toJson(),
    'unfreeze_amount': unfreezeAmount,
    'unfreeze_expire_time': unfreezeExpireTime,
  };
}

class TronHttpAccountUpdateContract {
  /// New account name encoded as expected by java-tron.
  final String? accountName;

  /// Address of the account that owns or initiates the request.
  final String? ownerAddress;

  const TronHttpAccountUpdateContract({this.accountName, this.ownerAddress});

  factory TronHttpAccountUpdateContract.fromJson(Map<String, dynamic> json) {
    return TronHttpAccountUpdateContract(
      accountName:
          (json['account_name'] is num
              ? json['account_name'].toString()
              : json.valueAsString('account_name')),
      ownerAddress:
          (json['owner_address'] is num
              ? json['owner_address'].toString()
              : json.valueAsString('owner_address')),
    );
  }

  Map<String, dynamic> toJson() => {
    'account_name': accountName,
    'owner_address': ownerAddress,
  };
}

class TronHttpAccountUpdateContractRequest {
  /// New account name encoded as expected by java-tron.
  final String? accountName;

  /// Address of the account that owns or initiates the request.
  final String ownerAddress;

  /// When true, addresses are encoded in base58check; when false or omitted, addresses are hex-encoded.
  final bool? visible;

  /// Permission id used to sign the transaction with a non-owner account permission.
  final int? permissionId;

  const TronHttpAccountUpdateContractRequest({
    this.accountName,
    required this.ownerAddress,
    this.visible,
    this.permissionId,
  });

  factory TronHttpAccountUpdateContractRequest.fromJson(
    Map<String, dynamic> json,
  ) {
    return TronHttpAccountUpdateContractRequest(
      accountName:
          (json['account_name'] is num
              ? json['account_name'].toString()
              : json.valueAsString('account_name')),
      ownerAddress:
          (json['owner_address'] is num
              ? json['owner_address'].toString()
              : json.valueAsString('owner_address')),
      visible: json.valueAsBool('visible'),
      permissionId: json.valueAsInt('Permission_id'),
    );
  }

  Map<String, dynamic> toJson() => {
    'account_name': accountName,
    'owner_address': ownerAddress,
    'visible': visible,
    'Permission_id': permissionId,
  };
}

/// Account or contract address accepted by this endpoint.
class TronHttpAddress {
  final String? host;
  final int? port;

  const TronHttpAddress({this.host, this.port});

  factory TronHttpAddress.fromJson(Map<String, dynamic> json) {
    return TronHttpAddress(
      host:
          (json['host'] is num
              ? json['host'].toString()
              : json.valueAsString('host')),
      port: json.valueAsInt('port'),
    );
  }

  Map<String, dynamic> toJson() => {'host': host, 'port': port};
}

class TronHttpAssetIssueContract {
  /// Identifier used by this query.
  final String? id;

  /// Address of the account that owns or initiates the request.
  final String? ownerAddress;

  /// Name encoded as expected by java-tron.
  final String? name;

  /// Asset abbreviation.
  final String? abbr;

  /// Total asset supply.
  final BigInt? totalSupply;

  /// Frozen supply schedules for an asset issue.
  final List<TronHttpAssetIssueContractFrozenSupply>? frozenSupply;

  /// TRX amount used in the asset issue exchange ratio.
  final int? trxNum;

  /// Asset precision.
  final int? precision;

  /// Number of issued tokens in the exchange ratio; trx_num TRX can purchase num tokens.
  final int? num_;

  /// Start timestamp in milliseconds.
  final BigInt? startTime;

  /// End timestamp in milliseconds.
  final BigInt? endTime;

  /// Sort order.
  final BigInt? order;

  /// Vote count or vote weight.
  final int? voteScore;

  /// Human-readable description for this object.
  final String? description;

  /// URL encoded as expected by java-tron.
  final String? url;

  /// Free asset bandwidth limit for each account.
  final BigInt? freeAssetNetLimit;

  /// Public free asset bandwidth limit.
  final BigInt? publicFreeAssetNetLimit;

  /// Public free asset bandwidth usage.
  final BigInt? publicFreeAssetNetUsage;

  /// Latest public free bandwidth usage timestamp.
  final BigInt? publicLatestFreeNetTime;

  const TronHttpAssetIssueContract({
    this.id,
    this.ownerAddress,
    this.name,
    this.abbr,
    this.totalSupply,
    this.frozenSupply,
    this.trxNum,
    this.precision,
    this.num_,
    this.startTime,
    this.endTime,
    this.order,
    this.voteScore,
    this.description,
    this.url,
    this.freeAssetNetLimit,
    this.publicFreeAssetNetLimit,
    this.publicFreeAssetNetUsage,
    this.publicLatestFreeNetTime,
  });

  factory TronHttpAssetIssueContract.fromJson(Map<String, dynamic> json) {
    return TronHttpAssetIssueContract(
      id:
          (json['id'] is num
              ? json['id'].toString()
              : json.valueAsString('id')),
      ownerAddress:
          (json['owner_address'] is num
              ? json['owner_address'].toString()
              : json.valueAsString('owner_address')),
      name:
          (json['name'] is num
              ? json['name'].toString()
              : json.valueAsString('name')),
      abbr:
          (json['abbr'] is num
              ? json['abbr'].toString()
              : json.valueAsString('abbr')),
      totalSupply: json.valueAsBigInt('total_supply'),
      frozenSupply:
          json.hasValue('frozen_supply')
              ? json
                  .valueEnsureAsList<Map<String, dynamic>>('frozen_supply')
                  .map(
                    (e) => TronHttpAssetIssueContractFrozenSupply.fromJson(e),
                  )
                  .toList()
              : null,
      trxNum: json.valueAsInt('trx_num'),
      precision: json.valueAsInt('precision'),
      num_: json.valueAsInt('num'),
      startTime: json.valueAsBigInt('start_time'),
      endTime: json.valueAsBigInt('end_time'),
      order: json.valueAsBigInt('order'),
      voteScore: json.valueAsInt('vote_score'),
      description:
          (json['description'] is num
              ? json['description'].toString()
              : json.valueAsString('description')),
      url:
          (json['url'] is num
              ? json['url'].toString()
              : json.valueAsString('url')),
      freeAssetNetLimit: json.valueAsBigInt('free_asset_net_limit'),
      publicFreeAssetNetLimit: json.valueAsBigInt(
        'public_free_asset_net_limit',
      ),
      publicFreeAssetNetUsage: json.valueAsBigInt(
        'public_free_asset_net_usage',
      ),
      publicLatestFreeNetTime: json.valueAsBigInt(
        'public_latest_free_net_time',
      ),
    );
  }

  Map<String, dynamic> toJson() => {
    'id': id,
    'owner_address': ownerAddress,
    'name': name,
    'abbr': abbr,
    'total_supply': totalSupply,
    'frozen_supply': frozenSupply?.map((e) => e.toJson()).toList(),
    'trx_num': trxNum,
    'precision': precision,
    'num': num_,
    'start_time': startTime,
    'end_time': endTime,
    'order': order,
    'vote_score': voteScore,
    'description': description,
    'url': url,
    'free_asset_net_limit': freeAssetNetLimit,
    'public_free_asset_net_limit': publicFreeAssetNetLimit,
    'public_free_asset_net_usage': publicFreeAssetNetUsage,
    'public_latest_free_net_time': publicLatestFreeNetTime,
  };
}

class TronHttpAssetIssueContractFrozenSupply {
  final BigInt? frozenAmount;
  final BigInt? frozenDays;

  const TronHttpAssetIssueContractFrozenSupply({
    this.frozenAmount,
    this.frozenDays,
  });

  factory TronHttpAssetIssueContractFrozenSupply.fromJson(
    Map<String, dynamic> json,
  ) {
    return TronHttpAssetIssueContractFrozenSupply(
      frozenAmount: json.valueAsBigInt('frozen_amount'),
      frozenDays: json.valueAsBigInt('frozen_days'),
    );
  }

  Map<String, dynamic> toJson() => {
    'frozen_amount': frozenAmount,
    'frozen_days': frozenDays,
  };
}

class TronHttpAssetIssueContractFrozenSupplyInt64StringCompatible {
  final BigInt? frozenAmount;
  final BigInt? frozenDays;

  const TronHttpAssetIssueContractFrozenSupplyInt64StringCompatible({
    this.frozenAmount,
    this.frozenDays,
  });

  factory TronHttpAssetIssueContractFrozenSupplyInt64StringCompatible.fromJson(
    Map<String, dynamic> json,
  ) {
    return TronHttpAssetIssueContractFrozenSupplyInt64StringCompatible(
      frozenAmount: json.valueAsBigInt('frozen_amount'),
      frozenDays: json.valueAsBigInt('frozen_days'),
    );
  }

  Map<String, dynamic> toJson() => {
    'frozen_amount': frozenAmount,
    'frozen_days': frozenDays,
  };
}

class TronHttpAssetIssueContractInt64StringCompatible {
  /// Identifier used by this query.
  final String? id;

  /// Address of the account that owns or initiates the request.
  final String? ownerAddress;

  /// Name encoded as expected by java-tron.
  final String? name;

  /// Asset abbreviation.
  final String? abbr;

  /// Total asset supply.
  final BigInt? totalSupply;

  /// Frozen supply schedules for an asset issue.
  final List<TronHttpAssetIssueContractFrozenSupplyInt64StringCompatible>?
  frozenSupply;

  /// TRX amount used in the asset issue exchange ratio.
  final int? trxNum;

  /// Asset precision.
  final int? precision;

  /// Number of issued tokens in the exchange ratio; trx_num TRX can purchase num tokens.
  final int? num_;

  /// Start timestamp in milliseconds.
  final BigInt? startTime;

  /// End timestamp in milliseconds.
  final BigInt? endTime;

  /// Sort order.
  final BigInt? order;

  /// Vote count or vote weight.
  final int? voteScore;

  /// Human-readable description for this object.
  final String? description;

  /// URL encoded as expected by java-tron.
  final String? url;

  /// Free asset bandwidth limit for each account.
  final BigInt? freeAssetNetLimit;

  /// Public free asset bandwidth limit.
  final BigInt? publicFreeAssetNetLimit;

  /// Public free asset bandwidth usage.
  final BigInt? publicFreeAssetNetUsage;

  /// Latest public free bandwidth usage timestamp.
  final BigInt? publicLatestFreeNetTime;

  const TronHttpAssetIssueContractInt64StringCompatible({
    this.id,
    this.ownerAddress,
    this.name,
    this.abbr,
    this.totalSupply,
    this.frozenSupply,
    this.trxNum,
    this.precision,
    this.num_,
    this.startTime,
    this.endTime,
    this.order,
    this.voteScore,
    this.description,
    this.url,
    this.freeAssetNetLimit,
    this.publicFreeAssetNetLimit,
    this.publicFreeAssetNetUsage,
    this.publicLatestFreeNetTime,
  });

  factory TronHttpAssetIssueContractInt64StringCompatible.fromJson(
    Map<String, dynamic> json,
  ) {
    return TronHttpAssetIssueContractInt64StringCompatible(
      id:
          (json['id'] is num
              ? json['id'].toString()
              : json.valueAsString('id')),
      ownerAddress:
          (json['owner_address'] is num
              ? json['owner_address'].toString()
              : json.valueAsString('owner_address')),
      name:
          (json['name'] is num
              ? json['name'].toString()
              : json.valueAsString('name')),
      abbr:
          (json['abbr'] is num
              ? json['abbr'].toString()
              : json.valueAsString('abbr')),
      totalSupply: json.valueAsBigInt('total_supply'),
      frozenSupply:
          json.hasValue('frozen_supply')
              ? json
                  .valueEnsureAsList<Map<String, dynamic>>('frozen_supply')
                  .map(
                    (e) =>
                        TronHttpAssetIssueContractFrozenSupplyInt64StringCompatible.fromJson(
                          e,
                        ),
                  )
                  .toList()
              : null,
      trxNum: json.valueAsInt('trx_num'),
      precision: json.valueAsInt('precision'),
      num_: json.valueAsInt('num'),
      startTime: json.valueAsBigInt('start_time'),
      endTime: json.valueAsBigInt('end_time'),
      order: json.valueAsBigInt('order'),
      voteScore: json.valueAsInt('vote_score'),
      description:
          (json['description'] is num
              ? json['description'].toString()
              : json.valueAsString('description')),
      url:
          (json['url'] is num
              ? json['url'].toString()
              : json.valueAsString('url')),
      freeAssetNetLimit: json.valueAsBigInt('free_asset_net_limit'),
      publicFreeAssetNetLimit: json.valueAsBigInt(
        'public_free_asset_net_limit',
      ),
      publicFreeAssetNetUsage: json.valueAsBigInt(
        'public_free_asset_net_usage',
      ),
      publicLatestFreeNetTime: json.valueAsBigInt(
        'public_latest_free_net_time',
      ),
    );
  }

  Map<String, dynamic> toJson() => {
    'id': id,
    'owner_address': ownerAddress,
    'name': name,
    'abbr': abbr,
    'total_supply': totalSupply,
    'frozen_supply': frozenSupply?.map((e) => e.toJson()).toList(),
    'trx_num': trxNum,
    'precision': precision,
    'num': num_,
    'start_time': startTime,
    'end_time': endTime,
    'order': order,
    'vote_score': voteScore,
    'description': description,
    'url': url,
    'free_asset_net_limit': freeAssetNetLimit,
    'public_free_asset_net_limit': publicFreeAssetNetLimit,
    'public_free_asset_net_usage': publicFreeAssetNetUsage,
    'public_latest_free_net_time': publicLatestFreeNetTime,
  };
}

class TronHttpAssetIssueContractRequest {
  /// Identifier used by this query.
  final String? id;

  /// Address of the account that owns or initiates the request.
  final String ownerAddress;

  /// Name encoded as expected by java-tron.
  final String name;

  /// Asset abbreviation.
  final String? abbr;

  /// Total asset supply.
  final BigInt totalSupply;

  /// Frozen supply schedules for an asset issue.
  final List<TronHttpAssetIssueContractFrozenSupply>? frozenSupply;

  /// TRX amount used in the asset issue exchange ratio.
  final int trxNum;

  /// Asset precision.
  final int? precision;

  /// Number of issued tokens in the exchange ratio; trx_num TRX can purchase num tokens.
  final int num_;

  /// Start timestamp in milliseconds.
  final BigInt startTime;

  /// End timestamp in milliseconds.
  final BigInt endTime;

  /// Sort order.
  final BigInt? order;

  /// Vote count or vote weight.
  final int? voteScore;

  /// Human-readable description for this object.
  final String? description;

  /// URL encoded as expected by java-tron.
  final String url;

  /// Free asset bandwidth limit for each account.
  final BigInt? freeAssetNetLimit;

  /// Public free asset bandwidth limit.
  final BigInt? publicFreeAssetNetLimit;

  /// Public free asset bandwidth usage.
  final BigInt? publicFreeAssetNetUsage;

  /// Latest public free bandwidth usage timestamp.
  final BigInt? publicLatestFreeNetTime;

  /// When true, addresses are encoded in base58check; when false or omitted, addresses are hex-encoded.
  final bool? visible;

  /// Permission id used to sign the transaction with a non-owner account permission.
  final int? permissionId;

  const TronHttpAssetIssueContractRequest({
    this.id,
    required this.ownerAddress,
    required this.name,
    this.abbr,
    required this.totalSupply,
    this.frozenSupply,
    required this.trxNum,
    this.precision,
    required this.num_,
    required this.startTime,
    required this.endTime,
    this.order,
    this.voteScore,
    this.description,
    required this.url,
    this.freeAssetNetLimit,
    this.publicFreeAssetNetLimit,
    this.publicFreeAssetNetUsage,
    this.publicLatestFreeNetTime,
    this.visible,
    this.permissionId,
  });

  factory TronHttpAssetIssueContractRequest.fromJson(
    Map<String, dynamic> json,
  ) {
    return TronHttpAssetIssueContractRequest(
      id:
          (json['id'] is num
              ? json['id'].toString()
              : json.valueAsString('id')),
      ownerAddress:
          (json['owner_address'] is num
              ? json['owner_address'].toString()
              : json.valueAsString('owner_address')),
      name:
          (json['name'] is num
              ? json['name'].toString()
              : json.valueAsString('name')),
      abbr:
          (json['abbr'] is num
              ? json['abbr'].toString()
              : json.valueAsString('abbr')),
      totalSupply: json.valueAsBigInt('total_supply'),
      frozenSupply:
          json.hasValue('frozen_supply')
              ? json
                  .valueEnsureAsList<Map<String, dynamic>>('frozen_supply')
                  .map(
                    (e) => TronHttpAssetIssueContractFrozenSupply.fromJson(e),
                  )
                  .toList()
              : null,
      trxNum: json.valueAsInt('trx_num'),
      precision: json.valueAsInt('precision'),
      num_: json.valueAsInt('num'),
      startTime: json.valueAsBigInt('start_time'),
      endTime: json.valueAsBigInt('end_time'),
      order: json.valueAsBigInt('order'),
      voteScore: json.valueAsInt('vote_score'),
      description:
          (json['description'] is num
              ? json['description'].toString()
              : json.valueAsString('description')),
      url:
          (json['url'] is num
              ? json['url'].toString()
              : json.valueAsString('url')),
      freeAssetNetLimit: json.valueAsBigInt('free_asset_net_limit'),
      publicFreeAssetNetLimit: json.valueAsBigInt(
        'public_free_asset_net_limit',
      ),
      publicFreeAssetNetUsage: json.valueAsBigInt(
        'public_free_asset_net_usage',
      ),
      publicLatestFreeNetTime: json.valueAsBigInt(
        'public_latest_free_net_time',
      ),
      visible: json.valueAsBool('visible'),
      permissionId: json.valueAsInt('Permission_id'),
    );
  }

  Map<String, dynamic> toJson() => {
    'id': id,
    'owner_address': ownerAddress,
    'name': name,
    'abbr': abbr,
    'total_supply': totalSupply,
    'frozen_supply': frozenSupply?.map((e) => e.toJson()).toList(),
    'trx_num': trxNum,
    'precision': precision,
    'num': num_,
    'start_time': startTime,
    'end_time': endTime,
    'order': order,
    'vote_score': voteScore,
    'description': description,
    'url': url,
    'free_asset_net_limit': freeAssetNetLimit,
    'public_free_asset_net_limit': publicFreeAssetNetLimit,
    'public_free_asset_net_usage': publicFreeAssetNetUsage,
    'public_latest_free_net_time': publicLatestFreeNetTime,
    'visible': visible,
    'Permission_id': permissionId,
  };
}

class TronHttpAssetIssueList {
  final List<TronHttpAssetIssueContract>? assetIssue;

  const TronHttpAssetIssueList({this.assetIssue});

  factory TronHttpAssetIssueList.fromJson(Map<String, dynamic> json) {
    return TronHttpAssetIssueList(
      assetIssue:
          json.hasValue('assetIssue')
              ? json
                  .valueEnsureAsList<Map<String, dynamic>>('assetIssue')
                  .map((e) => TronHttpAssetIssueContract.fromJson(e))
                  .toList()
              : null,
    );
  }

  Map<String, dynamic> toJson() => {
    'assetIssue': assetIssue?.map((e) => e.toJson()).toList(),
  };
}

class TronHttpAssetIssueListInt64StringCompatible {
  final List<TronHttpAssetIssueContractInt64StringCompatible>? assetIssue;

  const TronHttpAssetIssueListInt64StringCompatible({this.assetIssue});

  factory TronHttpAssetIssueListInt64StringCompatible.fromJson(
    Map<String, dynamic> json,
  ) {
    return TronHttpAssetIssueListInt64StringCompatible(
      assetIssue:
          json.hasValue('assetIssue')
              ? json
                  .valueEnsureAsList<Map<String, dynamic>>('assetIssue')
                  .map(
                    (e) =>
                        TronHttpAssetIssueContractInt64StringCompatible.fromJson(
                          e,
                        ),
                  )
                  .toList()
              : null,
    );
  }

  Map<String, dynamic> toJson() => {
    'assetIssue': assetIssue?.map((e) => e.toJson()).toList(),
  };
}

class TronHttpAuthority {
  final TronHttpAccountId? account;
  final String? permissionName;

  const TronHttpAuthority({this.account, this.permissionName});

  factory TronHttpAuthority.fromJson(Map<String, dynamic> json) {
    return TronHttpAuthority(
      account: json.valueTo<TronHttpAccountId?, Map<String, dynamic>>(
        key: 'account',
        parse: (v) => TronHttpAccountId.fromJson(v),
      ),
      permissionName:
          (json['permission_name'] is num
              ? json['permission_name'].toString()
              : json.valueAsString('permission_name')),
    );
  }

  Map<String, dynamic> toJson() => {
    'account': account?.toJson(),
    'permission_name': permissionName,
  };
}

class TronHttpBlock {
  final List<TronHttpTransaction>? transactions;
  final TronHttpBlockHeader? blockHeader;

  /// Block id injected by Util.printBlockToJSON.
  final String? blockID;

  const TronHttpBlock({this.transactions, this.blockHeader, this.blockID});

  factory TronHttpBlock.fromJson(Map<String, dynamic> json) {
    return TronHttpBlock(
      transactions:
          json.hasValue('transactions')
              ? json
                  .valueEnsureAsList<Map<String, dynamic>>('transactions')
                  .map((e) => TronHttpTransaction.fromJson(e))
                  .toList()
              : null,
      blockHeader: json.valueTo<TronHttpBlockHeader?, Map<String, dynamic>>(
        key: 'block_header',
        parse: (v) => TronHttpBlockHeader.fromJson(v),
      ),
      blockID:
          (json['blockID'] is num
              ? json['blockID'].toString()
              : json.valueAsString('blockID')),
    );
  }

  Map<String, dynamic> toJson() => {
    'transactions': transactions?.map((e) => e.toJson()).toList(),
    'block_header': blockHeader?.toJson(),
    'blockID': blockID,
  };
}

class TronHttpBlockBalanceTrace {
  final TronHttpBlockBalanceTraceBlockIdentifier? blockIdentifier;

  /// Timestamp in milliseconds.
  final BigInt? timestamp;
  final List<TronHttpTransactionBalanceTrace>? transactionBalanceTrace;

  const TronHttpBlockBalanceTrace({
    this.blockIdentifier,
    this.timestamp,
    this.transactionBalanceTrace,
  });

  factory TronHttpBlockBalanceTrace.fromJson(Map<String, dynamic> json) {
    return TronHttpBlockBalanceTrace(
      blockIdentifier: json.valueTo<
        TronHttpBlockBalanceTraceBlockIdentifier?,
        Map<String, dynamic>
      >(
        key: 'block_identifier',
        parse: (v) => TronHttpBlockBalanceTraceBlockIdentifier.fromJson(v),
      ),
      timestamp: json.valueAsBigInt('timestamp'),
      transactionBalanceTrace:
          json.hasValue('transaction_balance_trace')
              ? json
                  .valueEnsureAsList<Map<String, dynamic>>(
                    'transaction_balance_trace',
                  )
                  .map((e) => TronHttpTransactionBalanceTrace.fromJson(e))
                  .toList()
              : null,
    );
  }

  Map<String, dynamic> toJson() => {
    'block_identifier': blockIdentifier?.toJson(),
    'timestamp': timestamp,
    'transaction_balance_trace':
        transactionBalanceTrace?.map((e) => e.toJson()).toList(),
  };
}

/// Block identifier used by the query.
class TronHttpBlockBalanceTraceBlockIdentifier {
  /// Block or transaction hash.
  final String? hash;

  /// Block number or numeric query value.
  final BigInt? number;

  const TronHttpBlockBalanceTraceBlockIdentifier({this.hash, this.number});

  factory TronHttpBlockBalanceTraceBlockIdentifier.fromJson(
    Map<String, dynamic> json,
  ) {
    return TronHttpBlockBalanceTraceBlockIdentifier(
      hash:
          (json['hash'] is num
              ? json['hash'].toString()
              : json.valueAsString('hash')),
      number: json.valueAsBigInt('number'),
    );
  }

  Map<String, dynamic> toJson() => {'hash': hash, 'number': number};
}

class TronHttpBlockHeader {
  final TronHttpBlockHeaderRaw? rawData;
  final String? witnessSignature;

  const TronHttpBlockHeader({this.rawData, this.witnessSignature});

  factory TronHttpBlockHeader.fromJson(Map<String, dynamic> json) {
    return TronHttpBlockHeader(
      rawData: json.valueTo<TronHttpBlockHeaderRaw?, Map<String, dynamic>>(
        key: 'raw_data',
        parse: (v) => TronHttpBlockHeaderRaw.fromJson(v),
      ),
      witnessSignature:
          (json['witness_signature'] is num
              ? json['witness_signature'].toString()
              : json.valueAsString('witness_signature')),
    );
  }

  Map<String, dynamic> toJson() => {
    'raw_data': rawData?.toJson(),
    'witness_signature': witnessSignature,
  };
}

class TronHttpBlockHeaderInt64StringCompatible {
  final TronHttpBlockHeaderRawInt64StringCompatible? rawData;
  final String? witnessSignature;

  const TronHttpBlockHeaderInt64StringCompatible({
    this.rawData,
    this.witnessSignature,
  });

  factory TronHttpBlockHeaderInt64StringCompatible.fromJson(
    Map<String, dynamic> json,
  ) {
    return TronHttpBlockHeaderInt64StringCompatible(
      rawData: json.valueTo<
        TronHttpBlockHeaderRawInt64StringCompatible?,
        Map<String, dynamic>
      >(
        key: 'raw_data',
        parse: (v) => TronHttpBlockHeaderRawInt64StringCompatible.fromJson(v),
      ),
      witnessSignature:
          (json['witness_signature'] is num
              ? json['witness_signature'].toString()
              : json.valueAsString('witness_signature')),
    );
  }

  Map<String, dynamic> toJson() => {
    'raw_data': rawData?.toJson(),
    'witness_signature': witnessSignature,
  };
}

/// Transaction raw data object.
class TronHttpBlockHeaderRaw {
  /// Timestamp in milliseconds.
  final BigInt? timestamp;
  final String? txTrieRoot;
  final String? parentHash;

  /// Block number or numeric query value.
  final BigInt? number;
  final BigInt? witnessId;
  final String? witnessAddress;
  final int? version;
  final String? accountStateRoot;

  const TronHttpBlockHeaderRaw({
    this.timestamp,
    this.txTrieRoot,
    this.parentHash,
    this.number,
    this.witnessId,
    this.witnessAddress,
    this.version,
    this.accountStateRoot,
  });

  factory TronHttpBlockHeaderRaw.fromJson(Map<String, dynamic> json) {
    return TronHttpBlockHeaderRaw(
      timestamp: json.valueAsBigInt('timestamp'),
      txTrieRoot:
          (json['txTrieRoot'] is num
              ? json['txTrieRoot'].toString()
              : json.valueAsString('txTrieRoot')),
      parentHash:
          (json['parentHash'] is num
              ? json['parentHash'].toString()
              : json.valueAsString('parentHash')),
      number: json.valueAsBigInt('number'),
      witnessId: json.valueAsBigInt('witness_id'),
      witnessAddress:
          (json['witness_address'] is num
              ? json['witness_address'].toString()
              : json.valueAsString('witness_address')),
      version: json.valueAsInt('version'),
      accountStateRoot:
          (json['accountStateRoot'] is num
              ? json['accountStateRoot'].toString()
              : json.valueAsString('accountStateRoot')),
    );
  }

  Map<String, dynamic> toJson() => {
    'timestamp': timestamp,
    'txTrieRoot': txTrieRoot,
    'parentHash': parentHash,
    'number': number,
    'witness_id': witnessId,
    'witness_address': witnessAddress,
    'version': version,
    'accountStateRoot': accountStateRoot,
  };
}

/// Transaction raw data object.
class TronHttpBlockHeaderRawInt64StringCompatible {
  /// Timestamp in milliseconds.
  final BigInt? timestamp;
  final String? txTrieRoot;
  final String? parentHash;

  /// Block number or numeric query value.
  final BigInt? number;
  final BigInt? witnessId;
  final String? witnessAddress;
  final int? version;
  final String? accountStateRoot;

  const TronHttpBlockHeaderRawInt64StringCompatible({
    this.timestamp,
    this.txTrieRoot,
    this.parentHash,
    this.number,
    this.witnessId,
    this.witnessAddress,
    this.version,
    this.accountStateRoot,
  });

  factory TronHttpBlockHeaderRawInt64StringCompatible.fromJson(
    Map<String, dynamic> json,
  ) {
    return TronHttpBlockHeaderRawInt64StringCompatible(
      timestamp: json.valueAsBigInt('timestamp'),
      txTrieRoot:
          (json['txTrieRoot'] is num
              ? json['txTrieRoot'].toString()
              : json.valueAsString('txTrieRoot')),
      parentHash:
          (json['parentHash'] is num
              ? json['parentHash'].toString()
              : json.valueAsString('parentHash')),
      number: json.valueAsBigInt('number'),
      witnessId: json.valueAsBigInt('witness_id'),
      witnessAddress:
          (json['witness_address'] is num
              ? json['witness_address'].toString()
              : json.valueAsString('witness_address')),
      version: json.valueAsInt('version'),
      accountStateRoot:
          (json['accountStateRoot'] is num
              ? json['accountStateRoot'].toString()
              : json.valueAsString('accountStateRoot')),
    );
  }

  Map<String, dynamic> toJson() => {
    'timestamp': timestamp,
    'txTrieRoot': txTrieRoot,
    'parentHash': parentHash,
    'number': number,
    'witness_id': witnessId,
    'witness_address': witnessAddress,
    'version': version,
    'accountStateRoot': accountStateRoot,
  };
}

/// POST /wallet/getblockbynum (request)
/// POST /wallet/gettransactioncountbyblocknum (request)
/// POST /wallet/gettransactioninfobyblocknum (request)
class TronHttpBlockHeightNumberMessageRequest {
  /// Block height.
  final BigInt? num_;

  /// When true, addresses are encoded in base58check; when false or omitted, addresses are hex-encoded.
  final bool? visible;

  const TronHttpBlockHeightNumberMessageRequest({this.num_, this.visible});

  factory TronHttpBlockHeightNumberMessageRequest.fromJson(
    Map<String, dynamic> json,
  ) {
    return TronHttpBlockHeightNumberMessageRequest(
      num_: json.valueAsBigInt('num'),
      visible: json.valueAsBool('visible'),
    );
  }

  Map<String, dynamic> toJson() => {'num': num_, 'visible': visible};
}

class TronHttpBlockIdentifierRequest {
  /// The 32-byte hash of the block, encoded as 64 hexadecimal characters.
  final String hash;

  /// Block height corresponding to hash. When omitted, the Protobuf default value 0 is used.
  final BigInt? number;

  /// When true, addresses are encoded in base58check; when false or omitted, addresses are hex-encoded.
  final bool? visible;

  const TronHttpBlockIdentifierRequest({
    required this.hash,
    this.number,
    this.visible,
  });

  factory TronHttpBlockIdentifierRequest.fromJson(Map<String, dynamic> json) {
    return TronHttpBlockIdentifierRequest(
      hash:
          (json['hash'] is num
              ? json['hash'].toString()
              : json.valueAsString('hash')),
      number: json.valueAsBigInt('number'),
      visible: json.valueAsBool('visible'),
    );
  }

  Map<String, dynamic> toJson() => {
    'hash': hash,
    'number': number,
    'visible': visible,
  };
}

class TronHttpBlockInt64StringCompatible {
  final List<TronHttpTransactionInt64StringCompatible>? transactions;
  final TronHttpBlockHeaderInt64StringCompatible? blockHeader;

  /// Block id injected by Util.printBlockToJSON.
  final String? blockID;

  const TronHttpBlockInt64StringCompatible({
    this.transactions,
    this.blockHeader,
    this.blockID,
  });

  factory TronHttpBlockInt64StringCompatible.fromJson(
    Map<String, dynamic> json,
  ) {
    return TronHttpBlockInt64StringCompatible(
      transactions:
          json.hasValue('transactions')
              ? json
                  .valueEnsureAsList<Map<String, dynamic>>('transactions')
                  .map(
                    (e) => TronHttpTransactionInt64StringCompatible.fromJson(e),
                  )
                  .toList()
              : null,
      blockHeader: json.valueTo<
        TronHttpBlockHeaderInt64StringCompatible?,
        Map<String, dynamic>
      >(
        key: 'block_header',
        parse: (v) => TronHttpBlockHeaderInt64StringCompatible.fromJson(v),
      ),
      blockID:
          (json['blockID'] is num
              ? json['blockID'].toString()
              : json.valueAsString('blockID')),
    );
  }

  Map<String, dynamic> toJson() => {
    'transactions': transactions?.map((e) => e.toJson()).toList(),
    'block_header': blockHeader?.toJson(),
    'blockID': blockID,
  };
}

/// POST /wallet/getblockbylimitnext (request)
class TronHttpBlockLimitRequest {
  /// Starting block number for the query range.
  final BigInt? startNum;

  /// Ending block number for the query range.
  final BigInt? endNum;

  /// When true, addresses are encoded in base58check; when false or omitted, addresses are hex-encoded.
  final bool? visible;

  const TronHttpBlockLimitRequest({this.startNum, this.endNum, this.visible});

  factory TronHttpBlockLimitRequest.fromJson(Map<String, dynamic> json) {
    return TronHttpBlockLimitRequest(
      startNum: json.valueAsBigInt('startNum'),
      endNum: json.valueAsBigInt('endNum'),
      visible: json.valueAsBool('visible'),
    );
  }

  Map<String, dynamic> toJson() => {
    'startNum': startNum,
    'endNum': endNum,
    'visible': visible,
  };
}

class TronHttpBlockList {
  final List<TronHttpBlock>? block;

  const TronHttpBlockList({this.block});

  factory TronHttpBlockList.fromJson(Map<String, dynamic> json) {
    return TronHttpBlockList(
      block:
          json.hasValue('block')
              ? json
                  .valueEnsureAsList<Map<String, dynamic>>('block')
                  .map((e) => TronHttpBlock.fromJson(e))
                  .toList()
              : null,
    );
  }

  Map<String, dynamic> toJson() => {
    'block': block?.map((e) => e.toJson()).toList(),
  };
}

class TronHttpBlockListInt64StringCompatible {
  final List<TronHttpBlockInt64StringCompatible>? block;

  const TronHttpBlockListInt64StringCompatible({this.block});

  factory TronHttpBlockListInt64StringCompatible.fromJson(
    Map<String, dynamic> json,
  ) {
    return TronHttpBlockListInt64StringCompatible(
      block:
          json.hasValue('block')
              ? json
                  .valueEnsureAsList<Map<String, dynamic>>('block')
                  .map((e) => TronHttpBlockInt64StringCompatible.fromJson(e))
                  .toList()
              : null,
    );
  }

  Map<String, dynamic> toJson() => {
    'block': block?.map((e) => e.toJson()).toList(),
  };
}

/// POST /wallet/getblock (request)
class TronHttpBlockReqRequest {
  /// Block id or block number.
  final String? idOrNum;

  /// Whether to return detailed block information.
  final bool? detail;

  /// When true, addresses are encoded in base58check; when false or omitted, addresses are hex-encoded.
  final bool? visible;

  const TronHttpBlockReqRequest({this.idOrNum, this.detail, this.visible});

  factory TronHttpBlockReqRequest.fromJson(Map<String, dynamic> json) {
    return TronHttpBlockReqRequest(
      idOrNum:
          (json['id_or_num'] is num
              ? json['id_or_num'].toString()
              : json.valueAsString('id_or_num')),
      detail: json.valueAsBool('detail'),
      visible: json.valueAsBool('visible'),
    );
  }

  Map<String, dynamic> toJson() => {
    'id_or_num': idOrNum,
    'detail': detail,
    'visible': visible,
  };
}

/// POST /wallet/getblockbyid (request)
/// POST /wallet/gettransactionbyid (request)
/// POST /wallet/gettransactioninfobyid (request)
/// POST /wallet/getcontract (request)
/// POST /wallet/getcontractinfo (request)
/// POST /wallet/getdelegatedresourceaccountindex (request)
/// POST /wallet/getdelegatedresourceaccountindexv2 (request)
class TronHttpBytesMessageRequest {
  /// Hex string, amount, or value field accepted by this endpoint.
  final String? value;

  /// When true, addresses are encoded in base58check; when false or omitted, addresses are hex-encoded.
  final bool? visible;

  const TronHttpBytesMessageRequest({this.value, this.visible});

  factory TronHttpBytesMessageRequest.fromJson(Map<String, dynamic> json) {
    return TronHttpBytesMessageRequest(
      value:
          (json['value'] is num
              ? json['value'].toString()
              : json.valueAsString('value')),
      visible: json.valueAsBool('visible'),
    );
  }

  Map<String, dynamic> toJson() => {'value': value, 'visible': visible};
}

/// POST /wallet/getcandelegatedmaxsize (request)
class TronHttpCanDelegatedMaxSizeRequestMessageRequest {
  /// Account, contract, or resource type.
  final int? type;

  /// Address of the account that owns or initiates the request.
  final String? ownerAddress;

  /// When true, addresses are encoded in base58check; when false or omitted, addresses are hex-encoded.
  final bool? visible;

  const TronHttpCanDelegatedMaxSizeRequestMessageRequest({
    this.type,
    this.ownerAddress,
    this.visible,
  });

  factory TronHttpCanDelegatedMaxSizeRequestMessageRequest.fromJson(
    Map<String, dynamic> json,
  ) {
    return TronHttpCanDelegatedMaxSizeRequestMessageRequest(
      type: json.valueAsInt('type'),
      ownerAddress:
          (json['owner_address'] is num
              ? json['owner_address'].toString()
              : json.valueAsString('owner_address')),
      visible: json.valueAsBool('visible'),
    );
  }

  Map<String, dynamic> toJson() => {
    'type': type,
    'owner_address': ownerAddress,
    'visible': visible,
  };
}

class TronHttpCanDelegatedMaxSizeResponseMessage {
  final BigInt? maxSize;

  const TronHttpCanDelegatedMaxSizeResponseMessage({this.maxSize});

  factory TronHttpCanDelegatedMaxSizeResponseMessage.fromJson(
    Map<String, dynamic> json,
  ) {
    return TronHttpCanDelegatedMaxSizeResponseMessage(
      maxSize: json.valueAsBigInt('max_size'),
    );
  }

  Map<String, dynamic> toJson() => {'max_size': maxSize};
}

class TronHttpCanDelegatedMaxSizeResponseMessageInt64StringCompatible {
  final BigInt? maxSize;

  const TronHttpCanDelegatedMaxSizeResponseMessageInt64StringCompatible({
    this.maxSize,
  });

  factory TronHttpCanDelegatedMaxSizeResponseMessageInt64StringCompatible.fromJson(
    Map<String, dynamic> json,
  ) {
    return TronHttpCanDelegatedMaxSizeResponseMessageInt64StringCompatible(
      maxSize: json.valueAsBigInt('max_size'),
    );
  }

  Map<String, dynamic> toJson() => {'max_size': maxSize};
}

/// POST /wallet/getcanwithdrawunfreezeamount (request)
class TronHttpCanWithdrawUnfreezeAmountRequestMessageRequest {
  /// Address of the account that owns or initiates the request.
  final String? ownerAddress;

  /// Timestamp in milliseconds.
  final BigInt? timestamp;

  /// When true, addresses are encoded in base58check; when false or omitted, addresses are hex-encoded.
  final bool? visible;

  const TronHttpCanWithdrawUnfreezeAmountRequestMessageRequest({
    this.ownerAddress,
    this.timestamp,
    this.visible,
  });

  factory TronHttpCanWithdrawUnfreezeAmountRequestMessageRequest.fromJson(
    Map<String, dynamic> json,
  ) {
    return TronHttpCanWithdrawUnfreezeAmountRequestMessageRequest(
      ownerAddress:
          (json['owner_address'] is num
              ? json['owner_address'].toString()
              : json.valueAsString('owner_address')),
      timestamp: json.valueAsBigInt('timestamp'),
      visible: json.valueAsBool('visible'),
    );
  }

  Map<String, dynamic> toJson() => {
    'owner_address': ownerAddress,
    'timestamp': timestamp,
    'visible': visible,
  };
}

class TronHttpCanWithdrawUnfreezeAmountResponseMessage {
  /// Amount in sun, where 1 TRX equals 1,000,000 sun.
  final BigInt? amount;

  const TronHttpCanWithdrawUnfreezeAmountResponseMessage({this.amount});

  factory TronHttpCanWithdrawUnfreezeAmountResponseMessage.fromJson(
    Map<String, dynamic> json,
  ) {
    return TronHttpCanWithdrawUnfreezeAmountResponseMessage(
      amount: json.valueAsBigInt('amount'),
    );
  }

  Map<String, dynamic> toJson() => {'amount': amount};
}

class TronHttpCanWithdrawUnfreezeAmountResponseMessageInt64StringCompatible {
  /// Amount in sun, where 1 TRX equals 1,000,000 sun.
  final BigInt? amount;

  const TronHttpCanWithdrawUnfreezeAmountResponseMessageInt64StringCompatible({
    this.amount,
  });

  factory TronHttpCanWithdrawUnfreezeAmountResponseMessageInt64StringCompatible.fromJson(
    Map<String, dynamic> json,
  ) {
    return TronHttpCanWithdrawUnfreezeAmountResponseMessageInt64StringCompatible(
      amount: json.valueAsBigInt('amount'),
    );
  }

  Map<String, dynamic> toJson() => {'amount': amount};
}

class TronHttpCancelAllUnfreezeV2Contract {
  /// Address of the account that owns or initiates the request.
  final String? ownerAddress;

  const TronHttpCancelAllUnfreezeV2Contract({this.ownerAddress});

  factory TronHttpCancelAllUnfreezeV2Contract.fromJson(
    Map<String, dynamic> json,
  ) {
    return TronHttpCancelAllUnfreezeV2Contract(
      ownerAddress:
          (json['owner_address'] is num
              ? json['owner_address'].toString()
              : json.valueAsString('owner_address')),
    );
  }

  Map<String, dynamic> toJson() => {'owner_address': ownerAddress};
}

class TronHttpCancelAllUnfreezeV2ContractRequest {
  /// Address of the account that owns or initiates the request.
  final String ownerAddress;

  /// When true, addresses are encoded in base58check; when false or omitted, addresses are hex-encoded.
  final bool? visible;

  /// Permission id used to sign the transaction with a non-owner account permission.
  final int? permissionId;

  const TronHttpCancelAllUnfreezeV2ContractRequest({
    required this.ownerAddress,
    this.visible,
    this.permissionId,
  });

  factory TronHttpCancelAllUnfreezeV2ContractRequest.fromJson(
    Map<String, dynamic> json,
  ) {
    return TronHttpCancelAllUnfreezeV2ContractRequest(
      ownerAddress:
          (json['owner_address'] is num
              ? json['owner_address'].toString()
              : json.valueAsString('owner_address')),
      visible: json.valueAsBool('visible'),
      permissionId: json.valueAsInt('Permission_id'),
    );
  }

  Map<String, dynamic> toJson() => {
    'owner_address': ownerAddress,
    'visible': visible,
    'Permission_id': permissionId,
  };
}

class TronHttpChainParameters {
  final List<TronHttpChainParametersChainParameter>? chainParameter;

  const TronHttpChainParameters({this.chainParameter});

  factory TronHttpChainParameters.fromJson(Map<String, dynamic> json) {
    return TronHttpChainParameters(
      chainParameter:
          json.hasValue('chainParameter')
              ? json
                  .valueEnsureAsList<Map<String, dynamic>>('chainParameter')
                  .map((e) => TronHttpChainParametersChainParameter.fromJson(e))
                  .toList()
              : null,
    );
  }

  Map<String, dynamic> toJson() => {
    'chainParameter': chainParameter?.map((e) => e.toJson()).toList(),
  };
}

class TronHttpChainParametersChainParameter {
  final String? key;

  /// Hex string, amount, or value field accepted by this endpoint.
  final BigInt? value;

  const TronHttpChainParametersChainParameter({this.key, this.value});

  factory TronHttpChainParametersChainParameter.fromJson(
    Map<String, dynamic> json,
  ) {
    return TronHttpChainParametersChainParameter(
      key:
          (json['key'] is num
              ? json['key'].toString()
              : json.valueAsString('key')),
      value: json.valueAsBigInt('value'),
    );
  }

  Map<String, dynamic> toJson() => {'key': key, 'value': value};
}

class TronHttpChainParametersChainParameterInt64StringCompatible {
  final String? key;

  /// Hex string, amount, or value field accepted by this endpoint.
  final BigInt? value;

  const TronHttpChainParametersChainParameterInt64StringCompatible({
    this.key,
    this.value,
  });

  factory TronHttpChainParametersChainParameterInt64StringCompatible.fromJson(
    Map<String, dynamic> json,
  ) {
    return TronHttpChainParametersChainParameterInt64StringCompatible(
      key:
          (json['key'] is num
              ? json['key'].toString()
              : json.valueAsString('key')),
      value: json.valueAsBigInt('value'),
    );
  }

  Map<String, dynamic> toJson() => {'key': key, 'value': value};
}

class TronHttpChainParametersInt64StringCompatible {
  final List<TronHttpChainParametersChainParameterInt64StringCompatible>?
  chainParameter;

  const TronHttpChainParametersInt64StringCompatible({this.chainParameter});

  factory TronHttpChainParametersInt64StringCompatible.fromJson(
    Map<String, dynamic> json,
  ) {
    return TronHttpChainParametersInt64StringCompatible(
      chainParameter:
          json.hasValue('chainParameter')
              ? json
                  .valueEnsureAsList<Map<String, dynamic>>('chainParameter')
                  .map(
                    (e) =>
                        TronHttpChainParametersChainParameterInt64StringCompatible.fromJson(
                          e,
                        ),
                  )
                  .toList()
              : null,
    );
  }

  Map<String, dynamic> toJson() => {
    'chainParameter': chainParameter?.map((e) => e.toJson()).toList(),
  };
}

class TronHttpClearABIContract {
  /// Address of the account that owns or initiates the request.
  final String? ownerAddress;

  /// Smart contract address.
  final String? contractAddress;

  const TronHttpClearABIContract({this.ownerAddress, this.contractAddress});

  factory TronHttpClearABIContract.fromJson(Map<String, dynamic> json) {
    return TronHttpClearABIContract(
      ownerAddress:
          (json['owner_address'] is num
              ? json['owner_address'].toString()
              : json.valueAsString('owner_address')),
      contractAddress:
          (json['contract_address'] is num
              ? json['contract_address'].toString()
              : json.valueAsString('contract_address')),
    );
  }

  Map<String, dynamic> toJson() => {
    'owner_address': ownerAddress,
    'contract_address': contractAddress,
  };
}

class TronHttpClearABIContractRequest {
  /// Address of the account that owns or initiates the request.
  final String ownerAddress;

  /// Smart contract address.
  final String contractAddress;

  /// When true, addresses are encoded in base58check; when false or omitted, addresses are hex-encoded.
  final bool? visible;

  /// Permission id used to sign the transaction with a non-owner account permission.
  final int? permissionId;

  const TronHttpClearABIContractRequest({
    required this.ownerAddress,
    required this.contractAddress,
    this.visible,
    this.permissionId,
  });

  factory TronHttpClearABIContractRequest.fromJson(Map<String, dynamic> json) {
    return TronHttpClearABIContractRequest(
      ownerAddress:
          (json['owner_address'] is num
              ? json['owner_address'].toString()
              : json.valueAsString('owner_address')),
      contractAddress:
          (json['contract_address'] is num
              ? json['contract_address'].toString()
              : json.valueAsString('contract_address')),
      visible: json.valueAsBool('visible'),
      permissionId: json.valueAsInt('Permission_id'),
    );
  }

  Map<String, dynamic> toJson() => {
    'owner_address': ownerAddress,
    'contract_address': contractAddress,
    'visible': visible,
    'Permission_id': permissionId,
  };
}

class TronHttpContractState {
  final BigInt? energyUsage;
  final BigInt? energyFactor;
  final BigInt? updateCycle;

  const TronHttpContractState({
    this.energyUsage,
    this.energyFactor,
    this.updateCycle,
  });

  factory TronHttpContractState.fromJson(Map<String, dynamic> json) {
    return TronHttpContractState(
      energyUsage: json.valueAsBigInt('energy_usage'),
      energyFactor: json.valueAsBigInt('energy_factor'),
      updateCycle: json.valueAsBigInt('update_cycle'),
    );
  }

  Map<String, dynamic> toJson() => {
    'energy_usage': energyUsage,
    'energy_factor': energyFactor,
    'update_cycle': updateCycle,
  };
}

class TronHttpContractStateInt64StringCompatible {
  final BigInt? energyUsage;
  final BigInt? energyFactor;
  final BigInt? updateCycle;

  const TronHttpContractStateInt64StringCompatible({
    this.energyUsage,
    this.energyFactor,
    this.updateCycle,
  });

  factory TronHttpContractStateInt64StringCompatible.fromJson(
    Map<String, dynamic> json,
  ) {
    return TronHttpContractStateInt64StringCompatible(
      energyUsage: json.valueAsBigInt('energy_usage'),
      energyFactor: json.valueAsBigInt('energy_factor'),
      updateCycle: json.valueAsBigInt('update_cycle'),
    );
  }

  Map<String, dynamic> toJson() => {
    'energy_usage': energyUsage,
    'energy_factor': energyFactor,
    'update_cycle': updateCycle,
  };
}

class TronHttpCreateSmartContract {
  /// Address of the account that owns or initiates the request.
  final String? ownerAddress;
  final TronHttpSmartContract? newContract;

  /// TRC10 token amount transferred with the smart contract call.
  final BigInt? callTokenValue;

  /// TRC10 token id.
  final BigInt? tokenId;

  const TronHttpCreateSmartContract({
    this.ownerAddress,
    this.newContract,
    this.callTokenValue,
    this.tokenId,
  });

  factory TronHttpCreateSmartContract.fromJson(Map<String, dynamic> json) {
    return TronHttpCreateSmartContract(
      ownerAddress:
          (json['owner_address'] is num
              ? json['owner_address'].toString()
              : json.valueAsString('owner_address')),
      newContract: json.valueTo<TronHttpSmartContract?, Map<String, dynamic>>(
        key: 'new_contract',
        parse: (v) => TronHttpSmartContract.fromJson(v),
      ),
      callTokenValue: json.valueAsBigInt('call_token_value'),
      tokenId: json.valueAsBigInt('token_id'),
    );
  }

  Map<String, dynamic> toJson() => {
    'owner_address': ownerAddress,
    'new_contract': newContract?.toJson(),
    'call_token_value': callTokenValue,
    'token_id': tokenId,
  };
}

class TronHttpCreateSmartContractInt64StringCompatible {
  /// Address of the account that owns or initiates the request.
  final String? ownerAddress;
  final TronHttpSmartContractInt64StringCompatible? newContract;

  /// TRC10 token amount transferred with the smart contract call.
  final BigInt? callTokenValue;

  /// TRC10 token id.
  final BigInt? tokenId;

  const TronHttpCreateSmartContractInt64StringCompatible({
    this.ownerAddress,
    this.newContract,
    this.callTokenValue,
    this.tokenId,
  });

  factory TronHttpCreateSmartContractInt64StringCompatible.fromJson(
    Map<String, dynamic> json,
  ) {
    return TronHttpCreateSmartContractInt64StringCompatible(
      ownerAddress:
          (json['owner_address'] is num
              ? json['owner_address'].toString()
              : json.valueAsString('owner_address')),
      newContract: json.valueTo<
        TronHttpSmartContractInt64StringCompatible?,
        Map<String, dynamic>
      >(
        key: 'new_contract',
        parse: (v) => TronHttpSmartContractInt64StringCompatible.fromJson(v),
      ),
      callTokenValue: json.valueAsBigInt('call_token_value'),
      tokenId: json.valueAsBigInt('token_id'),
    );
  }

  Map<String, dynamic> toJson() => {
    'owner_address': ownerAddress,
    'new_contract': newContract?.toJson(),
    'call_token_value': callTokenValue,
    'token_id': tokenId,
  };
}

class TronHttpCreateSmartContractRequest {
  /// Address of the account that owns or initiates the request.
  final String ownerAddress;

  /// TRC10 token amount transferred with the smart contract call.
  final BigInt? callTokenValue;

  /// TRC10 token id.
  final BigInt? tokenId;

  /// JSON-encoded ABI entry array. DeployContractServlet reads this field as a string before parsing it as ABI JSON.
  final String? abi;

  /// Compiled smart contract bytecode.
  final String bytecode;

  /// Contract parameter payload.
  final String? parameter;

  /// Name encoded as expected by java-tron.
  final String? name;

  /// TRX amount in sun transferred with the smart contract call.
  final BigInt? callValue;

  /// Percentage of contract execution resource cost paid by the user.
  final BigInt? consumeUserResourcePercent;

  /// Origin energy limit for a deployed smart contract.
  final BigInt? originEnergyLimit;

  /// Maximum fee in sun for smart contract execution.
  final BigInt? feeLimit;

  /// When true, addresses are encoded in base58check; when false or omitted, addresses are hex-encoded.
  final bool? visible;

  /// Permission id used to sign the transaction with a non-owner account permission.
  final int? permissionId;

  const TronHttpCreateSmartContractRequest({
    required this.ownerAddress,
    this.callTokenValue,
    this.tokenId,
    this.abi,
    required this.bytecode,
    this.parameter,
    this.name,
    this.callValue,
    this.consumeUserResourcePercent,
    this.originEnergyLimit,
    this.feeLimit,
    this.visible,
    this.permissionId,
  });

  factory TronHttpCreateSmartContractRequest.fromJson(
    Map<String, dynamic> json,
  ) {
    return TronHttpCreateSmartContractRequest(
      ownerAddress:
          (json['owner_address'] is num
              ? json['owner_address'].toString()
              : json.valueAsString('owner_address')),
      callTokenValue: json.valueAsBigInt('call_token_value'),
      tokenId: json.valueAsBigInt('token_id'),
      abi:
          (json['abi'] is num
              ? json['abi'].toString()
              : json.valueAsString('abi')),
      bytecode:
          (json['bytecode'] is num
              ? json['bytecode'].toString()
              : json.valueAsString('bytecode')),
      parameter:
          (json['parameter'] is num
              ? json['parameter'].toString()
              : json.valueAsString('parameter')),
      name:
          (json['name'] is num
              ? json['name'].toString()
              : json.valueAsString('name')),
      callValue: json.valueAsBigInt('call_value'),
      consumeUserResourcePercent: json.valueAsBigInt(
        'consume_user_resource_percent',
      ),
      originEnergyLimit: json.valueAsBigInt('origin_energy_limit'),
      feeLimit: json.valueAsBigInt('fee_limit'),
      visible: json.valueAsBool('visible'),
      permissionId: json.valueAsInt('Permission_id'),
    );
  }

  Map<String, dynamic> toJson() => {
    'owner_address': ownerAddress,
    'call_token_value': callTokenValue,
    'token_id': tokenId,
    'abi': abi,
    'bytecode': bytecode,
    'parameter': parameter,
    'name': name,
    'call_value': callValue,
    'consume_user_resource_percent': consumeUserResourcePercent,
    'origin_energy_limit': originEnergyLimit,
    'fee_limit': feeLimit,
    'visible': visible,
    'Permission_id': permissionId,
  };
}

class TronHttpDelegateResourceContract {
  /// Address of the account that owns or initiates the request.
  final String? ownerAddress;

  /// Resource type.
  final TronHttpAccountFreezeV2Type? resource;

  /// Resource amount in sun, where 1 TRX equals 1,000,000 sun.
  final BigInt? balance;

  /// Address of the account receiving resources or funds.
  final String? receiverAddress;

  /// Whether delegated resources are locked.
  final bool? lock;

  /// Resource delegation lock period.
  final BigInt? lockPeriod;

  const TronHttpDelegateResourceContract({
    this.ownerAddress,
    this.resource,
    this.balance,
    this.receiverAddress,
    this.lock,
    this.lockPeriod,
  });

  factory TronHttpDelegateResourceContract.fromJson(Map<String, dynamic> json) {
    return TronHttpDelegateResourceContract(
      ownerAddress:
          (json['owner_address'] is num
              ? json['owner_address'].toString()
              : json.valueAsString('owner_address')),
      resource:
          json.hasValue('resource')
              ? TronHttpAccountFreezeV2Type.fromJson(json['resource'])
              : null,
      balance: json.valueAsBigInt('balance'),
      receiverAddress:
          (json['receiver_address'] is num
              ? json['receiver_address'].toString()
              : json.valueAsString('receiver_address')),
      lock: json.valueAsBool('lock'),
      lockPeriod: json.valueAsBigInt('lock_period'),
    );
  }

  Map<String, dynamic> toJson() => {
    'owner_address': ownerAddress,
    'resource': resource?.toJson(),
    'balance': balance,
    'receiver_address': receiverAddress,
    'lock': lock,
    'lock_period': lockPeriod,
  };
}

class TronHttpDelegateResourceContractInt64StringCompatible {
  /// Address of the account that owns or initiates the request.
  final String? ownerAddress;

  /// Resource type.
  final TronHttpAccountFreezeV2Type? resource;

  /// Resource amount in sun, where 1 TRX equals 1,000,000 sun.
  final BigInt? balance;

  /// Address of the account receiving resources or funds.
  final String? receiverAddress;

  /// Whether delegated resources are locked.
  final bool? lock;

  /// Resource delegation lock period.
  final BigInt? lockPeriod;

  const TronHttpDelegateResourceContractInt64StringCompatible({
    this.ownerAddress,
    this.resource,
    this.balance,
    this.receiverAddress,
    this.lock,
    this.lockPeriod,
  });

  factory TronHttpDelegateResourceContractInt64StringCompatible.fromJson(
    Map<String, dynamic> json,
  ) {
    return TronHttpDelegateResourceContractInt64StringCompatible(
      ownerAddress:
          (json['owner_address'] is num
              ? json['owner_address'].toString()
              : json.valueAsString('owner_address')),
      resource:
          json.hasValue('resource')
              ? TronHttpAccountFreezeV2Type.fromJson(json['resource'])
              : null,
      balance: json.valueAsBigInt('balance'),
      receiverAddress:
          (json['receiver_address'] is num
              ? json['receiver_address'].toString()
              : json.valueAsString('receiver_address')),
      lock: json.valueAsBool('lock'),
      lockPeriod: json.valueAsBigInt('lock_period'),
    );
  }

  Map<String, dynamic> toJson() => {
    'owner_address': ownerAddress,
    'resource': resource?.toJson(),
    'balance': balance,
    'receiver_address': receiverAddress,
    'lock': lock,
    'lock_period': lockPeriod,
  };
}

class TronHttpDelegateResourceContractRequest {
  /// Address of the account that owns or initiates the request.
  final String ownerAddress;

  /// Resource type.
  final TronHttpDelegateResourceContractRequestResource? resource;

  /// Resource amount in sun, where 1 TRX equals 1,000,000 sun.
  final BigInt balance;

  /// Address of the account receiving resources or funds.
  final String receiverAddress;

  /// Whether delegated resources are locked.
  final bool? lock;

  /// Resource delegation lock period.
  final BigInt? lockPeriod;

  /// When true, addresses are encoded in base58check; when false or omitted, addresses are hex-encoded.
  final bool? visible;

  /// Permission id used to sign the transaction with a non-owner account permission.
  final int? permissionId;

  const TronHttpDelegateResourceContractRequest({
    required this.ownerAddress,
    this.resource,
    required this.balance,
    required this.receiverAddress,
    this.lock,
    this.lockPeriod,
    this.visible,
    this.permissionId,
  });

  factory TronHttpDelegateResourceContractRequest.fromJson(
    Map<String, dynamic> json,
  ) {
    return TronHttpDelegateResourceContractRequest(
      ownerAddress:
          (json['owner_address'] is num
              ? json['owner_address'].toString()
              : json.valueAsString('owner_address')),
      resource:
          json.hasValue('resource')
              ? TronHttpDelegateResourceContractRequestResource.fromJson(
                json['resource'],
              )
              : null,
      balance: json.valueAsBigInt('balance'),
      receiverAddress:
          (json['receiver_address'] is num
              ? json['receiver_address'].toString()
              : json.valueAsString('receiver_address')),
      lock: json.valueAsBool('lock'),
      lockPeriod: json.valueAsBigInt('lock_period'),
      visible: json.valueAsBool('visible'),
      permissionId: json.valueAsInt('Permission_id'),
    );
  }

  Map<String, dynamic> toJson() => {
    'owner_address': ownerAddress,
    'resource': resource?.toJson(),
    'balance': balance,
    'receiver_address': receiverAddress,
    'lock': lock,
    'lock_period': lockPeriod,
    'visible': visible,
    'Permission_id': permissionId,
  };
}

class TronHttpDelegatedResource {
  /// Sender account address.
  final String? from;

  /// Recipient account or contract address.
  final String? to;
  final BigInt? frozenBalanceForBandwidth;
  final BigInt? frozenBalanceForEnergy;
  final BigInt? expireTimeForBandwidth;
  final BigInt? expireTimeForEnergy;

  const TronHttpDelegatedResource({
    this.from,
    this.to,
    this.frozenBalanceForBandwidth,
    this.frozenBalanceForEnergy,
    this.expireTimeForBandwidth,
    this.expireTimeForEnergy,
  });

  factory TronHttpDelegatedResource.fromJson(Map<String, dynamic> json) {
    return TronHttpDelegatedResource(
      from:
          (json['from'] is num
              ? json['from'].toString()
              : json.valueAsString('from')),
      to:
          (json['to'] is num
              ? json['to'].toString()
              : json.valueAsString('to')),
      frozenBalanceForBandwidth: json.valueAsBigInt(
        'frozen_balance_for_bandwidth',
      ),
      frozenBalanceForEnergy: json.valueAsBigInt('frozen_balance_for_energy'),
      expireTimeForBandwidth: json.valueAsBigInt('expire_time_for_bandwidth'),
      expireTimeForEnergy: json.valueAsBigInt('expire_time_for_energy'),
    );
  }

  Map<String, dynamic> toJson() => {
    'from': from,
    'to': to,
    'frozen_balance_for_bandwidth': frozenBalanceForBandwidth,
    'frozen_balance_for_energy': frozenBalanceForEnergy,
    'expire_time_for_bandwidth': expireTimeForBandwidth,
    'expire_time_for_energy': expireTimeForEnergy,
  };
}

class TronHttpDelegatedResourceAccountIndex {
  final String? account;
  final List<String>? fromAccounts;
  final List<String>? toAccounts;

  /// Timestamp in milliseconds.
  final BigInt? timestamp;

  const TronHttpDelegatedResourceAccountIndex({
    this.account,
    this.fromAccounts,
    this.toAccounts,
    this.timestamp,
  });

  factory TronHttpDelegatedResourceAccountIndex.fromJson(
    Map<String, dynamic> json,
  ) {
    return TronHttpDelegatedResourceAccountIndex(
      account:
          (json['account'] is num
              ? json['account'].toString()
              : json.valueAsString('account')),
      fromAccounts: json.valueAsList<List<String>?>('fromAccounts'),
      toAccounts: json.valueAsList<List<String>?>('toAccounts'),
      timestamp: json.valueAsBigInt('timestamp'),
    );
  }

  Map<String, dynamic> toJson() => {
    'account': account,
    'fromAccounts': fromAccounts,
    'toAccounts': toAccounts,
    'timestamp': timestamp,
  };
}

class TronHttpDelegatedResourceAccountIndexInt64StringCompatible {
  final String? account;
  final List<String>? fromAccounts;
  final List<String>? toAccounts;

  /// Timestamp in milliseconds.
  final BigInt? timestamp;

  const TronHttpDelegatedResourceAccountIndexInt64StringCompatible({
    this.account,
    this.fromAccounts,
    this.toAccounts,
    this.timestamp,
  });

  factory TronHttpDelegatedResourceAccountIndexInt64StringCompatible.fromJson(
    Map<String, dynamic> json,
  ) {
    return TronHttpDelegatedResourceAccountIndexInt64StringCompatible(
      account:
          (json['account'] is num
              ? json['account'].toString()
              : json.valueAsString('account')),
      fromAccounts: json.valueAsList<List<String>?>('fromAccounts'),
      toAccounts: json.valueAsList<List<String>?>('toAccounts'),
      timestamp: json.valueAsBigInt('timestamp'),
    );
  }

  Map<String, dynamic> toJson() => {
    'account': account,
    'fromAccounts': fromAccounts,
    'toAccounts': toAccounts,
    'timestamp': timestamp,
  };
}

class TronHttpDelegatedResourceInt64StringCompatible {
  /// Sender account address.
  final String? from;

  /// Recipient account or contract address.
  final String? to;
  final BigInt? frozenBalanceForBandwidth;
  final BigInt? frozenBalanceForEnergy;
  final BigInt? expireTimeForBandwidth;
  final BigInt? expireTimeForEnergy;

  const TronHttpDelegatedResourceInt64StringCompatible({
    this.from,
    this.to,
    this.frozenBalanceForBandwidth,
    this.frozenBalanceForEnergy,
    this.expireTimeForBandwidth,
    this.expireTimeForEnergy,
  });

  factory TronHttpDelegatedResourceInt64StringCompatible.fromJson(
    Map<String, dynamic> json,
  ) {
    return TronHttpDelegatedResourceInt64StringCompatible(
      from:
          (json['from'] is num
              ? json['from'].toString()
              : json.valueAsString('from')),
      to:
          (json['to'] is num
              ? json['to'].toString()
              : json.valueAsString('to')),
      frozenBalanceForBandwidth: json.valueAsBigInt(
        'frozen_balance_for_bandwidth',
      ),
      frozenBalanceForEnergy: json.valueAsBigInt('frozen_balance_for_energy'),
      expireTimeForBandwidth: json.valueAsBigInt('expire_time_for_bandwidth'),
      expireTimeForEnergy: json.valueAsBigInt('expire_time_for_energy'),
    );
  }

  Map<String, dynamic> toJson() => {
    'from': from,
    'to': to,
    'frozen_balance_for_bandwidth': frozenBalanceForBandwidth,
    'frozen_balance_for_energy': frozenBalanceForEnergy,
    'expire_time_for_bandwidth': expireTimeForBandwidth,
    'expire_time_for_energy': expireTimeForEnergy,
  };
}

class TronHttpDelegatedResourceList {
  final List<TronHttpDelegatedResource>? delegatedResource;

  const TronHttpDelegatedResourceList({this.delegatedResource});

  factory TronHttpDelegatedResourceList.fromJson(Map<String, dynamic> json) {
    return TronHttpDelegatedResourceList(
      delegatedResource:
          json.hasValue('delegatedResource')
              ? json
                  .valueEnsureAsList<Map<String, dynamic>>('delegatedResource')
                  .map((e) => TronHttpDelegatedResource.fromJson(e))
                  .toList()
              : null,
    );
  }

  Map<String, dynamic> toJson() => {
    'delegatedResource': delegatedResource?.map((e) => e.toJson()).toList(),
  };
}

class TronHttpDelegatedResourceListInt64StringCompatible {
  final List<TronHttpDelegatedResourceInt64StringCompatible>? delegatedResource;

  const TronHttpDelegatedResourceListInt64StringCompatible({
    this.delegatedResource,
  });

  factory TronHttpDelegatedResourceListInt64StringCompatible.fromJson(
    Map<String, dynamic> json,
  ) {
    return TronHttpDelegatedResourceListInt64StringCompatible(
      delegatedResource:
          json.hasValue('delegatedResource')
              ? json
                  .valueEnsureAsList<Map<String, dynamic>>('delegatedResource')
                  .map(
                    (e) =>
                        TronHttpDelegatedResourceInt64StringCompatible.fromJson(
                          e,
                        ),
                  )
                  .toList()
              : null,
    );
  }

  Map<String, dynamic> toJson() => {
    'delegatedResource': delegatedResource?.map((e) => e.toJson()).toList(),
  };
}

/// POST /wallet/getdelegatedresource (request)
/// POST /wallet/getdelegatedresourcev2 (request)
class TronHttpDelegatedResourceMessageRequest {
  /// Source account address.
  final String? fromAddress;

  /// Destination account address.
  final String? toAddress;

  /// When true, addresses are encoded in base58check; when false or omitted, addresses are hex-encoded.
  final bool? visible;

  const TronHttpDelegatedResourceMessageRequest({
    this.fromAddress,
    this.toAddress,
    this.visible,
  });

  factory TronHttpDelegatedResourceMessageRequest.fromJson(
    Map<String, dynamic> json,
  ) {
    return TronHttpDelegatedResourceMessageRequest(
      fromAddress:
          (json['fromAddress'] is num
              ? json['fromAddress'].toString()
              : json.valueAsString('fromAddress')),
      toAddress:
          (json['toAddress'] is num
              ? json['toAddress'].toString()
              : json.valueAsString('toAddress')),
      visible: json.valueAsBool('visible'),
    );
  }

  Map<String, dynamic> toJson() => {
    'fromAddress': fromAddress,
    'toAddress': toAddress,
    'visible': visible,
  };
}

class TronHttpExchangeCreateContract {
  /// Address of the account that owns or initiates the request.
  final String? ownerAddress;
  final String? firstTokenId;
  final BigInt? firstTokenBalance;
  final String? secondTokenId;
  final BigInt? secondTokenBalance;

  const TronHttpExchangeCreateContract({
    this.ownerAddress,
    this.firstTokenId,
    this.firstTokenBalance,
    this.secondTokenId,
    this.secondTokenBalance,
  });

  factory TronHttpExchangeCreateContract.fromJson(Map<String, dynamic> json) {
    return TronHttpExchangeCreateContract(
      ownerAddress:
          (json['owner_address'] is num
              ? json['owner_address'].toString()
              : json.valueAsString('owner_address')),
      firstTokenId:
          (json['first_token_id'] is num
              ? json['first_token_id'].toString()
              : json.valueAsString('first_token_id')),
      firstTokenBalance: json.valueAsBigInt('first_token_balance'),
      secondTokenId:
          (json['second_token_id'] is num
              ? json['second_token_id'].toString()
              : json.valueAsString('second_token_id')),
      secondTokenBalance: json.valueAsBigInt('second_token_balance'),
    );
  }

  Map<String, dynamic> toJson() => {
    'owner_address': ownerAddress,
    'first_token_id': firstTokenId,
    'first_token_balance': firstTokenBalance,
    'second_token_id': secondTokenId,
    'second_token_balance': secondTokenBalance,
  };
}

class TronHttpExchangeCreateContractInt64StringCompatible {
  /// Address of the account that owns or initiates the request.
  final String? ownerAddress;
  final String? firstTokenId;
  final BigInt? firstTokenBalance;
  final String? secondTokenId;
  final BigInt? secondTokenBalance;

  const TronHttpExchangeCreateContractInt64StringCompatible({
    this.ownerAddress,
    this.firstTokenId,
    this.firstTokenBalance,
    this.secondTokenId,
    this.secondTokenBalance,
  });

  factory TronHttpExchangeCreateContractInt64StringCompatible.fromJson(
    Map<String, dynamic> json,
  ) {
    return TronHttpExchangeCreateContractInt64StringCompatible(
      ownerAddress:
          (json['owner_address'] is num
              ? json['owner_address'].toString()
              : json.valueAsString('owner_address')),
      firstTokenId:
          (json['first_token_id'] is num
              ? json['first_token_id'].toString()
              : json.valueAsString('first_token_id')),
      firstTokenBalance: json.valueAsBigInt('first_token_balance'),
      secondTokenId:
          (json['second_token_id'] is num
              ? json['second_token_id'].toString()
              : json.valueAsString('second_token_id')),
      secondTokenBalance: json.valueAsBigInt('second_token_balance'),
    );
  }

  Map<String, dynamic> toJson() => {
    'owner_address': ownerAddress,
    'first_token_id': firstTokenId,
    'first_token_balance': firstTokenBalance,
    'second_token_id': secondTokenId,
    'second_token_balance': secondTokenBalance,
  };
}

class TronHttpExchangeInjectContract {
  /// Address of the account that owns or initiates the request.
  final String? ownerAddress;
  final BigInt? exchangeId;

  /// TRC10 token id.
  final String? tokenId;
  final BigInt? quant;

  const TronHttpExchangeInjectContract({
    this.ownerAddress,
    this.exchangeId,
    this.tokenId,
    this.quant,
  });

  factory TronHttpExchangeInjectContract.fromJson(Map<String, dynamic> json) {
    return TronHttpExchangeInjectContract(
      ownerAddress:
          (json['owner_address'] is num
              ? json['owner_address'].toString()
              : json.valueAsString('owner_address')),
      exchangeId: json.valueAsBigInt('exchange_id'),
      tokenId:
          (json['token_id'] is num
              ? json['token_id'].toString()
              : json.valueAsString('token_id')),
      quant: json.valueAsBigInt('quant'),
    );
  }

  Map<String, dynamic> toJson() => {
    'owner_address': ownerAddress,
    'exchange_id': exchangeId,
    'token_id': tokenId,
    'quant': quant,
  };
}

class TronHttpExchangeInjectContractInt64StringCompatible {
  /// Address of the account that owns or initiates the request.
  final String? ownerAddress;
  final BigInt? exchangeId;

  /// TRC10 token id.
  final String? tokenId;
  final BigInt? quant;

  const TronHttpExchangeInjectContractInt64StringCompatible({
    this.ownerAddress,
    this.exchangeId,
    this.tokenId,
    this.quant,
  });

  factory TronHttpExchangeInjectContractInt64StringCompatible.fromJson(
    Map<String, dynamic> json,
  ) {
    return TronHttpExchangeInjectContractInt64StringCompatible(
      ownerAddress:
          (json['owner_address'] is num
              ? json['owner_address'].toString()
              : json.valueAsString('owner_address')),
      exchangeId: json.valueAsBigInt('exchange_id'),
      tokenId:
          (json['token_id'] is num
              ? json['token_id'].toString()
              : json.valueAsString('token_id')),
      quant: json.valueAsBigInt('quant'),
    );
  }

  Map<String, dynamic> toJson() => {
    'owner_address': ownerAddress,
    'exchange_id': exchangeId,
    'token_id': tokenId,
    'quant': quant,
  };
}

class TronHttpExchangeTransactionContract {
  /// Address of the account that owns or initiates the request.
  final String? ownerAddress;
  final BigInt? exchangeId;

  /// TRC10 token id.
  final String? tokenId;
  final BigInt? quant;
  final BigInt? expected;

  const TronHttpExchangeTransactionContract({
    this.ownerAddress,
    this.exchangeId,
    this.tokenId,
    this.quant,
    this.expected,
  });

  factory TronHttpExchangeTransactionContract.fromJson(
    Map<String, dynamic> json,
  ) {
    return TronHttpExchangeTransactionContract(
      ownerAddress:
          (json['owner_address'] is num
              ? json['owner_address'].toString()
              : json.valueAsString('owner_address')),
      exchangeId: json.valueAsBigInt('exchange_id'),
      tokenId:
          (json['token_id'] is num
              ? json['token_id'].toString()
              : json.valueAsString('token_id')),
      quant: json.valueAsBigInt('quant'),
      expected: json.valueAsBigInt('expected'),
    );
  }

  Map<String, dynamic> toJson() => {
    'owner_address': ownerAddress,
    'exchange_id': exchangeId,
    'token_id': tokenId,
    'quant': quant,
    'expected': expected,
  };
}

class TronHttpExchangeTransactionContractInt64StringCompatible {
  /// Address of the account that owns or initiates the request.
  final String? ownerAddress;
  final BigInt? exchangeId;

  /// TRC10 token id.
  final String? tokenId;
  final BigInt? quant;
  final BigInt? expected;

  const TronHttpExchangeTransactionContractInt64StringCompatible({
    this.ownerAddress,
    this.exchangeId,
    this.tokenId,
    this.quant,
    this.expected,
  });

  factory TronHttpExchangeTransactionContractInt64StringCompatible.fromJson(
    Map<String, dynamic> json,
  ) {
    return TronHttpExchangeTransactionContractInt64StringCompatible(
      ownerAddress:
          (json['owner_address'] is num
              ? json['owner_address'].toString()
              : json.valueAsString('owner_address')),
      exchangeId: json.valueAsBigInt('exchange_id'),
      tokenId:
          (json['token_id'] is num
              ? json['token_id'].toString()
              : json.valueAsString('token_id')),
      quant: json.valueAsBigInt('quant'),
      expected: json.valueAsBigInt('expected'),
    );
  }

  Map<String, dynamic> toJson() => {
    'owner_address': ownerAddress,
    'exchange_id': exchangeId,
    'token_id': tokenId,
    'quant': quant,
    'expected': expected,
  };
}

class TronHttpExchangeWithdrawContract {
  /// Address of the account that owns or initiates the request.
  final String? ownerAddress;
  final BigInt? exchangeId;

  /// TRC10 token id.
  final String? tokenId;
  final BigInt? quant;

  const TronHttpExchangeWithdrawContract({
    this.ownerAddress,
    this.exchangeId,
    this.tokenId,
    this.quant,
  });

  factory TronHttpExchangeWithdrawContract.fromJson(Map<String, dynamic> json) {
    return TronHttpExchangeWithdrawContract(
      ownerAddress:
          (json['owner_address'] is num
              ? json['owner_address'].toString()
              : json.valueAsString('owner_address')),
      exchangeId: json.valueAsBigInt('exchange_id'),
      tokenId:
          (json['token_id'] is num
              ? json['token_id'].toString()
              : json.valueAsString('token_id')),
      quant: json.valueAsBigInt('quant'),
    );
  }

  Map<String, dynamic> toJson() => {
    'owner_address': ownerAddress,
    'exchange_id': exchangeId,
    'token_id': tokenId,
    'quant': quant,
  };
}

class TronHttpExchangeWithdrawContractInt64StringCompatible {
  /// Address of the account that owns or initiates the request.
  final String? ownerAddress;
  final BigInt? exchangeId;

  /// TRC10 token id.
  final String? tokenId;
  final BigInt? quant;

  const TronHttpExchangeWithdrawContractInt64StringCompatible({
    this.ownerAddress,
    this.exchangeId,
    this.tokenId,
    this.quant,
  });

  factory TronHttpExchangeWithdrawContractInt64StringCompatible.fromJson(
    Map<String, dynamic> json,
  ) {
    return TronHttpExchangeWithdrawContractInt64StringCompatible(
      ownerAddress:
          (json['owner_address'] is num
              ? json['owner_address'].toString()
              : json.valueAsString('owner_address')),
      exchangeId: json.valueAsBigInt('exchange_id'),
      tokenId:
          (json['token_id'] is num
              ? json['token_id'].toString()
              : json.valueAsString('token_id')),
      quant: json.valueAsBigInt('quant'),
    );
  }

  Map<String, dynamic> toJson() => {
    'owner_address': ownerAddress,
    'exchange_id': exchangeId,
    'token_id': tokenId,
    'quant': quant,
  };
}

class TronHttpFreezeBalanceContract {
  /// Address of the account that owns or initiates the request.
  final String? ownerAddress;

  /// Amount to freeze in sun, where 1 TRX equals 1,000,000 sun.
  final BigInt? frozenBalance;

  /// Freeze duration in days.
  final BigInt? frozenDuration;

  /// Resource type.
  final TronHttpAccountFreezeV2Type? resource;

  /// Address of the account receiving resources or funds.
  final String? receiverAddress;

  const TronHttpFreezeBalanceContract({
    this.ownerAddress,
    this.frozenBalance,
    this.frozenDuration,
    this.resource,
    this.receiverAddress,
  });

  factory TronHttpFreezeBalanceContract.fromJson(Map<String, dynamic> json) {
    return TronHttpFreezeBalanceContract(
      ownerAddress:
          (json['owner_address'] is num
              ? json['owner_address'].toString()
              : json.valueAsString('owner_address')),
      frozenBalance: json.valueAsBigInt('frozen_balance'),
      frozenDuration: json.valueAsBigInt('frozen_duration'),
      resource:
          json.hasValue('resource')
              ? TronHttpAccountFreezeV2Type.fromJson(json['resource'])
              : null,
      receiverAddress:
          (json['receiver_address'] is num
              ? json['receiver_address'].toString()
              : json.valueAsString('receiver_address')),
    );
  }

  Map<String, dynamic> toJson() => {
    'owner_address': ownerAddress,
    'frozen_balance': frozenBalance,
    'frozen_duration': frozenDuration,
    'resource': resource?.toJson(),
    'receiver_address': receiverAddress,
  };
}

class TronHttpFreezeBalanceContractInt64StringCompatible {
  /// Address of the account that owns or initiates the request.
  final String? ownerAddress;

  /// Amount to freeze in sun, where 1 TRX equals 1,000,000 sun.
  final BigInt? frozenBalance;

  /// Freeze duration in days.
  final BigInt? frozenDuration;

  /// Resource type.
  final TronHttpAccountFreezeV2Type? resource;

  /// Address of the account receiving resources or funds.
  final String? receiverAddress;

  const TronHttpFreezeBalanceContractInt64StringCompatible({
    this.ownerAddress,
    this.frozenBalance,
    this.frozenDuration,
    this.resource,
    this.receiverAddress,
  });

  factory TronHttpFreezeBalanceContractInt64StringCompatible.fromJson(
    Map<String, dynamic> json,
  ) {
    return TronHttpFreezeBalanceContractInt64StringCompatible(
      ownerAddress:
          (json['owner_address'] is num
              ? json['owner_address'].toString()
              : json.valueAsString('owner_address')),
      frozenBalance: json.valueAsBigInt('frozen_balance'),
      frozenDuration: json.valueAsBigInt('frozen_duration'),
      resource:
          json.hasValue('resource')
              ? TronHttpAccountFreezeV2Type.fromJson(json['resource'])
              : null,
      receiverAddress:
          (json['receiver_address'] is num
              ? json['receiver_address'].toString()
              : json.valueAsString('receiver_address')),
    );
  }

  Map<String, dynamic> toJson() => {
    'owner_address': ownerAddress,
    'frozen_balance': frozenBalance,
    'frozen_duration': frozenDuration,
    'resource': resource?.toJson(),
    'receiver_address': receiverAddress,
  };
}

class TronHttpFreezeBalanceContractRequest {
  /// Address of the account that owns or initiates the request.
  final String ownerAddress;

  /// Amount to freeze in sun, where 1 TRX equals 1,000,000 sun.
  final BigInt frozenBalance;

  /// Freeze duration in days.
  final BigInt? frozenDuration;

  /// Resource type to freeze. TRON_POWER is accepted only when the chain supports the new resource model (`supportAllowNewResourceModel()`).
  final TronHttpFreezeBalanceContractRequestResource? resource;

  /// Address of the account receiving resources or funds.
  final String? receiverAddress;

  /// When true, addresses are encoded in base58check; when false or omitted, addresses are hex-encoded.
  final bool? visible;

  /// Permission id used to sign the transaction with a non-owner account permission.
  final int? permissionId;

  const TronHttpFreezeBalanceContractRequest({
    required this.ownerAddress,
    required this.frozenBalance,
    this.frozenDuration,
    this.resource,
    this.receiverAddress,
    this.visible,
    this.permissionId,
  });

  factory TronHttpFreezeBalanceContractRequest.fromJson(
    Map<String, dynamic> json,
  ) {
    return TronHttpFreezeBalanceContractRequest(
      ownerAddress:
          (json['owner_address'] is num
              ? json['owner_address'].toString()
              : json.valueAsString('owner_address')),
      frozenBalance: json.valueAsBigInt('frozen_balance'),
      frozenDuration: json.valueAsBigInt('frozen_duration'),
      resource:
          json.hasValue('resource')
              ? TronHttpFreezeBalanceContractRequestResource.fromJson(
                json['resource'],
              )
              : null,
      receiverAddress:
          (json['receiver_address'] is num
              ? json['receiver_address'].toString()
              : json.valueAsString('receiver_address')),
      visible: json.valueAsBool('visible'),
      permissionId: json.valueAsInt('Permission_id'),
    );
  }

  Map<String, dynamic> toJson() => {
    'owner_address': ownerAddress,
    'frozen_balance': frozenBalance,
    'frozen_duration': frozenDuration,
    'resource': resource?.toJson(),
    'receiver_address': receiverAddress,
    'visible': visible,
    'Permission_id': permissionId,
  };
}

class TronHttpFreezeBalanceV2Contract {
  /// Address of the account that owns or initiates the request.
  final String? ownerAddress;

  /// Amount to freeze in sun, where 1 TRX equals 1,000,000 sun.
  final BigInt? frozenBalance;

  /// Resource type.
  final TronHttpAccountFreezeV2Type? resource;

  const TronHttpFreezeBalanceV2Contract({
    this.ownerAddress,
    this.frozenBalance,
    this.resource,
  });

  factory TronHttpFreezeBalanceV2Contract.fromJson(Map<String, dynamic> json) {
    return TronHttpFreezeBalanceV2Contract(
      ownerAddress:
          (json['owner_address'] is num
              ? json['owner_address'].toString()
              : json.valueAsString('owner_address')),
      frozenBalance: json.valueAsBigInt('frozen_balance'),
      resource:
          json.hasValue('resource')
              ? TronHttpAccountFreezeV2Type.fromJson(json['resource'])
              : null,
    );
  }

  Map<String, dynamic> toJson() => {
    'owner_address': ownerAddress,
    'frozen_balance': frozenBalance,
    'resource': resource?.toJson(),
  };
}

class TronHttpFreezeBalanceV2ContractInt64StringCompatible {
  /// Address of the account that owns or initiates the request.
  final String? ownerAddress;

  /// Amount to freeze in sun, where 1 TRX equals 1,000,000 sun.
  final BigInt? frozenBalance;

  /// Resource type.
  final TronHttpAccountFreezeV2Type? resource;

  const TronHttpFreezeBalanceV2ContractInt64StringCompatible({
    this.ownerAddress,
    this.frozenBalance,
    this.resource,
  });

  factory TronHttpFreezeBalanceV2ContractInt64StringCompatible.fromJson(
    Map<String, dynamic> json,
  ) {
    return TronHttpFreezeBalanceV2ContractInt64StringCompatible(
      ownerAddress:
          (json['owner_address'] is num
              ? json['owner_address'].toString()
              : json.valueAsString('owner_address')),
      frozenBalance: json.valueAsBigInt('frozen_balance'),
      resource:
          json.hasValue('resource')
              ? TronHttpAccountFreezeV2Type.fromJson(json['resource'])
              : null,
    );
  }

  Map<String, dynamic> toJson() => {
    'owner_address': ownerAddress,
    'frozen_balance': frozenBalance,
    'resource': resource?.toJson(),
  };
}

class TronHttpFreezeBalanceV2ContractRequest {
  /// Address of the account that owns or initiates the request.
  final String ownerAddress;

  /// Amount to freeze in sun, where 1 TRX equals 1,000,000 sun.
  final BigInt frozenBalance;

  /// Resource type to freeze. TRON_POWER is accepted only when the chain supports the new resource model (`supportAllowNewResourceModel()`).
  final TronHttpFreezeBalanceContractRequestResource? resource;

  /// When true, addresses are encoded in base58check; when false or omitted, addresses are hex-encoded.
  final bool? visible;

  /// Permission id used to sign the transaction with a non-owner account permission.
  final int? permissionId;

  const TronHttpFreezeBalanceV2ContractRequest({
    required this.ownerAddress,
    required this.frozenBalance,
    this.resource,
    this.visible,
    this.permissionId,
  });

  factory TronHttpFreezeBalanceV2ContractRequest.fromJson(
    Map<String, dynamic> json,
  ) {
    return TronHttpFreezeBalanceV2ContractRequest(
      ownerAddress:
          (json['owner_address'] is num
              ? json['owner_address'].toString()
              : json.valueAsString('owner_address')),
      frozenBalance: json.valueAsBigInt('frozen_balance'),
      resource:
          json.hasValue('resource')
              ? TronHttpFreezeBalanceContractRequestResource.fromJson(
                json['resource'],
              )
              : null,
      visible: json.valueAsBool('visible'),
      permissionId: json.valueAsInt('Permission_id'),
    );
  }

  Map<String, dynamic> toJson() => {
    'owner_address': ownerAddress,
    'frozen_balance': frozenBalance,
    'resource': resource?.toJson(),
    'visible': visible,
    'Permission_id': permissionId,
  };
}

/// POST /wallet/getavailableunfreezecount (request)
class TronHttpGetAvailableUnfreezeCountRequestMessageRequest {
  /// Address of the account that owns or initiates the request.
  final String? ownerAddress;

  /// When true, addresses are encoded in base58check; when false or omitted, addresses are hex-encoded.
  final bool? visible;

  const TronHttpGetAvailableUnfreezeCountRequestMessageRequest({
    this.ownerAddress,
    this.visible,
  });

  factory TronHttpGetAvailableUnfreezeCountRequestMessageRequest.fromJson(
    Map<String, dynamic> json,
  ) {
    return TronHttpGetAvailableUnfreezeCountRequestMessageRequest(
      ownerAddress:
          (json['owner_address'] is num
              ? json['owner_address'].toString()
              : json.valueAsString('owner_address')),
      visible: json.valueAsBool('visible'),
    );
  }

  Map<String, dynamic> toJson() => {
    'owner_address': ownerAddress,
    'visible': visible,
  };
}

class TronHttpGetAvailableUnfreezeCountResponseMessage {
  final BigInt? count;

  const TronHttpGetAvailableUnfreezeCountResponseMessage({this.count});

  factory TronHttpGetAvailableUnfreezeCountResponseMessage.fromJson(
    Map<String, dynamic> json,
  ) {
    return TronHttpGetAvailableUnfreezeCountResponseMessage(
      count: json.valueAsBigInt('count'),
    );
  }

  Map<String, dynamic> toJson() => {'count': count};
}

class TronHttpGetAvailableUnfreezeCountResponseMessageInt64StringCompatible {
  final BigInt? count;

  const TronHttpGetAvailableUnfreezeCountResponseMessageInt64StringCompatible({
    this.count,
  });

  factory TronHttpGetAvailableUnfreezeCountResponseMessageInt64StringCompatible.fromJson(
    Map<String, dynamic> json,
  ) {
    return TronHttpGetAvailableUnfreezeCountResponseMessageInt64StringCompatible(
      count: json.valueAsBigInt('count'),
    );
  }

  Map<String, dynamic> toJson() => {'count': count};
}

class TronHttpInternalTransaction {
  /// Block or transaction hash.
  final String? hash;
  final String? callerAddress;
  final String? transferToAddress;
  final List<TronHttpInternalTransactionCallValueInfo>? callValueInfo;
  final String? note;
  final bool? rejected;
  final String? extra;

  const TronHttpInternalTransaction({
    this.hash,
    this.callerAddress,
    this.transferToAddress,
    this.callValueInfo,
    this.note,
    this.rejected,
    this.extra,
  });

  factory TronHttpInternalTransaction.fromJson(Map<String, dynamic> json) {
    return TronHttpInternalTransaction(
      hash:
          (json['hash'] is num
              ? json['hash'].toString()
              : json.valueAsString('hash')),
      callerAddress:
          (json['caller_address'] is num
              ? json['caller_address'].toString()
              : json.valueAsString('caller_address')),
      transferToAddress:
          (json['transferTo_address'] is num
              ? json['transferTo_address'].toString()
              : json.valueAsString('transferTo_address')),
      callValueInfo:
          json.hasValue('callValueInfo')
              ? json
                  .valueEnsureAsList<Map<String, dynamic>>('callValueInfo')
                  .map(
                    (e) => TronHttpInternalTransactionCallValueInfo.fromJson(e),
                  )
                  .toList()
              : null,
      note:
          (json['note'] is num
              ? json['note'].toString()
              : json.valueAsString('note')),
      rejected: json.valueAsBool('rejected'),
      extra:
          (json['extra'] is num
              ? json['extra'].toString()
              : json.valueAsString('extra')),
    );
  }

  Map<String, dynamic> toJson() => {
    'hash': hash,
    'caller_address': callerAddress,
    'transferTo_address': transferToAddress,
    'callValueInfo': callValueInfo?.map((e) => e.toJson()).toList(),
    'note': note,
    'rejected': rejected,
    'extra': extra,
  };
}

class TronHttpInternalTransactionCallValueInfo {
  final BigInt? callValue;

  /// TRC10 token id.
  final String? tokenId;

  const TronHttpInternalTransactionCallValueInfo({
    this.callValue,
    this.tokenId,
  });

  factory TronHttpInternalTransactionCallValueInfo.fromJson(
    Map<String, dynamic> json,
  ) {
    return TronHttpInternalTransactionCallValueInfo(
      callValue: json.valueAsBigInt('callValue'),
      tokenId:
          (json['tokenId'] is num
              ? json['tokenId'].toString()
              : json.valueAsString('tokenId')),
    );
  }

  Map<String, dynamic> toJson() => {'callValue': callValue, 'tokenId': tokenId};
}

class TronHttpInternalTransactionCallValueInfoInt64StringCompatible {
  final BigInt? callValue;

  /// TRC10 token id.
  final String? tokenId;

  const TronHttpInternalTransactionCallValueInfoInt64StringCompatible({
    this.callValue,
    this.tokenId,
  });

  factory TronHttpInternalTransactionCallValueInfoInt64StringCompatible.fromJson(
    Map<String, dynamic> json,
  ) {
    return TronHttpInternalTransactionCallValueInfoInt64StringCompatible(
      callValue: json.valueAsBigInt('callValue'),
      tokenId:
          (json['tokenId'] is num
              ? json['tokenId'].toString()
              : json.valueAsString('tokenId')),
    );
  }

  Map<String, dynamic> toJson() => {'callValue': callValue, 'tokenId': tokenId};
}

class TronHttpInternalTransactionInt64StringCompatible {
  /// Block or transaction hash.
  final String? hash;
  final String? callerAddress;
  final String? transferToAddress;
  final List<TronHttpInternalTransactionCallValueInfoInt64StringCompatible>?
  callValueInfo;
  final String? note;
  final bool? rejected;
  final String? extra;

  const TronHttpInternalTransactionInt64StringCompatible({
    this.hash,
    this.callerAddress,
    this.transferToAddress,
    this.callValueInfo,
    this.note,
    this.rejected,
    this.extra,
  });

  factory TronHttpInternalTransactionInt64StringCompatible.fromJson(
    Map<String, dynamic> json,
  ) {
    return TronHttpInternalTransactionInt64StringCompatible(
      hash:
          (json['hash'] is num
              ? json['hash'].toString()
              : json.valueAsString('hash')),
      callerAddress:
          (json['caller_address'] is num
              ? json['caller_address'].toString()
              : json.valueAsString('caller_address')),
      transferToAddress:
          (json['transferTo_address'] is num
              ? json['transferTo_address'].toString()
              : json.valueAsString('transferTo_address')),
      callValueInfo:
          json.hasValue('callValueInfo')
              ? json
                  .valueEnsureAsList<Map<String, dynamic>>('callValueInfo')
                  .map(
                    (e) =>
                        TronHttpInternalTransactionCallValueInfoInt64StringCompatible.fromJson(
                          e,
                        ),
                  )
                  .toList()
              : null,
      note:
          (json['note'] is num
              ? json['note'].toString()
              : json.valueAsString('note')),
      rejected: json.valueAsBool('rejected'),
      extra:
          (json['extra'] is num
              ? json['extra'].toString()
              : json.valueAsString('extra')),
    );
  }

  Map<String, dynamic> toJson() => {
    'hash': hash,
    'caller_address': callerAddress,
    'transferTo_address': transferToAddress,
    'callValueInfo': callValueInfo?.map((e) => e.toJson()).toList(),
    'note': note,
    'rejected': rejected,
    'extra': extra,
  };
}

/// Legacy java-tron error payload. Error is free-form and has no wire-level code; use x-tron-in-band-error and the top-level x-tron-error-model catalog for classification and retry policy.
///
/// GET /wallet/getaccount (response)
/// POST /wallet/getaccount (response)
/// POST /wallet/getaccountbalance (response)
/// GET /wallet/getaccountnet (response)
/// POST /wallet/getaccountnet (response)
/// GET /wallet/getaccountresource (response)
/// POST /wallet/getaccountresource (response)
/// POST /wallet/createaccount (response)
/// POST /wallet/updateaccount (response)
/// POST /wallet/accountpermissionupdate (response)
/// GET /wallet/validateaddress (response)
/// POST /wallet/validateaddress (response)
/// GET /wallet/getnowblock (response)
/// POST /wallet/getnowblock (response)
/// GET /wallet/getblock (response)
/// POST /wallet/getblock (response)
/// GET /wallet/getblockbynum (response)
/// POST /wallet/getblockbynum (response)
/// GET /wallet/getblockbyid (response)
/// POST /wallet/getblockbyid (response)
/// GET /wallet/getblockbylimitnext (response)
/// POST /wallet/getblockbylimitnext (response)
/// GET /wallet/getblockbylatestnum (response)
/// POST /wallet/getblockbylatestnum (response)
/// POST /wallet/getblockbalance (response)
/// GET /wallet/gettransactioncountbyblocknum (response)
/// POST /wallet/gettransactioncountbyblocknum (response)
/// GET /wallet/gettransactionbyid (response)
/// POST /wallet/gettransactionbyid (response)
/// GET /wallet/gettransactioninfobyid (response)
/// POST /wallet/gettransactioninfobyid (response)
/// GET /wallet/gettransactioninfobyblocknum (response)
/// POST /wallet/gettransactioninfobyblocknum (response)
/// GET /wallet/getpendingsize (response)
/// POST /wallet/getpendingsize (response)
/// GET /wallet/gettransactionfrompending (response)
/// POST /wallet/gettransactionfrompending (response)
/// GET /wallet/gettransactionlistfrompending (response)
/// POST /wallet/gettransactionlistfrompending (response)
/// POST /wallet/createtransaction (response)
/// POST /wallet/getsignweight (response)
/// POST /wallet/getapprovedlist (response)
/// POST /wallet/broadcasttransaction (response)
/// POST /wallet/broadcasthex (response)
/// POST /wallet/createassetissue (response)
/// POST /wallet/updateasset (response)
/// POST /wallet/transferasset (response)
/// POST /wallet/participateassetissue (response)
/// POST /wallet/unfreezeasset (response)
/// GET /wallet/getassetissuebyid (response)
/// POST /wallet/getassetissuebyid (response)
/// GET /wallet/getassetissuebyname (response)
/// POST /wallet/getassetissuebyname (response)
/// GET /wallet/getassetissuelistbyname (response)
/// POST /wallet/getassetissuelistbyname (response)
/// GET /wallet/getassetissuebyaccount (response)
/// POST /wallet/getassetissuebyaccount (response)
/// GET /wallet/getassetissuelist (response)
/// POST /wallet/getassetissuelist (response)
/// GET /wallet/getpaginatedassetissuelist (response)
/// POST /wallet/getpaginatedassetissuelist (response)
/// POST /wallet/deploycontract (response)
/// POST /wallet/triggersmartcontract (response)
/// POST /wallet/triggerconstantcontract (response)
/// POST /wallet/estimateenergy (response)
/// GET /wallet/getcontract (response)
/// POST /wallet/getcontract (response)
/// GET /wallet/getcontractinfo (response)
/// POST /wallet/getcontractinfo (response)
/// POST /wallet/clearabi (response)
/// POST /wallet/updatesetting (response)
/// POST /wallet/updateenergylimit (response)
/// POST /wallet/createwitness (response)
/// POST /wallet/updatewitness (response)
/// GET /wallet/listwitnesses (response)
/// POST /wallet/listwitnesses (response)
/// GET /wallet/getpaginatednowwitnesslist (response)
/// POST /wallet/getpaginatednowwitnesslist (response)
/// POST /wallet/votewitnessaccount (response)
/// GET /wallet/getBrokerage (response)
/// POST /wallet/getBrokerage (response)
/// POST /wallet/updateBrokerage (response)
/// GET /wallet/getReward (response)
/// POST /wallet/getReward (response)
/// POST /wallet/withdrawbalance (response)
/// POST /wallet/proposalcreate (response)
/// POST /wallet/proposalapprove (response)
/// POST /wallet/proposaldelete (response)
/// GET /wallet/listproposals (response)
/// POST /wallet/listproposals (response)
/// GET /wallet/getproposalbyid (response)
/// POST /wallet/getproposalbyid (response)
/// GET /wallet/getpaginatedproposallist (response)
/// POST /wallet/getpaginatedproposallist (response)
/// GET /wallet/getchainparameters (response)
/// POST /wallet/getchainparameters (response)
/// GET /wallet/getnextmaintenancetime (response)
/// POST /wallet/getnextmaintenancetime (response)
/// POST /wallet/freezebalance (response)
/// POST /wallet/unfreezebalance (response)
/// GET /wallet/getdelegatedresource (response)
/// POST /wallet/getdelegatedresource (response)
/// GET /wallet/getdelegatedresourceaccountindex (response)
/// POST /wallet/getdelegatedresourceaccountindex (response)
/// POST /wallet/freezebalancev2 (response)
/// POST /wallet/unfreezebalancev2 (response)
/// POST /wallet/withdrawexpireunfreeze (response)
/// POST /wallet/cancelallunfreezev2 (response)
/// POST /wallet/delegateresource (response)
/// POST /wallet/undelegateresource (response)
/// GET /wallet/getdelegatedresourcev2 (response)
/// POST /wallet/getdelegatedresourcev2 (response)
/// GET /wallet/getdelegatedresourceaccountindexv2 (response)
/// POST /wallet/getdelegatedresourceaccountindexv2 (response)
/// GET /wallet/getcandelegatedmaxsize (response)
/// POST /wallet/getcandelegatedmaxsize (response)
/// GET /wallet/getavailableunfreezecount (response)
/// POST /wallet/getavailableunfreezecount (response)
/// GET /wallet/getcanwithdrawunfreezeamount (response)
/// POST /wallet/getcanwithdrawunfreezeamount (response)
/// GET /wallet/getnodeinfo (response)
/// POST /wallet/getnodeinfo (response)
/// GET /wallet/listnodes (response)
/// POST /wallet/listnodes (response)
/// GET /wallet/getenergyprices (response)
/// POST /wallet/getenergyprices (response)
/// GET /wallet/getbandwidthprices (response)
/// POST /wallet/getbandwidthprices (response)
/// GET /wallet/getburntrx (response)
/// POST /wallet/getburntrx (response)
class TronHttpJavaTronError {
  /// Exception class/message or shared-layer rejection text.
  final String error;

  const TronHttpJavaTronError({required this.error});

  factory TronHttpJavaTronError.fromJson(Map<String, dynamic> json) {
    return TronHttpJavaTronError(
      error:
          (json['Error'] is num
              ? json['Error'].toString()
              : json.valueAsString('Error')),
    );
  }

  Map<String, dynamic> toJson() => {'Error': error};
}

class TronHttpKey {
  /// Account or contract address accepted by this endpoint.
  final String? address;
  final BigInt? weight;

  const TronHttpKey({this.address, this.weight});

  factory TronHttpKey.fromJson(Map<String, dynamic> json) {
    return TronHttpKey(
      address:
          (json['address'] is num
              ? json['address'].toString()
              : json.valueAsString('address')),
      weight: json.valueAsBigInt('weight'),
    );
  }

  Map<String, dynamic> toJson() => {'address': address, 'weight': weight};
}

class TronHttpKeyInt64StringCompatible {
  /// Account or contract address accepted by this endpoint.
  final String? address;
  final BigInt? weight;

  const TronHttpKeyInt64StringCompatible({this.address, this.weight});

  factory TronHttpKeyInt64StringCompatible.fromJson(Map<String, dynamic> json) {
    return TronHttpKeyInt64StringCompatible(
      address:
          (json['address'] is num
              ? json['address'].toString()
              : json.valueAsString('address')),
      weight: json.valueAsBigInt('weight'),
    );
  }

  Map<String, dynamic> toJson() => {'address': address, 'weight': weight};
}

class TronHttpMarketCancelOrderContract {
  /// Address of the account that owns or initiates the request.
  final String? ownerAddress;
  final String? orderId;

  const TronHttpMarketCancelOrderContract({this.ownerAddress, this.orderId});

  factory TronHttpMarketCancelOrderContract.fromJson(
    Map<String, dynamic> json,
  ) {
    return TronHttpMarketCancelOrderContract(
      ownerAddress:
          (json['owner_address'] is num
              ? json['owner_address'].toString()
              : json.valueAsString('owner_address')),
      orderId:
          (json['order_id'] is num
              ? json['order_id'].toString()
              : json.valueAsString('order_id')),
    );
  }

  Map<String, dynamic> toJson() => {
    'owner_address': ownerAddress,
    'order_id': orderId,
  };
}

class TronHttpMarketOrderDetail {
  final String? makerOrderId;
  final String? takerOrderId;
  final BigInt? fillSellQuantity;
  final BigInt? fillBuyQuantity;

  const TronHttpMarketOrderDetail({
    this.makerOrderId,
    this.takerOrderId,
    this.fillSellQuantity,
    this.fillBuyQuantity,
  });

  factory TronHttpMarketOrderDetail.fromJson(Map<String, dynamic> json) {
    return TronHttpMarketOrderDetail(
      makerOrderId:
          (json['makerOrderId'] is num
              ? json['makerOrderId'].toString()
              : json.valueAsString('makerOrderId')),
      takerOrderId:
          (json['takerOrderId'] is num
              ? json['takerOrderId'].toString()
              : json.valueAsString('takerOrderId')),
      fillSellQuantity: json.valueAsBigInt('fillSellQuantity'),
      fillBuyQuantity: json.valueAsBigInt('fillBuyQuantity'),
    );
  }

  Map<String, dynamic> toJson() => {
    'makerOrderId': makerOrderId,
    'takerOrderId': takerOrderId,
    'fillSellQuantity': fillSellQuantity,
    'fillBuyQuantity': fillBuyQuantity,
  };
}

class TronHttpMarketOrderDetailInt64StringCompatible {
  final String? makerOrderId;
  final String? takerOrderId;
  final BigInt? fillSellQuantity;
  final BigInt? fillBuyQuantity;

  const TronHttpMarketOrderDetailInt64StringCompatible({
    this.makerOrderId,
    this.takerOrderId,
    this.fillSellQuantity,
    this.fillBuyQuantity,
  });

  factory TronHttpMarketOrderDetailInt64StringCompatible.fromJson(
    Map<String, dynamic> json,
  ) {
    return TronHttpMarketOrderDetailInt64StringCompatible(
      makerOrderId:
          (json['makerOrderId'] is num
              ? json['makerOrderId'].toString()
              : json.valueAsString('makerOrderId')),
      takerOrderId:
          (json['takerOrderId'] is num
              ? json['takerOrderId'].toString()
              : json.valueAsString('takerOrderId')),
      fillSellQuantity: json.valueAsBigInt('fillSellQuantity'),
      fillBuyQuantity: json.valueAsBigInt('fillBuyQuantity'),
    );
  }

  Map<String, dynamic> toJson() => {
    'makerOrderId': makerOrderId,
    'takerOrderId': takerOrderId,
    'fillSellQuantity': fillSellQuantity,
    'fillBuyQuantity': fillBuyQuantity,
  };
}

class TronHttpMarketSellAssetContract {
  /// Address of the account that owns or initiates the request.
  final String? ownerAddress;
  final String? sellTokenId;
  final BigInt? sellTokenQuantity;
  final String? buyTokenId;
  final BigInt? buyTokenQuantity;

  const TronHttpMarketSellAssetContract({
    this.ownerAddress,
    this.sellTokenId,
    this.sellTokenQuantity,
    this.buyTokenId,
    this.buyTokenQuantity,
  });

  factory TronHttpMarketSellAssetContract.fromJson(Map<String, dynamic> json) {
    return TronHttpMarketSellAssetContract(
      ownerAddress:
          (json['owner_address'] is num
              ? json['owner_address'].toString()
              : json.valueAsString('owner_address')),
      sellTokenId:
          (json['sell_token_id'] is num
              ? json['sell_token_id'].toString()
              : json.valueAsString('sell_token_id')),
      sellTokenQuantity: json.valueAsBigInt('sell_token_quantity'),
      buyTokenId:
          (json['buy_token_id'] is num
              ? json['buy_token_id'].toString()
              : json.valueAsString('buy_token_id')),
      buyTokenQuantity: json.valueAsBigInt('buy_token_quantity'),
    );
  }

  Map<String, dynamic> toJson() => {
    'owner_address': ownerAddress,
    'sell_token_id': sellTokenId,
    'sell_token_quantity': sellTokenQuantity,
    'buy_token_id': buyTokenId,
    'buy_token_quantity': buyTokenQuantity,
  };
}

class TronHttpMarketSellAssetContractInt64StringCompatible {
  /// Address of the account that owns or initiates the request.
  final String? ownerAddress;
  final String? sellTokenId;
  final BigInt? sellTokenQuantity;
  final String? buyTokenId;
  final BigInt? buyTokenQuantity;

  const TronHttpMarketSellAssetContractInt64StringCompatible({
    this.ownerAddress,
    this.sellTokenId,
    this.sellTokenQuantity,
    this.buyTokenId,
    this.buyTokenQuantity,
  });

  factory TronHttpMarketSellAssetContractInt64StringCompatible.fromJson(
    Map<String, dynamic> json,
  ) {
    return TronHttpMarketSellAssetContractInt64StringCompatible(
      ownerAddress:
          (json['owner_address'] is num
              ? json['owner_address'].toString()
              : json.valueAsString('owner_address')),
      sellTokenId:
          (json['sell_token_id'] is num
              ? json['sell_token_id'].toString()
              : json.valueAsString('sell_token_id')),
      sellTokenQuantity: json.valueAsBigInt('sell_token_quantity'),
      buyTokenId:
          (json['buy_token_id'] is num
              ? json['buy_token_id'].toString()
              : json.valueAsString('buy_token_id')),
      buyTokenQuantity: json.valueAsBigInt('buy_token_quantity'),
    );
  }

  Map<String, dynamic> toJson() => {
    'owner_address': ownerAddress,
    'sell_token_id': sellTokenId,
    'sell_token_quantity': sellTokenQuantity,
    'buy_token_id': buyTokenId,
    'buy_token_quantity': buyTokenQuantity,
  };
}

class TronHttpNode {
  final TronHttpAddress? address;

  const TronHttpNode({this.address});

  factory TronHttpNode.fromJson(Map<String, dynamic> json) {
    return TronHttpNode(
      address: json.valueTo<TronHttpAddress?, Map<String, dynamic>>(
        key: 'address',
        parse: (v) => TronHttpAddress.fromJson(v),
      ),
    );
  }

  Map<String, dynamic> toJson() => {'address': address?.toJson()};
}

class TronHttpNodeInfo {
  final BigInt? beginSyncNum;
  final String? block;
  final String? solidityBlock;
  final int? currentConnectCount;
  final int? activeConnectCount;
  final int? passiveConnectCount;
  final BigInt? totalFlow;
  final TronHttpNodeInfoConfigNodeInfo? configNodeInfo;
  final TronHttpNodeInfoMachineInfo? machineInfo;
  final Map<String, String>? cheatWitnessInfoMap;
  final List<TronHttpNodeInfoPeerInfo>? peerList;

  const TronHttpNodeInfo({
    this.beginSyncNum,
    this.block,
    this.solidityBlock,
    this.currentConnectCount,
    this.activeConnectCount,
    this.passiveConnectCount,
    this.totalFlow,
    this.configNodeInfo,
    this.machineInfo,
    this.cheatWitnessInfoMap,
    this.peerList,
  });

  factory TronHttpNodeInfo.fromJson(Map<String, dynamic> json) {
    return TronHttpNodeInfo(
      beginSyncNum: json.valueAsBigInt('beginSyncNum'),
      block:
          (json['block'] is num
              ? json['block'].toString()
              : json.valueAsString('block')),
      solidityBlock:
          (json['solidityBlock'] is num
              ? json['solidityBlock'].toString()
              : json.valueAsString('solidityBlock')),
      currentConnectCount: json.valueAsInt('currentConnectCount'),
      activeConnectCount: json.valueAsInt('activeConnectCount'),
      passiveConnectCount: json.valueAsInt('passiveConnectCount'),
      totalFlow: json.valueAsBigInt('totalFlow'),
      configNodeInfo: json
          .valueTo<TronHttpNodeInfoConfigNodeInfo?, Map<String, dynamic>>(
            key: 'configNodeInfo',
            parse: (v) => TronHttpNodeInfoConfigNodeInfo.fromJson(v),
          ),
      machineInfo: json
          .valueTo<TronHttpNodeInfoMachineInfo?, Map<String, dynamic>>(
            key: 'machineInfo',
            parse: (v) => TronHttpNodeInfoMachineInfo.fromJson(v),
          ),
      cheatWitnessInfoMap:
          json.hasValue('cheatWitnessInfoMap')
              ? _tronMapFromJson<String>(
                json['cheatWitnessInfoMap'],
                (v) =>
                    v is num
                        ? v.toString()
                        : JsonParser.valueAsString<String>(v),
              )
              : null,
      peerList:
          json.hasValue('peerList')
              ? json
                  .valueEnsureAsList<Map<String, dynamic>>('peerList')
                  .map((e) => TronHttpNodeInfoPeerInfo.fromJson(e))
                  .toList()
              : null,
    );
  }

  Map<String, dynamic> toJson() => {
    'beginSyncNum': beginSyncNum,
    'block': block,
    'solidityBlock': solidityBlock,
    'currentConnectCount': currentConnectCount,
    'activeConnectCount': activeConnectCount,
    'passiveConnectCount': passiveConnectCount,
    'totalFlow': totalFlow,
    'configNodeInfo': configNodeInfo?.toJson(),
    'machineInfo': machineInfo?.toJson(),
    'cheatWitnessInfoMap':
        cheatWitnessInfoMap == null
            ? null
            : _tronMapToJson(cheatWitnessInfoMap!),
    'peerList': peerList?.map((e) => e.toJson()).toList(),
  };
}

class TronHttpNodeInfoConfigNodeInfo {
  final String? codeVersion;
  final String? p2pVersion;
  final int? listenPort;
  final bool? discoverEnable;
  final int? activeNodeSize;
  final int? passiveNodeSize;
  final int? sendNodeSize;
  final int? maxConnectCount;
  final int? sameIpMaxConnectCount;
  final int? backupListenPort;
  final int? backupMemberSize;
  final int? backupPriority;
  final int? dbVersion;
  final int? minParticipationRate;
  final bool? supportConstant;
  final num? minTimeRatio;
  final num? maxTimeRatio;
  final BigInt? allowCreationOfContracts;
  final BigInt? allowAdaptiveEnergy;
  final String? versionNum;

  const TronHttpNodeInfoConfigNodeInfo({
    this.codeVersion,
    this.p2pVersion,
    this.listenPort,
    this.discoverEnable,
    this.activeNodeSize,
    this.passiveNodeSize,
    this.sendNodeSize,
    this.maxConnectCount,
    this.sameIpMaxConnectCount,
    this.backupListenPort,
    this.backupMemberSize,
    this.backupPriority,
    this.dbVersion,
    this.minParticipationRate,
    this.supportConstant,
    this.minTimeRatio,
    this.maxTimeRatio,
    this.allowCreationOfContracts,
    this.allowAdaptiveEnergy,
    this.versionNum,
  });

  factory TronHttpNodeInfoConfigNodeInfo.fromJson(Map<String, dynamic> json) {
    return TronHttpNodeInfoConfigNodeInfo(
      codeVersion:
          (json['codeVersion'] is num
              ? json['codeVersion'].toString()
              : json.valueAsString('codeVersion')),
      p2pVersion:
          (json['p2pVersion'] is num
              ? json['p2pVersion'].toString()
              : json.valueAsString('p2pVersion')),
      listenPort: json.valueAsInt('listenPort'),
      discoverEnable: json.valueAsBool('discoverEnable'),
      activeNodeSize: json.valueAsInt('activeNodeSize'),
      passiveNodeSize: json.valueAsInt('passiveNodeSize'),
      sendNodeSize: json.valueAsInt('sendNodeSize'),
      maxConnectCount: json.valueAsInt('maxConnectCount'),
      sameIpMaxConnectCount: json.valueAsInt('sameIpMaxConnectCount'),
      backupListenPort: json.valueAsInt('backupListenPort'),
      backupMemberSize: json.valueAsInt('backupMemberSize'),
      backupPriority: json.valueAsInt('backupPriority'),
      dbVersion: json.valueAsInt('dbVersion'),
      minParticipationRate: json.valueAsInt('minParticipationRate'),
      supportConstant: json.valueAsBool('supportConstant'),
      minTimeRatio: json.valueAsNum('minTimeRatio'),
      maxTimeRatio: json.valueAsNum('maxTimeRatio'),
      allowCreationOfContracts: json.valueAsBigInt('allowCreationOfContracts'),
      allowAdaptiveEnergy: json.valueAsBigInt('allowAdaptiveEnergy'),
      versionNum:
          (json['versionNum'] is num
              ? json['versionNum'].toString()
              : json.valueAsString('versionNum')),
    );
  }

  Map<String, dynamic> toJson() => {
    'codeVersion': codeVersion,
    'p2pVersion': p2pVersion,
    'listenPort': listenPort,
    'discoverEnable': discoverEnable,
    'activeNodeSize': activeNodeSize,
    'passiveNodeSize': passiveNodeSize,
    'sendNodeSize': sendNodeSize,
    'maxConnectCount': maxConnectCount,
    'sameIpMaxConnectCount': sameIpMaxConnectCount,
    'backupListenPort': backupListenPort,
    'backupMemberSize': backupMemberSize,
    'backupPriority': backupPriority,
    'dbVersion': dbVersion,
    'minParticipationRate': minParticipationRate,
    'supportConstant': supportConstant,
    'minTimeRatio': minTimeRatio,
    'maxTimeRatio': maxTimeRatio,
    'allowCreationOfContracts': allowCreationOfContracts,
    'allowAdaptiveEnergy': allowAdaptiveEnergy,
    'versionNum': versionNum,
  };
}

class TronHttpNodeInfoConfigNodeInfoInt64StringCompatible {
  final String? codeVersion;
  final String? p2pVersion;
  final int? listenPort;
  final bool? discoverEnable;
  final int? activeNodeSize;
  final int? passiveNodeSize;
  final int? sendNodeSize;
  final int? maxConnectCount;
  final int? sameIpMaxConnectCount;
  final int? backupListenPort;
  final int? backupMemberSize;
  final int? backupPriority;
  final int? dbVersion;
  final int? minParticipationRate;
  final bool? supportConstant;
  final num? minTimeRatio;
  final num? maxTimeRatio;
  final BigInt? allowCreationOfContracts;
  final BigInt? allowAdaptiveEnergy;
  final String? versionNum;

  const TronHttpNodeInfoConfigNodeInfoInt64StringCompatible({
    this.codeVersion,
    this.p2pVersion,
    this.listenPort,
    this.discoverEnable,
    this.activeNodeSize,
    this.passiveNodeSize,
    this.sendNodeSize,
    this.maxConnectCount,
    this.sameIpMaxConnectCount,
    this.backupListenPort,
    this.backupMemberSize,
    this.backupPriority,
    this.dbVersion,
    this.minParticipationRate,
    this.supportConstant,
    this.minTimeRatio,
    this.maxTimeRatio,
    this.allowCreationOfContracts,
    this.allowAdaptiveEnergy,
    this.versionNum,
  });

  factory TronHttpNodeInfoConfigNodeInfoInt64StringCompatible.fromJson(
    Map<String, dynamic> json,
  ) {
    return TronHttpNodeInfoConfigNodeInfoInt64StringCompatible(
      codeVersion:
          (json['codeVersion'] is num
              ? json['codeVersion'].toString()
              : json.valueAsString('codeVersion')),
      p2pVersion:
          (json['p2pVersion'] is num
              ? json['p2pVersion'].toString()
              : json.valueAsString('p2pVersion')),
      listenPort: json.valueAsInt('listenPort'),
      discoverEnable: json.valueAsBool('discoverEnable'),
      activeNodeSize: json.valueAsInt('activeNodeSize'),
      passiveNodeSize: json.valueAsInt('passiveNodeSize'),
      sendNodeSize: json.valueAsInt('sendNodeSize'),
      maxConnectCount: json.valueAsInt('maxConnectCount'),
      sameIpMaxConnectCount: json.valueAsInt('sameIpMaxConnectCount'),
      backupListenPort: json.valueAsInt('backupListenPort'),
      backupMemberSize: json.valueAsInt('backupMemberSize'),
      backupPriority: json.valueAsInt('backupPriority'),
      dbVersion: json.valueAsInt('dbVersion'),
      minParticipationRate: json.valueAsInt('minParticipationRate'),
      supportConstant: json.valueAsBool('supportConstant'),
      minTimeRatio: json.valueAsNum('minTimeRatio'),
      maxTimeRatio: json.valueAsNum('maxTimeRatio'),
      allowCreationOfContracts: json.valueAsBigInt('allowCreationOfContracts'),
      allowAdaptiveEnergy: json.valueAsBigInt('allowAdaptiveEnergy'),
      versionNum:
          (json['versionNum'] is num
              ? json['versionNum'].toString()
              : json.valueAsString('versionNum')),
    );
  }

  Map<String, dynamic> toJson() => {
    'codeVersion': codeVersion,
    'p2pVersion': p2pVersion,
    'listenPort': listenPort,
    'discoverEnable': discoverEnable,
    'activeNodeSize': activeNodeSize,
    'passiveNodeSize': passiveNodeSize,
    'sendNodeSize': sendNodeSize,
    'maxConnectCount': maxConnectCount,
    'sameIpMaxConnectCount': sameIpMaxConnectCount,
    'backupListenPort': backupListenPort,
    'backupMemberSize': backupMemberSize,
    'backupPriority': backupPriority,
    'dbVersion': dbVersion,
    'minParticipationRate': minParticipationRate,
    'supportConstant': supportConstant,
    'minTimeRatio': minTimeRatio,
    'maxTimeRatio': maxTimeRatio,
    'allowCreationOfContracts': allowCreationOfContracts,
    'allowAdaptiveEnergy': allowAdaptiveEnergy,
    'versionNum': versionNum,
  };
}

class TronHttpNodeInfoInt64StringCompatible {
  final BigInt? beginSyncNum;
  final String? block;
  final String? solidityBlock;
  final int? currentConnectCount;
  final int? activeConnectCount;
  final int? passiveConnectCount;
  final BigInt? totalFlow;
  final TronHttpNodeInfoConfigNodeInfoInt64StringCompatible? configNodeInfo;
  final TronHttpNodeInfoMachineInfoInt64StringCompatible? machineInfo;
  final Map<String, String>? cheatWitnessInfoMap;
  final List<TronHttpNodeInfoPeerInfoInt64StringCompatible>? peerList;

  const TronHttpNodeInfoInt64StringCompatible({
    this.beginSyncNum,
    this.block,
    this.solidityBlock,
    this.currentConnectCount,
    this.activeConnectCount,
    this.passiveConnectCount,
    this.totalFlow,
    this.configNodeInfo,
    this.machineInfo,
    this.cheatWitnessInfoMap,
    this.peerList,
  });

  factory TronHttpNodeInfoInt64StringCompatible.fromJson(
    Map<String, dynamic> json,
  ) {
    return TronHttpNodeInfoInt64StringCompatible(
      beginSyncNum: json.valueAsBigInt('beginSyncNum'),
      block:
          (json['block'] is num
              ? json['block'].toString()
              : json.valueAsString('block')),
      solidityBlock:
          (json['solidityBlock'] is num
              ? json['solidityBlock'].toString()
              : json.valueAsString('solidityBlock')),
      currentConnectCount: json.valueAsInt('currentConnectCount'),
      activeConnectCount: json.valueAsInt('activeConnectCount'),
      passiveConnectCount: json.valueAsInt('passiveConnectCount'),
      totalFlow: json.valueAsBigInt('totalFlow'),
      configNodeInfo: json.valueTo<
        TronHttpNodeInfoConfigNodeInfoInt64StringCompatible?,
        Map<String, dynamic>
      >(
        key: 'configNodeInfo',
        parse:
            (v) =>
                TronHttpNodeInfoConfigNodeInfoInt64StringCompatible.fromJson(v),
      ),
      machineInfo: json.valueTo<
        TronHttpNodeInfoMachineInfoInt64StringCompatible?,
        Map<String, dynamic>
      >(
        key: 'machineInfo',
        parse:
            (v) => TronHttpNodeInfoMachineInfoInt64StringCompatible.fromJson(v),
      ),
      cheatWitnessInfoMap:
          json.hasValue('cheatWitnessInfoMap')
              ? _tronMapFromJson<String>(
                json['cheatWitnessInfoMap'],
                (v) =>
                    v is num
                        ? v.toString()
                        : JsonParser.valueAsString<String>(v),
              )
              : null,
      peerList:
          json.hasValue('peerList')
              ? json
                  .valueEnsureAsList<Map<String, dynamic>>('peerList')
                  .map(
                    (e) =>
                        TronHttpNodeInfoPeerInfoInt64StringCompatible.fromJson(
                          e,
                        ),
                  )
                  .toList()
              : null,
    );
  }

  Map<String, dynamic> toJson() => {
    'beginSyncNum': beginSyncNum,
    'block': block,
    'solidityBlock': solidityBlock,
    'currentConnectCount': currentConnectCount,
    'activeConnectCount': activeConnectCount,
    'passiveConnectCount': passiveConnectCount,
    'totalFlow': totalFlow,
    'configNodeInfo': configNodeInfo?.toJson(),
    'machineInfo': machineInfo?.toJson(),
    'cheatWitnessInfoMap':
        cheatWitnessInfoMap == null
            ? null
            : _tronMapToJson(cheatWitnessInfoMap!),
    'peerList': peerList?.map((e) => e.toJson()).toList(),
  };
}

class TronHttpNodeInfoMachineInfo {
  final int? threadCount;
  final int? deadLockThreadCount;
  final int? cpuCount;
  final BigInt? totalMemory;
  final BigInt? freeMemory;
  final num? cpuRate;
  final String? javaVersion;
  final String? osName;
  final BigInt? jvmTotalMemory;
  final BigInt? jvmFreeMemory;
  final num? processCpuRate;
  final List<TronHttpNodeInfoMachineInfoMemoryDescInfo>? memoryDescInfoList;
  final List<TronHttpNodeInfoMachineInfoDeadLockThreadInfo>?
  deadLockThreadInfoList;

  const TronHttpNodeInfoMachineInfo({
    this.threadCount,
    this.deadLockThreadCount,
    this.cpuCount,
    this.totalMemory,
    this.freeMemory,
    this.cpuRate,
    this.javaVersion,
    this.osName,
    this.jvmTotalMemory,
    this.jvmFreeMemory,
    this.processCpuRate,
    this.memoryDescInfoList,
    this.deadLockThreadInfoList,
  });

  factory TronHttpNodeInfoMachineInfo.fromJson(Map<String, dynamic> json) {
    return TronHttpNodeInfoMachineInfo(
      threadCount: json.valueAsInt('threadCount'),
      deadLockThreadCount: json.valueAsInt('deadLockThreadCount'),
      cpuCount: json.valueAsInt('cpuCount'),
      totalMemory: json.valueAsBigInt('totalMemory'),
      freeMemory: json.valueAsBigInt('freeMemory'),
      cpuRate: json.valueAsNum('cpuRate'),
      javaVersion:
          (json['javaVersion'] is num
              ? json['javaVersion'].toString()
              : json.valueAsString('javaVersion')),
      osName:
          (json['osName'] is num
              ? json['osName'].toString()
              : json.valueAsString('osName')),
      jvmTotalMemory: json.valueAsBigInt('jvmTotalMemory'),
      jvmFreeMemory: json.valueAsBigInt('jvmFreeMemory'),
      processCpuRate: json.valueAsNum('processCpuRate'),
      memoryDescInfoList:
          json.hasValue('memoryDescInfoList')
              ? json
                  .valueEnsureAsList<Map<String, dynamic>>('memoryDescInfoList')
                  .map(
                    (e) =>
                        TronHttpNodeInfoMachineInfoMemoryDescInfo.fromJson(e),
                  )
                  .toList()
              : null,
      deadLockThreadInfoList:
          json.hasValue('deadLockThreadInfoList')
              ? json
                  .valueEnsureAsList<Map<String, dynamic>>(
                    'deadLockThreadInfoList',
                  )
                  .map(
                    (e) =>
                        TronHttpNodeInfoMachineInfoDeadLockThreadInfo.fromJson(
                          e,
                        ),
                  )
                  .toList()
              : null,
    );
  }

  Map<String, dynamic> toJson() => {
    'threadCount': threadCount,
    'deadLockThreadCount': deadLockThreadCount,
    'cpuCount': cpuCount,
    'totalMemory': totalMemory,
    'freeMemory': freeMemory,
    'cpuRate': cpuRate,
    'javaVersion': javaVersion,
    'osName': osName,
    'jvmTotalMemory': jvmTotalMemory,
    'jvmFreeMemory': jvmFreeMemory,
    'processCpuRate': processCpuRate,
    'memoryDescInfoList': memoryDescInfoList?.map((e) => e.toJson()).toList(),
    'deadLockThreadInfoList':
        deadLockThreadInfoList?.map((e) => e.toJson()).toList(),
  };
}

class TronHttpNodeInfoMachineInfoDeadLockThreadInfo {
  /// Name encoded as expected by java-tron.
  final String? name;
  final String? lockName;
  final String? lockOwner;
  final String? state;
  final BigInt? blockTime;
  final BigInt? waitTime;
  final String? stackTrace;

  const TronHttpNodeInfoMachineInfoDeadLockThreadInfo({
    this.name,
    this.lockName,
    this.lockOwner,
    this.state,
    this.blockTime,
    this.waitTime,
    this.stackTrace,
  });

  factory TronHttpNodeInfoMachineInfoDeadLockThreadInfo.fromJson(
    Map<String, dynamic> json,
  ) {
    return TronHttpNodeInfoMachineInfoDeadLockThreadInfo(
      name:
          (json['name'] is num
              ? json['name'].toString()
              : json.valueAsString('name')),
      lockName:
          (json['lockName'] is num
              ? json['lockName'].toString()
              : json.valueAsString('lockName')),
      lockOwner:
          (json['lockOwner'] is num
              ? json['lockOwner'].toString()
              : json.valueAsString('lockOwner')),
      state:
          (json['state'] is num
              ? json['state'].toString()
              : json.valueAsString('state')),
      blockTime: json.valueAsBigInt('blockTime'),
      waitTime: json.valueAsBigInt('waitTime'),
      stackTrace:
          (json['stackTrace'] is num
              ? json['stackTrace'].toString()
              : json.valueAsString('stackTrace')),
    );
  }

  Map<String, dynamic> toJson() => {
    'name': name,
    'lockName': lockName,
    'lockOwner': lockOwner,
    'state': state,
    'blockTime': blockTime,
    'waitTime': waitTime,
    'stackTrace': stackTrace,
  };
}

class TronHttpNodeInfoMachineInfoDeadLockThreadInfoInt64StringCompatible {
  /// Name encoded as expected by java-tron.
  final String? name;
  final String? lockName;
  final String? lockOwner;
  final String? state;
  final BigInt? blockTime;
  final BigInt? waitTime;
  final String? stackTrace;

  const TronHttpNodeInfoMachineInfoDeadLockThreadInfoInt64StringCompatible({
    this.name,
    this.lockName,
    this.lockOwner,
    this.state,
    this.blockTime,
    this.waitTime,
    this.stackTrace,
  });

  factory TronHttpNodeInfoMachineInfoDeadLockThreadInfoInt64StringCompatible.fromJson(
    Map<String, dynamic> json,
  ) {
    return TronHttpNodeInfoMachineInfoDeadLockThreadInfoInt64StringCompatible(
      name:
          (json['name'] is num
              ? json['name'].toString()
              : json.valueAsString('name')),
      lockName:
          (json['lockName'] is num
              ? json['lockName'].toString()
              : json.valueAsString('lockName')),
      lockOwner:
          (json['lockOwner'] is num
              ? json['lockOwner'].toString()
              : json.valueAsString('lockOwner')),
      state:
          (json['state'] is num
              ? json['state'].toString()
              : json.valueAsString('state')),
      blockTime: json.valueAsBigInt('blockTime'),
      waitTime: json.valueAsBigInt('waitTime'),
      stackTrace:
          (json['stackTrace'] is num
              ? json['stackTrace'].toString()
              : json.valueAsString('stackTrace')),
    );
  }

  Map<String, dynamic> toJson() => {
    'name': name,
    'lockName': lockName,
    'lockOwner': lockOwner,
    'state': state,
    'blockTime': blockTime,
    'waitTime': waitTime,
    'stackTrace': stackTrace,
  };
}

class TronHttpNodeInfoMachineInfoInt64StringCompatible {
  final int? threadCount;
  final int? deadLockThreadCount;
  final int? cpuCount;
  final BigInt? totalMemory;
  final BigInt? freeMemory;
  final num? cpuRate;
  final String? javaVersion;
  final String? osName;
  final BigInt? jvmTotalMemory;
  final BigInt? jvmFreeMemory;
  final num? processCpuRate;
  final List<TronHttpNodeInfoMachineInfoMemoryDescInfoInt64StringCompatible>?
  memoryDescInfoList;
  final List<
    TronHttpNodeInfoMachineInfoDeadLockThreadInfoInt64StringCompatible
  >?
  deadLockThreadInfoList;

  const TronHttpNodeInfoMachineInfoInt64StringCompatible({
    this.threadCount,
    this.deadLockThreadCount,
    this.cpuCount,
    this.totalMemory,
    this.freeMemory,
    this.cpuRate,
    this.javaVersion,
    this.osName,
    this.jvmTotalMemory,
    this.jvmFreeMemory,
    this.processCpuRate,
    this.memoryDescInfoList,
    this.deadLockThreadInfoList,
  });

  factory TronHttpNodeInfoMachineInfoInt64StringCompatible.fromJson(
    Map<String, dynamic> json,
  ) {
    return TronHttpNodeInfoMachineInfoInt64StringCompatible(
      threadCount: json.valueAsInt('threadCount'),
      deadLockThreadCount: json.valueAsInt('deadLockThreadCount'),
      cpuCount: json.valueAsInt('cpuCount'),
      totalMemory: json.valueAsBigInt('totalMemory'),
      freeMemory: json.valueAsBigInt('freeMemory'),
      cpuRate: json.valueAsNum('cpuRate'),
      javaVersion:
          (json['javaVersion'] is num
              ? json['javaVersion'].toString()
              : json.valueAsString('javaVersion')),
      osName:
          (json['osName'] is num
              ? json['osName'].toString()
              : json.valueAsString('osName')),
      jvmTotalMemory: json.valueAsBigInt('jvmTotalMemory'),
      jvmFreeMemory: json.valueAsBigInt('jvmFreeMemory'),
      processCpuRate: json.valueAsNum('processCpuRate'),
      memoryDescInfoList:
          json.hasValue('memoryDescInfoList')
              ? json
                  .valueEnsureAsList<Map<String, dynamic>>('memoryDescInfoList')
                  .map(
                    (e) =>
                        TronHttpNodeInfoMachineInfoMemoryDescInfoInt64StringCompatible.fromJson(
                          e,
                        ),
                  )
                  .toList()
              : null,
      deadLockThreadInfoList:
          json.hasValue('deadLockThreadInfoList')
              ? json
                  .valueEnsureAsList<Map<String, dynamic>>(
                    'deadLockThreadInfoList',
                  )
                  .map(
                    (e) =>
                        TronHttpNodeInfoMachineInfoDeadLockThreadInfoInt64StringCompatible.fromJson(
                          e,
                        ),
                  )
                  .toList()
              : null,
    );
  }

  Map<String, dynamic> toJson() => {
    'threadCount': threadCount,
    'deadLockThreadCount': deadLockThreadCount,
    'cpuCount': cpuCount,
    'totalMemory': totalMemory,
    'freeMemory': freeMemory,
    'cpuRate': cpuRate,
    'javaVersion': javaVersion,
    'osName': osName,
    'jvmTotalMemory': jvmTotalMemory,
    'jvmFreeMemory': jvmFreeMemory,
    'processCpuRate': processCpuRate,
    'memoryDescInfoList': memoryDescInfoList?.map((e) => e.toJson()).toList(),
    'deadLockThreadInfoList':
        deadLockThreadInfoList?.map((e) => e.toJson()).toList(),
  };
}

class TronHttpNodeInfoMachineInfoMemoryDescInfo {
  /// Name encoded as expected by java-tron.
  final String? name;
  final BigInt? initSize;
  final BigInt? useSize;
  final BigInt? maxSize;
  final num? useRate;

  const TronHttpNodeInfoMachineInfoMemoryDescInfo({
    this.name,
    this.initSize,
    this.useSize,
    this.maxSize,
    this.useRate,
  });

  factory TronHttpNodeInfoMachineInfoMemoryDescInfo.fromJson(
    Map<String, dynamic> json,
  ) {
    return TronHttpNodeInfoMachineInfoMemoryDescInfo(
      name:
          (json['name'] is num
              ? json['name'].toString()
              : json.valueAsString('name')),
      initSize: json.valueAsBigInt('initSize'),
      useSize: json.valueAsBigInt('useSize'),
      maxSize: json.valueAsBigInt('maxSize'),
      useRate: json.valueAsNum('useRate'),
    );
  }

  Map<String, dynamic> toJson() => {
    'name': name,
    'initSize': initSize,
    'useSize': useSize,
    'maxSize': maxSize,
    'useRate': useRate,
  };
}

class TronHttpNodeInfoMachineInfoMemoryDescInfoInt64StringCompatible {
  /// Name encoded as expected by java-tron.
  final String? name;
  final BigInt? initSize;
  final BigInt? useSize;
  final BigInt? maxSize;
  final num? useRate;

  const TronHttpNodeInfoMachineInfoMemoryDescInfoInt64StringCompatible({
    this.name,
    this.initSize,
    this.useSize,
    this.maxSize,
    this.useRate,
  });

  factory TronHttpNodeInfoMachineInfoMemoryDescInfoInt64StringCompatible.fromJson(
    Map<String, dynamic> json,
  ) {
    return TronHttpNodeInfoMachineInfoMemoryDescInfoInt64StringCompatible(
      name:
          (json['name'] is num
              ? json['name'].toString()
              : json.valueAsString('name')),
      initSize: json.valueAsBigInt('initSize'),
      useSize: json.valueAsBigInt('useSize'),
      maxSize: json.valueAsBigInt('maxSize'),
      useRate: json.valueAsNum('useRate'),
    );
  }

  Map<String, dynamic> toJson() => {
    'name': name,
    'initSize': initSize,
    'useSize': useSize,
    'maxSize': maxSize,
    'useRate': useRate,
  };
}

class TronHttpNodeInfoPeerInfo {
  final String? lastSyncBlock;
  final BigInt? remainNum;
  final BigInt? lastBlockUpdateTime;
  final bool? syncFlag;
  final BigInt? headBlockTimeWeBothHave;
  final bool? needSyncFromPeer;
  final bool? needSyncFromUs;
  final String? host;
  final int? port;
  final String? nodeId;
  final BigInt? connectTime;
  final num? avgLatency;
  final int? syncToFetchSize;
  final BigInt? syncToFetchSizePeekNum;
  final int? syncBlockRequestedSize;
  final BigInt? unFetchSynNum;
  final int? blockInPorcSize;
  final String? headBlockWeBothHave;
  final int? score;
  final int? nodeCount;
  final BigInt? inFlow;
  final int? disconnectTimes;
  final String? localDisconnectReason;
  final String? remoteDisconnectReason;
  final bool? active;

  const TronHttpNodeInfoPeerInfo({
    this.lastSyncBlock,
    this.remainNum,
    this.lastBlockUpdateTime,
    this.syncFlag,
    this.headBlockTimeWeBothHave,
    this.needSyncFromPeer,
    this.needSyncFromUs,
    this.host,
    this.port,
    this.nodeId,
    this.connectTime,
    this.avgLatency,
    this.syncToFetchSize,
    this.syncToFetchSizePeekNum,
    this.syncBlockRequestedSize,
    this.unFetchSynNum,
    this.blockInPorcSize,
    this.headBlockWeBothHave,
    this.score,
    this.nodeCount,
    this.inFlow,
    this.disconnectTimes,
    this.localDisconnectReason,
    this.remoteDisconnectReason,
    this.active,
  });

  factory TronHttpNodeInfoPeerInfo.fromJson(Map<String, dynamic> json) {
    return TronHttpNodeInfoPeerInfo(
      lastSyncBlock:
          (json['lastSyncBlock'] is num
              ? json['lastSyncBlock'].toString()
              : json.valueAsString('lastSyncBlock')),
      remainNum: json.valueAsBigInt('remainNum'),
      lastBlockUpdateTime: json.valueAsBigInt('lastBlockUpdateTime'),
      syncFlag: json.valueAsBool('syncFlag'),
      headBlockTimeWeBothHave: json.valueAsBigInt('headBlockTimeWeBothHave'),
      needSyncFromPeer: json.valueAsBool('needSyncFromPeer'),
      needSyncFromUs: json.valueAsBool('needSyncFromUs'),
      host:
          (json['host'] is num
              ? json['host'].toString()
              : json.valueAsString('host')),
      port: json.valueAsInt('port'),
      nodeId:
          (json['nodeId'] is num
              ? json['nodeId'].toString()
              : json.valueAsString('nodeId')),
      connectTime: json.valueAsBigInt('connectTime'),
      avgLatency: json.valueAsNum('avgLatency'),
      syncToFetchSize: json.valueAsInt('syncToFetchSize'),
      syncToFetchSizePeekNum: json.valueAsBigInt('syncToFetchSizePeekNum'),
      syncBlockRequestedSize: json.valueAsInt('syncBlockRequestedSize'),
      unFetchSynNum: json.valueAsBigInt('unFetchSynNum'),
      blockInPorcSize: json.valueAsInt('blockInPorcSize'),
      headBlockWeBothHave:
          (json['headBlockWeBothHave'] is num
              ? json['headBlockWeBothHave'].toString()
              : json.valueAsString('headBlockWeBothHave')),
      score: json.valueAsInt('score'),
      nodeCount: json.valueAsInt('nodeCount'),
      inFlow: json.valueAsBigInt('inFlow'),
      disconnectTimes: json.valueAsInt('disconnectTimes'),
      localDisconnectReason:
          (json['localDisconnectReason'] is num
              ? json['localDisconnectReason'].toString()
              : json.valueAsString('localDisconnectReason')),
      remoteDisconnectReason:
          (json['remoteDisconnectReason'] is num
              ? json['remoteDisconnectReason'].toString()
              : json.valueAsString('remoteDisconnectReason')),
      active: json.valueAsBool('active'),
    );
  }

  Map<String, dynamic> toJson() => {
    'lastSyncBlock': lastSyncBlock,
    'remainNum': remainNum,
    'lastBlockUpdateTime': lastBlockUpdateTime,
    'syncFlag': syncFlag,
    'headBlockTimeWeBothHave': headBlockTimeWeBothHave,
    'needSyncFromPeer': needSyncFromPeer,
    'needSyncFromUs': needSyncFromUs,
    'host': host,
    'port': port,
    'nodeId': nodeId,
    'connectTime': connectTime,
    'avgLatency': avgLatency,
    'syncToFetchSize': syncToFetchSize,
    'syncToFetchSizePeekNum': syncToFetchSizePeekNum,
    'syncBlockRequestedSize': syncBlockRequestedSize,
    'unFetchSynNum': unFetchSynNum,
    'blockInPorcSize': blockInPorcSize,
    'headBlockWeBothHave': headBlockWeBothHave,
    'score': score,
    'nodeCount': nodeCount,
    'inFlow': inFlow,
    'disconnectTimes': disconnectTimes,
    'localDisconnectReason': localDisconnectReason,
    'remoteDisconnectReason': remoteDisconnectReason,
    'active': active,
  };
}

class TronHttpNodeInfoPeerInfoInt64StringCompatible {
  final String? lastSyncBlock;
  final BigInt? remainNum;
  final BigInt? lastBlockUpdateTime;
  final bool? syncFlag;
  final BigInt? headBlockTimeWeBothHave;
  final bool? needSyncFromPeer;
  final bool? needSyncFromUs;
  final String? host;
  final int? port;
  final String? nodeId;
  final BigInt? connectTime;
  final num? avgLatency;
  final int? syncToFetchSize;
  final BigInt? syncToFetchSizePeekNum;
  final int? syncBlockRequestedSize;
  final BigInt? unFetchSynNum;
  final int? blockInPorcSize;
  final String? headBlockWeBothHave;
  final int? score;
  final int? nodeCount;
  final BigInt? inFlow;
  final int? disconnectTimes;
  final String? localDisconnectReason;
  final String? remoteDisconnectReason;
  final bool? active;

  const TronHttpNodeInfoPeerInfoInt64StringCompatible({
    this.lastSyncBlock,
    this.remainNum,
    this.lastBlockUpdateTime,
    this.syncFlag,
    this.headBlockTimeWeBothHave,
    this.needSyncFromPeer,
    this.needSyncFromUs,
    this.host,
    this.port,
    this.nodeId,
    this.connectTime,
    this.avgLatency,
    this.syncToFetchSize,
    this.syncToFetchSizePeekNum,
    this.syncBlockRequestedSize,
    this.unFetchSynNum,
    this.blockInPorcSize,
    this.headBlockWeBothHave,
    this.score,
    this.nodeCount,
    this.inFlow,
    this.disconnectTimes,
    this.localDisconnectReason,
    this.remoteDisconnectReason,
    this.active,
  });

  factory TronHttpNodeInfoPeerInfoInt64StringCompatible.fromJson(
    Map<String, dynamic> json,
  ) {
    return TronHttpNodeInfoPeerInfoInt64StringCompatible(
      lastSyncBlock:
          (json['lastSyncBlock'] is num
              ? json['lastSyncBlock'].toString()
              : json.valueAsString('lastSyncBlock')),
      remainNum: json.valueAsBigInt('remainNum'),
      lastBlockUpdateTime: json.valueAsBigInt('lastBlockUpdateTime'),
      syncFlag: json.valueAsBool('syncFlag'),
      headBlockTimeWeBothHave: json.valueAsBigInt('headBlockTimeWeBothHave'),
      needSyncFromPeer: json.valueAsBool('needSyncFromPeer'),
      needSyncFromUs: json.valueAsBool('needSyncFromUs'),
      host:
          (json['host'] is num
              ? json['host'].toString()
              : json.valueAsString('host')),
      port: json.valueAsInt('port'),
      nodeId:
          (json['nodeId'] is num
              ? json['nodeId'].toString()
              : json.valueAsString('nodeId')),
      connectTime: json.valueAsBigInt('connectTime'),
      avgLatency: json.valueAsNum('avgLatency'),
      syncToFetchSize: json.valueAsInt('syncToFetchSize'),
      syncToFetchSizePeekNum: json.valueAsBigInt('syncToFetchSizePeekNum'),
      syncBlockRequestedSize: json.valueAsInt('syncBlockRequestedSize'),
      unFetchSynNum: json.valueAsBigInt('unFetchSynNum'),
      blockInPorcSize: json.valueAsInt('blockInPorcSize'),
      headBlockWeBothHave:
          (json['headBlockWeBothHave'] is num
              ? json['headBlockWeBothHave'].toString()
              : json.valueAsString('headBlockWeBothHave')),
      score: json.valueAsInt('score'),
      nodeCount: json.valueAsInt('nodeCount'),
      inFlow: json.valueAsBigInt('inFlow'),
      disconnectTimes: json.valueAsInt('disconnectTimes'),
      localDisconnectReason:
          (json['localDisconnectReason'] is num
              ? json['localDisconnectReason'].toString()
              : json.valueAsString('localDisconnectReason')),
      remoteDisconnectReason:
          (json['remoteDisconnectReason'] is num
              ? json['remoteDisconnectReason'].toString()
              : json.valueAsString('remoteDisconnectReason')),
      active: json.valueAsBool('active'),
    );
  }

  Map<String, dynamic> toJson() => {
    'lastSyncBlock': lastSyncBlock,
    'remainNum': remainNum,
    'lastBlockUpdateTime': lastBlockUpdateTime,
    'syncFlag': syncFlag,
    'headBlockTimeWeBothHave': headBlockTimeWeBothHave,
    'needSyncFromPeer': needSyncFromPeer,
    'needSyncFromUs': needSyncFromUs,
    'host': host,
    'port': port,
    'nodeId': nodeId,
    'connectTime': connectTime,
    'avgLatency': avgLatency,
    'syncToFetchSize': syncToFetchSize,
    'syncToFetchSizePeekNum': syncToFetchSizePeekNum,
    'syncBlockRequestedSize': syncBlockRequestedSize,
    'unFetchSynNum': unFetchSynNum,
    'blockInPorcSize': blockInPorcSize,
    'headBlockWeBothHave': headBlockWeBothHave,
    'score': score,
    'nodeCount': nodeCount,
    'inFlow': inFlow,
    'disconnectTimes': disconnectTimes,
    'localDisconnectReason': localDisconnectReason,
    'remoteDisconnectReason': remoteDisconnectReason,
    'active': active,
  };
}

class TronHttpNodeList {
  final List<TronHttpNode>? nodes;

  const TronHttpNodeList({this.nodes});

  factory TronHttpNodeList.fromJson(Map<String, dynamic> json) {
    return TronHttpNodeList(
      nodes:
          json.hasValue('nodes')
              ? json
                  .valueEnsureAsList<Map<String, dynamic>>('nodes')
                  .map((e) => TronHttpNode.fromJson(e))
                  .toList()
              : null,
    );
  }

  Map<String, dynamic> toJson() => {
    'nodes': nodes?.map((e) => e.toJson()).toList(),
  };
}

class TronHttpNumberMessage {
  /// Unix timestamp in milliseconds of the next maintenance cycle.
  final BigInt num_;

  const TronHttpNumberMessage({required this.num_});

  factory TronHttpNumberMessage.fromJson(Map<String, dynamic> json) {
    return TronHttpNumberMessage(num_: json.valueAsBigInt('num'));
  }

  Map<String, dynamic> toJson() => {'num': num_};
}

class TronHttpNumberMessageInt64StringCompatible {
  /// Unix timestamp in milliseconds of the next maintenance cycle.
  final BigInt num_;

  const TronHttpNumberMessageInt64StringCompatible({required this.num_});

  factory TronHttpNumberMessageInt64StringCompatible.fromJson(
    Map<String, dynamic> json,
  ) {
    return TronHttpNumberMessageInt64StringCompatible(
      num_: json.valueAsBigInt('num'),
    );
  }

  Map<String, dynamic> toJson() => {'num': num_};
}

/// POST /wallet/getblockbylatestnum (request)
class TronHttpNumberMessageRequest {
  /// Number of most recent blocks to return.
  final BigInt? num_;

  /// When true, addresses are encoded in base58check; when false or omitted, addresses are hex-encoded.
  final bool? visible;

  const TronHttpNumberMessageRequest({this.num_, this.visible});

  factory TronHttpNumberMessageRequest.fromJson(Map<String, dynamic> json) {
    return TronHttpNumberMessageRequest(
      num_: json.valueAsBigInt('num'),
      visible: json.valueAsBool('visible'),
    );
  }

  Map<String, dynamic> toJson() => {'num': num_, 'visible': visible};
}

/// POST /wallet/getpaginatedassetissuelist (request)
/// POST /wallet/getpaginatednowwitnesslist (request)
/// POST /wallet/getpaginatedproposallist (request)
class TronHttpPaginatedMessageRequest {
  /// Zero-based pagination offset.
  final BigInt? offset;

  /// Maximum number of items to return.
  final BigInt? limit;

  /// When true, addresses are encoded in base58check; when false or omitted, addresses are hex-encoded.
  final bool? visible;

  const TronHttpPaginatedMessageRequest({
    this.offset,
    this.limit,
    this.visible,
  });

  factory TronHttpPaginatedMessageRequest.fromJson(Map<String, dynamic> json) {
    return TronHttpPaginatedMessageRequest(
      offset: json.valueAsBigInt('offset'),
      limit: json.valueAsBigInt('limit'),
      visible: json.valueAsBool('visible'),
    );
  }

  Map<String, dynamic> toJson() => {
    'offset': offset,
    'limit': limit,
    'visible': visible,
  };
}

class TronHttpParticipateAssetIssueContract {
  /// Address of the account that owns or initiates the request.
  final String? ownerAddress;

  /// Destination account address.
  final String? toAddress;

  /// Asset name or token identifier encoded as expected by java-tron.
  final String? assetName;

  /// Amount in sun, where 1 TRX equals 1,000,000 sun.
  final BigInt? amount;

  const TronHttpParticipateAssetIssueContract({
    this.ownerAddress,
    this.toAddress,
    this.assetName,
    this.amount,
  });

  factory TronHttpParticipateAssetIssueContract.fromJson(
    Map<String, dynamic> json,
  ) {
    return TronHttpParticipateAssetIssueContract(
      ownerAddress:
          (json['owner_address'] is num
              ? json['owner_address'].toString()
              : json.valueAsString('owner_address')),
      toAddress:
          (json['to_address'] is num
              ? json['to_address'].toString()
              : json.valueAsString('to_address')),
      assetName:
          (json['asset_name'] is num
              ? json['asset_name'].toString()
              : json.valueAsString('asset_name')),
      amount: json.valueAsBigInt('amount'),
    );
  }

  Map<String, dynamic> toJson() => {
    'owner_address': ownerAddress,
    'to_address': toAddress,
    'asset_name': assetName,
    'amount': amount,
  };
}

class TronHttpParticipateAssetIssueContractInt64StringCompatible {
  /// Address of the account that owns or initiates the request.
  final String? ownerAddress;

  /// Destination account address.
  final String? toAddress;

  /// Asset name or token identifier encoded as expected by java-tron.
  final String? assetName;

  /// Amount in sun, where 1 TRX equals 1,000,000 sun.
  final BigInt? amount;

  const TronHttpParticipateAssetIssueContractInt64StringCompatible({
    this.ownerAddress,
    this.toAddress,
    this.assetName,
    this.amount,
  });

  factory TronHttpParticipateAssetIssueContractInt64StringCompatible.fromJson(
    Map<String, dynamic> json,
  ) {
    return TronHttpParticipateAssetIssueContractInt64StringCompatible(
      ownerAddress:
          (json['owner_address'] is num
              ? json['owner_address'].toString()
              : json.valueAsString('owner_address')),
      toAddress:
          (json['to_address'] is num
              ? json['to_address'].toString()
              : json.valueAsString('to_address')),
      assetName:
          (json['asset_name'] is num
              ? json['asset_name'].toString()
              : json.valueAsString('asset_name')),
      amount: json.valueAsBigInt('amount'),
    );
  }

  Map<String, dynamic> toJson() => {
    'owner_address': ownerAddress,
    'to_address': toAddress,
    'asset_name': assetName,
    'amount': amount,
  };
}

class TronHttpParticipateAssetIssueContractRequest {
  /// Address of the account that owns or initiates the request.
  final String ownerAddress;

  /// Destination account address.
  final String toAddress;

  /// Asset name or token identifier encoded as expected by java-tron.
  final String assetName;

  /// Amount in sun, where 1 TRX equals 1,000,000 sun.
  final BigInt amount;

  /// When true, addresses are encoded in base58check; when false or omitted, addresses are hex-encoded.
  final bool? visible;

  /// Permission id used to sign the transaction with a non-owner account permission.
  final int? permissionId;

  const TronHttpParticipateAssetIssueContractRequest({
    required this.ownerAddress,
    required this.toAddress,
    required this.assetName,
    required this.amount,
    this.visible,
    this.permissionId,
  });

  factory TronHttpParticipateAssetIssueContractRequest.fromJson(
    Map<String, dynamic> json,
  ) {
    return TronHttpParticipateAssetIssueContractRequest(
      ownerAddress:
          (json['owner_address'] is num
              ? json['owner_address'].toString()
              : json.valueAsString('owner_address')),
      toAddress:
          (json['to_address'] is num
              ? json['to_address'].toString()
              : json.valueAsString('to_address')),
      assetName:
          (json['asset_name'] is num
              ? json['asset_name'].toString()
              : json.valueAsString('asset_name')),
      amount: json.valueAsBigInt('amount'),
      visible: json.valueAsBool('visible'),
      permissionId: json.valueAsInt('Permission_id'),
    );
  }

  Map<String, dynamic> toJson() => {
    'owner_address': ownerAddress,
    'to_address': toAddress,
    'asset_name': assetName,
    'amount': amount,
    'visible': visible,
    'Permission_id': permissionId,
  };
}

/// Owner permission definition.
class TronHttpPermission {
  /// Account, contract, or resource type.
  final TronHttpPermissionType? type;

  /// Identifier used by this query.
  final int? id;
  final String? permissionName;
  final BigInt? threshold;
  final int? parentId;
  final String? operations;
  final List<TronHttpKey>? keys;

  const TronHttpPermission({
    this.type,
    this.id,
    this.permissionName,
    this.threshold,
    this.parentId,
    this.operations,
    this.keys,
  });

  factory TronHttpPermission.fromJson(Map<String, dynamic> json) {
    return TronHttpPermission(
      type:
          json.hasValue('type')
              ? TronHttpPermissionType.fromJson(json['type'])
              : null,
      id: json.valueAsInt('id'),
      permissionName:
          (json['permission_name'] is num
              ? json['permission_name'].toString()
              : json.valueAsString('permission_name')),
      threshold: json.valueAsBigInt('threshold'),
      parentId: json.valueAsInt('parent_id'),
      operations:
          (json['operations'] is num
              ? json['operations'].toString()
              : json.valueAsString('operations')),
      keys:
          json.hasValue('keys')
              ? json
                  .valueEnsureAsList<Map<String, dynamic>>('keys')
                  .map((e) => TronHttpKey.fromJson(e))
                  .toList()
              : null,
    );
  }

  Map<String, dynamic> toJson() => {
    'type': type?.toJson(),
    'id': id,
    'permission_name': permissionName,
    'threshold': threshold,
    'parent_id': parentId,
    'operations': operations,
    'keys': keys?.map((e) => e.toJson()).toList(),
  };
}

/// Owner permission definition.
class TronHttpPermissionInt64StringCompatible {
  /// Account, contract, or resource type.
  final TronHttpPermissionType? type;

  /// Identifier used by this query.
  final int? id;
  final String? permissionName;
  final BigInt? threshold;
  final int? parentId;
  final String? operations;
  final List<TronHttpKeyInt64StringCompatible>? keys;

  const TronHttpPermissionInt64StringCompatible({
    this.type,
    this.id,
    this.permissionName,
    this.threshold,
    this.parentId,
    this.operations,
    this.keys,
  });

  factory TronHttpPermissionInt64StringCompatible.fromJson(
    Map<String, dynamic> json,
  ) {
    return TronHttpPermissionInt64StringCompatible(
      type:
          json.hasValue('type')
              ? TronHttpPermissionType.fromJson(json['type'])
              : null,
      id: json.valueAsInt('id'),
      permissionName:
          (json['permission_name'] is num
              ? json['permission_name'].toString()
              : json.valueAsString('permission_name')),
      threshold: json.valueAsBigInt('threshold'),
      parentId: json.valueAsInt('parent_id'),
      operations:
          (json['operations'] is num
              ? json['operations'].toString()
              : json.valueAsString('operations')),
      keys:
          json.hasValue('keys')
              ? json
                  .valueEnsureAsList<Map<String, dynamic>>('keys')
                  .map((e) => TronHttpKeyInt64StringCompatible.fromJson(e))
                  .toList()
              : null,
    );
  }

  Map<String, dynamic> toJson() => {
    'type': type?.toJson(),
    'id': id,
    'permission_name': permissionName,
    'threshold': threshold,
    'parent_id': parentId,
    'operations': operations,
    'keys': keys?.map((e) => e.toJson()).toList(),
  };
}

class TronHttpPricesResponseMessage {
  final String? prices;

  const TronHttpPricesResponseMessage({this.prices});

  factory TronHttpPricesResponseMessage.fromJson(Map<String, dynamic> json) {
    return TronHttpPricesResponseMessage(
      prices:
          (json['prices'] is num
              ? json['prices'].toString()
              : json.valueAsString('prices')),
    );
  }

  Map<String, dynamic> toJson() => {'prices': prices};
}

class TronHttpProposal {
  /// Proposal id.
  final BigInt? proposalId;
  final String? proposerAddress;
  final BigInt? expirationTime;
  final BigInt? createTime;
  final List<String>? approvals;
  final TronHttpProposalState? state;

  /// Proposal parameter map.
  final Map<String, BigInt>? parameters;

  const TronHttpProposal({
    this.proposalId,
    this.proposerAddress,
    this.expirationTime,
    this.createTime,
    this.approvals,
    this.state,
    this.parameters,
  });

  factory TronHttpProposal.fromJson(Map<String, dynamic> json) {
    return TronHttpProposal(
      proposalId: json.valueAsBigInt('proposal_id'),
      proposerAddress:
          (json['proposer_address'] is num
              ? json['proposer_address'].toString()
              : json.valueAsString('proposer_address')),
      expirationTime: json.valueAsBigInt('expiration_time'),
      createTime: json.valueAsBigInt('create_time'),
      approvals: json.valueAsList<List<String>?>('approvals'),
      state:
          json.hasValue('state')
              ? TronHttpProposalState.fromJson(json['state'])
              : null,
      parameters:
          json.hasValue('parameters')
              ? _tronMapFromJson<BigInt>(
                json['parameters'],
                JsonParser.valueAsBigInt<BigInt>,
              )
              : null,
    );
  }

  Map<String, dynamic> toJson() => {
    'proposal_id': proposalId,
    'proposer_address': proposerAddress,
    'expiration_time': expirationTime,
    'create_time': createTime,
    'approvals': approvals,
    'state': state?.toJson(),
    'parameters': parameters == null ? null : _tronMapToJson(parameters!),
  };
}

class TronHttpProposalApproveContract {
  /// Address of the account that owns or initiates the request.
  final String? ownerAddress;

  /// Proposal id.
  final BigInt? proposalId;

  /// Whether to add approval for the proposal.
  final bool? isAddApproval;

  const TronHttpProposalApproveContract({
    this.ownerAddress,
    this.proposalId,
    this.isAddApproval,
  });

  factory TronHttpProposalApproveContract.fromJson(Map<String, dynamic> json) {
    return TronHttpProposalApproveContract(
      ownerAddress:
          (json['owner_address'] is num
              ? json['owner_address'].toString()
              : json.valueAsString('owner_address')),
      proposalId: json.valueAsBigInt('proposal_id'),
      isAddApproval: json.valueAsBool('is_add_approval'),
    );
  }

  Map<String, dynamic> toJson() => {
    'owner_address': ownerAddress,
    'proposal_id': proposalId,
    'is_add_approval': isAddApproval,
  };
}

class TronHttpProposalApproveContractInt64StringCompatible {
  /// Address of the account that owns or initiates the request.
  final String? ownerAddress;

  /// Proposal id.
  final BigInt? proposalId;

  /// Whether to add approval for the proposal.
  final bool? isAddApproval;

  const TronHttpProposalApproveContractInt64StringCompatible({
    this.ownerAddress,
    this.proposalId,
    this.isAddApproval,
  });

  factory TronHttpProposalApproveContractInt64StringCompatible.fromJson(
    Map<String, dynamic> json,
  ) {
    return TronHttpProposalApproveContractInt64StringCompatible(
      ownerAddress:
          (json['owner_address'] is num
              ? json['owner_address'].toString()
              : json.valueAsString('owner_address')),
      proposalId: json.valueAsBigInt('proposal_id'),
      isAddApproval: json.valueAsBool('is_add_approval'),
    );
  }

  Map<String, dynamic> toJson() => {
    'owner_address': ownerAddress,
    'proposal_id': proposalId,
    'is_add_approval': isAddApproval,
  };
}

class TronHttpProposalApproveContractRequest {
  /// Address of the account that owns or initiates the request.
  final String ownerAddress;

  /// Proposal id.
  final BigInt proposalId;

  /// Whether to add approval for the proposal.
  final bool? isAddApproval;

  /// When true, addresses are encoded in base58check; when false or omitted, addresses are hex-encoded.
  final bool? visible;

  /// Permission id used to sign the transaction with a non-owner account permission.
  final int? permissionId;

  const TronHttpProposalApproveContractRequest({
    required this.ownerAddress,
    required this.proposalId,
    this.isAddApproval,
    this.visible,
    this.permissionId,
  });

  factory TronHttpProposalApproveContractRequest.fromJson(
    Map<String, dynamic> json,
  ) {
    return TronHttpProposalApproveContractRequest(
      ownerAddress:
          (json['owner_address'] is num
              ? json['owner_address'].toString()
              : json.valueAsString('owner_address')),
      proposalId: json.valueAsBigInt('proposal_id'),
      isAddApproval: json.valueAsBool('is_add_approval'),
      visible: json.valueAsBool('visible'),
      permissionId: json.valueAsInt('Permission_id'),
    );
  }

  Map<String, dynamic> toJson() => {
    'owner_address': ownerAddress,
    'proposal_id': proposalId,
    'is_add_approval': isAddApproval,
    'visible': visible,
    'Permission_id': permissionId,
  };
}

class TronHttpProposalCreateContract {
  /// Address of the account that owns or initiates the request.
  final String? ownerAddress;

  /// Proposal parameter map.
  final Map<String, BigInt>? parameters;

  const TronHttpProposalCreateContract({this.ownerAddress, this.parameters});

  factory TronHttpProposalCreateContract.fromJson(Map<String, dynamic> json) {
    return TronHttpProposalCreateContract(
      ownerAddress:
          (json['owner_address'] is num
              ? json['owner_address'].toString()
              : json.valueAsString('owner_address')),
      parameters:
          json.hasValue('parameters')
              ? _tronMapFromJson<BigInt>(
                json['parameters'],
                JsonParser.valueAsBigInt<BigInt>,
              )
              : null,
    );
  }

  Map<String, dynamic> toJson() => {
    'owner_address': ownerAddress,
    'parameters': parameters == null ? null : _tronMapToJson(parameters!),
  };
}

class TronHttpProposalCreateContractInt64StringCompatible {
  /// Address of the account that owns or initiates the request.
  final String? ownerAddress;

  /// Proposal parameter map.
  final Map<String, BigInt>? parameters;

  const TronHttpProposalCreateContractInt64StringCompatible({
    this.ownerAddress,
    this.parameters,
  });

  factory TronHttpProposalCreateContractInt64StringCompatible.fromJson(
    Map<String, dynamic> json,
  ) {
    return TronHttpProposalCreateContractInt64StringCompatible(
      ownerAddress:
          (json['owner_address'] is num
              ? json['owner_address'].toString()
              : json.valueAsString('owner_address')),
      parameters:
          json.hasValue('parameters')
              ? _tronMapFromJson<BigInt>(
                json['parameters'],
                JsonParser.valueAsBigInt<BigInt>,
              )
              : null,
    );
  }

  Map<String, dynamic> toJson() => {
    'owner_address': ownerAddress,
    'parameters': parameters == null ? null : _tronMapToJson(parameters!),
  };
}

class TronHttpProposalCreateContractRequest {
  /// Address of the account that owns or initiates the request.
  final String ownerAddress;

  /// Proposal parameter entries parsed by JsonFormat as key/value map entries.
  final List<TronHttpProposalCreateContractRequestParametersItem> parameters;

  /// When true, addresses are encoded in base58check; when false or omitted, addresses are hex-encoded.
  final bool? visible;

  /// Permission id used to sign the transaction with a non-owner account permission.
  final int? permissionId;

  const TronHttpProposalCreateContractRequest({
    required this.ownerAddress,
    required this.parameters,
    this.visible,
    this.permissionId,
  });

  factory TronHttpProposalCreateContractRequest.fromJson(
    Map<String, dynamic> json,
  ) {
    return TronHttpProposalCreateContractRequest(
      ownerAddress:
          (json['owner_address'] is num
              ? json['owner_address'].toString()
              : json.valueAsString('owner_address')),
      parameters:
          json
              .valueEnsureAsList<Map<String, dynamic>>('parameters')
              .map(
                (e) =>
                    TronHttpProposalCreateContractRequestParametersItem.fromJson(
                      e,
                    ),
              )
              .toList(),
      visible: json.valueAsBool('visible'),
      permissionId: json.valueAsInt('Permission_id'),
    );
  }

  Map<String, dynamic> toJson() => {
    'owner_address': ownerAddress,
    'parameters': parameters.map((e) => e.toJson()).toList(),
    'visible': visible,
    'Permission_id': permissionId,
  };
}

class TronHttpProposalDeleteContract {
  /// Address of the account that owns or initiates the request.
  final String? ownerAddress;

  /// Proposal id.
  final BigInt? proposalId;

  const TronHttpProposalDeleteContract({this.ownerAddress, this.proposalId});

  factory TronHttpProposalDeleteContract.fromJson(Map<String, dynamic> json) {
    return TronHttpProposalDeleteContract(
      ownerAddress:
          (json['owner_address'] is num
              ? json['owner_address'].toString()
              : json.valueAsString('owner_address')),
      proposalId: json.valueAsBigInt('proposal_id'),
    );
  }

  Map<String, dynamic> toJson() => {
    'owner_address': ownerAddress,
    'proposal_id': proposalId,
  };
}

class TronHttpProposalDeleteContractInt64StringCompatible {
  /// Address of the account that owns or initiates the request.
  final String? ownerAddress;

  /// Proposal id.
  final BigInt? proposalId;

  const TronHttpProposalDeleteContractInt64StringCompatible({
    this.ownerAddress,
    this.proposalId,
  });

  factory TronHttpProposalDeleteContractInt64StringCompatible.fromJson(
    Map<String, dynamic> json,
  ) {
    return TronHttpProposalDeleteContractInt64StringCompatible(
      ownerAddress:
          (json['owner_address'] is num
              ? json['owner_address'].toString()
              : json.valueAsString('owner_address')),
      proposalId: json.valueAsBigInt('proposal_id'),
    );
  }

  Map<String, dynamic> toJson() => {
    'owner_address': ownerAddress,
    'proposal_id': proposalId,
  };
}

class TronHttpProposalDeleteContractRequest {
  /// Address of the account that owns or initiates the request.
  final String ownerAddress;

  /// Proposal id.
  final BigInt proposalId;

  /// When true, addresses are encoded in base58check; when false or omitted, addresses are hex-encoded.
  final bool? visible;

  /// Permission id used to sign the transaction with a non-owner account permission.
  final int? permissionId;

  const TronHttpProposalDeleteContractRequest({
    required this.ownerAddress,
    required this.proposalId,
    this.visible,
    this.permissionId,
  });

  factory TronHttpProposalDeleteContractRequest.fromJson(
    Map<String, dynamic> json,
  ) {
    return TronHttpProposalDeleteContractRequest(
      ownerAddress:
          (json['owner_address'] is num
              ? json['owner_address'].toString()
              : json.valueAsString('owner_address')),
      proposalId: json.valueAsBigInt('proposal_id'),
      visible: json.valueAsBool('visible'),
      permissionId: json.valueAsInt('Permission_id'),
    );
  }

  Map<String, dynamic> toJson() => {
    'owner_address': ownerAddress,
    'proposal_id': proposalId,
    'visible': visible,
    'Permission_id': permissionId,
  };
}

class TronHttpProposalInt64StringCompatible {
  /// Proposal id.
  final BigInt? proposalId;
  final String? proposerAddress;
  final BigInt? expirationTime;
  final BigInt? createTime;
  final List<String>? approvals;
  final TronHttpProposalState? state;

  /// Proposal parameter map.
  final Map<String, BigInt>? parameters;

  const TronHttpProposalInt64StringCompatible({
    this.proposalId,
    this.proposerAddress,
    this.expirationTime,
    this.createTime,
    this.approvals,
    this.state,
    this.parameters,
  });

  factory TronHttpProposalInt64StringCompatible.fromJson(
    Map<String, dynamic> json,
  ) {
    return TronHttpProposalInt64StringCompatible(
      proposalId: json.valueAsBigInt('proposal_id'),
      proposerAddress:
          (json['proposer_address'] is num
              ? json['proposer_address'].toString()
              : json.valueAsString('proposer_address')),
      expirationTime: json.valueAsBigInt('expiration_time'),
      createTime: json.valueAsBigInt('create_time'),
      approvals: json.valueAsList<List<String>?>('approvals'),
      state:
          json.hasValue('state')
              ? TronHttpProposalState.fromJson(json['state'])
              : null,
      parameters:
          json.hasValue('parameters')
              ? _tronMapFromJson<BigInt>(
                json['parameters'],
                JsonParser.valueAsBigInt<BigInt>,
              )
              : null,
    );
  }

  Map<String, dynamic> toJson() => {
    'proposal_id': proposalId,
    'proposer_address': proposerAddress,
    'expiration_time': expirationTime,
    'create_time': createTime,
    'approvals': approvals,
    'state': state?.toJson(),
    'parameters': parameters == null ? null : _tronMapToJson(parameters!),
  };
}

class TronHttpProposalList {
  final List<TronHttpProposal>? proposals;

  const TronHttpProposalList({this.proposals});

  factory TronHttpProposalList.fromJson(Map<String, dynamic> json) {
    return TronHttpProposalList(
      proposals:
          json.hasValue('proposals')
              ? json
                  .valueEnsureAsList<Map<String, dynamic>>('proposals')
                  .map((e) => TronHttpProposal.fromJson(e))
                  .toList()
              : null,
    );
  }

  Map<String, dynamic> toJson() => {
    'proposals': proposals?.map((e) => e.toJson()).toList(),
  };
}

class TronHttpProposalListInt64StringCompatible {
  final List<TronHttpProposalInt64StringCompatible>? proposals;

  const TronHttpProposalListInt64StringCompatible({this.proposals});

  factory TronHttpProposalListInt64StringCompatible.fromJson(
    Map<String, dynamic> json,
  ) {
    return TronHttpProposalListInt64StringCompatible(
      proposals:
          json.hasValue('proposals')
              ? json
                  .valueEnsureAsList<Map<String, dynamic>>('proposals')
                  .map((e) => TronHttpProposalInt64StringCompatible.fromJson(e))
                  .toList()
              : null,
    );
  }

  Map<String, dynamic> toJson() => {
    'proposals': proposals?.map((e) => e.toJson()).toList(),
  };
}

class TronHttpReceiveDescription {
  final String? valueCommitment;
  final String? noteCommitment;
  final String? epk;
  final String? cEnc;
  final String? cOut;
  final String? zkproof;

  const TronHttpReceiveDescription({
    this.valueCommitment,
    this.noteCommitment,
    this.epk,
    this.cEnc,
    this.cOut,
    this.zkproof,
  });

  factory TronHttpReceiveDescription.fromJson(Map<String, dynamic> json) {
    return TronHttpReceiveDescription(
      valueCommitment:
          (json['value_commitment'] is num
              ? json['value_commitment'].toString()
              : json.valueAsString('value_commitment')),
      noteCommitment:
          (json['note_commitment'] is num
              ? json['note_commitment'].toString()
              : json.valueAsString('note_commitment')),
      epk:
          (json['epk'] is num
              ? json['epk'].toString()
              : json.valueAsString('epk')),
      cEnc:
          (json['c_enc'] is num
              ? json['c_enc'].toString()
              : json.valueAsString('c_enc')),
      cOut:
          (json['c_out'] is num
              ? json['c_out'].toString()
              : json.valueAsString('c_out')),
      zkproof:
          (json['zkproof'] is num
              ? json['zkproof'].toString()
              : json.valueAsString('zkproof')),
    );
  }

  Map<String, dynamic> toJson() => {
    'value_commitment': valueCommitment,
    'note_commitment': noteCommitment,
    'epk': epk,
    'c_enc': cEnc,
    'c_out': cOut,
    'zkproof': zkproof,
  };
}

class TronHttpResourceReceipt {
  final BigInt? energyUsage;
  final BigInt? energyFee;
  final BigInt? originEnergyUsage;
  final BigInt? energyUsageTotal;
  final BigInt? netUsage;
  final BigInt? netFee;
  final TronHttpTransactionResultContractRet? result;
  final BigInt? energyPenaltyTotal;

  const TronHttpResourceReceipt({
    this.energyUsage,
    this.energyFee,
    this.originEnergyUsage,
    this.energyUsageTotal,
    this.netUsage,
    this.netFee,
    this.result,
    this.energyPenaltyTotal,
  });

  factory TronHttpResourceReceipt.fromJson(Map<String, dynamic> json) {
    return TronHttpResourceReceipt(
      energyUsage: json.valueAsBigInt('energy_usage'),
      energyFee: json.valueAsBigInt('energy_fee'),
      originEnergyUsage: json.valueAsBigInt('origin_energy_usage'),
      energyUsageTotal: json.valueAsBigInt('energy_usage_total'),
      netUsage: json.valueAsBigInt('net_usage'),
      netFee: json.valueAsBigInt('net_fee'),
      result:
          json.hasValue('result')
              ? TronHttpTransactionResultContractRet.fromJson(json['result'])
              : null,
      energyPenaltyTotal: json.valueAsBigInt('energy_penalty_total'),
    );
  }

  Map<String, dynamic> toJson() => {
    'energy_usage': energyUsage,
    'energy_fee': energyFee,
    'origin_energy_usage': originEnergyUsage,
    'energy_usage_total': energyUsageTotal,
    'net_usage': netUsage,
    'net_fee': netFee,
    'result': result?.toJson(),
    'energy_penalty_total': energyPenaltyTotal,
  };
}

class TronHttpResourceReceiptInt64StringCompatible {
  final BigInt? energyUsage;
  final BigInt? energyFee;
  final BigInt? originEnergyUsage;
  final BigInt? energyUsageTotal;
  final BigInt? netUsage;
  final BigInt? netFee;
  final TronHttpTransactionResultContractRet? result;
  final BigInt? energyPenaltyTotal;

  const TronHttpResourceReceiptInt64StringCompatible({
    this.energyUsage,
    this.energyFee,
    this.originEnergyUsage,
    this.energyUsageTotal,
    this.netUsage,
    this.netFee,
    this.result,
    this.energyPenaltyTotal,
  });

  factory TronHttpResourceReceiptInt64StringCompatible.fromJson(
    Map<String, dynamic> json,
  ) {
    return TronHttpResourceReceiptInt64StringCompatible(
      energyUsage: json.valueAsBigInt('energy_usage'),
      energyFee: json.valueAsBigInt('energy_fee'),
      originEnergyUsage: json.valueAsBigInt('origin_energy_usage'),
      energyUsageTotal: json.valueAsBigInt('energy_usage_total'),
      netUsage: json.valueAsBigInt('net_usage'),
      netFee: json.valueAsBigInt('net_fee'),
      result:
          json.hasValue('result')
              ? TronHttpTransactionResultContractRet.fromJson(json['result'])
              : null,
      energyPenaltyTotal: json.valueAsBigInt('energy_penalty_total'),
    );
  }

  Map<String, dynamic> toJson() => {
    'energy_usage': energyUsage,
    'energy_fee': energyFee,
    'origin_energy_usage': originEnergyUsage,
    'energy_usage_total': energyUsageTotal,
    'net_usage': netUsage,
    'net_fee': netFee,
    'result': result?.toJson(),
    'energy_penalty_total': energyPenaltyTotal,
  };
}

class TronHttpReturn {
  final bool? result;
  final TronHttpReturnCode? code;
  final String? message;

  const TronHttpReturn({this.result, this.code, this.message});

  factory TronHttpReturn.fromJson(Map<String, dynamic> json) {
    return TronHttpReturn(
      result: json.valueAsBool('result'),
      code:
          json.hasValue('code')
              ? TronHttpReturnCode.fromJson(json['code'])
              : null,
      message:
          (json['message'] is num
              ? json['message'].toString()
              : json.valueAsString('message')),
    );
  }

  Map<String, dynamic> toJson() => {
    'result': result,
    'code': code?.toJson(),
    'message': message,
  };
}

class TronHttpSetAccountIdContract {
  final String? accountId;

  /// Address of the account that owns or initiates the request.
  final String? ownerAddress;

  const TronHttpSetAccountIdContract({this.accountId, this.ownerAddress});

  factory TronHttpSetAccountIdContract.fromJson(Map<String, dynamic> json) {
    return TronHttpSetAccountIdContract(
      accountId:
          (json['account_id'] is num
              ? json['account_id'].toString()
              : json.valueAsString('account_id')),
      ownerAddress:
          (json['owner_address'] is num
              ? json['owner_address'].toString()
              : json.valueAsString('owner_address')),
    );
  }

  Map<String, dynamic> toJson() => {
    'account_id': accountId,
    'owner_address': ownerAddress,
  };
}

class TronHttpShieldedTransferContract {
  final String? transparentFromAddress;
  final BigInt? fromAmount;
  final List<TronHttpSpendDescription>? spendDescription;
  final List<TronHttpReceiveDescription>? receiveDescription;
  final String? bindingSignature;
  final String? transparentToAddress;
  final BigInt? toAmount;

  const TronHttpShieldedTransferContract({
    this.transparentFromAddress,
    this.fromAmount,
    this.spendDescription,
    this.receiveDescription,
    this.bindingSignature,
    this.transparentToAddress,
    this.toAmount,
  });

  factory TronHttpShieldedTransferContract.fromJson(Map<String, dynamic> json) {
    return TronHttpShieldedTransferContract(
      transparentFromAddress:
          (json['transparent_from_address'] is num
              ? json['transparent_from_address'].toString()
              : json.valueAsString('transparent_from_address')),
      fromAmount: json.valueAsBigInt('from_amount'),
      spendDescription:
          json.hasValue('spend_description')
              ? json
                  .valueEnsureAsList<Map<String, dynamic>>('spend_description')
                  .map((e) => TronHttpSpendDescription.fromJson(e))
                  .toList()
              : null,
      receiveDescription:
          json.hasValue('receive_description')
              ? json
                  .valueEnsureAsList<Map<String, dynamic>>(
                    'receive_description',
                  )
                  .map((e) => TronHttpReceiveDescription.fromJson(e))
                  .toList()
              : null,
      bindingSignature:
          (json['binding_signature'] is num
              ? json['binding_signature'].toString()
              : json.valueAsString('binding_signature')),
      transparentToAddress:
          (json['transparent_to_address'] is num
              ? json['transparent_to_address'].toString()
              : json.valueAsString('transparent_to_address')),
      toAmount: json.valueAsBigInt('to_amount'),
    );
  }

  Map<String, dynamic> toJson() => {
    'transparent_from_address': transparentFromAddress,
    'from_amount': fromAmount,
    'spend_description': spendDescription?.map((e) => e.toJson()).toList(),
    'receive_description': receiveDescription?.map((e) => e.toJson()).toList(),
    'binding_signature': bindingSignature,
    'transparent_to_address': transparentToAddress,
    'to_amount': toAmount,
  };
}

class TronHttpShieldedTransferContractInt64StringCompatible {
  final String? transparentFromAddress;
  final BigInt? fromAmount;
  final List<TronHttpSpendDescription>? spendDescription;
  final List<TronHttpReceiveDescription>? receiveDescription;
  final String? bindingSignature;
  final String? transparentToAddress;
  final BigInt? toAmount;

  const TronHttpShieldedTransferContractInt64StringCompatible({
    this.transparentFromAddress,
    this.fromAmount,
    this.spendDescription,
    this.receiveDescription,
    this.bindingSignature,
    this.transparentToAddress,
    this.toAmount,
  });

  factory TronHttpShieldedTransferContractInt64StringCompatible.fromJson(
    Map<String, dynamic> json,
  ) {
    return TronHttpShieldedTransferContractInt64StringCompatible(
      transparentFromAddress:
          (json['transparent_from_address'] is num
              ? json['transparent_from_address'].toString()
              : json.valueAsString('transparent_from_address')),
      fromAmount: json.valueAsBigInt('from_amount'),
      spendDescription:
          json.hasValue('spend_description')
              ? json
                  .valueEnsureAsList<Map<String, dynamic>>('spend_description')
                  .map((e) => TronHttpSpendDescription.fromJson(e))
                  .toList()
              : null,
      receiveDescription:
          json.hasValue('receive_description')
              ? json
                  .valueEnsureAsList<Map<String, dynamic>>(
                    'receive_description',
                  )
                  .map((e) => TronHttpReceiveDescription.fromJson(e))
                  .toList()
              : null,
      bindingSignature:
          (json['binding_signature'] is num
              ? json['binding_signature'].toString()
              : json.valueAsString('binding_signature')),
      transparentToAddress:
          (json['transparent_to_address'] is num
              ? json['transparent_to_address'].toString()
              : json.valueAsString('transparent_to_address')),
      toAmount: json.valueAsBigInt('to_amount'),
    );
  }

  Map<String, dynamic> toJson() => {
    'transparent_from_address': transparentFromAddress,
    'from_amount': fromAmount,
    'spend_description': spendDescription?.map((e) => e.toJson()).toList(),
    'receive_description': receiveDescription?.map((e) => e.toJson()).toList(),
    'binding_signature': bindingSignature,
    'transparent_to_address': transparentToAddress,
    'to_amount': toAmount,
  };
}

class TronHttpSmartContract {
  final String? originAddress;

  /// Smart contract address.
  final String? contractAddress;
  final TronHttpSmartContractABI? abi;

  /// Compiled smart contract bytecode.
  final String? bytecode;

  /// TRX amount in sun transferred with the smart contract call.
  final BigInt? callValue;

  /// Percentage of contract execution resource cost paid by the user.
  final BigInt? consumeUserResourcePercent;

  /// Name encoded as expected by java-tron.
  final String? name;

  /// Origin energy limit for a deployed smart contract.
  final BigInt? originEnergyLimit;
  final String? codeHash;
  final String? trxHash;
  final int? version;

  const TronHttpSmartContract({
    this.originAddress,
    this.contractAddress,
    this.abi,
    this.bytecode,
    this.callValue,
    this.consumeUserResourcePercent,
    this.name,
    this.originEnergyLimit,
    this.codeHash,
    this.trxHash,
    this.version,
  });

  factory TronHttpSmartContract.fromJson(Map<String, dynamic> json) {
    return TronHttpSmartContract(
      originAddress:
          (json['origin_address'] is num
              ? json['origin_address'].toString()
              : json.valueAsString('origin_address')),
      contractAddress:
          (json['contract_address'] is num
              ? json['contract_address'].toString()
              : json.valueAsString('contract_address')),
      abi: json.valueTo<TronHttpSmartContractABI?, Map<String, dynamic>>(
        key: 'abi',
        parse: (v) => TronHttpSmartContractABI.fromJson(v),
      ),
      bytecode:
          (json['bytecode'] is num
              ? json['bytecode'].toString()
              : json.valueAsString('bytecode')),
      callValue: json.valueAsBigInt('call_value'),
      consumeUserResourcePercent: json.valueAsBigInt(
        'consume_user_resource_percent',
      ),
      name:
          (json['name'] is num
              ? json['name'].toString()
              : json.valueAsString('name')),
      originEnergyLimit: json.valueAsBigInt('origin_energy_limit'),
      codeHash:
          (json['code_hash'] is num
              ? json['code_hash'].toString()
              : json.valueAsString('code_hash')),
      trxHash:
          (json['trx_hash'] is num
              ? json['trx_hash'].toString()
              : json.valueAsString('trx_hash')),
      version: json.valueAsInt('version'),
    );
  }

  Map<String, dynamic> toJson() => {
    'origin_address': originAddress,
    'contract_address': contractAddress,
    'abi': abi?.toJson(),
    'bytecode': bytecode,
    'call_value': callValue,
    'consume_user_resource_percent': consumeUserResourcePercent,
    'name': name,
    'origin_energy_limit': originEnergyLimit,
    'code_hash': codeHash,
    'trx_hash': trxHash,
    'version': version,
  };
}

/// Smart contract ABI definition.
class TronHttpSmartContractABI {
  final List<TronHttpSmartContractABIEntry>? entrys;

  const TronHttpSmartContractABI({this.entrys});

  factory TronHttpSmartContractABI.fromJson(Map<String, dynamic> json) {
    return TronHttpSmartContractABI(
      entrys:
          json.hasValue('entrys')
              ? json
                  .valueEnsureAsList<Map<String, dynamic>>('entrys')
                  .map((e) => TronHttpSmartContractABIEntry.fromJson(e))
                  .toList()
              : null,
    );
  }

  Map<String, dynamic> toJson() => {
    'entrys': entrys?.map((e) => e.toJson()).toList(),
  };
}

class TronHttpSmartContractABIEntry {
  final bool? anonymous;
  final bool? constant;

  /// Name encoded as expected by java-tron.
  final String? name;
  final List<TronHttpSmartContractABIEntryParam>? inputs;
  final List<TronHttpSmartContractABIEntryParam>? outputs;

  /// Account, contract, or resource type.
  final TronHttpSmartContractABIEntryType? type;
  final bool? payable;
  final TronHttpSmartContractABIEntryStateMutability? stateMutability;

  const TronHttpSmartContractABIEntry({
    this.anonymous,
    this.constant,
    this.name,
    this.inputs,
    this.outputs,
    this.type,
    this.payable,
    this.stateMutability,
  });

  factory TronHttpSmartContractABIEntry.fromJson(Map<String, dynamic> json) {
    return TronHttpSmartContractABIEntry(
      anonymous: json.valueAsBool('anonymous'),
      constant: json.valueAsBool('constant'),
      name:
          (json['name'] is num
              ? json['name'].toString()
              : json.valueAsString('name')),
      inputs:
          json.hasValue('inputs')
              ? json
                  .valueEnsureAsList<Map<String, dynamic>>('inputs')
                  .map((e) => TronHttpSmartContractABIEntryParam.fromJson(e))
                  .toList()
              : null,
      outputs:
          json.hasValue('outputs')
              ? json
                  .valueEnsureAsList<Map<String, dynamic>>('outputs')
                  .map((e) => TronHttpSmartContractABIEntryParam.fromJson(e))
                  .toList()
              : null,
      type:
          json.hasValue('type')
              ? TronHttpSmartContractABIEntryType.fromJson(json['type'])
              : null,
      payable: json.valueAsBool('payable'),
      stateMutability:
          json.hasValue('stateMutability')
              ? TronHttpSmartContractABIEntryStateMutability.fromJson(
                json['stateMutability'],
              )
              : null,
    );
  }

  Map<String, dynamic> toJson() => {
    'anonymous': anonymous,
    'constant': constant,
    'name': name,
    'inputs': inputs?.map((e) => e.toJson()).toList(),
    'outputs': outputs?.map((e) => e.toJson()).toList(),
    'type': type?.toJson(),
    'payable': payable,
    'stateMutability': stateMutability?.toJson(),
  };
}

class TronHttpSmartContractABIEntryParam {
  final bool? indexed;

  /// Name encoded as expected by java-tron.
  final String? name;

  /// Account, contract, or resource type.
  final String? type;

  const TronHttpSmartContractABIEntryParam({
    this.indexed,
    this.name,
    this.type,
  });

  factory TronHttpSmartContractABIEntryParam.fromJson(
    Map<String, dynamic> json,
  ) {
    return TronHttpSmartContractABIEntryParam(
      indexed: json.valueAsBool('indexed'),
      name:
          (json['name'] is num
              ? json['name'].toString()
              : json.valueAsString('name')),
      type:
          (json['type'] is num
              ? json['type'].toString()
              : json.valueAsString('type')),
    );
  }

  Map<String, dynamic> toJson() => {
    'indexed': indexed,
    'name': name,
    'type': type,
  };
}

class TronHttpSmartContractDataWrapper {
  final TronHttpSmartContract? smartContract;
  final String? runtimecode;
  final TronHttpContractState? contractState;

  const TronHttpSmartContractDataWrapper({
    this.smartContract,
    this.runtimecode,
    this.contractState,
  });

  factory TronHttpSmartContractDataWrapper.fromJson(Map<String, dynamic> json) {
    return TronHttpSmartContractDataWrapper(
      smartContract: json.valueTo<TronHttpSmartContract?, Map<String, dynamic>>(
        key: 'smart_contract',
        parse: (v) => TronHttpSmartContract.fromJson(v),
      ),
      runtimecode:
          (json['runtimecode'] is num
              ? json['runtimecode'].toString()
              : json.valueAsString('runtimecode')),
      contractState: json.valueTo<TronHttpContractState?, Map<String, dynamic>>(
        key: 'contract_state',
        parse: (v) => TronHttpContractState.fromJson(v),
      ),
    );
  }

  Map<String, dynamic> toJson() => {
    'smart_contract': smartContract?.toJson(),
    'runtimecode': runtimecode,
    'contract_state': contractState?.toJson(),
  };
}

class TronHttpSmartContractDataWrapperInt64StringCompatible {
  final TronHttpSmartContractInt64StringCompatible? smartContract;
  final String? runtimecode;
  final TronHttpContractStateInt64StringCompatible? contractState;

  const TronHttpSmartContractDataWrapperInt64StringCompatible({
    this.smartContract,
    this.runtimecode,
    this.contractState,
  });

  factory TronHttpSmartContractDataWrapperInt64StringCompatible.fromJson(
    Map<String, dynamic> json,
  ) {
    return TronHttpSmartContractDataWrapperInt64StringCompatible(
      smartContract: json.valueTo<
        TronHttpSmartContractInt64StringCompatible?,
        Map<String, dynamic>
      >(
        key: 'smart_contract',
        parse: (v) => TronHttpSmartContractInt64StringCompatible.fromJson(v),
      ),
      runtimecode:
          (json['runtimecode'] is num
              ? json['runtimecode'].toString()
              : json.valueAsString('runtimecode')),
      contractState: json.valueTo<
        TronHttpContractStateInt64StringCompatible?,
        Map<String, dynamic>
      >(
        key: 'contract_state',
        parse: (v) => TronHttpContractStateInt64StringCompatible.fromJson(v),
      ),
    );
  }

  Map<String, dynamic> toJson() => {
    'smart_contract': smartContract?.toJson(),
    'runtimecode': runtimecode,
    'contract_state': contractState?.toJson(),
  };
}

class TronHttpSmartContractInt64StringCompatible {
  final String? originAddress;

  /// Smart contract address.
  final String? contractAddress;
  final TronHttpSmartContractABI? abi;

  /// Compiled smart contract bytecode.
  final String? bytecode;

  /// TRX amount in sun transferred with the smart contract call.
  final BigInt? callValue;

  /// Percentage of contract execution resource cost paid by the user.
  final BigInt? consumeUserResourcePercent;

  /// Name encoded as expected by java-tron.
  final String? name;

  /// Origin energy limit for a deployed smart contract.
  final BigInt? originEnergyLimit;
  final String? codeHash;
  final String? trxHash;
  final int? version;

  const TronHttpSmartContractInt64StringCompatible({
    this.originAddress,
    this.contractAddress,
    this.abi,
    this.bytecode,
    this.callValue,
    this.consumeUserResourcePercent,
    this.name,
    this.originEnergyLimit,
    this.codeHash,
    this.trxHash,
    this.version,
  });

  factory TronHttpSmartContractInt64StringCompatible.fromJson(
    Map<String, dynamic> json,
  ) {
    return TronHttpSmartContractInt64StringCompatible(
      originAddress:
          (json['origin_address'] is num
              ? json['origin_address'].toString()
              : json.valueAsString('origin_address')),
      contractAddress:
          (json['contract_address'] is num
              ? json['contract_address'].toString()
              : json.valueAsString('contract_address')),
      abi: json.valueTo<TronHttpSmartContractABI?, Map<String, dynamic>>(
        key: 'abi',
        parse: (v) => TronHttpSmartContractABI.fromJson(v),
      ),
      bytecode:
          (json['bytecode'] is num
              ? json['bytecode'].toString()
              : json.valueAsString('bytecode')),
      callValue: json.valueAsBigInt('call_value'),
      consumeUserResourcePercent: json.valueAsBigInt(
        'consume_user_resource_percent',
      ),
      name:
          (json['name'] is num
              ? json['name'].toString()
              : json.valueAsString('name')),
      originEnergyLimit: json.valueAsBigInt('origin_energy_limit'),
      codeHash:
          (json['code_hash'] is num
              ? json['code_hash'].toString()
              : json.valueAsString('code_hash')),
      trxHash:
          (json['trx_hash'] is num
              ? json['trx_hash'].toString()
              : json.valueAsString('trx_hash')),
      version: json.valueAsInt('version'),
    );
  }

  Map<String, dynamic> toJson() => {
    'origin_address': originAddress,
    'contract_address': contractAddress,
    'abi': abi?.toJson(),
    'bytecode': bytecode,
    'call_value': callValue,
    'consume_user_resource_percent': consumeUserResourcePercent,
    'name': name,
    'origin_energy_limit': originEnergyLimit,
    'code_hash': codeHash,
    'trx_hash': trxHash,
    'version': version,
  };
}

class TronHttpSpendDescription {
  final String? valueCommitment;
  final String? anchor;
  final String? nullifier;
  final String? rk;
  final String? zkproof;
  final String? spendAuthoritySignature;

  const TronHttpSpendDescription({
    this.valueCommitment,
    this.anchor,
    this.nullifier,
    this.rk,
    this.zkproof,
    this.spendAuthoritySignature,
  });

  factory TronHttpSpendDescription.fromJson(Map<String, dynamic> json) {
    return TronHttpSpendDescription(
      valueCommitment:
          (json['value_commitment'] is num
              ? json['value_commitment'].toString()
              : json.valueAsString('value_commitment')),
      anchor:
          (json['anchor'] is num
              ? json['anchor'].toString()
              : json.valueAsString('anchor')),
      nullifier:
          (json['nullifier'] is num
              ? json['nullifier'].toString()
              : json.valueAsString('nullifier')),
      rk:
          (json['rk'] is num
              ? json['rk'].toString()
              : json.valueAsString('rk')),
      zkproof:
          (json['zkproof'] is num
              ? json['zkproof'].toString()
              : json.valueAsString('zkproof')),
      spendAuthoritySignature:
          (json['spend_authority_signature'] is num
              ? json['spend_authority_signature'].toString()
              : json.valueAsString('spend_authority_signature')),
    );
  }

  Map<String, dynamic> toJson() => {
    'value_commitment': valueCommitment,
    'anchor': anchor,
    'nullifier': nullifier,
    'rk': rk,
    'zkproof': zkproof,
    'spend_authority_signature': spendAuthoritySignature,
  };
}

class TronHttpTransaction {
  final String? txID;
  final TronHttpTransactionRaw? rawData;

  /// Hex-encoded transaction raw data.
  final String? rawDataHex;

  /// Transaction signatures.
  final List<String>? signature;

  /// Transaction result entries returned by java-tron when present.
  final List<TronHttpTransactionResult>? ret;

  /// When true, addresses are encoded in base58check; when false or omitted, addresses are hex-encoded.
  final bool? visible;

  /// Smart contract address.
  final String? contractAddress;

  const TronHttpTransaction({
    this.txID,
    this.rawData,
    this.rawDataHex,
    this.signature,
    this.ret,
    this.visible,
    this.contractAddress,
  });

  factory TronHttpTransaction.fromJson(Map<String, dynamic> json) {
    return TronHttpTransaction(
      txID:
          (json['txID'] is num
              ? json['txID'].toString()
              : json.valueAsString('txID')),
      rawData: json.valueTo<TronHttpTransactionRaw?, Map<String, dynamic>>(
        key: 'raw_data',
        parse: (v) => TronHttpTransactionRaw.fromJson(v),
      ),
      rawDataHex:
          (json['raw_data_hex'] is num
              ? json['raw_data_hex'].toString()
              : json.valueAsString('raw_data_hex')),
      signature: json.valueAsList<List<String>?>('signature'),
      ret:
          json.hasValue('ret')
              ? json
                  .valueEnsureAsList<Map<String, dynamic>>('ret')
                  .map((e) => TronHttpTransactionResult.fromJson(e))
                  .toList()
              : null,
      visible: json.valueAsBool('visible'),
      contractAddress:
          (json['contract_address'] is num
              ? json['contract_address'].toString()
              : json.valueAsString('contract_address')),
    );
  }

  Map<String, dynamic> toJson() => {
    'txID': txID,
    'raw_data': rawData?.toJson(),
    'raw_data_hex': rawDataHex,
    'signature': signature,
    'ret': ret?.map((e) => e.toJson()).toList(),
    'visible': visible,
    'contract_address': contractAddress,
  };
}

class TronHttpTransactionApprovedList {
  final List<String>? approvedList;
  final TronHttpTransactionApprovedListResult? result;
  final TronHttpTransactionExtention? transaction;

  const TronHttpTransactionApprovedList({
    this.approvedList,
    this.result,
    this.transaction,
  });

  factory TronHttpTransactionApprovedList.fromJson(Map<String, dynamic> json) {
    return TronHttpTransactionApprovedList(
      approvedList: json.valueAsList<List<String>?>('approved_list'),
      result: json.valueTo<
        TronHttpTransactionApprovedListResult?,
        Map<String, dynamic>
      >(
        key: 'result',
        parse: (v) => TronHttpTransactionApprovedListResult.fromJson(v),
      ),
      transaction: json
          .valueTo<TronHttpTransactionExtention?, Map<String, dynamic>>(
            key: 'transaction',
            parse: (v) => TronHttpTransactionExtention.fromJson(v),
          ),
    );
  }

  Map<String, dynamic> toJson() => {
    'approved_list': approvedList,
    'result': result?.toJson(),
    'transaction': transaction?.toJson(),
  };
}

class TronHttpTransactionApprovedListResult {
  final TronHttpTransactionApprovedListResultCode? code;
  final String? message;

  const TronHttpTransactionApprovedListResult({this.code, this.message});

  factory TronHttpTransactionApprovedListResult.fromJson(
    Map<String, dynamic> json,
  ) {
    return TronHttpTransactionApprovedListResult(
      code:
          json.hasValue('code')
              ? TronHttpTransactionApprovedListResultCode.fromJson(json['code'])
              : null,
      message:
          (json['message'] is num
              ? json['message'].toString()
              : json.valueAsString('message')),
    );
  }

  Map<String, dynamic> toJson() => {'code': code?.toJson(), 'message': message};
}

class TronHttpTransactionBalanceTrace {
  final String? transactionIdentifier;
  final List<TronHttpTransactionBalanceTraceOperation>? operation;

  /// Account, contract, or resource type.
  final String? type;
  final String? status;

  const TronHttpTransactionBalanceTrace({
    this.transactionIdentifier,
    this.operation,
    this.type,
    this.status,
  });

  factory TronHttpTransactionBalanceTrace.fromJson(Map<String, dynamic> json) {
    return TronHttpTransactionBalanceTrace(
      transactionIdentifier:
          (json['transaction_identifier'] is num
              ? json['transaction_identifier'].toString()
              : json.valueAsString('transaction_identifier')),
      operation:
          json.hasValue('operation')
              ? json
                  .valueEnsureAsList<Map<String, dynamic>>('operation')
                  .map(
                    (e) => TronHttpTransactionBalanceTraceOperation.fromJson(e),
                  )
                  .toList()
              : null,
      type:
          (json['type'] is num
              ? json['type'].toString()
              : json.valueAsString('type')),
      status:
          (json['status'] is num
              ? json['status'].toString()
              : json.valueAsString('status')),
    );
  }

  Map<String, dynamic> toJson() => {
    'transaction_identifier': transactionIdentifier,
    'operation': operation?.map((e) => e.toJson()).toList(),
    'type': type,
    'status': status,
  };
}

class TronHttpTransactionBalanceTraceOperation {
  final BigInt? operationIdentifier;

  /// Account or contract address accepted by this endpoint.
  final String? address;

  /// Amount in sun, where 1 TRX equals 1,000,000 sun.
  final BigInt? amount;

  const TronHttpTransactionBalanceTraceOperation({
    this.operationIdentifier,
    this.address,
    this.amount,
  });

  factory TronHttpTransactionBalanceTraceOperation.fromJson(
    Map<String, dynamic> json,
  ) {
    return TronHttpTransactionBalanceTraceOperation(
      operationIdentifier: json.valueAsBigInt('operation_identifier'),
      address:
          (json['address'] is num
              ? json['address'].toString()
              : json.valueAsString('address')),
      amount: json.valueAsBigInt('amount'),
    );
  }

  Map<String, dynamic> toJson() => {
    'operation_identifier': operationIdentifier,
    'address': address,
    'amount': amount,
  };
}

class TronHttpTransactionContract {
  /// Account, contract, or resource type.
  final TronHttpTransactionContractType? type;

  /// Contract parameter payload.
  final TronHttpTransactionContractParameter? parameter;
  final String? provider;
  final String? contractName;

  /// Permission id used to sign the transaction with a non-owner account permission.
  final int? permissionId;

  const TronHttpTransactionContract({
    this.type,
    this.parameter,
    this.provider,
    this.contractName,
    this.permissionId,
  });

  factory TronHttpTransactionContract.fromJson(Map<String, dynamic> json) {
    return TronHttpTransactionContract(
      type:
          json.hasValue('type')
              ? TronHttpTransactionContractType.fromJson(json['type'])
              : null,
      parameter: json
          .valueTo<TronHttpTransactionContractParameter?, Map<String, dynamic>>(
            key: 'parameter',
            parse: (v) => TronHttpTransactionContractParameter.fromJson(v),
          ),
      provider:
          (json['provider'] is num
              ? json['provider'].toString()
              : json.valueAsString('provider')),
      contractName:
          (json['ContractName'] is num
              ? json['ContractName'].toString()
              : json.valueAsString('ContractName')),
      permissionId: json.valueAsInt('Permission_id'),
    );
  }

  Map<String, dynamic> toJson() => {
    'type': type?.toJson(),
    'parameter': parameter?.toJson(),
    'provider': provider,
    'ContractName': contractName,
    'Permission_id': permissionId,
  };
}

class TronHttpTransactionContractInt64StringCompatible {
  /// Account, contract, or resource type.
  final TronHttpTransactionContractType? type;

  /// Contract parameter payload.
  final TronHttpTransactionContractInt64StringCompatibleParameter? parameter;
  final String? provider;
  final String? contractName;

  /// Permission id used to sign the transaction with a non-owner account permission.
  final int? permissionId;

  const TronHttpTransactionContractInt64StringCompatible({
    this.type,
    this.parameter,
    this.provider,
    this.contractName,
    this.permissionId,
  });

  factory TronHttpTransactionContractInt64StringCompatible.fromJson(
    Map<String, dynamic> json,
  ) {
    return TronHttpTransactionContractInt64StringCompatible(
      type:
          json.hasValue('type')
              ? TronHttpTransactionContractType.fromJson(json['type'])
              : null,
      parameter: json.valueTo<
        TronHttpTransactionContractInt64StringCompatibleParameter?,
        Map<String, dynamic>
      >(
        key: 'parameter',
        parse:
            (v) =>
                TronHttpTransactionContractInt64StringCompatibleParameter.fromJson(
                  v,
                ),
      ),
      provider:
          (json['provider'] is num
              ? json['provider'].toString()
              : json.valueAsString('provider')),
      contractName:
          (json['ContractName'] is num
              ? json['ContractName'].toString()
              : json.valueAsString('ContractName')),
      permissionId: json.valueAsInt('Permission_id'),
    );
  }

  Map<String, dynamic> toJson() => {
    'type': type?.toJson(),
    'parameter': parameter?.toJson(),
    'provider': provider,
    'ContractName': contractName,
    'Permission_id': permissionId,
  };
}

class TronHttpTransactionExtention {
  final TronHttpTransaction? transaction;
  final String? txid;
  final List<String>? constantResult;
  final TronHttpReturn? result;
  final BigInt? energyUsed;
  final List<TronHttpTransactionInfoLog>? logs;
  final List<TronHttpInternalTransaction>? internalTransactions;
  final BigInt? energyPenalty;

  const TronHttpTransactionExtention({
    this.transaction,
    this.txid,
    this.constantResult,
    this.result,
    this.energyUsed,
    this.logs,
    this.internalTransactions,
    this.energyPenalty,
  });

  factory TronHttpTransactionExtention.fromJson(Map<String, dynamic> json) {
    return TronHttpTransactionExtention(
      transaction: json.valueTo<TronHttpTransaction?, Map<String, dynamic>>(
        key: 'transaction',
        parse: (v) => TronHttpTransaction.fromJson(v),
      ),
      txid:
          (json['txid'] is num
              ? json['txid'].toString()
              : json.valueAsString('txid')),
      constantResult: json.valueAsList<List<String>?>('constant_result'),
      result: json.valueTo<TronHttpReturn?, Map<String, dynamic>>(
        key: 'result',
        parse: (v) => TronHttpReturn.fromJson(v),
      ),
      energyUsed: json.valueAsBigInt('energy_used'),
      logs:
          json.hasValue('logs')
              ? json
                  .valueEnsureAsList<Map<String, dynamic>>('logs')
                  .map((e) => TronHttpTransactionInfoLog.fromJson(e))
                  .toList()
              : null,
      internalTransactions:
          json.hasValue('internal_transactions')
              ? json
                  .valueEnsureAsList<Map<String, dynamic>>(
                    'internal_transactions',
                  )
                  .map((e) => TronHttpInternalTransaction.fromJson(e))
                  .toList()
              : null,
      energyPenalty: json.valueAsBigInt('energy_penalty'),
    );
  }

  Map<String, dynamic> toJson() => {
    'transaction': transaction?.toJson(),
    'txid': txid,
    'constant_result': constantResult,
    'result': result?.toJson(),
    'energy_used': energyUsed,
    'logs': logs?.map((e) => e.toJson()).toList(),
    'internal_transactions':
        internalTransactions?.map((e) => e.toJson()).toList(),
    'energy_penalty': energyPenalty,
  };
}

class TronHttpTransactionIdList {
  final List<String>? txId;

  const TronHttpTransactionIdList({this.txId});

  factory TronHttpTransactionIdList.fromJson(Map<String, dynamic> json) {
    return TronHttpTransactionIdList(
      txId: json.valueAsList<List<String>?>('txId'),
    );
  }

  Map<String, dynamic> toJson() => {'txId': txId};
}

class TronHttpTransactionInfo {
  /// Identifier used by this query.
  final String? id;
  final BigInt? fee;

  /// Hex-encoded block number.
  final BigInt? blockNumber;
  final BigInt? blockTimeStamp;
  final List<String>? contractResult;

  /// Smart contract address.
  final String? contractAddress;
  final TronHttpResourceReceipt? receipt;
  final List<TronHttpTransactionInfoLog>? log;
  final TronHttpTransactionResultRet? result;
  final String? resMessage;
  final String? assetIssueID;
  final BigInt? withdrawAmount;
  final BigInt? unfreezeAmount;
  final List<TronHttpInternalTransaction>? internalTransactions;
  final BigInt? exchangeReceivedAmount;
  final BigInt? exchangeInjectAnotherAmount;
  final BigInt? exchangeWithdrawAnotherAmount;
  final BigInt? exchangeId;
  final BigInt? shieldedTransactionFee;
  final String? orderId;
  final List<TronHttpMarketOrderDetail>? orderDetails;
  final BigInt? packingFee;
  final BigInt? withdrawExpireAmount;
  final Map<String, BigInt>? cancelUnfreezeV2Amount;

  const TronHttpTransactionInfo({
    this.id,
    this.fee,
    this.blockNumber,
    this.blockTimeStamp,
    this.contractResult,
    this.contractAddress,
    this.receipt,
    this.log,
    this.result,
    this.resMessage,
    this.assetIssueID,
    this.withdrawAmount,
    this.unfreezeAmount,
    this.internalTransactions,
    this.exchangeReceivedAmount,
    this.exchangeInjectAnotherAmount,
    this.exchangeWithdrawAnotherAmount,
    this.exchangeId,
    this.shieldedTransactionFee,
    this.orderId,
    this.orderDetails,
    this.packingFee,
    this.withdrawExpireAmount,
    this.cancelUnfreezeV2Amount,
  });

  factory TronHttpTransactionInfo.fromJson(Map<String, dynamic> json) {
    return TronHttpTransactionInfo(
      id:
          (json['id'] is num
              ? json['id'].toString()
              : json.valueAsString('id')),
      fee: json.valueAsBigInt('fee'),
      blockNumber: json.valueAsBigInt('blockNumber'),
      blockTimeStamp: json.valueAsBigInt('blockTimeStamp'),
      contractResult: json.valueAsList<List<String>?>('contractResult'),
      contractAddress:
          (json['contract_address'] is num
              ? json['contract_address'].toString()
              : json.valueAsString('contract_address')),
      receipt: json.valueTo<TronHttpResourceReceipt?, Map<String, dynamic>>(
        key: 'receipt',
        parse: (v) => TronHttpResourceReceipt.fromJson(v),
      ),
      log:
          json.hasValue('log')
              ? json
                  .valueEnsureAsList<Map<String, dynamic>>('log')
                  .map((e) => TronHttpTransactionInfoLog.fromJson(e))
                  .toList()
              : null,
      result:
          json.hasValue('result')
              ? TronHttpTransactionResultRet.fromJson(json['result'])
              : null,
      resMessage:
          (json['resMessage'] is num
              ? json['resMessage'].toString()
              : json.valueAsString('resMessage')),
      assetIssueID:
          (json['assetIssueID'] is num
              ? json['assetIssueID'].toString()
              : json.valueAsString('assetIssueID')),
      withdrawAmount: json.valueAsBigInt('withdraw_amount'),
      unfreezeAmount: json.valueAsBigInt('unfreeze_amount'),
      internalTransactions:
          json.hasValue('internal_transactions')
              ? json
                  .valueEnsureAsList<Map<String, dynamic>>(
                    'internal_transactions',
                  )
                  .map((e) => TronHttpInternalTransaction.fromJson(e))
                  .toList()
              : null,
      exchangeReceivedAmount: json.valueAsBigInt('exchange_received_amount'),
      exchangeInjectAnotherAmount: json.valueAsBigInt(
        'exchange_inject_another_amount',
      ),
      exchangeWithdrawAnotherAmount: json.valueAsBigInt(
        'exchange_withdraw_another_amount',
      ),
      exchangeId: json.valueAsBigInt('exchange_id'),
      shieldedTransactionFee: json.valueAsBigInt('shielded_transaction_fee'),
      orderId:
          (json['orderId'] is num
              ? json['orderId'].toString()
              : json.valueAsString('orderId')),
      orderDetails:
          json.hasValue('orderDetails')
              ? json
                  .valueEnsureAsList<Map<String, dynamic>>('orderDetails')
                  .map((e) => TronHttpMarketOrderDetail.fromJson(e))
                  .toList()
              : null,
      packingFee: json.valueAsBigInt('packingFee'),
      withdrawExpireAmount: json.valueAsBigInt('withdraw_expire_amount'),
      cancelUnfreezeV2Amount:
          json.hasValue('cancel_unfreezeV2_amount')
              ? _tronMapFromJson<BigInt>(
                json['cancel_unfreezeV2_amount'],
                JsonParser.valueAsBigInt<BigInt>,
              )
              : null,
    );
  }

  Map<String, dynamic> toJson() => {
    'id': id,
    'fee': fee,
    'blockNumber': blockNumber,
    'blockTimeStamp': blockTimeStamp,
    'contractResult': contractResult,
    'contract_address': contractAddress,
    'receipt': receipt?.toJson(),
    'log': log?.map((e) => e.toJson()).toList(),
    'result': result?.toJson(),
    'resMessage': resMessage,
    'assetIssueID': assetIssueID,
    'withdraw_amount': withdrawAmount,
    'unfreeze_amount': unfreezeAmount,
    'internal_transactions':
        internalTransactions?.map((e) => e.toJson()).toList(),
    'exchange_received_amount': exchangeReceivedAmount,
    'exchange_inject_another_amount': exchangeInjectAnotherAmount,
    'exchange_withdraw_another_amount': exchangeWithdrawAnotherAmount,
    'exchange_id': exchangeId,
    'shielded_transaction_fee': shieldedTransactionFee,
    'orderId': orderId,
    'orderDetails': orderDetails?.map((e) => e.toJson()).toList(),
    'packingFee': packingFee,
    'withdraw_expire_amount': withdrawExpireAmount,
    'cancel_unfreezeV2_amount':
        cancelUnfreezeV2Amount == null
            ? null
            : _tronMapToJson(cancelUnfreezeV2Amount!),
  };
}

class TronHttpTransactionInfoInt64StringCompatible {
  /// Identifier used by this query.
  final String? id;
  final BigInt? fee;

  /// Hex-encoded block number.
  final BigInt? blockNumber;
  final BigInt? blockTimeStamp;
  final List<String>? contractResult;

  /// Smart contract address.
  final String? contractAddress;
  final TronHttpResourceReceiptInt64StringCompatible? receipt;
  final List<TronHttpTransactionInfoLog>? log;
  final TronHttpTransactionResultRet? result;
  final String? resMessage;
  final String? assetIssueID;
  final BigInt? withdrawAmount;
  final BigInt? unfreezeAmount;
  final List<TronHttpInternalTransactionInt64StringCompatible>?
  internalTransactions;
  final BigInt? exchangeReceivedAmount;
  final BigInt? exchangeInjectAnotherAmount;
  final BigInt? exchangeWithdrawAnotherAmount;
  final BigInt? exchangeId;
  final BigInt? shieldedTransactionFee;
  final String? orderId;
  final List<TronHttpMarketOrderDetailInt64StringCompatible>? orderDetails;
  final BigInt? packingFee;
  final BigInt? withdrawExpireAmount;
  final Map<String, BigInt>? cancelUnfreezeV2Amount;

  const TronHttpTransactionInfoInt64StringCompatible({
    this.id,
    this.fee,
    this.blockNumber,
    this.blockTimeStamp,
    this.contractResult,
    this.contractAddress,
    this.receipt,
    this.log,
    this.result,
    this.resMessage,
    this.assetIssueID,
    this.withdrawAmount,
    this.unfreezeAmount,
    this.internalTransactions,
    this.exchangeReceivedAmount,
    this.exchangeInjectAnotherAmount,
    this.exchangeWithdrawAnotherAmount,
    this.exchangeId,
    this.shieldedTransactionFee,
    this.orderId,
    this.orderDetails,
    this.packingFee,
    this.withdrawExpireAmount,
    this.cancelUnfreezeV2Amount,
  });

  factory TronHttpTransactionInfoInt64StringCompatible.fromJson(
    Map<String, dynamic> json,
  ) {
    return TronHttpTransactionInfoInt64StringCompatible(
      id:
          (json['id'] is num
              ? json['id'].toString()
              : json.valueAsString('id')),
      fee: json.valueAsBigInt('fee'),
      blockNumber: json.valueAsBigInt('blockNumber'),
      blockTimeStamp: json.valueAsBigInt('blockTimeStamp'),
      contractResult: json.valueAsList<List<String>?>('contractResult'),
      contractAddress:
          (json['contract_address'] is num
              ? json['contract_address'].toString()
              : json.valueAsString('contract_address')),
      receipt: json.valueTo<
        TronHttpResourceReceiptInt64StringCompatible?,
        Map<String, dynamic>
      >(
        key: 'receipt',
        parse: (v) => TronHttpResourceReceiptInt64StringCompatible.fromJson(v),
      ),
      log:
          json.hasValue('log')
              ? json
                  .valueEnsureAsList<Map<String, dynamic>>('log')
                  .map((e) => TronHttpTransactionInfoLog.fromJson(e))
                  .toList()
              : null,
      result:
          json.hasValue('result')
              ? TronHttpTransactionResultRet.fromJson(json['result'])
              : null,
      resMessage:
          (json['resMessage'] is num
              ? json['resMessage'].toString()
              : json.valueAsString('resMessage')),
      assetIssueID:
          (json['assetIssueID'] is num
              ? json['assetIssueID'].toString()
              : json.valueAsString('assetIssueID')),
      withdrawAmount: json.valueAsBigInt('withdraw_amount'),
      unfreezeAmount: json.valueAsBigInt('unfreeze_amount'),
      internalTransactions:
          json.hasValue('internal_transactions')
              ? json
                  .valueEnsureAsList<Map<String, dynamic>>(
                    'internal_transactions',
                  )
                  .map(
                    (e) =>
                        TronHttpInternalTransactionInt64StringCompatible.fromJson(
                          e,
                        ),
                  )
                  .toList()
              : null,
      exchangeReceivedAmount: json.valueAsBigInt('exchange_received_amount'),
      exchangeInjectAnotherAmount: json.valueAsBigInt(
        'exchange_inject_another_amount',
      ),
      exchangeWithdrawAnotherAmount: json.valueAsBigInt(
        'exchange_withdraw_another_amount',
      ),
      exchangeId: json.valueAsBigInt('exchange_id'),
      shieldedTransactionFee: json.valueAsBigInt('shielded_transaction_fee'),
      orderId:
          (json['orderId'] is num
              ? json['orderId'].toString()
              : json.valueAsString('orderId')),
      orderDetails:
          json.hasValue('orderDetails')
              ? json
                  .valueEnsureAsList<Map<String, dynamic>>('orderDetails')
                  .map(
                    (e) =>
                        TronHttpMarketOrderDetailInt64StringCompatible.fromJson(
                          e,
                        ),
                  )
                  .toList()
              : null,
      packingFee: json.valueAsBigInt('packingFee'),
      withdrawExpireAmount: json.valueAsBigInt('withdraw_expire_amount'),
      cancelUnfreezeV2Amount:
          json.hasValue('cancel_unfreezeV2_amount')
              ? _tronMapFromJson<BigInt>(
                json['cancel_unfreezeV2_amount'],
                JsonParser.valueAsBigInt<BigInt>,
              )
              : null,
    );
  }

  Map<String, dynamic> toJson() => {
    'id': id,
    'fee': fee,
    'blockNumber': blockNumber,
    'blockTimeStamp': blockTimeStamp,
    'contractResult': contractResult,
    'contract_address': contractAddress,
    'receipt': receipt?.toJson(),
    'log': log?.map((e) => e.toJson()).toList(),
    'result': result?.toJson(),
    'resMessage': resMessage,
    'assetIssueID': assetIssueID,
    'withdraw_amount': withdrawAmount,
    'unfreeze_amount': unfreezeAmount,
    'internal_transactions':
        internalTransactions?.map((e) => e.toJson()).toList(),
    'exchange_received_amount': exchangeReceivedAmount,
    'exchange_inject_another_amount': exchangeInjectAnotherAmount,
    'exchange_withdraw_another_amount': exchangeWithdrawAnotherAmount,
    'exchange_id': exchangeId,
    'shielded_transaction_fee': shieldedTransactionFee,
    'orderId': orderId,
    'orderDetails': orderDetails?.map((e) => e.toJson()).toList(),
    'packingFee': packingFee,
    'withdraw_expire_amount': withdrawExpireAmount,
    'cancel_unfreezeV2_amount':
        cancelUnfreezeV2Amount == null
            ? null
            : _tronMapToJson(cancelUnfreezeV2Amount!),
  };
}

class TronHttpTransactionInfoLog {
  /// Account or contract address accepted by this endpoint.
  final String? address;

  /// Log topics filter.
  final List<String>? topics;

  /// Hex-encoded contract call data or transaction data.
  final String? data;

  const TronHttpTransactionInfoLog({this.address, this.topics, this.data});

  factory TronHttpTransactionInfoLog.fromJson(Map<String, dynamic> json) {
    return TronHttpTransactionInfoLog(
      address:
          (json['address'] is num
              ? json['address'].toString()
              : json.valueAsString('address')),
      topics: json.valueAsList<List<String>?>('topics'),
      data:
          (json['data'] is num
              ? json['data'].toString()
              : json.valueAsString('data')),
    );
  }

  Map<String, dynamic> toJson() => {
    'address': address,
    'topics': topics,
    'data': data,
  };
}

class TronHttpTransactionInt64StringCompatible {
  final String? txID;
  final TronHttpTransactionRawInt64StringCompatible? rawData;

  /// Hex-encoded transaction raw data.
  final String? rawDataHex;

  /// Transaction signatures.
  final List<String>? signature;

  /// Transaction result entries returned by java-tron when present.
  final List<TronHttpTransactionResultInt64StringCompatible>? ret;

  /// When true, addresses are encoded in base58check; when false or omitted, addresses are hex-encoded.
  final bool? visible;

  /// Smart contract address.
  final String? contractAddress;

  const TronHttpTransactionInt64StringCompatible({
    this.txID,
    this.rawData,
    this.rawDataHex,
    this.signature,
    this.ret,
    this.visible,
    this.contractAddress,
  });

  factory TronHttpTransactionInt64StringCompatible.fromJson(
    Map<String, dynamic> json,
  ) {
    return TronHttpTransactionInt64StringCompatible(
      txID:
          (json['txID'] is num
              ? json['txID'].toString()
              : json.valueAsString('txID')),
      rawData: json.valueTo<
        TronHttpTransactionRawInt64StringCompatible?,
        Map<String, dynamic>
      >(
        key: 'raw_data',
        parse: (v) => TronHttpTransactionRawInt64StringCompatible.fromJson(v),
      ),
      rawDataHex:
          (json['raw_data_hex'] is num
              ? json['raw_data_hex'].toString()
              : json.valueAsString('raw_data_hex')),
      signature: json.valueAsList<List<String>?>('signature'),
      ret:
          json.hasValue('ret')
              ? json
                  .valueEnsureAsList<Map<String, dynamic>>('ret')
                  .map(
                    (e) =>
                        TronHttpTransactionResultInt64StringCompatible.fromJson(
                          e,
                        ),
                  )
                  .toList()
              : null,
      visible: json.valueAsBool('visible'),
      contractAddress:
          (json['contract_address'] is num
              ? json['contract_address'].toString()
              : json.valueAsString('contract_address')),
    );
  }

  Map<String, dynamic> toJson() => {
    'txID': txID,
    'raw_data': rawData?.toJson(),
    'raw_data_hex': rawDataHex,
    'signature': signature,
    'ret': ret?.map((e) => e.toJson()).toList(),
    'visible': visible,
    'contract_address': contractAddress,
  };
}

/// Transaction raw data object.
class TronHttpTransactionRaw {
  final String? refBlockBytes;
  final BigInt? refBlockNum;
  final String? refBlockHash;
  final BigInt? expiration;
  final List<TronHttpAuthority>? auths;

  /// Hex-encoded contract call data or transaction data.
  final String? data;
  final List<TronHttpTransactionContract>? contract;
  final String? scripts;

  /// Timestamp in milliseconds.
  final BigInt? timestamp;

  /// Maximum fee in sun for smart contract execution.
  final BigInt? feeLimit;

  const TronHttpTransactionRaw({
    this.refBlockBytes,
    this.refBlockNum,
    this.refBlockHash,
    this.expiration,
    this.auths,
    this.data,
    this.contract,
    this.scripts,
    this.timestamp,
    this.feeLimit,
  });

  factory TronHttpTransactionRaw.fromJson(Map<String, dynamic> json) {
    return TronHttpTransactionRaw(
      refBlockBytes:
          (json['ref_block_bytes'] is num
              ? json['ref_block_bytes'].toString()
              : json.valueAsString('ref_block_bytes')),
      refBlockNum: json.valueAsBigInt('ref_block_num'),
      refBlockHash:
          (json['ref_block_hash'] is num
              ? json['ref_block_hash'].toString()
              : json.valueAsString('ref_block_hash')),
      expiration: json.valueAsBigInt('expiration'),
      auths:
          json.hasValue('auths')
              ? json
                  .valueEnsureAsList<Map<String, dynamic>>('auths')
                  .map((e) => TronHttpAuthority.fromJson(e))
                  .toList()
              : null,
      data:
          (json['data'] is num
              ? json['data'].toString()
              : json.valueAsString('data')),
      contract:
          json.hasValue('contract')
              ? json
                  .valueEnsureAsList<Map<String, dynamic>>('contract')
                  .map((e) => TronHttpTransactionContract.fromJson(e))
                  .toList()
              : null,
      scripts:
          (json['scripts'] is num
              ? json['scripts'].toString()
              : json.valueAsString('scripts')),
      timestamp: json.valueAsBigInt('timestamp'),
      feeLimit: json.valueAsBigInt('fee_limit'),
    );
  }

  Map<String, dynamic> toJson() => {
    'ref_block_bytes': refBlockBytes,
    'ref_block_num': refBlockNum,
    'ref_block_hash': refBlockHash,
    'expiration': expiration,
    'auths': auths?.map((e) => e.toJson()).toList(),
    'data': data,
    'contract': contract?.map((e) => e.toJson()).toList(),
    'scripts': scripts,
    'timestamp': timestamp,
    'fee_limit': feeLimit,
  };
}

/// Transaction raw data object.
class TronHttpTransactionRawInt64StringCompatible {
  final String? refBlockBytes;
  final BigInt? refBlockNum;
  final String? refBlockHash;
  final BigInt? expiration;
  final List<TronHttpAuthority>? auths;

  /// Hex-encoded contract call data or transaction data.
  final String? data;
  final List<TronHttpTransactionContractInt64StringCompatible>? contract;
  final String? scripts;

  /// Timestamp in milliseconds.
  final BigInt? timestamp;

  /// Maximum fee in sun for smart contract execution.
  final BigInt? feeLimit;

  const TronHttpTransactionRawInt64StringCompatible({
    this.refBlockBytes,
    this.refBlockNum,
    this.refBlockHash,
    this.expiration,
    this.auths,
    this.data,
    this.contract,
    this.scripts,
    this.timestamp,
    this.feeLimit,
  });

  factory TronHttpTransactionRawInt64StringCompatible.fromJson(
    Map<String, dynamic> json,
  ) {
    return TronHttpTransactionRawInt64StringCompatible(
      refBlockBytes:
          (json['ref_block_bytes'] is num
              ? json['ref_block_bytes'].toString()
              : json.valueAsString('ref_block_bytes')),
      refBlockNum: json.valueAsBigInt('ref_block_num'),
      refBlockHash:
          (json['ref_block_hash'] is num
              ? json['ref_block_hash'].toString()
              : json.valueAsString('ref_block_hash')),
      expiration: json.valueAsBigInt('expiration'),
      auths:
          json.hasValue('auths')
              ? json
                  .valueEnsureAsList<Map<String, dynamic>>('auths')
                  .map((e) => TronHttpAuthority.fromJson(e))
                  .toList()
              : null,
      data:
          (json['data'] is num
              ? json['data'].toString()
              : json.valueAsString('data')),
      contract:
          json.hasValue('contract')
              ? json
                  .valueEnsureAsList<Map<String, dynamic>>('contract')
                  .map(
                    (e) =>
                        TronHttpTransactionContractInt64StringCompatible.fromJson(
                          e,
                        ),
                  )
                  .toList()
              : null,
      scripts:
          (json['scripts'] is num
              ? json['scripts'].toString()
              : json.valueAsString('scripts')),
      timestamp: json.valueAsBigInt('timestamp'),
      feeLimit: json.valueAsBigInt('fee_limit'),
    );
  }

  Map<String, dynamic> toJson() => {
    'ref_block_bytes': refBlockBytes,
    'ref_block_num': refBlockNum,
    'ref_block_hash': refBlockHash,
    'expiration': expiration,
    'auths': auths?.map((e) => e.toJson()).toList(),
    'data': data,
    'contract': contract?.map((e) => e.toJson()).toList(),
    'scripts': scripts,
    'timestamp': timestamp,
    'fee_limit': feeLimit,
  };
}

class TronHttpTransactionRequest {
  final TronHttpTransactionRaw rawData;

  /// Compatibility field ignored by Util.packTransaction. It is not a protocol.Transaction protobuf field, is not checked against raw_data, and does not affect transaction ID or signature verification; those use the reserialized raw_data.
  final String? rawDataHex;

  /// Transaction signatures.
  final List<String>? signature;

  /// Transaction result entries returned by java-tron when present.
  final List<TronHttpTransactionResult>? ret;

  /// When true, addresses are encoded in base58check; when false or omitted, addresses are hex-encoded.
  final bool? visible;

  const TronHttpTransactionRequest({
    required this.rawData,
    this.rawDataHex,
    this.signature,
    this.ret,
    this.visible,
  });

  factory TronHttpTransactionRequest.fromJson(Map<String, dynamic> json) {
    return TronHttpTransactionRequest(
      rawData: json.valueTo<TronHttpTransactionRaw, Map<String, dynamic>>(
        key: 'raw_data',
        parse: (v) => TronHttpTransactionRaw.fromJson(v),
      ),
      rawDataHex:
          (json['raw_data_hex'] is num
              ? json['raw_data_hex'].toString()
              : json.valueAsString('raw_data_hex')),
      signature: json.valueAsList<List<String>?>('signature'),
      ret:
          json.hasValue('ret')
              ? json
                  .valueEnsureAsList<Map<String, dynamic>>('ret')
                  .map((e) => TronHttpTransactionResult.fromJson(e))
                  .toList()
              : null,
      visible: json.valueAsBool('visible'),
    );
  }

  Map<String, dynamic> toJson() => {
    'raw_data': rawData.toJson(),
    'raw_data_hex': rawDataHex,
    'signature': signature,
    'ret': ret?.map((e) => e.toJson()).toList(),
    'visible': visible,
  };
}

class TronHttpTransactionResult {
  final BigInt? fee;
  final TronHttpTransactionResultRet? ret;
  final TronHttpTransactionResultContractRet? contractRet;
  final String? assetIssueID;
  final BigInt? withdrawAmount;
  final BigInt? unfreezeAmount;
  final BigInt? exchangeReceivedAmount;
  final BigInt? exchangeInjectAnotherAmount;
  final BigInt? exchangeWithdrawAnotherAmount;
  final BigInt? exchangeId;
  final BigInt? shieldedTransactionFee;
  final String? orderId;
  final List<TronHttpMarketOrderDetail>? orderDetails;
  final BigInt? withdrawExpireAmount;
  final Map<String, BigInt>? cancelUnfreezeV2Amount;

  const TronHttpTransactionResult({
    this.fee,
    this.ret,
    this.contractRet,
    this.assetIssueID,
    this.withdrawAmount,
    this.unfreezeAmount,
    this.exchangeReceivedAmount,
    this.exchangeInjectAnotherAmount,
    this.exchangeWithdrawAnotherAmount,
    this.exchangeId,
    this.shieldedTransactionFee,
    this.orderId,
    this.orderDetails,
    this.withdrawExpireAmount,
    this.cancelUnfreezeV2Amount,
  });

  factory TronHttpTransactionResult.fromJson(Map<String, dynamic> json) {
    return TronHttpTransactionResult(
      fee: json.valueAsBigInt('fee'),
      ret:
          json.hasValue('ret')
              ? TronHttpTransactionResultRet.fromJson(json['ret'])
              : null,
      contractRet:
          json.hasValue('contractRet')
              ? TronHttpTransactionResultContractRet.fromJson(
                json['contractRet'],
              )
              : null,
      assetIssueID:
          (json['assetIssueID'] is num
              ? json['assetIssueID'].toString()
              : json.valueAsString('assetIssueID')),
      withdrawAmount: json.valueAsBigInt('withdraw_amount'),
      unfreezeAmount: json.valueAsBigInt('unfreeze_amount'),
      exchangeReceivedAmount: json.valueAsBigInt('exchange_received_amount'),
      exchangeInjectAnotherAmount: json.valueAsBigInt(
        'exchange_inject_another_amount',
      ),
      exchangeWithdrawAnotherAmount: json.valueAsBigInt(
        'exchange_withdraw_another_amount',
      ),
      exchangeId: json.valueAsBigInt('exchange_id'),
      shieldedTransactionFee: json.valueAsBigInt('shielded_transaction_fee'),
      orderId:
          (json['orderId'] is num
              ? json['orderId'].toString()
              : json.valueAsString('orderId')),
      orderDetails:
          json.hasValue('orderDetails')
              ? json
                  .valueEnsureAsList<Map<String, dynamic>>('orderDetails')
                  .map((e) => TronHttpMarketOrderDetail.fromJson(e))
                  .toList()
              : null,
      withdrawExpireAmount: json.valueAsBigInt('withdraw_expire_amount'),
      cancelUnfreezeV2Amount:
          json.hasValue('cancel_unfreezeV2_amount')
              ? _tronMapFromJson<BigInt>(
                json['cancel_unfreezeV2_amount'],
                JsonParser.valueAsBigInt<BigInt>,
              )
              : null,
    );
  }

  Map<String, dynamic> toJson() => {
    'fee': fee,
    'ret': ret?.toJson(),
    'contractRet': contractRet?.toJson(),
    'assetIssueID': assetIssueID,
    'withdraw_amount': withdrawAmount,
    'unfreeze_amount': unfreezeAmount,
    'exchange_received_amount': exchangeReceivedAmount,
    'exchange_inject_another_amount': exchangeInjectAnotherAmount,
    'exchange_withdraw_another_amount': exchangeWithdrawAnotherAmount,
    'exchange_id': exchangeId,
    'shielded_transaction_fee': shieldedTransactionFee,
    'orderId': orderId,
    'orderDetails': orderDetails?.map((e) => e.toJson()).toList(),
    'withdraw_expire_amount': withdrawExpireAmount,
    'cancel_unfreezeV2_amount':
        cancelUnfreezeV2Amount == null
            ? null
            : _tronMapToJson(cancelUnfreezeV2Amount!),
  };
}

class TronHttpTransactionResultInt64StringCompatible {
  final BigInt? fee;
  final TronHttpTransactionResultRet? ret;
  final TronHttpTransactionResultContractRet? contractRet;
  final String? assetIssueID;
  final BigInt? withdrawAmount;
  final BigInt? unfreezeAmount;
  final BigInt? exchangeReceivedAmount;
  final BigInt? exchangeInjectAnotherAmount;
  final BigInt? exchangeWithdrawAnotherAmount;
  final BigInt? exchangeId;
  final BigInt? shieldedTransactionFee;
  final String? orderId;
  final List<TronHttpMarketOrderDetailInt64StringCompatible>? orderDetails;
  final BigInt? withdrawExpireAmount;
  final Map<String, BigInt>? cancelUnfreezeV2Amount;

  const TronHttpTransactionResultInt64StringCompatible({
    this.fee,
    this.ret,
    this.contractRet,
    this.assetIssueID,
    this.withdrawAmount,
    this.unfreezeAmount,
    this.exchangeReceivedAmount,
    this.exchangeInjectAnotherAmount,
    this.exchangeWithdrawAnotherAmount,
    this.exchangeId,
    this.shieldedTransactionFee,
    this.orderId,
    this.orderDetails,
    this.withdrawExpireAmount,
    this.cancelUnfreezeV2Amount,
  });

  factory TronHttpTransactionResultInt64StringCompatible.fromJson(
    Map<String, dynamic> json,
  ) {
    return TronHttpTransactionResultInt64StringCompatible(
      fee: json.valueAsBigInt('fee'),
      ret:
          json.hasValue('ret')
              ? TronHttpTransactionResultRet.fromJson(json['ret'])
              : null,
      contractRet:
          json.hasValue('contractRet')
              ? TronHttpTransactionResultContractRet.fromJson(
                json['contractRet'],
              )
              : null,
      assetIssueID:
          (json['assetIssueID'] is num
              ? json['assetIssueID'].toString()
              : json.valueAsString('assetIssueID')),
      withdrawAmount: json.valueAsBigInt('withdraw_amount'),
      unfreezeAmount: json.valueAsBigInt('unfreeze_amount'),
      exchangeReceivedAmount: json.valueAsBigInt('exchange_received_amount'),
      exchangeInjectAnotherAmount: json.valueAsBigInt(
        'exchange_inject_another_amount',
      ),
      exchangeWithdrawAnotherAmount: json.valueAsBigInt(
        'exchange_withdraw_another_amount',
      ),
      exchangeId: json.valueAsBigInt('exchange_id'),
      shieldedTransactionFee: json.valueAsBigInt('shielded_transaction_fee'),
      orderId:
          (json['orderId'] is num
              ? json['orderId'].toString()
              : json.valueAsString('orderId')),
      orderDetails:
          json.hasValue('orderDetails')
              ? json
                  .valueEnsureAsList<Map<String, dynamic>>('orderDetails')
                  .map(
                    (e) =>
                        TronHttpMarketOrderDetailInt64StringCompatible.fromJson(
                          e,
                        ),
                  )
                  .toList()
              : null,
      withdrawExpireAmount: json.valueAsBigInt('withdraw_expire_amount'),
      cancelUnfreezeV2Amount:
          json.hasValue('cancel_unfreezeV2_amount')
              ? _tronMapFromJson<BigInt>(
                json['cancel_unfreezeV2_amount'],
                JsonParser.valueAsBigInt<BigInt>,
              )
              : null,
    );
  }

  Map<String, dynamic> toJson() => {
    'fee': fee,
    'ret': ret?.toJson(),
    'contractRet': contractRet?.toJson(),
    'assetIssueID': assetIssueID,
    'withdraw_amount': withdrawAmount,
    'unfreeze_amount': unfreezeAmount,
    'exchange_received_amount': exchangeReceivedAmount,
    'exchange_inject_another_amount': exchangeInjectAnotherAmount,
    'exchange_withdraw_another_amount': exchangeWithdrawAnotherAmount,
    'exchange_id': exchangeId,
    'shielded_transaction_fee': shieldedTransactionFee,
    'orderId': orderId,
    'orderDetails': orderDetails?.map((e) => e.toJson()).toList(),
    'withdraw_expire_amount': withdrawExpireAmount,
    'cancel_unfreezeV2_amount':
        cancelUnfreezeV2Amount == null
            ? null
            : _tronMapToJson(cancelUnfreezeV2Amount!),
  };
}

class TronHttpTransactionSignWeight {
  final TronHttpPermission? permission;
  final List<String>? approvedList;
  final BigInt? currentWeight;
  final TronHttpTransactionSignWeightResult? result;
  final TronHttpTransactionExtention? transaction;

  const TronHttpTransactionSignWeight({
    this.permission,
    this.approvedList,
    this.currentWeight,
    this.result,
    this.transaction,
  });

  factory TronHttpTransactionSignWeight.fromJson(Map<String, dynamic> json) {
    return TronHttpTransactionSignWeight(
      permission: json.valueTo<TronHttpPermission?, Map<String, dynamic>>(
        key: 'permission',
        parse: (v) => TronHttpPermission.fromJson(v),
      ),
      approvedList: json.valueAsList<List<String>?>('approved_list'),
      currentWeight: json.valueAsBigInt('current_weight'),
      result: json
          .valueTo<TronHttpTransactionSignWeightResult?, Map<String, dynamic>>(
            key: 'result',
            parse: (v) => TronHttpTransactionSignWeightResult.fromJson(v),
          ),
      transaction: json
          .valueTo<TronHttpTransactionExtention?, Map<String, dynamic>>(
            key: 'transaction',
            parse: (v) => TronHttpTransactionExtention.fromJson(v),
          ),
    );
  }

  Map<String, dynamic> toJson() => {
    'permission': permission?.toJson(),
    'approved_list': approvedList,
    'current_weight': currentWeight,
    'result': result?.toJson(),
    'transaction': transaction?.toJson(),
  };
}

class TronHttpTransactionSignWeightResult {
  final TronHttpTransactionSignWeightResultCode? code;
  final String? message;

  const TronHttpTransactionSignWeightResult({this.code, this.message});

  factory TronHttpTransactionSignWeightResult.fromJson(
    Map<String, dynamic> json,
  ) {
    return TronHttpTransactionSignWeightResult(
      code:
          json.hasValue('code')
              ? TronHttpTransactionSignWeightResultCode.fromJson(json['code'])
              : null,
      message:
          (json['message'] is num
              ? json['message'].toString()
              : json.valueAsString('message')),
    );
  }

  Map<String, dynamic> toJson() => {'code': code?.toJson(), 'message': message};
}

class TronHttpTransferAssetContract {
  /// Asset name or token identifier encoded as expected by java-tron.
  final String? assetName;

  /// Address of the account that owns or initiates the request.
  final String? ownerAddress;

  /// Destination account address.
  final String? toAddress;

  /// Amount in the transferred TRC-10 token's smallest unit.
  final BigInt? amount;

  const TronHttpTransferAssetContract({
    this.assetName,
    this.ownerAddress,
    this.toAddress,
    this.amount,
  });

  factory TronHttpTransferAssetContract.fromJson(Map<String, dynamic> json) {
    return TronHttpTransferAssetContract(
      assetName:
          (json['asset_name'] is num
              ? json['asset_name'].toString()
              : json.valueAsString('asset_name')),
      ownerAddress:
          (json['owner_address'] is num
              ? json['owner_address'].toString()
              : json.valueAsString('owner_address')),
      toAddress:
          (json['to_address'] is num
              ? json['to_address'].toString()
              : json.valueAsString('to_address')),
      amount: json.valueAsBigInt('amount'),
    );
  }

  Map<String, dynamic> toJson() => {
    'asset_name': assetName,
    'owner_address': ownerAddress,
    'to_address': toAddress,
    'amount': amount,
  };
}

class TronHttpTransferAssetContractInt64StringCompatible {
  /// Asset name or token identifier encoded as expected by java-tron.
  final String? assetName;

  /// Address of the account that owns or initiates the request.
  final String? ownerAddress;

  /// Destination account address.
  final String? toAddress;

  /// Amount in the transferred TRC-10 token's smallest unit.
  final BigInt? amount;

  const TronHttpTransferAssetContractInt64StringCompatible({
    this.assetName,
    this.ownerAddress,
    this.toAddress,
    this.amount,
  });

  factory TronHttpTransferAssetContractInt64StringCompatible.fromJson(
    Map<String, dynamic> json,
  ) {
    return TronHttpTransferAssetContractInt64StringCompatible(
      assetName:
          (json['asset_name'] is num
              ? json['asset_name'].toString()
              : json.valueAsString('asset_name')),
      ownerAddress:
          (json['owner_address'] is num
              ? json['owner_address'].toString()
              : json.valueAsString('owner_address')),
      toAddress:
          (json['to_address'] is num
              ? json['to_address'].toString()
              : json.valueAsString('to_address')),
      amount: json.valueAsBigInt('amount'),
    );
  }

  Map<String, dynamic> toJson() => {
    'asset_name': assetName,
    'owner_address': ownerAddress,
    'to_address': toAddress,
    'amount': amount,
  };
}

class TronHttpTransferAssetContractRequest {
  /// Asset name or token identifier encoded as expected by java-tron.
  final String assetName;

  /// Address of the account that owns or initiates the request.
  final String ownerAddress;

  /// Destination account address.
  final String toAddress;

  /// Amount in the transferred TRC-10 token's smallest unit.
  final BigInt amount;

  /// When true, addresses are encoded in base58check; when false or omitted, addresses are hex-encoded.
  final bool? visible;

  /// Permission id used to sign the transaction with a non-owner account permission.
  final int? permissionId;

  /// Extra transaction data encoded as expected by java-tron.
  final String? extraData;

  const TronHttpTransferAssetContractRequest({
    required this.assetName,
    required this.ownerAddress,
    required this.toAddress,
    required this.amount,
    this.visible,
    this.permissionId,
    this.extraData,
  });

  factory TronHttpTransferAssetContractRequest.fromJson(
    Map<String, dynamic> json,
  ) {
    return TronHttpTransferAssetContractRequest(
      assetName:
          (json['asset_name'] is num
              ? json['asset_name'].toString()
              : json.valueAsString('asset_name')),
      ownerAddress:
          (json['owner_address'] is num
              ? json['owner_address'].toString()
              : json.valueAsString('owner_address')),
      toAddress:
          (json['to_address'] is num
              ? json['to_address'].toString()
              : json.valueAsString('to_address')),
      amount: json.valueAsBigInt('amount'),
      visible: json.valueAsBool('visible'),
      permissionId: json.valueAsInt('Permission_id'),
      extraData:
          (json['extra_data'] is num
              ? json['extra_data'].toString()
              : json.valueAsString('extra_data')),
    );
  }

  Map<String, dynamic> toJson() => {
    'asset_name': assetName,
    'owner_address': ownerAddress,
    'to_address': toAddress,
    'amount': amount,
    'visible': visible,
    'Permission_id': permissionId,
    'extra_data': extraData,
  };
}

class TronHttpTransferContract {
  /// Address of the account that owns or initiates the request.
  final String? ownerAddress;

  /// Destination account address.
  final String? toAddress;

  /// Amount in sun, where 1 TRX equals 1,000,000 sun.
  final BigInt? amount;

  const TronHttpTransferContract({
    this.ownerAddress,
    this.toAddress,
    this.amount,
  });

  factory TronHttpTransferContract.fromJson(Map<String, dynamic> json) {
    return TronHttpTransferContract(
      ownerAddress:
          (json['owner_address'] is num
              ? json['owner_address'].toString()
              : json.valueAsString('owner_address')),
      toAddress:
          (json['to_address'] is num
              ? json['to_address'].toString()
              : json.valueAsString('to_address')),
      amount: json.valueAsBigInt('amount'),
    );
  }

  Map<String, dynamic> toJson() => {
    'owner_address': ownerAddress,
    'to_address': toAddress,
    'amount': amount,
  };
}

class TronHttpTransferContractInt64StringCompatible {
  /// Address of the account that owns or initiates the request.
  final String? ownerAddress;

  /// Destination account address.
  final String? toAddress;

  /// Amount in sun, where 1 TRX equals 1,000,000 sun.
  final BigInt? amount;

  const TronHttpTransferContractInt64StringCompatible({
    this.ownerAddress,
    this.toAddress,
    this.amount,
  });

  factory TronHttpTransferContractInt64StringCompatible.fromJson(
    Map<String, dynamic> json,
  ) {
    return TronHttpTransferContractInt64StringCompatible(
      ownerAddress:
          (json['owner_address'] is num
              ? json['owner_address'].toString()
              : json.valueAsString('owner_address')),
      toAddress:
          (json['to_address'] is num
              ? json['to_address'].toString()
              : json.valueAsString('to_address')),
      amount: json.valueAsBigInt('amount'),
    );
  }

  Map<String, dynamic> toJson() => {
    'owner_address': ownerAddress,
    'to_address': toAddress,
    'amount': amount,
  };
}

class TronHttpTransferContractRequest {
  /// Address of the account that owns or initiates the request.
  final String ownerAddress;

  /// Destination account address.
  final String toAddress;

  /// Amount in sun, where 1 TRX equals 1,000,000 sun.
  final BigInt amount;

  /// When true, addresses are encoded in base58check; when false or omitted, addresses are hex-encoded.
  final bool? visible;

  /// Permission id used to sign the transaction with a non-owner account permission.
  final int? permissionId;

  /// Extra transaction data encoded as expected by java-tron.
  final String? extraData;

  const TronHttpTransferContractRequest({
    required this.ownerAddress,
    required this.toAddress,
    required this.amount,
    this.visible,
    this.permissionId,
    this.extraData,
  });

  factory TronHttpTransferContractRequest.fromJson(Map<String, dynamic> json) {
    return TronHttpTransferContractRequest(
      ownerAddress:
          (json['owner_address'] is num
              ? json['owner_address'].toString()
              : json.valueAsString('owner_address')),
      toAddress:
          (json['to_address'] is num
              ? json['to_address'].toString()
              : json.valueAsString('to_address')),
      amount: json.valueAsBigInt('amount'),
      visible: json.valueAsBool('visible'),
      permissionId: json.valueAsInt('Permission_id'),
      extraData:
          (json['extra_data'] is num
              ? json['extra_data'].toString()
              : json.valueAsString('extra_data')),
    );
  }

  Map<String, dynamic> toJson() => {
    'owner_address': ownerAddress,
    'to_address': toAddress,
    'amount': amount,
    'visible': visible,
    'Permission_id': permissionId,
    'extra_data': extraData,
  };
}

class TronHttpTriggerSmartContract {
  /// Address of the account that owns or initiates the request.
  final String? ownerAddress;

  /// Smart contract address.
  final String? contractAddress;

  /// TRX amount in sun transferred with the smart contract call.
  final BigInt? callValue;

  /// Hex-encoded contract call data or transaction data.
  final String? data;

  /// TRC10 token amount transferred with the smart contract call.
  final BigInt? callTokenValue;

  /// TRC10 token id.
  final BigInt? tokenId;

  const TronHttpTriggerSmartContract({
    this.ownerAddress,
    this.contractAddress,
    this.callValue,
    this.data,
    this.callTokenValue,
    this.tokenId,
  });

  factory TronHttpTriggerSmartContract.fromJson(Map<String, dynamic> json) {
    return TronHttpTriggerSmartContract(
      ownerAddress:
          (json['owner_address'] is num
              ? json['owner_address'].toString()
              : json.valueAsString('owner_address')),
      contractAddress:
          (json['contract_address'] is num
              ? json['contract_address'].toString()
              : json.valueAsString('contract_address')),
      callValue: json.valueAsBigInt('call_value'),
      data:
          (json['data'] is num
              ? json['data'].toString()
              : json.valueAsString('data')),
      callTokenValue: json.valueAsBigInt('call_token_value'),
      tokenId: json.valueAsBigInt('token_id'),
    );
  }

  Map<String, dynamic> toJson() => {
    'owner_address': ownerAddress,
    'contract_address': contractAddress,
    'call_value': callValue,
    'data': data,
    'call_token_value': callTokenValue,
    'token_id': tokenId,
  };
}

class TronHttpTriggerSmartContractInt64StringCompatible {
  /// Address of the account that owns or initiates the request.
  final String? ownerAddress;

  /// Smart contract address.
  final String? contractAddress;

  /// TRX amount in sun transferred with the smart contract call.
  final BigInt? callValue;

  /// Hex-encoded contract call data or transaction data.
  final String? data;

  /// TRC10 token amount transferred with the smart contract call.
  final BigInt? callTokenValue;

  /// TRC10 token id.
  final BigInt? tokenId;

  const TronHttpTriggerSmartContractInt64StringCompatible({
    this.ownerAddress,
    this.contractAddress,
    this.callValue,
    this.data,
    this.callTokenValue,
    this.tokenId,
  });

  factory TronHttpTriggerSmartContractInt64StringCompatible.fromJson(
    Map<String, dynamic> json,
  ) {
    return TronHttpTriggerSmartContractInt64StringCompatible(
      ownerAddress:
          (json['owner_address'] is num
              ? json['owner_address'].toString()
              : json.valueAsString('owner_address')),
      contractAddress:
          (json['contract_address'] is num
              ? json['contract_address'].toString()
              : json.valueAsString('contract_address')),
      callValue: json.valueAsBigInt('call_value'),
      data:
          (json['data'] is num
              ? json['data'].toString()
              : json.valueAsString('data')),
      callTokenValue: json.valueAsBigInt('call_token_value'),
      tokenId: json.valueAsBigInt('token_id'),
    );
  }

  Map<String, dynamic> toJson() => {
    'owner_address': ownerAddress,
    'contract_address': contractAddress,
    'call_value': callValue,
    'data': data,
    'call_token_value': callTokenValue,
    'token_id': tokenId,
  };
}

class TronHttpTriggerSmartContractRequest {
  /// Address of the account that owns or initiates the request.
  final String ownerAddress;

  /// Smart contract address.
  final String contractAddress;

  /// TRX amount in sun transferred with the smart contract call.
  final BigInt? callValue;

  /// Hex-encoded contract call data or transaction data.
  final String? data;

  /// TRC10 token amount transferred with the smart contract call.
  final BigInt? callTokenValue;

  /// TRC10 token id.
  final BigInt? tokenId;

  /// Maximum fee in sun for smart contract execution.
  final BigInt? feeLimit;

  /// Smart contract function selector, for example transfer(address,uint256).
  final String? functionSelector;

  /// Contract parameter payload.
  final String? parameter;

  /// When true, addresses are encoded in base58check; when false or omitted, addresses are hex-encoded.
  final bool? visible;

  /// Permission id used to sign the transaction with a non-owner account permission.
  final int? permissionId;

  const TronHttpTriggerSmartContractRequest({
    required this.ownerAddress,
    required this.contractAddress,
    this.callValue,
    this.data,
    this.callTokenValue,
    this.tokenId,
    this.feeLimit,
    this.functionSelector,
    this.parameter,
    this.visible,
    this.permissionId,
  });

  factory TronHttpTriggerSmartContractRequest.fromJson(
    Map<String, dynamic> json,
  ) {
    return TronHttpTriggerSmartContractRequest(
      ownerAddress:
          (json['owner_address'] is num
              ? json['owner_address'].toString()
              : json.valueAsString('owner_address')),
      contractAddress:
          (json['contract_address'] is num
              ? json['contract_address'].toString()
              : json.valueAsString('contract_address')),
      callValue: json.valueAsBigInt('call_value'),
      data:
          (json['data'] is num
              ? json['data'].toString()
              : json.valueAsString('data')),
      callTokenValue: json.valueAsBigInt('call_token_value'),
      tokenId: json.valueAsBigInt('token_id'),
      feeLimit: json.valueAsBigInt('fee_limit'),
      functionSelector:
          (json['function_selector'] is num
              ? json['function_selector'].toString()
              : json.valueAsString('function_selector')),
      parameter:
          (json['parameter'] is num
              ? json['parameter'].toString()
              : json.valueAsString('parameter')),
      visible: json.valueAsBool('visible'),
      permissionId: json.valueAsInt('Permission_id'),
    );
  }

  Map<String, dynamic> toJson() => {
    'owner_address': ownerAddress,
    'contract_address': contractAddress,
    'call_value': callValue,
    'data': data,
    'call_token_value': callTokenValue,
    'token_id': tokenId,
    'fee_limit': feeLimit,
    'function_selector': functionSelector,
    'parameter': parameter,
    'visible': visible,
    'Permission_id': permissionId,
  };
}

class TronHttpUnDelegateResourceContract {
  /// Address of the account that owns or initiates the request.
  final String? ownerAddress;

  /// Resource type.
  final TronHttpAccountFreezeV2Type? resource;

  /// Resource amount in sun, where 1 TRX equals 1,000,000 sun.
  final BigInt? balance;

  /// Address of the account receiving resources or funds.
  final String? receiverAddress;

  const TronHttpUnDelegateResourceContract({
    this.ownerAddress,
    this.resource,
    this.balance,
    this.receiverAddress,
  });

  factory TronHttpUnDelegateResourceContract.fromJson(
    Map<String, dynamic> json,
  ) {
    return TronHttpUnDelegateResourceContract(
      ownerAddress:
          (json['owner_address'] is num
              ? json['owner_address'].toString()
              : json.valueAsString('owner_address')),
      resource:
          json.hasValue('resource')
              ? TronHttpAccountFreezeV2Type.fromJson(json['resource'])
              : null,
      balance: json.valueAsBigInt('balance'),
      receiverAddress:
          (json['receiver_address'] is num
              ? json['receiver_address'].toString()
              : json.valueAsString('receiver_address')),
    );
  }

  Map<String, dynamic> toJson() => {
    'owner_address': ownerAddress,
    'resource': resource?.toJson(),
    'balance': balance,
    'receiver_address': receiverAddress,
  };
}

class TronHttpUnDelegateResourceContractInt64StringCompatible {
  /// Address of the account that owns or initiates the request.
  final String? ownerAddress;

  /// Resource type.
  final TronHttpAccountFreezeV2Type? resource;

  /// Resource amount in sun, where 1 TRX equals 1,000,000 sun.
  final BigInt? balance;

  /// Address of the account receiving resources or funds.
  final String? receiverAddress;

  const TronHttpUnDelegateResourceContractInt64StringCompatible({
    this.ownerAddress,
    this.resource,
    this.balance,
    this.receiverAddress,
  });

  factory TronHttpUnDelegateResourceContractInt64StringCompatible.fromJson(
    Map<String, dynamic> json,
  ) {
    return TronHttpUnDelegateResourceContractInt64StringCompatible(
      ownerAddress:
          (json['owner_address'] is num
              ? json['owner_address'].toString()
              : json.valueAsString('owner_address')),
      resource:
          json.hasValue('resource')
              ? TronHttpAccountFreezeV2Type.fromJson(json['resource'])
              : null,
      balance: json.valueAsBigInt('balance'),
      receiverAddress:
          (json['receiver_address'] is num
              ? json['receiver_address'].toString()
              : json.valueAsString('receiver_address')),
    );
  }

  Map<String, dynamic> toJson() => {
    'owner_address': ownerAddress,
    'resource': resource?.toJson(),
    'balance': balance,
    'receiver_address': receiverAddress,
  };
}

class TronHttpUnDelegateResourceContractRequest {
  /// Address of the account that owns or initiates the request.
  final String ownerAddress;

  /// Resource type.
  final TronHttpDelegateResourceContractRequestResource? resource;

  /// Resource amount in sun, where 1 TRX equals 1,000,000 sun.
  final BigInt balance;

  /// Address of the account receiving resources or funds.
  final String receiverAddress;

  /// When true, addresses are encoded in base58check; when false or omitted, addresses are hex-encoded.
  final bool? visible;

  /// Permission id used to sign the transaction with a non-owner account permission.
  final int? permissionId;

  const TronHttpUnDelegateResourceContractRequest({
    required this.ownerAddress,
    this.resource,
    required this.balance,
    required this.receiverAddress,
    this.visible,
    this.permissionId,
  });

  factory TronHttpUnDelegateResourceContractRequest.fromJson(
    Map<String, dynamic> json,
  ) {
    return TronHttpUnDelegateResourceContractRequest(
      ownerAddress:
          (json['owner_address'] is num
              ? json['owner_address'].toString()
              : json.valueAsString('owner_address')),
      resource:
          json.hasValue('resource')
              ? TronHttpDelegateResourceContractRequestResource.fromJson(
                json['resource'],
              )
              : null,
      balance: json.valueAsBigInt('balance'),
      receiverAddress:
          (json['receiver_address'] is num
              ? json['receiver_address'].toString()
              : json.valueAsString('receiver_address')),
      visible: json.valueAsBool('visible'),
      permissionId: json.valueAsInt('Permission_id'),
    );
  }

  Map<String, dynamic> toJson() => {
    'owner_address': ownerAddress,
    'resource': resource?.toJson(),
    'balance': balance,
    'receiver_address': receiverAddress,
    'visible': visible,
    'Permission_id': permissionId,
  };
}

class TronHttpUnfreezeAssetContract {
  /// Address of the account that owns or initiates the request.
  final String? ownerAddress;

  const TronHttpUnfreezeAssetContract({this.ownerAddress});

  factory TronHttpUnfreezeAssetContract.fromJson(Map<String, dynamic> json) {
    return TronHttpUnfreezeAssetContract(
      ownerAddress:
          (json['owner_address'] is num
              ? json['owner_address'].toString()
              : json.valueAsString('owner_address')),
    );
  }

  Map<String, dynamic> toJson() => {'owner_address': ownerAddress};
}

class TronHttpUnfreezeAssetContractRequest {
  /// Address of the account that owns or initiates the request.
  final String ownerAddress;

  /// When true, addresses are encoded in base58check; when false or omitted, addresses are hex-encoded.
  final bool? visible;

  /// Permission id used to sign the transaction with a non-owner account permission.
  final int? permissionId;

  const TronHttpUnfreezeAssetContractRequest({
    required this.ownerAddress,
    this.visible,
    this.permissionId,
  });

  factory TronHttpUnfreezeAssetContractRequest.fromJson(
    Map<String, dynamic> json,
  ) {
    return TronHttpUnfreezeAssetContractRequest(
      ownerAddress:
          (json['owner_address'] is num
              ? json['owner_address'].toString()
              : json.valueAsString('owner_address')),
      visible: json.valueAsBool('visible'),
      permissionId: json.valueAsInt('Permission_id'),
    );
  }

  Map<String, dynamic> toJson() => {
    'owner_address': ownerAddress,
    'visible': visible,
    'Permission_id': permissionId,
  };
}

class TronHttpUnfreezeBalanceContract {
  /// Address of the account that owns or initiates the request.
  final String? ownerAddress;

  /// Resource type.
  final TronHttpAccountFreezeV2Type? resource;

  /// Address of the account receiving resources or funds.
  final String? receiverAddress;

  const TronHttpUnfreezeBalanceContract({
    this.ownerAddress,
    this.resource,
    this.receiverAddress,
  });

  factory TronHttpUnfreezeBalanceContract.fromJson(Map<String, dynamic> json) {
    return TronHttpUnfreezeBalanceContract(
      ownerAddress:
          (json['owner_address'] is num
              ? json['owner_address'].toString()
              : json.valueAsString('owner_address')),
      resource:
          json.hasValue('resource')
              ? TronHttpAccountFreezeV2Type.fromJson(json['resource'])
              : null,
      receiverAddress:
          (json['receiver_address'] is num
              ? json['receiver_address'].toString()
              : json.valueAsString('receiver_address')),
    );
  }

  Map<String, dynamic> toJson() => {
    'owner_address': ownerAddress,
    'resource': resource?.toJson(),
    'receiver_address': receiverAddress,
  };
}

class TronHttpUnfreezeBalanceContractRequest {
  /// Address of the account that owns or initiates the request.
  final String ownerAddress;

  /// Resource type to unfreeze. TRON_POWER is accepted only when the chain supports the new resource model (`supportAllowNewResourceModel()`).
  final TronHttpFreezeBalanceContractRequestResource? resource;

  /// Address of the account receiving resources or funds.
  final String? receiverAddress;

  /// When true, addresses are encoded in base58check; when false or omitted, addresses are hex-encoded.
  final bool? visible;

  /// Permission id used to sign the transaction with a non-owner account permission.
  final int? permissionId;

  const TronHttpUnfreezeBalanceContractRequest({
    required this.ownerAddress,
    this.resource,
    this.receiverAddress,
    this.visible,
    this.permissionId,
  });

  factory TronHttpUnfreezeBalanceContractRequest.fromJson(
    Map<String, dynamic> json,
  ) {
    return TronHttpUnfreezeBalanceContractRequest(
      ownerAddress:
          (json['owner_address'] is num
              ? json['owner_address'].toString()
              : json.valueAsString('owner_address')),
      resource:
          json.hasValue('resource')
              ? TronHttpFreezeBalanceContractRequestResource.fromJson(
                json['resource'],
              )
              : null,
      receiverAddress:
          (json['receiver_address'] is num
              ? json['receiver_address'].toString()
              : json.valueAsString('receiver_address')),
      visible: json.valueAsBool('visible'),
      permissionId: json.valueAsInt('Permission_id'),
    );
  }

  Map<String, dynamic> toJson() => {
    'owner_address': ownerAddress,
    'resource': resource?.toJson(),
    'receiver_address': receiverAddress,
    'visible': visible,
    'Permission_id': permissionId,
  };
}

class TronHttpUnfreezeBalanceV2Contract {
  /// Address of the account that owns or initiates the request.
  final String? ownerAddress;

  /// Amount to unfreeze in sun, where 1 TRX equals 1,000,000 sun.
  final BigInt? unfreezeBalance;

  /// Resource type.
  final TronHttpAccountFreezeV2Type? resource;

  const TronHttpUnfreezeBalanceV2Contract({
    this.ownerAddress,
    this.unfreezeBalance,
    this.resource,
  });

  factory TronHttpUnfreezeBalanceV2Contract.fromJson(
    Map<String, dynamic> json,
  ) {
    return TronHttpUnfreezeBalanceV2Contract(
      ownerAddress:
          (json['owner_address'] is num
              ? json['owner_address'].toString()
              : json.valueAsString('owner_address')),
      unfreezeBalance: json.valueAsBigInt('unfreeze_balance'),
      resource:
          json.hasValue('resource')
              ? TronHttpAccountFreezeV2Type.fromJson(json['resource'])
              : null,
    );
  }

  Map<String, dynamic> toJson() => {
    'owner_address': ownerAddress,
    'unfreeze_balance': unfreezeBalance,
    'resource': resource?.toJson(),
  };
}

class TronHttpUnfreezeBalanceV2ContractInt64StringCompatible {
  /// Address of the account that owns or initiates the request.
  final String? ownerAddress;

  /// Amount to unfreeze in sun, where 1 TRX equals 1,000,000 sun.
  final BigInt? unfreezeBalance;

  /// Resource type.
  final TronHttpAccountFreezeV2Type? resource;

  const TronHttpUnfreezeBalanceV2ContractInt64StringCompatible({
    this.ownerAddress,
    this.unfreezeBalance,
    this.resource,
  });

  factory TronHttpUnfreezeBalanceV2ContractInt64StringCompatible.fromJson(
    Map<String, dynamic> json,
  ) {
    return TronHttpUnfreezeBalanceV2ContractInt64StringCompatible(
      ownerAddress:
          (json['owner_address'] is num
              ? json['owner_address'].toString()
              : json.valueAsString('owner_address')),
      unfreezeBalance: json.valueAsBigInt('unfreeze_balance'),
      resource:
          json.hasValue('resource')
              ? TronHttpAccountFreezeV2Type.fromJson(json['resource'])
              : null,
    );
  }

  Map<String, dynamic> toJson() => {
    'owner_address': ownerAddress,
    'unfreeze_balance': unfreezeBalance,
    'resource': resource?.toJson(),
  };
}

class TronHttpUnfreezeBalanceV2ContractRequest {
  /// Address of the account that owns or initiates the request.
  final String ownerAddress;

  /// Amount to unfreeze in sun, where 1 TRX equals 1,000,000 sun.
  final BigInt unfreezeBalance;

  /// Resource type to unfreeze. TRON_POWER is accepted only when the chain supports the new resource model (`supportAllowNewResourceModel()`).
  final TronHttpFreezeBalanceContractRequestResource? resource;

  /// When true, addresses are encoded in base58check; when false or omitted, addresses are hex-encoded.
  final bool? visible;

  /// Permission id used to sign the transaction with a non-owner account permission.
  final int? permissionId;

  const TronHttpUnfreezeBalanceV2ContractRequest({
    required this.ownerAddress,
    required this.unfreezeBalance,
    this.resource,
    this.visible,
    this.permissionId,
  });

  factory TronHttpUnfreezeBalanceV2ContractRequest.fromJson(
    Map<String, dynamic> json,
  ) {
    return TronHttpUnfreezeBalanceV2ContractRequest(
      ownerAddress:
          (json['owner_address'] is num
              ? json['owner_address'].toString()
              : json.valueAsString('owner_address')),
      unfreezeBalance: json.valueAsBigInt('unfreeze_balance'),
      resource:
          json.hasValue('resource')
              ? TronHttpFreezeBalanceContractRequestResource.fromJson(
                json['resource'],
              )
              : null,
      visible: json.valueAsBool('visible'),
      permissionId: json.valueAsInt('Permission_id'),
    );
  }

  Map<String, dynamic> toJson() => {
    'owner_address': ownerAddress,
    'unfreeze_balance': unfreezeBalance,
    'resource': resource?.toJson(),
    'visible': visible,
    'Permission_id': permissionId,
  };
}

class TronHttpUpdateAssetContract {
  /// Address of the account that owns or initiates the request.
  final String? ownerAddress;

  /// Human-readable description for this object.
  final String? description;

  /// URL encoded as expected by java-tron.
  final String? url;

  /// New account resource limit.
  final BigInt? newLimit;

  /// New public resource limit.
  final BigInt? newPublicLimit;

  const TronHttpUpdateAssetContract({
    this.ownerAddress,
    this.description,
    this.url,
    this.newLimit,
    this.newPublicLimit,
  });

  factory TronHttpUpdateAssetContract.fromJson(Map<String, dynamic> json) {
    return TronHttpUpdateAssetContract(
      ownerAddress:
          (json['owner_address'] is num
              ? json['owner_address'].toString()
              : json.valueAsString('owner_address')),
      description:
          (json['description'] is num
              ? json['description'].toString()
              : json.valueAsString('description')),
      url:
          (json['url'] is num
              ? json['url'].toString()
              : json.valueAsString('url')),
      newLimit: json.valueAsBigInt('new_limit'),
      newPublicLimit: json.valueAsBigInt('new_public_limit'),
    );
  }

  Map<String, dynamic> toJson() => {
    'owner_address': ownerAddress,
    'description': description,
    'url': url,
    'new_limit': newLimit,
    'new_public_limit': newPublicLimit,
  };
}

class TronHttpUpdateAssetContractInt64StringCompatible {
  /// Address of the account that owns or initiates the request.
  final String? ownerAddress;

  /// Human-readable description for this object.
  final String? description;

  /// URL encoded as expected by java-tron.
  final String? url;

  /// New account resource limit.
  final BigInt? newLimit;

  /// New public resource limit.
  final BigInt? newPublicLimit;

  const TronHttpUpdateAssetContractInt64StringCompatible({
    this.ownerAddress,
    this.description,
    this.url,
    this.newLimit,
    this.newPublicLimit,
  });

  factory TronHttpUpdateAssetContractInt64StringCompatible.fromJson(
    Map<String, dynamic> json,
  ) {
    return TronHttpUpdateAssetContractInt64StringCompatible(
      ownerAddress:
          (json['owner_address'] is num
              ? json['owner_address'].toString()
              : json.valueAsString('owner_address')),
      description:
          (json['description'] is num
              ? json['description'].toString()
              : json.valueAsString('description')),
      url:
          (json['url'] is num
              ? json['url'].toString()
              : json.valueAsString('url')),
      newLimit: json.valueAsBigInt('new_limit'),
      newPublicLimit: json.valueAsBigInt('new_public_limit'),
    );
  }

  Map<String, dynamic> toJson() => {
    'owner_address': ownerAddress,
    'description': description,
    'url': url,
    'new_limit': newLimit,
    'new_public_limit': newPublicLimit,
  };
}

class TronHttpUpdateAssetContractRequest {
  /// Address of the account that owns or initiates the request.
  final String ownerAddress;

  /// Human-readable description for this object.
  final String? description;

  /// URL encoded as expected by java-tron.
  final String url;

  /// New account resource limit.
  final BigInt? newLimit;

  /// New public resource limit.
  final BigInt? newPublicLimit;

  /// When true, addresses are encoded in base58check; when false or omitted, addresses are hex-encoded.
  final bool? visible;

  /// Permission id used to sign the transaction with a non-owner account permission.
  final int? permissionId;

  const TronHttpUpdateAssetContractRequest({
    required this.ownerAddress,
    this.description,
    required this.url,
    this.newLimit,
    this.newPublicLimit,
    this.visible,
    this.permissionId,
  });

  factory TronHttpUpdateAssetContractRequest.fromJson(
    Map<String, dynamic> json,
  ) {
    return TronHttpUpdateAssetContractRequest(
      ownerAddress:
          (json['owner_address'] is num
              ? json['owner_address'].toString()
              : json.valueAsString('owner_address')),
      description:
          (json['description'] is num
              ? json['description'].toString()
              : json.valueAsString('description')),
      url:
          (json['url'] is num
              ? json['url'].toString()
              : json.valueAsString('url')),
      newLimit: json.valueAsBigInt('new_limit'),
      newPublicLimit: json.valueAsBigInt('new_public_limit'),
      visible: json.valueAsBool('visible'),
      permissionId: json.valueAsInt('Permission_id'),
    );
  }

  Map<String, dynamic> toJson() => {
    'owner_address': ownerAddress,
    'description': description,
    'url': url,
    'new_limit': newLimit,
    'new_public_limit': newPublicLimit,
    'visible': visible,
    'Permission_id': permissionId,
  };
}

class TronHttpUpdateBrokerageContract {
  /// Address of the account that owns or initiates the request.
  final String? ownerAddress;

  /// Witness brokerage percentage, from 0 to 100.
  final int? brokerage;

  const TronHttpUpdateBrokerageContract({this.ownerAddress, this.brokerage});

  factory TronHttpUpdateBrokerageContract.fromJson(Map<String, dynamic> json) {
    return TronHttpUpdateBrokerageContract(
      ownerAddress:
          (json['owner_address'] is num
              ? json['owner_address'].toString()
              : json.valueAsString('owner_address')),
      brokerage: json.valueAsInt('brokerage'),
    );
  }

  Map<String, dynamic> toJson() => {
    'owner_address': ownerAddress,
    'brokerage': brokerage,
  };
}

class TronHttpUpdateBrokerageContractRequest {
  /// Address of the account that owns or initiates the request.
  final String ownerAddress;

  /// Witness brokerage percentage, from 0 to 100.
  final int? brokerage;

  /// When true, addresses are encoded in base58check; when false or omitted, addresses are hex-encoded.
  final bool? visible;

  /// Permission id used to sign the transaction with a non-owner account permission.
  final int? permissionId;

  const TronHttpUpdateBrokerageContractRequest({
    required this.ownerAddress,
    this.brokerage,
    this.visible,
    this.permissionId,
  });

  factory TronHttpUpdateBrokerageContractRequest.fromJson(
    Map<String, dynamic> json,
  ) {
    return TronHttpUpdateBrokerageContractRequest(
      ownerAddress:
          (json['owner_address'] is num
              ? json['owner_address'].toString()
              : json.valueAsString('owner_address')),
      brokerage: json.valueAsInt('brokerage'),
      visible: json.valueAsBool('visible'),
      permissionId: json.valueAsInt('Permission_id'),
    );
  }

  Map<String, dynamic> toJson() => {
    'owner_address': ownerAddress,
    'brokerage': brokerage,
    'visible': visible,
    'Permission_id': permissionId,
  };
}

class TronHttpUpdateEnergyLimitContract {
  /// Address of the account that owns or initiates the request.
  final String? ownerAddress;

  /// Smart contract address.
  final String? contractAddress;

  /// Origin energy limit for a deployed smart contract.
  final BigInt? originEnergyLimit;

  const TronHttpUpdateEnergyLimitContract({
    this.ownerAddress,
    this.contractAddress,
    this.originEnergyLimit,
  });

  factory TronHttpUpdateEnergyLimitContract.fromJson(
    Map<String, dynamic> json,
  ) {
    return TronHttpUpdateEnergyLimitContract(
      ownerAddress:
          (json['owner_address'] is num
              ? json['owner_address'].toString()
              : json.valueAsString('owner_address')),
      contractAddress:
          (json['contract_address'] is num
              ? json['contract_address'].toString()
              : json.valueAsString('contract_address')),
      originEnergyLimit: json.valueAsBigInt('origin_energy_limit'),
    );
  }

  Map<String, dynamic> toJson() => {
    'owner_address': ownerAddress,
    'contract_address': contractAddress,
    'origin_energy_limit': originEnergyLimit,
  };
}

class TronHttpUpdateEnergyLimitContractInt64StringCompatible {
  /// Address of the account that owns or initiates the request.
  final String? ownerAddress;

  /// Smart contract address.
  final String? contractAddress;

  /// Origin energy limit for a deployed smart contract.
  final BigInt? originEnergyLimit;

  const TronHttpUpdateEnergyLimitContractInt64StringCompatible({
    this.ownerAddress,
    this.contractAddress,
    this.originEnergyLimit,
  });

  factory TronHttpUpdateEnergyLimitContractInt64StringCompatible.fromJson(
    Map<String, dynamic> json,
  ) {
    return TronHttpUpdateEnergyLimitContractInt64StringCompatible(
      ownerAddress:
          (json['owner_address'] is num
              ? json['owner_address'].toString()
              : json.valueAsString('owner_address')),
      contractAddress:
          (json['contract_address'] is num
              ? json['contract_address'].toString()
              : json.valueAsString('contract_address')),
      originEnergyLimit: json.valueAsBigInt('origin_energy_limit'),
    );
  }

  Map<String, dynamic> toJson() => {
    'owner_address': ownerAddress,
    'contract_address': contractAddress,
    'origin_energy_limit': originEnergyLimit,
  };
}

class TronHttpUpdateEnergyLimitContractRequest {
  /// Address of the account that owns or initiates the request.
  final String ownerAddress;

  /// Smart contract address.
  final String contractAddress;

  /// Origin energy limit for a deployed smart contract.
  final BigInt originEnergyLimit;

  /// When true, addresses are encoded in base58check; when false or omitted, addresses are hex-encoded.
  final bool? visible;

  /// Permission id used to sign the transaction with a non-owner account permission.
  final int? permissionId;

  const TronHttpUpdateEnergyLimitContractRequest({
    required this.ownerAddress,
    required this.contractAddress,
    required this.originEnergyLimit,
    this.visible,
    this.permissionId,
  });

  factory TronHttpUpdateEnergyLimitContractRequest.fromJson(
    Map<String, dynamic> json,
  ) {
    return TronHttpUpdateEnergyLimitContractRequest(
      ownerAddress:
          (json['owner_address'] is num
              ? json['owner_address'].toString()
              : json.valueAsString('owner_address')),
      contractAddress:
          (json['contract_address'] is num
              ? json['contract_address'].toString()
              : json.valueAsString('contract_address')),
      originEnergyLimit: json.valueAsBigInt('origin_energy_limit'),
      visible: json.valueAsBool('visible'),
      permissionId: json.valueAsInt('Permission_id'),
    );
  }

  Map<String, dynamic> toJson() => {
    'owner_address': ownerAddress,
    'contract_address': contractAddress,
    'origin_energy_limit': originEnergyLimit,
    'visible': visible,
    'Permission_id': permissionId,
  };
}

class TronHttpUpdateSettingContract {
  /// Address of the account that owns or initiates the request.
  final String? ownerAddress;

  /// Smart contract address.
  final String? contractAddress;

  /// Percentage of contract execution resource cost paid by the user.
  final BigInt? consumeUserResourcePercent;

  const TronHttpUpdateSettingContract({
    this.ownerAddress,
    this.contractAddress,
    this.consumeUserResourcePercent,
  });

  factory TronHttpUpdateSettingContract.fromJson(Map<String, dynamic> json) {
    return TronHttpUpdateSettingContract(
      ownerAddress:
          (json['owner_address'] is num
              ? json['owner_address'].toString()
              : json.valueAsString('owner_address')),
      contractAddress:
          (json['contract_address'] is num
              ? json['contract_address'].toString()
              : json.valueAsString('contract_address')),
      consumeUserResourcePercent: json.valueAsBigInt(
        'consume_user_resource_percent',
      ),
    );
  }

  Map<String, dynamic> toJson() => {
    'owner_address': ownerAddress,
    'contract_address': contractAddress,
    'consume_user_resource_percent': consumeUserResourcePercent,
  };
}

class TronHttpUpdateSettingContractInt64StringCompatible {
  /// Address of the account that owns or initiates the request.
  final String? ownerAddress;

  /// Smart contract address.
  final String? contractAddress;

  /// Percentage of contract execution resource cost paid by the user.
  final BigInt? consumeUserResourcePercent;

  const TronHttpUpdateSettingContractInt64StringCompatible({
    this.ownerAddress,
    this.contractAddress,
    this.consumeUserResourcePercent,
  });

  factory TronHttpUpdateSettingContractInt64StringCompatible.fromJson(
    Map<String, dynamic> json,
  ) {
    return TronHttpUpdateSettingContractInt64StringCompatible(
      ownerAddress:
          (json['owner_address'] is num
              ? json['owner_address'].toString()
              : json.valueAsString('owner_address')),
      contractAddress:
          (json['contract_address'] is num
              ? json['contract_address'].toString()
              : json.valueAsString('contract_address')),
      consumeUserResourcePercent: json.valueAsBigInt(
        'consume_user_resource_percent',
      ),
    );
  }

  Map<String, dynamic> toJson() => {
    'owner_address': ownerAddress,
    'contract_address': contractAddress,
    'consume_user_resource_percent': consumeUserResourcePercent,
  };
}

class TronHttpUpdateSettingContractRequest {
  /// Address of the account that owns or initiates the request.
  final String ownerAddress;

  /// Smart contract address.
  final String contractAddress;

  /// Percentage of contract execution resource cost paid by the user.
  final BigInt? consumeUserResourcePercent;

  /// When true, addresses are encoded in base58check; when false or omitted, addresses are hex-encoded.
  final bool? visible;

  /// Permission id used to sign the transaction with a non-owner account permission.
  final int? permissionId;

  const TronHttpUpdateSettingContractRequest({
    required this.ownerAddress,
    required this.contractAddress,
    this.consumeUserResourcePercent,
    this.visible,
    this.permissionId,
  });

  factory TronHttpUpdateSettingContractRequest.fromJson(
    Map<String, dynamic> json,
  ) {
    return TronHttpUpdateSettingContractRequest(
      ownerAddress:
          (json['owner_address'] is num
              ? json['owner_address'].toString()
              : json.valueAsString('owner_address')),
      contractAddress:
          (json['contract_address'] is num
              ? json['contract_address'].toString()
              : json.valueAsString('contract_address')),
      consumeUserResourcePercent: json.valueAsBigInt(
        'consume_user_resource_percent',
      ),
      visible: json.valueAsBool('visible'),
      permissionId: json.valueAsInt('Permission_id'),
    );
  }

  Map<String, dynamic> toJson() => {
    'owner_address': ownerAddress,
    'contract_address': contractAddress,
    'consume_user_resource_percent': consumeUserResourcePercent,
    'visible': visible,
    'Permission_id': permissionId,
  };
}

class TronHttpVote {
  final String? voteAddress;
  final BigInt? voteCount;

  const TronHttpVote({this.voteAddress, this.voteCount});

  factory TronHttpVote.fromJson(Map<String, dynamic> json) {
    return TronHttpVote(
      voteAddress:
          (json['vote_address'] is num
              ? json['vote_address'].toString()
              : json.valueAsString('vote_address')),
      voteCount: json.valueAsBigInt('vote_count'),
    );
  }

  Map<String, dynamic> toJson() => {
    'vote_address': voteAddress,
    'vote_count': voteCount,
  };
}

class TronHttpVoteInt64StringCompatible {
  final String? voteAddress;
  final BigInt? voteCount;

  const TronHttpVoteInt64StringCompatible({this.voteAddress, this.voteCount});

  factory TronHttpVoteInt64StringCompatible.fromJson(
    Map<String, dynamic> json,
  ) {
    return TronHttpVoteInt64StringCompatible(
      voteAddress:
          (json['vote_address'] is num
              ? json['vote_address'].toString()
              : json.valueAsString('vote_address')),
      voteCount: json.valueAsBigInt('vote_count'),
    );
  }

  Map<String, dynamic> toJson() => {
    'vote_address': voteAddress,
    'vote_count': voteCount,
  };
}

class TronHttpVoteWitnessContract {
  /// Address of the account that owns or initiates the request.
  final String? ownerAddress;

  /// Witness vote entries.
  final List<TronHttpVoteWitnessContractVote>? votes;

  /// Proposal support flag.
  final bool? support;

  const TronHttpVoteWitnessContract({
    this.ownerAddress,
    this.votes,
    this.support,
  });

  factory TronHttpVoteWitnessContract.fromJson(Map<String, dynamic> json) {
    return TronHttpVoteWitnessContract(
      ownerAddress:
          (json['owner_address'] is num
              ? json['owner_address'].toString()
              : json.valueAsString('owner_address')),
      votes:
          json.hasValue('votes')
              ? json
                  .valueEnsureAsList<Map<String, dynamic>>('votes')
                  .map((e) => TronHttpVoteWitnessContractVote.fromJson(e))
                  .toList()
              : null,
      support: json.valueAsBool('support'),
    );
  }

  Map<String, dynamic> toJson() => {
    'owner_address': ownerAddress,
    'votes': votes?.map((e) => e.toJson()).toList(),
    'support': support,
  };
}

class TronHttpVoteWitnessContractInt64StringCompatible {
  /// Address of the account that owns or initiates the request.
  final String? ownerAddress;

  /// Witness vote entries.
  final List<TronHttpVoteWitnessContractVoteInt64StringCompatible>? votes;

  /// Proposal support flag.
  final bool? support;

  const TronHttpVoteWitnessContractInt64StringCompatible({
    this.ownerAddress,
    this.votes,
    this.support,
  });

  factory TronHttpVoteWitnessContractInt64StringCompatible.fromJson(
    Map<String, dynamic> json,
  ) {
    return TronHttpVoteWitnessContractInt64StringCompatible(
      ownerAddress:
          (json['owner_address'] is num
              ? json['owner_address'].toString()
              : json.valueAsString('owner_address')),
      votes:
          json.hasValue('votes')
              ? json
                  .valueEnsureAsList<Map<String, dynamic>>('votes')
                  .map(
                    (e) =>
                        TronHttpVoteWitnessContractVoteInt64StringCompatible.fromJson(
                          e,
                        ),
                  )
                  .toList()
              : null,
      support: json.valueAsBool('support'),
    );
  }

  Map<String, dynamic> toJson() => {
    'owner_address': ownerAddress,
    'votes': votes?.map((e) => e.toJson()).toList(),
    'support': support,
  };
}

class TronHttpVoteWitnessContractRequest {
  /// Address of the account that owns or initiates the request.
  final String ownerAddress;

  /// Witness vote entries.
  final List<TronHttpVoteWitnessContractVoteRequest> votes;

  /// Proposal support flag.
  final bool? support;

  /// When true, addresses are encoded in base58check; when false or omitted, addresses are hex-encoded.
  final bool? visible;

  /// Permission id used to sign the transaction with a non-owner account permission.
  final int? permissionId;

  const TronHttpVoteWitnessContractRequest({
    required this.ownerAddress,
    required this.votes,
    this.support,
    this.visible,
    this.permissionId,
  });

  factory TronHttpVoteWitnessContractRequest.fromJson(
    Map<String, dynamic> json,
  ) {
    return TronHttpVoteWitnessContractRequest(
      ownerAddress:
          (json['owner_address'] is num
              ? json['owner_address'].toString()
              : json.valueAsString('owner_address')),
      votes:
          json
              .valueEnsureAsList<Map<String, dynamic>>('votes')
              .map((e) => TronHttpVoteWitnessContractVoteRequest.fromJson(e))
              .toList(),
      support: json.valueAsBool('support'),
      visible: json.valueAsBool('visible'),
      permissionId: json.valueAsInt('Permission_id'),
    );
  }

  Map<String, dynamic> toJson() => {
    'owner_address': ownerAddress,
    'votes': votes.map((e) => e.toJson()).toList(),
    'support': support,
    'visible': visible,
    'Permission_id': permissionId,
  };
}

class TronHttpVoteWitnessContractVote {
  final String? voteAddress;
  final BigInt? voteCount;

  const TronHttpVoteWitnessContractVote({this.voteAddress, this.voteCount});

  factory TronHttpVoteWitnessContractVote.fromJson(Map<String, dynamic> json) {
    return TronHttpVoteWitnessContractVote(
      voteAddress:
          (json['vote_address'] is num
              ? json['vote_address'].toString()
              : json.valueAsString('vote_address')),
      voteCount: json.valueAsBigInt('vote_count'),
    );
  }

  Map<String, dynamic> toJson() => {
    'vote_address': voteAddress,
    'vote_count': voteCount,
  };
}

class TronHttpVoteWitnessContractVoteInt64StringCompatible {
  final String? voteAddress;
  final BigInt? voteCount;

  const TronHttpVoteWitnessContractVoteInt64StringCompatible({
    this.voteAddress,
    this.voteCount,
  });

  factory TronHttpVoteWitnessContractVoteInt64StringCompatible.fromJson(
    Map<String, dynamic> json,
  ) {
    return TronHttpVoteWitnessContractVoteInt64StringCompatible(
      voteAddress:
          (json['vote_address'] is num
              ? json['vote_address'].toString()
              : json.valueAsString('vote_address')),
      voteCount: json.valueAsBigInt('vote_count'),
    );
  }

  Map<String, dynamic> toJson() => {
    'vote_address': voteAddress,
    'vote_count': voteCount,
  };
}

class TronHttpVoteWitnessContractVoteRequest {
  final String voteAddress;
  final BigInt voteCount;

  const TronHttpVoteWitnessContractVoteRequest({
    required this.voteAddress,
    required this.voteCount,
  });

  factory TronHttpVoteWitnessContractVoteRequest.fromJson(
    Map<String, dynamic> json,
  ) {
    return TronHttpVoteWitnessContractVoteRequest(
      voteAddress:
          (json['vote_address'] is num
              ? json['vote_address'].toString()
              : json.valueAsString('vote_address')),
      voteCount: json.valueAsBigInt('vote_count'),
    );
  }

  Map<String, dynamic> toJson() => {
    'vote_address': voteAddress,
    'vote_count': voteCount,
  };
}

class TronHttpWithdrawBalanceContract {
  /// Address of the account that owns or initiates the request.
  final String? ownerAddress;

  const TronHttpWithdrawBalanceContract({this.ownerAddress});

  factory TronHttpWithdrawBalanceContract.fromJson(Map<String, dynamic> json) {
    return TronHttpWithdrawBalanceContract(
      ownerAddress:
          (json['owner_address'] is num
              ? json['owner_address'].toString()
              : json.valueAsString('owner_address')),
    );
  }

  Map<String, dynamic> toJson() => {'owner_address': ownerAddress};
}

class TronHttpWithdrawBalanceContractRequest {
  /// Address of the account that owns or initiates the request.
  final String ownerAddress;

  /// When true, addresses are encoded in base58check; when false or omitted, addresses are hex-encoded.
  final bool? visible;

  /// Permission id used to sign the transaction with a non-owner account permission.
  final int? permissionId;

  const TronHttpWithdrawBalanceContractRequest({
    required this.ownerAddress,
    this.visible,
    this.permissionId,
  });

  factory TronHttpWithdrawBalanceContractRequest.fromJson(
    Map<String, dynamic> json,
  ) {
    return TronHttpWithdrawBalanceContractRequest(
      ownerAddress:
          (json['owner_address'] is num
              ? json['owner_address'].toString()
              : json.valueAsString('owner_address')),
      visible: json.valueAsBool('visible'),
      permissionId: json.valueAsInt('Permission_id'),
    );
  }

  Map<String, dynamic> toJson() => {
    'owner_address': ownerAddress,
    'visible': visible,
    'Permission_id': permissionId,
  };
}

class TronHttpWithdrawExpireUnfreezeContract {
  /// Address of the account that owns or initiates the request.
  final String? ownerAddress;

  const TronHttpWithdrawExpireUnfreezeContract({this.ownerAddress});

  factory TronHttpWithdrawExpireUnfreezeContract.fromJson(
    Map<String, dynamic> json,
  ) {
    return TronHttpWithdrawExpireUnfreezeContract(
      ownerAddress:
          (json['owner_address'] is num
              ? json['owner_address'].toString()
              : json.valueAsString('owner_address')),
    );
  }

  Map<String, dynamic> toJson() => {'owner_address': ownerAddress};
}

class TronHttpWithdrawExpireUnfreezeContractRequest {
  /// Address of the account that owns or initiates the request.
  final String ownerAddress;

  /// When true, addresses are encoded in base58check; when false or omitted, addresses are hex-encoded.
  final bool? visible;

  /// Permission id used to sign the transaction with a non-owner account permission.
  final int? permissionId;

  const TronHttpWithdrawExpireUnfreezeContractRequest({
    required this.ownerAddress,
    this.visible,
    this.permissionId,
  });

  factory TronHttpWithdrawExpireUnfreezeContractRequest.fromJson(
    Map<String, dynamic> json,
  ) {
    return TronHttpWithdrawExpireUnfreezeContractRequest(
      ownerAddress:
          (json['owner_address'] is num
              ? json['owner_address'].toString()
              : json.valueAsString('owner_address')),
      visible: json.valueAsBool('visible'),
      permissionId: json.valueAsInt('Permission_id'),
    );
  }

  Map<String, dynamic> toJson() => {
    'owner_address': ownerAddress,
    'visible': visible,
    'Permission_id': permissionId,
  };
}

class TronHttpWitness {
  /// Account or contract address accepted by this endpoint.
  final String? address;
  final BigInt? voteCount;
  final String? pubKey;

  /// URL encoded as expected by java-tron.
  final String? url;
  final BigInt? totalProduced;
  final BigInt? totalMissed;
  final BigInt? latestBlockNum;
  final BigInt? latestSlotNum;
  final bool? isJobs;

  const TronHttpWitness({
    this.address,
    this.voteCount,
    this.pubKey,
    this.url,
    this.totalProduced,
    this.totalMissed,
    this.latestBlockNum,
    this.latestSlotNum,
    this.isJobs,
  });

  factory TronHttpWitness.fromJson(Map<String, dynamic> json) {
    return TronHttpWitness(
      address:
          (json['address'] is num
              ? json['address'].toString()
              : json.valueAsString('address')),
      voteCount: json.valueAsBigInt('voteCount'),
      pubKey:
          (json['pubKey'] is num
              ? json['pubKey'].toString()
              : json.valueAsString('pubKey')),
      url:
          (json['url'] is num
              ? json['url'].toString()
              : json.valueAsString('url')),
      totalProduced: json.valueAsBigInt('totalProduced'),
      totalMissed: json.valueAsBigInt('totalMissed'),
      latestBlockNum: json.valueAsBigInt('latestBlockNum'),
      latestSlotNum: json.valueAsBigInt('latestSlotNum'),
      isJobs: json.valueAsBool('isJobs'),
    );
  }

  Map<String, dynamic> toJson() => {
    'address': address,
    'voteCount': voteCount,
    'pubKey': pubKey,
    'url': url,
    'totalProduced': totalProduced,
    'totalMissed': totalMissed,
    'latestBlockNum': latestBlockNum,
    'latestSlotNum': latestSlotNum,
    'isJobs': isJobs,
  };
}

class TronHttpWitnessCreateContract {
  /// Address of the account that owns or initiates the request.
  final String? ownerAddress;

  /// URL encoded as expected by java-tron.
  final String? url;

  const TronHttpWitnessCreateContract({this.ownerAddress, this.url});

  factory TronHttpWitnessCreateContract.fromJson(Map<String, dynamic> json) {
    return TronHttpWitnessCreateContract(
      ownerAddress:
          (json['owner_address'] is num
              ? json['owner_address'].toString()
              : json.valueAsString('owner_address')),
      url:
          (json['url'] is num
              ? json['url'].toString()
              : json.valueAsString('url')),
    );
  }

  Map<String, dynamic> toJson() => {'owner_address': ownerAddress, 'url': url};
}

class TronHttpWitnessCreateContractRequest {
  /// Address of the account that owns or initiates the request.
  final String ownerAddress;

  /// URL encoded as expected by java-tron.
  final String url;

  /// When true, addresses are encoded in base58check; when false or omitted, addresses are hex-encoded.
  final bool? visible;

  /// Permission id used to sign the transaction with a non-owner account permission.
  final int? permissionId;

  const TronHttpWitnessCreateContractRequest({
    required this.ownerAddress,
    required this.url,
    this.visible,
    this.permissionId,
  });

  factory TronHttpWitnessCreateContractRequest.fromJson(
    Map<String, dynamic> json,
  ) {
    return TronHttpWitnessCreateContractRequest(
      ownerAddress:
          (json['owner_address'] is num
              ? json['owner_address'].toString()
              : json.valueAsString('owner_address')),
      url:
          (json['url'] is num
              ? json['url'].toString()
              : json.valueAsString('url')),
      visible: json.valueAsBool('visible'),
      permissionId: json.valueAsInt('Permission_id'),
    );
  }

  Map<String, dynamic> toJson() => {
    'owner_address': ownerAddress,
    'url': url,
    'visible': visible,
    'Permission_id': permissionId,
  };
}

class TronHttpWitnessInt64StringCompatible {
  /// Account or contract address accepted by this endpoint.
  final String? address;
  final BigInt? voteCount;
  final String? pubKey;

  /// URL encoded as expected by java-tron.
  final String? url;
  final BigInt? totalProduced;
  final BigInt? totalMissed;
  final BigInt? latestBlockNum;
  final BigInt? latestSlotNum;
  final bool? isJobs;

  const TronHttpWitnessInt64StringCompatible({
    this.address,
    this.voteCount,
    this.pubKey,
    this.url,
    this.totalProduced,
    this.totalMissed,
    this.latestBlockNum,
    this.latestSlotNum,
    this.isJobs,
  });

  factory TronHttpWitnessInt64StringCompatible.fromJson(
    Map<String, dynamic> json,
  ) {
    return TronHttpWitnessInt64StringCompatible(
      address:
          (json['address'] is num
              ? json['address'].toString()
              : json.valueAsString('address')),
      voteCount: json.valueAsBigInt('voteCount'),
      pubKey:
          (json['pubKey'] is num
              ? json['pubKey'].toString()
              : json.valueAsString('pubKey')),
      url:
          (json['url'] is num
              ? json['url'].toString()
              : json.valueAsString('url')),
      totalProduced: json.valueAsBigInt('totalProduced'),
      totalMissed: json.valueAsBigInt('totalMissed'),
      latestBlockNum: json.valueAsBigInt('latestBlockNum'),
      latestSlotNum: json.valueAsBigInt('latestSlotNum'),
      isJobs: json.valueAsBool('isJobs'),
    );
  }

  Map<String, dynamic> toJson() => {
    'address': address,
    'voteCount': voteCount,
    'pubKey': pubKey,
    'url': url,
    'totalProduced': totalProduced,
    'totalMissed': totalMissed,
    'latestBlockNum': latestBlockNum,
    'latestSlotNum': latestSlotNum,
    'isJobs': isJobs,
  };
}

class TronHttpWitnessList {
  final List<TronHttpWitness>? witnesses;

  const TronHttpWitnessList({this.witnesses});

  factory TronHttpWitnessList.fromJson(Map<String, dynamic> json) {
    return TronHttpWitnessList(
      witnesses:
          json.hasValue('witnesses')
              ? json
                  .valueEnsureAsList<Map<String, dynamic>>('witnesses')
                  .map((e) => TronHttpWitness.fromJson(e))
                  .toList()
              : null,
    );
  }

  Map<String, dynamic> toJson() => {
    'witnesses': witnesses?.map((e) => e.toJson()).toList(),
  };
}

class TronHttpWitnessListInt64StringCompatible {
  final List<TronHttpWitnessInt64StringCompatible>? witnesses;

  const TronHttpWitnessListInt64StringCompatible({this.witnesses});

  factory TronHttpWitnessListInt64StringCompatible.fromJson(
    Map<String, dynamic> json,
  ) {
    return TronHttpWitnessListInt64StringCompatible(
      witnesses:
          json.hasValue('witnesses')
              ? json
                  .valueEnsureAsList<Map<String, dynamic>>('witnesses')
                  .map((e) => TronHttpWitnessInt64StringCompatible.fromJson(e))
                  .toList()
              : null,
    );
  }

  Map<String, dynamic> toJson() => {
    'witnesses': witnesses?.map((e) => e.toJson()).toList(),
  };
}

class TronHttpWitnessUpdateContract {
  /// Address of the account that owns or initiates the request.
  final String? ownerAddress;

  /// Updated URL encoded as expected by java-tron.
  final String? updateUrl;

  const TronHttpWitnessUpdateContract({this.ownerAddress, this.updateUrl});

  factory TronHttpWitnessUpdateContract.fromJson(Map<String, dynamic> json) {
    return TronHttpWitnessUpdateContract(
      ownerAddress:
          (json['owner_address'] is num
              ? json['owner_address'].toString()
              : json.valueAsString('owner_address')),
      updateUrl:
          (json['update_url'] is num
              ? json['update_url'].toString()
              : json.valueAsString('update_url')),
    );
  }

  Map<String, dynamic> toJson() => {
    'owner_address': ownerAddress,
    'update_url': updateUrl,
  };
}

class TronHttpWitnessUpdateContractRequest {
  /// Address of the account that owns or initiates the request.
  final String ownerAddress;

  /// Updated URL encoded as expected by java-tron.
  final String updateUrl;

  /// When true, addresses are encoded in base58check; when false or omitted, addresses are hex-encoded.
  final bool? visible;

  /// Permission id used to sign the transaction with a non-owner account permission.
  final int? permissionId;

  const TronHttpWitnessUpdateContractRequest({
    required this.ownerAddress,
    required this.updateUrl,
    this.visible,
    this.permissionId,
  });

  factory TronHttpWitnessUpdateContractRequest.fromJson(
    Map<String, dynamic> json,
  ) {
    return TronHttpWitnessUpdateContractRequest(
      ownerAddress:
          (json['owner_address'] is num
              ? json['owner_address'].toString()
              : json.valueAsString('owner_address')),
      updateUrl:
          (json['update_url'] is num
              ? json['update_url'].toString()
              : json.valueAsString('update_url')),
      visible: json.valueAsBool('visible'),
      permissionId: json.valueAsInt('Permission_id'),
    );
  }

  Map<String, dynamic> toJson() => {
    'owner_address': ownerAddress,
    'update_url': updateUrl,
    'visible': visible,
    'Permission_id': permissionId,
  };
}

class TronHttpProposalCreateContractRequestParametersItem {
  final BigInt key;
  final BigInt value;

  const TronHttpProposalCreateContractRequestParametersItem({
    required this.key,
    required this.value,
  });

  factory TronHttpProposalCreateContractRequestParametersItem.fromJson(
    Map<String, dynamic> json,
  ) {
    return TronHttpProposalCreateContractRequestParametersItem(
      key: json.valueAsBigInt('key'),
      value: json.valueAsBigInt('value'),
    );
  }

  Map<String, dynamic> toJson() => {'key': key, 'value': value};
}

class TronHttpResponseWalletEstimateenergyPostEstimateenergyPostResultObject1Result {
  final bool? result;
  final String? code;
  final String? message;

  const TronHttpResponseWalletEstimateenergyPostEstimateenergyPostResultObject1Result({
    this.result,
    this.code,
    this.message,
  });

  factory TronHttpResponseWalletEstimateenergyPostEstimateenergyPostResultObject1Result.fromJson(
    Map<String, dynamic> json,
  ) {
    return TronHttpResponseWalletEstimateenergyPostEstimateenergyPostResultObject1Result(
      result: json.valueAsBool('result'),
      code:
          (json['code'] is num
              ? json['code'].toString()
              : json.valueAsString('code')),
      message:
          (json['message'] is num
              ? json['message'].toString()
              : json.valueAsString('message')),
    );
  }

  Map<String, dynamic> toJson() => {
    'result': result,
    'code': code,
    'message': message,
  };
}

/// Contract parameter payload.
class TronHttpTransactionContractInt64StringCompatibleParameter {
  final String typeUrl;

  /// Hex string, amount, or value field accepted by this endpoint.
  final TronHttpTransactionContractInt64StringCompatibleParameterValue value;

  const TronHttpTransactionContractInt64StringCompatibleParameter({
    required this.typeUrl,
    required this.value,
  });

  factory TronHttpTransactionContractInt64StringCompatibleParameter.fromJson(
    Map<String, dynamic> json,
  ) {
    final String typeUrl =
        (json['type_url'] is num
            ? json['type_url'].toString()
            : json.valueAsString('type_url'));
    return TronHttpTransactionContractInt64StringCompatibleParameter(
      typeUrl: typeUrl,
      value:
          TronHttpTransactionContractInt64StringCompatibleParameterValue.fromJsonWithTypeUrl(
            json['value'],
            typeUrl,
          ),
    );
  }

  Map<String, dynamic> toJson() => {
    'type_url': typeUrl,
    'value': value.toJson(),
  };
}

/// Contract parameter payload.
class TronHttpTransactionContractParameter {
  final String typeUrl;

  /// Hex string, amount, or value field accepted by this endpoint.
  final TronHttpTransactionContractParameterValue value;

  const TronHttpTransactionContractParameter({
    required this.typeUrl,
    required this.value,
  });

  factory TronHttpTransactionContractParameter.fromJson(
    Map<String, dynamic> json,
  ) {
    final String typeUrl =
        (json['type_url'] is num
            ? json['type_url'].toString()
            : json.valueAsString('type_url'));
    return TronHttpTransactionContractParameter(
      typeUrl: typeUrl,
      value: TronHttpTransactionContractParameterValue.fromJsonWithTypeUrl(
        json['value'],
        typeUrl,
      ),
    );
  }

  Map<String, dynamic> toJson() => {
    'type_url': typeUrl,
    'value': value.toJson(),
  };
}

class TronHttpWalletBroadcasthexPostBody {
  /// Hex-encoded serialized `protocol.Transaction`. Each signature embedded in the decoded protobuf transaction must be 65–68 bytes; otherwise broadcast returns `SIGERROR`.
  final String transaction;

  const TronHttpWalletBroadcasthexPostBody({required this.transaction});

  factory TronHttpWalletBroadcasthexPostBody.fromJson(
    Map<String, dynamic> json,
  ) {
    return TronHttpWalletBroadcasthexPostBody(
      transaction:
          (json['transaction'] is num
              ? json['transaction'].toString()
              : json.valueAsString('transaction')),
    );
  }

  Map<String, dynamic> toJson() => {'transaction': transaction};
}

class TronHttpWalletBroadcasttransactionPostBody {
  final TronHttpTransactionRaw rawData;

  /// Compatibility field ignored by Util.packTransaction. It is not a protocol.Transaction protobuf field, is not checked against raw_data, and does not affect transaction ID or signature verification; those use the reserialized raw_data.
  final String? rawDataHex;

  /// Transaction signatures supplied for broadcast.
  final List<String>? signature;

  /// Transaction result entries returned by java-tron when present.
  final List<TronHttpTransactionResult>? ret;

  /// When true, addresses are encoded in base58check; when false or omitted, addresses are hex-encoded.
  final bool? visible;

  const TronHttpWalletBroadcasttransactionPostBody({
    required this.rawData,
    this.rawDataHex,
    this.signature,
    this.ret,
    this.visible,
  });

  factory TronHttpWalletBroadcasttransactionPostBody.fromJson(
    Map<String, dynamic> json,
  ) {
    return TronHttpWalletBroadcasttransactionPostBody(
      rawData: json.valueTo<TronHttpTransactionRaw, Map<String, dynamic>>(
        key: 'raw_data',
        parse: (v) => TronHttpTransactionRaw.fromJson(v),
      ),
      rawDataHex:
          (json['raw_data_hex'] is num
              ? json['raw_data_hex'].toString()
              : json.valueAsString('raw_data_hex')),
      signature: json.valueAsList<List<String>?>('signature'),
      ret:
          json.hasValue('ret')
              ? json
                  .valueEnsureAsList<Map<String, dynamic>>('ret')
                  .map((e) => TronHttpTransactionResult.fromJson(e))
                  .toList()
              : null,
      visible: json.valueAsBool('visible'),
    );
  }

  Map<String, dynamic> toJson() => {
    'raw_data': rawData.toJson(),
    'raw_data_hex': rawDataHex,
    'signature': signature,
    'ret': ret?.map((e) => e.toJson()).toList(),
    'visible': visible,
  };
}

class TronHttpWalletGetBrokeragePostBody {
  /// Account or contract address accepted by this endpoint.
  final String? address;

  const TronHttpWalletGetBrokeragePostBody({this.address});

  factory TronHttpWalletGetBrokeragePostBody.fromJson(
    Map<String, dynamic> json,
  ) {
    return TronHttpWalletGetBrokeragePostBody(
      address:
          (json['address'] is num
              ? json['address'].toString()
              : json.valueAsString('address')),
    );
  }

  Map<String, dynamic> toJson() => {'address': address};
}

class TronHttpWalletGetaccountresourcePostBody {
  /// Account or contract address accepted by this endpoint.
  final String? address;

  /// When true, addresses are encoded in base58check; when false or omitted, addresses are hex-encoded.
  final bool? visible;

  const TronHttpWalletGetaccountresourcePostBody({this.address, this.visible});

  factory TronHttpWalletGetaccountresourcePostBody.fromJson(
    Map<String, dynamic> json,
  ) {
    return TronHttpWalletGetaccountresourcePostBody(
      address:
          (json['address'] is num
              ? json['address'].toString()
              : json.valueAsString('address')),
      visible: json.valueAsBool('visible'),
    );
  }

  Map<String, dynamic> toJson() => {'address': address, 'visible': visible};
}

class TronHttpWalletGetassetissuebyidPostBody {
  /// Hex string, amount, or value field accepted by this endpoint.
  final String? value;

  /// When true, addresses are encoded in base58check; when false or omitted, addresses are hex-encoded.
  final bool? visible;

  const TronHttpWalletGetassetissuebyidPostBody({this.value, this.visible});

  factory TronHttpWalletGetassetissuebyidPostBody.fromJson(
    Map<String, dynamic> json,
  ) {
    return TronHttpWalletGetassetissuebyidPostBody(
      value:
          (json['value'] is num
              ? json['value'].toString()
              : json.valueAsString('value')),
      visible: json.valueAsBool('visible'),
    );
  }

  Map<String, dynamic> toJson() => {'value': value, 'visible': visible};
}

class TronHttpWalletGetproposalbyidPostBody {
  /// Proposal id.
  final BigInt id;

  /// When true, addresses are encoded in base58check; when false or omitted, addresses are hex-encoded.
  final bool? visible;

  const TronHttpWalletGetproposalbyidPostBody({required this.id, this.visible});

  factory TronHttpWalletGetproposalbyidPostBody.fromJson(
    Map<String, dynamic> json,
  ) {
    return TronHttpWalletGetproposalbyidPostBody(
      id: json.valueAsBigInt('id'),
      visible: json.valueAsBool('visible'),
    );
  }

  Map<String, dynamic> toJson() => {'id': id, 'visible': visible};
}

class TronHttpWalletGettransactionlistfrompendingPostBody {
  /// POST reads this field from the JSON request body. Transaction IDs remain hex strings regardless of its value.
  final bool? visible;

  const TronHttpWalletGettransactionlistfrompendingPostBody({this.visible});

  factory TronHttpWalletGettransactionlistfrompendingPostBody.fromJson(
    Map<String, dynamic> json,
  ) {
    return TronHttpWalletGettransactionlistfrompendingPostBody(
      visible: json.valueAsBool('visible'),
    );
  }

  Map<String, dynamic> toJson() => {'visible': visible};
}

class TronHttpWalletValidateaddressPostBody {
  /// Account or contract address accepted by this endpoint.
  final String? address;

  const TronHttpWalletValidateaddressPostBody({this.address});

  factory TronHttpWalletValidateaddressPostBody.fromJson(
    Map<String, dynamic> json,
  ) {
    return TronHttpWalletValidateaddressPostBody(
      address:
          (json['address'] is num
              ? json['address'].toString()
              : json.valueAsString('address')),
    );
  }

  Map<String, dynamic> toJson() => {'address': address};
}
