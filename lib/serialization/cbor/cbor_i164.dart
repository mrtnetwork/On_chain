import 'package:blockchain_utils/blockchain_utils.dart';

/// A class representing a CBOR (Concise Binary Object Representation) int (64-byte) value.
class CborSignedValue extends CborNumeric {
  /// Constructor for creating a CborInt64Value instance with the provided parameters.
  /// It accepts the Bigint value.
  const CborSignedValue._(super.value);

  factory CborSignedValue.i64(dynamic value) {
    if (value is! int && value is! BigInt) {
      throw BuError(DefaultErrorType.invalidArgument,
        'Invalid unsgined int. value must be int or bigint.',
        details: {'value': value.runtimeType.toString()},
      );
    }

    if (value is BigInt && value.bitLength > 64) {
      throw BuError(DefaultErrorType.invalidArgument,
        'Invalid signed 64-bit Integer.',
        details: {
          'Value': value.toString(),
          'bitLength': value.bitLength.toString(),
        },
      );
    }
    return CborSignedValue._(value);
  }
  factory CborSignedValue.i32(int value) {
    if (value.bitLength > 32) {
      throw BuError(DefaultErrorType.invalidArgument,
        'Invalid signed 32-bit Integer.',
        details: {
          'Value': value.toString(),
          'bitLength': value.bitLength.toString(),
        },
      );
    }
    return CborSignedValue._(value);
  }

  /// Encode the value into CBOR bytes
  @override
  BuBytes encode() {
    if (value is int || (value as BigInt).isSafeInt()) {
      return CborIntValue(toInt()).encode();
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
