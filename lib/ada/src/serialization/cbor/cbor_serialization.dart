import 'package:blockchain_utils/blockchain_utils.dart';
import 'package:on_chain/ada/src/exception/exception.dart';

enum CborMapEncodingType {
  definite,
  inDefinite;

  bool get isFixed => this == definite;
  static CborMapEncodingType fromName(String? name) {
    return values.firstWhere((e) => e.name == name,
        orElse: () =>
            throw const CborException("Invalid cbor length encoding type."));
  }
}

/// A mixin providing serialization functionality to classes.
mixin ADASerialization {
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
      throw ADAPluginException('Failed to deserialize CBOR bytes into type.',
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
