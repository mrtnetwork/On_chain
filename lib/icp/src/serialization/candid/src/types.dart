import 'package:on_chain/exception/onchain_error.dart';

enum Opcode {
  null_(-1),
  bool_(-2),
  nat(-3),
  int_(-4),
  nat8(-5),
  nat16(-6),
  nat32(-7),
  nat64(-8),
  int8(-9),
  int16(-10),
  int32(-11),
  int64(-12),
  float32(-13),
  float64(-14),
  text(-15),
  reserved(-16),
  empty(-17),
  opt(-18),
  vec(-19),
  record(-20),
  variant(-21),
  func(-22),
  service(-23),
  principal(-24);

  final int value;
  const Opcode(this.value);
}

class Label implements Comparable<Label> {
  final int? _id;
  final String? _name;

  /// Candid type hash function.
  static int idlHash(String id) {
    var s = 0;
    for (final c in id.codeUnits) {
      s = (s * 223 + c) & 0xFFFFFFFF;
    }
    return s;
  }

  const Label.id(this._id) : _name = null;
  const Label.named(this._name) : _id = null;
  const Label.unnamed(int id) : _id = id, _name = null;

  int get hash => _id ?? Label.idlHash(_name!);

  bool get isNamed => _name != null;

  @override
  int compareTo(Label other) => hash.compareTo(other.hash);

  @override
  bool operator ==(Object other) => other is Label && hash == other.hash;

  @override
  int get hashCode => hash;

  @override
  String toString() => _name ?? hash.toString();
}

/// A record/variant field. Use [Field] for eager types and [Field.lazy] /
/// [LazyField] when the field type may recurse (e.g. MetadataMap, Value).
class Field {
  final Label id;
  final CType? _eager;
  final CType Function()? _lazy;
  CType? _lazyCache;

  /// Eager field — [ty] is stored and returned as-is.
  Field(this.id, CType ty) : _eager = ty, _lazy = null;

  /// Lazy field — [getTy] is invoked once when first needed, then cached.
  /// Caching is required so TypeSerializer identity maps stay stable.
  Field.lazy(this.id, CType Function() getTy) : _eager = null, _lazy = getTy;

  /// Resolved field type. For lazy fields this calls the deferred factory once.
  CType get ty {
    if (_eager != null) return _eager;
    return _lazyCache ??= _lazy!();
  }

  /// Alias used by serializers: resolve the type after the arm is selected.
  CType getType() => ty;

  bool get isLazy => _lazy != null;
}

/// Convenience constructor matching generator output `LazyField(...)`.
class LazyField extends Field {
  LazyField(super.id, super.getTy) : super.lazy();
}

enum FuncMode { query, oneway, compositeQuery }

class FunctionType {
  final List<CType> args;
  final List<CType> rets;
  final List<FuncMode> modes;
  const FunctionType(this.args, this.rets, this.modes);
}

enum CTypeKind {
  null_,
  bool,
  nat,
  int,
  nat8,
  nat16,
  nat32,
  nat64,
  int8,
  int16,
  int32,
  int64,
  float32,
  float64,
  text,
  reserved,
  empty,
  principal,
  unknown,
  future,
  opt,
  vec,
  record,
  variant,
  func,
  service,
  var_,
  knot,
}

class CType {
  final CTypeKind kind;
  final CType? _inner; // For opt, vec
  final List<Field>? _fields; // For record, variant
  final FunctionType? _func; // For func
  final List<(String, CType)>? _service; // For service
  final String? _varName; // For var
  final TypeId? _knotId; // For knot

  const CType._(
    this.kind,
    this._inner,
    this._fields,
    this._func,
    this._service,
    this._varName,
    this._knotId,
  );

  // Primitives
  static const null_ = CType._(
    CTypeKind.null_,
    null,
    null,
    null,
    null,
    null,
    null,
  );
  static const bool_ = CType._(
    CTypeKind.bool,
    null,
    null,
    null,
    null,
    null,
    null,
  );
  static const nat = CType._(CTypeKind.nat, null, null, null, null, null, null);
  static const int_ = CType._(
    CTypeKind.int,
    null,
    null,
    null,
    null,
    null,
    null,
  );
  static const nat8 = CType._(
    CTypeKind.nat8,
    null,
    null,
    null,
    null,
    null,
    null,
  );
  static const nat16 = CType._(
    CTypeKind.nat16,
    null,
    null,
    null,
    null,
    null,
    null,
  );
  static const nat32 = CType._(
    CTypeKind.nat32,
    null,
    null,
    null,
    null,
    null,
    null,
  );
  static const nat64 = CType._(
    CTypeKind.nat64,
    null,
    null,
    null,
    null,
    null,
    null,
  );
  static const int8 = CType._(
    CTypeKind.int8,
    null,
    null,
    null,
    null,
    null,
    null,
  );
  static const int16 = CType._(
    CTypeKind.int16,
    null,
    null,
    null,
    null,
    null,
    null,
  );
  static const int32 = CType._(
    CTypeKind.int32,
    null,
    null,
    null,
    null,
    null,
    null,
  );
  static const int64 = CType._(
    CTypeKind.int64,
    null,
    null,
    null,
    null,
    null,
    null,
  );
  static const float32 = CType._(
    CTypeKind.float32,
    null,
    null,
    null,
    null,
    null,
    null,
  );
  static const float64 = CType._(
    CTypeKind.float64,
    null,
    null,
    null,
    null,
    null,
    null,
  );
  static const text = CType._(
    CTypeKind.text,
    null,
    null,
    null,
    null,
    null,
    null,
  );
  static const reserved = CType._(
    CTypeKind.reserved,
    null,
    null,
    null,
    null,
    null,
    null,
  );
  static const empty = CType._(
    CTypeKind.empty,
    null,
    null,
    null,
    null,
    null,
    null,
  );
  static const principal = CType._(
    CTypeKind.principal,
    null,
    null,
    null,
    null,
    null,
    null,
  );
  static const unknown = CType._(
    CTypeKind.unknown,
    null,
    null,
    null,
    null,
    null,
    null,
  );
  static const future = CType._(
    CTypeKind.future,
    null,
    null,
    null,
    null,
    null,
    null,
  );

  factory CType.opt(CType t) =>
      CType._(CTypeKind.opt, t, null, null, null, null, null);
  factory CType.vec(CType t) =>
      CType._(CTypeKind.vec, t, null, null, null, null, null);
  factory CType.record(List<Field> fields) {
    final sorted = List<Field>.from(fields)
      ..sort((a, b) => a.id.compareTo(b.id));
    return CType._(CTypeKind.record, null, sorted, null, null, null, null);
  }
  factory CType.variant(List<Field> fields) {
    final sorted = List<Field>.from(fields)
      ..sort((a, b) => a.id.compareTo(b.id));
    return CType._(CTypeKind.variant, null, sorted, null, null, null, null);
  }
  factory CType.func(FunctionType f) =>
      CType._(CTypeKind.func, null, null, f, null, null, null);
  factory CType.service(List<(String, CType)> methods) {
    final sorted = List<(String, CType)>.from(methods)
      ..sort((a, b) => a.$1.compareTo(b.$1));
    return CType._(CTypeKind.service, null, null, null, sorted, null, null);
  }
  factory CType.var_(String name) =>
      CType._(CTypeKind.var_, null, null, null, null, name, null);
  factory CType.knot(TypeId id) =>
      CType._(CTypeKind.knot, null, null, null, null, null, id);

  CType? get inner => _inner;
  List<Field>? get fields => _fields;
  FunctionType? get func => _func;
  List<(String, CType)>? get serviceMethods => _service;
  String? get varName => _varName;

  bool get isPrimitive => switch (kind) {
    CTypeKind.null_ ||
    CTypeKind.bool ||
    CTypeKind.nat ||
    CTypeKind.int ||
    CTypeKind.nat8 ||
    CTypeKind.nat16 ||
    CTypeKind.nat32 ||
    CTypeKind.nat64 ||
    CTypeKind.int8 ||
    CTypeKind.int16 ||
    CTypeKind.int32 ||
    CTypeKind.int64 ||
    CTypeKind.float32 ||
    CTypeKind.float64 ||
    CTypeKind.text ||
    CTypeKind.reserved ||
    CTypeKind.empty ||
    CTypeKind.principal => true,
    _ => false,
  };

  bool isBlob(TypeEnv env) {
    if (kind != CTypeKind.vec) return false;
    final t = env.traceType(_inner!);
    return t.kind == CTypeKind.nat8;
  }

  bool get isTuple {
    if (kind != CTypeKind.record || _fields == null) return false;
    for (var i = 0; i < _fields.length; i++) {
      if (_fields[i].id.hash != i) return false;
    }
    return true;
  }

  @override
  bool operator ==(Object other) => other is CType && _eq(other);

  bool _eq(CType other) {
    if (kind != other.kind) return false;
    if (_inner != null) return _inner == other._inner;
    if (_fields != null) {
      if (other._fields == null || _fields.length != other._fields.length) {
        return false;
      }
      for (var i = 0; i < _fields.length; i++) {
        if (_fields[i].id != other._fields[i].id) return false;
        if (_fields[i].ty != other._fields[i].ty) return false;
      }
      return true;
    }
    if (_func != null) return _func == other._func;
    if (_service != null) {
      if (other._service == null || _service.length != other._service.length) {
        return false;
      }
      for (var i = 0; i < _service.length; i++) {
        if (_service[i].$1 != other._service[i].$1) return false;
        if (_service[i].$2 != other._service[i].$2) return false;
      }
      return true;
    }
    if (_varName != null) return _varName == other._varName;
    if (_knotId != null) return _knotId == other._knotId;
    return true;
  }

  @override
  int get hashCode =>
      Object.hash(kind, _inner, _fields, _func, _service, _varName, _knotId);

  @override
  String toString() {
    return switch (kind) {
      CTypeKind.null_ => 'null',
      CTypeKind.bool => 'bool',
      CTypeKind.nat => 'nat',
      CTypeKind.int => 'int',
      CTypeKind.nat8 => 'nat8',
      CTypeKind.nat16 => 'nat16',
      CTypeKind.nat32 => 'nat32',
      CTypeKind.nat64 => 'nat64',
      CTypeKind.int8 => 'int8',
      CTypeKind.int16 => 'int16',
      CTypeKind.int32 => 'int32',
      CTypeKind.int64 => 'int64',
      CTypeKind.float32 => 'float32',
      CTypeKind.float64 => 'float64',
      CTypeKind.text => 'text',
      CTypeKind.reserved => 'reserved',
      CTypeKind.empty => 'empty',
      CTypeKind.principal => 'principal',
      CTypeKind.opt => 'opt(${_inner!})',
      CTypeKind.vec => 'vec(${_inner!})',
      CTypeKind.record =>
        'record {${_fields!.map((f) => '${f.id}: ${f.ty}').join('; ')}}',
      CTypeKind.variant =>
        'variant {${_fields!.map((f) => '${f.id}: ${f.ty}').join('; ')}}',
      CTypeKind.func => 'func',
      CTypeKind.service => 'service',
      CTypeKind.var_ => _varName!,
      CTypeKind.knot => 'knot(${_knotId!})',
      _ => '?',
    };
  }
}

/// Type identifier for recursive types.
class TypeId {
  final String name;
  const TypeId(this.name);
  @override
  bool operator ==(Object other) => other is TypeId && name == other.name;
  @override
  int get hashCode => name.hashCode;
  @override
  String toString() => name;
}

/// Type environment for resolving recursive types.
class TypeEnv {
  final _env = <String, CType>{};

  TypeEnv();

  factory TypeEnv.fromMap(Map<String, CType> map) {
    final e = TypeEnv();
    e._env.addAll(map);
    return e;
  }

  void add(String name, CType ty) => _env[name] = ty;

  CType findType(String name) {
    final t = _env[name];
    if (t == null) {
      throw OnChainErrors.icpCandid(
        "findType",
        reason: 'Unbound type identifier $name',
      );
    }
    return t;
  }

  CType traceType(CType t) {
    if (t.kind == CTypeKind.var_) {
      return traceType(findType(t.varName!));
    }
    return t;
  }

  CType recFindType(String name) {
    var t = findType(name);
    while (t.kind == CTypeKind.var_) {
      t = findType(t.varName!);
    }
    return t;
  }

  void merge(TypeEnv other) {
    for (final e in other._env.entries) {
      if (_env.containsKey(e.key) && _env[e.key] != e.value) {
        throw OnChainErrors.icpCandid(
          "merge",
          reason: 'Inconsistent binding for ${e.key}.',
        );
      }
      _env[e.key] = e.value;
    }
  }

  bool isEmptyType(String id) {
    final t = recFindType(id);
    // Plain `record {}` is a valid inhabited type, not the uninhabited `empty`.
    // Only recursive records whose every field eventually points back to empty
    // types are considered empty (e.g. type E = record { e: E }).
    if (t.kind != CTypeKind.record) return false;
    if (t.fields!.isEmpty) return false;
    for (final f in t.fields!) {
      if (f.ty.kind == CTypeKind.var_) {
        if (!isEmptyType(f.ty.varName!)) return false;
      } else {
        return false;
      }
    }
    return true;
  }

  void replaceEmpty() {
    final toReplace = <String>[];
    for (final k in _env.keys) {
      if (isEmptyType(k)) toReplace.add(k);
    }
    for (final k in toReplace) {
      _env[k] = CType.empty;
    }
  }

  Map<String, CType> get bindings => Map.unmodifiable(_env);
}

/// A variant value for typed encode: `Variant('ok', 42)`.
class Variant {
  final String? tag;
  final int? hash;
  final dynamic value;

  const Variant(this.tag, this.value) : hash = null;
  const Variant.byHash(this.hash, this.value) : tag = null;
}
