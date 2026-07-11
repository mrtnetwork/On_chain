import 'package:on_chain/on_chain.dart';
import 'package:test/test.dart';

void main() {
  test('"Exception serialization"', () {
    {
      final error = DartAptosPluginException("error");
      final decode = OnChainPluginException.deserialize(
        cborBytes: error.toCbor().encode(),
      );
      expect(decode, error);
    }
    {
      final error = ADAPluginException("error");
      final decode = OnChainPluginException.deserialize(
        cborBytes: error.toCbor().encode(),
      );
      expect(decode, error);
    }
    {
      final error = ETHPluginException("error");
      final decode = OnChainPluginException.deserialize(
        cborBytes: error.toCbor().encode(),
      );
      expect(decode, error);
    }
    {
      final error = EIP4631Exception("error");
      final decode = OnChainPluginException.deserialize(
        cborBytes: error.toCbor().encode(),
      );
      expect(decode, error);
    }
    {
      final error = BcsSerializationException("error");
      final decode = OnChainPluginException.deserialize(
        cborBytes: error.toCbor().encode(),
      );
      expect(decode, error);
    }
    {
      final error = SolanaPluginException("error");
      final decode = OnChainPluginException.deserialize(
        cborBytes: error.toCbor().encode(),
      );
      expect(decode, error);
    }
    {
      final error = SolidityAbiException("error", details: {"name": "1"});
      final decode = OnChainPluginException.deserialize(
        cborBytes: error.toCbor().encode(),
      );
      expect(decode, error);
    }
    {
      final error = DartSuiPluginException("error", details: {"name": "sui"});
      final decode = OnChainPluginException.deserialize(
        cborBytes: error.toCbor().encode(),
      );
      expect(decode, error);
    }
  });
}
