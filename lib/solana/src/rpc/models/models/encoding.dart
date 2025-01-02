import 'package:blockchain_utils/blockchain_utils.dart';
import 'package:on_chain/solana/src/exception/exception.dart';

class SolanaRequestEncoding {
  const SolanaRequestEncoding(this.value);
  final String value;

  static const SolanaRequestEncoding base58 = SolanaRequestEncoding('base58');
  static const SolanaRequestEncoding base64 = SolanaRequestEncoding('base64');
  static const SolanaRequestEncoding jsonParsed =
      SolanaRequestEncoding('jsonParsed');
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
        return StringUtils.encode(data, type: StringEncoding.base64);
    }
  }

  static Tuple<SolanaRequestEncoding, String> _findTypes(dynamic data) {
    if (data is List) {
      if (data.length != 2) {
        throw const SolanaPluginException(
            'Invalid data. Data should be a string, a map, or a list with a length of 2.');
      }
      switch (data[1]) {
        case 'base58':
          return Tuple(SolanaRequestEncoding.base58, data[0]);
        case 'base64':
          return Tuple(SolanaRequestEncoding.base64, data[0]);
        default:
          throw const SolanaPluginException(
              'Unsupported or invalid data types for decoding.');
      }
    }
    if (data is! String) {
      throw const SolanaPluginException(
          'Invalid (base58 or Base64) string. To decode data into bytes, please use SolanaRequestEncoding.base58 or SolanaRequestEncoding.base64.');
    }
    return Tuple(SolanaRequestEncoding.base58, data);
  }

  static List<int> decode(dynamic data, {SolanaRequestEncoding? type}) {
    final correctType = _findTypes(data);
    if (type != null && correctType.item1 != type) {
      throw SolanaPluginException('Incorrect type.',
          details: {'Excepted': correctType.item1, 'type': type});
    }
    return _decode(correctType.item2, correctType.item1);
  }
}
