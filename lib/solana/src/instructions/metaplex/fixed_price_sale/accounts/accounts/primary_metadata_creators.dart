import 'package:on_chain/solana/src/instructions/metaplex/fixed_price_sale/types/types/creator.dart';
import 'package:on_chain/solana/src/layout/layout.dart';

class _Utils {
  static const List<int> discriminator = [66, 131, 48, 36, 100, 130, 177, 11];
  static final Structure layout = LayoutUtils.struct([
    LayoutUtils.blob(8, property: "discriminator"),
    LayoutUtils.vec(Creator.creatorLayout, property: "creators"),
  ]);
}

class PrimaryMetadataCreators extends LayoutSerializable {
  final List<Creator> creators;
  const PrimaryMetadataCreators({required this.creators});
  factory PrimaryMetadataCreators.fromBuffer(List<int> data) {
    final decode = LayoutSerializable.decode(
        bytes: data,
        layout: _Utils.layout,
        validator: {"discriminator": _Utils.discriminator});
    return PrimaryMetadataCreators(
        creators: (decode["creators"] as List)
            .map((e) => Creator.fromJson(e))
            .toList());
  }

  @override
  Structure get layout => _Utils.layout;

  @override
  Map<String, dynamic> serialize() {
    return {
      "discriminator": _Utils.discriminator,
      "creators": creators.map((e) => e.serialize()).toList()
    };
  }

  @override
  String toString() {
    return "PrimaryMetadataCreators${serialize()}";
  }
}
