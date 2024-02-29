import 'package:on_chain/solana/src/layout/layout.dart';

/// Represents a layout with no data.
class None extends Layout {
  None({String? property}) : super(0, property: property);

  /// Constructs a [None] layout.
  ///
  /// - [property] (optional): The property identifier.
  @override
  Layout clone({String? newProperty}) {
    return None(property: newProperty);
  }

  @override
  decode(List<int> bytes, {int offset = 0}) {
    return null;
  }

  @override
  int encode(source, LayoutByteWriter writer, {int offset = 0}) {
    return 0;
  }
}
