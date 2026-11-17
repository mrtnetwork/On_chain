// import 'dart:typed_data';
import 'package:blockchain_utils/blockchain_utils.dart';

import 'package:on_chain/exception/onchain_error.dart';
import 'package:on_chain/icp/src/address/address.dart';
import 'package:on_chain/icp/src/serialization/candid/src/leb128.dart';
import 'package:on_chain/icp/src/serialization/candid/src/reference.dart';

import 'deserialize.dart';
import 'types.dart';
import 'value.dart';
import 'serializer.dart';

class CandidUtils {
  /// Encode a single Candid value.
  static BuBytes encodeOne(IDLValue value) {
    final builder = IDLBuilder();
    builder.arg(value);
    return builder.serializeToBytes();
  }

  /// Encode multiple Candid values.
  static BuBytes encodeArgs(List<IDLValue> values) {
    final builder = IDLBuilder();
    for (final v in values) {
      builder.arg(v);
    }
    return builder.serializeToBytes();
  }

  /// Decode a single Candid value.
  static IDLValue decodeOne(List<int> bytes) {
    final de = IDLDeserialize(bytes);
    final result = de.getValue();
    de.done();
    return result;
  }

  /// Decode multiple Candid values.
  static List<IDLValue> decodeArgs(List<int> bytes) {
    final de = IDLDeserialize(bytes);
    final result = <IDLValue>[];
    while (!de.isDone) {
      result.add(de.getValue());
    }
    de.done();
    return result;
  }

  /// Decode with explicit expected types.
  static List<IDLValue> decodeArgsWithTypes(
    List<int> bytes,
    List<CType> types,
  ) {
    final de = IDLDeserialize(bytes);
    final result = <IDLValue>[];
    for (final t in types) {
      result.add(de.getValueWithType(t));
    }
    de.done();
    return result;
  }

  /// Pretty-print a number with underscores.
  static String ppNumStr(String s) {
    final isNeg = s.startsWith('-');
    final digits = isNeg ? s.substring(1) : s;
    final groups = <String>[];
    for (var i = digits.length; i > 0; i -= 3) {
      groups.add(digits.substring(i - 3 < 0 ? 0 : i - 3, i));
    }
    final result = groups.reversed.join('_');
    return isNeg ? '-$result' : result;
  }

  /// Check that labels are unique (assumes sorted).
  static void checkUnique(Iterable<Label> labels) {
    Label? prev;
    for (final lab in labels) {
      if (prev != null && lab == prev) {
        throw OnChainErrors.icpCandid(
          "checkUnique",
          reason: "label '$lab' hash collision with '$prev'",
        );
      }
      prev = lab;
    }
  }

  /// Encode values with explicit Candid types (plain Dart values, not IDLValue).
  ///
  /// ```dart
  /// final bytes = encode(
  ///   [CType.nat, CType.text, CType.opt(CType.bool_)],
  ///   [BigInt.from(42), 'hello', true],
  /// );
  /// ```
  static BuBytes encode(List<CType> types, List<dynamic> values) {
    if (types.length != values.length) {
      throw OnChainErrors.icpCandid(
        "encode",
        reason:
            'Type/value count mismatch: ${types.length} types, ${values.length} values',
      );
    }
    final typeSer = TypeSerializer();
    final valueSer = ValueSerializer();
    for (var i = 0; i < types.length; i++) {
      typeSer.pushType(types[i]);
      serializeTyped(valueSer, types[i], values[i]);
    }
    final out = ByteDataWriter();
    out.writeAll(const [0x44, 0x49, 0x44, 0x4C]); // DIDL
    out.writeAll(typeSer.serialize());
    out.writeAll(valueSer.result);
    return out.buffer();
  }

  /// Encode a single value with an explicit type.
  static BuBytes encodeOneTyped(CType type, dynamic value) =>
      encode([type], [value]);

  /// Decode a message into plain Dart values using [types] as the expected types.
  static List<dynamic> decode(List<int> bytes, List<CType> types) {
    final de = IDLDeserialize(bytes);
    final result = <dynamic>[];
    for (final t in types) {
      final idl = de.getValueWithType(t);
      result.add(idlValueToDart(idl, t));
    }
    de.done();
    return result;
  }

  /// Decode a single value with an expected type.
  static dynamic decodeOneTyped(List<int> bytes, CType type) =>
      decode(bytes, [type]).first;

  /// Convert an [IDLValue] to a plain Dart value guided by [type].
  static dynamic idlValueToDart(IDLValue v, CType type) {
    return switch (v) {
      IDLNull() => null,
      IDLBool(:final v) => v,
      IDLText(:final v) => v,
      IDLNat(:final v) => v,
      IDLInt(:final v) => v,
      IDLNat8(:final v) => v,
      IDLNat16(:final v) => v,
      IDLNat32(:final v) => v,
      IDLNat64(:final v) => v,
      IDLInt8(:final v) => v,
      IDLInt16(:final v) => v,
      IDLInt32(:final v) => v,
      IDLInt64(:final v) => v,
      IDLFloat32(:final v) => v,
      IDLFloat64(:final v) => v,
      IDLReserved() => null,
      IDLNone() => null,
      IDLPrincipal(:final v) => v,
      IDLService(:final v) => ServiceRef(v),
      IDLFunc(:final principal, :final method) => FuncRef(principal, method),
      IDLBlob(:final v) => v,
      IDLOpt(:final v) => idlValueToDart(v, type.inner ?? v.valueType()),
      IDLVec(:final values) => _vecToDart(values, type),
      IDLRecord(:final fields) => _recordToDart(fields, type),
      IDLVariant(:final field) => _variantToDart(field, type),
    };
  }

  static dynamic _vecToDart(List<IDLValue> values, CType type) {
    final inner =
        type.inner ?? (values.isEmpty ? CType.empty : values.first.valueType());
    if (inner.kind == CTypeKind.nat8) {
      return values.map((e) => (e as IDLNat8).v).toList();
    }
    return values.map((e) => idlValueToDart(e, inner)).toList();
  }

  static Map<String, dynamic> _recordToDart(List<IDLField> fields, CType type) {
    final map = <String, dynamic>{};
    final typeFields = type.fields;
    for (var i = 0; i < fields.length; i++) {
      final f = fields[i];
      final key = f.id.isNamed ? f.id.toString() : f.id.hash.toString();
      CType fieldTy = f.val.valueType();
      if (typeFields != null) {
        for (final tf in typeFields) {
          if (tf.id.hash == f.id.hash) {
            fieldTy = tf.ty;
            break;
          }
        }
      }
      map[key] = idlValueToDart(f.val, fieldTy);
    }
    return map;
  }

  static Map<String, dynamic> _variantToDart(IDLField field, CType type) {
    final key =
        field.id.isNamed ? field.id.toString() : field.id.hash.toString();
    CType fieldTy = field.val.valueType();
    final typeFields = type.fields;
    if (typeFields != null) {
      for (final tf in typeFields) {
        if (tf.id.hash == field.id.hash) {
          fieldTy = tf.ty;
          break;
        }
      }
    }
    return {key: idlValueToDart(field.val, fieldTy)};
  }

  // ---------------------------------------------------------------------------
  // Typed serialization
  // ---------------------------------------------------------------------------

  /// Serialize [value] according to [type] into [s].
  static void serializeTyped(ValueSerializer s, CType type, dynamic value) {
    switch (type.kind) {
      case CTypeKind.null_:
        s.serializeNull();
      case CTypeKind.bool:
        s.serializeBool(value as bool);
      case CTypeKind.nat:
        s.serializeNat(_asBigInt(value));
      case CTypeKind.int:
        s.serializeInt(_asBigInt(value));
      case CTypeKind.nat8:
        s.serializeNat8(_asInt(value));
      case CTypeKind.nat16:
        s.serializeNat16(_asInt(value));
      case CTypeKind.nat32:
        s.serializeNat32(_asInt(value));
      case CTypeKind.nat64:
        s.serializeNat64(_asBigInt(value));
      case CTypeKind.int8:
        s.serializeInt8(_asInt(value));
      case CTypeKind.int16:
        s.serializeInt16(_asInt(value));
      case CTypeKind.int32:
        s.serializeInt32(_asInt(value));
      case CTypeKind.int64:
        s.serializeInt64(_asBigInt(value));
      case CTypeKind.float32:
        s.serializeFloat32((value as num).toDouble());
      case CTypeKind.float64:
        s.serializeFloat64((value as num).toDouble());
      case CTypeKind.text:
        s.serializeText(value as String);
      case CTypeKind.reserved:
        s.serializeNull();
      case CTypeKind.empty:
        throw OnChainErrors.icpCandid(
          "serializeTyped",
          reason: 'Cannot encode empty type.',
        );
      case CTypeKind.principal:
        s.serializePrincipal(_asPrincipal(value).toBytes());
      case CTypeKind.opt:
        _serializeOpt(s, type.inner!, value);
      case CTypeKind.vec:
        _serializeVec(s, type.inner!, value);
      case CTypeKind.record:
        _serializeRecord(s, type.fields!, value);
      case CTypeKind.variant:
        _serializeVariant(s, type.fields!, value);
      case CTypeKind.func:
        final fr = _asFuncRef(value);
        s.serializeFunction(fr.principal.toBytes(), fr.method);
      case CTypeKind.service:
        final sr = _asServiceRef(value);
        s.serializePrincipal(sr.principal.toBytes());
      case CTypeKind.var_:
      case CTypeKind.knot:
      case CTypeKind.unknown:
      case CTypeKind.future:
        throw OnChainErrors.icpCandid(
          "serializeTyped",
          reason: 'Cannot serialize type ${type.kind}',
        );
    }
  }

  static void _serializeOpt(ValueSerializer s, CType inner, dynamic value) {
    if (value == null) {
      s.writeRawByte(0);
    } else {
      s.writeRawByte(1);
      serializeTyped(s, inner, value);
    }
  }

  static void _serializeVec(ValueSerializer s, CType inner, dynamic value) {
    if (value is List<int> && inner.kind == CTypeKind.nat8) {
      s.serializeBlob(value);
      return;
    }
    if (value is! List) {
      throw OnChainErrors.icpCandid(
        "CandidUtils._serializeVec",
        reason: 'Expected List for vec, got ${value.runtimeType}',
      );
    }
    LEB128.encodeUnsigned(s.writer, BigInt.from(value.length));
    for (final e in value) {
      serializeTyped(s, inner, e);
    }
  }

  static void _serializeRecord(
    ValueSerializer s,
    List<Field> fields,
    dynamic value,
  ) {
    if (value is Map) {
      for (final f in fields) {
        final key = f.id.isNamed ? f.id.toString() : f.id.hash.toString();
        final alt = f.id.hash.toString();
        dynamic v;
        if (value.containsKey(key)) {
          v = value[key];
        } else if (value.containsKey(alt)) {
          v = value[alt];
        } else if (value.containsKey(f.id.hash)) {
          v = value[f.id.hash];
        } else if (f.ty.kind == CTypeKind.opt) {
          v = null;
        } else {
          throw OnChainErrors.icpCandid(
            "CandidUtils._serializeRecord",
            reason: 'Missing record field "$key"',
          );
        }
        serializeTyped(s, f.ty, v);
      }
    } else if (value is List) {
      if (value.length != fields.length) {
        throw OnChainErrors.icpCandid(
          "CandidUtils._serializeRecord",
          reason:
              'Record field count mismatch: expected ${fields.length}, got ${value.length}',
        );
      }
      for (var i = 0; i < fields.length; i++) {
        serializeTyped(s, fields[i].ty, value[i]);
      }
    } else {
      throw OnChainErrors.icpCandid(
        "CandidUtils._serializeRecord",
        reason: 'Expected Map or List for record, got ${value.runtimeType}',
      );
    }
  }

  static void _serializeVariant(
    ValueSerializer s,
    List<Field> fields,
    dynamic value,
  ) {
    String? name;
    dynamic payload;
    int? hash;

    if (value is Variant) {
      name = value.tag;
      payload = value.value;
      hash = value.hash;
    } else if (value is Map) {
      if (value.length != 1) {
        throw OnChainErrors.icpCandid(
          "CandidUtils._serializeVariant",
          reason:
              'Variant map must have exactly one entry, got ${value.length}',
        );
      }
      final e = value.entries.first;
      if (e.key is String) {
        name = e.key as String;
      } else if (e.key is int) {
        hash = e.key as int;
      } else {
        throw OnChainErrors.icpCandid(
          "CandidUtils._serializeVariant",
          reason: 'Variant key must be String or int',
        );
      }
      payload = e.value;
    } else {
      throw OnChainErrors.icpCandid(
        "CandidUtils._serializeVariant",
        reason: 'Expected Variant or Map for variant, got ${value.runtimeType}',
      );
    }

    var index = -1;
    Field? field;
    for (var i = 0; i < fields.length; i++) {
      final f = fields[i];
      final matchName =
          name != null &&
          ((f.id.isNamed && f.id.toString() == name) ||
              f.id.hash == Label.idlHash(name));
      final matchHash = hash != null && f.id.hash == hash;
      if (matchName || matchHash) {
        index = i;
        field = f;
        break;
      }
    }
    if (index < 0 || field == null) {
      throw OnChainErrors.icpCandid(
        "CandidUtils._serializeVariant",
        reason: 'Unknown variant tag: ${name ?? hash}',
      );
    }
    LEB128.encodeUnsigned(s.writer, BigInt.from(index));
    serializeTyped(s, field.ty, payload);
  }

  static BigInt _asBigInt(dynamic v) {
    if (v is BigInt) return v;
    if (v is int) return BigInt.from(v);
    throw OnChainErrors.icpCandid(
      "CandidUtils._asBigInt",
      reason: 'Expected int or BigInt, got ${v.runtimeType}',
    );
  }

  static int _asInt(dynamic v) {
    if (v is int) return v;
    if (v is BigInt) return v.toInt();
    throw OnChainErrors.icpCandid(
      "CandidUtils._asInt",
      reason: 'Expected int, got ${v.runtimeType}',
    );
  }

  static IcpPrincipalAddress _asPrincipal(dynamic v) {
    if (v is IcpPrincipalAddress) return v;
    // if (v is Uint8List) return IcpPrincipalAddress.fromBytes(v);
    if (v is List<int>) {
      return IcpPrincipalAddress.fromBytes(v);
    }
    if (v is ServiceRef) return v.principal;
    throw OnChainErrors.icpCandid(
      "CandidUtils._asPrincipal",
      reason: 'Expected Principal, got ${v.runtimeType}',
    );
  }

  static FuncRef _asFuncRef(dynamic v) {
    if (v is FuncRef) return v;
    if (v is IDLFunc) return FuncRef(v.principal, v.method);
    throw OnChainErrors.icpCandid(
      "CandidUtils._asFuncRef",
      reason: 'Expected FuncRef, got ${v.runtimeType}',
    );
  }

  static ServiceRef _asServiceRef(dynamic v) {
    if (v is ServiceRef) return v;
    if (v is IcpPrincipalAddress) return ServiceRef(v);
    if (v is IDLService) return ServiceRef(v.v);
    if (v is List<int>) return ServiceRef(IcpPrincipalAddress.fromBytes(v));
    throw OnChainErrors.icpCandid(
      "CandidUtils._asServiceRef",
      reason: 'Expected ServiceRef or Principal, got ${v.runtimeType}',
    );
  }
}
