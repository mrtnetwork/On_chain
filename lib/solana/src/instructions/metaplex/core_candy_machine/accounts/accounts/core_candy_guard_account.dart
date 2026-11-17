import 'package:blockchain_utils/encoding/encoding.dart';
import 'package:on_chain/solana/src/address/sol_address.dart';
import 'package:on_chain/solana/src/borsh_serialization/program_layout.dart';
import 'package:on_chain/solana/src/utils/layouts.dart';

class CoreCandyGuardAccount extends BorshLayoutSerializable {
  /// sha256("account:CandyGuard")[0..8], verified against the IDL build.
  static const List<int> discriminator = [44, 207, 199, 184, 112, 103, 34, 181];

  final SolAddress base;
  final int bump;
  final SolAddress authority;

  const CoreCandyGuardAccount({
    required this.base,
    required this.bump,
    required this.authority,
  });

  static StructLayout get _layout => LayoutConst.struct([
    LayoutConst.blob(8, property: 'discriminator'),
    SolanaLayoutUtils.publicKey('base'),
    LayoutConst.u8(property: 'bump'),
    SolanaLayoutUtils.publicKey('authority'),
  ]);

  @override
  StructLayout get layout => _layout;

  @override
  Map<String, dynamic> serialize() {
    return {
      'discriminator': discriminator,
      'base': base,
      'bump': bump,
      'authority': authority,
    };
  }

  factory CoreCandyGuardAccount.fromBuffer(List<int> bytes) {
    final decode = BorshLayoutSerializable.decode(
      bytes: bytes,
      layout: _layout,
      validator: {'discriminator': discriminator},
    );
    return CoreCandyGuardAccount(
      base: decode['base'],
      bump: decode['bump'],
      authority: decode['authority'],
    );
  }
}
