import 'package:blockchain_utils/blockchain_utils.dart';
import 'package:on_chain/ada/ada.dart';
import 'package:test/test.dart';

import '../utils.dart';

const _baseAddress =
    'addr_test1qz2fxv2umyhttkxyxp8x0dlpdt3k6cwng5pxj3jhsydzer3jcu5d8ps7zex2k2xt3uqxgjqnnj83ws8lhrn648jjxtwq2ytjqp';

final _feeParameters = ADAFeeParameters(
  minFeeA: 44,
  minFeeB: 155381,
  coinsPerUtxoSize: 4310,
);

ADAAddress get _address => ADABaseAddress(_baseAddress);

TransactionUnspentOutput get _utxo => TransactionUnspentOutput(
  input: TransactionInput(
    transactionId: TransactionHash.fromHex(
      'ece972a6d5d1b07062ed5aaab786b528b04a3cf675affdda8cb79ec805c53ce2',
    ),
    index: 0,
  ),
  output: TransactionOutput(
    address: _address,
    amount: Value(coin: BigInt.from(10000000)),
  ),
);

Map<ADAAddress, List<ADABaseTransactionWitness>> _fakeSigner({
  required BuBytes digest,
  required List<ADAAddress> addresses,
}) {
  return {
    for (final address in addresses)
      address: [ADATransactionBuilderUtils.fakeVkeyWitnessWitness()],
  };
}

void adaTransactionBuilderV2Test() {
  group('ADA/Transaction Builder V2', () {
    test('the fee covers the size of the signed transaction', () {
      final builder = ADATransactionBuilderV2(
        utxos: [_utxo],
        outputs: [
          TransactionOutput(
            address: _address,
            amount: Value(coin: BigInt.from(3000000)),
          ),
        ],
      );

      final finalized = builder.finalize(
        changeAddress: _address,
        feeParameters: _feeParameters,
      );

      final transaction = finalized.sign(_fakeSigner);

      expect(finalized.fee, isNotNull);
      expect(
        finalized.fee! >=
            BigInt.from(
              _feeParameters.minFeeA * transaction.size +
                  _feeParameters.minFeeB,
            ),
        true,
      );
      /// the change is the leftover of the inputs
      expect(
        finalized.outputs.last.amount.coin,
        BigInt.from(10000000) - BigInt.from(3000000) - finalized.fee!,
      );
    });

    test('the fee is calculated with the change output', () {
      final builder = ADATransactionBuilderV2(
        utxos: [_utxo],
        outputs: [
          TransactionOutput(
            address: _address,
            amount: Value(coin: BigInt.from(3000000)),
          ),
        ],
      );

      final finalized = builder.finalize(
        changeAddress: _address,
        feeParameters: _feeParameters,
      );

      /// the size of the transaction with the change output
      expect(finalized.estimatedSize, finalized.estimateSize());
      expect(finalized.outputs.length, 2);
    });

    test('the change that is too small is added to the fee', () {
      final builder = ADATransactionBuilderV2(
        utxos: [_utxo],
        outputs: [
          TransactionOutput(
            address: _address,
            amount: Value(coin: BigInt.from(9700000)),
          ),
        ],
      );

      final finalized = builder.finalize(
        changeAddress: _address,
        feeParameters: _feeParameters,
      );

      /// the leftover is smaller than the minimum amount of an output, so it is
      /// not returned as a change output but it is added to the fee.
      expect(finalized.outputs.length, 1);
      final transaction = finalized.sign(_fakeSigner);
      expect(
        finalized.fee! >=
            BigInt.from(
              _feeParameters.minFeeA * transaction.size +
                  _feeParameters.minFeeB,
            ),
        true,
      );
    });

    test('the change holds the assets that are not spent', () {
      final policy = PolicyID(List<int>.filled(28, 1));
      final name = AssetName(List<int>.filled(32, 2));

      final utxo = TransactionUnspentOutput(
        input: TransactionInput(
          transactionId: TransactionHash.fromHex(
            'ece972a6d5d1b07062ed5aaab786b528b04a3cf675affdda8cb79ec805c53ce2',
          ),
          index: 0,
        ),
        output: TransactionOutput(
          address: _address,
          amount: Value(
            coin: BigInt.from(10000000),
            multiAsset: MultiAsset({
              policy: Assets({name: BigInt.from(10)}),
            }),
          ),
        ),
      );

      final builder = ADATransactionBuilderV2(
        utxos: [utxo],
        outputs: [
          TransactionOutput(
            address: _address,
            amount: Value(coin: BigInt.from(3000000)),
          ),
        ],
      );

      final finalized = builder.finalize(
        changeAddress: _address,
        feeParameters: _feeParameters,
      );

      final change = finalized.outputs.last.amount.multiAsset;
      expect(change, isNotNull);
      expect(change!.assets[policy]!.assets[name], BigInt.from(10));
    });

    test('the lovelace of a change that is too small is added to the fee', () {
      final policy = PolicyID(List<int>.filled(28, 1));
      final name = AssetName(List<int>.filled(32, 2));

      final utxo = TransactionUnspentOutput(
        input: TransactionInput(
          transactionId: TransactionHash.fromHex(
            'ece972a6d5d1b07062ed5aaab786b528b04a3cf675affdda8cb79ec805c53ce2',
          ),
          index: 0,
        ),
        output: TransactionOutput(
          address: _address,
          amount: Value(
            coin: BigInt.from(10000000),
            multiAsset: MultiAsset({
              policy: Assets({name: BigInt.from(10)}),
            }),
          ),
        ),
      );

      final builder = ADATransactionBuilderV2(
        utxos: [utxo],
        outputs: [
          TransactionOutput(
            address: _address,
            amount: Value(coin: BigInt.from(9700000)),
          ),
        ],
      );

      final finalized = builder.finalize(
        changeAddress: _address,
        feeParameters: _feeParameters,
      );

      /// the lovelace of the change is too small, it is added to the fee and
      /// the change output only holds the assets (an output with zero lovelace
      /// and native assets is valid).
      final change = finalized.outputs.last;
      expect(change.amount.coin, BigInt.zero);
      expect(change.amount.multiAsset!.assets[policy]!.assets[name], BigInt.from(10));
      /// the fee holds the lovelace of the change
      expect(
        finalized.fee! +
                change.amount.coin +
                finalized.outputs.first.amount.coin,
        BigInt.from(10000000),
      );
    });

    test('an exception is thrown when a signer does not sign', () {
      final builder = ADATransactionBuilderV2(
        utxos: [_utxo],
        outputs: [
          TransactionOutput(
            address: _address,
            amount: Value(coin: BigInt.from(3000000)),
          ),
        ],
      );

      final finalized = builder.finalize(
        changeAddress: _address,
        feeParameters: _feeParameters,
      );

      expect(
        () => finalized.sign(
          ({required digest, required addresses}) =>
              <ADAAddress, List<ADABaseTransactionWitness>>{},
        ),
        throwsA(isA<BuError>()),
      );
    });

    test('an exception is thrown when the transaction spends more assets than the inputs hold', () {
      final policy = PolicyID(List<int>.filled(28, 1));
      final name = AssetName(List<int>.filled(32, 2));

      final builder = ADATransactionBuilderV2(
        utxos: [_utxo],
        outputs: [
          TransactionOutput(
            address: _address,
            amount: Value(coin: BigInt.from(3000000)),
          ),
          TransactionOutput(
            address: _address,
            amount: Value(
              coin: BigInt.zero,
              multiAsset: MultiAsset({
                policy: Assets({name: BigInt.from(10)}),
              }),
            ),
          ),
        ],
      );

      final finalized = builder.finalize(
        changeAddress: _address,
        feeParameters: _feeParameters,
      );

      expect(
        () => finalized.sign(_fakeSigner),
        throwsA(
          isA<BuError>().having(
            (e) => e.message,
            'message',
            'The transaction spends more assets than the inputs hold.',
          ),
        ),
      );
    });

    test('an exception is thrown when the fee has not been calculated', () {
      final builder = ADATransactionBuilderV2(
        utxos: [_utxo],
        outputs: [
          TransactionOutput(
            address: _address,
            amount: Value(coin: BigInt.from(3000000)),
          ),
        ],
      );

      expect(
        () => builder.sign(_fakeSigner),
        throwsA(isA<BuError>()),
      );
    });
  });
}

void main() {
  OnChainUtilsTestApi.runTest(
    adaTransactionBuilderV2Test,
    "ADA Transaction Builder V2",
  );
}
