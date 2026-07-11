import 'package:blockchain_utils/cbor/core/cbor.dart';
import 'package:blockchain_utils/cbor/exception/exception.dart';
import 'package:blockchain_utils/cbor/types/types.dart';
import 'package:blockchain_utils/utils/utils.dart';

/// A class representing a CBOR (Concise Binary Object Representation) int (64-byte) value.
class CborUnsignedValue extends CborNumeric {
  /// Constructor for creating a CborInt64Value instance with the provided parameters.
  /// It accepts the Bigint value.
  const CborUnsignedValue._(super.value);

  factory CborUnsignedValue.u64(dynamic value) {
    if (value is! int && value is! BigInt) {
      throw CborException(
        'Invalid unsgined int. value must be int or bigint.',
        details: {'value': value?.toString()},
      );
    }
    final BigInt bigintVal = value is int ? BigInt.from(value) : value;
    if (bigintVal.isNegative || bigintVal.bitLength > 64) {
      throw CborException(
        'Invalid unsigned 64-bit Integer.',
        details: {
          'Value': bigintVal.toString(),
          'bitLength': bigintVal.bitLength.toString(),
        },
      );
    }
    return CborUnsignedValue._(bigintVal);
  }
  factory CborUnsignedValue.u32(int value) {
    if (value.isNegative || value.bitLength > 32) {
      throw CborException(
        'Invalid unsigned 32-bit Integer.',
        details: {
          'Value': value.toString(),
          'bitLength': value.bitLength.toString(),
        },
      );
    }
    return CborUnsignedValue._(value);
  }

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

  @override
  Object? getValue() {
    return value;
  }

  @override
  List<dynamic> get variables => [value];
}
