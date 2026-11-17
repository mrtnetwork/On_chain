import 'package:blockchain_utils/blockchain_utils.dart';
import 'package:on_chain/icp/src/icp.dart';
import 'package:test/test.dart';

import '../../utils.dart';

void icpSerializationEncodableProviderParamsTest() async {
  group('ICP/Encodable provider params', () {
    test('Encodable provider params (canister query)', () async {
    final param = ICPRequestCanisterQuery(
      message: LEDGERQueryArchives(),
      params: ICPRequestQueryParams.anonymous(IcpPrincipalAddress.management),
    );
    final request = await param.buildRequest(0);
    ICPRequestDetails deserialize = ICPRequestDetails.deserialize(
      bytes: request.toCbor().encode(),
    );
    expect(deserialize.encodeBody(), request.encodeBody());
    expect(deserialize.successStatusCodes, request.successStatusCodes);
    expect(deserialize.errorStatusCodes, request.errorStatusCodes);
    expect(deserialize.network, BlockchainNetwork.icp);
    expect(deserialize.responseEncoding, request.responseEncoding);
    expect(deserialize.requestMethod, RequestMethod.post);
    expect(deserialize.path, request.path);
  });
  test('Encodable provider params (status)', () async {
    final param = ICPRequestStatus();
    final request = await param.buildRequest(0);
    ICPRequestDetails deserialize = ICPRequestDetails.deserialize(
      bytes: request.toCbor().encode(),
    );
    expect(deserialize.encodeBody(), null);
    expect(deserialize.successStatusCodes, request.successStatusCodes);
    expect(deserialize.errorStatusCodes, request.errorStatusCodes);
    expect(deserialize.network, BlockchainNetwork.icp);
    expect(deserialize.responseEncoding, request.responseEncoding);
    expect(deserialize.requestMethod, RequestMethod.get);
    expect(deserialize.path, request.path);
    });
  });
}

void main() {
  OnChainUtilsTestApi.runTest(
    icpSerializationEncodableProviderParamsTest,
    "Encodable Provider Params",
  );
}
