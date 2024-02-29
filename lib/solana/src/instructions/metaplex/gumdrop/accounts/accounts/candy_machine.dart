import 'package:on_chain/solana/src/address/sol_address.dart';
import 'package:on_chain/solana/src/instructions/metaplex/gumdrop/types/types/candy_machine_data.dart';
import 'package:on_chain/solana/src/layout/layout.dart';

class _Utils {
  static const List<int> discriminator = [51, 173, 177, 113, 25, 241, 109, 189];

  static final Structure layout = LayoutUtils.struct([
    LayoutUtils.blob(8, property: "discriminator"),
    LayoutUtils.publicKey("authority"),
    LayoutUtils.publicKey("wallet"),
    LayoutUtils.optional(LayoutUtils.publicKey(), property: "tokenMint"),
    LayoutUtils.publicKey("config"),
    GumdropCandyMachineData.staticLayout,
    LayoutUtils.u64("itemsRedeemed"),
    LayoutUtils.u8("bump")
  ]);
}

class GumdropCandyMachine extends LayoutSerializable {
  final SolAddress authority;
  final SolAddress wallet;
  final SolAddress? tokenMint;
  final SolAddress config;
  final GumdropCandyMachineData data;
  final BigInt itemsRedeemed;
  final int bump;

  const GumdropCandyMachine(
      {required this.authority,
      required this.wallet,
      this.tokenMint,
      required this.config,
      required this.data,
      required this.itemsRedeemed,
      required this.bump});
  factory GumdropCandyMachine.fromBuffer(List<int> data) {
    final decode = LayoutSerializable.decode(
        bytes: data,
        layout: _Utils.layout,
        validator: {"discriminator": _Utils.discriminator});
    return GumdropCandyMachine(
        authority: decode["authority"],
        wallet: decode["wallet"],
        config: decode["config"],
        data: GumdropCandyMachineData.fromJson(decode["candyMachineData"]),
        itemsRedeemed: decode["itemsRedeemed"],
        bump: decode["bump"],
        tokenMint: decode["tokenMint"]);
  }

  @override
  Structure get layout => _Utils.layout;
  @override
  Map<String, dynamic> serialize() {
    return {
      "discriminator": _Utils.discriminator,
      "authority": authority,
      "wallet": wallet,
      "tokenMint": tokenMint,
      "config": config,
      "candyMachineData": data.serialize(),
      "itemsRedeemed": itemsRedeemed,
      "bump": bump
    };
  }

  @override
  String toString() {
    return "GumdropCandyMachine${serialize()}";
  }
}
