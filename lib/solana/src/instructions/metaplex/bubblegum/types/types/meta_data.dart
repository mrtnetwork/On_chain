import 'package:on_chain/solana/src/instructions/metaplex/bubblegum/types/types/collection.dart';
import 'package:on_chain/solana/src/instructions/metaplex/bubblegum/types/types/token_program_version.dart';
import 'package:on_chain/solana/src/instructions/metaplex/bubblegum/types/types/token_standard.dart';
import 'package:on_chain/solana/src/instructions/metaplex/bubblegum/types/types/uses.dart';
import 'package:on_chain/solana/src/instructions/metaplex/fixed_price_sale/types/types/creator.dart';
import 'package:on_chain/solana/src/layout/layout.dart';

class MetaData extends LayoutSerializable {
  final String name;
  final String symbol;
  final String uri;
  final int sellerFeeBasisPoints;
  final bool primarySaleHappened;
  final bool isMutable;
  final int? editionNonce;
  final TokenStandard? tokenStandard;
  final Collection? collection;
  final Uses? uses;
  final TokenProgramVersion tokenProgramVersion;
  final List<Creator> creators;
  const MetaData(
      {required this.name,
      required this.symbol,
      required this.uri,
      required this.sellerFeeBasisPoints,
      required this.primarySaleHappened,
      required this.isMutable,
      required this.editionNonce,
      required this.tokenStandard,
      required this.collection,
      required this.uses,
      required this.tokenProgramVersion,
      required this.creators});
  factory MetaData.fromJson(Map<String, dynamic> json) {
    return MetaData(
        name: json["name"],
        symbol: json["symbol"],
        uri: json["uri"],
        sellerFeeBasisPoints: json["sellerFeeBasisPoints"],
        primarySaleHappened: json["primarySaleHappened"],
        isMutable: json["isMutable"],
        editionNonce: json["editionNonce"],
        tokenStandard: json["tokenStandard"] == null
            ? null
            : TokenStandard.fromValue(json["tokenStandard"]),
        collection: json["collection"] == null
            ? null
            : Collection.fromJson(json["collection"]),
        uses: json["uses"] == null ? null : Uses.fromJson(json["uses"]),
        tokenProgramVersion:
            TokenProgramVersion.fromValue(json["tokenProgramVersion"]),
        creators: (json["creators"] as List)
            .map((e) => Creator.fromJson(e))
            .toList());
  }
  factory MetaData.fromBuffer(List<int> bytes) {
    final decode =
        LayoutSerializable.decode(bytes: bytes, layout: staticLayout);
    return MetaData.fromJson(decode);
  }
  static Structure staticLayout = LayoutUtils.struct([
    LayoutUtils.string("name"),
    LayoutUtils.string("symbol"),
    LayoutUtils.string("uri"),
    LayoutUtils.u16("sellerFeeBasisPoints"),
    LayoutUtils.boolean(property: "primarySaleHappened"),
    LayoutUtils.boolean(property: "isMutable"),
    LayoutUtils.optional(LayoutUtils.u8(), property: "editionNonce"),
    LayoutUtils.optional(LayoutUtils.u8(), property: "tokenStandard"),
    LayoutUtils.optional(Collection.staticLayout, property: "collection"),
    LayoutUtils.optional(Uses.staticLayout, property: "uses"),
    LayoutUtils.u8("tokenProgramVersion"),
    LayoutUtils.vec(Creator.creatorLayout, property: "creators")
  ], "metaData");

  @override
  Structure get layout => staticLayout;
  @override
  Map<String, dynamic> serialize() {
    return {
      "name": name,
      "symbol": symbol,
      "uri": uri,
      "sellerFeeBasisPoints": sellerFeeBasisPoints,
      "primarySaleHappened": primarySaleHappened,
      "isMutable": isMutable,
      "editionNonce": editionNonce,
      "tokenStandard": tokenStandard?.value,
      "collection": collection?.serialize(),
      "uses": uses?.serialize(),
      "tokenProgramVersion": tokenProgramVersion.value,
      "creators": creators.map((e) => e.serialize()).toList()
    };
  }

  @override
  String toString() {
    return "MetaData${serialize()}";
  }
}
