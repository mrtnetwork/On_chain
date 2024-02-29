import 'package:on_chain/solana/src/instructions/metaplex/fixed_price_sale/fixed_price_sale.dart';
import 'package:on_chain/solana/src/layout/layout.dart';

class GumdropConfigData extends LayoutSerializable {
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
        uuid: json["uuid"],
        symbol: json["symbol"],
        sellerFeeBasisPoints: json["sellerFeeBasisPoints"],
        creators:
            (json["creators"] as List).map((e) => Creator.fromJson(e)).toList(),
        maxSupply: json["maxSupply"],
        isMutable: json["isMutable"],
        retainAuthority: json["retainAuthority"],
        maxNumberOfLines: json["maxNumberOfLines"]);
  }
  static final Structure staticLayout = LayoutUtils.struct([
    LayoutUtils.string("uuid"),
    LayoutUtils.string("symbol"),
    LayoutUtils.u16("sellerFeeBasisPoints"),
    LayoutUtils.vec(Creator.creatorLayout, property: "creators"),
    LayoutUtils.u64("maxSupply"),
    LayoutUtils.boolean(property: "isMutable"),
    LayoutUtils.boolean(property: "retainAuthority"),
    LayoutUtils.u32("maxNumberOfLines"),
  ], "configData");
  @override
  Structure get layout => staticLayout;

  @override
  Map<String, dynamic> serialize() {
    return {
      "uuid": uuid,
      "symbol": symbol,
      "sellerFeeBasisPoints": sellerFeeBasisPoints,
      "creators": creators.map((e) => e.serialize()).toList(),
      "maxSupply": maxSupply,
      "isMutable": isMutable,
      "retainAuthority": retainAuthority,
      "maxNumberOfLines": maxNumberOfLines
    };
  }

  @override
  String toString() {
    return "GumdropConfigData${serialize()}";
  }
}
