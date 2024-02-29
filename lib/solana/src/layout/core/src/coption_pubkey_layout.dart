import 'package:blockchain_utils/blockchain_utils.dart';
import 'package:on_chain/solana/src/layout/byte_writer/layout_byte_write.dart';
import 'package:on_chain/solana/src/layout/utils/layout_utils.dart';
import 'core.dart';
import 'numeric.dart';

class COptionPublicKeyLayout<T> extends Layout<T?> {
  COptionPublicKeyLayout({String? property})
      : layout = LayoutUtils.publicKey(),
        super(-1, property: property);
  final Layout layout;
  final Layout discriminator = IntegerLayout(1);

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
      return discriminator.encode(0, writer, offset: offset);
    }
    discriminator.encode(1, writer, offset: offset);
    final encode = layout.encode(source, writer, offset: offset + 1);
    return encode + 1;
  }

  @override
  int getSpan(List<int>? bytes, {int offset = 0}) {
    if (bytes == null) return layout.span + 1;
    final decode = discriminator.decode(bytes, offset: offset);
    if (decode == 0) return 1;
    if (decode != 1) {
      throw MessageException("Invalid option", details: {"property": property});
    }
    return layout.span + 1;
  }

  @override
  Layout clone({String? newProperty}) {
    return COptionPublicKeyLayout(property: newProperty);
  }
}
