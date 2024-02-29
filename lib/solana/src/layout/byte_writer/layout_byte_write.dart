import 'package:blockchain_utils/binary/binary.dart';

/// A utility class for writing layout bytes dynamically.
class LayoutByteWriter {
  final bool growable;
  static const int maxPackedSize = 2048;
  LayoutByteWriter(int span)
      : _buffer = span > 0 ? List.filled(span, 0) : List.empty(growable: true),
        growable = span < 0;

  LayoutByteWriter.filled(int length, [int value = 0])
      : _buffer = List.filled(length, value),
        growable = false;
  LayoutByteWriter.fromHex(String hexBytes)
      : _buffer = BytesUtils.fromHexString(hexBytes),
        growable = false;
  LayoutByteWriter.from(List<int> bytes)
      : _buffer = BytesUtils.toBytes(bytes),
        growable = false;
  final List<int> _buffer;

  /// Get the last byte in the tracked bytes.
  int get last => _buffer.last;

  /// buffer bytes.
  List<int> toBytes() {
    return List<int>.from(_buffer);
  }

  List<int> sublist(int start, [int? end]) {
    return _buffer.sublist(start, end);
  }

  int get length => _buffer.length;

  void _filled(int end) {
    if (growable) {
      if (end > _buffer.length) {
        final filled = end - (_buffer.length);
        _buffer.addAll(List<int>.filled(filled, 0, growable: true));
      }
    }
  }

  void setAll(int index, List<int> bytes) {
    _filled(index + bytes.length);
    _buffer.setAll(index, bytes);
  }

  void setRange(int start, int end, List<int> iterable) {
    _filled(end);
    _buffer.setRange(start, end, BytesUtils.toBytes(iterable));
  }

  void set(int offset, int value) {
    _filled(offset);
    _buffer[offset] = value & mask8;
  }

  void fillRange(
    int start,
    int end,
    int value,
  ) {
    _filled(end);
    _buffer.fillRange(start, end, value & mask8);
  }

  int at(int pos) => _buffer[pos];
}
