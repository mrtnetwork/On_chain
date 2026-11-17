import 'package:blockchain_utils/blockchain_utils.dart';

import 'package:on_chain/sui/src/rpc/core/core.dart';

enum SuiProviderApi {
  jsonRpc(0),
  grpc(1);

  final int value;
  const SuiProviderApi(this.value);

  static SuiProviderApi fromValue(int? value) {
    return values.firstWhere(
      (e) => e.value == value,
      orElse:
          () =>
              throw BuError(
                DefaultErrorType.invalidArgument,
                "Invalid Sui provider API value.",
              ),
    );
  }
}

abstract class BaseSuiServiceRequestParams implements IServiceRequestParams {
  final SuiProviderApi api;
  const BaseSuiServiceRequestParams(this.api);
  factory BaseSuiServiceRequestParams.deserialize({
    List<int>? bytes,
    CborObject? obj,
  }) {
    final CborTagValue tag = CborTagSerializable.decode(
      cborBytes: bytes,
      cborObject: obj,
    );
    final values = CborTagSerializable.decodeTaggedValue(
      identifier: BlockchainNetwork.sui.identifier,
      cborObject: tag,
    );
    final type = SuiProviderApi.fromValue(values.rawValueAt(0));
    return switch (type) {
      SuiProviderApi.jsonRpc => SuiRequestDetails.deserialize(obj: tag),
      SuiProviderApi.grpc => SuiGrpcRequestDetails.deserialize(obj: tag),
    };
  }
  @override
  SerializationIdentifier get serializationIdentifier =>
      BlockchainNetwork.sui.identifier;
}

abstract class SuiGrpcRequest<RESULT>
    extends IGRPCServiceRequest<RESULT, SuiGrpcRequestDetails> {
  const SuiGrpcRequest();

  /// gRPC method path, e.g. `/sui.rpc.v2.LedgerService/GetObject`.
  String get method;

  List<int> toBuffer();

  @override
  SuiGrpcRequestDetails buildRequest(int _) {
    return SuiGrpcRequestDetails(buffer: toBuffer(), requestMethod: method);
  }
}

class SuiGrpcRequestDetails extends BaseSuiServiceRequestParams
    with CborTagSerializable
    implements BaseGRPCServiceRequestParams {
  final String requestMethod;
  final BuBytes buffer;

  SuiGrpcRequestDetails({
    required List<int> buffer,
    required this.requestMethod,
  }) : buffer = buffer.asImmutableBytes,
       super(SuiProviderApi.grpc);
  factory SuiGrpcRequestDetails.deserialize({
    List<int>? bytes,
    CborObject? obj,
  }) {
    final values = CborTagSerializable.decodeTaggedValue(
      identifier: BlockchainNetwork.sui.identifier,
      cborBytes: bytes,
      cborObject: obj,
    );
    return SuiGrpcRequestDetails(
      buffer: values.rawValueAt(1),
      requestMethod: values.rawValueAt(2),
    );
  }

  @override
  String method() {
    return requestMethod;
  }

  @override
  BuBytes toBuffer() {
    return buffer;
  }

  @override
  List<CborObject?> get serializationItems => [
    api.value.toCbor(),
    CborBytesValue(buffer),
    requestMethod.toCbor(),
  ];

  @override
  Uri encodeUrl(String uri) {
    return Uri.parse(uri);
  }
}
