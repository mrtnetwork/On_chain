// https://github.com/solana-labs/buffer-layout
//
// The MIT License (MIT)
// Copyright (c) 2015-2018 Peter A. Bigot
// Permission is hereby granted, free of charge, to any person obtaining a copy
// of this software and associated documentation files (the "Software"), to deal
// in the Software without restriction, including without limitation the rights
// to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
// copies of the Software, and to permit persons to whom the Software is
// furnished to do so, subject to the following conditions:
// The above copyright notice and this permission notice shall be included in
// all copies or substantial portions of the Software.
// THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
// IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
// FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
// AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
// LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
// OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
// THE SOFTWARE.
import 'package:blockchain_utils/blockchain_utils.dart';
import 'package:on_chain/solana/src/layout/byte_writer/layout_byte_write.dart';
import 'numeric.dart';

/// Base class for layout objects.
///
/// **NOTE:** This is an abstract base class; you can create instances if it amuses you,
/// but they won't support the [encode] or [decode] functions.
///
/// - [span] : Initializer for [span]. The parameter must be an integer;
/// a negative value signifies that the span is [value-specific].
/// - [property] (optional): Initializer for [property].
abstract class Layout<T> {
  final int span;
  final String? property;
  const Layout(this.span, {this.property});

  T decode(List<int> bytes, {int offset = 0});
  int encode(T source, LayoutByteWriter writer, {int offset = 0});
  int getSpan(List<int>? bytes, {int offset = 0}) {
    if (span < 0) throw MessageException("invalid span");
    return span;
  }

  Layout clone({String? newProperty});
  List<int> serialize(T soruce, {int? size, int offset = 0}) {
    final LayoutByteWriter data = LayoutByteWriter(span);
    final enc = encode(soruce, data, offset: offset);
    if (span > 0) return data.toBytes();
    return data.sublist(0, enc);
  }
}

/// Represent a contiguous sequence of a specific layout as an Array.
///
/// Factory: [Sequence]
///
/// - [elementLayout] : Initializer for [elementLayout].
/// - [count] : Initializer for [count]. The parameter must be either a positive [Constant] integer layout or an instance of
///  [ExternalLayout].
/// - [property] (optional): Initializer for [property].
///
class Sequence<T> extends Layout<List<T>> {
  final Layout elementLayout;
  final Layout count; // Type can be ExternalLayout or int
  factory Sequence(
      {required Layout elementLayout,
      required Layout count,
      String? property}) {
    if (!((count is ExternalLayout && count.isCount()) ||
        (count is Constant && count.value is int && count.value >= 0))) {
      throw MessageException(
          'count must be non-negative integer or an unsigned integer ExternalLayout');
    }
    int span = -1;
    if ((count is ExternalLayout && count.isCount()) ||
        (count is Constant && count.value >= 0)) {
      if (count is! ExternalLayout && (elementLayout.span >= 0)) {
        span = (count as Constant).value * elementLayout.span;
      }
    }

    return Sequence._(
        elementLayout: elementLayout,
        count: count,
        property: property,
        span: span);
  }

  Sequence._({
    required this.elementLayout,
    required this.count,
    required int span,
    String? property,
  }) : super(span, property: property);

  @override
  int getSpan(List<int>? bytes, {int offset = 0}) {
    if (this.span >= 0) {
      return this.span;
    }

    int span = 0;
    dynamic count = this.count;

    if (count is ExternalLayout) {
      count = count.decode(bytes ?? [], offset: offset);
    }
    if (this.elementLayout.span > 0) {
      span = count * this.elementLayout.span;
    } else {
      int idx = 0;
      while (idx < count) {
        span += this.elementLayout.getSpan(bytes, offset: offset + span);
        ++idx;
      }
    }

    return span;
  }

  @override
  List<T> decode(List<int> bytes, {int offset = 0}) {
    List<T> rv = [];
    int i = 0;

    int count = this.count.decode(bytes, offset: offset);

    // if (this.count is ExternalLayout) {
    //   count = this.count.decode(bytes, offset: offset);
    // } else {
    //   count = this.count as int;
    // }
    while (i < count) {
      rv.add(this.elementLayout.decode(bytes, offset: offset));
      offset += this.elementLayout.getSpan(bytes, offset: offset);
      i += 1;
    }
    return rv;
  }

  @override
  int encode(List<T> source, LayoutByteWriter writer, {int offset = 0}) {
    final elo = this.elementLayout;
    int span = source.fold(0, (span, v) {
      return span + elo.encode(v, writer, offset: offset + span);
    });

    if (this.count is ExternalLayout) {
      this.count.encode(source.length, writer, offset: offset);
    }

    return span;
  }

  @override
  Sequence<T> clone({String? newProperty}) {
    return Sequence<T>(
        elementLayout: elementLayout, count: count, property: newProperty);
  }
}

/// Represent a contiguous sequence of arbitrary layout elements as an Object.
///
/// **NOTE** The [span] of the structure is variable if any layout in [fields] has a variable span.
///  When [encode] we must have a value for all variable-length fields, or we wouldn't be able to
///  figure out how much space to use for storage. We can only identify the value for a field when it has a [property].
///
///  As such, although a structure may contain both unnamed fields and variable-length fields,
///  it cannot contain an unnamed variable-length field.
///
/// - [fields] : Initializer for [fields]. An error is raised if this contains a variable-length field for which a [property] is not defined.
/// - [property] (optional): Initializer for [property].
/// - [decodePrefixes] (optional): Initializer for [decodePrefixes].
///
/// Throws [MessageException] if [fields] contains an unnamed variable-length layout.
///
class Structure extends Layout<Map<String, dynamic>> {
  final List<Layout> fields;
  final bool decodePrefixes;
  factory Structure(List<Layout> fields,
      {String? property, bool decodePrefixes = false}) {
    for (var fd in fields) {
      if (fd.span < 0 && fd.property == null) {
        throw MessageException(
            'fields cannot contain unnamed variable-length layout');
      }
    }
    int span = 0;

    try {
      span = fields.fold<int>(0, (span, fd) {
        return span + fd.getSpan(null);
      });
    } catch (e) {
      span = -1;
    }
    return Structure._(
        fields: fields,
        span: span,
        decodePrefixes: decodePrefixes,
        property: property);
  }

  Structure._({
    required List<Layout> fields,
    required int span,
    required this.decodePrefixes,
    String? property,
  })  : fields = List<Layout>.unmodifiable(fields),
        super(span, property: property);

  @override
  Structure clone({String? newProperty}) {
    return Structure._(
        span: span,
        fields: List<Layout>.from(fields),
        property: newProperty,
        decodePrefixes: decodePrefixes);
  }

  @override
  int getSpan(List<int>? bytes, {int offset = 0}) {
    if (this.span >= 0) {
      return this.span;
    }

    int span = 0;
    try {
      span = fields.fold(0, (span, fd) {
        final fsp = fd.getSpan(bytes, offset: offset);
        offset += fsp;
        return span + fsp;
      });
    } catch (e) {
      throw MessageException('indeterminate span');
    }

    return span;
  }

  @override
  Map<String, dynamic> decode(List<int> bytes, {int offset = 0}) {
    final Map<String, dynamic> dest = {};
    for (var fd in fields) {
      if (fd.property != null) {
        dest[fd.property!] = fd.decode(bytes, offset: offset);
      }
      offset += fd.getSpan(bytes, offset: offset);
      if (decodePrefixes && bytes.length == offset) {
        break;
      }
    }

    return dest;
  }

  @override
  int encode(Map<String, dynamic> source, LayoutByteWriter writer,
      {int offset = 0}) {
    final firstOffset = offset;
    int lastOffset = 0;
    int lastWrote = 0;

    for (final fd in fields) {
      int span = fd.span;
      lastWrote = (span > 0) ? span : 0;
      if (fd.property != null) {
        if (source.containsKey(fd.property)) {
          lastWrote = fd.encode(source[fd.property], writer, offset: offset);
          if (span < 0) {
            span = fd.getSpan(writer.toBytes(), offset: offset);
          }
        }
      }

      lastOffset = offset;
      offset += span;
    }

    return (lastOffset + lastWrote) - firstOffset;
  }
}

/// Represent any number of span-compatible layouts.
///
/// If the union has a [defaultLayout] that layout must have a non-negative [span].
/// The span of a fixed-span union includes its [discriminator] if the variant is a prefix
/// of the union, plus the span of its [defaultLayout].
///
/// If the union does not have a default layout then the encoded span of the union depends on
/// the encoded span of its variant (which may be fixed or variable).
///
/// [Variant layout]s are added through [addVariant].
/// If the union has a default layout, the span of the [layout contained by the variant]
/// must not exceed the span of the [defaultLayout] (minus the span of a prefix disriminator, if used).
/// The span of the variant will equal the span of the union itself.
///
/// The variant for a buffer can only be identified from the [discriminator] [property]
/// (in the case of the [defaultLayout]), or by using [getVariant] and examining the resulting
/// [VariantLayout] instance.
///
/// - [discriminator] : How to identify the layout used to interpret the union contents.
/// The parameter must be an instance of [UnionDiscriminator], an [ExternalLayout] that satisfies [isCount()],
/// or unsigned [IntegerLayout]. When a non-external layout element is passed the layout appears at the start
/// of the union. In all cases the (synthesized) [UnionDiscriminator] instance is recorded as [discriminator].
/// - [defaultLayout] (optional): Initializer for [defaultLayout]. If absent defaults to `null`. If `null` there
///   is no default layout: the union has data-dependent length and attempts to decode or encode
///   unrecognized variants will throw an exception. A [Layout] instance must have a non-negative [span],
///   and if it lacks a [property] the [defaultLayout] will be a [clone] with property `content`.
/// - [property] (optional): Initializer for [property].
///
class Union extends Layout<Map<String, dynamic>> {
  final UnionLayoutDiscriminator discriminator;
  final bool usesPrefixDiscriminator;
  final Layout? defaultLayout;
  final Map<int, VariantLayout> _registry = {};
  Union._(
      {required this.discriminator,
      required this.usesPrefixDiscriminator,
      required this.defaultLayout,
      required int span,
      required String? property})
      : super(span, property: property);
  factory Union(Layout discr, {Layout? defaultLayout, String? property}) {
    if (discr is! UnionDiscriminator &&
        discr is! ExternalLayout &&
        discr is! IntegerLayout) {
      throw MessageException(
          "discr must be a UnionDiscriminator or an unsigned integer layout");
    }
    if (discr is IntegerLayout && discr.sign) {
      throw MessageException("discr must be an unsigned integer layout");
    }
    final usesPrefixDiscriminator = (discr is IntegerLayout);
    int span = -1;
    if (defaultLayout != null) {
      if (defaultLayout.span < 0) {
        throw MessageException('defaultLayout must have constant span');
      }
      if (defaultLayout.property == null) {
        defaultLayout = defaultLayout.clone(newProperty: 'content');
      }
      span = defaultLayout.span;
      if (span >= 0 && (discr is IntegerLayout)) {
        span += (discr).span;
      }
    }
    final UnionLayoutDiscriminator discriminator;
    if (discr is IntegerLayout) {
      discriminator = UnionLayoutDiscriminator(OffsetLayout(discr));
    } else if ((discr is ExternalLayout) && discr.isCount()) {
      discriminator = UnionLayoutDiscriminator(discr);
    } else if (discr is! UnionDiscriminator) {
      throw MessageException(
          'discr must be a UnionDiscriminator or an unsigned integer layout');
    } else {
      discriminator = discr as UnionLayoutDiscriminator;
    }
    return Union._(
        discriminator: discriminator,
        usesPrefixDiscriminator: usesPrefixDiscriminator,
        defaultLayout: defaultLayout,
        span: span,
        property: property);
  }

  @override
  int getSpan(List<int>? bytes, {int offset = 0}) {
    if (span >= 0) {
      return span;
    }

    final vlo = getVariant(bytes!, offset: offset);
    if (vlo == null) {
      throw MessageException(
          'unable to determine span for unrecognized variant');
    }

    return vlo.getSpan(bytes, offset: offset);
  }

  VariantLayout? defaultGetSourceVariant(Map<String, dynamic> source) {
    if (source.containsKey(discriminator.property)) {
      if (source.containsKey(defaultLayout?.property)) {
        return null;
      }

      final vlo = _registry[source[discriminator.property]];
      if (vlo != null &&
          ((vlo.layout == null) ||
              (vlo.property != null && source.containsKey(vlo.property)))) {
        return vlo;
      }
    } else {
      for (final tag in _registry.keys) {
        final vlo = _registry[tag];
        if (vlo?.property != null && source.containsKey(vlo?.property)) {
          return vlo;
        }
      }
    }

    throw MessageException('unable to infer source variant');
  }

  @override
  Map<String, dynamic> decode(List<int> bytes, {int offset = 0}) {
    final dlo = discriminator;
    final discr = dlo.decode(bytes, offset: offset);
    final clo = _registry[discr];
    Map<String, dynamic> dest = {};
    if (clo == null) {
      final defaultLayout = this.defaultLayout;
      var contentOffset = 0;

      if (usesPrefixDiscriminator) {
        contentOffset = dlo.layout.span;
      }

      dest[dlo.property!] = discr;

      if (defaultLayout != null) {
        dest[defaultLayout.property!] =
            defaultLayout.decode(bytes, offset: offset + contentOffset);
      }
    } else {
      dest = clo.decode(bytes, offset: offset);
    }

    return dest;
  }

  @override
  int encode(Map<String, dynamic> source, LayoutByteWriter writer,
      {int offset = 0}) {
    final vlo = defaultGetSourceVariant(source);

    if (vlo == null) {
      final dlo = discriminator;
      final clo = defaultLayout;

      var contentOffset = 0;

      if (usesPrefixDiscriminator) {
        contentOffset = dlo.layout.span;
      }

      dlo.encode(source[dlo.property], writer, offset: offset);

      return contentOffset +
          clo!.encode(source[clo.property], writer,
              offset: offset + contentOffset);
    }

    return vlo.encode(source, writer, offset: offset);
  }

  VariantLayout addVariant(
      {required int variant, Layout? layout, String? property}) {
    final rv = VariantLayout(
        union: this, variant: variant, layout: layout, property: property);
    _registry[variant] = rv;
    return rv;
  }

  VariantLayout? getVariant(List<int> variantBytes, {int offset = 0}) {
    int variant = discriminator.decode(variantBytes, offset: offset);
    return _registry[variant];
  }

  @override
  Union clone({String? newProperty}) {
    return Union(discriminator, property: newProperty);
  }
}

/// Represent a specific variant within a containing union.
///
/// **NOTE** The [span] of the variant may include the span of the [discriminator] used to identify it,
/// but values read and written using the variant strictly conform to the content of [layout].
///
/// **NOTE** User code should not invoke this constructor directly. Use the union [addVariant] helper method.
///
/// - [union] : Initializer for [union].
/// - [variant] : Initializer for [variant].
/// - [layout] (optional): Initializer for [layout]. If absent the variant carries no data.
/// - [property] (optional): Initializer for [property]. Unlike many other layouts, variant layouts normally
///   include a property name so they can be identified within their containing [Union].
///   The property identifier may be absent only if `layout` is absent.
///
class VariantLayout extends Layout<Map<String, dynamic>> {
  final Union union;
  final int variant;
  final Layout? layout;
  VariantLayout._(
      {required this.union,
      required this.variant,
      this.layout,
      required int span,
      String? property})
      : super(span, property: property);

  factory VariantLayout({
    required Union union,
    required int variant,
    Layout? layout,
    String? property,
  }) {
    if (layout != null) {
      if ((union.defaultLayout != null) &&
          (0 <= layout.span) &&
          (layout.span > union.defaultLayout!.span)) {
        throw MessageException('variant span exceeds span of containing union');
      }
    }
    int span = union.span;
    if (0 > union.span) {
      span = layout != null ? layout.span : 0;
      if ((0 <= span) && union.usesPrefixDiscriminator) {
        span += union.discriminator.layout.span;
      }
    }
    return VariantLayout._(
        union: union,
        variant: variant,
        span: span,
        layout: layout,
        property: property);
  }

  @override
  int getSpan(List<int>? bytes, {int offset = 0}) {
    if (!this.span.isNegative) {
      return this.span;
    }
    int contentOffset = 0;
    if (union.usesPrefixDiscriminator) {
      contentOffset = union.discriminator.layout.span;
    }
    int span = 0;
    if (layout != null) {
      span = layout!.getSpan(bytes, offset: offset + contentOffset);
    }
    return contentOffset + span;
  }

  @override
  Map<String, dynamic> decode(List<int> bytes, {int offset = 0}) {
    if (this != union.getVariant(bytes, offset: offset)) {
      throw MessageException('variant mismatch');
    }

    var contentOffset = 0;
    if (union.usesPrefixDiscriminator) {
      contentOffset = union.discriminator.layout.span;
    }
    final Map<String, dynamic> dest = {};
    if (layout != null) {
      dest[property!] = layout!.decode(bytes, offset: offset + contentOffset);
    } else if (property != null) {
      dest[property!] = true;
    } else if (union.usesPrefixDiscriminator) {
      dest[union.discriminator.property!] = variant;
    }

    return dest;
  }

  @override
  int encode(Map<String, dynamic> source, LayoutByteWriter writer,
      {int offset = 0}) {
    int contentOffset = 0;
    if (union.usesPrefixDiscriminator) {
      contentOffset = union.discriminator.layout.span;
    }

    if (layout != null && !source.containsKey(property)) {
      throw MessageException('variant lacks property $property');
    }

    union.discriminator.encode(variant, writer, offset: offset);
    int span = contentOffset;

    if (layout != null) {
      layout!.encode(source[property], writer, offset: offset + contentOffset);
      span += layout!.getSpan(writer.toBytes(), offset: offset + contentOffset);

      if (union.span >= 0 && span > union.span) {
        throw MessageException('encoded variant overruns containing union');
      }
    }

    return span;
  }

  @override
  VariantLayout clone({String? newProperty}) {
    return VariantLayout._(
        union: union,
        variant: variant,
        layout: layout,
        property: newProperty,
        span: span);
  }
}

/// A class representing a blob layout within a buffer.
class Blob extends Layout<List<int>> {
  /// The number of bytes in the blob.
  ///
  /// This may be a non-negative integer or an instance of [ExternalLayout] that satisfies [ExternalLayout.isCount].
  final dynamic length;

  Blob._(this.length, {String? property})
      : super(length is ExternalLayout ? -1 : length, property: property);

  /// Constructs a [Blob] with the given [length] and [property].
  ///
  /// The [length] can be a positive integer or an unsigned integer [ExternalLayout].
  factory Blob(dynamic length, {String? property}) {
    if (length is int) {
      if (length.isNegative) {
        throw MessageException("The length must be a positive integer.");
      }
    } else if (length is! ExternalLayout) {
      throw MessageException(
          "The length can be a positive integer or an unsigned integer ExternalLayout");
    }
    return Blob._(length, property: property);
  }

  @override
  int getSpan(List<int>? bytes, {int offset = 0}) {
    int span = this.span;
    if (span < 0) {
      span = (length as ExternalLayout).decode(bytes!, offset: offset);
    }
    return span;
  }

  @override
  List<int> decode(List<int> bytes, {int offset = 0}) {
    int span = getSpan(bytes, offset: offset);
    return bytes.sublist(offset, offset + span);
  }

  @override
  int encode(List<int> source, LayoutByteWriter writer, {int offset = 0}) {
    int span = this.span;
    if (length is ExternalLayout) {
      span = source.length;
    }
    if (span != source.length) {
      throw MessageException(
          "Blob.encode' requires a source with length $span.");
    }
    if (offset + span > writer.length) {
      if (!writer.growable) {
        throw RangeError('Encoding overruns List<int>');
      }
    }
    final srcBuffer = List<int>.from(source);
    writer.setRange(offset, offset + span, srcBuffer);

    if (length is ExternalLayout) {
      (length as ExternalLayout).encode(span, writer, offset: offset);
    }

    return span;
  }

  @override
  Blob clone({String? newProperty}) {
    return Blob(length, property: newProperty);
  }
}

/// A class representing a C-style string layout within a buffer.
class CString extends Layout<String> {
  /// Constructs a [CString] with the given [property].
  CString({String? property}) : super(-1, property: property);

  @override
  int getSpan(List<int>? bytes, {int offset = 0}) {
    if (bytes == null) {
      throw MessageException("bytes must be a Uint8Array");
    }
    int idx = offset;
    while (idx < bytes.length && bytes[idx] != 0) {
      idx += 1;
    }
    return 1 + idx - offset;
  }

  @override
  String decode(List<int> bytes, {int offset = 0}) {
    int span = getSpan(bytes, offset: offset);
    return String.fromCharCodes(bytes.sublist(offset, offset + span - 1));
  }

  @override
  int encode(String source, LayoutByteWriter writer, {int offset = 0}) {
    List<int> srcBytes = StringUtils.encode(source);
    int span = srcBytes.length;
    if (offset + span > writer.length) {
      throw RangeError('Encoding overruns List<int>');
    }

    writer.setRange(offset, offset + span, srcBytes);
    writer.set(offset + span, 0);
    return span + 1;
  }

  @override
  Layout clone({String? newProperty}) {
    return CString(property: newProperty);
  }
}

/// A class representing a UTF-8 layout within a buffer.
class UTF8 extends Layout<String> {
  /// The maximum span of the layout in bytes.
  ///
  /// Positive values are generally expected. Zero is abnormal.
  /// Attempts to encode or decode a value that exceeds this length
  /// will throw a `RangeError`.
  ///
  /// A negative value indicates that there is no bound on the length
  /// of the content.
  final int maxSpan;

  /// Constructs a [UTF8] layout with the given [maxSpan] and [property].
  UTF8({int? maxSpan, String? property})
      : maxSpan = maxSpan ?? -1,
        super(-1, property: property);

  @override
  int getSpan(List<int>? bytes, {int offset = 0}) {
    if (bytes == null) {
      throw MessageException("bytes must not be null");
    }
    return bytes.length - offset;
  }

  @override
  String decode(List<int> bytes, {int offset = 0}) {
    int span = getSpan(bytes, offset: offset);
    if (maxSpan >= 0 && maxSpan < span) {
      throw MessageException('Text length exceeds maxSpan');
    }
    return String.fromCharCodes(bytes.sublist(offset, offset + span));
  }

  @override
  int encode(String source, LayoutByteWriter writer, {int offset = 0}) {
    List<int> srcBytes = StringUtils.encode(source);
    int span = srcBytes.length;

    if (maxSpan >= 0 && maxSpan < span) {
      throw RangeError('Text length exceeds maxSpan');
    }

    if (offset + span > writer.length) {
      throw RangeError('Encoding overruns List<int>');
    }

    writer.setRange(offset, offset + span, srcBytes);
    return span;
  }

  @override
  Layout clone({String? newProperty}) {
    return UTF8(maxSpan: maxSpan, property: newProperty);
  }
}

/// A class representing a constant layout within a buffer.
class Constant<T> extends Layout<T> {
  /// The value produced by this constant when the layout is decoded.
  ///
  /// Any Dart value including `null` and `undefined` is permitted.
  ///
  /// **WARNING** If `value` passed in the constructor was not
  /// frozen, it is possible for users of decoded values to change
  /// the content of the value.
  final T value;

  /// Constructs a [Constant] layout with the given [value] and [property].
  Constant(this.value, {String? property}) : super(0, property: property);

  @override
  T decode(List<int> bytes, {int offset = 0}) {
    return value;
  }

  @override
  int encode(T source, LayoutByteWriter writer, {int offset = 0}) {
    // Constants take no space
    return 0;
  }

  @override
  Layout clone({String? newProperty}) {
    return Constant(value, property: newProperty);
  }
}

/// Represents the layout for a key-value pair in a map.
class MapEntryLayout extends Layout<MapEntry> {
  final Layout keyLayout;
  final Layout valueLayout;

  /// Constructs a [MapEntryLayout] with the specified key and value layouts.
  ///
  /// - [keyLayout] : The layout for the key.
  /// - [valueLayout] : The layout for the value.
  /// - [property] (optional): The property identifier.
  MapEntryLayout(
      {required this.keyLayout, required this.valueLayout, String? property})
      : super(keyLayout.span + valueLayout.span, property: property);

  @override
  MapEntry decode(List<int> bytes, {int offset = 0}) {
    final key = keyLayout.decode(bytes, offset: offset);
    final value = valueLayout.decode(bytes,
        offset: offset + keyLayout.getSpan(bytes, offset: offset));
    return MapEntry(key, value);
  }

  @override
  int encode(MapEntry source, LayoutByteWriter writer, {int offset = 0}) {
    final keyBytes = keyLayout.encode(source.key, writer, offset: offset);
    final valueBytes =
        valueLayout.encode(source.value, writer, offset: offset + keyBytes);
    return keyBytes + valueBytes;
  }

  @override
  int getSpan(List<int>? bytes, {int offset = 0}) {
    final keySpan = keyLayout.getSpan(bytes, offset: offset);
    return keySpan + valueLayout.getSpan(bytes, offset: offset + keySpan);
  }

  @override
  Layout clone({String? newProperty}) {
    return MapEntryLayout(
        keyLayout: keyLayout, valueLayout: valueLayout, property: newProperty);
  }
}
