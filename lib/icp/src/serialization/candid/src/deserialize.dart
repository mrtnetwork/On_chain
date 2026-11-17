import 'package:blockchain_utils/helper/helper.dart';

import 'package:on_chain/exception/onchain_error.dart';
import 'package:on_chain/icp/src/address/address.dart';

import 'types.dart';
import 'leb128.dart';
import 'value.dart';
import 'binary_parser.dart';

/// Main entry point for decoding Candid messages.
class IDLDeserialize {
  final ByteDataReader _input;
  final TypeEnv _env;
  final List<CType> _types;
  int _currentArg = 0;

  IDLDeserialize._(this._input, this._env, this._types);

  factory IDLDeserialize(List<int> bytes) {
    bytes = bytes.asImmutableBytes;
    final header = Header.read(bytes);
    // final input = ByteDataReader(bytes.toList()); // position tracking needed
    // Skip header bytes - we need to track how many bytes the header consumed
    // For simplicity, re-read to consume correct bytes
    final r = ByteDataReader(bytes);
    r.readBytes(4); // magic
    final tableLen = LEB128.decodeUnsigned(r).toInt();
    for (var i = 0; i < tableLen; i++) {
      _skipConsType(r);
    }
    final argCount = LEB128.decodeUnsigned(r).toInt();
    for (var i = 0; i < argCount; i++) {
      _skipIndexType(r);
    }
    return IDLDeserialize._(r, header.env, header.args);
  }

  bool get isDone => _currentArg >= _types.length;

  IDLValue getValue() {
    if (isDone) {
      throw OnChainErrors.icpCandid(
        "IDLDeserialize.getValue",
        reason: 'No more values on the wire',
      );
    }
    final expect = _types[_currentArg++];
    return _deserializeValue(expect, expect);
  }

  IDLValue getValueWithType(CType expected) {
    if (isDone) {
      throw OnChainErrors.icpCandid(
        "IDLDeserialize.getValueWithType",
        reason: 'No more values on the wire',
      );
    }
    final wire = _types[_currentArg++];
    return _deserializeValue(wire, expected);
  }

  void done() {
    while (!isDone) {
      getValue();
    }
    if (_input.remaining > 0) {
      throw OnChainErrors.icpCandid(
        "IDLDeserialize.done",
        reason: 'Trailing bytes after deserialization',
      );
    }
  }

  IDLValue _deserializeValue(CType wire, CType expect) {
    final w = _trace(wire);
    final e = _trace(expect);

    // Subtyping: opt rules
    if (e.kind == CTypeKind.opt && w.kind != CTypeKind.opt) {
      if (w.kind == CTypeKind.null_ || w.kind == CTypeKind.reserved) {
        return const IDLNone();
      }
      final inner = _deserializeValue(w, e.inner!);
      return IDLOpt(inner);
    }

    if (e.kind == CTypeKind.reserved) return const IDLReserved();
    if (e.kind == CTypeKind.empty) {
      throw OnChainErrors.icpCandid(
        "IDLDeserialize",
        reason: 'Cannot decode empty type',
      );
    }

    // Exact matches
    return switch ((w.kind, e.kind)) {
      (CTypeKind.null_, CTypeKind.null_) => const IDLNull(),
      (CTypeKind.bool, CTypeKind.bool) => IDLBool(_input.readUint8() != 0),
      (CTypeKind.nat, CTypeKind.nat) => IDLNat(LEB128.decodeUnsigned(_input)),
      (CTypeKind.int, CTypeKind.int) => IDLInt(LEB128.decodeSigned(_input)),
      (CTypeKind.nat8, CTypeKind.nat8) => IDLNat8(_input.readUint8()),
      (CTypeKind.nat16, CTypeKind.nat16) => IDLNat16(_input.readUint16LE()),
      (CTypeKind.nat32, CTypeKind.nat32) => IDLNat32(_input.readUint32LE()),
      (CTypeKind.nat64, CTypeKind.nat64) => IDLNat64(_input.readUint64LE()),
      (CTypeKind.int8, CTypeKind.int8) => IDLInt8(
        _input.readUint8().toSigned(8),
      ),
      (CTypeKind.int16, CTypeKind.int16) => IDLInt16(
        _input.readUint16LE().toSigned(16),
      ),
      (CTypeKind.int32, CTypeKind.int32) => IDLInt32(
        _input.readUint32LE().toSigned(32),
      ),
      (CTypeKind.int64, CTypeKind.int64) => IDLInt64(_input.readInt64LE()),
      (CTypeKind.float32, CTypeKind.float32) => IDLFloat32(
        _input.readFloat32LE(),
      ),
      (CTypeKind.float64, CTypeKind.float64) => IDLFloat64(
        _input.readFloat64LE(),
      ),
      (CTypeKind.text, CTypeKind.text) => _readText(),
      (CTypeKind.principal, CTypeKind.principal) => _readPrincipal(),
      (CTypeKind.opt, CTypeKind.opt) => _readOpt(w, e),
      (CTypeKind.vec, CTypeKind.vec) => _readVec(w, e),
      (CTypeKind.record, CTypeKind.record) => _readRecord(w, e),
      (CTypeKind.variant, CTypeKind.variant) => _readVariant(w, e),
      (CTypeKind.service, CTypeKind.service) => IDLService(_readPrincipal().v),
      (CTypeKind.func, CTypeKind.func) => _readFunc(),
      _ =>
        throw OnChainErrors.icpCandid(
          "IDLDeserialize",
          reason: 'Type mismatch: wire=$w, expect=$e',
        ),
    };
  }

  CType _trace(CType t) {
    if (t.kind == CTypeKind.var_) return _env.recFindType(t.varName!);
    return t;
  }

  IDLText _readText() {
    final len = LEB128.decodeUnsigned(_input).toInt();
    final bytes = _input.readBytes(len);
    return IDLText(String.fromCharCodes(bytes));
  }

  IDLPrincipal _readPrincipal() {
    final flag = _input.readUint8();
    if (flag != 1) {
      throw OnChainErrors.icpCandid(
        "IDLDeserialize",
        reason: 'Opaque reference not supported',
      );
    }
    final len = LEB128.decodeUnsigned(_input).toInt();
    final bytes = _input.readBytes(len);
    return IDLPrincipal(IcpPrincipalAddress.fromBytes(bytes));
  }

  IDLFunc _readFunc() {
    final funcFlag = _input.readUint8();
    if (funcFlag != 1) {
      throw OnChainErrors.icpCandid(
        "IDLDeserialize",
        reason: 'Opaque reference not supported',
      );
    }
    final p = _readPrincipal();
    final len = LEB128.decodeUnsigned(_input).toInt();
    final meth = String.fromCharCodes(_input.readBytes(len));
    return IDLFunc(p.v, meth);
  }

  IDLValue _readOpt(CType w, CType e) {
    final hasValue = _input.readUint8() != 0;
    if (!hasValue) return const IDLNone();
    final inner = _deserializeValue(w.inner!, e.inner!);
    return IDLOpt(inner);
  }

  IDLVec _readVec(CType w, CType e) {
    final len = LEB128.decodeUnsigned(_input).toInt();
    final values = <IDLValue>[];
    for (var i = 0; i < len; i++) {
      values.add(_deserializeValue(w.inner!, e.inner!));
    }
    return IDLVec(values);
  }

  IDLRecord _readRecord(CType w, CType e) {
    final wFields = w.fields!;
    final eFields = e.fields!;
    final result = <IDLField>[];
    var wi = 0, ei = 0;

    while (wi < wFields.length || ei < eFields.length) {
      final wId = wi < wFields.length ? wFields[wi].id.hash : null;
      final eId = ei < eFields.length ? eFields[ei].id.hash : null;

      if (wId != null && eId != null && wId == eId) {
        final val = _deserializeValue(wFields[wi].ty, eFields[ei].ty);
        result.add(IDLField(eFields[ei].id, val));
        wi++;
        ei++;
      } else if (eId != null && (wId == null || eId < wId)) {
        // Missing wire field - must be optional
        final et = _trace(eFields[ei].ty);
        if (et.kind != CTypeKind.opt &&
            et.kind != CTypeKind.reserved &&
            et.kind != CTypeKind.null_) {
          throw OnChainErrors.icpCandid(
            "IDLDeserialize",
            reason: 'Field ${eFields[ei].id} is not optional',
          );
        }
        result.add(IDLField(eFields[ei].id, const IDLNone()));
        ei++;
      } else {
        // Extra wire field - skip
        _deserializeValue(wFields[wi].ty, CType.reserved);
        wi++;
      }
    }
    return IDLRecord(result);
  }

  IDLVariant _readVariant(CType w, CType e) {
    final index = LEB128.decodeUnsigned(_input).toInt();
    if (index >= w.fields!.length) {
      throw OnChainErrors.icpCandid(
        "IDLDeserialize",
        reason: 'Variant index out of range',
      );
    }
    final wField = w.fields![index];
    final eField = e.fields!.firstWhere(
      (f) => f.id == wField.id,
      orElse:
          () =>
              throw OnChainErrors.icpCandid(
                "IDLDeserialize",
                reason: 'Unknown variant field ${wField.id}',
              ),
    );
    final val = _deserializeValue(wField.ty, eField.ty);
    return IDLVariant(IDLField(eField.id, val), index);
  }

  static void _skipConsType(ByteDataReader r) {
    final opcode = LEB128.decodeSigned(r).toInt();
    switch (opcode) {
      case -18:
        _skipIndexType(r);
      case -19:
        _skipIndexType(r);
      case -20 || -21:
        final len = LEB128.decodeUnsigned(r).toInt();
        for (var i = 0; i < len; i++) {
          LEB128.decodeUnsigned(r); // id
          _skipIndexType(r);
        }
      case -22:
        final al = LEB128.decodeUnsigned(r).toInt();
        for (var i = 0; i < al; i++) {
          _skipIndexType(r);
        }
        final rl = LEB128.decodeUnsigned(r).toInt();
        for (var i = 0; i < rl; i++) {
          _skipIndexType(r);
        }
        final anl = r.readUint8();
        for (var i = 0; i < anl; i++) {
          r.readUint8();
        }
      case -23:
        final len = LEB128.decodeUnsigned(r).toInt();
        for (var i = 0; i < len; i++) {
          final nl = LEB128.decodeUnsigned(r).toInt();
          r.readBytes(nl);
          _skipIndexType(r);
        }
    }
  }

  static void _skipIndexType(ByteDataReader r) {
    final idx = LEB128.decodeSigned(r).toInt();
    // Type table references
    if (idx >= 0) return;
    // Primitive opcodes: -1 (null) through -17 (empty)
    if (idx >= -17 && idx <= -1) return;
    // Principal opcode
    if (idx == -24) return;
    throw OnChainErrors.icpCandid(
      "IDLDeserialize",
      reason: 'Unknown index type: $idx',
    );
  }
}
