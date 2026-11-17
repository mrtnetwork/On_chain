import 'package:blockchain_utils/blockchain_utils.dart';
import 'package:on_chain/hedera/src/proto_messages/proto/models.dart';

/// Deterministic fake key material for unit tests (not secure).
class FakeHederaKeys {
  FakeHederaKeys._();

  static List<int> _bytes(int seed, [int len = 32]) =>
      List<int>.generate(len, (i) => (seed + i * 17) & 0xff);

  static HederaKey ed25519(int seed) {
    final key = ED25519PrivateKey.fromBytes(
      EdwardsLimbOps.scReduce32(_bytes(seed)),
    );
    return HederaKey(ed25519: key.publicKey.toBytes());
  }

  static HederaKey ecdsaSecp256k1(int seed) {
    final key = Secp256k1PrivateKey.fromBytes(_bytes(seed));
    return HederaKey(ecdsaSecp256k1: key.publicKey.toBytes());
  }

  /// M-of-N threshold over [count] ed25519 keys starting at [seed].
  static HederaKey threshold({
    required int threshold,
    required int count,
    int seed = 1,
  }) {
    assert(threshold >= 1 && threshold <= count);
    final keys = [for (var i = 0; i < count; i++) ed25519(seed + i)];
    return HederaKey(
      thresholdKey: HederaThresholdKey(
        threshold: threshold,
        keys: HederaKeyList(keys: keys),
      ),
    );
  }

  static HederaKey keyList(List<HederaKey> keys) =>
      HederaKey(keyList: HederaKeyList(keys: keys));
}
