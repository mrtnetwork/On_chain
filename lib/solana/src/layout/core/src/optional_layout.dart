import 'package:blockchain_utils/blockchain_utils.dart';
import 'package:on_chain/solana/src/layout/byte_writer/layout_byte_write.dart';
import '../core.dart';

/// Represents a layout for optional values.
class OptionalLayout<T> extends Layout<T?> {
  /// Constructs an [OptionalLayout] with the specified layout and optional discriminator.
  ///
  /// - [layout] : The layout for the optional value.
  /// - [property] (optional): The property identifier.
  /// - [keepLayoutSize] (optional): Whether to keep the layout size.
  /// - [discriminator] (optional): The discriminator layout.
  OptionalLayout(this.layout,
      {Layout? discriminator, String? property, this.keepLayoutSize = false})
      : discriminator = discriminator ?? IntegerLayout(1),
        super(-1, property: property);
  final Layout<T> layout;
  final Layout discriminator;
  final bool keepLayoutSize;
  late final int? size =
      keepLayoutSize ? layout.span + discriminator.span : null;

  @override
  T? decode(List<int> bytes, {int offset = 0}) {
    final decode = discriminator.decode(bytes, offset: offset);
    if (decode == 0) return null;
    if (decode != 1) {
      throw MessageException("Invalid option", details: {"property": property});
    }
    return layout.decode(bytes, offset: offset + 1);
  }

  @override
  int encode(T? source, LayoutByteWriter writer, {int offset = 0}) {
    if (source == null) {
      return size ?? discriminator.encode(0, writer, offset: offset);
    }
    discriminator.encode(1, writer, offset: offset);
    final encode = layout.encode(source, writer, offset: offset + 1);
    return size ?? encode + 1;
  }

  @override
  int getSpan(List<int>? bytes, {int offset = 0}) {
    if (size != null) return size!;

    final decode = discriminator.decode(bytes!, offset: offset);
    if (decode == 0) return 1;
    if (decode != 1) {
      throw MessageException("Invalid option", details: {"property": property});
    }
    return layout.getSpan(bytes, offset: offset + 1) + 1;
  }

  @override
  Layout clone({String? newProperty}) {
    return OptionalLayout(layout,
        property: newProperty, keepLayoutSize: keepLayoutSize);
  }
}
