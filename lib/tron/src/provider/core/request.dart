import 'dart:convert';

import 'package:on_chain/tron/src/address/tron_address.dart';
import 'package:on_chain/tron/src/provider/methods/request_methods.dart';

/// An abstract class representing request parameters for Tron API calls.
abstract class TronRequestParams<RESPONSE, RESULT> {
  /// method for the request.
  abstract final TronHTTPMethods method;

  /// Converts the request parameters to a JSON format.
  Map<String, dynamic> toJson();
}

/// An abstract class representing request parameters for TVM (Tron Virtual Machine) API calls.
abstract class TVMRequestParam<RESULT, RESPONSE> implements TronRequestParams {
  /// Indicates whether the address is visible.
  bool? get visible => null;

  /// Converts the response result to the specified type [RESULT].
  RESULT onResonse(RESPONSE result) {
    return result as RESULT;
  }

  /// Converts the request parameters to [TronRequestDetails] with a unique identifier.
  TronRequestDetails toRequest(int _) {
    final inJson = toJson();
    inJson.removeWhere((key, value) => value == null);
    final Map<String, BigInt> replace = {};
    int id = 0;
    final encoder = JsonEncoder(
      (object) {
        if (object is TronAddress) {
          return object.toAddress(visible ?? true);
        }
        object as BigInt;
        if (object.isValidInt) {
          return object.toInt();
        }
        id++;
        final n = "$id#${object.toString()}";
        replace[n] = object;

        return n;
      },
    );

    String encode = encoder.convert(inJson);
    for (final i in replace.entries) {
      encode = encode.replaceFirst('"${i.key}"', "${i.value}");
    }
    return TronRequestDetails(id: id, method: method, params: encode);
  }
}

/// Represents the details of a Tron network request.
class TronRequestDetails {
  /// Constructs a new [TronRequestDetails] instance with the specified parameters.
  const TronRequestDetails({
    required this.id,
    required this.method,
    required this.params,
  });

  /// Unique identifier for the request.
  final int id;

  /// method for the request.
  final TronHTTPMethods method;

  /// Request parameters encoded as a JSON-formatted string.
  final String params;

  /// Gets the request body as a string.
  String toRequestBody() {
    return params;
  }

  /// Generates the complete request URL by combining the base URI and method-specific URI.
  String url(String uri) {
    if (uri.endsWith("/")) return "$uri${method.uri}";
    return "$uri/${method.uri}";
  }
}
