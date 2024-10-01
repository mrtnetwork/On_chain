import 'package:blockchain_utils/utils/utils.dart';
import 'package:blockchain_utils/cbor/types/types.dart';
import 'package:blockchain_utils/cbor/core/cbor.dart';
import 'package:on_chain/ada/src/exception/exception.dart';

/// A class representing a CBOR (Concise Binary Object Representation) int (64-byte) value.
class CborUnsignedValue implements CborNumeric {
  /// Constructor for creating a CborInt64Value instance with the provided parameters.
  /// It accepts the Bigint value.
  const CborUnsignedValue._(this.value);

  factory CborUnsignedValue.u64(dynamic value) {
    if (value is! int && value is! BigInt) {
      throw ADAPluginException(
          "Invalid unsgined int. value must be int or bigint.",
          details: {"value": value});
    }
    final BigInt bigintVal = value is int ? BigInt.from(value) : value;
    if (bigintVal.isNegative || bigintVal.bitLength > 64) {
      throw ADAPluginException("Invalid unsigned 64-bit Integer.",
          details: {"Value": bigintVal, "bitLength": bigintVal.bitLength});
    }
    return CborUnsignedValue._(bigintVal);
  }
  factory CborUnsignedValue.u32(int value) {
    if (value.isNegative || value.bitLength > 32) {
      throw ADAPluginException("Invalid unsigned 32-bit Integer.",
          details: {"Value": value, "bitLength": value.bitLength});
    }
    return CborUnsignedValue._(value);
  }

  @override
  final dynamic value;

  /// Encode the value into CBOR bytes
  @override
  List<int> encode() {
    if (value is int) {
      return CborIntValue(value).encode();
    }
    return CborSafeIntValue(value).encode();
  }

  /// value as bigint
  @override
  BigInt toBigInt() {
    if (value is int) return BigInt.from(value);
    return value;
  }

  /// value as int
  @override
  int toInt() {
    if (value is int) return value;
    return (value as BigInt).toInt();
  }

  /// Encode the value into CBOR bytes an then to hex
  @override
  String toCborHex() {
    return BytesUtils.toHexString(encode());
  }

  /// Returns the string representation of the value.
  @override
  String toString() {
    return value.toString();
  }

  /// override equal operation
  @override
  operator ==(other) {
    if (other is! CborNumeric) return false;
    if (other is CborBigIntValue) return false;
    return other.toBigInt() == toBigInt();
  }

  /// override hashcode
  @override
  int get hashCode => value.hashCode;
}
