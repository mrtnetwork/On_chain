import 'package:blockchain_utils/blockchain_utils.dart';
import 'package:on_chain/near/src/rpc/rpc.dart';
import 'package:test/test.dart';

import '../../utils.dart';

void nearSerializationEncodableProviderParamsTest() {
  group('NEAR/Encodable provider params', () {
    test('encodable provider params', () {
      final param = NearNodeRequestExperimentalReceipt(
        NearRpcRpcReceiptRequest(receiptId: "receiptId"),
      );
      final request = param.buildRequest(0);
      final deserialize = NearRequestDetails.deserialize(
        bytes: request.toCbor().encode(),
      );
      expect(deserialize.encodeBody(), request.encodeBody());
      expect(deserialize.successStatusCodes, request.successStatusCodes);
      expect(deserialize.errorStatusCodes, request.errorStatusCodes);
      expect(deserialize.network, BlockchainNetwork.near);
      expect(deserialize.responseEncoding, request.responseEncoding);
      expect(deserialize.requestMethod, request.requestMethod);
      expect(deserialize.path, request.path);
    });
  });
}

void main() {
  OnChainUtilsTestApi.runTest(
    nearSerializationEncodableProviderParamsTest,
    "Encodable Provider Params",
  );
}
