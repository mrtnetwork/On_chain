import 'package:blockchain_utils/blockchain_utils.dart';
import 'package:on_chain/ada/src/serialization/cbor_serialization.dart';
import 'package:on_chain/ada/src/models/utils.dart';

/// Abstract class for handling fixed length bytes.
abstract class FixedBytes
    with ADASerialization
    implements Comparable<FixedBytes> {
  /// The hash bytes data.
  final List<int> data;

  /// Constructs a FixedBytes object with hash bytes data and length for validate.
  FixedBytes(List<int> hashBytes, int length)
      : data = AdaTransactionUtils.validateFixedLengthBytes(
            bytes: hashBytes, length: length);

  /// Constructs a FixedBytes object from a hexadecimal string and length for validate.
  FixedBytes.fromHex(String hexBytes, int length)
      : data = AdaTransactionUtils.validateFixeHexByteslength(
            hexBytes: hexBytes, length: length);

  @override
  operator ==(other) {
    return identical(this, other) ||
        (other is FixedBytes &&
            other.runtimeType == runtimeType &&
            BytesUtils.bytesEqual(other.data, data));
  }

  @override
  int get hashCode => data.fold<int>(
      mask32, (previousValue, element) => previousValue ^ element.hashCode);

  @override
  int compareTo(other) {
    final lenComparison = data.length.compareTo(other.data.length);
    if (lenComparison == 0) {
      return BytesUtils.compareBytes(data, other.data);
    }
    return lenComparison;
  }

  /// Converts the hash bytes to a hexadecimal string.
  String toHex() {
    return BytesUtils.toHexString(data);
  }

  @override
  CborObject toCbor() {
    return CborBytesValue(data);
  }

  @override
  dynamic toJson() {
    return toHex();
  }

  @override
  String toString() {
    return "$runtimeType${toJson()}}";
  }
}
