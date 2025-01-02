import 'package:on_chain/solana/src/address/sol_address.dart';
import 'package:blockchain_utils/layout/layout.dart';
import 'package:on_chain/solana/src/borsh_serialization/program_layout.dart';
import 'package:on_chain/solana/src/utils/layouts.dart';

class _Utils {
  static const List<int> discriminator = [50, 164, 42, 108, 90, 201, 250, 216];

  static final StructLayout layout = LayoutConst.struct([
    LayoutConst.blob(8, property: 'discriminator'),
    SolanaLayoutUtils.publicKey('mint'),
    SolanaLayoutUtils.publicKey('fanout'),
    SolanaLayoutUtils.publicKey('tokenAccount'),
    LayoutConst.u64(property: 'totalInflow'),
    LayoutConst.u64(property: 'lastSnapshotAmount'),
    LayoutConst.u8(property: 'bumpSeed'),
  ]);
}

class FanoutMint extends LayoutSerializable {
  final SolAddress mint;
  final SolAddress fanout;
  final SolAddress tokenAccount;
  final BigInt totalInflow;
  final BigInt lastSnapshotAmount;
  final int bumpSeed;

  const FanoutMint(
      {required this.mint,
      required this.fanout,
      required this.tokenAccount,
      required this.totalInflow,
      required this.lastSnapshotAmount,
      required this.bumpSeed});
  factory FanoutMint.fromBuffer(List<int> data) {
    final decode = LayoutSerializable.decode(
        bytes: data,
        layout: _Utils.layout,
        validator: {'discriminator': _Utils.discriminator});
    return FanoutMint(
        mint: decode['mint'],
        fanout: decode['fanout'],
        tokenAccount: decode['tokenAccount'],
        totalInflow: decode['totalInflow'],
        lastSnapshotAmount: decode['lastSnapshotAmount'],
        bumpSeed: decode['bumpSeed']);
  }

  @override
  StructLayout get layout => _Utils.layout;
  @override
  Map<String, dynamic> serialize() {
    return {
      'discriminator': _Utils.discriminator,
      'mint': mint,
      'fanout': fanout,
      'tokenAccount': tokenAccount,
      'totalInflow': totalInflow,
      'lastSnapshotAmount': lastSnapshotAmount,
      'bumpSeed': bumpSeed
    };
  }

  @override
  String toString() {
    return 'FanoutMint${serialize()}';
  }
}
