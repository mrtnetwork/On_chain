import 'package:blockchain_utils/blockchain_utils.dart';
import 'package:on_chain/ada/src/exception/exception.dart';
import 'package:on_chain/ada/src/provider/blockfrost/models/models/filter_params.dart';
import 'package:on_chain/ada/src/provider/blockfrost/utils/blockforest_provider_utils.dart';

/// An abstract class representing request parameters for blockfrost (ADA) API calls.
abstract class BlockFrostRequest<RESULT, RESPONSE>
    extends BaseServiceRequest<RESULT, RESPONSE, BlockFrostRequestDetails> {
  BlockFrostRequest({this.filter});
  final BlockFrostRequestFilter? filter;

  @override
  RequestServiceType get requestType => RequestServiceType.post;

  /// method for the request.
  abstract final String method;

  /// list of path parameters variable
  abstract final List<String> pathParameters;

  /// Converts the request parameters to [BlockFrostRequestDetails] with a unique identifier.
  @override
  BlockFrostRequestDetails buildRequest(int v) {
    final pathParams = BlockFrostProviderUtils.extractParams(method);
    if (pathParams.length != pathParameters.length) {
      throw ADAPluginException('Invalid Path Parameters.', details: {
        'pathParams': pathParameters,
        'expectedPathParametersLength': pathParams.length
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
    return BlockFrostRequestDetails(requestID: v, pathParams: params);
  }
}

/// An abstract class representing post request parameters for blockfrost (ADA) API calls.
abstract class BlockFrostPostRequest<RESULT, RESPONSE>
    extends BlockFrostRequest<RESULT, RESPONSE> {
  abstract final List<int> body;

  Map<String, String>? get headers => null;

  @override
  RequestServiceType get requestType => RequestServiceType.post;

  @override
  BlockFrostRequestDetails buildRequest(int v) {
    final request = super.buildRequest(v);
    return request.copyWith(
        params: body,
        headers: headers ?? ServiceConst.defaultPostHeaders,
        type: requestType);
  }
}

/// Represents the details of a blockfrost request.
class BlockFrostRequestDetails extends BaseServiceRequestParams {
  /// Constructs a new [BlockFrostRequestDetails] instance with the specified parameters.
  const BlockFrostRequestDetails(
      {required super.requestID,
      required this.pathParams,
      super.headers = const {},
      RequestServiceType requestType = RequestServiceType.get,
      this.params})
      : super(type: requestType);

  BlockFrostRequestDetails copyWith(
      {int? requestID,
      String? pathParams,
      RequestServiceType? type,
      Map<String, String>? headers,
      List<int>? params}) {
    return BlockFrostRequestDetails(
      requestID: requestID ?? this.requestID,
      pathParams: pathParams ?? this.pathParams,
      requestType: type ?? this.type,
      headers: headers ?? this.headers,
      params: params ?? this.params,
    );
  }

  /// URL path parameters
  final String pathParams;

  final List<int>? params;

  @override
  List<int>? body() {
    return params;
  }

  @override
  Uri toUri(String uri, {String version = 'v0'}) {
    String url = uri;
    if (!url.contains(version)) {
      if (url.endsWith('/')) {
        url = url + version;
      } else {
        url = '$url/$version';
      }
    }
    if (url.endsWith('/')) {
      url = url.substring(0, url.length - 1);
    }

    return Uri.parse('$url$pathParams');
  }

  @override
  Map<String, dynamic> toJson() {
    return {
      'pathParameters': pathParams,
      'body': BytesUtils.tryToHexString(params)
    };
  }
}
