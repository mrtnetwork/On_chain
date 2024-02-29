import 'package:blockchain_utils/blockchain_utils.dart';
import 'package:on_chain/solana/src/layout/layout.dart';

class CollectionDetailsV1 extends LayoutSerializable {
  final BigInt size;
  const CollectionDetailsV1({required this.size});
  factory CollectionDetailsV1.fromJson(Map<String, dynamic> json) {
    if (json["kind"] != 0) {
      throw MessageException("invalid or unknown CollectionDetailsV1");
    }
    return CollectionDetailsV1(size: json["size"]);
  }

  static Structure staticLayout = LayoutUtils.struct([
    LayoutUtils.u8("kind"),
    LayoutUtils.u64("size"),
  ], "collectionDetails");

  @override
  Structure get layout => staticLayout;

  @override
  Map<String, dynamic> serialize() {
    return {"kind": 0, "size": size};
  }
}
