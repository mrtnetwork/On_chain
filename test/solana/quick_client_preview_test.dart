// Preview tests for the staged SolanaQuickClientApi
// (test/solana/quick_preview/). Offline stub-service tests only — no network.
import 'dart:async';

import 'package:blockchain_utils/blockchain_utils.dart';
import 'package:on_chain/solana/solana.dart';
import 'package:test/test.dart';

import '../utils.dart';

const String _systemProgram = '11111111111111111111111111111111';
const String _tokenProgram = 'TokenkegQfeZyiNwAJbNbGKPFXCWuBvf9Ss623VQ5DA';
const String _usdcMint = 'EPjFWdd5AufqSSqeM2qN1xzybapC8G4wEGGkZwyTDt1v';

class _StubSolanaService with SolanaServiceProvider {
  final BaseServiceResponse Function(SolanaRequestDetails params) respond;
  _StubSolanaService(this.respond);

  @override
  Future<BaseServiceResponse> doRequest(
    SolanaRequestDetails params, {
    Duration? timeout,
  }) async => respond(params);
}

BaseServiceResponse _ok(SolanaRequestDetails params, Object? result) {
  return params.toResponse({
    'jsonrpc': '2.0',
    'id': params.requestID,
    'result': result,
  });
}

BaseServiceResponse _valued(SolanaRequestDetails params, Object? value) {
  return _ok(params, {
    'context': {'slot': 1},
    'value': value,
  });
}

Map<String, dynamic> _accountJson({
  required String lamports,
  required String owner,
  Object? data,
}) => {
  'executable': false,
  'lamports': lamports,
  'owner': owner,
  'rentEpoch': 0.0,
  'space': 165,
  'data': data ?? ['', 'base64'],
};

String _tokenAccountData({
  required String mint,
  required String owner,
  required int amount,
}) {
  final account = SolanaTokenAccount(
    address: SolAddress(_systemProgram),
    mint: SolAddress(mint),
    owner: SolAddress(owner),
    amount: BigInt.from(amount),
    delegate: null,
    delegatedAmount: BigInt.zero,
    state: AccountState.initialized,
    rentExemptReserve: null,
    closeAuthority: null,
  );
  return StringUtils.decode(account.toBytes(), encoding: StringEncoding.base64);
}

String _mintAccountData({required int decimals}) {
  final mint = SolanaMintAccount(
    address: SolAddress(_usdcMint),
    mintAuthority: null,
    supply: BigInt.from(1000000),
    decimals: decimals,
    isInitialized: true,
    freezeAuthority: null,
  );
  return StringUtils.decode(mint.toBytes(), encoding: StringEncoding.base64);
}

Map<String, dynamic> _statusJson({String? confirmationStatus, Object? err}) => {
  'slot': 1,
  'confirmations': null,
  'err': err,
  'confirmationStatus': confirmationStatus,
};

SolanaQuickClient _quick(
  BaseServiceResponse Function(SolanaRequestDetails params) respond,
) {
  return DefaultSolanaQuickClient(
    provider: SolanaProvider(_StubSolanaService(respond)),
  );
}

/// RPC method name of a built request (stable discriminator for stubs).
String _rpcMethod(SolanaRequestDetails params) => params.method;

SolanaTransaction _tx() {
  return SolanaTransaction(
    payerKey: SolAddress(_systemProgram),
    recentBlockhash: SolAddress(_systemProgram),
    instructions: [MemoProgram(layout: MemoLayout.fromString('preview'))],
  );
}

void solanaQuickClientPreviewTest() {
  group('Solana/Quick Client Preview (Offline)', () {
    test('getAccountBalance / getAccountInfo', () async {
      final quick = _quick(
        (p) =>
            _valued(p, _accountJson(lamports: '1000', owner: _systemProgram)),
      );
      final addr = SolAddress(_systemProgram);
      expect(await quick.getAccountBalance(addr), BigInt.from(1000));
      expect(await quick.getBalance(addr), BigInt.from(1000));
      final info = await quick.getAccountInfo(addr);
      expect(info, isNotNull);
      expect(info!.owner.address, _systemProgram);

      final missing = _quick((p) => _valued(p, null));
      expect(await missing.getAccountBalance(addr), BigInt.zero);
      expect(await missing.getAccountInfo(addr), isNull);
    });

    test('getTokenAccount / getTokenAddressBalance', () async {
      final quick = _quick(
        (p) => _valued(
          p,
          _accountJson(
            lamports: '2039280',
            owner: _tokenProgram,
            data: [
              _tokenAccountData(
                mint: _usdcMint,
                owner: _systemProgram,
                amount: 500,
              ),
              'base64',
            ],
          ),
        ),
      );
      final token = await quick.getTokenAccount(SolAddress(_systemProgram));
      expect(token, isNotNull);
      expect(token!.amount, BigInt.from(500));
      expect(token.mint.address, _usdcMint);
      expect(
        await quick.getTokenAddressBalance(SolAddress(_systemProgram)),
        BigInt.from(500),
      );

      final missing = _quick((p) => _valued(p, null));
      expect(await missing.getTokenAccount(SolAddress(_systemProgram)), isNull);
      expect(
        await missing.getTokenAddressBalance(SolAddress(_systemProgram)),
        BigInt.zero,
      );
    });

    test('getRent / getFee', () async {
      final rent = _quick((p) => _valued(p, 890880));
      expect(await rent.getRent(165), BigInt.from(890880));

      final fee = _quick((p) => _valued(p, 5000));
      expect(await fee.getFee(_tx()), BigInt.from(5000));

      final noFee = _quick((p) => _valued(p, null));
      expect(await noFee.getFee(_tx()), isNull);
    });

    test('simulate returns the simulated response', () async {
      final quick = _quick(
        (p) => _valued(p, {
          'err': null,
          'logs': ['Program log: preview'],
        }),
      );
      final sim = await quick.simulate(transaction: _tx());
      expect(sim.err, isNull);
      expect(sim.logs, ['Program log: preview']);
    });

    test('getBlockHash / getGenesis / validate / blockHeight', () async {
      Map<String, dynamic> blockhash() => {
        'blockhash': _systemProgram,
        'lastValidBlockHeight': 1,
      };
      final quick = _quick((p) {
        final method = _rpcMethod(p);
        if (method.contains('getGenesisHash')) return _ok(p, 'genesis-hash');
        if (method.contains('getBlockHeight')) return _ok(p, 100);
        return _valued(p, blockhash());
      });
      expect((await quick.getBlockHash()).address, _systemProgram);
      expect(await quick.getGenesis(), 'genesis-hash');
      expect(await quick.validateNetworkGenesis('genesis-hash'), isTrue);
      expect(await quick.validateNetworkGenesis('other'), isFalse);
      expect(await quick.getBlockHeight(), BigInt.from(100));
    });

    test('clusterNodes parses node list', () async {
      final quick = _quick(
        (p) => _ok(p, [
          {
            'pubkey': _systemProgram,
            'gossip': '127.0.0.1:8001',
            'tpu': '127.0.0.1:8003',
            'rpc': '127.0.0.1:8899',
            'version': '1.0.0',
          },
        ]),
      );
      final nodes = await quick.clusterNodes();
      expect(nodes.length, 1);
      expect(nodes.single.version, '1.0.0');
    });

    test('getMintAccount returns null when missing', () async {
      final quick = _quick(
        (p) => _valued(
          p,
          _accountJson(
            lamports: '1461600',
            owner: _tokenProgram,
            data: [_mintAccountData(decimals: 6), 'base64'],
          ),
        ),
      );
      final mint = await quick.getMintAccount(SolAddress(_usdcMint));
      expect(mint, isNotNull);
      expect(mint!.decimals, 6);

      final missing = _quick((p) => _valued(p, null));
      expect(await missing.getMintAccount(SolAddress(_usdcMint)), isNull);
    });

    test('getAccountSPLTokenBalances joins mint decimals', () async {
      final tokenData = _tokenAccountData(
        mint: _usdcMint,
        owner: _systemProgram,
        amount: 50,
      );
      BaseServiceResponse respond(SolanaRequestDetails params) {
        if (_rpcMethod(params).contains('getTokenAccountsByOwner')) {
          return _valued(params, [
            {
              'pubkey': _systemProgram,
              'account': _accountJson(
                lamports: '2039280',
                owner: _tokenProgram,
                data: [tokenData, 'base64'],
              ),
            },
          ]);
        }
        return _valued(
          params,
          _accountJson(
            lamports: '1461600',
            owner: _tokenProgram,
            data: [_mintAccountData(decimals: 6), 'base64'],
          ),
        );
      }

      final quick = _quick(respond);
      final balances = await quick.getAccountSPLTokenBalances(
        SolAddress(_systemProgram),
      );
      expect(balances.length, 1);
      expect(balances.single.amount, BigInt.from(50));
      expect(balances.single.mint.address, _usdcMint);
      expect(balances.single.decimals, 6);

      final empty = _quick((p) => _valued(p, []));
      expect(
        await empty.getAccountSPLTokenBalances(SolAddress(_systemProgram)),
        isEmpty,
      );
    });

    test('getTokenAccountAddress derives PDA, validates mint owner', () async {
      final quick = _quick(
        (p) =>
            _valued(p, _accountJson(lamports: '1461600', owner: _tokenProgram)),
      );
      final resolved = await quick.getTokenAccountAddress(
        account: SolAddress(_systemProgram),
        mint: SolAddress(_usdcMint),
      );
      expect(resolved.tokenProgramId.address, _tokenProgram);
      expect(
        resolved.pdaAddress,
        AssociatedTokenAccountProgramUtils.associatedTokenAccount(
          mint: SolAddress(_usdcMint),
          owner: SolAddress(_systemProgram),
          tokenProgramId: SolAddress(_tokenProgram),
          allowOwnerOffCurve: true,
        ).address,
      );

      final missing = _quick((p) => _valued(p, null));
      expect(
        () => missing.getTokenAccountAddress(
          account: SolAddress(_systemProgram),
          mint: SolAddress(_usdcMint),
        ),
        throwsA(isA<BuError>()),
      );

      final badOwner = _quick(
        (p) => _valued(p, _accountJson(lamports: '1', owner: _systemProgram)),
      );
      expect(
        () => badOwner.getTokenAccountAddress(
          account: SolAddress(_systemProgram),
          mint: SolAddress(_usdcMint),
        ),
        throwsA(isA<BuError>()),
      );
    });

    test('getTokenBalance reads derived token account', () async {
      final tokenData = _tokenAccountData(
        mint: _usdcMint,
        owner: _systemProgram,
        amount: 75,
      );
      final quick = _quick(
        (p) => _valued(
          p,
          _accountJson(
            lamports: '2039280',
            owner: _tokenProgram,
            data: [tokenData, 'base64'],
          ),
        ),
      );
      expect(
        await quick.getTokenBalance(
          account: SolAddress(_systemProgram),
          mint: SolAddress(_usdcMint),
          tokenProgramId: SolAddress(_tokenProgram),
        ),
        BigInt.from(75),
      );
    });

    test('sendTransaction returns signature', () async {
      final quick = _quick((p) => _ok(p, 'sig123'));
      expect(await quick.sendTransaction(_tx()), 'sig123');
    });

    test('transactionStatus maps signature statuses', () async {
      SolanaQuickClient stub(Object? status) =>
          _quick((p) => _valued(p, status == null ? [null] : [status]));
      expect(
        await stub(
          _statusJson(confirmationStatus: 'finalized'),
        ).transactionStatus('sig'),
        SolanaTxStatus.block,
      );
      expect(
        await stub(
          _statusJson(confirmationStatus: 'confirmed'),
        ).transactionStatus('sig'),
        SolanaTxStatus.pending,
      );
      expect(
        await stub(
          _statusJson(err: {'InstructionError': 'x'}),
        ).transactionStatus('sig'),
        SolanaTxStatus.failed,
      );
      expect(await stub(null).transactionStatus('sig'), SolanaTxStatus.unknown);
      expect(
        await _quick((p) => _valued(p, [])).transactionStatus('sig'),
        SolanaTxStatus.unknown,
      );
    });

    test('getTokenMetadataAccount reads metaplex metadata', () async {
      final metadata = Metadata(
        key: MetaDataKey.metadataV1,
        updateAuthority: SolAddress(_systemProgram),
        mint: SolAddress(_usdcMint),
        data: MetaDataData(
          name: 'USD Coin',
          symbol: 'USDC',
          uri: 'https://example.com/usdc.json',
          sellerFeeBasisPoints: 0,
        ),
        primarySaleHappened: true,
        isMutable: true,
        editionNonce: null,
        tokenStandard: null,
        collection: null,
        uses: null,
        collectionDetails: null,
        programmableConfigRecord: null,
      );
      final encoded = StringUtils.decode(
        metadata.toBytes(),
        encoding: StringEncoding.base64,
      );
      final quick = _quick(
        (p) => _valued(
          p,
          _accountJson(
            lamports: '1',
            owner: _tokenProgram,
            data: [encoded, 'base64'],
          ),
        ),
      );
      final read = await quick.getTokenMetadataAccount(SolAddress(_usdcMint));
      expect(read, isNotNull);
      expect(read!.data.name, 'USD Coin');
      expect(read.data.symbol, 'USDC');

      final missing = _quick((p) => _valued(p, null));
      expect(
        await missing.getTokenMetadataAccount(SolAddress(_usdcMint)),
        isNull,
      );
    });

    test(
      'trackTransaction completes on finalize, times out otherwise',
      () async {
        final quick = _quick(
          (p) => _valued(p, [_statusJson(confirmationStatus: 'finalized')]),
        );
        expect(
          await quick.trackTransaction(
            transactionId: 'sig',
            periodicTimeOut: const Duration(milliseconds: 10),
          ),
          TransactionConfirmationStatus.finalized,
        );

        final never = _quick((p) => _valued(p, [null]));
        expect(
          () => never.trackTransaction(
            transactionId: 'sig',
            timeout: const Duration(milliseconds: 50),
            periodicTimeOut: const Duration(milliseconds: 10),
          ),
          throwsA(isA<BuError>()),
        );

        final failing = _quick(
          (p) => _valued(p, [
            _statusJson(err: {'InstructionError': 'x'}),
          ]),
        );
        expect(
          () => failing.trackTransaction(
            transactionId: 'sig',
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
    solanaQuickClientPreviewTest,
    'Solana Quick Client Preview',
  );
}
