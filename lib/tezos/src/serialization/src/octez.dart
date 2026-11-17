import 'package:blockchain_utils/encoding/encoding.dart';
import 'package:blockchain_utils/utils/utils.dart';

/// Base layout for serializable Octez (Tezos binary) values.
abstract class OctezSerializable<T> {
  const OctezSerializable();

  /// Binary layout used for forging.
  Layout<T> toLayot();

  /// JSON representation (RPC format).
  dynamic toJson();

  /// Forge to binary bytes.
  List<int> serializeBytes() => toLayot().serialize(this as T);

  /// Forge to a hex string.
  String serializeHex() => BytesUtils.toHexString(serializeBytes());
}

/// Base layout for tagged-union (variant) Octez values.
abstract class OctezVariatnSerializable<T, E> extends OctezSerializable<T> {
  const OctezVariatnSerializable();

  /// Tagged-union layout used for forging the variant with its tag.
  TaggedUnionLayout<E> toVariantLayot();

  /// JSON representation of the variant.
  dynamic toVariantJson();

  /// Forge to binary bytes including the variant tag.
  List<int> serializeVariantBytes() => toVariantLayot().serialize(this as E);

  /// Variant (operation/kind) name used in JSON.
  String get varintName;
}
