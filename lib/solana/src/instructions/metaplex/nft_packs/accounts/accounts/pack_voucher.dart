import 'package:on_chain/solana/src/address/sol_address.dart';
import 'package:on_chain/solana/src/instructions/metaplex/nft_packs/types/types/account_type.dart';
import 'package:on_chain/solana/src/layout/layout.dart';

class _Utils {
  static final Structure layout = LayoutUtils.struct([
    LayoutUtils.u8("accountType"),
    LayoutUtils.publicKey("packSet"),
    LayoutUtils.publicKey("master"),
    LayoutUtils.publicKey("metadata"),
  ]);
}

class PackVoucher extends LayoutSerializable {
  static int get size => _Utils.layout.span;
  final NFTPacksAccountType accountType;
  final SolAddress packSet;
  final SolAddress master;
  final SolAddress metadata;
  const PackVoucher(
      {required this.accountType,
      required this.packSet,
      required this.master,
      required this.metadata});
  factory PackVoucher.fromBuffer(List<int> data) {
    final decode =
        LayoutSerializable.decode(bytes: data, layout: _Utils.layout);
    return PackVoucher(
        accountType: NFTPacksAccountType.fromValue(decode["accountType"]),
        master: decode["master"],
        metadata: decode["metadata"],
        packSet: decode["packSet"]);
  }

  @override
  Structure get layout => _Utils.layout;
  @override
  Map<String, dynamic> serialize() {
    return {
      "accountType": accountType.value,
      "packSet": packSet,
      "metadata": metadata,
      "master": master
    };
  }

  @override
  String toString() {
    return "PackVoucher${serialize()}";
  }
}
