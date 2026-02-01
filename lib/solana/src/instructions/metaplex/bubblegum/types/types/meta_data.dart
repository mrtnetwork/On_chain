import 'package:on_chain/solana/src/instructions/metaplex/bubblegum/types/types/collection.dart';
import 'package:on_chain/solana/src/instructions/metaplex/bubblegum/types/types/token_program_version.dart';
import 'package:on_chain/solana/src/instructions/metaplex/bubblegum/types/types/token_standard.dart';
import 'package:on_chain/solana/src/instructions/metaplex/bubblegum/types/types/uses.dart';
import 'package:on_chain/solana/src/instructions/metaplex/fixed_price_sale/types/types/creator.dart';
import 'package:blockchain_utils/layout/layout.dart';
import 'package:on_chain/solana/src/borsh_serialization/program_layout.dart';

class MetaData extends BorshLayoutSerializable {
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
        name: json['name'],
        symbol: json['symbol'],
        uri: json['uri'],
        sellerFeeBasisPoints: json['sellerFeeBasisPoints'],
        primarySaleHappened: json['primarySaleHappened'],
        isMutable: json['isMutable'],
        editionNonce: json['editionNonce'],
        tokenStandard: json['tokenStandard'] == null
            ? null
            : TokenStandard.fromValue(json['tokenStandard']),
        collection: json['collection'] == null
            ? null
            : Collection.fromJson(json['collection']),
        uses: json['uses'] == null ? null : Uses.fromJson(json['uses']),
        tokenProgramVersion:
            TokenProgramVersion.fromValue(json['tokenProgramVersion']),
        creators: (json['creators'] as List)
            .map((e) => Creator.fromJson(e))
            .toList());
  }
  factory MetaData.fromBuffer(List<int> bytes) {
    final decode =
        BorshLayoutSerializable.decode(bytes: bytes, layout: staticLayout);
    return MetaData.fromJson(decode);
  }
  static StructLayout staticLayout = LayoutConst.struct([
    LayoutConst.string(property: 'name'),
    LayoutConst.string(property: 'symbol'),
    LayoutConst.string(property: 'uri'),
    LayoutConst.u16(property: 'sellerFeeBasisPoints'),
    LayoutConst.boolean(property: 'primarySaleHappened'),
    LayoutConst.boolean(property: 'isMutable'),
    LayoutConst.optional(LayoutConst.u8(), property: 'editionNonce'),
    LayoutConst.optional(LayoutConst.u8(), property: 'tokenStandard'),
    LayoutConst.optional(Collection.staticLayout, property: 'collection'),
    LayoutConst.optional(Uses.staticLayout, property: 'uses'),
    LayoutConst.u8(property: 'tokenProgramVersion'),
    LayoutConst.vec(Creator.creatorLayout, property: 'creators')
  ], property: 'metaData');

  @override
  StructLayout get layout => staticLayout;
  @override
  Map<String, dynamic> serialize() {
    return {
      'name': name,
      'symbol': symbol,
      'uri': uri,
      'sellerFeeBasisPoints': sellerFeeBasisPoints,
      'primarySaleHappened': primarySaleHappened,
      'isMutable': isMutable,
      'editionNonce': editionNonce,
      'tokenStandard': tokenStandard?.value,
      'collection': collection?.serialize(),
      'uses': uses?.serialize(),
      'tokenProgramVersion': tokenProgramVersion.value,
      'creators': creators.map((e) => e.serialize()).toList()
    };
  }

  @override
  String toString() {
    return 'MetaData${serialize()}';
  }
}
