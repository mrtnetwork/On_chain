// Offline tests for NearTokenQuickApi
// (lib/near/src/rpc/quick_api/token_api.dart). Fake-leaf tests only — no
// network: the fake answers node reads while the composed methods run real.
import 'package:blockchain_utils/blockchain_utils.dart';
import 'package:on_chain/near/near.dart';
import 'package:test/test.dart';

import '../utils.dart';

/// Configurable fake: token methods run for real, node leaves answer from
/// [onRead]/[onNode] (or throw to simulate failures).
class _Fake with NearQuickNodeApi, NearTokenQuickApi {
  _Fake({required this.onRead, this.onNode});

  final Object? Function(String leaf, [Object? args]) onRead;
  final Object? Function(String leaf)? onNode;

  Object? _node(String leaf) =>
      onNode != null ? onNode!(leaf) : throw StateError('unexpected $leaf');

  @override
  IProvider<IServiceProvider, BaseServiceRequestParams> get provider =>
      throw UnimplementedError();
  @override
  Future<DECODE>
  readFunctionResponse<ENCODE extends Object?, DECODE extends Object?>({
    required BaseNearAddress contractId,
    required ENCODE args,
    required NearContractFunction<ENCODE, DECODE> function,
    NearBlockReference blockReference = NearBlockReference.optimistic,
    Duration? timeout,
  }) async {
    return onRead(function.name, args) as DECODE;
  }
  // @override
  // Future<DECODE> readFunctionResponse<ENCODE extends Object?, DECODE extends Object?>({
  //   required BaseNearAddress contractId,
  //   required ENCODE args,
  //   required NearContractFunction<ENCODE, DECODE> function,
  //   NearBlockReference blockRefrence = NearBlockReference.optimistic,
  //   Duration? timeout,
  // }) async =>
  //     onRead(function.name, args) as DECODE;

  @override
  Future<NearRpcRpcQueryResponseAccountView> viewAccount(
    BaseNearAddress accountId, {
    NearBlockReference blockReference = NearBlockReference.optimistic,
    Duration? timeout,
  }) async => _node('viewAccount') as NearRpcRpcQueryResponseAccountView;
  @override
  Future<NearRpcRpcQueryResponseAccessKeyView> viewAccessKey({
    required BaseNearAddress accountId,
    required String publicKey,
    NearBlockReference blockReference = NearBlockReference.optimistic,
    Duration? timeout,
  }) async => _node('viewAccessKey') as NearRpcRpcQueryResponseAccessKeyView;

  @override
  Future<NearRpcRpcTransactionResponse> transactionStatus({
    required String txId,
    required BaseNearAddress accountId,
    Duration? timeout,
  }) async => _node('transactionStatus') as NearRpcRpcTransactionResponse;

  @override
  Future<NearRpcRpcTransactionResponse> sendTransactionUntil({
    required NearSignedTransaction transaction,
    NearRpcTxExecutionStatus? waitUntil,
    Duration? timeout,
  }) async => _node('sendTransactionUntil') as NearRpcRpcTransactionResponse;
}

NearRpcRpcQueryResponseAccountView _accountView({required String amount}) {
  return NearRpcRpcQueryResponseAccountView(
    NearRpcAccountView(
      amount: amount,
      codeHash: '11111111111111111111111111111111',
      locked: '0',
      storageUsage: BigInt.zero,
    ),
    blockHash: 'blockhash',
    blockHeight: BigInt.one,
  );
}

NearRpcRpcTransactionResponse _finalOutcome({
  required NearRpcFinalExecutionStatus status,
  List<NearRpcExecutionOutcomeWithIdView> receipts = const [],
}) {
  return NearRpcRpcTransactionResponseFinalExecutionOutcomeView(
    NearRpcFinalExecutionOutcomeView(
      status: status,
      receiptsOutcome: receipts,
      transaction: NearRpcSignedTransactionView(
        actions: const [],
        hash: 'hash',
        nonce: BigInt.zero,
        publicKey: 'ed25519:',
        receiverId: 'bob.near',
        signerId: 'alice.near',
        signature: 'sig',
      ),
      transactionOutcome: NearRpcExecutionOutcomeWithIdView(
        blockHash: 'blockhash',
        id: 'txid',
        outcome: NearRpcExecutionOutcomeView(
          executorId: 'alice.near',
          gasBurnt: BigInt.zero,
          logs: const [],
          receiptIds: const [],
          status: NearRpcExecutionStatusViewSuccessValue('ok'),
          tokensBurnt: '0',
        ),
        proof: const [],
      ),
    ),
  );
}

void nearTokenQuickApiTest() {
  final contract = BaseNearAddress('contract.near');
  final owner = BaseNearAddress('alice.near');

  group('NEAR/TokenQuickApi (fake leaves)', () {
    test('getFtMetadata joins name/symbol/decimals', () async {
      final api = _Fake(
        onRead:
            (method, [args]) => switch (method) {
              'ft_metadata' => {
                'name': 'Name',
                'symbol': 'SYM',
                'decimals': '6',
              },
              _ => throw StateError('unexpected $method'),
            },
      );
      final meta = await api.getFtMetadata(contract);
      expect(meta.name, 'Name');
      expect(meta.symbol, 'SYM');
      expect(meta.decimals, 6);
    });

    test('getFtBalance parses value, throws on garbage', () async {
      final api = _Fake(onRead: (method, [args]) => '250');
      expect(
        await api.getFtBalance(contract: contract, owner: owner),
        BigInt.from(250),
      );

      final broken = _Fake(onRead: (method, [args]) => 'not-a-number');
      expect(
        () => broken.getFtBalance(contract: contract, owner: owner),
        throwsA(isA<BuError>()),
      );
    });

    test('probeNearStandards maps missing methods only', () async {
      final api = _Fake(
        onRead:
            (method, [args]) => switch (method) {
              'ft_metadata' => {'name': 'x'},
              _ => throw const RPCError(message: 'MethodNotFound: nope'),
            },
      );
      final probe = await api.probeNearStandards(contract);
      expect(probe.isFt, isTrue);
      expect(probe.isNft, isFalse);
      expect(probe.isMt, isFalse);
      expect(probe.methods, ['ft_balance_of', 'ft_metadata', 'ft_transfer']);

      final down = _Fake(
        onRead:
            (method, [args]) =>
                throw const RPCError(message: 'connection refused'),
      );
      expect(() => down.probeNearStandards(contract), throwsA(isA<RPCError>()));
    });

    test('getNftOwnerOrNull passes missing through', () async {
      final hit = _Fake(onRead: (method, [args]) => {'owner_id': 'bob.near'});
      expect(
        await hit.getNftOwnerOrNull(contract: contract, tokenId: '1'),
        'bob.near',
      );

      final missing = _Fake(onRead: (method, [args]) => <String, dynamic>{});
      expect(
        await missing.getNftOwnerOrNull(contract: contract, tokenId: '1'),
        isNull,
      );
    });

    test('getMtMetadata and getMtBalance', () async {
      final api = _Fake(
        onRead:
            (method, [args]) => switch (method) {
              'mt_metadata_base_by_token_id' => [
                {'name': 'MT', 'symbol': 'M', 'decimals': '0'},
              ],
              'mt_balance_of' => '42',
              _ => throw StateError('unexpected $method'),
            },
      );
      final meta = await api.getMtMetadata(contract: contract, tokenId: '1');
      expect(meta.name, 'MT');
      expect(
        await api.getMtBalance(contract: contract, owner: owner, tokenId: '1'),
        BigInt.from(42),
      );

      final empty = _Fake(onRead: (method, [args]) => <dynamic>[]);
      expect(
        () => empty.getMtMetadata(contract: contract, tokenId: '1'),
        throwsA(isA<BuError>()),
      );
    });

    test('getStorageBalanceBounds maps leniently, min throws', () async {
      final api = _Fake(
        onRead: (method, [args]) => {'min': '100', 'max': 'bad'},
      );
      final bounds = await api.getStorageBalanceBounds(contract);
      expect(bounds.min, BigInt.from(100));
      expect(bounds.max, BigInt.zero);
      expect(await api.getStorageBoundsMin(contract), BigInt.from(100));

      final missing = _Fake(onRead: (method, [args]) => <String, dynamic>{});
      expect(
        () => missing.getStorageBoundsMin(contract),
        throwsA(isA<BuError>()),
      );
    });

    test('getAccountBalance parses, accountExists maps missing', () async {
      final api = _Fake(
        onRead: (method, [args]) => throw StateError('unused'),
        onNode: (leaf) => _accountView(amount: '1000'),
      );
      expect(await api.getAccountBalance(owner), BigInt.from(1000));
      expect(await api.accountExists(owner), isTrue);

      final missing = _Fake(
        onRead: (method, [args]) => throw StateError('unused'),
        onNode: (leaf) {
          throw const RPCError(message: 'account does not exist');
        },
      );
      expect(await missing.accountExists(owner), isFalse);

      final down = _Fake(
        onRead: (method, [args]) => throw StateError('unused'),
        onNode: (leaf) {
          throw const RPCError(message: 'connection refused');
        },
      );
      expect(() => down.accountExists(owner), throwsA(isA<RPCError>()));
    });

    test('getAccessKeyView maps missing keys only', () async {
      final hit = _Fake(
        onRead: (method, [args]) => throw StateError('unused'),
        onNode:
            (leaf) => NearRpcRpcQueryResponseAccessKeyView(
              NearRpcAccessKeyView(
                nonce: BigInt.zero,
                permission: const NearRpcAccessKeyPermissionViewFullAccess(),
              ),
              blockHash: 'blockhash',
              blockHeight: BigInt.one,
            ),
      );
      final key = await hit.getAccessKeyView(
        accountId: owner,
        publicKey: 'ed25519:abc',
      );
      expect(key, isNotNull);
      expect(key!.nonce, BigInt.zero);

      final missing = _Fake(
        onRead: (method, [args]) => throw StateError('unused'),
        onNode: (leaf) {
          throw const RPCError(message: 'access key does not exist');
        },
      );
      expect(
        await missing.getAccessKeyView(
          accountId: owner,
          publicKey: 'ed25519:abc',
        ),
        isNull,
      );
    });

    test('getTransactionStatus maps outcomes', () async {
      NearRpcRpcTransactionResponse outcome(NearRpcFinalExecutionStatus s) =>
          _finalOutcome(status: s);
      final block = _Fake(
        onRead: (method, [args]) => throw StateError('unused'),
        onNode:
            (leaf) => outcome(NearRpcFinalExecutionStatusSuccessValue('ok')),
      );
      expect(
        await block.getTransactionStatus(txId: 'h', accountId: owner),
        NearTxStatus.block,
      );

      final failed = _Fake(
        onRead: (method, [args]) => throw StateError('unused'),
        onNode:
            (leaf) => outcome(
              NearRpcFinalExecutionStatusFailure(
                NearRpcTxExecutionErrorActionError(
                  NearRpcActionError(
                    kind: const NearRpcActionErrorKindDelegateActionExpired(),
                  ),
                ),
              ),
            ),
      );
      expect(
        await failed.getTransactionStatus(txId: 'h', accountId: owner),
        NearTxStatus.failed,
      );

      final pending = _Fake(
        onRead: (method, [args]) => throw StateError('unused'),
        onNode: (leaf) {
          throw const RPCError(message: 'transaction does not exist');
        },
      );
      expect(
        await pending.getTransactionStatus(txId: 'h', accountId: owner),
        NearTxStatus.pending,
      );
    });
  });
}

void main() {
  OnChainUtilsTestApi.runTest(nearTokenQuickApiTest, 'NEAR Token Quick Api');
}
