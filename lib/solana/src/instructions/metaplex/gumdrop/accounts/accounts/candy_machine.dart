import 'package:on_chain/solana/src/address/sol_address.dart';
import 'package:on_chain/solana/src/instructions/metaplex/gumdrop/types/types/candy_machine_data.dart';
import 'package:blockchain_utils/layout/layout.dart';
import 'package:on_chain/solana/src/borsh_serialization/program_layout.dart';
import 'package:on_chain/solana/src/utils/layouts.dart';

class _Utils {
  static const List<int> discriminator = [51, 173, 177, 113, 25, 241, 109, 189];

  static StructLayout get layout => LayoutConst.struct([
        LayoutConst.blob(8, property: 'discriminator'),
        SolanaLayoutUtils.publicKey('authority'),
        SolanaLayoutUtils.publicKey('wallet'),
        LayoutConst.optional(SolanaLayoutUtils.publicKey(),
            property: 'tokenMint'),
        SolanaLayoutUtils.publicKey('config'),
        GumdropCandyMachineData.staticLayout,
        LayoutConst.u64(property: 'itemsRedeemed'),
        LayoutConst.u8(property: 'bump')
      ]);
}

class GumdropCandyMachine extends BorshLayoutSerializable {
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
    final decode = BorshLayoutSerializable.decode(
        bytes: data,
        layout: _Utils.layout,
        validator: {'discriminator': _Utils.discriminator});
    return GumdropCandyMachine(
        authority: decode['authority'],
        wallet: decode['wallet'],
        config: decode['config'],
        data: GumdropCandyMachineData.fromJson(decode['candyMachineData']),
        itemsRedeemed: decode['itemsRedeemed'],
        bump: decode['bump'],
        tokenMint: decode['tokenMint']);
  }

  @override
  StructLayout get layout => _Utils.layout;
  @override
  Map<String, dynamic> serialize() {
    return {
      'discriminator': _Utils.discriminator,
      'authority': authority,
      'wallet': wallet,
      'tokenMint': tokenMint,
      'config': config,
      'candyMachineData': data.serialize(),
      'itemsRedeemed': itemsRedeemed,
      'bump': bump
    };
  }

  @override
  String toString() {
    return 'GumdropCandyMachine${serialize()}';
  }
}
