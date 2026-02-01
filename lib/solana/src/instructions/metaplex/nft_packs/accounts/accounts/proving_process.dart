import 'package:on_chain/solana/src/address/sol_address.dart';
import 'package:on_chain/solana/src/instructions/metaplex/nft_packs/types/types/account_type.dart';
import 'package:blockchain_utils/layout/layout.dart';
import 'package:on_chain/solana/src/borsh_serialization/program_layout.dart';
import 'package:on_chain/solana/src/utils/layouts.dart';

class _Utils {
  static StructLayout get layout => LayoutConst.struct([
        LayoutConst.u8(property: 'accountType'),
        SolanaLayoutUtils.publicKey('walletKey'),
        LayoutConst.boolean(property: 'isExhausted'),
        SolanaLayoutUtils.publicKey('voucherMint'),
        SolanaLayoutUtils.publicKey('packSet'),
        LayoutConst.u32(property: 'cardsRedeemed'),
        LayoutConst.map(LayoutConst.u32(), LayoutConst.u32(),
            property: 'cardsToRedeem')
      ]);
}

class ProvingProcess extends BorshLayoutSerializable {
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
        BorshLayoutSerializable.decode(bytes: data, layout: _Utils.layout);
    return ProvingProcess(
        accountType: NFTPacksAccountType.fromValue(decode['accountType']),
        walletKey: decode['walletKey'],
        isExhausted: decode['isExhausted'],
        voucherMint: decode['voucherMint'],
        packSet: decode['packSet'],
        cardsRedeemed: decode['cardsRedeemed'],
        cardsToRedeem: (decode['cardsToRedeem'] as Map).cast());
  }

  @override
  StructLayout get layout => _Utils.layout;
  @override
  Map<String, dynamic> serialize() {
    return {
      'accountType': accountType.value,
      'walletKey': walletKey,
      'isExhausted': isExhausted,
      'voucherMint': voucherMint,
      'packSet': packSet,
      'cardsRedeemed': cardsRedeemed,
      'cardsToRedeem': cardsToRedeem
    };
  }

  @override
  String toString() {
    return 'ProvingProcess${serialize()}';
  }
}
