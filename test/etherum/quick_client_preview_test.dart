// Preview tests for the staged EthereumQuickClientApi
// (test/etherum/quick_preview/). Offline stub-service tests only — no network.
import 'dart:async';

import 'package:blockchain_utils/blockchain_utils.dart';
import 'package:on_chain/ethereum/ethereum.dart';
import 'package:test/test.dart';

import '../utils.dart';

const String _account = '0x0000000000000000000000000000000000000002';
const String _contract = '0x0000000000000000000000000000000000000001';
const String _txHash =
    '0xabababababababababababababababababababababababababababababababab';

class _StubEthService with EthereumServiceProvider {
  final BaseServiceResponse Function(EthereumRequestDetails params) respond;
  _StubEthService(this.respond);

  @override
  Future<BaseServiceResponse> doRequest(
    EthereumRequestDetails params, {
    Duration? timeout,
  }) async => respond(params);

  @override
  Future<BaseServiceSubscribtionResponse> doSubscribtionRequest({
    required EthereumRequestDetails params,
    required BaseServiceSubscribtionRequest<
      dynamic,
      dynamic,
      BaseSubscribtionEvent<dynamic>,
      EthereumRequestDetails
    >
    request,
    Duration? timeout,
  }) {
    throw UnimplementedError('HTTP subscriptions not supported.');
  }
}

BaseServiceResponse _ok(EthereumRequestDetails params, Object? result) {
  return params.toResponse({
    'jsonrpc': '2.0',
    'id': params.requestID,
    'result': result,
  });
}

EthereumQuickClient _quick(
  BaseServiceResponse Function(EthereumRequestDetails params) respond,
) {
  return DefaultEthereumQuickClient(
    provider: EthereumProvider(_StubEthService(respond)),
  );
}

/// ABI-encode a uint256 output word.
String _uintWord(BigInt v) => '0x${v.toRadixString(16).padLeft(64, '0')}';

/// ABI-encode a string output (offset + length + data words).
String _stringWord(String s) {
  final data = BytesUtils.toHexString(StringUtils.encode(s));
  return '0x${32.toRadixString(16).padLeft(64, '0')}'
      '${(data.length ~/ 2).toRadixString(16).padLeft(64, '0')}'
      '${data.padRight(64, '0')}';
}

Map<String, dynamic> _feeHistoryJson() => {
  'baseFeePerGas': ['0x64', '0x65'],
  'gasUsedRatio': [0.5, 0.6],
  'oldestBlock': '0x1',
  'reward': [
    ['0x1', '0x2', '0x3'],
    ['0x2', '0x3', '0x4'],
  ],
};

Map<String, dynamic> _receiptJson({required bool success}) => {
  'type': '0x2',
  'transactionHash': _txHash,
  'blockHash': _txHash,
  'from': _account,
  'to': _contract,
  'logsBloom': '0x00',
  'status': success ? '0x1' : '0x0',
  'logs': [],
};

void ethereumQuickClientPreviewTest() {
  group('Ethereum/EthereumQuickClientApi preview (offline)', () {
    test('getHistoricalFee averages rewards', () async {
      final quick = _quick((p) => _ok(p, _feeHistoryJson()));
      final fee = await quick.getHistoricalFee();
      expect(fee.slow, BigInt.from(1));
      expect(fee.normal, BigInt.from(2));
      expect(fee.high, BigInt.from(3));
      expect(fee.baseFee, BigInt.from(101));
    });

    test('getNetworkInfo reports eip support, degrades gracefully', () async {
      var withEip = true;
      final quick = _quick((p) {
        if (p.method.contains('eth_chainId')) {
          return _ok(p, '0x1');
        }
        if (!withEip) {
          return p.toResponse(
            StringUtils.encodeJson({
              'jsonrpc': '2.0',
              'id': p.requestID,
              'error': {'code': -32601, 'message': 'not supported'},
            }),
          );
        }
        return _ok(p, _feeHistoryJson());
      });
      final ok = await quick.getNetworkInfo();
      expect(ok.chainId, BigInt.one);
      expect(ok.supportsEIP1559, isTrue);

      withEip = false;
      final degraded = await quick.getNetworkInfo();
      expect(degraded.chainId, BigInt.one);
      expect(degraded.supportsEIP1559, isFalse);
    });

    test('gasPrice / estimateGasLimit / nonce / send / blockHeight', () async {
      final quick = _quick((p) {
        return switch (p.method) {
          _ when p.method.contains('eth_gasPrice') => _ok(p, '0x64'),
          _ when p.method.contains('eth_estimateGas') => _ok(p, '0x5208'),
          _ when p.method.contains('eth_getTransactionCount') => _ok(p, '0x7'),
          _ when p.method.contains('eth_sendRawTransaction') => _ok(
            p,
            '0xdeadbeef',
          ),
          _ => _ok(p, '0x100'),
        };
      });
      expect(await quick.gasPrice(), BigInt.from(100));
      expect(
        await quick.estimateGasLimit({'to': _account}),
        BigInt.from(21000),
      );
      expect(await quick.getAccountNonce(ETHAddress(_account)), 7);
      expect(await quick.sendRawTransaction('0x1234'), '0xdeadbeef');
      expect(await quick.getBlockHeight(), BigInt.from(256));
    });

    test('isContract / getChainId / validateChainId / balances', () async {
      final quick = _quick((p) {
        if (p.method.contains('eth_getCode')) return _ok(p, '0x6000');
        if (p.method.contains('eth_chainId')) return _ok(p, '0x1');
        return _ok(p, '0x3e8');
      });
      expect(await quick.isContract(ETHAddress(_contract)), isTrue);
      expect(await quick.getChainId(), BigInt.one);
      expect(await quick.validateChainId(expectedChainId: BigInt.one), isTrue);
      expect(await quick.validateChainId(expectedChainId: BigInt.two), isFalse);
      expect(await quick.getBalance(ETHAddress(_account)), BigInt.from(1000));

      final empty = _quick((p) => _ok(p, null));
      expect(await empty.isContract(ETHAddress(_contract)), isFalse);
    });

    test('dynamicCall passes method through', () async {
      final quick = _quick((p) => _ok(p, {'chain': 'eth'}));
      expect(
        // NOTE: EthereumRequestDynamic defaults to an unmodifiable const
        // params list that crashes buildRequest; pass a mutable one.
        await quick.dynamicCall<Map<String, dynamic>>(
          method: 'custom_method',
          params: <dynamic>[],
        ),
        {'chain': 'eth'},
      );
    });

    test('getErc20Details reads decimals/symbol/name', () async {
      var calls = 0;
      final quick = _quick((p) {
        return switch (++calls) {
          1 => _ok(p, _uintWord(BigInt.from(6))),
          2 => _ok(p, _stringWord('USDC')),
          _ => _ok(p, _stringWord('USD Coin')),
        };
      });
      final meta = await quick.getERC20Details(ETHAddress(_contract));
      expect(meta, isNotNull);
      expect(meta!.decimals, 6);
      expect(meta.symbol, 'USDC');
      expect(meta.name, 'USD Coin');
    });

    test('getErc20Details returns null without decimals', () async {
      final quick = _quick((p) => _ok(p, '0x'));
      expect(await quick.getERC20Details(ETHAddress(_contract)), isNull);
    });

    test('getAccountERC20Token joins metadata and balance', () async {
      var calls = 0;
      final quick = _quick((p) {
        return switch (++calls) {
          1 => _ok(p, _uintWord(BigInt.from(6))),
          2 => _ok(p, _stringWord('USDC')),
          3 => _ok(p, _stringWord('USD Coin')),
          _ => _ok(p, _uintWord(BigInt.from(500))),
        };
      });
      final token = await quick.getAccountERC20Token(
        ETHAddress(_account),
        ETHAddress(_contract),
      );
      expect(token, isNotNull);
      expect(token!.balance, BigInt.from(500));
      expect(token.symbol, 'USDC');
      expect(token.decimals, 6);
      expect(token.contract, ETHAddress(_contract).address);
    });

    test('getAllowance / getTokenBalance decode uint256', () async {
      final quick = _quick((p) => _ok(p, _uintWord(BigInt.from(42))));
      expect(
        await quick.getAllowance(
          contract: ETHAddress(_contract),
          owner: ETHAddress(_account),
          spender: ETHAddress(_account),
        ),
        BigInt.from(42),
      );
      expect(
        await quick.getTokenBalance(
          address: ETHAddress(_account),
          contract: ETHAddress(_contract),
        ),
        BigInt.from(42),
      );
    });

    test('transactionStatus maps receipt states', () async {
      final quick = _quick((p) => _ok(p, _receiptJson(success: true)));
      expect(await quick.transactionStatus(_txHash), EthTxStatus.block);

      final failed = _quick((p) => _ok(p, _receiptJson(success: false)));
      expect(await failed.transactionStatus(_txHash), EthTxStatus.failed);

      final missing = _quick((p) => _ok(p, null));
      expect(await missing.transactionStatus(_txHash), EthTxStatus.unknown);
    });

    test(
      'trackTransaction completes on receipt, times out otherwise',
      () async {
        final quick = _quick((p) => _ok(p, _receiptJson(success: true)));
        final receipt = await quick.trackTransaction(
          transactionId: _txHash,
          periodicTimeOut: const Duration(milliseconds: 10),
        );
        expect(receipt.transactionHash, _txHash);

        final never = _quick((p) => _ok(p, null));
        expect(
          () => never.trackTransaction(
            transactionId: _txHash,
            timeout: const Duration(milliseconds: 50),
            periodicTimeOut: const Duration(milliseconds: 10),
          ),
          throwsA(isA<BuError>()),
        );
      },
    );
  });
}

void main() {
  OnChainUtilsTestApi.runTest(
    ethereumQuickClientPreviewTest,
    'Ethereum Quick Client Preview',
  );
}
