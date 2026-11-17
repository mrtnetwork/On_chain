// Offline tests for the Hedera token additions
// (lib/hedera/src/rpc/api/api/client/client.dart). Stub-service tests only
// — no network (mirror REST stubs; node gRPC untouched).
import 'package:blockchain_utils/blockchain_utils.dart';
import 'package:on_chain/hedera/hedera.dart';
import 'package:on_chain/hedera/src/proto_messages/proto/src/basic_types.dart';
import 'package:on_chain/hedera/src/proto_messages/proto/src/transaction.dart';
import 'package:test/test.dart';

import '../utils.dart';

class _StubMirrorService with HederaServiceProvider {
  final BaseServiceResponse Function(HederaMirrorRequestDetails params)
  respond;
  _StubMirrorService(this.respond);

  @override
  Future<BaseServiceResponse> doRequest(
    HederaMirrorRequestDetails params, {
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

BaseServiceResponse _ok(
  HederaMirrorRequestDetails params,
  Object payload,
) {
  return params.toResponse(StringUtils.encodeJson(payload));
}

BaseServiceResponse _notFound(HederaMirrorRequestDetails params) {
  return params.toResponse(
    StringUtils.encodeJson({'message': 'Not Found'}),
    statusCode: 404,
  );
}

BaseServiceResponse _serverError(HederaMirrorRequestDetails params) {
  return params.toResponse(
    StringUtils.encodeJson({'message': 'internal error'}),
    statusCode: 500,
  );
}

class _Client extends HederaClient {
  _Client(this._provider);

  final HederaProvider<_StubMirrorService> _provider;

  @override
  HederaNetwork get network => HederaNetwork.testnet;

  @override
  IGrpcProvider<
    IServiceProvider,
    BaseHederaServiceRequestParams,
    BaseGRPCServiceRequestParams
  >
  get internalProvider => _provider;

  @override
  HederaAccountID get nodeAccountId => throw UnimplementedError();

  @override
  HederaClientSterategy get strategy => const HederaClientSterategy();
}

HederaClient _quick(
  BaseServiceResponse Function(HederaMirrorRequestDetails params) respond,
) {
  return _Client(HederaProvider(_StubMirrorService(respond)));
}

Map<String, dynamic> _accountStub({
  required int balance,
  List<Map<String, dynamic>> tokens = const [],
}) => {
  'account': '0.0.100',
  'alias': '0.0.100',
  'auto_renew_period': '7776000',
  'balance': {
    'timestamp': '1700000000.000000000',
    'balance': balance,
    'tokens': tokens,
  },
  'created_timestamp': '1700000000.000000000',
  'decline_reward': false,
  'deleted': false,
  'ethereum_nonce': 0,
  'evm_address': '0x0000000000000000000000000000000000000064',
  'expiry_timestamp': '1800000000.000000000',
  'memo': '',
  'max_automatic_token_associations': 0,
  'pending_reward': 0,
  'receiver_sig_required': false,
  'staked_account_id': '0.0.0',
  'staked_node_id': 0,
  'stake_period_start': '1700000000.000000000',
  'transactions': [],
  'links': {},
};

Map<String, dynamic> _tokenEntry({
  required String tokenId,
  required int balance,
}) => {'token_id': tokenId, 'balance': balance};

void hederaTokenClientTest() {
  const owner = '0.0.100';
  const token = '0.0.200';

  group('Hedera/Client token additions (offline)', () {
    test('getTokenBalance hits and misses', () async {
      final quick = _quick(
        (p) => _ok(p, _accountStub(balance: 1000, tokens: [
          _tokenEntry(tokenId: token, balance: 5),
        ])),
      );
      final addr = HederaAddress(owner);
      final tokenId = HederaAddress(token);
      expect(
        await quick.getTokenBalance(tokenId: tokenId, owner: addr),
        BigInt.from(5),
      );
      expect(
        await quick.getTokenBalance(
          tokenId: HederaAddress('0.0.201'),
          owner: addr,
        ),
        BigInt.zero,
      );
      final balances = await quick.getAccountTokenBalances(addr);
      expect(balances[tokenId], BigInt.from(5));
    });

    test('getFungibleTokenMetadata maps type-gated fields', () async {
      final quick = _quick(
        (p) => _ok(p, {
          'name': 'Name',
          'symbol': 'SYM',
          'decimals': '6',
          'type': 'FUNGIBLE_COMMON',
        }),
      );
      final meta = await quick.getFungibleTokenMetadata(HederaAddress(token));
      expect(meta, isNotNull);
      expect(meta!.name, 'Name');
      expect(meta.decimals, 6);

      final nft = _quick(
        (p) => _ok(p, {
          'name': 'N',
          'symbol': 'S',
          'decimals': '0',
          'type': 'NON_FUNGIBLE_UNIQUE',
        }),
      );
      expect(
        await nft.getFungibleTokenMetadata(HederaAddress(token)),
        isNull,
      );
    });

    test('getAccountNfts filters deleted and serial-less', () async {
      Map<String, dynamic> nft({
        required int serial,
        bool deleted = false,
      }) => {
        'serial_number': serial,
        'token_id': token,
        'deleted': deleted,
        'metadata': '',
      };
      final quick = _quick(
        (p) => _ok(p, {
          'nfts': [
            nft(serial: 1),
            nft(serial: 2, deleted: true),
          ],
        }),
      );
      final nfts = await quick.getAccountNfts(HederaAddress(owner));
      expect(nfts.length, 1);
      expect(nfts.single.serialNumber, BigInt.from(1));
    });

    test('getAccountInfo null on 404, throws otherwise', () async {
      final hit = _quick(
        (p) => _ok(p, _accountStub(balance: 0)),
      );
      final info = await hit.getAccountInfo(HederaAddress(owner));
      expect(info, isNotNull);
      expect(
        await hit.resolveAccountId(HederaAddress(owner)),
        HederaAddress(owner),
      );

      final missing = _quick(_notFound);
      expect(
        await missing.getAccountInfo(HederaAddress(owner)),
        isNull,
      );
      expect(
        await missing.resolveAccountId(HederaAddress(owner)),
        isNull,
      );

      final broken = _quick(_serverError);
      expect(
        () => broken.getAccountInfo(HederaAddress(owner)),
        throwsA(isA<RPCError>()),
      );
    });

    test('getTransactionStatus maps result/missing/failure', () async {
      Map<String, dynamic> tx({String? result}) => {
        'transactions': [
          if (result != null) {'result': result},
        ],
      };
      final block = _quick((p) => _ok(p, tx(result: 'SUCCESS')));
      expect(
        await block.getTransactionStatus('0.0.100-1000-0'),
        HederaTxStatus.block,
      );

      final failed = _quick((p) => _ok(p, tx(result: 'INSUFFICIENT_TX_FEE')));
      expect(
        await failed.getTransactionStatus('0.0.100-1000-0'),
        HederaTxStatus.failed,
      );

      final empty = _quick((p) => _ok(p, tx()));
      expect(
        await empty.getTransactionStatus('0.0.100-1000-0'),
        HederaTxStatus.pending,
      );

      expect(
        await block.getTransactionStatus('garbage!!'),
        HederaTxStatus.unknown,
      );

      final missing = _quick(_notFound);
      expect(
        await missing.getTransactionStatus('0.0.100-1000-0'),
        HederaTxStatus.pending,
      );

      final broken = _quick(_serverError);
      expect(
        () => broken.getTransactionStatus('0.0.100-1000-0'),
        throwsA(isA<RPCError>()),
      );
    });

    test('estimateBodyFee converts with margin', () async {
      var calls = 0;
      final quick = _quick((p) {
        if (++calls == 1) {
          return _ok(p, {
            'total': '100',
            'high_volume_multiplier': '1',
            'network': {'multiplier': 1, 'subtotal': '50'},
            'node': {'base': '10', 'extras': []},
            'service': {'base': '10', 'extras': []},
          });
        }
        return _ok(p, {
          'network': 'mainnet',
          'timestamp': '1700000000.000000000',
          'current_rate': {
            'hbar_equivalent': 30000,
            'cent_equivalent': 300000,
            'expiration_time': 100,
          },
        });
      });
      final body = HederaTransactionBody();
      final fee = await quick.estimateBodyFee(
        body: body,
        totalSignature: 1,
        feeMultiplier: 10,
      );
      // raw = 100 * 30000 / 300000 = 10; fee = 10 * 10 + 1 = 101.
      expect(fee, BigInt.from(101));
    });
  });
}

void main() {
  OnChainUtilsTestApi.runTest(hederaTokenClientTest, 'Hedera Token Client');
}
