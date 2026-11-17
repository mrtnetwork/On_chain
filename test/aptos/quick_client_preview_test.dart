// Preview tests for the staged AptosQuickClientApi
// (test/aptos/quick_preview/). Offline stub-service tests only — no network.
//
// Covers every quick method against canned backend payloads, mirroring the
// wallet `AptosClientMethods` behavior the mixin ports.
import 'package:on_chain/exception/onchain_error.dart';

import 'package:blockchain_utils/blockchain_utils.dart';
import 'package:on_chain/aptos/aptos.dart';
import 'package:test/test.dart';

import '../utils.dart';

class _StubAptosService with AptosServiceProvider {
  final BaseServiceResponse Function(AptosRequestDetails params) respond;
  _StubAptosService(this.respond);

  @override
  Future<AptosServiceResponse> doRequest(
    AptosRequestDetails params, {
    Duration? timeout,
  }) async => respond(params);
}

BaseServiceResponse _ok(AptosRequestDetails params, Object payload) {
  final bytes =
      payload is String
          ? StringUtils.encode(payload)
          : StringUtils.encodeJson(payload);
  return params.toResponse(bytes);
}

BaseServiceResponse _graphQlOk(
  AptosRequestDetails params,
  Map<String, dynamic> data,
) {
  return _ok(params, {'data': data});
}

AptosQuickClient _quick(
  BaseServiceResponse Function(AptosRequestDetails params) respondFullnode,
  BaseServiceResponse Function(AptosRequestDetails params) respondGraphQl,
) {
  return DefaultAptosQuickClient(
    fullNodeProvider: AptosProvider(_StubAptosService(respondFullnode)),
    graphQlProvider: AptosProvider(_StubAptosService(respondGraphQl)),
  );
}

AptosQuickClient _quickFullnode(
  BaseServiceResponse Function(AptosRequestDetails params) respond,
) {
  return _quick(respond, (_) => throw StateError('graphQl must not be called'));
}

Map<String, dynamic> _userTxJson({required bool success}) => {
  'version': '1',
  'type': 'user_transaction',
  'hash': '0xabc',
  'state_change_hash': '0xdef',
  'event_root_hash': '0x123',
  'state_checkpoint_hash': '0x456',
  'gas_used': '10',
  'success': success,
  'vm_status': success ? 'Executed successfully' : 'Move abort',
  'accumulator_root_hash': '0x789',
  'changes': [],
  'sender': '0x1',
  'sequence_number': '0',
  'max_gas_amount': '100',
  'gas_unit_price': '100',
  'expiration_timestamp_secs': '9999999999',
  'payload': {
    'type': 'entry_function_payload',
    'function': '0x1::coin::transfer',
    'type_arguments': [],
    'arguments': [],
  },
  'signature': null,
  'events': [],
  'timestamp': '1700000000000000',
};

AptosSignedTransaction _signedTx() {
  final publicKey =
      AptosED25519PrivateKey.fromBytes(List<int>.filled(32, 12)).publicKey;
  final auth = AptosTransactionAuthenticatorEd25519(
    publicKey: publicKey,
    signature: AptosEd25519Signature(List<int>.filled(64, 0)),
  );
  final entry = AptosTransactionEntryFunction(
    moduleId: AptosModuleId(address: AptosAddress.one, name: 'coin'),
    functionName: 'transfer',
    args: [],
  );
  final raw = AptosRawTransaction(
    sender: AptosAddress.one,
    sequenceNumber: BigInt.one,
    transactionPayload: AptosTransactionPayloadEntryFunction(
      entryFunction: entry,
    ),
    maxGasAmount: BigInt.from(2000),
    gasUnitPrice: BigInt.from(100),
    expirationTimestampSecs: BigInt.from(9999999999),
    chainId: 1,
  );
  return AptosSignedTransaction(rawTransaction: raw, authenticator: auth);
}

Map<String, dynamic> _pendingTxJson({String hash = '0xdead'}) => {
  'hash': hash,
  'sender': '0x1',
  'sequence_number': '0',
  'max_gas_amount': '100',
  'gas_unit_price': '100',
  'expiration_timestamp_secs': '9999999999',
  'payload': {
    'type': 'entry_function_payload',
    'function': '0x1::coin::transfer',
    'type_arguments': [],
    'arguments': [],
  },
  'signature': null,
};

void aptosQuickClientPreviewTest() {
  group('Aptos/AptosQuickClientApi preview (offline)', () {
    test('getAccountBalance reads coin::balance view', () async {
      final quick = _quickFullnode((p) => _ok(p, ['1000']));
      expect(
        await quick.getAccountBalance(AptosAddress.one),
        BigInt.from(1000),
      );
    });

    test(
      'watchAccountTokenBalances merges indexer + fullnode backfill',
      () async {
        var calls = 0;
        final quick = _quick((p) => _ok(p, '250'), (p) {
          if (++calls > 1) {
            return _graphQlOk(p, {'current_fungible_asset_balances': []});
          }
          return _graphQlOk(p, {
            'current_fungible_asset_balances': [
              {
                'amount': '100',
                'asset_type': '0x1::coin::Coin',
                'is_frozen': false,
                'owner_address': AptosAddress.one.address,
                'storage_id': '0x1',
              },
            ],
          });
        });
        final balances =
            await quick
                .watchAccountTokenBalances(
                  address: AptosAddress.one,
                  assetTypes: ['0x1::coin::Coin', '0x2::other::Other'],
                )
                .expand((e) => e)
                .toList();
        expect(balances.length, 2);
        expect(balances.first.balance, BigInt.from(100));
        expect(balances.first.assetType, '0x1::coin::Coin');
        final backfilled = balances.last;
        expect(backfilled.balance, BigInt.from(250));
        expect(backfilled.frozen, isFalse);
        expect(backfilled.assetType, '0x2::other::Other');
      },
    );

    test('watchAccountTokenBalances throws on indexer failure', () async {
      final quick = _quick(
        (p) => _ok(p, '1'),
        (_) => throw const BuError(OnChainErrorType.aptosPlugin, 'indexer down'),
      );
      expect(
        () =>
            quick.watchAccountTokenBalances(address: AptosAddress.one).toList(),
        throwsA(isA<BuError>()),
      );
    });

    test('watchAccountFungibleTokens joins metadata, skips APT coin', () async {
      var calls = 0;
      final quick = _quick(
        (_) => throw StateError('fullnode must not be called'),
        (p) {
          calls++;
          if (calls == 1) {
            return _graphQlOk(p, {
              'current_fungible_asset_balances': [
                {
                  'amount': '50',
                  'asset_type': '0x2::usdc::USDC',
                  'is_frozen': true,
                  'owner_address': AptosAddress.one.address,
                  'storage_id': '0x2',
                },
                {
                  'amount': '5',
                  'asset_type': AptosConstants.aptosCoinAssetType,
                  'is_frozen': false,
                  'owner_address': AptosAddress.one.address,
                  'storage_id': '0x3',
                },
              ],
            });
          }
          return _graphQlOk(p, {
            'fungible_asset_metadata': [
              {
                'token_standard': 'v1',
                'symbol': 'USDC',
                'name': 'USD Coin',
                'decimals': 6,
                'creator_address': '0x2',
                'asset_type': '0x2::usdc::USDC',
                'icon_uri': 'https://example.com/usdc.png',
              },
            ],
          });
        },
      );
      final tokens =
          await quick
              .watchAccountFungibleTokens(AptosAddress.one)
              .expand((e) => e)
              .toList();
      expect(tokens.length, 1);
      final token = tokens.single;
      expect(token.symbol, 'USDC');
      expect(token.decimals, 6);
      expect(token.balance, BigInt.from(50));
      expect(token.isFrozen, isTrue);
      expect(token.iconUri, 'https://example.com/usdc.png');
    });

    test(
      'watchAccountFungibleTokens skips fractional exponent amounts',
      () async {
        var calls = 0;
        final quick = _quick(
          (_) => throw StateError('fullnode must not be called'),
          (p) {
            calls++;
            if (calls == 1) {
              return _graphQlOk(p, {
                'current_fungible_asset_balances': [
                  {
                    'amount': 1e21,
                    'asset_type': '0x2::big::BIG',
                    'is_frozen': false,
                    'owner_address': AptosAddress.one.address,
                    'storage_id': '0x2',
                  },
                  {
                    'amount': 1.5,
                    'asset_type': '0x2::odd::ODD',
                    'is_frozen': false,
                    'owner_address': AptosAddress.one.address,
                    'storage_id': '0x3',
                  },
                ],
              });
            }
            return _graphQlOk(p, {
              'fungible_asset_metadata': [
                {
                  'token_standard': 'v1',
                  'symbol': 'BIG',
                  'name': 'Big Token',
                  'decimals': 0,
                  'creator_address': '0x2',
                  'asset_type': '0x2::big::BIG',
                },
                {
                  'token_standard': 'v1',
                  'symbol': 'ODD',
                  'name': 'Odd Token',
                  'decimals': 0,
                  'creator_address': '0x2',
                  'asset_type': '0x2::odd::ODD',
                },
              ],
            });
          },
        );
        final tokens =
            await quick
                .watchAccountFungibleTokens(AptosAddress.one)
                .expand((e) => e)
                .toList();
        expect(tokens.length, 1);
        expect(tokens.single.symbol, 'BIG');
        expect(tokens.single.balance, BigInt.parse('1000000000000000000000'));
      },
    );

    test('getAccountSequence / gas / chainId / ledger info', () async {
      final quick = _quickFullnode(
        (p) => _ok(p, {'sequence_number': '7', 'authentication_key': '0x00'}),
      );
      expect(await quick.getAccountSequence(AptosAddress.one), BigInt.from(7));

      final gas = _quickFullnode(
        (p) => _ok(p, {
          'deprioritized_gas_estimate': 90,
          'gas_estimate': 100,
          'prioritized_gas_estimate': 120,
        }),
      );
      expect(await gas.getGasUnitPrice(), BigInt.from(100));

      Map<String, dynamic> ledger() => {
        'chain_id': 1,
        'epoch': '100',
        'ledger_version': '1000',
        'oldest_ledger_version': '0',
        'ledger_timestamp': '1700000000000000',
        'node_role': 'full_node',
        'oldest_block_height': '0',
        'block_height': '500',
      };
      final chain = _quickFullnode((p) => _ok(p, ledger()));
      expect(await chain.getChainId(), 1);
      expect((await chain.getLedgerInfo()).blockHeight, '500');
      expect(await chain.getBlockHeight(), BigInt.from(500));
    });

    test('simulateTransaction returns first user transaction', () async {
      final quick = _quickFullnode((p) => _ok(p, [_userTxJson(success: true)]));
      final sim = await quick.simulateTransaction(
        rawTransaction: _signedTx().rawTransaction,
        authenticator: _signedTx().authenticator,
      );
      expect(sim.success, isTrue);
      expect(sim.hash, '0xabc');
    });

    test('submitTransaction passes hash through, else local hash', () async {
      final tx = _signedTx();
      final passthrough = _quickFullnode((p) => _ok(p, _pendingTxJson()));
      final ok = await passthrough.submitTransaction(tx);
      expect(ok.hash, '0xdead');
      expect(ok.submitted, isTrue);

      final fallback = _quickFullnode((p) => _ok(p, {'sender': '0x1'}));
      final local = await fallback.submitTransaction(tx);
      expect(local.hash, tx.txHash());
      expect(local.submitted, isFalse);

      final broken = _quickFullnode(
        (_) => throw const BuError(OnChainErrorType.aptosPlugin, 'node down'),
      );
      expect(() => broken.submitTransaction(tx), throwsA(isA<Exception>()));
    });

    test('transactionStatus maps success flags', () async {
      var success = true;
      final quick = _quickFullnode(
        (p) => _ok(p, _userTxJson(success: success)),
      );
      expect(await quick.transactionStatus('0xabc'), AptosTxStatus.block);
      success = false;
      expect(await quick.transactionStatus('0xabc'), AptosTxStatus.failed);
    });

    test('transactionStatus throws on undecodable body', () async {
      final quick = _quickFullnode((p) => _ok(p, {'type': 'unknown_type'}));
      expect(() => quick.transactionStatus('0xabc'), throwsA(isA<Exception>()));
    });

    test('getCoinBalance reads single asset resource', () async {
      final quick = _quickFullnode((p) => _ok(p, '750'));
      expect(
        await quick.getCoinBalance(
          owner: AptosAddress.one,
          assetType: '0x1::aptos_coin::AptosCoin',
        ),
        BigInt.from(750),
      );
    });

    test('trackTransaction completes, fails and times out', () async {
      final quick = _quickFullnode((p) => _ok(p, _userTxJson(success: true)));
      await quick.trackTransaction(
        transactionId: '0xabc',
        periodicTimeOut: const Duration(milliseconds: 10),
      );

      final failed = _quickFullnode((p) => _ok(p, _userTxJson(success: false)));
      expect(
        () => failed.trackTransaction(
          transactionId: '0xabc',
          periodicTimeOut: const Duration(milliseconds: 10),
        ),
        throwsA(isA<BuError>()),
      );

      final never = _quickFullnode(
        (p) => _ok(p, {'type': 'pending_transaction'}),
      );
      expect(
        () => never.trackTransaction(
          transactionId: '0xabc',
          timeout: const Duration(milliseconds: 50),
          periodicTimeOut: const Duration(milliseconds: 10),
        ),
        throwsA(isA<BuError>()),
      );
    });

    test('buildTransaction fetches sequence, chain and gas', () async {
      final quick = _quickFullnode((p) {
        final path = p.path ?? '';
        if (path.contains('estimate_gas_price')) {
          return _ok(p, {
            'deprioritized_gas_estimate': 90,
            'gas_estimate': 100,
            'prioritized_gas_estimate': 120,
          });
        }
        if (path == '/') {
          return _ok(p, {
            'chain_id': 1,
            'epoch': '100',
            'ledger_version': '1000',
            'oldest_ledger_version': '0',
            'ledger_timestamp': '1700000000000000',
            'node_role': 'full_node',
            'oldest_block_height': '0',
            'block_height': '500',
          });
        }
        return _ok(p, {'sequence_number': '7', 'authentication_key': '0x00'});
      });
      final entry = quick.fungibleAssetTransferEntry(
        assetType: AptosAddress.one,
        recipient: AptosAddress.one,
        amount: BigInt.from(10),
      );
      final raw = await quick.buildTransaction(
        sender: AptosAddress.one,
        entry: entry,
      );
      expect(raw.sequenceNumber, BigInt.from(7));
      expect(raw.chainId, 1);
      expect(raw.gasUnitPrice, BigInt.from(100));
      expect(raw.maxGasAmount, AptosConstants.defaultMaxGasAmount);
    });

    test('getFungibleAssetMetadata hit and miss', () async {
      final hit = _quick(
        (_) => throw StateError('fullnode must not be called'),
        (p) => _graphQlOk(p, {
          'fungible_asset_metadata': [
            {
              'token_standard': 'v1',
              'symbol': 'USDC',
              'name': 'USD Coin',
              'decimals': 6,
              'creator_address': '0x2',
              'asset_type': '0x2::usdc::USDC',
              'icon_uri': 'https://example.com/usdc.png',
            },
          ],
        }),
      );
      final meta = await hit.getFungibleAssetMetadata('0x2::usdc::USDC');
      expect(meta, isNotNull);
      expect(meta!.symbol, 'USDC');
      expect(meta.decimals, 6);

      final miss = _quick(
        (_) => throw StateError('fullnode must not be called'),
        (p) => _graphQlOk(p, {'fungible_asset_metadata': []}),
      );
      expect(await miss.getFungibleAssetMetadata('0x2::usdc::USDC'), isNull);
    });

    test('watchAccountNFTs filters to singly-held v2 assets', () async {
      Map<String, dynamic> ownership({
        required String amount,
        required bool fungible,
        required String tokenDataId,
        required String tokenName,
      }) => {
        'token_standard': 'v2',
        'amount': amount,
        'is_fungible_v2': fungible,
        'token_data_id': tokenDataId,
        'storage_id': '0x9',
        'owner_address': AptosAddress.one.address,
        'current_token_data': {
          'token_data_id': tokenDataId,
          'token_name': tokenName,
          'token_standard': 'v2',
          'collection_id': 'c1',
          'description': 'd',
          'token_uri': 'u',
          'current_collection': {
            'collection_id': 'c1',
            'collection_name': 'col1',
            'creator_address': '0x2',
            'description': 'd',
            'token_standard': 'v2',
            'uri': 'u',
          },
        },
      };
      final quick = _quick(
        (_) => throw StateError('fullnode must not be called'),
        (p) => _graphQlOk(p, {
          'current_token_ownerships_v2': [
            ownership(
              amount: '1',
              fungible: false,
              tokenDataId: '0xt1',
              tokenName: 'nft1',
            ),
            ownership(
              amount: '2',
              fungible: false,
              tokenDataId: '0xt2',
              tokenName: 'edition',
            ),
            ownership(
              amount: '1',
              fungible: true,
              tokenDataId: '0xt3',
              tokenName: 'fa-pos',
            ),
          ],
        }),
      );
      final nfts =
          await quick
              .watchAccountNFTs(AptosAddress.one)
              .expand((e) => e)
              .toList();
      expect(nfts.length, 1);
      expect(nfts.single.tokenDataId, '0xt1');
      expect(nfts.single.collectionName, 'col1');
    });

    test('watchAccountNFTs streams one page per event', () async {
      Map<String, dynamic> row(String tokenDataId) => {
        'token_standard': 'v2',
        'amount': '1',
        'is_fungible_v2': false,
        'token_data_id': tokenDataId,
        'storage_id':
            '0x0000000000000000000000000000000000000000000000000000000000000009',
        'owner_address': AptosAddress.one.address,
        'current_token_data': {
          'token_data_id': tokenDataId,
          'token_name': 'nft',
          'token_standard': 'v2',
          'collection_id': 'c1',
          'description': 'd',
          'token_uri': 'u',
          'current_collection': {
            'collection_id': 'c1',
            'collection_name': 'col1',
            'creator_address': '0x2',
            'description': 'd',
            'token_standard': 'v2',
            'uri': 'u',
          },
        },
      };
      var calls = 0;
      final quick = _quick(
        (_) => throw StateError('fullnode must not be called'),
        (p) {
          if (++calls > 2) {
            return _graphQlOk(p, {'current_token_ownerships_v2': []});
          }
          return _graphQlOk(p, {
            'current_token_ownerships_v2': [row('0xt$calls')],
          });
        },
      );
      final pages =
          await quick.watchAccountNFTs(AptosAddress.one, limit: 1).toList();
      expect(pages.length, 2);
      expect(pages.expand((e) => e).map((e) => e.tokenDataId), [
        '0xt1',
        '0xt2',
      ]);
    });

    test('delegation reads: pools, top, positions, all', () async {
      final quick = _quick(
        (p) => _ok(p, ['100', '200', '300']),
        (p) => _graphQlOk(p, {
          'delegator_distinct_pool': [
            {
              'pool_address':
                  '0x0000000000000000000000000000000000000000000000000000000000000001',
            },
          ],
          'current_delegated_staking_pool_balances': [
            {
              'staking_pool_address':
                  '0x0000000000000000000000000000000000000000000000000000000000000001',
              'total_coins': '1000',
              'operator_commission_percentage': '5',
            },
          ],
          'delegated_staking_pools': [
            {
              'staking_pool_address':
                  '0x0000000000000000000000000000000000000000000000000000000000000001',
            },
          ],
        }),
      );
      expect(await quick.getDelegatorPools(AptosAddress.one), [
        '0x0000000000000000000000000000000000000000000000000000000000000001',
      ]);
      final top = await quick.getTopDelegationPools();
      expect(
        top.single.pool,
        '0x0000000000000000000000000000000000000000000000000000000000000001',
      );
      expect(top.single.totalCoins, BigInt.from(1000));
      final positions = await quick.getChainDelegations(AptosAddress.one);
      expect(positions.single.active, BigInt.from(100));
      expect(positions.single.total, BigInt.from(600));
      expect(await quick.getAllDelegationPools(), [
        '0x0000000000000000000000000000000000000000000000000000000000000001',
      ]);
    });

    test('getNftObjectAddress hit and miss', () async {
      Map<String, dynamic> row(String storageId) => {
        'token_standard': 'v2',
        'amount': '1',
        'is_fungible_v2': false,
        'token_data_id': '0xt1',
        'storage_id': storageId,
        'owner_address': AptosAddress.one.address,
      };
      final hit = _quick(
        (_) => throw StateError('fullnode must not be called'),
        (p) => _graphQlOk(p, {
          'current_token_ownerships_v2': [
            row(
              '0x0000000000000000000000000000000000000000000000000000000000000009',
            ),
          ],
        }),
      );
      expect(
        await hit.getNftObjectAddress(
          owner: AptosAddress.one,
          tokenDataId: '0xt1',
        ),
        AptosAddress(
          '0x0000000000000000000000000000000000000000000000000000000000000009',
        ),
      );
      final miss = _quick(
        (_) => throw StateError('fullnode must not be called'),
        (p) => _graphQlOk(p, {'current_token_ownerships_v2': []}),
      );
      expect(
        await miss.getNftObjectAddress(
          owner: AptosAddress.one,
          tokenDataId: '0xt1',
        ),
        isNull,
      );
    });

    test('entry builders shape payloads', () async {
      final quick = _quickFullnode(
        (_) => throw StateError('must not be called'),
      );
      final fa = quick.fungibleAssetTransferEntry(
        assetType: AptosAddress.one,
        recipient: AptosAddress.one,
        amount: BigInt.from(10),
      );
      expect(fa.functionName, 'transfer');

      final obj = quick.objectTransferEntry(
        object: AptosAddress.one,
        recipient: AptosAddress.one,
      );
      expect(obj.functionName, 'transfer');

      expect(
        quick
            .delegationStakeEntry(pool: AptosAddress.one, amount: BigInt.one)
            .functionName,
        'add_stake',
      );
      expect(
        quick
            .delegationUnstakeEntry(pool: AptosAddress.one, amount: BigInt.one)
            .functionName,
        'unlock',
      );
      expect(
        quick
            .delegationWithdrawEntry(pool: AptosAddress.one, amount: BigInt.one)
            .functionName,
        'withdraw',
      );
    });
  });
}

void main() {
  OnChainUtilsTestApi.runTest(
    aptosQuickClientPreviewTest,
    'Aptos Quick Client Preview',
  );
}
