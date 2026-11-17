// Offline tests for TezosTokenQuickApi
// (lib/tezos/src/rpc/api/api/token_api.dart). Stub-service tests only — no
// network; path-routed stubs replay canned node payloads.
import 'package:blockchain_utils/blockchain_utils.dart';
import 'package:on_chain/tezos/tezos.dart';
import 'package:test/test.dart';

import '../utils.dart';

const String _tz1 = 'tz1KqTpEZ7Yob7QbPE4Hy4Wo8fHG8LhKxZSx';
const String _kt1 = 'KT1QuofAgnsWffHzLA7D78rxytJruGHDe7XG';

class _StubOctezService with OctezServiceProvider {
  final BaseServiceResponse Function(OctezRequestDetails params) respond;
  _StubOctezService(this.respond);

  @override
  Future<BaseServiceResponse> doRequest(
    OctezRequestDetails params, {
    Duration? timeout,
  }) async => respond(params);
}

BaseServiceResponse _ok(OctezRequestDetails params, Object payload) {
  final body =
      payload is String
          ? StringUtils.encode(payload)
          : StringUtils.encodeJson(payload);
  return params.toResponse(body);
}

BaseServiceResponse _notFound(OctezRequestDetails params) {
  return params.toResponse(
    StringUtils.encodeJson({'error': 'not found'}),
    statusCode: 404,
  );
}

BaseServiceResponse _serverError(OctezRequestDetails params) {
  return params.toResponse(
    StringUtils.encodeJson({'error': 'internal error'}),
    statusCode: 500,
  );
}

class _FakeClient extends DefaultTezosClient {
  _FakeClient({required super.provider, this.confirmation})
    : super(config: TezosClientConfig.defaults);

  final TezosConfirmationResult? confirmation;

  @override
  Future<TezosConfirmationResult> waitForOperation(
    String operationHash, {
    Duration? timeout,
    Duration? interval,
    String? chain,
    String? version,
    int? blockLookback,
  }) async {
    final result = confirmation;
    if (result == null) throw StateError('no confirmation canned');
    return result;
  }
}

DefaultTezosClient _quick(
  BaseServiceResponse Function(OctezRequestDetails params) respond, {
  TezosConfirmationResult? confirmation,
}) {
  return _FakeClient(
    provider: OctezProvider(_StubOctezService(respond)),
    confirmation: confirmation,
  );
}

Map<String, dynamic> _entrypoints(List<String> names) => {
  'entrypoints': {
    for (final name in names) name: {'prim': 'unit'},
  },
};

void tezosTokenQuickApiTest() {
  group('Tezos/TokenQuickApi (offline)', () {
    test('probeFaStandards detects FA1.2 and FA2', () async {
      final fa12 = _quick(
        (p) => _ok(p, _entrypoints(['transfer', 'approve', 'getBalance'])),
      );
      final probe12 = await fa12.probeFaStandards(TezosAddress(_kt1));
      expect(probe12.isFa12, isTrue);
      expect(probe12.isFa2, isFalse);
      expect(probe12.methods, contains('transfer'));

      final fa2 = _quick(
        (p) => _ok(
          p,
          _entrypoints(['transfer', 'balance_of', 'update_operators']),
        ),
      );
      final probe2 = await fa2.probeFaStandards(TezosAddress(_kt1));
      expect(probe2.isFa2, isTrue);
      expect(probe2.isFa12, isFalse);

      final implicit = _quick((p) {
        throw StateError('no RPC for implicit addresses');
      });
      final probeNone = await implicit.probeFaStandards(TezosAddress(_tz1));
      expect(probeNone.isFa12, isFalse);
      expect(probeNone.isFa2, isFalse);
      expect(probeNone.methods, isEmpty);
    });

    test('getActiveBakers maps delegate ids', () async {
      final quick = _quick((p) => _ok(p, [_tz1]));
      final bakers = await quick.getActiveBakers();
      expect(bakers.single.address, _tz1);
    });

    test('getAccountDelegate null on 404, throws otherwise', () async {
      final hit = _quick((p) => _ok(p, '"$_tz1"'));
      expect((await hit.getAccountDelegate(TezosAddress(_kt1)))?.address, _tz1);

      final missing = _quick(_notFound);
      expect(await missing.getAccountDelegate(TezosAddress(_kt1)), isNull);

      final broken = _quick(_serverError);
      expect(
        () => broken.getAccountDelegate(TezosAddress(_kt1)),
        throwsA(isA<RPCError>()),
      );
    });

    test('getStakedBalance parses mutez, zero when empty', () async {
      final quick = _quick((p) => _ok(p, '"1000"'));
      expect(
        await quick.getStakedBalance(TezosAddress(_kt1)),
        BigInt.from(1000),
      );

      final empty = _quick((p) => _ok(p, '""'));
      expect(await empty.getStakedBalance(TezosAddress(_kt1)), BigInt.zero);
    });

    test('getUnstakeRequests passes response through', () async {
      final quick = _quick(
        (p) => _ok(p, {
          'finalizable': [],
          'unfinalizable': {'delegate': _tz1, 'requests': []},
        }),
      );
      final requests = await quick.getUnstakeRequests(TezosAddress(_kt1));
      expect(requests, isNotNull);
      expect(requests!.finalizable, isEmpty);
    });

    test('getTransactionStatus maps confirmation states', () async {
      TezosConfirmationResult confirmationOf(TezosOperationStatus status) =>
          TezosConfirmationResult(operationHash: 'op', status: status);
      final block = _quick(
        (p) => throw StateError('unused'),
        confirmation: confirmationOf(TezosOperationStatus.applied),
      );
      expect(await block.getTransactionStatus('op'), TezosTxStatus.block);

      final failed = _quick(
        (p) => throw StateError('unused'),
        confirmation: confirmationOf(TezosOperationStatus.failed),
      );
      expect(await failed.getTransactionStatus('op'), TezosTxStatus.failed);

      final pending = _quick(
        (p) => throw StateError('unused'),
        confirmation: confirmationOf(TezosOperationStatus.pending),
      );
      expect(await pending.getTransactionStatus('op'), TezosTxStatus.pending);
    });
  });
}

void main() {
  OnChainUtilsTestApi.runTest(tezosTokenQuickApiTest, 'Tezos Token Quick Api');
}
