import 'package:blockchain_utils/blockchain_utils.dart';
import 'package:on_chain/ethereum/src/exception/exception.dart';

/// Class for decoding data encoded using the Recursive Length Prefix (RLP) encoding scheme.
class RLPDecoder {
  /// Decode the length of the RLP-encoded data.
  static int _decodeLength(List<int> data, int offset, int length) {
    int result = 0;
    for (int i = 0; i < length; i++) {
      result = (result * 256) + data[offset + i];
    }
    return result;
  }

  /// Decode an RLP-encoded array.
  static _Decoded _decodeArray(
      List<int> data, int offset, int childOffset, int length) {
    List<dynamic> result = [];

    while (childOffset < offset + 1 + length) {
      _Decoded decoded = _decode(data, childOffset);

      result.add(decoded.result);

      childOffset += decoded.consumed;
      if (childOffset > offset + 1 + length) {
        throw const ETHPluginException("child data too short");
      }
    }

    return _Decoded(consumed: (1 + length), result: result);
  }

  /// Decode a single RLP-encoded item.
  static _Decoded _decode(List<int> data, int offset) {
    if (data.isEmpty) {
      throw const ETHPluginException("data too short");
    }

    if (data[offset] >= 0xf8) {
      int lengthLength = data[offset] - 0xf7;
      int length = _decodeLength(data, offset + 1, lengthLength);
      return _decodeArray(
          data, offset, offset + 1 + lengthLength, lengthLength + length);
    } else if (data[offset] >= 0xc0) {
      int length = data[offset] - 0xc0;
      return _decodeArray(data, offset, offset + 1, length);
    } else if (data[offset] >= 0xb8) {
      int lengthLength = data[offset] - 0xb7;
      int length = _decodeLength(data, offset + 1, lengthLength);
      List<int> result = data.sublist(
          offset + 1 + lengthLength, offset + 1 + lengthLength + length);
      return _Decoded(consumed: (1 + lengthLength + length), result: result);
    } else if (data[offset] >= 0x80) {
      int length = data[offset] - 0x80;
      List<int> result = data.sublist(offset + 1, offset + 1 + length);
      return _Decoded(consumed: (1 + length), result: result);
    }

    return _Decoded(consumed: 1, result: [data[offset]]);
  }

  /// Decode an RLP-encoded list of items.
  static List<dynamic> decode(List<int> data) {
    try {
      _Decoded decoded = _decode(data, 0);
      if (decoded.consumed != data.length) {
        throw const ETHPluginException("invalid rpl payload bytes");
      }
      return decoded.result;
    } on MessageException {
      rethrow;
    } catch (e) {
      throw const ETHPluginException("cannot decode rpl payload");
    }
  }
}

/// A private class representing the result of a decoding operation.
class _Decoded {
  final dynamic result;
  final int consumed;
  const _Decoded({required this.result, required this.consumed});
}
