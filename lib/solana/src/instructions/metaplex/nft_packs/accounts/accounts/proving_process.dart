import 'package:on_chain/solana/src/address/sol_address.dart';
import 'package:on_chain/solana/src/instructions/metaplex/nft_packs/types/types/account_type.dart';
import 'package:on_chain/solana/src/layout/layout.dart';

class _Utils {
  static final Structure layout = LayoutUtils.struct([
    LayoutUtils.u8("accountType"),
    LayoutUtils.publicKey("walletKey"),
    LayoutUtils.boolean(property: "isExhausted"),
    LayoutUtils.publicKey("voucherMint"),
    LayoutUtils.publicKey("packSet"),
    LayoutUtils.u32("cardsRedeemed"),
    LayoutUtils.map(LayoutUtils.u32(), LayoutUtils.u32(),
        property: "cardsToRedeem")
  ]);
}

class ProvingProcess extends LayoutSerializable {
  final NFTPacksAccountType accountType;
  final SolAddress walletKey;
  final bool isExhausted;
  final SolAddress voucherMint;
  final SolAddress packSet;
  final int cardsRedeemed;
  final Map<int, int> cardsToRedeem;
  const ProvingProcess(
      {required this.accountType,
      required this.walletKey,
      required this.isExhausted,
      required this.voucherMint,
      required this.packSet,
      required this.cardsRedeemed,
      required this.cardsToRedeem});
  factory ProvingProcess.fromBuffer(List<int> data) {
    final decode =
        LayoutSerializable.decode(bytes: data, layout: _Utils.layout);
    return ProvingProcess(
        accountType: NFTPacksAccountType.fromValue(decode["accountType"]),
        walletKey: decode["walletKey"],
        isExhausted: decode["isExhausted"],
        voucherMint: decode["voucherMint"],
        packSet: decode["packSet"],
        cardsRedeemed: decode["cardsRedeemed"],
        cardsToRedeem: (decode["cardsToRedeem"] as Map).cast());
  }

  @override
  Structure get layout => _Utils.layout;
  @override
  Map<String, dynamic> serialize() {
    return {
      "accountType": accountType.value,
      "walletKey": walletKey,
      "isExhausted": isExhausted,
      "voucherMint": voucherMint,
      "packSet": packSet,
      "cardsRedeemed": cardsRedeemed,
      "cardsToRedeem": cardsToRedeem
    };
  }

  @override
  String toString() {
    return "ProvingProcess${serialize()}";
  }
}
