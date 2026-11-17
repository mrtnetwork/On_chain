import 'package:on_chain/icp/src/address/address.dart';

import 'serializer.dart';
import 'types.dart';
import 'value.dart';

/// Function reference: a canister method pointer `(principal, method)`.
class FuncRef {
  final IcpPrincipalAddress principal;
  final String method;
  final FunctionType? signature;

  const FuncRef(this.principal, this.method, {this.signature});

  factory FuncRef.from(
    IcpPrincipalAddress principal,
    String method, {
    FunctionType? signature,
  }) => FuncRef(principal, method, signature: signature);

  /// Candid type for this function reference (uses [signature] or opaque func).
  CType get type => CType.func(signature ?? const FunctionType([], [], []));

  IDLFunc toIDLValue() => IDLFunc(principal, method);

  void serialize(Serializer s) =>
      s.serializeFunction(principal.toBytes(), method);

  @override
  bool operator ==(Object other) =>
      other is FuncRef &&
      other.principal == principal &&
      other.method == method;

  @override
  int get hashCode => Object.hash(principal, method);

  @override
  String toString() => 'func $principal.$method';
}

/// Service reference: a canister principal with an optional interface.
class ServiceRef {
  final IcpPrincipalAddress principal;

  /// Method name → function type (optional interface description).
  final Map<String, FunctionType> methods;

  const ServiceRef(this.principal, [this.methods = const {}]);

  factory ServiceRef.from(
    IcpPrincipalAddress principal, {
    Map<String, FunctionType> methods = const {},
  }) => ServiceRef(principal, methods);

  /// Build a service Candid type from [methods].
  CType get type {
    final list =
        methods.entries.map((e) => (e.key, CType.func(e.value))).toList();
    return CType.service(list);
  }

  IDLService toIDLValue() => IDLService(principal);

  FuncRef method(String name) {
    final sig = methods[name];
    return FuncRef(principal, name, signature: sig);
  }

  void serialize(Serializer s) => s.serializePrincipal(principal.toBytes());

  @override
  bool operator ==(Object other) =>
      other is ServiceRef && other.principal == principal;

  @override
  int get hashCode => principal.hashCode;

  @override
  String toString() => 'service $principal';
}

/// Helpers to build function / service types for use with [encode].
class Func {
  Func._();

  /// `func (args...) -> (rets...); modes`
  static FunctionType signature({
    List<CType> args = const [],
    List<CType> rets = const [],
    List<FuncMode> modes = const [],
  }) => FunctionType(args, rets, modes);

  /// Query method.
  static FunctionType query(List<CType> args, List<CType> rets) =>
      FunctionType(args, rets, const [FuncMode.query]);

  /// Update (no mode flags).
  static FunctionType update(List<CType> args, List<CType> rets) =>
      FunctionType(args, rets, const []);

  /// One-way method.
  static FunctionType oneway(List<CType> args) =>
      FunctionType(args, const [], const [FuncMode.oneway]);

  /// Composite query.
  static FunctionType compositeQuery(List<CType> args, List<CType> rets) =>
      FunctionType(args, rets, const [FuncMode.compositeQuery]);

  /// Candid `func` type value.
  static CType type(FunctionType ft) => CType.func(ft);
}

/// Helpers to build service types for use with [encode].
class Service {
  Service._();

  /// Candid `service` type from a method map.
  static CType type(Map<String, FunctionType> methods) {
    final list =
        methods.entries.map((e) => (e.key, CType.func(e.value))).toList();
    return CType.service(list);
  }

  /// Create a [ServiceRef] binding a principal to an interface.
  static ServiceRef ref(
    IcpPrincipalAddress principal, {
    Map<String, FunctionType> methods = const {},
  }) => ServiceRef(principal, methods);
}
