// icp_http_base.dart

import 'package:blockchain_utils/encoding/encoding.dart';

/// Marker + common interface for every HTTP-interface request content.
abstract class ICPHttpRequest {
  const ICPHttpRequest();

  /// CBOR encode with the mandatory self-describe tag 55799.
  CborTagValue toCbor();

  /// Encode to raw bytes (tag + map).
  List<int> serialize() => toCbor().encode();
}

/// Marker + common interface for every HTTP-interface response body.
abstract class ICPHttpResponse {
  const ICPHttpResponse();
  CborTagValue toCbor();

  List<int> serialize() => toCbor().encode();
}
