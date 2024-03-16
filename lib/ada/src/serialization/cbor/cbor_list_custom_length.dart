import 'package:blockchain_utils/binary/utils.dart';
import 'package:blockchain_utils/cbor/cbor.dart';
import 'package:blockchain_utils/cbor/core/tags.dart';
import 'package:blockchain_utils/cbor/utils/dynamic_bytes.dart';

/// A class representing a CBOR (Concise Binary Object Representation) List value.
class CborCustomLengthListValue<T> implements CborObject {
  /// Constructor for creating a CborListValue instance with the provided parameters.
  /// It accepts the List of all cbor encodable value.
  ///
  CborCustomLengthListValue.fixedLength(this.value, {this.length});
  final int? length;

  /// value as List
  @override
  final List<T> value;

  /// Encode the value into CBOR bytes
  @override
  List<int> encode() {
    final bytes = CborBytesTracker();
    bytes.pushInt(MajorTags.array, length ?? value.length);
    for (final v in value) {
      final obj = CborObject.fromDynamic(v);
      final encodeObj = obj.encode();
      bytes.pushBytes(encodeObj);
    }

    return bytes.toBytes();
  }

  /// Encode the value into CBOR bytes an then to hex
  @override
  String toCborHex() {
    return BytesUtils.toHexString(encode());
  }

  /// Returns the string representation of the value.
  @override
  String toString() {
    return value.join(",");
  }
}
