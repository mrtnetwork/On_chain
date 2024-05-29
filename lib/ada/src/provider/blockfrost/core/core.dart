import 'package:blockchain_utils/exception/exception.dart';
import 'package:on_chain/ada/src/provider/blockfrost/models/models/filter_params.dart';
import 'package:on_chain/ada/src/provider/blockfrost/utils/blockforest_provider_utils.dart';
import 'package:on_chain/global_types/provider_request.dart';

/// An abstract class representing request parameters for blockfrost API calls.
abstract class BlockfrostRequestParams {
  /// method for the request.
  abstract final String method;

  /// list of path parameters variable
  abstract final List<String> pathParameters;
}

/// An abstract class representing request parameters for blockfrost (ADA) API calls.
abstract class BlockforestRequestParam<RESULT, RESPONSE>
    implements BlockfrostRequestParams {
  BlockforestRequestParam({this.filter});
  final BlockforestRequestFilter? filter;

  /// Converts the response result to the specified type [RESULT].
  RESULT onResonse(RESPONSE result) {
    return result as RESULT;
  }

  /// Converts the request parameters to [BlockforestRequestDetails] with a unique identifier.
  BlockforestRequestDetails toRequest(int v) {
    final pathParams = BlockforestProviderUtils.extractParams(method);
    if (pathParams.length != pathParameters.length) {
      throw MessageException("Invalid Path Parameters.", details: {
        "pathParams": pathParameters,
        "ExceptedPathParametersLength": pathParams.length
      });
    }
    String params = method;
    for (int i = 0; i < pathParams.length; i++) {
      params = params.replaceFirst(pathParams[i], pathParameters[i]);
    }
    if (filter != null) {
      params = Uri.parse(params)
          .replace(queryParameters: filter!.toJson())
          .normalizePath()
          .toString();
    }
    return BlockforestRequestDetails(id: v, pathParams: params);
  }
}

/// An abstract class representing post request parameters for blockfrost (ADA) API calls.
abstract class BlockforestPostRequestParam<RESULT, RESPONSE>
    extends BlockforestRequestParam<RESULT, RESPONSE> {
  abstract final Object body;

  final Map<String, String>? header = null;

  @override
  BlockforestRequestDetails toRequest(int v) {
    final request = super.toRequest(v);
    return request.copyWith(
        body: body, header: header, requestType: HTTPRequestType.post);
  }
}

/// Represents the details of a blockfrost request.
class BlockforestRequestDetails {
  /// Constructs a new [BlockforestRequestDetails] instance with the specified parameters.
  const BlockforestRequestDetails(
      {required this.id,
      required this.pathParams,
      this.header = const {},
      this.requestType = HTTPRequestType.get,
      this.body});

  BlockforestRequestDetails copyWith({
    int? id,
    String? pathParams,
    HTTPRequestType? requestType,
    Map<String, String>? header,
    Object? body,
  }) {
    return BlockforestRequestDetails(
      id: id ?? this.id,
      pathParams: pathParams ?? this.pathParams,
      requestType: requestType ?? this.requestType,
      header: header ?? this.header,
      body: body ?? this.body,
    );
  }

  /// Unique identifier for the request.
  final int id;

  /// URL path parameters
  final String pathParams;

  final HTTPRequestType requestType;

  final Map<String, String> header;

  final Object? body;

  /// Generates the complete request URL by combining the base URI and method-specific URI.
  String url(String uri, String version) {
    String url = uri;
    if (!url.contains(version)) {
      if (url.endsWith("/")) {
        url = url + version;
      } else {
        url = "$url/$version";
      }
    }
    if (url.endsWith("/")) {
      url = url.substring(0, url.length - 1);
    }

    return "$url$pathParams";
  }
}
