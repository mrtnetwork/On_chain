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

void icpSerializationExceptionTest() {
  group('ICP/Exception', () {
    test('ICP plugin exception', () {
    BuErrorCodec.registerTypes(OnChainErrorType.values);
    _expectRoundTrip(
      const BuError(
        OnChainErrorType.icpPlugin,
        "error",
        details: {"code": "1"},
      ),
    );
  });

  test('ICP address exception', () {
    _expectRoundTrip(
      const BuError(
        OnChainErrorType.icpAddress,
        "error",
        details: {"code": "1"},
      ),
    );
  });
  test('ICP candid exception', () {
    _expectRoundTrip(
      const BuError(
        OnChainErrorType.icpCandid,
        "error",
        details: {"code": "1"},
      ),
    );
    _expectRoundTrip(
      OnChainErrors.icpCandid("decode", reason: "bad"),
    );
  });

  test('ICP client exception', () {
    _expectRoundTrip(
      const BuError(
        OnChainErrorType.icpClient,
        "error",
        details: {"code": "1"},
      ),
    );
  });
  });
}

void main() {
  OnChainUtilsTestApi.runTest(icpSerializationExceptionTest, "Exception");
}
