import 'package:blockchain_utils/blockchain_utils.dart';

import 'package:on_chain/sui/src/proto_messages/google/protobuf/src/duration.dart';
import 'package:on_chain/sui/src/proto_messages/google/protobuf/src/timestamp.dart';

// Lives here (NOT in the generated files) so regeneration stays clean:
// instance helpers are extensions; static factories live on [SuiWktUtils]
// that `proto/sui/builder.dart` rewrites call sites to (extensions cannot
// add statics). Bodies delegate to the blockchain_utils runtime.
extension SuiTimestampJson on SuiTimestamp {
  String? toRfc3339() {
    final s = seconds;
    if (s == null) return null;
    return ProtoUtils.timestampToRfc3339(s.toInt(), nanos ?? 0);
  }
}

/// Static WKT factories for generated code (see file docs).
abstract final class SuiWktUtils {
  const SuiWktUtils._();

  static SuiTimestamp timestampFromRfc3339(Object? value) {
    if (value == null) {
      throw const BuError(
        DefaultErrorType.invalidArgument,
        'Missing timestamp value.',
      );
    }
    final parsed = ProtoUtils.timestampFromRfc3339(value as String);
    return SuiTimestamp(
      seconds: BigInt.from(parsed.seconds),
      nanos: parsed.nanos,
    );
  }

  static SuiDuration durationFromString(Object? value) {
    final parsed = ProtoGoogleDuration.parseDurationString(value);
    return SuiDuration(seconds: parsed.seconds, nanos: parsed.nanos);
  }
}

extension SuiDurationJson on SuiDuration {
  String? encodeString({bool asNanos = false}) {
    if (seconds == null && nanos == null) return null;
    return ProtoGoogleDuration.formatDuration(seconds, nanos);
  }
}
