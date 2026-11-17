import 'package:blockchain_utils/blockchain_utils.dart';
import 'package:on_chain/exception/onchain_error.dart';
import 'package:test/test.dart';

import '../utils.dart';

void _expectRoundTrip(BuError error) {
  final decode = BuErrorCodec.decode(bytes: error.toCborBytes());
  expect(decode.type, error.type);
  expect(decode.message, error.message);
  expect(decode.details, error.details);
}

void tezosExceptionTest() {
  group('Tezos/Exception', () {
    test('tezos exceptions', () {
      BuErrorCodec.registerTypes(OnChainErrorType.values);
      _expectRoundTrip(
        const BuError(
          OnChainErrorType.tezosPlugin,
          "error",
          details: {"code": "1"},
        ),
      );
      _expectRoundTrip(
        const BuError(
          OnChainErrorType.tezosAddress,
          "error",
          details: {"code": "1"},
        ),
      );
      _expectRoundTrip(
        const BuError(
          OnChainErrorType.tezosMicheline,
          "error",
          details: {"code": "1"},
        ),
      );
      _expectRoundTrip(
        const BuError(
          OnChainErrorType.tezosAbi,
          "error",
          details: {"code": "1"},
        ),
      );
      _expectRoundTrip(
        const BuError(
          OnChainErrorType.tezosMetadata,
          "error",
          details: {"code": "1"},
        ),
      );
      _expectRoundTrip(
        const BuError(
          OnChainErrorType.tezosView,
          "error",
          details: {"code": "1"},
        ),
      );
      _expectRoundTrip(OnChainErrors.tezosMicheline("encode", reason: "bad"));
      _expectRoundTrip(OnChainErrors.tezosAbi("encode `bool`", reason: "bad"));
    });
  });
}

void main() {
  OnChainUtilsTestApi.runTest(tezosExceptionTest, "Exception");
}
