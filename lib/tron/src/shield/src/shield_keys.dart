import 'package:blockchain_utils/blockchain_utils.dart';

class TronShieldSpendingKey {
  final SaplingExtendedSpendingKey exsk;
  const TronShieldSpendingKey(this.exsk);

  factory TronShieldSpendingKey.master(List<int> seed) =>
      TronShieldSpendingKey(SaplingExtendedSpendingKey.master(seed));

  factory TronShieldSpendingKey.fromBytes(List<int> bytes) =>
      TronShieldSpendingKey(SaplingExtendedSpendingKey.fromBytes(bytes));

  List<int> toBytes() => List<int>.from(exsk.toBytes());

  SaplingDiversifiableFullViewingKey get dfvk =>
      exsk.toExtendedFvk().toDiversifiableFullViewingKey();

  /// Default (external) payment address + diversifier index.
  (SaplingPaymentAddress, DiversifierIndex) defaultAddress() =>
      dfvk.defaultAddress();

  /// Raw 43-byte shielded address bytes for TRON RPC.
  List<int> defaultAddressBytes() =>
      List<int>.from(defaultAddress().$1.toBytes());

  SaplingIvk externalIvk() => dfvk.toExternalIvk().ivk;
  SaplingOutgoingViewingKey externalOvk() => dfvk.fvk.ovk;
  SaplingFullViewingKey fullViewingKey() => dfvk.fvk;
}

/// Viewing-only access (ivk + ovk + nk) for scanning.
class TronShieldViewingKey {
  final SaplingDiversifiableFullViewingKey dfvk;
  const TronShieldViewingKey(this.dfvk);

  List<SaplingIvk> scanIvks() => [dfvk.toExternalIvk().ivk];

  bool ownsAddress(SaplingPaymentAddress addr) =>
      dfvk.scopeForAddress(address: addr) != null;
}

/// Helpers to convert between raw shielded address bytes and TRON RPC forms.
class TronShieldAddressCodec {
  static const String hrp = 'ztron';

  /// 43 bytes: d (11) || pk_d (32).
  static SaplingPaymentAddress fromBytes(List<int> bytes) =>
      SaplingPaymentAddress.fromBytes(bytes);

  static List<int> toBytes(SaplingPaymentAddress addr) =>
      List<int>.from(addr.toBytes());

  static String toHex(SaplingPaymentAddress addr) =>
      BytesUtils.toHexString(toBytes(addr));

  static SaplingPaymentAddress fromHex(String hex) =>
      fromBytes(BytesUtils.fromHexString(hex));

  /// Bech32 `ztron1...` as returned/required by TRON RPC.
  static String toBech32(SaplingPaymentAddress addr) =>
      Bech32Encoder.encode(hrp, toBytes(addr));

  static SaplingPaymentAddress fromBech32(String address) =>
      fromBytes(List<int>.from(Bech32Decoder.decode(hrp, address)));
}
