import 'package:on_chain/solana/src/instructions/metaplex/bubblegum/types/types/collection.dart';
import 'package:on_chain/solana/src/instructions/metaplex/bubblegum/types/types/uses.dart';
import 'package:on_chain/solana/src/instructions/metaplex/fixed_price_sale/types/types/creator.dart';
import 'package:blockchain_utils/layout/layout.dart';
import 'package:on_chain/solana/src/borsh_serialization/program_layout.dart';

class MetaDataV2 extends BorshLayoutSerializable {
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
        name: json['name'],
        symbol: json['symbol'],
        uri: json['uri'],
        sellerFeeBasisPoints: json['sellerFeeBasisPoints'],
        creators: json['creators'] == null
            ? null
            : (json['creators'] as List)
                .map((e) => Creator.fromJson(e))
                .toList(),
        collection: json['collection'] == null
            ? null
            : Collection.fromJson(json['collection']),
        uses: json['uses'] == null ? null : Uses.fromJson(json['uses']));
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
      'name': name,
      'symbol': symbol,
      'uri': uri,
      'sellerFeeBasisPoints': sellerFeeBasisPoints,
      'collection': collection?.serialize(),
      'uses': uses?.serialize(),
      'creators': creators?.map((e) => e.serialize()).toList()
    };
  }

  static StructLayout get staticLayout => LayoutConst.struct([
        LayoutConst.string(property: 'name'),
        LayoutConst.string(property: 'symbol'),
        LayoutConst.string(property: 'uri'),
        LayoutConst.u16(property: 'sellerFeeBasisPoints'),
        LayoutConst.optional(LayoutConst.vec(Creator.creatorLayout),
            property: 'creators'),
        LayoutConst.optional(Collection.staticLayout, property: 'collection'),
        LayoutConst.optional(Uses.staticLayout, property: 'uses'),
      ], property: 'metaDataV2');

  @override
  StructLayout get layout => staticLayout;
}
