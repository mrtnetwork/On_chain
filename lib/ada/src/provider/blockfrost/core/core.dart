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
  RequestMethod get requestMethod => RequestMethod.post;

  /// method for the request.
  abstract final String method;

  /// list of path parameters variable
  abstract final List<String> pathParameters;

  /// Converts the request parameters to [BlockFrostRequestDetails] with a unique identifier.
  @override
  BlockFrostRequestDetails buildRequest(int v) {
    final pathParams = BlockFrostProviderUtils.extractParams(method);
    if (pathParams.length != pathParameters.length) {
      throw ADAPluginException(
        'Invalid Path Parameters.',
        details: {
          'pathParams': pathParameters.length.toString(),
          'expectedPathParametersLength': pathParams.length.toString(),
        },
      );
    }
    String params = method;
    for (int i = 0; i < pathParams.length; i++) {
      params = params.replaceFirst(pathParams[i], pathParameters[i]);
    }
    if (filter != null) {
      params =
          Uri.parse(params)
              .replace(queryParameters: filter!.toJson())
              .normalizePath()
              .toString();
    }
    return BlockFrostRequestDetails(
      requestID: v,
      path: params,
      responseEncoding: ServiceReponseEncoding.fromType<RESPONSE>(),
    );
  }
}

/// An abstract class representing post request parameters for blockfrost (ADA) API calls.
abstract class BlockFrostPostRequest<RESULT, RESPONSE>
    extends BlockFrostRequest<RESULT, RESPONSE> {
  abstract final List<int> body;

  Map<String, String>? get headers => null;

  @override
  RequestMethod get requestMethod => RequestMethod.post;

  @override
  BlockFrostRequestDetails buildRequest(int v) {
    final request = super.buildRequest(v);
    return request.copyWith(
      bodyBytes: body,
      headers: headers ?? ServiceConst.defaultPostHeaders,
      requestMethod: requestMethod,
    );
  }
}

/// Represents the details of a blockfrost request.
class BlockFrostRequestDetails extends BaseServiceRequestParams {
  /// Constructs a new [BlockFrostRequestDetails] instance with the specified parameters.
  const BlockFrostRequestDetails({
    required super.requestID,
    required super.path,
    required super.responseEncoding,
    super.headers = const {},
    super.successStatusCodes,
    super.errorStatusCodes = const [400, 402, 403, 404, 418, 425, 429, 500],
    super.requestMethod = RequestMethod.get,
    super.bodyBytes,
    super.bodyString,
  }) : super(network: BlockchainNetwork.cardano);
  factory BlockFrostRequestDetails.deserialize({
    List<int>? bytes,
    CborObject? obj,
  }) {
    final values = CborTagSerializable.decodeTaggedValue(
      identifier: BlockchainNetwork.cardano.identifier,
      cborBytes: bytes,
      cborObject: obj,
    );
    return BlockFrostRequestDetails(
      headers: values
          .mapAt<CborStringValue, CborStringValue>(0)
          .map((k, v) => MapEntry(k.value, v.value)),
      requestMethod: RequestMethod.fromValue(values.rawValueAt(1)),
      responseEncoding: ServiceReponseEncoding.fromValue(values.rawValueAt(2)),
      successStatusCodes:
          values
              .listAt<CborIntValue>(3)
              .map((e) => e.value)
              .toList()
              .emptyAsNull,
      errorStatusCodes:
          values
              .listAt<CborIntValue>(4)
              .map((e) => e.value)
              .toList()
              .emptyAsNull,
      bodyBytes: values.rawValueAt(5),
      bodyString: values.rawValueAt(6),
      path: values.rawValueAt(7),
      requestID: values.rawValueAt(8),
    );
  }
  BlockFrostRequestDetails copyWith({
    int? requestID,
    String? path,
    RequestMethod? requestMethod,
    Map<String, String>? headers,
    List<int>? bodyBytes,
    String? bodyString,
    ServiceReponseEncoding? responseEncoding,
    List<int>? errorStatusCodes,
    List<int>? successStatusCodes,
  }) {
    return BlockFrostRequestDetails(
      requestID: requestID ?? this.requestID,
      headers: headers ?? this.headers,
      path: path ?? this.path,
      responseEncoding: responseEncoding ?? this.responseEncoding,
      requestMethod: requestMethod ?? this.requestMethod,
      bodyString: bodyString ?? this.bodyString,
      errorStatusCodes: errorStatusCodes ?? this.errorStatusCodes,
      bodyBytes: bodyBytes ?? this.bodyBytes,
      successStatusCodes: successStatusCodes ?? this.successStatusCodes,
    );
  }

  @override
  Uri encodeUrl(String uri, {String version = 'v0'}) {
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

    return Uri.parse('$url${path ?? ''}');
  }

  @override
  Map<String, dynamic> toJson() {
    return {'path': path};
  }

  @override
  SerializationIdentifier get serializationIdentifier =>
      BlockchainNetwork.cardano.identifier;

  @override
  List<CborObject?> get serializationItems => [
    CborMapValue.definite(
      headers.map((k, v) => MapEntry(CborStringValue(k), CborStringValue(v))),
    ),
    requestMethod.value.toCbor(),
    responseEncoding.value.toCbor(),
    CborTagSerializable.listFromDynamic(
      successStatusCodes?.map((e) => CborIntValue(e)).toList() ?? [],
    ),
    CborTagSerializable.listFromDynamic(
      errorStatusCodes?.map((e) => CborIntValue(e)).toList() ?? [],
    ),
    bodyBytes?.toCborBytes(),
    bodyString?.toCbor(),
    path?.toCbor(),
    requestID.toCbor(),
  ];
}
