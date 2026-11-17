// Lenient block decoding: a transaction whose addresses fail parsing
// (e.g. hex-encoded ASCII like the `"0x000..."` owner seen on Nile) aborts
// strict decoding but is skipped per-tx in lenient mode.
import 'package:on_chain/on_chain.dart';
import 'package:blockchain_utils/blockchain_utils.dart';
import 'package:on_chain/tron/src/provider/utils/utils.dart';
import 'package:test/test.dart';

import '../utils.dart';

// Owner seen in the wild: hex of the ASCII text "0x" + 21 zeros
// (23 bytes — not a valid 21-byte address).
const String _poisonedOwner = '3078303030303030303030303030303030303030303030';
const String _goodOwner = '419b9ca143e8e4a2cd05ce4a160926e3b716001d6f';
const String _goodTo = '4171b0af54e0a1182a5e0947d6a64f3b22740ef318';

TronHttpTransaction _transferTx({
  String? owner,
  required String to,
  required BigInt amount,
}) {
  return TronHttpTransaction(
    rawData: TronHttpTransactionRaw(
      contract: [
        TronHttpTransactionContract(
          parameter: TronHttpTransactionContractParameter(
            typeUrl: 'type.googleapis.com/protocol.TransferContract',
            value: TronHttpTransactionContractParameterValueTransferContract(
              TronHttpTransferContract(
                ownerAddress: owner,
                toAddress: to,
                amount: amount,
              ),
            ),
          ),
        ),
      ],
    ),
  );
}

void lenientBlockTest() {
  group('Tron/Lenient block addresses', () {
    test('poisoned owner is an address error', () {
      final param = TronHttpTransactionContractParameter(
        typeUrl: 'type.googleapis.com/protocol.TransferContract',
        value: TronHttpTransactionContractParameterValueTransferContract(
          TronHttpTransferContract(
            ownerAddress: _poisonedOwner,
            toAddress: _goodTo,
            amount: BigInt.from(1000000),
          ),
        ),
      );
      expect(() => param.value.toContract(), throwsA(isA<BuError>()));
      // Still a TronPluginException for existing catch sites.
      expect(() => param.value.toContract(), throwsA(isA<BuError>()));
    });

    test('strict block decode aborts on poisoned tx', () {
      final block = TronHttpBlock(
        transactions: [
          _transferTx(
            owner: _poisonedOwner,
            to: _goodTo,
            amount: BigInt.from(99000000000000000),
          ),
          _transferTx(
            owner: _goodOwner,
            to: _goodTo,
            amount: BigInt.from(1000000),
          ),
        ],
      );
      expect(() => block.toBlock(), throwsA(isA<BuError>()));
    });
  });
}

void main() {
  OnChainUtilsTestApi.runTest(lenientBlockTest, "Lenient Block");
}
