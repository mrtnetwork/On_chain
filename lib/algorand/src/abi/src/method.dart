import 'package:blockchain_utils/blockchain_utils.dart';

import 'package:on_chain/algorand/src/abi/src/types.dart';
import 'package:on_chain/exception/onchain_error.dart';
import 'abi_type.dart';

/// Return type: either an [ABIType] or the string `'void'`.
// typedef ABIReturnType = Object; // ABIType | 'void'

/// Parameter description for a method argument.
class ABIMethodArgParams {
  final String type;
  final String? name;
  final String? desc;

  const ABIMethodArgParams({required this.type, this.name, this.desc});

  factory ABIMethodArgParams.fromJson(Map<String, dynamic> json) {
    return ABIMethodArgParams(
      type: json['type'] as String,
      name: json['name'] as String?,
      desc: json['desc'] as String?,
    );
  }

  Map<String, dynamic> toJson() => {
    'type': type,
    if (name != null) 'name': name,
    if (desc != null) 'desc': desc,
  };
}

/// Parameter description for a method return value.
class ABIMethodReturnParams {
  final String type;
  final String? desc;

  const ABIMethodReturnParams({required this.type, this.desc});

  factory ABIMethodReturnParams.fromJson(Map<String, dynamic> json) {
    return ABIMethodReturnParams(
      type: json['type'] as String,
      desc: json['desc'] as String?,
    );
  }

  Map<String, dynamic> toJson() => {
    'type': type,
    if (desc != null) 'desc': desc,
  };
}

/// Full method definition as it appears in a contract JSON.
class ABIMethodParams {
  final String name;
  final String? desc;
  final List<ABIMethodArgParams> args;
  final ABIMethodReturnParams returns;

  /// Optional read-only flag (ARC-22).
  final bool? readonly;

  /// Optional ARC-28 events that may be emitted.
  final List<ARC28Event>? events;

  const ABIMethodParams({
    required this.name,
    this.desc,
    required this.args,
    required this.returns,
    this.readonly,
    this.events,
  });

  factory ABIMethodParams.fromJson(Map<String, dynamic> json) {
    final args =
        (json['args'] as List? ?? [])
            .map(
              (e) => ABIMethodArgParams.fromJson(
                Map<String, dynamic>.from(e as Map),
              ),
            )
            .toList();

    final returnsJson = Map<String, dynamic>.from(json['returns'] as Map);

    final events =
        (json['events'] as List?)
            ?.map(
              (e) => ARC28Event.fromJson(Map<String, dynamic>.from(e as Map)),
            )
            .toList();

    return ABIMethodParams(
      name: json['name'] as String,
      desc: json['desc'] as String?,
      args: args,
      returns: ABIMethodReturnParams.fromJson(returnsJson),
      readonly: json['readonly'] as bool?,
      events: events,
    );
  }

  Map<String, dynamic> toJson() => {
    'name': name,
    if (desc != null) 'desc': desc,
    'args': args.map((a) => a.toJson()).toList(),
    'returns': returns.toJson(),
    if (readonly != null) 'readonly': readonly,
    if (events != null) 'events': events!.map((e) => e.toJson()).toList(),
  };
}

/// A resolved method argument.
class ABIMethodArg {
  final ABIArgumentType type;
  final String? name;
  final String? description;

  const ABIMethodArg({required this.type, this.name, this.description});
}

/// A resolved method return value.
class ABIMethodReturn {
  final ABIType? type;
  final String? description;

  const ABIMethodReturn({required this.type, this.description});
}

/// Algorand ABI method.
class ABIMethod {
  final String name;
  final String? description;
  final List<ABIMethodArg> args;
  final ABIMethodReturn returns;
  final List<ARC28Event>? events;
  final bool? readonly;

  ABIMethod(ABIMethodParams params)
    : name = params.name,
      description = params.desc,
      events = params.events,
      readonly = params.readonly,
      args =
          params.args.map((a) {
            final txn = ABITransactionType.tryFrom(a.type);
            final ref = ABIReferenceType.tryFrom(a.type);

            if (txn != null || ref != null) {
              return ABIMethodArg(
                type: txn ?? ref!,
                name: a.name,
                description: a.desc,
              );
            }

            return ABIMethodArg(
              type: ABIType.from(a.type),
              name: a.name,
              description: a.desc,
            );
          }).toList(),

      returns = ABIMethodReturn(
        type:
            params.returns.type == 'void'
                ? null
                : ABIType.from(params.returns.type),
        description: params.returns.desc,
      );

  /// Method signature string, e.g. `add(uint64,uint64)uint64`.
  String getSignature() {
    final argStr = args.map((a) => a.type.getName()).join(',');
    final retStr = returns.type?.getName() ?? 'void';
    return '$name($argStr)$retStr';
  }

  /// 4-byte method selector (first 4 bytes of SHA-512/256 of the signature).
  List<int> getSelector() {
    final sig = StringUtils.encode(getSignature());
    final hash = QuickCrypto.sha512256Hash(sig);
    return hash.sublist(0, 4);
  }

  /// Number of transactions this method call will produce
  /// (1 for the app call itself + 1 per transaction-typed argument).
  int txnCount() {
    var count = 1;
    for (final arg in args) {
      if (arg.type case ABITransactionType()) {
        count += 1;
      }
    }
    return count;
  }

  /// Serializes back to [ABIMethodParams].
  ABIMethodParams toParams() {
    return ABIMethodParams(
      name: name,
      desc: description,
      args:
          args
              .map(
                (a) => ABIMethodArgParams(
                  type: a.type.getName(),
                  name: a.name,
                  desc: a.description,
                ),
              )
              .toList(),
      returns: ABIMethodReturnParams(
        type: returns.type?.getName() ?? 'void',
        desc: returns.description,
      ),
      events: events,
      readonly: readonly,
    );
  }

  Map<String, dynamic> toJson() => toParams().toJson();

  /// Creates an [ABIMethod] from a signature string.
  static ABIMethod fromSignature(String signature) {
    final parsed = ABIMethodUtils._parseMethodSignature(signature);
    return ABIMethod(
      ABIMethodParams(
        name: parsed.name,
        args: parsed.args.map((a) => ABIMethodArgParams(type: a)).toList(),
        returns: ABIMethodReturnParams(type: parsed.returns),
      ),
    );
  }
}

class _ParsedSignature {
  final String name;
  final List<String> args;
  final String returns;

  const _ParsedSignature(this.name, this.args, this.returns);
}

/// Utility helpers for [ABIMethod], moved from top-level functions
/// (no behavior change).
abstract final class ABIMethodUtils {
  static _ParsedSignature _parseMethodSignature(String signature) {
    final argsStart = signature.indexOf('(');
    if (argsStart == -1) {
      throw OnChainErrors.algoPlugin(
        'ABIMethod.fromSignature',
        reason:
            'invalid method signature: missing opening parenthesis: $signature',
      );
    }

    var argsEnd = -1;
    var depth = 0;

    for (var i = argsStart; i < signature.length; i++) {
      final char = signature[i];
      if (char == '(') {
        depth++;
      } else if (char == ')') {
        if (depth == 0) break;
        depth--;
        if (depth == 0) {
          argsEnd = i;
          break;
        }
      }
    }

    if (argsEnd == -1) {
      throw OnChainErrors.algoPlugin(
        'ABIMethod.fromSignature',
        reason:
            'invalid method signature: missing closing parenthesis: $signature',
      );
    }

    final name = signature.substring(0, argsStart);
    final argsContent = signature.substring(argsStart + 1, argsEnd);
    final returns = signature.substring(argsEnd + 1);

    return _ParsedSignature(
      name,
      ABITupleType.parseTupleContent(argsContent),
      returns,
    );
  }

  /// Returns the unique method with [name] from [methods].
  static ABIMethod getMethodByName(List<ABIMethod> methods, String name) {
    final filtered = methods.where((m) => m.name == name).toList();

    if (filtered.length > 1) {
      throw OnChainErrors.algoPlugin(
        'getMethodByName',
        reason:
            'found ${filtered.length} methods with the same name: '
            '${filtered.map((m) => m.getSignature()).join(', ')}',
      );
    }

    if (filtered.isEmpty) {
      throw OnChainErrors.algoPlugin(
        'getMethodByName',
        reason: 'found 0 methods with the name "$name"',
      );
    }

    return filtered.first;
  }
}
