import 'package:blockchain_utils/blockchain_utils.dart';
import 'package:on_chain/tezos/tezos.dart';
import 'package:test/test.dart';

import '../utils.dart';

void tezosEncodableProviderParamsTest() {
  group('Tezos/Encodable provider params', () {
    test('encodable provider params', () {
      {
        final param = OctezUshuaiaRequestContextAdaptiveIssuanceLaunchCycle();
        final request = param.buildRequest(0);
        final deserialize = BaseOctezServiceRequestParams.deserialize(
          bytes: request.toCbor().encode(),
        );
        expect(deserialize.encodeBody(), request.encodeBody());
        expect(deserialize.successStatusCodes, request.successStatusCodes);
        expect(deserialize.errorStatusCodes, request.errorStatusCodes);
        expect(deserialize.network, BlockchainNetwork.tezos);
        expect(deserialize.responseEncoding, request.responseEncoding);
        expect(deserialize.requestMethod, request.requestMethod);
        expect(deserialize.path, request.path);
        expect(deserialize.api, OctezApiType.ushuaia);
      }
      {
        final param = OctezMempoolRequestUnbanAllOperations(
          requestBody: OctezMempoolResponseRequestOperations(),
        );
        final request = param.buildRequest(0);
        final deserialize = BaseOctezServiceRequestParams.deserialize(
          bytes: request.toCbor().encode(),
        );
        expect(deserialize.encodeBody(), request.encodeBody());
        expect(deserialize.successStatusCodes, request.successStatusCodes);
        expect(deserialize.errorStatusCodes, request.errorStatusCodes);
        expect(deserialize.network, BlockchainNetwork.tezos);
        expect(deserialize.responseEncoding, request.responseEncoding);
        expect(deserialize.requestMethod, request.requestMethod);
        expect(deserialize.path, request.path);
        expect(deserialize.api, OctezApiType.mempool);
      }
      final param = OctezRollupRequestHealth();
      final request = param.buildRequest(0);
      final deserialize = BaseOctezServiceRequestParams.deserialize(
        bytes: request.toCbor().encode(),
      );
      expect(deserialize.encodeBody(), request.encodeBody());
      expect(deserialize.successStatusCodes, request.successStatusCodes);
      expect(deserialize.errorStatusCodes, request.errorStatusCodes);
      expect(deserialize.network, BlockchainNetwork.tezos);
      expect(deserialize.responseEncoding, request.responseEncoding);
      expect(deserialize.requestMethod, request.requestMethod);
      expect(deserialize.path, request.path);
      expect(deserialize.api, OctezApiType.rollup);
    });
  });
}

void main() {
  OnChainUtilsTestApi.runTest(
    tezosEncodableProviderParamsTest,
    "Encodable Provider Params",
  );
}
