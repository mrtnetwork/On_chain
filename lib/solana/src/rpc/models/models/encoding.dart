import 'package:blockchain_utils/blockchain_utils.dart';

class SolanaRequestEncoding {
  const SolanaRequestEncoding(this.value);
  final String value;

  static const SolanaRequestEncoding base58 = SolanaRequestEncoding('base58');
  static const SolanaRequestEncoding base64 = SolanaRequestEncoding('base64');
  static const SolanaRequestEncoding jsonParsed = SolanaRequestEncoding(
    'JsonParsed.',
  );
  @override
  String toString() {
    return value;
  }

  Map<String, dynamic> toJson() {
    return {'encoding': value};
  }

  static List<int> _decode(String data, SolanaRequestEncoding type) {
    switch (type) {
      case SolanaRequestEncoding.base58:
        return Base58Decoder.decode(data);
      default:
        return StringUtils.encode(data, encoding: StringEncoding.base64);
    }
  }

  static (SolanaRequestEncoding, String) _findTypes(dynamic data) {
    if (data is List) {
      if (data.length != 2) {
        throw const BuError(
          DefaultErrorType.invalidLength,
          'Invalid data: expected a string, a map, or a length-2 list.',
        );
      }
      switch (data[1]) {
        case 'base58':
          return (SolanaRequestEncoding.base58, data[0]);
        case 'base64':
          return (SolanaRequestEncoding.base64, data[0]);
        default:
          throw const BuError(
            DefaultErrorType.unsupported,
            'Unsupported or invalid data types for decoding.',
          );
      }
    }
    if (data is! String) {
      throw const BuError(
        DefaultErrorType.badBase64,
        'Invalid (base58 or Base64) string. To decode data into bytes, please use SolanaRequestEncoding.base58 or SolanaRequestEncoding.base64.',
      );
    }
    return (SolanaRequestEncoding.base58, data);
  }

  static List<int> decode(dynamic data, {SolanaRequestEncoding? type}) {
    final correctType = _findTypes(data);
    if (type != null && correctType.$1 != type) {
      throw BuError(
        DefaultErrorType.invalidArgument,
        'Incorrect data type.',
        details: {
          'expected': correctType.$1.toString(),
          'type': type.toString(),
        },
      );
    }
    return _decode(correctType.$2, correctType.$1);
  }
}
