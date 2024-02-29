import 'package:on_chain/solana/src/instructions/metaplex/fixed_price_sale/types/types/creator.dart';
import 'package:on_chain/solana/src/layout/layout.dart';

class MetaDataData extends LayoutSerializable {
  final String name;
  final String symbol;
  final String uri;
  final int sellerFeeBasisPoints;
  final List<Creator>? creators;
  MetaDataData(
      {required this.name,
      required this.symbol,
      required this.uri,
      required this.sellerFeeBasisPoints,
      List<Creator>? creators})
      : creators =
            creators == null ? null : List<Creator>.unmodifiable(creators);
  factory MetaDataData.fromJson(Map<String, dynamic> json) {
    return MetaDataData(
        name: json["name"],
        symbol: json["symbol"],
        uri: json["uri"],
        sellerFeeBasisPoints: json["sellerFeeBasisPoints"],
        creators: json["creators"] == null
            ? null
            : (json["creators"] as List)
                .map((e) => Creator.fromJson(e))
                .toList());
  }
  static final Structure staticLayout = LayoutUtils.struct([
    LayoutUtils.string("name"),
    LayoutUtils.string("symbol"),
    LayoutUtils.string("uri"),
    LayoutUtils.u16("sellerFeeBasisPoints"),
    LayoutUtils.optional(LayoutUtils.vec(Creator.creatorLayout),
        property: "creators"),
  ], "metaDataData");

  @override
  Structure get layout => staticLayout;
  @override
  Map<String, dynamic> serialize() {
    return {
      "name": name,
      "symbol": symbol,
      "uri": uri,
      "sellerFeeBasisPoints": sellerFeeBasisPoints,
      "creators": creators?.map((e) => e.serialize()).toList()
    };
  }
}
