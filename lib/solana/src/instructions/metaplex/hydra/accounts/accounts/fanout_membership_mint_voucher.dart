import 'package:on_chain/solana/src/address/sol_address.dart';
import 'package:blockchain_utils/layout/layout.dart';
import 'package:on_chain/solana/src/borsh_serialization/program_layout.dart';
import 'package:on_chain/solana/src/utils/layouts.dart';

class _Utils {
  static const List<int> discriminator = [
    185,
    33,
    118,
    173,
    147,
    114,
    126,
    181
  ];

  static final StructLayout layout = LayoutConst.struct([
    LayoutConst.blob(8, property: 'discriminator'),
    SolanaLayoutUtils.publicKey('fanout'),
    SolanaLayoutUtils.publicKey('fanoutMint'),
    LayoutConst.u64(property: 'lastInflow'),
    LayoutConst.u8(property: 'bumpSeed')
  ]);
}

class FanoutMembershipMintVoucher extends LayoutSerializable {
  final SolAddress fanout;
  final SolAddress fanoutMint;
  final BigInt lastInflow;
  final int bumpSeed;

  const FanoutMembershipMintVoucher(
      {required this.fanout,
      required this.fanoutMint,
      required this.lastInflow,
      required this.bumpSeed});
  factory FanoutMembershipMintVoucher.fromBuffer(List<int> data) {
    final decode = LayoutSerializable.decode(
        bytes: data,
        layout: _Utils.layout,
        validator: {'discriminator': _Utils.discriminator});
    return FanoutMembershipMintVoucher(
        fanout: decode['fanout'],
        fanoutMint: decode['fanoutMint'],
        lastInflow: decode['lastInflow'],
        bumpSeed: decode['bumpSeed']);
  }

  @override
  StructLayout get layout => _Utils.layout;
  @override
  Map<String, dynamic> serialize() {
    return {
      'discriminator': _Utils.discriminator,
      'fanout': fanout,
      'fanoutMint': fanoutMint,
      'lastInflow': lastInflow,
      'bumpSeed': bumpSeed
    };
  }

  @override
  String toString() {
    return 'FanoutMembershipMintVoucher${serialize()}';
  }
}
