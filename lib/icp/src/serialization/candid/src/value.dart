// import 'dart:typed_data';
import 'package:blockchain_utils/blockchain_utils.dart';
import 'package:on_chain/icp/src/address/address.dart';
import 'types.dart';
import 'serializer.dart';

/// Untyped Candid value.
sealed class IDLValue with Equality {
  const IDLValue();

  CType valueType() => switch (this) {
    IDLNull() => CType.null_,
    IDLBool() => CType.bool_,
    IDLText() => CType.text,
    IDLInt() => CType.int_,
    IDLNat() => CType.nat,
    IDLNat8() => CType.nat8,
    IDLNat16() => CType.nat16,
    IDLNat32() => CType.nat32,
    IDLNat64() => CType.nat64,
    IDLInt8() => CType.int8,
    IDLInt16() => CType.int16,
    IDLInt32() => CType.int32,
    IDLInt64() => CType.int64,
    IDLFloat32() => CType.float32,
    IDLFloat64() => CType.float64,
    IDLReserved() => CType.reserved,
    IDLNone() => CType.opt(CType.empty),
    IDLPrincipal() => CType.principal,
    IDLService() => CType.service([]),
    IDLFunc() => CType.func(const FunctionType([], [], [])),
    IDLBlob() => CType.vec(CType.nat8),
    IDLOpt(:final v) => CType.opt(v.valueType()),
    IDLVec(:final values) => CType.vec(
      values.isEmpty ? CType.empty : values.first.valueType(),
    ),
    IDLRecord(:final fields) => CType.record(
      fields.map((f) => Field(f.id, f.val.valueType())).toList(),
    ),
    IDLVariant(:final field) => CType.variant([
      Field(field.id, field.val.valueType()),
    ]),
  };

  void serialize(Serializer s) {
    switch (this) {
      case IDLNull():
        s.serializeNull();
      case IDLBool(:final v):
        s.serializeBool(v);
      case IDLText(:final v):
        s.serializeText(v);
      case IDLInt(:final v):
        s.serializeInt(v);
      case IDLNat(:final v):
        s.serializeNat(v);
      case IDLNat8(:final v):
        s.serializeNat8(v);
      case IDLNat16(:final v):
        s.serializeNat16(v);
      case IDLNat32(:final v):
        s.serializeNat32(v);
      case IDLNat64(:final v):
        s.serializeNat64(v);
      case IDLInt8(:final v):
        s.serializeInt8(v);
      case IDLInt16(:final v):
        s.serializeInt16(v);
      case IDLInt32(:final v):
        s.serializeInt32(v);
      case IDLInt64(:final v):
        s.serializeInt64(v);
      case IDLFloat32(:final v):
        s.serializeFloat32(v);
      case IDLFloat64(:final v):
        s.serializeFloat64(v);
      case IDLReserved():
        s.serializeNull();
      case IDLNone():
        s.serializeOption(null);
      case IDLPrincipal(:final v):
        s.serializePrincipal(v.toBytes());
      case IDLService(:final v):
        s.serializePrincipal(v.toBytes());
      case IDLFunc(:final principal, :final method):
        s.serializeFunction(principal.toBytes(), method);
      case IDLBlob(:final v):
        s.serializeBlob(v);
      case IDLVec(:final values):
        final ser = s.serializeVec(values.length);
        for (final v in values) {
          ser.serializeElement(v);
        }
      case IDLRecord(:final fields):
        final ser = s.serializeStruct();
        for (final f in fields) {
          ser.serializeElement(f.val);
        }
      case IDLVariant(:final field, :final index):
        final ser = s.serializeVariant(index);
        ser.serializeElement(field.val);
      case IDLOpt(:final v):
        s.serializeOption(v);
        break;
    }
  }
}

class IDLNull extends IDLValue {
  const IDLNull();

  @override
  List<dynamic> get variables => [];
}

class IDLBool extends IDLValue {
  final bool v;
  const IDLBool(this.v);
  @override
  List<dynamic> get variables => [v];
}

class IDLText extends IDLValue {
  final String v;
  const IDLText(this.v);

  @override
  List<dynamic> get variables => [v];
}

class IDLInt extends IDLValue {
  final BigInt v;
  const IDLInt(this.v);
  factory IDLInt.from(int v) => IDLInt(BigInt.from(v));

  @override
  List<dynamic> get variables => [v];
}

class IDLNat extends IDLValue {
  final BigInt v;
  const IDLNat(this.v);
  factory IDLNat.from(int v) => IDLNat(BigInt.from(v));

  @override
  List<dynamic> get variables => [v];
}

class IDLNat8 extends IDLValue {
  final int v;
  const IDLNat8(this.v);

  @override
  List<dynamic> get variables => [v];
}

class IDLNat16 extends IDLValue {
  final int v;
  const IDLNat16(this.v);

  @override
  List<dynamic> get variables => [v];
}

class IDLNat32 extends IDLValue {
  final int v;
  const IDLNat32(this.v);

  @override
  List<dynamic> get variables => [v];
}

class IDLNat64 extends IDLValue {
  final BigInt v;
  IDLNat64(this.v);
  factory IDLNat64.from(int v) => IDLNat64(BigInt.from(v));

  @override
  List<dynamic> get variables => [v];
}

class IDLInt8 extends IDLValue {
  final int v;
  const IDLInt8(this.v);

  @override
  List<dynamic> get variables => [v];
}

class IDLInt16 extends IDLValue {
  final int v;
  const IDLInt16(this.v);

  @override
  List<dynamic> get variables => [v];
}

class IDLInt32 extends IDLValue {
  final int v;
  const IDLInt32(this.v);

  @override
  List<dynamic> get variables => [v];
}

class IDLInt64 extends IDLValue {
  final BigInt v;
  IDLInt64(this.v);
  factory IDLInt64.from(int v) => IDLInt64(BigInt.from(v));

  @override
  List<dynamic> get variables => [v];
}

class IDLFloat32 extends IDLValue {
  final double v;
  const IDLFloat32(this.v);

  @override
  List<dynamic> get variables => [v];
}

class IDLFloat64 extends IDLValue {
  final double v;
  const IDLFloat64(this.v);

  @override
  List<dynamic> get variables => [v];
}

class IDLReserved extends IDLValue {
  const IDLReserved();

  @override
  List<dynamic> get variables => [];
}

class IDLNone extends IDLValue {
  const IDLNone();
  @override
  List<dynamic> get variables => [];
}

class IDLPrincipal extends IDLValue {
  final IcpPrincipalAddress v;
  const IDLPrincipal(this.v);
  @override
  List<dynamic> get variables => [v];
}

class IDLService extends IDLValue {
  final IcpPrincipalAddress v;
  const IDLService(this.v);
  @override
  List<dynamic> get variables => [v];
}

class IDLFunc extends IDLValue {
  final IcpPrincipalAddress principal;
  final String method;
  const IDLFunc(this.principal, this.method);
  @override
  List<dynamic> get variables => [principal, method];
}

class IDLBlob extends IDLValue {
  final List<int> v;
  const IDLBlob(this.v);

  @override
  List<dynamic> get variables => [v];
}

class IDLOpt extends IDLValue {
  final IDLValue v;
  const IDLOpt(this.v);

  @override
  List<dynamic> get variables => [v];
}

class IDLVec extends IDLValue {
  final List<IDLValue> values;
  const IDLVec(this.values);

  @override
  List<dynamic> get variables => [values];
}

class IDLField with Equality {
  final Label id;
  final IDLValue val;
  const IDLField(this.id, this.val);

  @override
  List<dynamic> get variables => [id, val];
}

class IDLVariant extends IDLValue {
  final IDLField field;
  final int index;
  const IDLVariant(this.field, this.index);

  @override
  List<dynamic> get variables => [field, index];
}

class IDLRecord extends IDLValue {
  final List<IDLField> fields;
  const IDLRecord(this.fields);

  @override
  List<dynamic> get variables => [fields];
}

class IDLArgs {
  final List<IDLValue> args;
  const IDLArgs(this.args);

  List<int> toBytes() {
    final builder = IDLBuilder();
    for (final arg in args) {
      builder.valueArg(arg);
    }
    return builder.serializeToBytes();
  }
}
