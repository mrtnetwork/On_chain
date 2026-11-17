// Offline tests for the TronQuickClientApi additions (balance, height,
// track, status). Fullnode-stub tests only — no network.
import 'package:blockchain_utils/blockchain_utils.dart';
import 'package:on_chain/tron/tron.dart';
import 'package:test/test.dart';

import '../utils.dart';

const String _address = 'T9yD14Nj9j7xAB4dbGeiX9h8unkKLxmGkn';

class _StubTronService with TronServiceProvider {
  final BaseServiceResponse Function(TronFullNodeRequestDetails params) respond;
  _StubTronService(this.respond);

  @override
  Future<BaseServiceResponse> doRequest(
    TronFullNodeRequestDetails params, {
    Duration? timeout,
  }) async => respond(params);

  @override
  Future<List<int>> doGrpcRequest(
    BaseGRPCServiceRequestParams params, {
    Duration? timeout,
  }) {
    throw UnsupportedError('gRPC not supported in stubs.');
  }

  @override
  Stream<List<int>> doGrpcRequestStream(
    BaseGRPCServiceRequestParams params, {
    Duration? timeout,
  }) {
    throw UnsupportedError('gRPC not supported in stubs.');
  }

  @override
  Future<Stream<List<int>>> doGrpcRequestStreamAsync(
    BaseGRPCServiceRequestParams params, {
    Duration? timeout,
  }) {
    throw UnsupportedError('gRPC not supported in stubs.');
  }
}

BaseServiceResponse _ok(TronFullNodeRequestDetails params, Object payload) {
  final body =
      payload is String
          ? StringUtils.encode(payload)
          : StringUtils.encodeJson(payload);
  return params.toResponse(body);
}

TronQuickClient _quick(
  BaseServiceResponse Function(TronFullNodeRequestDetails params) respond,
) {
  return DefaultTronQuickClient(
    provider: TronProvider(_StubTronService(respond)),
    availableProviders: const [TronProviderApi.fullnode],
  );
}

Map<String, dynamic> _txJson({required String retCode}) => {
  'ret': [
    {'contractRet': retCode},
  ],
  'txID': 'abc123',
  'raw_data': {},
};

void tronQuickClientAdditionsTest() {
  group('Tron/QuickClientApi additions (offline)', () {
    test('getBalance reads account balance', () async {
      final hexAddr = BytesUtils.toHexString(TronAddress(_address).toBytes());
      final quick = _quick(
        (p) => _ok(p, {'address': hexAddr, 'balance': 1000}),
      );
      expect(await quick.getBalance(TronAddress(_address)), BigInt.from(1000));
    });

    test('getBlockHeight reads header number', () async {
      final quick = _quick(
        (p) => _ok(p, {
          'block_header': {
            'raw_data': {'number': 12345},
          },
        }),
      );
      expect(await quick.getBlockHeight(), BigInt.from(12345));
    });

    test('trackTransaction completes on serve, times out otherwise', () async {
      final quick = _quick((p) => _ok(p, _txJson(retCode: 'SUCCESS')));
      final tx = await quick.trackTransaction(
        transactionId: 'abc123',
        periodicTimeOut: const Duration(milliseconds: 10),
      );
      expect(tx, isNotNull);

      final never = _quick((p) => _ok(p, {}));
      expect(
        () => never.trackTransaction(
          transactionId: 'abc123',
          timeout: const Duration(milliseconds: 50),
          periodicTimeOut: const Duration(milliseconds: 10),
        ),
        throwsA(isA<BuError>()),
      );
    });

    test('getTransactionStatus maps receipt states', () async {
      final block = _quick((p) => _ok(p, _txJson(retCode: 'SUCCESS')));
      expect(await block.getTransactionStatus('abc123'), TronTxStatus.block);

      final failed = _quick((p) => _ok(p, _txJson(retCode: 'REVERT')));
      expect(await failed.getTransactionStatus('abc123'), TronTxStatus.failed);
    });
  });
}

void main() {
  OnChainUtilsTestApi.runTest(
    tronQuickClientAdditionsTest,
    'Tron Quick Additions',
  );
}
