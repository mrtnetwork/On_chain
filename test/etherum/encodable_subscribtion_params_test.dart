import 'package:on_chain/on_chain.dart';
import 'package:test/test.dart';

import '../utils.dart';

void encodableSubscribtionParamsTest() {
  group('Ethereum/Encodable subscription params', () {
    test('encodable subscribtion params', () {
      {
        final param = EthereumRequestETHSubscribeLogs(
          filter: SubscribeLogsFilter(
            address: ETHAddress.zero,
            topics: ["topic_a", "topic_b"],
          ),
        );
        final deserialize = EthereumSubscribionRequest.deserialize(
          bytes: param.toCbor().encode(),
        );
        expect(param.method, deserialize.method);
        expect(
          param.filter?.topics,
          (deserialize as EthereumRequestETHSubscribeLogs).filter?.topics,
        );
      }
      {
        final param = EthereumRequestETHSubscribeNewHeads();
        final deserialize = EthereumSubscribionRequest.deserialize(
          bytes: param.toCbor().encode(),
        );
        expect(param.method, deserialize.method);
      }
      {
        final param = EthereumRequestETHSubscribeNewPendingTransactions();
        final deserialize = EthereumSubscribionRequest.deserialize(
          bytes: param.toCbor().encode(),
        );
        expect(param.method, deserialize.method);
      }
      {
        final param = EthereumRequestETHSubscribeSyncing();
        final deserialize = EthereumSubscribionRequest.deserialize(
          bytes: param.toCbor().encode(),
        );
        expect(param.method, deserialize.method);
      }
    });
  });
}

void main() {
  OnChainUtilsTestApi.runTest(
    encodableSubscribtionParamsTest,
    "Encodable Subscribtion Params",
  );
}
