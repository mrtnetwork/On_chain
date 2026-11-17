// Offline replay of captured gRPC binary responses (base64).
// Proves the proto shapes against real wire data. No network.
@TestOn('vm')
library;
import 'dart:io';

import 'package:blockchain_utils/blockchain_utils.dart';
import 'package:on_chain/on_chain.dart';
import 'package:test/test.dart';

import '../utils.dart';
List<int> _fixture(String name) {
  final file = File('test/sui/test_vectors/grpc/$name.b64');
  return StringUtils.encode(file.readAsStringSync().trim(), encoding: StringEncoding.base64);
}

void suiGrpcFixturesTest() {
  group('Sui/Grpc fixtures (needs dart:io)', () {
  group('Sui/Grpc fixtures (offline, real wire bytes)', () {
    test('service info carries chain id', () {
      final info = SuiGetServiceInfoResponse.deserialize(_fixture('service_info'));
      expect(info.chainId, isNotEmpty);
    });

    test('epoch carries gas price', () {
      final epoch = SuiGetEpochResponse.deserialize(_fixture('epoch'));
      expect(epoch.epoch, isNotNull);
      expect(
        epoch.epoch!.referenceGasPrice,
        greaterThan(BigInt.zero),
      );
    });

    test('balances parse', () {
      final balances = SuiListBalancesResponse.deserialize(
        _fixture('balances'),
      );
      expect(balances.balances, isNotEmpty);
      expect(balances.balances.first.balance, greaterThan(BigInt.zero));
      expect(balances.balances.first.coinType, isNotEmpty);
    });

    test('coin info carries metadata', () {
      final info = SuiGetCoinInfoResponse.deserialize(_fixture('coin_info'));
      final meta = info.metadata;
      expect(meta, isNotNull);
      expect(meta!.symbol, 'SUI');
      expect(meta.decimals, 9);
    });

    test('object parses with owner', () {
      final response = SuiGetObjectResponse.deserialize(_fixture('object'));
      final object = response.object!;
      expect(object.objectId, isNotEmpty);
      expect(object.owner, isNotNull);
    });

    test('executed tx parses with effects', () {
      final response = SuiGetTransactionResponse.deserialize(
        _fixture('transaction'),
      );
      final tx = response.transaction!;
      expect(tx.digest, isNotEmpty);
      expect(tx.effects?.status?.success, isTrue);
      expect(tx.effects?.gasUsed?.computationCost, greaterThan(BigInt.zero));
      expect(tx.events?.events, isNotEmpty);
      expect(tx.balanceChanges, isNotEmpty);
    });

    test('simulate parses with gas used', () {
      final response = SuiSimulateTransactionResponse.deserialize(
        _fixture('simulate'),
      );
      expect(
        response.transaction?.effects?.gasUsed?.computationCost,
        greaterThan(BigInt.zero),
      );
    });
  });
  }, skip: !native ? 'filesystem fixtures unavailable' : null);
}

void main() {
  OnChainUtilsTestApi.runTest(suiGrpcFixturesTest, "Sui Grpc Fixtures");
}
