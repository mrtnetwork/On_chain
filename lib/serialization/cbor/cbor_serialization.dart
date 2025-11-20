import 'package:blockchain_utils/blockchain_utils.dart';
import 'package:on_chain/serialization/cbor/exception.dart';

class InternalCborSerializationConst {
  static const List<int> defaultTag = [120];
}

enum CborMapEncodingType {
  definite,
  inDefinite;

  bool get isFixed => this == definite;
  static CborMapEncodingType fromName(String? name) {
    return values.firstWhere((e) => e.name == name,
        orElse: () => throw ItemNotFoundException(value: name));
  }
}

/// A mixin providing serialization functionality to classes.
abstract mixin class InternalCborSerialization {
  /// Converts the object to a CBOR object.
  CborObject toCbor();

  /// Converts the object to a JSON representation.
  dynamic toJson();

  /// Serializes the object to CBOR bytes.
  List<int> serialize() => toCbor().encode();

  /// Serializes the object to hexadecimal string.
  String serializeHex() => BytesUtils.toHexString(serialize());

  /// Deserialize the provided CBOR bytes [cborBytes] into an object of type [T].
  /// Throws a MessageException with a descriptive message if deserialization fails.
  static T desrialize<T extends CborObject>(List<int> cborBytes) {
    final decode = CborObject.fromCbor(cborBytes);
    if (decode is! T) {
      throw CborSerializationException(
          'Failed to deserialize CBOR bytes into type.',
          details: {'type': '$T', 'expected': decode.runtimeType});
    }
    return decode;
  }

  @override
  String toString() {
    final js = toJson();
    return js.toString();
  }
}
