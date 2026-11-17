// Offline tests for ICPTokenQuickApi
// (lib/icp/src/service/client/api/icp_token_api.dart). Fake-leaf tests only
// — no network, no candid plumbing: the fake answers leaf queries while the
// composed methods under test run for real.
import 'package:blockchain_utils/blockchain_utils.dart';
import 'package:on_chain/exception/onchain_error.dart';
import 'package:on_chain/icp/icp.dart';
import 'package:test/test.dart';

import '../utils.dart';

/// Configurable fake: composed methods run for real, leaf queries answer
/// from [onQuery] (or throw to simulate replica/transport failures).
class _Fake with ICPQuickApi, ICPQuickQueryApi, ICPTokenQuickApi {
  _Fake({required this.onQuery});

  final Object? Function(Object message) onQuery;

  @override
  IProvider<IServiceProvider, ICPRequestDetails> get provider =>
      throw UnimplementedError();

  @override
  ICPNetworkConfig get networkConfig => ICPNetworkConfig.defaultConfig;

  @override
  Future<List<int>?> rootKey() async => null;

  @override
  Future<ICPRequestCallParams> createCallParams({
    required IcpPrincipalAddress canisterId,
    required IcpPrincipalAddress sender,
    required IcpPrincipalAddress? effectiveCanisterId,
  }) => throw UnimplementedError();

  @override
  Future<RESULT> query<RESULT>({
    required IICPQueryMessage<RESULT> message,
    required IcpPrincipalAddress canisterId,
    ICPRequestQueryParams? params,
  }) async => onQuery(message) as RESULT;
}

IcpPrincipalAddress _principal(int fill) =>
    IcpPrincipalAddress.fromBytes(List<int>.filled(29, fill));

LEDGERQueryBlocksResponse _blocksResponse({required bool empty}) {
  return LEDGERQueryBlocksResponse(
    chainLength: BigInt.one,
    blocks:
        empty
            ? const []
            : [
              LEDGERBlock(
                transaction: LEDGERTransaction(
                  memo: BigInt.zero,
                  createdAtTime: LEDGERTimeStamp(timestampNanos: BigInt.zero),
                ),
                timestamp: LEDGERTimeStamp(timestampNanos: BigInt.zero),
              ),
            ],
    firstBlockIndex: BigInt.zero,
    archivedBlocks: const [],
  );
}

void icpTokenQuickClientTest() {
  final canister = _principal(1);
  final owner = _principal(2);

  group('ICP/Token quick API (fake leaves)', () {
    test('getIcrc1TokenMetadata joins name/symbol/decimals', () async {
      final api = _Fake(
        onQuery:
            (m) => switch (m.runtimeType.toString()) {
              _ when m is ICRC1QueryIcrc1Name => 'Name',
              _ when m is ICRC1QueryIcrc1Symbol => 'SYM',
              _ when m is ICRC1QueryIcrc1Decimals => 6,
              _ => throw StateError('unexpected $m'),
            },
      );
      final meta = await api.getIcrc1TokenMetadata(canister);
      expect(meta.name, 'Name');
      expect(meta.symbol, 'SYM');
      expect(meta.decimals, 6);
    });

    test('fetchSupportedStandards maps rejections to empty', () async {
      final api = _Fake(
        onQuery:
            (m) => throw OnChainErrors.icpClient('query', reason: 'rejected'),
      );
      expect(await api.fetchSupportedStandards(canister), isEmpty);

      final broken = _Fake(onQuery: (m) => throw StateError('transport down'));
      expect(
        () => broken.fetchSupportedStandards(canister),
        throwsA(isA<StateError>()),
      );
    });

    test('getIcrc7TokenOwner passes opt-null through', () async {
      final hit = _Fake(
        onQuery: (m) => <ICRC7Account?>[ICRC7Account(owner: owner)],
      );
      expect(
        (await hit.getIcrc7TokenOwner(
          canister: canister,
          tokenId: BigInt.one,
        ))!.owner,
        owner,
      );

      final missing = _Fake(onQuery: (m) => const <ICRC7Account?>[null]);
      expect(
        await missing.getIcrc7TokenOwner(
          canister: canister,
          tokenId: BigInt.one,
        ),
        isNull,
      );

      final empty = _Fake(onQuery: (m) => const <ICRC7Account?>[]);
      expect(
        await empty.getIcrc7TokenOwner(canister: canister, tokenId: BigInt.one),
        isNull,
      );
    });

    test('getBlockTxStatus maps blocks presence', () async {
      final block = _Fake(onQuery: (m) => _blocksResponse(empty: false));
      expect(await block.getBlockTxStatus(BigInt.from(10)), IcpTxStatus.block);

      final pending = _Fake(onQuery: (m) => _blocksResponse(empty: true));
      expect(
        await pending.getBlockTxStatus(BigInt.from(10)),
        IcpTxStatus.pending,
      );
    });

    test('getIcrc1Balance forwards ledger value', () async {
      final api = _Fake(onQuery: (m) => BigInt.from(250));
      expect(
        await api.getIcrc1Balance(canister: canister, owner: owner),
        BigInt.from(250),
      );
    });

    test('builders shape messages', () async {
      final api = _Fake(onQuery: (m) => throw StateError('must not be called'));
      final params = ICPRequestCallParams(canisterId: canister, sender: owner);

      final transfer = await api.buildTransferContent(
        to: owner,
        amount: BigInt.from(100),
        sender: owner,
        params: params,
      );
      expect(transfer.message.args.amount.e8s, BigInt.from(100));

      final icrc1 = await api.buildIcrc1TransferContent(
        canister: canister,
        to: owner,
        amount: BigInt.from(7),
        sender: owner,
        params: params,
      );
      expect(icrc1.message.args.amount, BigInt.from(7));

      final icrc7 = await api.buildIcrc7TransferContent(
        canister: canister,
        to: owner,
        tokenId: BigInt.from(9),
        sender: owner,
        params: params,
      );
      expect(icrc7.message.args.single.tokenId, BigInt.from(9));

      final approve = await api.buildIcrc2ApproveContent(
        canister: canister,
        spender: owner,
        amount: BigInt.from(5),
        sender: owner,
        params: params,
      );
      expect(approve.message.args.amount, BigInt.from(5));

      final raw = await api.buildRawCallContent(
        canister: canister,
        sender: owner,
        params: params,
        method: 'greet',
        arg: const [1, 2, 3],
      );
      expect(raw.message.methodName, 'greet');

      expect(
        api.neuronStakingSubaccount(controller: owner, nonce: BigInt.one),
        hasLength(32),
      );
      expect(api.contentDigest(transfer.content), isNotEmpty);
    });
  });
}

void main() {
  OnChainUtilsTestApi.runTest(icpTokenQuickClientTest, 'ICP Token Quick Api');
}
