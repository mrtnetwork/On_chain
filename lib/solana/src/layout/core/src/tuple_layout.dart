import 'package:blockchain_utils/blockchain_utils.dart';
import 'package:on_chain/solana/src/layout/byte_writer/layout_byte_write.dart';

import '../core.dart';

/// Represents a layout for tuples.
class TupleLayout extends Layout<List> {
  /// Constructs a [TupleLayout] with the specified list of layouts.
  ///
  /// - [layouts] : The list of layouts representing the tuple elements.
  /// - [property] (optional): The property identifier.
  TupleLayout(this.layouts, {String? property}) : super(-1, property: property);
  final List<Layout> layouts;

  @override
  List decode(List<int> bytes, {int offset = 0}) {
    List encoded = [];
    int pos = offset;
    for (final i in layouts) {
      encoded.add(i.decode(bytes, offset: pos));
      pos += i.getSpan(bytes, offset: pos);
    }
    return encoded;
  }

  @override
  int encode(List source, LayoutByteWriter writer, {int offset = 0}) {
    if (source.length != layouts.length) {
      throw MessageException("Source length must match layout length.");
    }

    int pos = offset;
    for (int i = 0; i < source.length; i++) {
      pos += layouts[i].encode(source[i], writer, offset: pos);
    }

    return pos - offset;
  }

  @override
  int getSpan(List<int>? bytes, {int offset = 0}) {
    int span = 0;
    for (final i in layouts) {
      span += i.getSpan(bytes, offset: offset + span);
    }
    return span;
  }

  @override
  Layout clone({String? newProperty}) {
    return TupleLayout(layouts, property: newProperty);
  }
}
