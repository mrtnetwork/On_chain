import 'package:blockchain_utils/blockchain_utils.dart';
import 'package:on_chain/aptos/src/exception/exception.dart';
import 'package:on_chain/aptos/src/provider/constant/constants.dart';
import 'package:on_chain/aptos/src/provider/utils/utils.dart';

abstract class AptosRequest<RESULT, RESPONSE>
    extends BaseServiceRequest<RESULT, RESPONSE, AptosRequestDetails> {
  AptosRequest();

  @override
  RequestServiceType get requestType => RequestServiceType.post;

  abstract final String method;

  List<String> get pathParameters => [];
  Map<String, String?> get queryParameters => {};

  @override
  AptosRequestDetails buildRequest(int requestID) {
    final pathParams = AptosProviderUtils.extractParams(method);
    if (pathParams.length != pathParameters.length) {
      throw DartAptosPluginException('Invalid Path Parameters.', details: {
        'pathParams': pathParameters,
        'ExceptedPathParametersLength': pathParams.length
      });
    }
    String params = method;
    for (int i = 0; i < pathParams.length; i++) {
      params = params.replaceFirst(pathParams[i], pathParameters[i]);
    }
    return AptosRequestDetails(requestID: requestID, pathParams: params);
  }
}

abstract class AptosPostRequest<RESULT, RESPONSE>
    extends AptosRequest<RESULT, RESPONSE> {
  abstract final Object body;

  Map<String, String>? get headers => null;

  @override
  RequestServiceType get requestType => RequestServiceType.post;

  @override
  AptosRequestDetails buildRequest(int requestID) {
    final request = super.buildRequest(requestID);
    List<int> body = [];
    if (this.body is List<int>) {
      body = this.body as List<int>;
    } else {
      body = StringUtils.encode(StringUtils.fromJson(this.body));
    }
    return request.copyWith(
        params: body,
        headers: headers ?? ServiceConst.defaultPostHeaders,
        type: requestType);
  }
}

class AptosRequestDetails extends BaseServiceRequestParams {
  const AptosRequestDetails(
      {required super.requestID,
      required this.pathParams,
      super.headers = const {},
      RequestServiceType requestType = RequestServiceType.get,
      this.params})
      : super(
            type: requestType,
            errorStatusCodes: AptosProviderConst.errorStatusCodes,
            successStatusCodes: AptosProviderConst.successStatusCodes);

  AptosRequestDetails copyWith(
      {int? requestID,
      String? pathParams,
      RequestServiceType? type,
      Map<String, String>? headers,
      List<int>? params}) {
    return AptosRequestDetails(
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
  Uri toUri(String uri, {String version = 'v1'}) {
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
