import 'package:blockchain_utils/blockchain_utils.dart';
import 'package:on_chain/on_chain.dart';
import 'package:test/test.dart';

void main() {
  test('encodable provider params', () {
    final param = AptosRequestGetAccountAssetResources(
      address: AptosAddress.A,
      assetType: "assetOne",
      ledgetVersion: BigInt.one,
    );
    final request = param.buildRequest(0);
    final deserialize = AptosRequestDetails.deserialize(
      bytes: request.toCbor().encode(),
    );
    expect(deserialize.path, request.path);
    expect(deserialize.encodeBody(), request.encodeBody());
    expect(deserialize.successStatusCodes, request.successStatusCodes);
    expect(deserialize.errorStatusCodes, request.errorStatusCodes);
    expect(deserialize.network, BlockchainNetwork.aptos);
    expect(deserialize.responseEncoding, request.responseEncoding);
    expect(deserialize.requestMethod, request.requestMethod);
    expect(deserialize.requestMethod, request.requestMethod);
  });
  test('encodable provider params', () {
    final param = AptosRequestEncodeSubmission(
      expirationTimestampSecs: DateTime.now().toString(),
      gasUnitPrice: "12",
      maxGasAmount: "13",
      payload: "1",
      sender: AptosAddress.A,
      sequenceNumber: "12",
      secondarySigners: [AptosAddress.four.address],
    );
    final request = param.buildRequest(0);
    final deserialize = AptosRequestDetails.deserialize(
      bytes: request.toCbor().encode(),
    );
    expect(deserialize.path, request.path);
    expect(deserialize.encodeBody(), request.encodeBody());
    expect(deserialize.successStatusCodes, request.successStatusCodes);
    expect(deserialize.errorStatusCodes, request.errorStatusCodes);
    expect(deserialize.network, BlockchainNetwork.aptos);
    expect(deserialize.responseEncoding, request.responseEncoding);
    expect(deserialize.requestMethod, request.requestMethod);
    expect(deserialize.requestMethod, request.requestMethod);
  });
  test('encodable provider params', () {
    final param = AptosGraphQLRequestGetAccountCoinsData(
      variables: AptosGraphQLPaginatedWithOrderVariablesParams(
        offset: 12,
        limit: 3,
      ),
    );
    final request = param.buildRequest(0);
    final deserialize = AptosRequestDetails.deserialize(
      bytes: request.toCbor().encode(),
    );
    expect(deserialize.path, request.path);
    expect(deserialize.encodeBody(), request.encodeBody());
    expect(deserialize.successStatusCodes, request.successStatusCodes);
    expect(deserialize.errorStatusCodes, request.errorStatusCodes);
    expect(deserialize.network, BlockchainNetwork.aptos);
    expect(deserialize.responseEncoding, request.responseEncoding);
    expect(deserialize.requestMethod, request.requestMethod);
    expect(deserialize.requestMethod, request.requestMethod);
  });
}
