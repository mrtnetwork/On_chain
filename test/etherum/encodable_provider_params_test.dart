import 'package:blockchain_utils/blockchain_utils.dart';
import 'package:on_chain/on_chain.dart';
import 'package:test/test.dart';

import '../utils.dart';

void etherumEncodableProviderParamsTest() {
  group('Ethereum/Encodable provider params', () {
    test('encodable provider params', () {
      final param = EthereumRequestGetChainId();
      final request = param.buildRequest(0);
      final deserialize = EthereumRequestDetails.deserialize(
        bytes: request.toCbor().encode(),
      );
      expect(deserialize.encodeBody(), request.encodeBody());
      expect(deserialize.successStatusCodes, request.successStatusCodes);
      expect(deserialize.errorStatusCodes, request.errorStatusCodes);
      expect(deserialize.network, BlockchainNetwork.ethereum);
      expect(deserialize.responseEncoding, request.responseEncoding);
      expect(deserialize.requestMethod, request.requestMethod);
      expect(deserialize.path, null);
    });
  });
}

void main() {
  OnChainUtilsTestApi.runTest(
    etherumEncodableProviderParamsTest,
    "Encodable Provider Params",
  );
}
