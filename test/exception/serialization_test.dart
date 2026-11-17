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

void exceptionSerializationTest() {
  group('Core/Exception Serialization', () {
  test('Exception serialization', () {
    BuErrorCodec.registerTypes(OnChainErrorType.values);
    _expectRoundTrip(const BuError(OnChainErrorType.aptosPlugin, "error"));
    _expectRoundTrip(const BuError(OnChainErrorType.adaPlugin, "error"));
    _expectRoundTrip(const BuError(OnChainErrorType.ethereumPlugin, "error"));
    _expectRoundTrip(const BuError(OnChainErrorType.eip4361, "error"));
    _expectRoundTrip(const BuError(OnChainErrorType.bcsSerialization, "error"));
    _expectRoundTrip(const BuError(OnChainErrorType.solanaPlugin, "error"));
    _expectRoundTrip(
      const BuError(
        OnChainErrorType.solidityAbi,
        "error",
        details: {"name": "1"},
      ),
    );
    _expectRoundTrip(
      const BuError(
        OnChainErrorType.suiPlugin,
        "error",
        details: {"name": "sui"},
      ),
    );
    _expectRoundTrip(const BuError(OnChainErrorType.tronPlugin, "error"));
    _expectRoundTrip(const BuError(OnChainErrorType.nearPlugin, "error"));
    {
      final ids = OnChainErrorType.values.map((e) => e.id);
      expect(ids.toSet().length, OnChainErrorType.values.length);
      for (final id in ids) {
        expect(id > 258, equals(true));
      }
    }
  });
  });
}

void main() {
  OnChainUtilsTestApi.runTest(exceptionSerializationTest, "Serialization");
}
