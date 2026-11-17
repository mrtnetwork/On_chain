import 'package:blockchain_utils/blockchain_utils.dart';
import 'package:on_chain/exception/onchain_error.dart';

class TezosOctezCodecUtils {
  static dynamic encodeString(List<int> bytes) {
    try {
      return StringUtils.decode(bytes);
    } catch (_) {
      return {"invalid_utf8_string": bytes};
    }
  }

  static List<int> decodeString(dynamic str) {
    try {
      if (str is String) return StringUtils.encode(str);
      return JsonParser.valueEnsureAsMap<String, dynamic>(
        str,
      ).valueEnsureAsList<int>("invalid_utf8_string");
    } catch (_) {
      throw OnChainErrors.tezosPlugin(
        "octezBinaryToString",
        reason: "Invalid octez json string.",
      );
    }
  }

  static String encodeIsoSecondTimestamp(BigInt seconds) {
    final datetime =
        DateTime.fromMillisecondsSinceEpoch(
          (seconds * BigInt.from(1000)).asSafeInt,
        ).toUtc();
    return '${datetime.year.toString().padLeft(4, '0')}-'
        '${datetime.month.toString().padLeft(2, '0')}-'
        '${datetime.day.toString().padLeft(2, '0')}T'
        '${datetime.hour.toString().padLeft(2, '0')}:'
        '${datetime.minute.toString().padLeft(2, '0')}:'
        '${datetime.second.toString().padLeft(2, '0')}Z';
  }

  static BigInt isoDateTimetoSecond(String timestamp) {
    final seconds =
        DateTime.parse(timestamp).toUtc().millisecondsSinceEpoch ~/ 1000;
    return BigInt.from(seconds);
  }
}
