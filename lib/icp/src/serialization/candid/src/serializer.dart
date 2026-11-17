import 'dart:collection';

import 'dart:typed_data' show Endian;

import 'package:blockchain_utils/blockchain_utils.dart';
import 'package:on_chain/exception/onchain_error.dart';

import 'types.dart';
import 'leb128.dart';
import 'value.dart';

/// Serializer interface for Candid values.
abstract class Serializer {
  void serializeBool(bool v);
  void serializeInt(BigInt v);
  void serializeNat(BigInt v);
  void serializeNat8(int v);
  void serializeNat16(int v);
  void serializeNat32(int v);
  void serializeNat64(BigInt v);
  void serializeInt8(int v);
  void serializeInt16(int v);
  void serializeInt32(int v);
  void serializeInt64(BigInt v);
  void serializeFloat32(double v);
  void serializeFloat64(double v);
  void serializeText(String v);
  void serializeNull();
  void serializeEmpty();
  void serializePrincipal(List<int> blob);
  void serializeFunction(List<int> blob, String method);
  Compound serializeVec(int len);
  Compound serializeStruct();
  Compound serializeVariant(int index);
  void serializeBlob(List<int> blob);
  void serializeOption(IDLValue? v);
}

abstract class Compound {
  void serializeElement(IDLValue v);
  void serializeBlob(List<int> blob);
}

class _CompoundImpl implements Compound {
  final ValueSerializer _ser;
  _CompoundImpl(this._ser);

  @override
  void serializeElement(IDLValue v) => v.serialize(_ser);

  @override
  void serializeBlob(List<int> blob) => _ser.serializeBlob(blob);
}

class ValueSerializer implements Serializer {
  final ByteDataWriter _writer = ByteDataWriter();

  BuBytes get result => _writer.toBytes();

  /// Package-visible writer for typed encoding helpers.
  ByteDataWriter get writer => _writer;

  void writeRawByte(int b) => _writer.writeUint8(b);

  @override
  void serializeBool(bool v) => _writer.writeUint8(v ? 1 : 0);

  @override
  void serializeInt(BigInt v) => LEB128.encodeSigned(_writer, v);

  @override
  void serializeNat(BigInt v) => LEB128.encodeUnsigned(_writer, v);

  @override
  void serializeNat8(int v) => _writer.writeAll(
    IntUtils.toBytes(v.asU8, sign: false, byteOrder: Endian.little, length: 1),
  );

  @override
  void serializeNat16(int v) {
    _writer.writeAll(
      IntUtils.toBytes(
        v.asU16,
        sign: false,
        byteOrder: Endian.little,
        length: 2,
      ),
    );
  }

  @override
  void serializeNat32(int v) {
    _writer.writeAll(
      IntUtils.toBytes(
        v.asU32,
        sign: false,
        byteOrder: Endian.little,
        length: 4,
      ),
    );
  }

  @override
  void serializeNat64(BigInt v) {
    _writer.writeAll(
      BigintUtils.toBytes(
        v.asU64,
        sign: false,
        byteOrder: Endian.little,
        length: 8,
      ),
    );
  }

  @override
  void serializeInt8(int v) => _writer.writeAll(
    IntUtils.toBytes(v, sign: true, byteOrder: Endian.little, length: 1),
  );

  @override
  void serializeInt16(int v) => _writer.writeAll(
    IntUtils.toBytes(v.asI16, sign: true, byteOrder: Endian.little, length: 2),
  );

  @override
  void serializeInt32(int v) => _writer.writeAll(
    IntUtils.toBytes(v.asI32, sign: true, byteOrder: Endian.little, length: 4),
  );

  @override
  void serializeInt64(BigInt v) {
    _writer.writeAll(
      BigintUtils.toBytes(
        v.asI64,
        sign: true,
        byteOrder: Endian.little,
        length: 8,
      ),
    );
  }

  @override
  void serializeFloat32(double v) {
    final b = FloatCoder.toBytes(v, byteOrder: Endian.little);
    // final b = ByteData(4)..setFloat32(0, v, Endian.little);
    _writer.writeAll(b);
  }

  @override
  void serializeFloat64(double v) {
    final b = DoubleCoder.toBytes(v, byteOrder: Endian.little);
    _writer.writeAll(b);
  }

  @override
  void serializeText(String v) {
    final bytes = StringUtils.encode(v);
    LEB128.encodeUnsigned(_writer, BigInt.from(bytes.length));
    _writer.writeAll(bytes);
  }

  @override
  void serializeNull() {}

  @override
  void serializeEmpty() =>
      throw OnChainErrors.icpCandid(
        "ValueSerializer.serializeEmpty",
        reason: 'Cannot encode empty type.',
      );

  @override
  void serializePrincipal(List<int> blob) {
    _writer.writeUint8(1);
    LEB128.encodeUnsigned(_writer, BigInt.from(blob.length));
    _writer.writeAll(blob);
  }

  @override
  void serializeFunction(List<int> blob, String method) {
    _writer.writeUint8(1);
    serializePrincipal(blob);
    serializeText(method);
  }

  @override
  Compound serializeVec(int len) {
    LEB128.encodeUnsigned(_writer, BigInt.from(len));
    return _CompoundImpl(this);
  }

  @override
  Compound serializeStruct() => _CompoundImpl(this);

  @override
  Compound serializeVariant(int index) {
    LEB128.encodeUnsigned(_writer, BigInt.from(index));
    return _CompoundImpl(this);
  }

  @override
  void serializeBlob(List<int> blob) {
    LEB128.encodeUnsigned(_writer, BigInt.from(blob.length));
    _writer.writeAll(blob);
  }

  @override
  void serializeOption(IDLValue? v) {
    if (v == null) {
      _writer.writeUint8(0);
    } else {
      _writer.writeUint8(1);
      v.serialize(this);
    }
  }
}

class TypeSerializer {
  final List<List<int>> _typeTable = [];
  // Identity map: recursive CTypes with LazyField must not use deep ==.
  final Map<CType, int> _typeMap = HashMap<CType, int>(
    equals: identical,
    hashCode: identityHashCode,
  );

  /// Shape intern for record/variant so recursive [LazyField] edges that
  /// rebuild `get ctype` each time still share one type-table index.
  final Map<String, int> _shapeMap = {};
  final TypeEnv _env = TypeEnv();
  final List<CType> _args = [];

  void pushType(CType t) {
    _args.add(t);
    _buildType(t);
  }

  String? _shapeKey(CType t) {
    // Only labels — must not touch [Field.ty] (would expand LazyField).
    if (t.kind == CTypeKind.record || t.kind == CTypeKind.variant) {
      final fs = t.fields;
      if (fs == null) return null;
      return '${t.kind.name}:${fs.map((f) => f.id.hash).join(',')}';
    }
    return null;
  }

  void _buildType(CType t) {
    if (_typeMap.containsKey(t)) return;
    if (t.isPrimitive) return;

    final actual = switch (t.kind) {
      CTypeKind.var_ => _env.recFindType(t.varName!),
      _ => t,
    };
    if (actual.isPrimitive) return;

    final shape = _shapeKey(actual);
    if (shape != null && _shapeMap.containsKey(shape)) {
      final existing = _shapeMap[shape]!;
      _typeMap[t] = existing;
      if (!identical(actual, t)) _typeMap[actual] = existing;
      return;
    }

    // Reserve table slot BEFORE children so recursive LazyField edges can
    // resolve back to this type without infinite recursion.
    final idx = _typeTable.length;
    _typeMap[t] = idx;
    if (!identical(actual, t)) {
      _typeMap[actual] = idx;
    }
    if (shape != null) {
      _shapeMap[shape] = idx;
    }
    _typeTable.add([]); // placeholder

    switch (actual.kind) {
      case CTypeKind.opt:
      case CTypeKind.vec:
        _buildType(actual.inner!);
      case CTypeKind.record:
      case CTypeKind.variant:
        for (final f in actual.fields!) {
          _buildType(f.ty);
        }
      case CTypeKind.func:
        final f = actual.func!;
        for (final a in f.args) {
          _buildType(a);
        }
        for (final r in f.rets) {
          _buildType(r);
        }
      case CTypeKind.service:
        for (final (_, ty) in actual.serviceMethods!) {
          _buildType(ty);
        }
      default:
        break;
    }

    final buf = ByteDataWriter();
    switch (actual.kind) {
      case CTypeKind.opt:
        LEB128.encodeSigned(buf, BigInt.from(Opcode.opt.value));
        _encode(buf, actual.inner!);
      case CTypeKind.vec:
        LEB128.encodeSigned(buf, BigInt.from(Opcode.vec.value));
        _encode(buf, actual.inner!);
      case CTypeKind.record:
        LEB128.encodeSigned(buf, BigInt.from(Opcode.record.value));
        LEB128.encodeUnsigned(buf, BigInt.from(actual.fields!.length));
        for (final f in actual.fields!) {
          LEB128.encodeUnsigned(buf, BigInt.from(f.id.hash));
          _encode(buf, f.ty);
        }
      case CTypeKind.variant:
        LEB128.encodeSigned(buf, BigInt.from(Opcode.variant.value));
        LEB128.encodeUnsigned(buf, BigInt.from(actual.fields!.length));
        for (final f in actual.fields!) {
          LEB128.encodeUnsigned(buf, BigInt.from(f.id.hash));
          _encode(buf, f.ty);
        }
      case CTypeKind.func:
        final f = actual.func!;
        LEB128.encodeSigned(buf, BigInt.from(Opcode.func.value));
        LEB128.encodeUnsigned(buf, BigInt.from(f.args.length));
        for (final a in f.args) {
          _encode(buf, a);
        }

        LEB128.encodeUnsigned(buf, BigInt.from(f.rets.length));
        for (final r in f.rets) {
          _encode(buf, r);
        }
        LEB128.encodeUnsigned(buf, BigInt.from(f.modes.length));
        for (final m in f.modes) {
          final code = switch (m) {
            FuncMode.query => 1,
            FuncMode.oneway => 2,
            FuncMode.compositeQuery => 3,
          };
          LEB128.encodeSigned(buf, BigInt.from(code));
        }
      case CTypeKind.service:
        final ms = actual.serviceMethods!;
        LEB128.encodeSigned(buf, BigInt.from(Opcode.service.value));
        LEB128.encodeUnsigned(buf, BigInt.from(ms.length));
        for (final (name, ty) in ms) {
          final nb = StringUtils.encode(name);
          LEB128.encodeUnsigned(buf, BigInt.from(nb.length));
          buf.writeAll(nb);
          _encode(buf, ty);
        }
      default:
        throw OnChainErrors.icpCandid(
          "TypeSerializer",
          reason: 'Unexpected type in type table: $actual',
        );
    }
    _typeTable[idx] = buf.buffer();
  }

  void _encode(ByteDataWriter buf, CType t) {
    if (t.kind == CTypeKind.var_) {
      final actual = _env.recFindType(t.varName!);
      if (actual.isPrimitive) {
        _encodePrimitive(buf, actual);
        return;
      }
    }
    if (t.isPrimitive) {
      _encodePrimitive(buf, t);
      return;
    }
    final idx = _typeMap[t];
    if (idx == null) {
      throw OnChainErrors.icpCandid(
        "TypeSerializer",
        reason: 'Type $t not found in type map.',
      );
    }
    LEB128.encodeSigned(buf, BigInt.from(idx));
  }

  void _encodePrimitive(ByteDataWriter buf, CType t) {
    final code = switch (t.kind) {
      CTypeKind.null_ => Opcode.null_.value,
      CTypeKind.bool => Opcode.bool_.value,
      CTypeKind.nat => Opcode.nat.value,
      CTypeKind.int => Opcode.int_.value,
      CTypeKind.nat8 => Opcode.nat8.value,
      CTypeKind.nat16 => Opcode.nat16.value,
      CTypeKind.nat32 => Opcode.nat32.value,
      CTypeKind.nat64 => Opcode.nat64.value,
      CTypeKind.int8 => Opcode.int8.value,
      CTypeKind.int16 => Opcode.int16.value,
      CTypeKind.int32 => Opcode.int32.value,
      CTypeKind.int64 => Opcode.int64.value,
      CTypeKind.float32 => Opcode.float32.value,
      CTypeKind.float64 => Opcode.float64.value,
      CTypeKind.text => Opcode.text.value,
      CTypeKind.reserved => Opcode.reserved.value,
      CTypeKind.empty => Opcode.empty.value,
      CTypeKind.principal => Opcode.principal.value,
      _ =>
        throw OnChainErrors.icpCandid(
          "TypeSerializer",
          reason: 'Not a primitive: $t',
        ),
    };
    LEB128.encodeSigned(buf, BigInt.from(code));
  }

  List<int> serialize() {
    final out = ByteDataWriter();
    LEB128.encodeUnsigned(out, BigInt.from(_typeTable.length));
    for (final t in _typeTable) {
      out.writeAll(t);
    }
    LEB128.encodeUnsigned(out, BigInt.from(_args.length));
    for (final a in _args) {
      _encode(out, a);
    }
    return out.buffer();
  }
}

/// Main entry point for encoding Candid messages.
class IDLBuilder {
  final TypeSerializer _typeSer = TypeSerializer();
  final ValueSerializer _valueSer = ValueSerializer();

  IDLBuilder arg(IDLValue value) {
    _typeSer.pushType(value.valueType());
    value.serialize(_valueSer);
    return this;
  }

  IDLBuilder valueArg(IDLValue value) {
    return arg(value);
  }

  BuBytes serializeToBytes() {
    final out = ByteDataWriter();
    out.writeAll([0x44, 0x49, 0x44, 0x4C]); // "DIDL"
    out.writeAll(_typeSer.serialize());
    out.writeAll(_valueSer.result);
    return out.buffer();
  }
}
