import 'package:blockchain_utils/blockchain_utils.dart';
import 'package:on_chain/hedera/hedera.dart';
import 'package:on_chain/hedera/src/proto_messages/proto/src/query.dart';
import 'package:test/test.dart';

import '../../../utils.dart';
void serializationEncodableProviderParamsTest() {
  group('Hedera/Encodable provider params', () {
    test('Encodable provider params (mirror network fees)', () {
    final param = HederaMirrorRequestGetNetworkFees();
    final request = param.buildRequest(0);
    BaseHederaServiceRequestParams deserialize =
        BaseHederaServiceRequestParams.deserialize(
          bytes: request.toCbor().encode(),
        );
    expect(deserialize.api, HederaProviderApi.mirror);
    deserialize = deserialize as HederaMirrorRequestDetails;
    expect(deserialize.encodeBody(), request.encodeBody());
    expect(deserialize.successStatusCodes, request.successStatusCodes);
    expect(deserialize.errorStatusCodes, request.errorStatusCodes);
    expect(deserialize.network, BlockchainNetwork.hedera);
    expect(deserialize.responseEncoding, request.responseEncoding);
    expect(deserialize.requestMethod, request.requestMethod);
    expect(deserialize.path, request.path);
  });
  test('Encodable provider params (mirror estimate fees)', () {
    final param = HederaMirrorRequestEstimateFees(txBody: [0, 1, 2]);
    final request = param.buildRequest(0);
    BaseHederaServiceRequestParams deserialize =
        BaseHederaServiceRequestParams.deserialize(
          bytes: request.toCbor().encode(),
        );
    expect(deserialize.api, HederaProviderApi.mirror);
    deserialize = deserialize as HederaMirrorRequestDetails;
    expect(deserialize.encodeBody(), [0, 1, 2]);
    expect(deserialize.successStatusCodes, request.successStatusCodes);
    expect(deserialize.errorStatusCodes, request.errorStatusCodes);
    expect(deserialize.network, BlockchainNetwork.hedera);
    expect(deserialize.responseEncoding, request.responseEncoding);
    expect(deserialize.requestMethod, request.requestMethod);
    expect(deserialize.path, request.path);
    expect(deserialize.headers, {"Content-Type": "application/protobuf"});
  });
  test('Encodable provider params (gRPC request)', () {
    final param = HederaGrpcRequestMessage(
      request: HederaServiceFileServiceGetFileContent(),
    );
    final request = param.buildRequest(0);
    BaseHederaServiceRequestParams deserialize =
        BaseHederaServiceRequestParams.deserialize(
          bytes: request.toCbor().encode(),
        );
    expect(deserialize.api, HederaProviderApi.grpc);
    deserialize = deserialize as HederaGrpcRequestDetails;
    expect(deserialize.method(), request.method());
    expect(deserialize.buffer, request.buffer);
    });
  });
}

void main() {
  OnChainUtilsTestApi.runTest(serializationEncodableProviderParamsTest, "Encodable Provider Params");
}

