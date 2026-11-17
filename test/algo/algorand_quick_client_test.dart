// Offline tests for the Algorand quick client additions
// (lib/algorand/src/rpc/api/api.dart). Stub-service tests only — no network.
import 'package:blockchain_utils/blockchain_utils.dart';
import 'package:on_chain/algorand/algorand.dart';
import 'package:test/test.dart';

import '../utils.dart';

class _StubAlgoService with AlgoServiceProvider {
  final BaseServiceResponse Function(AlgoRequestDetails params) respond;
  _StubAlgoService(this.respond);

  @override
  Future<BaseServiceResponse> doRequest(
    AlgoRequestDetails params, {
    Duration? timeout,
  }) async => respond(params);
}

BaseServiceResponse _ok(AlgoRequestDetails params, Object payload) {
  return params.toResponse(StringUtils.encodeJson(payload));
}

/// Msgpack stub for `?format=msgpack` endpoints (pending transactions).
BaseServiceResponse _mpok(AlgoRequestDetails params, Object payload) {
  return params.toResponse(MsgPackAnyLayout().serialize(payload));
}

class _Client with AlgoQuickClientApi {
  _Client(this._provider);

  final AlgoProvider<_StubAlgoService> _provider;

  @override
  IProvider<IServiceProvider, AlgoRequestDetails> get provider => _provider;
}

AlgoQuickClientApi _quick(
  BaseServiceResponse Function(AlgoRequestDetails params) respond,
) {
  return _Client(AlgoProvider(_StubAlgoService(respond)));
}

Map<String, dynamic> _holding({
  required int assetId,
  required int amount,
  Map<String, dynamic>? params,
}) => {
  'asset-holding': {'asset-id': assetId, 'amount': amount},
  if (params != null) 'asset-params': params,
};

Map<String, dynamic> _ftParams() => {
  'creator': 'AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAY5HFKQ',
  'decimals': 6,
  'total': 1000000,
  'name': 'USD Coin',
  'unit-name': 'USDC',
};

Map<String, dynamic> _nftParams() => {
  'creator': 'AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAY5HFKQ',
  'decimals': 0,
  'total': 1,
  'name': 'Cool NFT',
  'unit-name': 'CNFT',
};

Map<String, dynamic> _pendingTx({
  required String poolError,
  int? confirmedRound,
}) {
  const addr = 'AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAY5HFKQ';
  String b64(List<int> bytes) =>
      StringUtils.decode(bytes, encoding: StringEncoding.base64);
  return {
    'pool-error': poolError,
    if (confirmedRound != null) 'confirmed-round': confirmedRound,
    'txn': {
      'sig': b64(List<int>.filled(64, 0)),
      'txn': {
        'type': 'pay',
        'snd': addr,
        'fee': 0,
        'fv': 1,
        'lv': 1001,
        'gen': 'mainnet-v1.0',
        'gh': b64(List<int>.filled(32, 0)),
        'amt': 0,
        'rcv': addr,
      },
    },
  };
}

void algorandQuickClientTest() {
  final address = AlgoAddress.fromBytes(List<int>.filled(32, 1));

  group('Algorand/QuickClientApi Additions (Offline)', () {
    test('getAccountBalance reads amount, zero on 404, throws otherwise',
        () async {
      final quick = _quick(
        (p) => _ok(p, {'address': address.address, 'amount': 1000}),
      );
      expect(await quick.getAccountBalance(address), BigInt.from(1000));

      final missing = _quick(
        (p) => p.toResponse(
          StringUtils.encodeJson({'message': 'account not found'}),
          statusCode: 404,
        ),
      );
      expect(await missing.getAccountBalance(address), BigInt.zero);

      final broken = _quick(
        (p) => p.toResponse(
          StringUtils.encodeJson({'message': 'internal error'}),
          statusCode: 500,
        ),
      );
      expect(() => broken.getAccountBalance(address), throwsA(isA<RPCError>()));
    });

    test('getTransactionStatus maps pool/confirmed/pending', () async {
      final confirmed = _quick(
        (p) => _mpok(p, _pendingTx(poolError: '', confirmedRound: 5)),
      );
      expect(
        await confirmed.getTransactionStatus('txid'),
        AlgoTxStatus.block,
      );

      final failed = _quick(
        (p) => _mpok(p, _pendingTx(poolError: 'rejected')),
      );
      expect(await failed.getTransactionStatus('txid'), AlgoTxStatus.failed);

      final pending = _quick((p) => _mpok(p, _pendingTx(poolError: '')));
      expect(await pending.getTransactionStatus('txid'), AlgoTxStatus.pending);
    });

    test('watchAccountHoldings streams pages following cursors', () async {
      var calls = 0;
      final quick = _quick((p) {
        if (++calls == 1) {
          return _ok(p, {
            'asset-holdings': [
              _holding(assetId: 1, amount: 5, params: _ftParams()),
            ],
            'next-token': 'cursor-1',
            'round': 1,
          });
        }
        return _ok(p, {
          'asset-holdings': [
            _holding(assetId: 2, amount: 1, params: _nftParams()),
          ],
          'round': 2,
        });
      });
      final pages = await quick.watchAccountHoldings(address).toList();
      expect(pages.length, 2);
      expect(pages[0].single.assetHolding.assetId, BigInt.one);
      expect(pages[1].single.assetHolding.amount, BigInt.one);
      expect(
        AlgoQuickClientApi.isNftAssetParams(pages[1].single.assetParams!),
        isTrue,
      );
      expect(
        AlgoQuickClientApi.isNftAssetParams(pages[0].single.assetParams!),
        isFalse,
      );
    });

    test('getAssetParams hit and miss', () async {
      final hit = _quick(
        (p) => _ok(p, {
          'index': 1,
          'params': _ftParams(),
        }),
      );
      final params = await hit.getAssetParams(BigInt.one);
      expect(params, isNotNull);
      expect(params!.unitName, 'USDC');
      expect(params.decimals, BigInt.from(6));

      final miss = _quick(
        (p) => p.toResponse(
          StringUtils.encodeJson({'message': 'asset not found'}),
          statusCode: 404,
        ),
      );
      expect(await miss.getAssetParams(BigInt.one), isNull);

      final broken = _quick(
        (p) => p.toResponse(
          StringUtils.encodeJson({'message': 'internal error'}),
          statusCode: 500,
        ),
      );
      expect(() => broken.getAssetParams(BigInt.one), throwsA(isA<RPCError>()));
    });
  });
}

void main() {
  OnChainUtilsTestApi.runTest(
    algorandQuickClientTest,
    'Algorand Quick Client',
  );
}
