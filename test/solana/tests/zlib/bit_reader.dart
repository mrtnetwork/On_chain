class BitReader {
  BitReader(List<int> data) : _data = List<int>.unmodifiable(data);
  final List<int> _data;
  int _pos = 0;
  int _byte = 0;
  int _numbits = 0;

  int readByte() {
    _numbits = 0;
    final byte = _data[_pos];
    _pos++;
    return byte;
  }

  int readBit() {
    if (_numbits <= 0) {
      _byte = readByte();
      _numbits = 8;
    }
    _numbits--;
    final bit = _byte & 1;
    _byte >>= 1;
    return bit;
  }

  int readBits(int n) {
    var o = 0;
    for (var i = 0; i < n; i++) {
      o |= readBit() << i;
    }
    return o;
  }

  int readBytes(int n) {
    var o = 0;
    for (var i = 0; i < n; i++) {
      o |= readByte() << (8 * i);
    }
    return o;
  }
}
