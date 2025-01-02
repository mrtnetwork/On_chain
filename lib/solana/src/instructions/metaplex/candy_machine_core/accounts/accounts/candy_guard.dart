import 'package:on_chain/solana/src/address/sol_address.dart';
import 'package:blockchain_utils/layout/layout.dart';
import 'package:on_chain/solana/src/borsh_serialization/program_layout.dart';
import 'package:on_chain/solana/src/utils/layouts.dart';

class _Utils {
  static const List<int> discriminator = [44, 207, 199, 184, 112, 103, 34, 181];
  static final StructLayout layout = LayoutConst.struct([
    LayoutConst.blob(8, property: 'discriminator'),
    SolanaLayoutUtils.publicKey('base'),
    LayoutConst.u8(property: 'bump'),
    SolanaLayoutUtils.publicKey('authority'),
  ]);
}

class CandyGaurdAccount extends LayoutSerializable {
  final SolAddress base;
  final int bump;
  final SolAddress authority;
  const CandyGaurdAccount(
      {required this.base, required this.bump, required this.authority});
  factory CandyGaurdAccount.fromBuffer(List<int> data) {
    final decode = LayoutSerializable.decode(
        bytes: data,
        layout: _Utils.layout,
        validator: {'discriminator': _Utils.discriminator});
    return CandyGaurdAccount(
        base: decode['base'],
        bump: decode['bump'],
        authority: decode['authority']);
  }

  @override
  StructLayout get layout => _Utils.layout;

  @override
  Map<String, dynamic> serialize() {
    return {
      'discriminator': _Utils.discriminator,
      'bump': bump,
      'base': base,
      'authority': authority,
    };
  }

  @override
  String toString() {
    return 'CandyGaurdAccount${serialize()}';
  }
}
