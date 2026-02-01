import 'package:on_chain/solana/src/instructions/metaplex/fixed_price_sale/fixed_price_sale.dart';
import 'package:blockchain_utils/layout/layout.dart';
import 'package:on_chain/solana/src/borsh_serialization/program_layout.dart';

class GumdropConfigData extends BorshLayoutSerializable {
  final String uuid;
  final String symbol;
  final int sellerFeeBasisPoints;
  final List<Creator> creators;
  final BigInt maxSupply;
  final bool isMutable;
  final bool retainAuthority;
  final int maxNumberOfLines;
  const GumdropConfigData(
      {required this.uuid,
      required this.symbol,
      required this.sellerFeeBasisPoints,
      required this.creators,
      required this.maxSupply,
      required this.isMutable,
      required this.retainAuthority,
      required this.maxNumberOfLines});
  factory GumdropConfigData.fromJson(Map<String, dynamic> json) {
    return GumdropConfigData(
        uuid: json['uuid'],
        symbol: json['symbol'],
        sellerFeeBasisPoints: json['sellerFeeBasisPoints'],
        creators:
            (json['creators'] as List).map((e) => Creator.fromJson(e)).toList(),
        maxSupply: json['maxSupply'],
        isMutable: json['isMutable'],
        retainAuthority: json['retainAuthority'],
        maxNumberOfLines: json['maxNumberOfLines']);
  }
  static StructLayout get staticLayout => LayoutConst.struct([
        LayoutConst.string(property: 'uuid'),
        LayoutConst.string(property: 'symbol'),
        LayoutConst.u16(property: 'sellerFeeBasisPoints'),
        LayoutConst.vec(Creator.creatorLayout, property: 'creators'),
        LayoutConst.u64(property: 'maxSupply'),
        LayoutConst.boolean(property: 'isMutable'),
        LayoutConst.boolean(property: 'retainAuthority'),
        LayoutConst.u32(property: 'maxNumberOfLines'),
      ], property: 'configData');
  @override
  StructLayout get layout => staticLayout;

  @override
  Map<String, dynamic> serialize() {
    return {
      'uuid': uuid,
      'symbol': symbol,
      'sellerFeeBasisPoints': sellerFeeBasisPoints,
      'creators': creators.map((e) => e.serialize()).toList(),
      'maxSupply': maxSupply,
      'isMutable': isMutable,
      'retainAuthority': retainAuthority,
      'maxNumberOfLines': maxNumberOfLines
    };
  }

  @override
  String toString() {
    return 'GumdropConfigData${serialize()}';
  }
}
