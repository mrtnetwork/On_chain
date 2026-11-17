import 'package:blockchain_utils/blockchain_utils.dart';
import 'package:on_chain/exception/onchain_error.dart';
import 'package:test/test.dart';

import '../../../utils.dart';

void _expectRoundTrip(BuError error) {
  final decode = BuErrorCodec.decode(bytes: error.toCborBytes());
  expect(decode.type, error.type);
  expect(decode.message, error.message);
  expect(decode.details, error.details);
}

void exceptionTest() {
  group('Hedera/Exception', () {
    test('Hedera plugin exception', () {
      BuErrorCodec.registerTypes(OnChainErrorType.values);
      _expectRoundTrip(
        const BuError(
          OnChainErrorType.hederaPlugin,
          "error",
          details: {"code": "1"},
        ),
      );
    });

    test('Hedera address exception', () {
      _expectRoundTrip(
        const BuError(
          OnChainErrorType.hederaAddress,
          "error",
          details: {"code": "1"},
        ),
      );
    });
    test('Hedera tx builder exception', () {
      _expectRoundTrip(
        const BuError(
          OnChainErrorType.hederaTxBuilder,
          "error",
          details: {"code": "1"},
        ),
      );
      _expectRoundTrip(
        OnChainErrors.hederaAddress("parse", reason: "bad"),
      );
    });
  });
}

void main() {
  OnChainUtilsTestApi.runTest(exceptionTest, "Exception");
}
