import 'dart:typed_data' show Endian;

import 'package:blockchain_utils/blockchain_utils.dart';

import 'consts.dart';

/// Transparent value wrapper (sun for TRX / smallest unit for TRC20).
/// Serialized as little-endian u64 (Sapling note value encoding).
class ShieldAmount with Equality, LayoutSerializable {
  final BigInt value;
  const ShieldAmount(this.value);
  factory ShieldAmount.zero() => ShieldAmount(BigInt.zero);
  factory ShieldAmount.fromInt(int v) => ShieldAmount(BigInt.from(v));

  factory ShieldAmount.deserialize(List<int> bytes) {
    final json = LayoutSerializable.deserialize(bytes: bytes, layout: layout());
    return ShieldAmount.deserializeJson(json);
  }

  factory ShieldAmount.deserializeJson(Map<String, dynamic> json) {
    return ShieldAmount(json.valueAsBigInt('value'));
  }

  static Layout<Map<String, dynamic>> layout({String? property}) {
    return LayoutConst.struct([
      LayoutConst.u64(property: 'value'),
    ], property: property);
  }

  BuBytes toBytes() =>
      BigintUtils.toBytes(value, length: 8, byteOrder: Endian.little);

  static ShieldAmount fromBytes(List<int> bytes) {
    return ShieldAmount(
      BigintUtils.fromBytes(bytes, length: 8, byteOrder: Endian.little),
    );
  }

  /// 64 value bits, LSB first, via BigintUtils.
  List<bool> toBits() => BigintUtils.toBinaryBool(value, bitLength: 64);

  @override
  List<dynamic> get variables => [value];

  @override
  Layout<Map<String, dynamic>> toLayout({String? property}) =>
      layout(property: property);

  @override
  Map<String, dynamic> toSerializeJson() => {'value': value};
}

/// Ephemeral public key bytes (32).
class ShieldEphemeralKey with Equality, LayoutSerializable {
  final BuBytes inner;
  ShieldEphemeralKey(List<int> bytes)
    : inner =
          bytes.length == 32
              ? BuBytes.from(bytes)
              : throw BuError(
                DefaultErrorType.invalidLength,
                "Ephemeral key must be 32 bytes.",
                details: {'length': bytes.length.toString()},
              );

  factory ShieldEphemeralKey.deserialize(List<int> bytes) {
    final json = LayoutSerializable.deserialize(bytes: bytes, layout: layout());
    return ShieldEphemeralKey.deserializeJson(json);
  }

  factory ShieldEphemeralKey.deserializeJson(Map<String, dynamic> json) {
    return ShieldEphemeralKey(json.valueAsBytes('inner'));
  }

  static Layout<Map<String, dynamic>> layout({String? property}) {
    return LayoutConst.struct([
      LayoutConst.fixedBlob32(property: 'inner'),
    ], property: property);
  }

  BuBytes toBytes() => inner.cloneBytes();

  @override
  List<dynamic> get variables => [inner];

  @override
  Layout<Map<String, dynamic>> toLayout({String? property}) =>
      layout(property: property);

  @override
  Map<String, dynamic> toSerializeJson() => {'inner': toBytes()};
}

/// Generic shielded output (spendable note ciphertext on chain).
abstract mixin class ShieldOutput<C> {
  ShieldEphemeralKey get ephemeralKey;
  C cmstar();
  BuBytes cmstarBytes();
  BuBytes get encCiphertext;
  BuBytes get encCiphertextCompact;

  (BuBytes, BuBytes)? splitCiphertextAtTag() {
    final bytes = encCiphertext;
    final tagLoc = bytes.length - ShieldNoteConst.aeadTagSize;
    if (tagLoc <= 0) return null;
    return (bytes.sublist(0, tagLoc), bytes.sublist(tagLoc));
  }
}

/// Encrypted note holder (esk/epk/note/memo/ovk).
abstract class ShieldNoteEncryption<Esk, Epk, N, Ovk> {
  final Esk esk;
  final Epk epk;
  final N note;
  final List<int> memo;
  final Ovk? ovk;
  const ShieldNoteEncryption({
    required this.esk,
    required this.epk,
    required this.note,
    required this.memo,
    required this.ovk,
  });
}

class ShieldBatchOutputResult<O, N, R> {
  final O output;
  final N note;
  final R recipient;
  final BuBytes? memo;
  const ShieldBatchOutputResult({
    required this.output,
    required this.note,
    required this.recipient,
    required this.memo,
  });
}

class ShieldBatchIvkResult<Ivk, N, R> {
  final Ivk ivk;
  final N note;
  final R recipient;
  final BuBytes? memo;
  const ShieldBatchIvkResult({
    required this.ivk,
    required this.note,
    required this.recipient,
    required this.memo,
  });
}
