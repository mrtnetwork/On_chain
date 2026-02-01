import 'package:on_chain/solana/src/address/sol_address.dart';
import 'package:blockchain_utils/layout/layout.dart';
import 'package:on_chain/solana/src/borsh_serialization/program_layout.dart';
import 'package:on_chain/solana/src/utils/layouts.dart';

class _Utils {
  static const List<int> discriminator = [46, 101, 92, 150, 138, 30, 245, 120];
  static StructLayout get layout => LayoutConst.struct([
        LayoutConst.blob(8, property: 'discriminator'),
        SolanaLayoutUtils.publicKey('auctioneerAuthority'),
        SolanaLayoutUtils.publicKey('auctionHouse'),
        LayoutConst.u8(property: 'bump'),
      ]);
}

/// Auctioneer account
class Auctioneer extends BorshLayoutSerializable {
  static int get size => _Utils.layout.span;
  final SolAddress auctioneerAuthority;
  final SolAddress auctionHouse;
  final int bump;
  const Auctioneer(
      {required this.auctioneerAuthority,
      required this.auctionHouse,
      required this.bump});
  factory Auctioneer.fromBuffer(List<int> data) {
    final decode = BorshLayoutSerializable.decode(
        bytes: data,
        layout: _Utils.layout,
        validator: {'discriminator': _Utils.discriminator});
    return Auctioneer(
        auctioneerAuthority: decode['auctioneerAuthority'],
        auctionHouse: decode['auctionHouse'],
        bump: decode['bump']);
  }
  @override
  StructLayout get layout => _Utils.layout;
  @override
  Map<String, dynamic> serialize() {
    return {
      'discriminator': _Utils.discriminator,
      'auctioneerAuthority': auctioneerAuthority,
      'auctionHouse': auctionHouse,
      'bump': bump,
    };
  }

  @override
  String toString() {
    return 'Auctioneer${serialize()}';
  }
}
