import 'package:blockchain_utils/blockchain_utils.dart';
import 'package:on_chain/algorand/src/abi/src/types.dart';
import 'method.dart';

/// Network-specific app ID for a contract.
class ABIContractNetworkInfo {
  final BigInt appID;

  const ABIContractNetworkInfo({required this.appID});

  factory ABIContractNetworkInfo.fromJson(Map<String, dynamic> json) =>
      ABIContractNetworkInfo(appID: json.valueAsBigInt("appID"));

  Map<String, dynamic> toJson() => {'appID': appID.toString()};
}

/// Full contract definition (ARC-4).
class ABIContractParams {
  final String name;
  final String? desc;
  final Map<String, ABIContractNetworkInfo>? networks;
  final List<ABIMethodParams> methods;
  final List<ARC28Event>? events;

  const ABIContractParams({
    required this.name,
    this.desc,
    this.networks,
    required this.methods,
    this.events,
  });

  factory ABIContractParams.fromJson(Map<String, dynamic> json) {
    final networks = json
        .valueAsMap<Map<String, dynamic>?>("networks")
        ?.map(
          (k, v) => MapEntry(
            k,
            ABIContractNetworkInfo.fromJson(JsonParser.valueEnsureAsMap(v)),
          ),
        );
    final methods =
        json
            .valueEnsureAsList<Map<String, dynamic>>("methods")
            .map(ABIMethodParams.fromJson)
            .toList();
    final events =
        json
            .valueAsList<List<Map<String, dynamic>>?>("events")
            ?.map(ARC28Event.fromJson)
            .toList();
    return ABIContractParams(
      name: json.valueAsString("name"),
      desc: json.valueAsString("desc"),
      networks: networks,
      methods: methods,
      events: events,
    );
  }

  Map<String, dynamic> toJson() =>
      {
        'name': name,
        'desc': desc,
        'networks': networks?.map((k, v) => MapEntry(k, v.toJson())),
        'methods': methods.map((m) => m.toJson()).toList(),
        'events': events?.map((e) => e.toJson()).toList(),
      }.notNullValue;
}

/// Resolved Algorand ABI contract.
class ABIContract {
  final String name;
  final String? description;
  final Map<String, ABIContractNetworkInfo> networks;
  final List<ABIMethod> methods;
  final List<ARC28Event>? events;

  ABIContract(ABIContractParams params)
    : name = params.name,
      description = params.desc,
      networks = Map.unmodifiable(params.networks ?? {}),
      methods = params.methods.map((m) => ABIMethod(m)).toList(),
      events = params.events;

  factory ABIContract.fromJson(Map<String, dynamic> json) =>
      ABIContract(ABIContractParams.fromJson(json));

  Map<String, dynamic> toJson() =>
      {
        'name': name,
        'desc': description,
        'networks': networks.map((k, v) => MapEntry(k, v.toJson())),
        'methods': methods.map((m) => m.toJson()).toList(),
        'events': events?.map((e) => e.toJson()).toList(),
      }.notNullValue;

  /// Looks up a method by name. Throws if zero or multiple matches.
  ABIMethod methodByName(String name) =>
      ABIMethodUtils.getMethodByName(methods, name);
}
