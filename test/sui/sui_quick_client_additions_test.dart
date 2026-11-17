// Offline tests for the SuiQuickClientApi additions (streams, suix reads,
// dry-run budget, submit/track/status, height, validators). gRPC stubs
// build real response objects; JSON-RPC stubs replay fixtures.
//
// VM-only: reads fixture files via `dart:io` (same as `sui_fixtures_test`).
@TestOn('vm')
library;
import 'dart:async';
import 'package:on_chain/exception/onchain_error.dart';
import 'dart:io';

import 'package:blockchain_utils/blockchain_utils.dart';
import 'package:on_chain/on_chain.dart';
import 'package:test/test.dart';

import '../utils.dart';

const String _owner = '0x0000000000000000000000000000000000000000000000000000000000000001';

Map<String, dynamic> _txFixture() {
  final raw = File('test/sui/test_vectors/live/tx.json').readAsStringSync();
  return StringUtils.toJson<Map<String, dynamic>>(raw);
}

class _StubSuiService with SuiServiceProvider {
  final Object? Function(String method) respondJson;
  final List<int> Function(String method) respondGrpc;
  _StubSuiService({required this.respondJson, required this.respondGrpc});

  @override
  Future<BaseServiceResponse> doRequest(
    BaseSuiServiceRequestParams params, {
    Duration? timeout,
  }) async {
    final details = params as SuiRequestDetails;
    final result = respondJson(details.method);
    if (result is Exception) throw result;
    return params.toResponse({
      'jsonrpc': '2.0',
      'id': params.requestID,
      'result': result,
    });
  }

  @override
  Future<List<int>> doGrpcRequest(
    BaseGRPCServiceRequestParams params, {
    Duration? timeout,
  }) async {
    final details = params as SuiGrpcRequestDetails;
    return respondGrpc(details.method());
  }

  @override
  Stream<List<int>> doGrpcRequestStream(
    BaseGRPCServiceRequestParams params, {
    Duration? timeout,
  }) {
    throw UnsupportedError('not supported in stubs.');
  }

  @override
  Future<Stream<List<int>>> doGrpcRequestStreamAsync(
    BaseGRPCServiceRequestParams params, {
    Duration? timeout,
  }) {
    throw UnsupportedError('not supported in stubs.');
  }
}

DefaultSuiQuickClient _quick({
  required Object? Function(String method) respondJson,
  required List<int> Function(String method) respondGrpc,
}) {
  return DefaultSuiQuickClient(
    provider: SuiProvider(
      _StubSuiService(respondJson: respondJson, respondGrpc: respondGrpc),
    ),
  );
}

DefaultSuiQuickClient _grpcOnly(List<int> Function(String method) respondGrpc) {
  return _quick(
    respondJson: (method) => throw StateError('json-rpc unused: $method'),
    respondGrpc: respondGrpc,
  );
}

SuiTransactionDataV1 _tx() {
  return SuiTransactionDataV1(
    expiration: const SuiTransactionExpirationNone(),
    sender: SuiAddress(_owner),
    gasData: SuiGasData(
      payment: const [],
      owner: SuiAddress(_owner),
      price: BigInt.from(1000),
      budget: BigInt.from(50000000),
    ),
    kind: SuiTransactionKindProgrammableTransaction(
      SuiProgrammableTransaction(inputs: const [], commands: const []),
    ),
  );
}

void suiQuickClientAdditionsTest() {
  group('Sui/QuickClientApi additions (offline)', () {
    test('watchAccountBalances streams pages', () async {
      var calls = 0;
      final quick = _grpcOnly((method) {
        if (++calls == 1) {
          return SuiListBalancesResponse(
            balances: [
              SuiBalance(coinType: '0x2::sui::SUI', balance: BigInt.from(100)),
            ],
            nextPageToken: [1],
          ).toBuffer().toList();
        }
        return SuiListBalancesResponse(
          balances: [
            SuiBalance(coinType: '0x2::foo::FOO', balance: BigInt.from(50)),
          ],
        ).toBuffer().toList();
      });
      final pages =
          await quick
              .watchAccountBalances(SuiAddress(_owner))
              .toList();
      expect(pages.length, 2);
      expect(
        pages.expand((e) => e).map((e) => e.balance),
        [BigInt.from(100), BigInt.from(50)],
      );
    });

    test('watchAccountCoins streams filtered pages', () async {
      SuiObject coin(String objectId) => SuiObject(
        objectId: objectId,
        objectType: '0x2::coin::Coin<0x2::sui::SUI>',
      );
      var calls = 0;
      final quick = _grpcOnly((method) {
        if (++calls == 1) {
          return SuiListOwnedObjectsResponse(
            objects: [coin('0x01'), coin('0x02')],
            nextPageToken: [1],
          ).toBuffer().toList();
        }
        return SuiListOwnedObjectsResponse(
          objects: [coin('0x03')],
        ).toBuffer().toList();
      });
      final coins =
          await quick
              .watchAccountCoins(SuiAddress(_owner))
              .expand((e) => e)
              .toList();
      expect(coins.map((e) => e.objectId), ['0x01', '0x02', '0x03']);
    });

    test('getCoins sums suix coin balances', () async {
      Map<String, dynamic> coin(String id, String balance) => {
        'balance': balance,
        'coinObjectId': id,
        'coinType': '0x2::sui::SUI',
        'digest': 'd',
        'previousTransaction': 't',
        'version': '1',
      };
      final quick = _quick(
        respondJson:
            (method) => {
              'data': [coin('0x01', '100'), coin('0x02', '50')],
              'hasNextPage': false,
            },
        respondGrpc: (method) => throw StateError('grpc unused'),
      );
      final coins = await quick.getCoins(owner: SuiAddress(_owner));
      expect(
        coins.fold<BigInt>(BigInt.zero, (p, e) => p + e.balance),
        BigInt.from(150),
      );
    });

    test('dryRun applies safe budget, throws on failure',
        skip: !native ? 'filesystem fixtures unavailable' : null, () async {
      Map<String, dynamic> dryRun({required bool success}) {
        final tx = _txFixture();
        final effects = Map<String, dynamic>.from(tx['effects'] as Map);
        effects['status'] = {'status': success ? 'success' : 'failure'};
        return {
          'effects': effects,
          'balanceChanges': [],
          'events': [],
          'input': {
            'sender': _owner,
            'gasData': {
              'budget': '1',
              'owner': _owner,
              'payment': [],
              'price': '1',
            },
            'transaction': {'kind': 'Genesis', 'objects': []},
          },
          'objectChanges': [],
        };
      }

      final quick = _quick(
        respondJson: (method) => dryRun(success: true),
        respondGrpc: (method) => throw StateError('grpc unused'),
      );
      final budgeted = await quick.dryRun(_tx());
      // 175000 + 1000*1000 + 23955200 - 23715648 = 1414552.
      expect(budgeted.gasData.budget, BigInt.from(1414552));

      final failing = _quick(
        respondJson: (method) => dryRun(success: false),
        respondGrpc: (method) => throw StateError('grpc unused'),
      );
      expect(
        () => failing.dryRun(_tx()),
        throwsA(isA<BuError>()),
      );
    });

    test('sendTransaction returns digest, throws on failure',
        skip: !native ? 'filesystem fixtures unavailable' : null, () async {
      final tx = _txFixture();
      final quick = _quick(
        respondJson: (method) => tx,
        respondGrpc: (method) => throw StateError('grpc unused'),
      );
      expect(
        await quick.sendTransaction(transaction: _tx(), signatures: ['sig']),
        tx['digest'],
      );

      Map<String, dynamic> failedTx() {
        final copy = Map<String, dynamic>.from(tx);
        final effects = Map<String, dynamic>.from(tx['effects'] as Map);
        effects['status'] = {'status': 'failure'};
        copy['effects'] = effects;
        return copy;
      }

      final failing = _quick(
        respondJson: (method) => failedTx(),
        respondGrpc: (method) => throw StateError('grpc unused'),
      );
      expect(
        () => failing.sendTransaction(transaction: _tx(), signatures: ['sig']),
        throwsA(isA<BuError>()),
      );
    });

    test('trackTransaction completes, times out otherwise',
        skip: !native ? 'filesystem fixtures unavailable' : null, () async {
      final tx = _txFixture();
      final quick = _quick(
        respondJson: (method) => tx,
        respondGrpc: (method) => throw StateError('grpc unused'),
      );
      await quick.trackTransaction(
        transactionId: 'digest',
        periodicTimeOut: const Duration(milliseconds: 10),
      );

      final never = _quick(
        respondJson:
            (method) => throw const BuError(OnChainErrorType.suiPlugin, 'node down'),
        respondGrpc: (method) => throw StateError('grpc unused'),
      );
      expect(
        () => never.trackTransaction(
          transactionId: 'digest',
          timeout: const Duration(milliseconds: 50),
          periodicTimeOut: const Duration(milliseconds: 10),
        ),
        throwsA(isA<BuError>()),
      );
    });

    test('getTransactionStatus maps effects',
        skip: !native ? 'filesystem fixtures unavailable' : null, () async {
      final tx = _txFixture();
      final quick = _quick(
        respondJson: (method) => tx,
        respondGrpc: (method) => throw StateError('grpc unused'),
      );
      expect(await quick.getTransactionStatus('digest'), SuiTxStatus.block);

      Map<String, dynamic> failedTx() {
        final copy = Map<String, dynamic>.from(tx);
        final effects = Map<String, dynamic>.from(tx['effects'] as Map);
        effects['status'] = {'status': 'failure'};
        copy['effects'] = effects;
        return copy;
      }

      final failing = _quick(
        respondJson: (method) => failedTx(),
        respondGrpc: (method) => throw StateError('grpc unused'),
      );
      expect(
        await failing.getTransactionStatus('digest'),
        SuiTxStatus.failed,
      );
    });

    test('getBlockHeight parses checkpoint sequence', () async {
      final quick = _quick(
        respondJson: (method) => '12345',
        respondGrpc: (method) => throw StateError('grpc unused'),
      );
      expect(await quick.getBlockHeight(), BigInt.from(12345));
    });
  });
}

void main() {
  OnChainUtilsTestApi.runTest(suiQuickClientAdditionsTest, 'Sui Quick Additions');
}
