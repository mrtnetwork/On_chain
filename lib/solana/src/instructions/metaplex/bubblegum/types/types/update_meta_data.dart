import 'package:on_chain/solana/src/instructions/metaplex/fixed_price_sale/types/types/creator.dart';
import 'package:blockchain_utils/layout/layout.dart';
import 'package:on_chain/solana/src/borsh_serialization/program_layout.dart';

class UpdateMetaData extends LayoutSerializable {
  final String? name;
  final String? symbol;
  final String? uri;
  final int? sellerFeeBasisPoints;
  final bool? primarySaleHappened;
  final bool? isMutable;
  final List<Creator>? creators;
  const UpdateMetaData(
      {required this.name,
      required this.symbol,
      required this.uri,
      required this.sellerFeeBasisPoints,
      required this.primarySaleHappened,
      required this.isMutable,
      required this.creators});
  factory UpdateMetaData.fromJson(Map<String, dynamic> json) {
    return UpdateMetaData(
        name: json["name"],
        symbol: json["symbol"],
        uri: json["uri"],
        sellerFeeBasisPoints: json["sellerFeeBasisPoints"],
        primarySaleHappened: json["primarySaleHappened"],
        isMutable: json["isMutable"],
        creators: json["creators"] == null
            ? null
            : (json["creators"] as List)
                .map((e) => Creator.fromJson(e))
                .toList());
  }
  factory UpdateMetaData.fromBuffer(List<int> bytes) {
    final decode =
        LayoutSerializable.decode(bytes: bytes, layout: staticLayout);
    return UpdateMetaData.fromJson(decode);
  }
  static StructLayout staticLayout = LayoutConst.struct([
    LayoutConst.optional(LayoutConst.string(), property: "name"),
    LayoutConst.optional(LayoutConst.string(), property: "symbol"),
    LayoutConst.optional(LayoutConst.string(), property: "uri"),
    LayoutConst.optional(LayoutConst.vec(Creator.creatorLayout),
        property: "creators"),
    LayoutConst.optional(LayoutConst.u16(), property: "sellerFeeBasisPoints"),
    LayoutConst.optional(LayoutConst.boolean(),
        property: "primarySaleHappened"),
    LayoutConst.optional(LayoutConst.boolean(), property: "isMutable"),
  ], property: "updateMetaData");

  @override
  StructLayout get layout => staticLayout;
  @override
  Map<String, dynamic> serialize() {
    return {
      "name": name,
      "symbol": symbol,
      "uri": uri,
      "sellerFeeBasisPoints": sellerFeeBasisPoints,
      "primarySaleHappened": primarySaleHappened,
      "isMutable": isMutable,
      "creators": creators?.map((e) => e.serialize()).toList()
    };
  }

  @override
  String toString() {
    return "UpdateMetaData${serialize()}";
  }
}
