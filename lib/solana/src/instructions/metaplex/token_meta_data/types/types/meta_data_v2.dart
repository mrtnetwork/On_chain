import 'package:on_chain/solana/src/instructions/metaplex/bubblegum/types/types/collection.dart';
import 'package:on_chain/solana/src/instructions/metaplex/bubblegum/types/types/uses.dart';
import 'package:on_chain/solana/src/instructions/metaplex/fixed_price_sale/types/types/creator.dart';
import 'package:on_chain/solana/src/layout/layout.dart';

class MetaDataV2 extends LayoutSerializable {
  const MetaDataV2(
      {required this.name,
      required this.symbol,
      required this.uri,
      required this.sellerFeeBasisPoints,
      this.collection,
      this.uses,
      this.creators});
  factory MetaDataV2.fromJson(Map<String, dynamic> json) {
    return MetaDataV2(
        name: json["name"],
        symbol: json["symbol"],
        uri: json["uri"],
        sellerFeeBasisPoints: json["sellerFeeBasisPoints"],
        creators: json["creators"] == null
            ? null
            : (json["creators"] as List)
                .map((e) => Creator.fromJson(e))
                .toList(),
        collection: json["collection"] == null
            ? null
            : Collection.fromJson(json["collection"]),
        uses: json["uses"] == null ? null : Uses.fromJson(json["uses"]));
  }
  final String name;
  final String symbol;
  final String uri;
  final int sellerFeeBasisPoints;
  final Collection? collection;
  final Uses? uses;
  final List<Creator>? creators;
  @override
  Map<String, dynamic> serialize() {
    return {
      "name": name,
      "symbol": symbol,
      "uri": uri,
      "sellerFeeBasisPoints": sellerFeeBasisPoints,
      "collection": collection?.serialize(),
      "uses": uses?.serialize(),
      "creators": creators?.map((e) => e.serialize()).toList()
    };
  }

  static final Structure staticLayout = LayoutUtils.struct([
    LayoutUtils.string("name"),
    LayoutUtils.string("symbol"),
    LayoutUtils.string("uri"),
    LayoutUtils.u16("sellerFeeBasisPoints"),
    LayoutUtils.optional(LayoutUtils.vec(Creator.creatorLayout),
        property: "creators"),
    LayoutUtils.optional(Collection.staticLayout, property: "collection"),
    LayoutUtils.optional(Uses.staticLayout, property: "uses"),
  ], "metaDataV2");

  @override
  Structure get layout => staticLayout;
}
