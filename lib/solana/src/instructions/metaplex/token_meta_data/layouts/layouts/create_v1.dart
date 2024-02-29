import 'package:on_chain/solana/src/address/sol_address.dart';
import 'package:on_chain/solana/src/instructions/metaplex/bubblegum/types/types.dart';
import 'package:on_chain/solana/src/instructions/metaplex/fixed_price_sale/types/types/creator.dart';
import 'package:on_chain/solana/src/instructions/metaplex/token_meta_data/layouts/instruction/instruction.dart';
import 'package:on_chain/solana/src/instructions/metaplex/token_meta_data/types/types/collection_details.dart';
import 'package:on_chain/solana/src/instructions/metaplex/token_meta_data/types/types/print_supply.dart';
import 'package:on_chain/solana/src/instructions/metaplex/token_meta_data/types/types/token_standard.dart';
import 'package:on_chain/solana/src/layout/layout.dart';

class MetaplexTokenMetaDataCreateV1Layout
    extends MetaplexTokenMetaDataProgramLayout {
  final String name;
  final String symbol;
  final String uri;
  final int sellerFeeBasisPoints;
  final List<Creator>? creators;
  final bool primarySaleHappened;
  final bool isMutable;
  final MetaDataTokenStandard tokenStandard;
  final Collection? collection;
  final Uses? uses;
  final CollectionDetailsV1? collectionDetails;
  final SolAddress? ruleSet;
  final int? decimals;
  final PrintSupply? printSupply;
  MetaplexTokenMetaDataCreateV1Layout(
      {required this.name,
      required this.symbol,
      required this.uri,
      required this.sellerFeeBasisPoints,
      List<Creator>? creators,
      required this.primarySaleHappened,
      required this.isMutable,
      required this.tokenStandard,
      this.collection,
      this.uses,
      this.collectionDetails,
      this.ruleSet,
      this.decimals,
      this.printSupply})
      : creators = creators == null ? null : List.unmodifiable(creators);

  factory MetaplexTokenMetaDataCreateV1Layout.fromBuffer(List<int> data) {
    final decode = ProgramLayout.decodeAndValidateStruct(
        layout: _layout,
        bytes: data,
        instruction:
            MetaplexTokenMetaDataProgramInstruction.createV1.insturction);
    return MetaplexTokenMetaDataCreateV1Layout(
        name: decode["name"],
        symbol: decode["symbol"],
        uri: decode["uri"],
        creators: decode["creators"] == null
            ? null
            : (decode["creators"] as List)
                .map((e) => Creator.fromJson(e))
                .toList(),
        primarySaleHappened: decode["primarySaleHappened"],
        isMutable: decode["isMutable"],
        tokenStandard: MetaDataTokenStandard.fromJson(decode["tokenStandard"]),
        collection: decode["collection"] == null
            ? null
            : Collection.fromJson(decode["collection"]),
        uses: decode["uses"] == null ? null : Uses.fromJson(decode["uses"]),
        collectionDetails: decode["collectionDetails"] == null
            ? null
            : CollectionDetailsV1.fromJson(decode["collectionDetails"]),
        ruleSet: decode["ruleSet"],
        decimals: decode["decimals"],
        printSupply: decode["printSupply"] == null
            ? null
            : PrintSupply.fromJson(json: decode["printSupply"]),
        sellerFeeBasisPoints: decode["sellerFeeBasisPoints"]);
  }

  static final Structure _layout = LayoutUtils.struct([
    LayoutUtils.u8("instruction"),
    LayoutUtils.u8("discriminator"),
    LayoutUtils.string("name"),
    LayoutUtils.string("symbol"),
    LayoutUtils.string("uri"),
    LayoutUtils.u16("sellerFeeBasisPoints"),
    LayoutUtils.optional(LayoutUtils.vec(Creator.creatorLayout),
        property: "creators"),
    LayoutUtils.boolean(property: "primarySaleHappened"),
    LayoutUtils.boolean(property: "isMutable"),
    LayoutUtils.wrap(MetaDataTokenStandard.staticLayout,
        property: "tokenStandard"),
    LayoutUtils.optional(Collection.staticLayout, property: "collection"),
    LayoutUtils.optional(Uses.staticLayout, property: "uses"),
    LayoutUtils.optional(CollectionDetailsV1.staticLayout,
        property: "collectionDetails"),
    LayoutUtils.optionPubkey(property: "ruleSet"),
    LayoutUtils.optional(LayoutUtils.u8(), property: "decimals"),
    LayoutUtils.optional(PrintSupply.staticLayout, property: "printSupply")
  ]);

  static const int discriminator = 0;

  @override
  Structure get layout => _layout;

  @override
  int get instruction =>
      MetaplexTokenMetaDataProgramInstruction.createV1.insturction;

  @override
  Map<String, dynamic> serialize() {
    return {
      "discriminator": discriminator,
      "name": name,
      "symbol": symbol,
      "uri": uri,
      "sellerFeeBasisPoints": sellerFeeBasisPoints,
      "creators": creators?.map((e) => e.serialize()).toList(),
      "primarySaleHappened": primarySaleHappened,
      "isMutable": isMutable,
      "tokenStandard": tokenStandard.serialize(),
      "collection": collection?.serialize(),
      "uses": uses?.serialize(),
      "collectionDetails": collectionDetails?.serialize(),
      "ruleSet": ruleSet,
      "decimals": decimals,
      "printSupply": printSupply?.serialize(),
    };
  }
}
