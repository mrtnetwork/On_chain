import 'package:blockchain_utils/blockchain_utils.dart';
import 'package:on_chain/fil/src/rpc/core/core.dart';
import 'package:on_chain/fil/src/rpc/methods/full_node/full_node.dart';
import 'package:test/test.dart';

import '../../utils.dart';

void testEncodableProviderParamsTest() {
  group('Filecoin/Encodable provider params', () {
    test('Encodable provider params', () {
      final param = LotusFullNodeRequestNetVersion();
      final request = param.buildRequest(0);
      final deserialize = BaseLotusServiceRequestParams.deserialize(
        bytes: request.toCbor().encode(),
      );
      expect(deserialize.encodeBody(), request.encodeBody());
      expect(deserialize.successStatusCodes, request.successStatusCodes);
      expect(deserialize.errorStatusCodes, request.errorStatusCodes);
      expect(deserialize.network, BlockchainNetwork.filecoin);
      expect(deserialize.responseEncoding, request.responseEncoding);
      expect(deserialize.requestMethod, request.requestMethod);
      expect(deserialize.path, request.path);
    });
  });
}

void main() {
  OnChainUtilsTestApi.runTest(
    testEncodableProviderParamsTest,
    "Encodable Provider Params",
  );
}
