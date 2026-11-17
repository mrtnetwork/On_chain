import 'package:blockchain_utils/blockchain_utils.dart';
import 'package:on_chain/exception/onchain_error.dart';
import 'package:on_chain/algorand/src/builder/builder.dart';
import 'package:test/test.dart';

import '../../utils.dart';

void _expectRoundTrip(BuError error) {
  final decode = BuErrorCodec.decode(bytes: error.toCborBytes());
  expect(decode.type, error.type);
  expect(decode.message, error.message);
  expect(decode.details, error.details);
}

void algoSerializationExceptionTest() {
  group('Algorand/Serialization Exceptions', () {
    test('algorand plugin exception', () {
      BuErrorCodec.registerTypes(OnChainErrorType.values);
      _expectRoundTrip(
        const BuError(
          OnChainErrorType.algoPlugin,
          "error",
          details: {"code": "1"},
        ),
      );
    });

    test('algorand abi exception', () {
      _expectRoundTrip(
        const BuError(
          OnChainErrorType.algoAbi,
          "error",
          details: {"code": "1"},
        ),
      );
    });
    test('algorand tx builder exception', () {
      _expectRoundTrip(
        const BuError(
          OnChainErrorType.algoTxBuilder,
          "error",
          details: {"code": "1"},
        ),
      );
      _expectRoundTrip(OnChainErrors.algoTxEmptyGroup);
      _expectRoundTrip(OnChainErrors.algoTxAlreadyGrouped);
      _expectRoundTrip(OnChainErrors.algoTxNotSigned);
      _expectRoundTrip(
        OnChainErrors.algoTxNotBuilding(
          AtomicTransactionComposerStatus.building.name,
        ),
      );
      _expectRoundTrip(OnChainErrors.algoTxGroupSizeExceeded(16));
      _expectRoundTrip(
        OnChainErrors.algoTxArgumentCountMismatch(
          methodName: 'm',
          expected: 1,
          actual: 2,
        ),
      );
    });
  });
}

void main() {
  OnChainUtilsTestApi.runTest(algoSerializationExceptionTest, "Exception");
}
