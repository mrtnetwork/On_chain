/// Class for encoding data using the Recursive Length Prefix (RLP) encoding scheme.
class RLPEncoder {
  /// Encodes an integer value into its RLP representation.
  static List<int> _encodeArray(int value) {
    final List<int> result = [];
    while (value != 0) {
      result.insert(0, value & 0xff);
      value >>= 8;
    }
    return result;
  }

  /// Recursive encoding of the given object using RLP.
  static List<int> _encode(List<dynamic> object) {
    if (object is! List<int>) {
      final List<int> payload = [];
      for (final child in object) {
        payload.addAll(_encode(child));
      }

      if (payload.length <= 55) {
        payload.insert(0, 0xc0 + payload.length);
        return payload;
      }

      final List<int> length = _encodeArray(payload.length);
      length.insert(0, 0xf7 + length.length);
      return [...length, ...payload];
    }

    final List<int> data = List.from(object, growable: true);

    if (data.length == 1 && data[0] <= 0x7f) {
      return data;
    } else if (data.length <= 55) {
      data.insert(0, 0x80 + data.length);
      return data;
    }

    final List<int> length = _encodeArray(data.length);
    length.insert(0, 0xb7 + length.length);

    return [...length, ...data];
  }

  /// Encodes a nested list of objects into its RLP representation.
  static List<int> encode(List<List<dynamic>> object) {
    return _encode(object);
  }
}
