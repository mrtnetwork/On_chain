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

void serializationExceptionTest() {
  group('NEAR/Exception', () {
    test('near plugin exception', () {
      BuErrorCodec.registerTypes(OnChainErrorType.values);
      _expectRoundTrip(
        const BuError(
          OnChainErrorType.nearPlugin,
          "error",
          details: {"code": "1"},
        ),
      );
      _expectRoundTrip(OnChainErrors.nearPlugin("parseAddress", reason: "bad"));
    });
  });
}

void main() {
  OnChainUtilsTestApi.runTest(serializationExceptionTest, "Exception");
}
