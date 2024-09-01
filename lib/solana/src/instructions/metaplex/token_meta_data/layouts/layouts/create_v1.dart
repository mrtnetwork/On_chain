import 'package:on_chain/solana/src/address/sol_address.dart';
import 'package:on_chain/solana/src/instructions/metaplex/bubblegum/types/types.dart';
import 'package:on_chain/solana/src/instructions/metaplex/fixed_price_sale/types/types/creator.dart';
import 'package:on_chain/solana/src/instructions/metaplex/token_meta_data/layouts/instruction/instruction.dart';
import 'package:on_chain/solana/src/instructions/metaplex/token_meta_data/types/types/collection_details.dart';
import 'package:on_chain/solana/src/instructions/metaplex/token_meta_data/types/types/print_supply.dart';
import 'package:on_chain/solana/src/instructions/metaplex/token_meta_data/types/types/token_standard.dart';
import 'package:blockchain_utils/layout/layout.dart';
import 'package:on_chain/solana/src/borsh_serialization/program_layout.dart';
import 'package:on_chain/solana/src/utils/layouts.dart';

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

  static final StructLayout _layout = LayoutConst.struct([
    LayoutConst.u8(property: "instruction"),
    LayoutConst.u8(property: "discriminator"),
    LayoutConst.string(property: "name"),
    LayoutConst.string(property: "symbol"),
    LayoutConst.string(property: "uri"),
    LayoutConst.u16(property: "sellerFeeBasisPoints"),
    LayoutConst.optional(LayoutConst.vec(Creator.creatorLayout),
        property: "creators"),
    LayoutConst.boolean(property: "primarySaleHappened"),
    LayoutConst.boolean(property: "isMutable"),
    LayoutConst.wrap(MetaDataTokenStandard.staticLayout,
        property: "tokenStandard"),
    LayoutConst.optional(Collection.staticLayout, property: "collection"),
    LayoutConst.optional(Uses.staticLayout, property: "uses"),
    LayoutConst.optional(CollectionDetailsV1.staticLayout,
        property: "collectionDetails"),
    SolanaLayoutUtils.optionPubkey(property: "ruleSet"),
    LayoutConst.optional(LayoutConst.u8(), property: "decimals"),
    LayoutConst.optional(PrintSupply.staticLayout, property: "printSupply")
  ]);

  static const int discriminator = 0;

  @override
  StructLayout get layout => _layout;

  @override
  MetaplexTokenMetaDataProgramInstruction get instruction =>
      MetaplexTokenMetaDataProgramInstruction.createV1;

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
