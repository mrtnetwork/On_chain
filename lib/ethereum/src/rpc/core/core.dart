import 'package:on_chain/ethereum/src/models/block_tag.dart';
import 'package:blockchain_utils/blockchain_utils.dart';
import 'package:on_chain/ethereum/src/rpc/methds/subscribes/methods/logs.dart';
import 'package:on_chain/ethereum/src/rpc/methds/subscribes/methods/new_heads.dart';
import 'package:on_chain/ethereum/src/rpc/methds/subscribes/methods/pending_transactions.dart';
import 'package:on_chain/ethereum/src/rpc/methds/subscribes/methods/subscribe.dart';
import 'package:on_chain/ethereum/src/rpc/methds/subscribes/methods/syncing.dart';
import 'package:on_chain/ethereum/src/rpc/methds/subscribes/methods/unsubscribe.dart';
import 'package:on_chain/serialization/identifiers/identifiers.dart';

abstract class EthereumSubscribionRequest
    extends EthereumRequest<String, String>
    with CborTagSerializable
    implements
        BaseServiceSubscribtionRequest<
          String,
          String,
          EthereumGenericSbuscriptionResponse,
          EthereumRequestDetails
        > {
  const EthereumSubscribionRequest();
  factory EthereumSubscribionRequest.deserialize({
    List<int>? bytes,
    CborObject? obj,
  }) {
    final decode = CborTagSerializable.decodeTaggedValueWithInfo(
      expectedTags: [
        OnChainSerializationIdentifiers.ethereumRpcSyncingSubscribtionParams,
        OnChainSerializationIdentifiers.ethereumRpcPendingTxSubscribtionParams,
        OnChainSerializationIdentifiers.ethereumRpcHeadSubscribtionParams,
        OnChainSerializationIdentifiers.ethereumRpcLogSubscribtionParams,
        OnChainSerializationIdentifiers.ethereumRpcGenericSubscribtionParams,
      ],
      cborBytes: bytes,
      cborObject: obj,
    );

    return switch (decode.identifier) {
      OnChainSerializationIdentifiers.ethereumRpcSyncingSubscribtionParams =>
        EthereumRequestETHSubscribeSyncing.deserialize(object: decode.tag),
      OnChainSerializationIdentifiers.ethereumRpcPendingTxSubscribtionParams =>
        EthereumRequestETHSubscribeNewPendingTransactions.deserialize(
          object: decode.tag,
        ),
      OnChainSerializationIdentifiers.ethereumRpcHeadSubscribtionParams =>
        EthereumRequestETHSubscribeNewHeads.deserialize(object: decode.tag),
      OnChainSerializationIdentifiers.ethereumRpcLogSubscribtionParams =>
        EthereumRequestETHSubscribeLogs.deserialize(object: decode.tag),
      OnChainSerializationIdentifiers.ethereumRpcGenericSubscribtionParams =>
        EthereumRequestETHSubscribeGeneric.deserialize(object: decode.tag),
      _ => throw CborSerializableException.incorrectTagValue(),
    };
  }
  @override
  EthereumRequestDetails buildUnsubscribeRequest(
    String identifier,
    int requestID,
  ) {
    return EthereumRequestETHUnsubscribe(identifier).buildRequest(requestID);
  }

  @override
  String? toIdentifier(BaseServiceResponse response) {
    if (response.type == ServiceResponseType.error) return null;
    return response
        .cast<BaseServiceSuccessRespose>()
        .toEncodingResponse<Map<String, dynamic>>(ServiceReponseEncoding.map)
        .valueAsString<String>("result");
  }

  @override
  EthereumGenericSbuscriptionResponse? toEvent(
    String identifier,
    Object? response,
  ) {
    if (response != null &&
        response is Map &&
        response["method"] == "eth_subscription" &&
        response["params"]?["subscription"] == identifier) {
      return EthereumGenericSbuscriptionResponse(
        id: identifier,
        event: JsonParser.valueEnsureAsMap<String, dynamic>(response),
      );
    }
    return null;
  }

  @override
  EthereumGenericSbuscriptionResponse deserializeEvent(List<int> bytes) {
    return EthereumGenericSbuscriptionResponse.deserialize(bytes: bytes);
  }

  @override
  List<CborObject?> get serializationItems => [];
}

/// An abstract class representing Ethereum JSON-RPC requests with generic response types.
abstract class EthereumRequest<RESULT, SERVICERESPONSE>
    extends
        BaseServiceRequest<RESULT, SERVICERESPONSE, EthereumRequestDetails> {
  const EthereumRequest({this.blockNumber});

  // The Ethereum method associated with the request.
  abstract final String method;

  /// Converts the request parameters to a JSON representation.
  List<dynamic> toJson();

  final BlockTagOrNumber? blockNumber;

  /// Converts a dynamic response to a BigInt, handling hexadecimal conversion.
  static BigInt onBigintResponse(dynamic result) {
    if (result == '0x') return BigInt.zero;
    return BigInt.parse(StringUtils.strip0x(result), radix: 16);
  }

  /// Converts a dynamic response to an integer, handling hexadecimal conversion.
  static int onIntResponse(dynamic result) {
    if (result == '0x') return 0;
    return int.parse(StringUtils.strip0x(result), radix: 16);
  }

  /// Converts the request parameters to a [EthereumRequestDetails] object.
  @override
  EthereumRequestDetails buildRequest(int requestId) {
    var inJson = toJson();
    inJson.removeWhere((v) => v == null);
    inJson =
        inJson.map((e) {
          if (e is BlockTagOrNumber) return e.toJson();
          return e;
        }).toList();
    return EthereumRequestDetails(
      requestID: requestId,
      bodyString: StringUtils.fromJson(
        ServiceProviderUtils.buildJsonRPCParams(
          requestId: requestId,
          method: method,
          params: inJson,
        ),
      ),
      method: method,
      headers: ServiceConst.defaultPostHeaders,
      requestMethod: requestMethod,
      responseEncoding: ServiceReponseEncoding.map,
    );
  }

  @override
  RequestMethod get requestMethod => RequestMethod.post;
}

/// Represents the details of an Ethereum JSON-RPC request.
class EthereumRequestDetails extends BaseServiceRequestParams {
  const EthereumRequestDetails({
    required super.requestID,
    super.path,
    required super.responseEncoding,
    required super.headers,
    required this.method,
    super.successStatusCodes,
    super.errorStatusCodes,
    super.requestMethod = RequestMethod.post,
    super.bodyBytes,
    super.bodyString,
  }) : super(network: BlockchainNetwork.ethereum);
  factory EthereumRequestDetails.deserialize({
    List<int>? bytes,
    CborObject? obj,
  }) {
    final values = CborTagSerializable.decodeTaggedValue(
      identifier: BlockchainNetwork.ethereum.identifier,
      cborBytes: bytes,
      cborObject: obj,
    );
    return EthereumRequestDetails(
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
      method: values.rawValueAt(9),
    );
  }
  EthereumRequestDetails copyWith({
    int? requestID,
    String? path,
    RequestMethod? requestMethod,
    Map<String, String>? headers,
    List<int>? bodyBytes,
    String? bodyString,
    ServiceReponseEncoding? responseEncoding,
    List<int>? errorStatusCodes,
    List<int>? successStatusCodes,
    EthereumRequestDetails? api,
    String? method,
  }) {
    return EthereumRequestDetails(
      requestID: requestID ?? this.requestID,
      headers: headers ?? this.headers,
      path: path ?? this.path,
      responseEncoding: responseEncoding ?? this.responseEncoding,
      requestMethod: requestMethod ?? this.requestMethod,
      bodyString: bodyString ?? this.bodyString,
      errorStatusCodes: errorStatusCodes ?? this.errorStatusCodes,
      bodyBytes: bodyBytes ?? this.bodyBytes,
      successStatusCodes: successStatusCodes ?? this.successStatusCodes,
      method: method ?? this.method,
    );
  }

  /// The Ethereum method name for the request.
  final String method;

  @override
  Map<String, dynamic> toJson() {
    return {
      'method': method,
      'body': bodyString,
      'id': requestID,
      'type': requestMethod.name,
    };
  }

  @override
  Uri encodeUrl(String uri) {
    return Uri.parse(uri);
  }

  @override
  List<int>? encodeBody({ServiceProtocol protocol = ServiceProtocol.http}) {
    assert(!protocol.isGrpc, "Unsupported protocol.");
    return super.encodeBody(protocol: protocol);
  }

  @override
  SerializationIdentifier get serializationIdentifier =>
      BlockchainNetwork.ethereum.identifier;

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
    method.toCbor(),
  ];
}

class EthereumGenericSbuscriptionResponse
    with CborTagSerializable
    implements BaseSubscribtionEvent<String> {
  @override
  final String id;
  final Map<String, dynamic> event;
  const EthereumGenericSbuscriptionResponse({
    required this.event,
    required this.id,
  });
  factory EthereumGenericSbuscriptionResponse.deserialize({
    List<int>? bytes,
    CborObject? obj,
  }) {
    final values = CborTagSerializable.decodeTaggedValue(
      identifier: OnChainSerializationIdentifiers.ethereumRpcEvent,
      cborBytes: bytes,
      cborObject: obj,
    );
    return EthereumGenericSbuscriptionResponse(
      id: values.rawValueAt(0),
      event: values.rawMapAt<String, dynamic>(1),
    );
  }
  @override
  SerializationIdentifier get serializationIdentifier =>
      OnChainSerializationIdentifiers.ethereumRpcEvent;

  @override
  List<CborObject?> get serializationItems => [
    id.toCbor(),
    CborTagSerializable.mapToCbor(event),
  ];
}
