import 'package:blockchain_utils/blockchain_utils.dart';
import 'package:on_chain/exception/onchain_error.dart';
import 'package:test/test.dart';

import '../../utils.dart';

void _expectRoundTrip(BuError error) {
  final decode = BuErrorCodec.decode(bytes: error.toCborBytes());
  expect(decode.type, error.type);
  expect(decode.message, error.message);
  expect(decode.details, error.details);
}

void testExceptionTest() {
  group('Filecoin/Exception', () {
    test('Fil plugin exception', () {
      BuErrorCodec.registerTypes(OnChainErrorType.values);
      _expectRoundTrip(
        const BuError(
          OnChainErrorType.filPlugin,
          "error",
          details: {"code": "1"},
        ),
      );
    });
    test('Fil address exception', () {
      _expectRoundTrip(
        const BuError(
          OnChainErrorType.filAddress,
          "error",
          details: {"code": "1"},
        ),
      );
    });
  });
}

void main() {
  OnChainUtilsTestApi.runTest(testExceptionTest, "Exception");
}
