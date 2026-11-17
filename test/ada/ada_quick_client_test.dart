// Offline tests for the Cardano quick client
// (lib/ada/src/provider/quick/). Stub-service tests only — no network.
import 'package:blockchain_utils/blockchain_utils.dart';
import 'package:on_chain/ada/ada.dart';
import 'package:test/test.dart';

import '../utils.dart';

const String _address =
    'addr_test1qz2fxv2umyhttkxyxp8x0dlpdt3k6cwng5pxj3jhsydzer3jcu5d8ps7zex2k2xt3uqxgjqnnj83ws8lhrn648jjxtwq2ytjqp';
const String _txHash =
    'abababababababababababababababababababababababababababababababab';
const String _blockHash =
    'cdcdcdcdcdcdcdcdcdcdcdcdcdcdcdcdcdcdcdcdcdcdcdcdcdcdcdcdcdcdcdcd';

class _StubBlockfrostService with BlockFrostServiceProvider {
  final BaseServiceResponse Function(BlockFrostRequestDetails params) respond;
  _StubBlockfrostService(this.respond);

  @override
  Future<BaseServiceResponse> doRequest(
    BlockFrostRequestDetails params, {
    Duration? timeout,
  }) async => respond(params);
}

BaseServiceResponse _ok(BlockFrostRequestDetails params, Object payload) {
  return params.toResponse(StringUtils.encodeJson(payload));
}

BaseServiceResponse _notFound(BlockFrostRequestDetails params) {
  return params.toResponse(
    StringUtils.encodeJson({'message': 'Not Found'}),
    statusCode: 404,
  );
}

BaseServiceResponse _serverError(BlockFrostRequestDetails params) {
  return params.toResponse(
    StringUtils.encodeJson({'message': 'internal error'}),
    statusCode: 500,
  );
}

class _Client with AdaQuickClientApi {
  _Client(this._provider);

  final BlockFrostProvider<_StubBlockfrostService> _provider;

  @override
  IProvider<IServiceProvider, BlockFrostRequestDetails> get provider =>
      _provider;
}

AdaQuickClientApi _quick(
  BaseServiceResponse Function(BlockFrostRequestDetails params) respond,
) {
  return _Client(BlockFrostProvider(_StubBlockfrostService(respond)));
}

Map<String, dynamic> _utxo({required int index, required int lovelace}) => {
  'address': _address,
  'tx_hash': _txHash,
  'output_index': index,
  'amount': [
    {'unit': 'lovelace', 'quantity': lovelace.toString()},
    {'unit': 'policyasset', 'quantity': '3'},
  ],
  'block': _blockHash,
};

/// Minimal roundtrippable transaction with one output at [index]-addressable
/// position 0 holding [lovelace].
String _txCbor() {
  final tx = ADATransaction(
    body: TransactionBody(
      inputs: TransactionInputs([]),
      outputs: TransactionOutputs([
        TransactionOutput(
          address: ADAAddress.fromAddress(_address),
          amount: Value(coin: BigInt.from(1000)),
        ),
      ]),
      fee: BigInt.from(200),
    ),
    witnessSet: TransactionWitnessSet(),
  );
  return BytesUtils.toHexString(tx.toCbor().encode());
}

void adaQuickClientTest() {
  group('ADA/QuickClientApi Additions (Offline)', () {
    test('watchAccountUtxos streams pages', () async {
      var calls = 0;
      final quick = _quick((p) {
        if (++calls == 1) {
          return _ok(p, [
            _utxo(index: 0, lovelace: 1000),
            _utxo(index: 1, lovelace: 2000),
          ]);
        }
        return _ok(p, [_utxo(index: 2, lovelace: 3000)]);
      });
      final pages =
          await quick
              .watchAccountUtxos(ADAAddress.fromAddress(_address), count: 2)
              .toList();
      expect(pages.length, 2);
      expect(pages.expand((e) => e).length, 3);
    });

    test('unknown address ends stream and balances zero', () async {
      final quick = _quick(_notFound);
      final address = ADAAddress.fromAddress(_address);
      expect(await quick.watchAccountUtxos(address).toList(), isEmpty);
      expect(await quick.getBalance(address), BigInt.zero);
    });

    test('transport failures throw', () async {
      final quick = _quick(_serverError);
      final address = ADAAddress.fromAddress(_address);
      expect(
        () => quick.watchAccountUtxos(address).toList(),
        throwsA(isA<RPCError>()),
      );
      expect(() => quick.getBalance(address), throwsA(isA<RPCError>()));
    });

    test('getBalance sums lovelace only', () async {
      final quick = _quick(
        (p) => _ok(p, [
          _utxo(index: 0, lovelace: 1000),
          _utxo(index: 1, lovelace: 2000),
        ]),
      );
      expect(
        await quick.getBalance(ADAAddress.fromAddress(_address)),
        BigInt.from(3000),
      );
    });

    test('getTransactionStatus block on serve, unknown on 404', () async {
      final served = _quick(
        (p) => _ok(p, {
          'hash': _txHash,
          'block': _blockHash,
          'block_height': 100,
          'block_time': 1700000000,
          'slot': 1000,
          'index': 0,
          'output_amount': [
            {'unit': 'lovelace', 'quantity': '1000'},
          ],
          'fees': '200',
          'deposit': '0',
          'size': 100,
          'invalid_before': null,
          'invalid_hereafter': '10000',
          'utxo_count': 1,
          'withdrawal_count': 0,
          'mir_cert_count': 0,
          'delegation_count': 0,
          'stake_cert_count': 0,
          'pool_update_count': 0,
          'pool_retire_count': 0,
          'asset_mint_or_burn_count': 0,
          'redeemer_count': 0,
          'valid_contract': true,
        }),
      );
      expect(await served.getTransactionStatus(_txHash), AdaTxStatus.block);

      final missing = _quick(_notFound);
      expect(await missing.getTransactionStatus(_txHash), AdaTxStatus.unknown);

      final broken = _quick(_serverError);
      expect(
        () => broken.getTransactionStatus(_txHash),
        throwsA(isA<RPCError>()),
      );
    });

    test('getTransaction roundtrips cbor, null on 404', () async {
      final cbor = _txCbor();
      final quick = _quick((p) => _ok(p, {'cbor': cbor}));
      final tx = await quick.getTransaction(_txHash);
      expect(tx, isNotNull);
      expect(tx!.body.outputs!.outputs.single.amount.coin, BigInt.from(1000));

      final missing = _quick(_notFound);
      expect(await missing.getTransaction(_txHash), isNull);
    });

    test('getUtxosOutputs resolves spent outputs', () async {
      final cbor = _txCbor();
      final quick = _quick((p) => _ok(p, {'cbor': cbor}));
      final input = TransactionInput(
        transactionId: TransactionHash.fromHex(_txHash),
        index: 0,
      );
      final resolved = await quick.getUtxosOutputs([input]);
      expect(resolved.length, 1);
      expect(resolved.single.output.amount.coin, BigInt.from(1000));

      final dangling = TransactionInput(
        transactionId: TransactionHash.fromHex(_txHash),
        index: 7,
      );
      expect(await quick.getUtxosOutputs([dangling]), isEmpty);
    });
  });
}

void main() {
  OnChainUtilsTestApi.runTest(adaQuickClientTest, 'Cardano Quick Client');
}
