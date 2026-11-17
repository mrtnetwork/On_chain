// import 'dart:typed_data';

import 'dart:typed_data' show Endian;

import 'package:blockchain_utils/blockchain_utils.dart';
import 'package:on_chain/exception/onchain_error.dart';

/// LEB128 encoding/decoding for unsigned and signed integers.
class LEB128 {
  static void encodeUnsigned(ByteDataWriter w, BigInt val) {
    var v = val;
    while (true) {
      var byte = (v & BigInt.from(0x7f)).toInt();
      v >>= 7;
      if (v != BigInt.zero) {
        byte |= 0x80;
      }
      w.writeUint8(byte);
      if (v == BigInt.zero) return;
    }
  }

  static void encodeSigned(ByteDataWriter w, BigInt val) {
    var v = val;
    while (true) {
      var byte = (v & BigInt.from(0x7f)).toInt();
      v >>= 6;
      var done = v == BigInt.zero || v == -BigInt.one;
      if (done) {
        byte &= 0x7f;
      } else {
        v >>= 1;
        byte |= 0x80;
      }
      w.writeUint8(byte);
      if (done) return;
    }
  }

  static BigInt decodeUnsigned(ByteDataReader r) {
    var result = BigInt.zero;
    var shift = 0;
    while (true) {
      final byte = r.readUint8();
      final lowBits = BigInt.from(byte & 0x7f);
      result |= lowBits << shift;
      if ((byte & 0x80) == 0) return result;
      shift += 7;
      if (shift > 8192) {
        throw OnChainErrors.icpCandid(
          "LEB128.decodeUnsigned",
          reason: 'LEB128 unsigned overflow.',
        );
      }
    }
  }

  static BigInt decodeSigned(ByteDataReader r) {
    var result = BigInt.zero;
    var shift = 0;
    late int byte;
    while (true) {
      byte = r.readUint8();
      final lowBits = BigInt.from(byte & 0x7f);
      result |= lowBits << shift;
      shift += 7;
      if ((byte & 0x80) == 0) break;
      if (shift > 8192) {
        throw OnChainErrors.icpCandid(
          "LEB128.decodeSigned",
          reason: 'LEB128 signed overflow.',
        );
      }
    }
    if ((byte & 0x40) != 0) {
      result |= BigInt.from(-1) << shift;
    }
    return result;
  }
}

/// Simple byte buffer writer.
class ByteDataWriter {
  final _bytes = BuBytes.empty();

  void writeUint8(int v) => _bytes.add(v);
  void writeAll(List<int> bytes) => _bytes.addAll(bytes);

  BuBytes toBytes() => _bytes.clone();
  BuBytes buffer() => _bytes;
  int get length => _bytes.length;
}

/// Simple byte buffer reader.
class ByteDataReader {
  final List<int> _data;
  int _pos = 0;

  ByteDataReader(this._data);

  int get position => _pos;
  int get remaining => _data.length - _pos;

  void setPosition(int pos) => _pos = pos;

  int readUint8() {
    if (_pos >= _data.length) {
      throw OnChainErrors.icpCandid(
        "LEB128.readUint8",
        reason: 'Unexpected end of bytes.',
      );
    }
    return _data[_pos++];
  }

  List<int> readBytes(int len) {
    if (_pos + len > _data.length) {
      throw OnChainErrors.icpCandid(
        "LEB128.readBytes",
        reason: 'Not enough bytes.',
      );
    }
    final result = _data.sublist(_pos, _pos + len);
    _pos += len;
    return result;
  }

  int readUint16LE() {
    const len = 2;
    final r = IntUtils.fromBytes(
      _data,
      offset: _pos,
      length: len,
      byteOrder: Endian.little,
    );
    _pos += len;
    return r;
  }

  int readUint32LE() {
    const len = 4;
    final r = IntUtils.fromBytes(
      _data,
      offset: _pos,
      length: len,
      byteOrder: Endian.little,
    );
    _pos += len;
    return r;
  }

  /// Reads 8 little-endian bytes as an unsigned 64-bit integer (BigInt).
  BigInt readUint64LE() {
    const len = 8;
    final r = BigintUtils.fromBytes(
      _data,
      offset: _pos,
      length: len,
      byteOrder: Endian.little,
    );
    _pos += len;
    return r;
  }

  /// Reads 8 little-endian bytes as a signed 64-bit integer (BigInt).
  BigInt readInt64LE() {
    const len = 8;
    final r = BigintUtils.fromBytes(
      _data,
      offset: _pos,
      length: len,
      byteOrder: Endian.little,
      sign: true,
    );
    _pos += len;
    return r;
  }

  double readFloat32LE() {
    return FloatCoder.fromBytes(readBytes(4), byteOrder: Endian.little);
  }

  double readFloat64LE() {
    return DoubleCoder.fromBytes(readBytes(8), byteOrder: Endian.little);
  }
}
