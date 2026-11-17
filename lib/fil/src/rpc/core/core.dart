import 'package:blockchain_utils/encoding/encoding.dart';

import 'package:blockchain_utils/helper/extensions/extensions.dart';
import 'package:blockchain_utils/chain/types/network.dart';
import 'package:blockchain_utils/service/service.dart';
import 'package:blockchain_utils/utils/utils.dart';
import 'package:on_chain/exception/onchain_error.dart';

abstract class LotusRequest<
  RESULT,
  RESPONSE,
  R extends LotusFullNodeRequestDetails
>
    extends BaseServiceRequest<RESULT, RESPONSE, R> {
  const LotusRequest();
}

/// An abstract class representing request parameters for Lotus (Filecoin) JSON-RPC calls.
abstract class LotusFullNodeRequest<RESULT, RESPONSE>
    extends LotusRequest<RESULT, RESPONSE, LotusFullNodeRequestDetails> {
  const LotusFullNodeRequest();
  String get jsonRpcMethod;

  List<dynamic> toJson();

  /// Converts the request parameters to [LotusFullNodeRequestDetails] with a unique identifier.
  @override
  LotusFullNodeRequestDetails buildRequest(int id) {
    return LotusFullNodeRequestDetails(
      requestID: id,
      requestMethod: requestMethod,
      bodyBytes: StringUtils.encodeJson(
        ServiceProviderUtils.buildJsonRPCParams(
          requestId: id,
          method: jsonRpcMethod,
          params: toJson(),
        ),
        options: JsonEncodeOptions(bigIntEncoding: BigIntEncoding.intOrString),
      ),
      responseEncoding: ServiceReponseEncoding.map,
      headers: ServiceConst.defaultPostHeaders,
    );
  }

  @override
  RequestMethod get requestMethod => RequestMethod.post;
  ServiceReponseEncoding? get responseEncoding => null;
}

enum LotusProviderApi {
  fullNode(0);

  final int value;
  const LotusProviderApi(this.value);

  static LotusProviderApi fromValue(int? value) {
    return values.firstWhere(
      (e) => e.value == value,

      orElse:
          () =>
              throw OnChainErrors.filPlugin(
                "LotusProviderApi.fromValue",
                reason: "Invalid Lotus provider API value.",
                details: {"value": "$value"},
              ),
    );
  }
}

abstract class BaseLotusServiceRequestParams
    implements BaseServiceRequestParams {
  final LotusProviderApi api;
  const BaseLotusServiceRequestParams(this.api);
  factory BaseLotusServiceRequestParams.deserialize({
    List<int>? bytes,
    CborObject? obj,
  }) {
    final CborTagValue tag = CborTagSerializable.decode(
      cborBytes: bytes,
      cborObject: obj,
    );
    final values = CborTagSerializable.decodeTaggedValue(
      identifier: BlockchainNetwork.filecoin.identifier,
      cborObject: tag,
    );
    final type = LotusProviderApi.fromValue(values.rawValueAt(0));
    return switch (type) {
      LotusProviderApi.fullNode => LotusFullNodeRequestDetails.deserialize(
        obj: tag,
      ),
    };
  }
  @override
  SerializationIdentifier get serializationIdentifier =>
      BlockchainNetwork.filecoin.identifier;
}

class LotusFullNodeRequestDetails extends BaseServiceRequestParams
    implements BaseLotusServiceRequestParams {
  @override
  final LotusProviderApi api = LotusProviderApi.fullNode;
  const LotusFullNodeRequestDetails({
    required super.requestID,
    super.path,
    required super.responseEncoding,
    super.requestMethod = RequestMethod.get,
    super.errorStatusCodes,
    super.headers = const {},
    super.bodyBytes,
  }) : super(bodyString: null, network: BlockchainNetwork.filecoin);

  factory LotusFullNodeRequestDetails.deserialize({
    List<int>? bytes,
    CborObject? obj,
  }) {
    final values = CborTagSerializable.decodeTaggedValue(
      identifier: BlockchainNetwork.filecoin.identifier,
      cborBytes: bytes,
      cborObject: obj,
    );
    return LotusFullNodeRequestDetails(
      headers: values
          .mapAt<CborStringValue, CborStringValue>(1)
          .map((k, v) => MapEntry(k.value, v.value)),
      responseEncoding: ServiceReponseEncoding.fromValue(values.rawValueAt(2)),
      path: values.rawValueAt(3),
      requestID: values.rawValueAt(4),
      requestMethod: RequestMethod.fromValue(values.rawValueAt(5)),
      bodyBytes: values.rawValueAt(6),
      errorStatusCodes:
          values
              .listAt<CborIntValue>(7)
              .map((e) => e.value)
              .toList()
              .emptyAsNull,
    );
  }
  LotusFullNodeRequestDetails copyWith({
    int? requestID,
    String? path,
    Map<String, String>? headers,
    ServiceReponseEncoding? responseEncoding,
    RequestMethod? requestMethod,
    List<int>? bodyBytes,
    List<int>? errorStatusCodes,
  }) {
    return LotusFullNodeRequestDetails(
      requestID: requestID ?? this.requestID,
      headers: headers ?? this.headers,
      path: path ?? this.path,
      responseEncoding: responseEncoding ?? this.responseEncoding,
      requestMethod: requestMethod ?? this.requestMethod,
      bodyBytes: bodyBytes ?? this.bodyBytes,
      errorStatusCodes: errorStatusCodes ?? this.errorStatusCodes,
    );
  }

  @override
  Uri encodeUrl(String uri) {
    return Uri.parse(uri);
  }

  @override
  Map<String, dynamic> toJson() {
    return {
      'path': path,
      'body': bodyString ?? BytesUtils.tryToHexString(bodyBytes),
      "api": api.name,
    };
  }

  @override
  List<CborObject?> get serializationItems => [
    api.value.toCbor(),
    CborMapValue.definite(
      headers.map((k, v) => MapEntry(CborStringValue(k), CborStringValue(v))),
    ),
    responseEncoding.value.toCbor(),
    path?.toCbor(),
    requestID.toCbor(),
    requestMethod.value.toCbor(),
    bodyBytes?.toCborBytes(),
    CborTagSerializable.listFromDynamic(
      errorStatusCodes?.map((e) => CborIntValue(e)).toList() ?? [],
    ),
  ];

  @override
  SerializationIdentifier get serializationIdentifier =>
      BlockchainNetwork.filecoin.identifier;
}
