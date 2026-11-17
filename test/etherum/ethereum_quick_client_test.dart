// Offline tests for EthereumQuickClientApi (lib/ethereum/src/rpc/quick/).
// Stub-service tests only — no network.
import 'dart:async';

import 'package:blockchain_utils/blockchain_utils.dart';
import 'package:on_chain/ethereum/ethereum.dart';
import 'package:on_chain/solidity/abi/abi.dart';
import 'package:on_chain/solidity/helper/helper.dart';
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

BaseServiceResponse _rpcError(
  EthereumRequestDetails params, {
  required int code,
  required String message,
}) {
  return params.toResponse(
    StringUtils.encodeJson({
      'jsonrpc': '2.0',
      'id': params.requestID,
      'error': {'code': code, 'message': message},
    }),
  );
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

/// ABI-encode a bool output word.
String _boolWord(bool v) => _uintWord(v ? BigInt.one : BigInt.zero);

/// ABI-encode a string output (offset + length + data words).
String _stringWord(String s) {
  final data = BytesUtils.toHexString(StringUtils.encode(s));
  return '0x${32.toRadixString(16).padLeft(64, '0')}'
      '${(data.length ~/ 2).toRadixString(16).padLeft(64, '0')}'
      '${data.padRight(64, '0')}';
}

/// ABI-encode an address output word.
String _addressWord(String address) =>
    '0x${'0' * 24}${address.substring(2).toLowerCase()}';

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

void ethereumQuickClientTest() {
  group('Ethereum/EthereumQuickClientApi (offline)', () {
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
          return _rpcError(p, code: -32601, message: 'not supported');
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

    test('getNetworkInfo rethrows non-method errors', () async {
      final quick = _quick((p) {
        if (p.method.contains('eth_chainId')) {
          return _ok(p, '0x1');
        }
        return _rpcError(p, code: -32005, message: 'rate limited');
      });
      expect(() => quick.getNetworkInfo(), throwsA(isA<RPCError>()));
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
      expect(
        await quick.validateChainId(expectedChainId: BigInt.two),
        isFalse,
      );
      expect(await quick.getBalance(ETHAddress(_account)), BigInt.from(1000));

      final empty = _quick((p) => _ok(p, null));
      expect(await empty.isContract(ETHAddress(_contract)), isFalse);
    });

    test('dynamicCall passes method through', () async {
      final quick = _quick((p) => _ok(p, {'chain': 'eth'}));
      expect(
        await quick.dynamicCall<Map<String, dynamic>>(
          method: 'custom_method',
          params: <dynamic>[],
        ),
        {'chain': 'eth'},
      );
    });

    test('getERC20Details reads decimals/symbol/name', () async {
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

    test('getERC20Details returns null without decimals', () async {
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

    test('supportsInterface maps revert to false, throws otherwise', () async {
      final yes = _quick((p) => _ok(p, _boolWord(true)));
      expect(
        await yes.supportsInterface(
          standard: EthereumContractStandard.erc721,
          contract: ETHAddress(_contract),
          from: ETHAddress(_account),
        ),
        isTrue,
      );

      final revert = _quick(
        (p) => _rpcError(p, code: 3, message: 'execution reverted'),
      );
      expect(
        await revert.supportsInterface(
          standard: EthereumContractStandard.erc721,
          contract: ETHAddress(_contract),
          from: ETHAddress(_account),
        ),
        isFalse,
      );

      final broken = _quick(
        (p) => _rpcError(p, code: -32603, message: 'internal error'),
      );
      expect(
        () => broken.supportsInterface(
          standard: EthereumContractStandard.erc721,
          contract: ETHAddress(_contract),
          from: ETHAddress(_account),
        ),
        throwsA(isA<RPCError>()),
      );
    });

    test('detectContractStandard probes 165 then functions', () async {
      // No 165 support, but ownerOf resolves -> erc721.
      var calls = 0;
      final quick = _quick((p) {
        calls++;
        if (calls <= 2) {
          return _rpcError(p, code: 3, message: 'execution reverted');
        }
        return _ok(p, _addressWord(_account));
      });
      expect(
        await quick.detectContractStandard(
          contract: ETHAddress(_contract),
          from: ETHAddress(_account),
          tokenId: BigInt.one,
        ),
        EthereumContractStandard.erc721,
      );

      // 1155 interface id matches.
      final supported = _quick((p) => _ok(p, _boolWord(true)));
      expect(
        await supported.detectContractStandard(
          contract: ETHAddress(_contract),
          from: ETHAddress(_account),
        ),
        EthereumContractStandard.erc721,
      );
    });

    test('getERC721Owner / tokenUri / 1155 uri null on revert', () async {
      final revert = _quick(
        (p) => _rpcError(p, code: 3, message: 'execution reverted'),
      );
      expect(
        await revert.getERC721Owner(
          contract: ETHAddress(_contract),
          tokenId: BigInt.one,
        ),
        isNull,
      );
      expect(
        await revert.getERC721TokenUri(
          contract: ETHAddress(_contract),
          tokenId: BigInt.one,
        ),
        isNull,
      );
      expect(
        await revert.getERC1155Uri(
          contract: ETHAddress(_contract),
          tokenId: BigInt.one,
        ),
        isNull,
      );
      expect(
        await revert.getERC20Name(ETHAddress(_contract)),
        isNull,
      );
      expect(
        await revert.getERC20Symbol(ETHAddress(_contract)),
        isNull,
      );
    });

    test('findInboundHoldings classifies 3-topic and 4-topic logs', () async {
      const sig =
          '0xddf252ad1be2c89b69c2b068fc378daa952ba7f163c4a11628f55a4df523b3ef';
      String padded(String address) =>
          '0x${'0' * 24}${address.substring(2).toLowerCase()}';
      final owner = ETHAddress(_account);
      final other = '0x0000000000000000000000000000000000000003';
      final token = _contract;
      final quick = _quick((p) {
        if (p.method.contains('eth_blockNumber')) return _ok(p, '0x64');
        return _ok(p, [
          {
            'address': token,
            'topics': [sig, padded(other), padded(owner.address)],
            'data': '0x',
          },
          {
            'address': token,
            'topics': [
              sig,
              padded(other),
              padded(owner.address),
              '0x${'0' * 62}7',
            ],
            'data': '0x',
          },
        ]);
      });
      final holdings = await quick.findInboundHoldings(owner: owner);
      expect(holdings.erc20Contracts, {token.toLowerCase()});
      expect(holdings.erc721[token.toLowerCase()], {BigInt.from(7)});
    });

    test('watchERC1155TokenIds emits verified ids', () async {
      // TransferSingle data: id=1, value=2 (non-indexed tuple).
      final data = ABIUtils.encode(
        types: ['uint256', 'uint256'],
        params: [BigInt.one, BigInt.two],
      );
      String encAddr(String a) => _addressWord(a);
      final quick = _quick((p) {
        if (p.method.contains('eth_blockNumber')) return _ok(p, '0x5');
        if (p.method.contains('eth_getLogs')) {
          return _ok(p, [
            {
              'address': _contract,
              'topics': [
                const ERC1155TransferSingleDecoder().signatureHex,
                encAddr(_account),
                encAddr(
                  '0x0000000000000000000000000000000000000003',
                ),
                encAddr(_account),
              ],
              'data': BytesUtils.toHexString(data),
            },
          ]);
        }
        return _ok(p, _uintWord(BigInt.from(2)));
      });
      final legs = await quick
          .watchERC1155TokenIds(
            contract: ETHAddress(_contract),
            owner: ETHAddress(_account),
          )
          .toList();
      expect(legs.expand((e) => e), contains(BigInt.one));
    });

    test('range-cap errors split, other errors throw', () async {
      expect(
        EthereumQuickClientApi.isEvmReverted(
          const RPCError(message: 'execution reverted'),
        ),
        isTrue,
      );
      expect(
        EthereumQuickClientApi.isEvmReverted(
          const RPCError(message: 'REVERT opcode executed'),
        ),
        isTrue,
      );
      expect(
        EthereumQuickClientApi.isEvmRangeLimitError(
          const RPCError(errorCode: -32701, message: 'x'),
        ),
        isTrue,
      );
      expect(
        EthereumQuickClientApi.isEvmRangeLimitError(
          const RPCError(message: 'block range too large'),
        ),
        isTrue,
      );
      expect(
        EthereumQuickClientApi.isEvmRangeLimitError(
          const RPCError(message: 'boom'),
        ),
        isFalse,
      );
    });

    test('calldata encoders roundtrip with typed decoders', () async {
      final quick = _quick((p) => _ok(p, '0x'));
      final to = ETHAddress(_account);
      final from = ETHAddress(_contract);

      final transfer = quick.erc20TransferCalldata(
        to: to,
        value: BigInt.from(42),
      );
      // Well-known selector of transfer(address,uint256).
      expect(BytesUtils.toHexString(transfer.sublist(0, 4)), 'a9059cbb');
      final decodedTransfer = const ERC20TransferEncoder().decodeInput(
        transfer,
      );
      expect(decodedTransfer.to.address, to.address);
      expect(decodedTransfer.value, BigInt.from(42));

      final approve = quick.erc20ApproveCalldata(
        spender: to,
        value: BigInt.one,
      );
      expect(BytesUtils.toHexString(approve.sublist(0, 4)), '095ea7b3');
      final decodedApprove = const ERC20ApproveEncoder().decodeInput(approve);
      expect(decodedApprove.spender.address, to.address);
      expect(decodedApprove.value, BigInt.one);

      final nftTransfer = quick.erc721TransferCalldata(
        from: from,
        to: to,
        tokenId: BigInt.from(7),
      );
      final decodedNftTransfer = const ERC721TransferFromEncoder().decodeInput(
        nftTransfer,
      );
      expect(decodedNftTransfer.from.address, from.address);
      expect(decodedNftTransfer.to.address, to.address);
      expect(decodedNftTransfer.tokenId, BigInt.from(7));

      final nftApprove = quick.erc721ApproveCalldata(
        to: to,
        tokenId: BigInt.from(7),
      );
      final decodedNftApprove = const ERC721ApproveEncoder().decodeInput(
        nftApprove,
      );
      expect(decodedNftApprove.to.address, to.address);
      expect(decodedNftApprove.tokenId, BigInt.from(7));

      final safeTransfer = quick.erc1155SafeTransferFromCalldata(
        from: from,
        to: to,
        id: BigInt.one,
        value: BigInt.two,
      );
      final decodedSafe = const ERC1155SafeTransferFromEncoder().decodeInput(
        safeTransfer,
      );
      expect(decodedSafe.from.address, from.address);
      expect(decodedSafe.to.address, to.address);
      expect(decodedSafe.id, BigInt.one);
      expect(decodedSafe.value, BigInt.two);
      expect(decodedSafe.data, isEmpty);

      final approvalForAll = quick.setApprovalForAllCalldata(
        operator: to,
        approved: true,
      );
      final decodedApproval =
          const ERC1155SetApprovalForAllEncoder().decodeInput(approvalForAll);
      expect(decodedApproval.operator.address, to.address);
      expect(decodedApproval.approved, isTrue);

      // Selectors match the wire request fragments.
      expect(
        BytesUtils.bytesEqual(
          transfer.sublist(0, 4),
          const ERC20TransferEncoder().selector,
        ),
        isTrue,
      );
    });
  });
}

void main() {
  OnChainUtilsTestApi.runTest(ethereumQuickClientTest, 'Ethereum Quick Client');
}
