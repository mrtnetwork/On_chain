import 'package:blockchain_utils/blockchain_utils.dart';
import 'package:on_chain/tron/src/address/tron_address.dart';
import 'package:on_chain/tron/src/exception/exception.dart';
import 'package:on_chain/tron/src/models/contract/base_contract/base_contract.dart';
import 'package:on_chain/tron/src/models/contract/base_contract/common.dart';

/// Class for encoding Tron transactions using minimal protobuf encoding.
class ProtocolBufferEncoder {
  static final BigInt _maxInt64 = BigInt.parse("7FFFFFFFFFFFFFFF", radix: 16);
  static final BigInt _minInt64 = BigInt.parse("8000000000000000", radix: 16);

  static const int _int64BitLength = 63;
  static const int int32BitLength = 31;

  /// Validate if a [BigInt] value fits within the 64-bit signed integer range.
  static void _validateBigInt(BigInt value) {
    if (value.bitLength <= _int64BitLength) {
      return;
    }
    throw TronPluginException("Value overflows 64-bit signed integer range",
        details: {"input": value});
  }

  /// Validate if an [int] value fits within the 32-bit signed integer range.
  static void _validateInt(int value) {
    if (value.bitLength <= int32BitLength) {
      return;
    }
    throw TronPluginException("Value overflows 32-bit signed integer range",
        details: {"input": value});
  }

  /// Encode a protobuf field with the given [fieldNumber] and [value].
  static List<int> encode(int fieldNumber, dynamic value) {
    if (value is BigInt) {
      return _encodeBigInt(fieldNumber, value);
    } else if (value is int) {
      return _encodeInt(fieldNumber, value);
    } else if (value is TronEnumerate) {
      return _encodeInt(fieldNumber, value.value);
    } else if (value is TronAddress) {
      return _encodeBytes(fieldNumber, value.toBytes());
    } else if (value is List<int>) {
      return _encodeBytes(fieldNumber, value);
    } else if (value is String) {
      return _encodeBytes(fieldNumber, StringUtils.encode(value));
    } else if (value is TronProtocolBufferImpl) {
      return _encodeBytes(fieldNumber, value.toBuffer());
    } else if (value is List) {
      return _encodeList(fieldNumber, value);
    } else if (value is bool) {
      return _encodeBool(fieldNumber, value);
    } else if (value is Map) {
      return _encodeMap(fieldNumber, value);
    }
    throw TronPluginException("unsupported type",
        details: {"runtime": value.runtimeType, "value": value});
  }

  /// Encode a [Map] with the given [fieldNumber] and [value].
  static List<int> _encodeMap(int fieldNumber, Map value) {
    List<int> result = [];
    for (final i in value.entries) {
      final key = encode(1, i.key);
      final val = encode(2, i.value);
      result.addAll(_encodeLength(fieldNumber, key.length + val.length));
      result.addAll(key);
      result.addAll(val);
    }
    return result;
  }

  /// Encode length of the data for the given [fieldNumber] and [value].
  static List<int> _encodeLength(int fieldNumber, int value) {
    _validateInt(value);
    List<int> result = [];
    int tag = (fieldNumber << 3) | 2;
    result.addAll(_encodeVarint32(tag));
    result.addAll(_encodeVarint32(value));

    return result;
  }

  /// Encode a list with the given [fieldNumber] and [value].
  static List<int> _encodeList(int fieldNumber, List<dynamic> value) {
    if (value.isEmpty) return [];
    List<int> result = [];
    for (final i in value) {
      result.addAll(encode(fieldNumber, i));
    }
    return result;
  }

  /// Encode a [BigInt] with the given [fieldNumber] and [value].
  static List<int> _encodeBigInt(int fieldNumber, BigInt value) {
    _validateBigInt(value);
    List<int> result = [];

    // Combine field number and wire type (0 for varint)
    int tag = (fieldNumber << 3) | 0;
    BigInt mybeZigZag = value;
    if (value.isNegative) {
      mybeZigZag = ((value & _maxInt64) | _minInt64);
    }

    // Encode the tag and value into varint format
    result.addAll(_encodeVarint32(tag));
    result.addAll(_encodeVarintBigInt(mybeZigZag));
    return result;
  }

  /// Utility function to encode a 64-bit varint.
  static List<int> _encodeVarintBigInt(BigInt value) {
    List<int> result = [];
    while (value > BigInt.from(0x7F)) {
      result.add((value & BigInt.from(0x7F) | BigInt.from(0x80)).toInt());
      value >>= 7;
    }
    result.add(value.toInt());
    return result;
  }

  /// Encode a 32-bit varint with the given [value].
  static List<int> _encodeVarint32(int value) {
    List<int> result = [];
    while (value > 0x7F) {
      result.add((value & 0x7F) | 0x80);
      value >>= 7;
    }
    result.add(value);
    return result;
  }

  /// Encode an [int] with the given [fieldNumber]
  static List<int> _encodeInt(int fieldNumber, int value) {
    _validateInt(value);
    List<int> result = [];
    int tag = (fieldNumber << 3) | 0;
    result.addAll(_encodeVarint32(tag));
    if (value.isNegative) {
      final BigInt zigzag = ((BigInt.from(value) & _maxInt64) | _minInt64);
      result.addAll(_encodeVarintBigInt(zigzag));
      return result;
    }
    result.addAll(_encodeVarint32(value));

    return result;
  }

  /// Encode a byte array with the given [fieldNumber] and [value].
  static List<int> _encodeBytes(int fieldNumber, List<int> value) {
    List<int> result = [];
    result.addAll(_encodeLength(fieldNumber, value.length));
    result.addAll(value);

    return result;
  }

  /// Encode a boolean with the given [fieldNumber] and [value].
  static List<int> _encodeBool(int fieldNumber, bool value) {
    return _encodeInt(fieldNumber, value ? 1 : 0);
  }
}
