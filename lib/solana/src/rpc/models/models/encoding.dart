import 'package:blockchain_utils/blockchain_utils.dart';

class SolanaRPCEncoding {
  const SolanaRPCEncoding(this.value);
  final String value;

  static const SolanaRPCEncoding base58 = SolanaRPCEncoding("base58");
  static const SolanaRPCEncoding base64 = SolanaRPCEncoding("base64");
  static const SolanaRPCEncoding jsonParsed = SolanaRPCEncoding("jsonParsed");
  @override
  String toString() {
    return value;
  }

  Map<String, dynamic> toJson() {
    return {"encoding": value};
  }

  static List<int> _decode(String data, SolanaRPCEncoding type) {
    switch (type) {
      case SolanaRPCEncoding.base58:
        return Base58Decoder.decode(data);
      default:
        return StringUtils.encode(data, StringEncoding.base64);
    }
  }

  static Tuple<SolanaRPCEncoding, String> _findTypes(dynamic data) {
    if (data is List) {
      if (data.length != 2) {
        throw const MessageException(
            "Invalid data. Data should be a string, a map, or a list with a length of 2.");
      }
      switch (data[1]) {
        case "base58":
          return Tuple(SolanaRPCEncoding.base58, data[0]);
        case "base64":
          return Tuple(SolanaRPCEncoding.base64, data[0]);
        default:
          throw const MessageException(
              "Unsupported or invalid data types for decoding.");
      }
    }
    if (data is! String) {
      throw const MessageException(
          "Invalid (base58 or Base64) string. To decode data into bytes, please use SolanaRPCEncoding.base58 or SolanaRPCEncoding.base64.");
    }
    return Tuple(SolanaRPCEncoding.base58, data);
  }

  static List<int> decode(dynamic data, {SolanaRPCEncoding? type}) {
    final correctType = _findTypes(data);
    if (type != null && correctType.item1 != type) {
      throw MessageException("Incorrect type.",
          details: {"Excepted": correctType.item1, "type": type});
    }
    return _decode(correctType.item2, correctType.item1);
  }
}
