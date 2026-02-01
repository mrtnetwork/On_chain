import 'package:on_chain/solana/src/instructions/metaplex/fixed_price_sale/types/types/creator.dart';
import 'package:blockchain_utils/layout/layout.dart';
import 'package:on_chain/solana/src/borsh_serialization/program_layout.dart';

class MetaDataData extends BorshLayoutSerializable {
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
        name: json['name'],
        symbol: json['symbol'],
        uri: json['uri'],
        sellerFeeBasisPoints: json['sellerFeeBasisPoints'],
        creators: json['creators'] == null
            ? null
            : (json['creators'] as List)
                .map((e) => Creator.fromJson(e))
                .toList());
  }
  static StructLayout get staticLayout => LayoutConst.struct([
        LayoutConst.string(property: 'name'),
        LayoutConst.string(property: 'symbol'),
        LayoutConst.string(property: 'uri'),
        LayoutConst.u16(property: 'sellerFeeBasisPoints'),
        LayoutConst.optional(LayoutConst.vec(Creator.creatorLayout),
            property: 'creators'),
      ], property: 'metaDataData');

  @override
  StructLayout get layout => staticLayout;
  @override
  Map<String, dynamic> serialize() {
    return {
      'name': name,
      'symbol': symbol,
      'uri': uri,
      'sellerFeeBasisPoints': sellerFeeBasisPoints,
      'creators': creators?.map((e) => e.serialize()).toList()
    };
  }
}
