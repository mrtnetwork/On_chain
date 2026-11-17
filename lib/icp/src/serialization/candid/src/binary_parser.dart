import 'package:blockchain_utils/blockchain_utils.dart';
import 'package:on_chain/exception/onchain_error.dart';

import 'types.dart';
import 'leb128.dart';

class Header {
  final TypeEnv env;
  final List<CType> args;

  Header(this.env, this.args);

  factory Header.read(List<int> bytes, {int? maxTypeLen}) {
    final r = ByteDataReader(bytes);
    final magic = r.readBytes(4);
    if (!BytesUtils.bytesEqual(magic, [0x44, 0x49, 0x44, 0x4C])) {
      throw OnChainErrors.icpCandid(
        "Header.read",
        reason: 'Invalid magic: expected DIDL',
      );
    }
    final tableLen = LEB128.decodeUnsigned(r).toInt();
    final maxLen = maxTypeLen ?? 10000;
    if (tableLen > maxLen) {
      throw OnChainErrors.icpCandid(
        "Header.read",
        reason: 'Type table size exceeded.',
      );
    }

    final tableEntries = <CType>[];
    for (var i = 0; i < tableLen; i++) {
      tableEntries.add(_readConsType(r, tableLen));
    }

    final envMap = <String, CType>{};
    for (var i = 0; i < tableLen; i++) {
      envMap['table$i'] = tableEntries[i];
    }
    final env = TypeEnv.fromMap(envMap);
    env.replaceEmpty();

    final argCount = LEB128.decodeUnsigned(r).toInt();
    final args = <CType>[];
    for (var i = 0; i < argCount; i++) {
      args.add(_readIndexType(r, tableLen));
    }

    return Header(env, args);
  }

  static CType _readConsType(ByteDataReader r, int tableLen) {
    final opcode = LEB128.decodeSigned(r).toInt();
    return switch (opcode) {
      -18 => CType.opt(_readIndexType(r, tableLen)),
      -19 => CType.vec(_readIndexType(r, tableLen)),
      -20 => _readFields(r, tableLen, false),
      -21 => _readFields(r, tableLen, true),
      -22 => _readFunc(r, tableLen),
      -23 => _readService(r, tableLen),
      _ =>
        throw OnChainErrors.icpCandid(
          "Header.read",
          reason: 'Unknown constructor opcode: $opcode',
        ),
    };
  }

  static CType _readFields(ByteDataReader r, int tableLen, bool isVariant) {
    final len = LEB128.decodeUnsigned(r).toInt();
    final fields = <Field>[];
    int? prev;
    for (var i = 0; i < len; i++) {
      final id = LEB128.decodeUnsigned(r).toInt();
      if (prev != null && prev >= id) {
        throw OnChainErrors.icpCandid(
          "Header.read",
          reason: 'Field ID collision or not sorted.',
        );
      }
      prev = id;
      final ty = _readIndexType(r, tableLen);
      fields.add(Field(Label.id(id), ty));
    }
    return isVariant ? CType.variant(fields) : CType.record(fields);
  }

  static CType _readFunc(ByteDataReader r, int tableLen) {
    final argLen = LEB128.decodeUnsigned(r).toInt();
    final args = <CType>[];
    for (var i = 0; i < argLen; i++) {
      args.add(_readIndexType(r, tableLen));
    }
    final retLen = LEB128.decodeUnsigned(r).toInt();
    final rets = <CType>[];
    for (var i = 0; i < retLen; i++) {
      rets.add(_readIndexType(r, tableLen));
    }
    final annLen = r.readUint8();
    if (annLen > 1) {
      throw OnChainErrors.icpCandid(
        "Header.read",
        reason: 'Function annotation length should be at most 1.',
      );
    }
    final modes = <FuncMode>[];
    for (var i = 0; i < annLen; i++) {
      final m = r.readUint8();
      modes.add(switch (m) {
        1 => FuncMode.query,
        2 => FuncMode.oneway,
        3 => FuncMode.compositeQuery,
        _ =>
          throw OnChainErrors.icpCandid(
            "Header.read",
            reason: 'Unknown func mode: $m',
          ),
      });
    }
    return CType.func(FunctionType(args, rets, modes));
  }

  static CType _readService(ByteDataReader r, int tableLen) {
    final len = LEB128.decodeUnsigned(r).toInt();
    final methods = <(String, CType)>[];
    String? prev;
    for (var i = 0; i < len; i++) {
      final nameLen = LEB128.decodeUnsigned(r).toInt();
      final nameBytes = r.readBytes(nameLen);
      final name = String.fromCharCodes(nameBytes);
      if (prev != null && prev.compareTo(name) >= 0) {
        throw OnChainErrors.icpCandid(
          "Header.read",
          reason: 'Method name duplicate or not sorted.',
        );
      }
      prev = name;
      final ty = _readIndexType(r, tableLen);
      methods.add((name, ty));
    }
    return CType.service(methods);
  }

  static CType _readIndexType(ByteDataReader r, int tableLen) {
    final idx = LEB128.decodeSigned(r).toInt();
    return switch (idx) {
      -1 => CType.null_,
      -2 => CType.bool_,
      -3 => CType.nat,
      -4 => CType.int_,
      -5 => CType.nat8,
      -6 => CType.nat16,
      -7 => CType.nat32,
      -8 => CType.nat64,
      -9 => CType.int8,
      -10 => CType.int16,
      -11 => CType.int32,
      -12 => CType.int64,
      -13 => CType.float32,
      -14 => CType.float64,
      -15 => CType.text,
      -16 => CType.reserved,
      -17 => CType.empty,
      -24 => CType.principal,
      >= 0 => CType.var_('table$idx'),
      _ =>
        throw OnChainErrors.icpCandid(
          "Header.read",
          reason: 'Unknown opcode: $idx',
        ),
    };
  }
}
