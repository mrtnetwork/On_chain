import 'package:blockchain_utils/blockchain_utils.dart';

import 'method.dart';

abstract class ABIArgumentType {
  String getName();
}

/// Algorand ABI transaction types used as method arguments.
enum ABITransactionType implements ABIArgumentType {
  /// Any transaction type.
  any('txn'),

  /// Payment transaction type.
  pay('pay'),

  /// Key registration transaction type.
  keyreg('keyreg'),

  /// Asset configuration transaction type.
  acfg('acfg'),

  /// Asset transfer transaction type.
  axfer('axfer'),

  /// Asset freeze transaction type.
  afrz('afrz'),

  /// Application transaction type.
  appl('appl');

  final String value;
  const ABITransactionType(this.value);

  @override
  String getName() => value;

  static ABITransactionType? tryFrom(String s) {
    return values.firstWhereNullable((e) => e.value == s);
  }
}

/// Utility helpers for ABI types, moved from top-level functions
/// (no behavior change).
abstract final class ABITypeUtils {
  /// [txnType] is typically the `type` field of a transaction object
  /// (e.g. `"pay"`, `"axfer"`). Pass `null` if the type is unknown.
  static bool abiCheckTransactionType(
    ABITransactionType expected,
    String? txnType,
  ) {
    if (expected == ABITransactionType.any) return true;
    return txnType != null && txnType == expected.value;
  }
}

/// Algorand ABI reference types used as method arguments.
enum ABIReferenceType implements ABIArgumentType {
  /// Account reference type.
  account('account'),

  /// Application reference type.
  application('application'),

  /// Asset reference type.
  asset('asset');

  final String value;
  const ABIReferenceType(this.value);

  @override
  String getName() => value;

  static ABIReferenceType? tryFrom(String s) {
    return values.firstWhereNullable((e) => e.value == s);
  }
}

/// ARC-28 event description.
///
/// See https://arc.algorand.foundation/ARCs/arc-0028
class ARC28Event {
  /// The name of the event.
  final String name;

  /// Optional user-friendly description.
  final String? desc;

  /// The arguments of the event, in order.
  final List<ARC28EventArg> args;

  const ARC28Event({required this.name, this.desc, required this.args});

  factory ARC28Event.fromJson(Map<String, dynamic> json) {
    final argsList =
        (json['args'] as List? ?? [])
            .map(
              (e) =>
                  ARC28EventArg.fromJson(Map<String, dynamic>.from(e as Map)),
            )
            .toList();
    return ARC28Event(
      name: json['name'] as String,
      desc: json['desc'] as String?,
      args: argsList,
    );
  }

  Map<String, dynamic> toJson() => {
    'name': name,
    if (desc != null) 'desc': desc,
    'args': args.map((a) => a.toJson()).toList(),
  };
}

/// A single argument of an ARC-28 event.
class ARC28EventArg {
  /// The type of the argument (ABI type string).
  final String type;

  /// Optional user-friendly name.
  final String? name;

  /// Optional user-friendly description.
  final String? desc;

  const ARC28EventArg({required this.type, this.name, this.desc});

  factory ARC28EventArg.fromJson(Map<String, dynamic> json) => ARC28EventArg(
    type: json['type'] as String,
    name: json['name'] as String?,
    desc: json['desc'] as String?,
  );

  Map<String, dynamic> toJson() => {
    'type': type,
    if (name != null) 'name': name,
    if (desc != null) 'desc': desc,
  };
}

/// Interface definition parameters.
class ABIInterfaceParams {
  final String name;
  final String? desc;
  final List<ABIMethodParams> methods;

  const ABIInterfaceParams({
    required this.name,
    this.desc,
    required this.methods,
  });

  factory ABIInterfaceParams.fromJson(Map<String, dynamic> json) {
    final methods =
        json
            .valueEnsureAsList<Map<String, dynamic>>("methods")
            .map(ABIMethodParams.fromJson)
            .toList();
    return ABIInterfaceParams(
      name: json.valueAsString("name"),
      desc: json.valueAsString("desc"),
      methods: methods,
    );
  }

  Map<String, dynamic> toJson() =>
      {
        'name': name,
        'desc': desc,
        'methods': methods.map((m) => m.toJson()).toList(),
      }.notNullValue;
}

/// Resolved Algorand ABI interface.
class ABIInterface {
  final String name;
  final String? description;
  final List<ABIMethod> methods;

  ABIInterface(ABIInterfaceParams params)
    : name = params.name,
      description = params.desc,
      methods = params.methods.map((m) => ABIMethod(m)).toList();

  factory ABIInterface.fromJson(Map<String, dynamic> json) =>
      ABIInterface(ABIInterfaceParams.fromJson(json));

  Map<String, dynamic> toJson() =>
      {
        'name': name,
        'desc': description,
        'methods': methods.map((m) => m.toJson()).toList(),
      }.notNullValue;

  /// Looks up a method by name. Throws if zero or multiple matches.
  ABIMethod methodByName(String name) =>
      ABIMethodUtils.getMethodByName(methods, name);
}
