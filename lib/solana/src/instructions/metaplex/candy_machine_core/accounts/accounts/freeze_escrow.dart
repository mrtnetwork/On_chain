import 'package:on_chain/solana/src/address/sol_address.dart';
import 'package:blockchain_utils/layout/layout.dart';
import 'package:on_chain/solana/src/borsh_serialization/program_layout.dart';
import 'package:on_chain/solana/src/utils/layouts.dart';

class _Utils {
  static const List<int> discriminator = [227, 186, 40, 152, 7, 174, 131, 184];

  static final StructLayout layout = LayoutConst.struct([
    LayoutConst.blob(8, property: 'discriminator'),
    SolanaLayoutUtils.publicKey('candyGuard'),
    SolanaLayoutUtils.publicKey('candyMachine'),
    LayoutConst.u64(property: 'frozenCount'),
    LayoutConst.optional(LayoutConst.i64(), property: 'firstMintTime'),
    LayoutConst.u64(property: 'freezePeriod'),
    SolanaLayoutUtils.publicKey('destination'),
    SolanaLayoutUtils.publicKey('authority')
  ]);
}

class FreezeEscrowAccount extends LayoutSerializable {
  /// Candy guard address associated with this escrow.
  final SolAddress candyGuard;

  /// Candy machine address associated with this escrow.
  final SolAddress candyMachine;

  /// Number of NFTs frozen.
  final SolAddress frozenCount;

  /// The timestamp of the first (frozen) mint. This is used to calculate
  /// when the freeze period is over.
  final BigInt? firstMintTime;

  /// The amount of time (in seconds) for the freeze. The NFTs will be
  /// allowed to thaw after this.
  final BigInt freezePeriod;

  /// The destination address for the frozen fund to go to.
  final SolAddress destination;

  /// The authority that initialized the freeze. This will be the only
  /// address able to unlock the funds in case the candy guard account is
  /// closed.
  final SolAddress authority;
  const FreezeEscrowAccount(
      {required this.candyGuard,
      required this.candyMachine,
      required this.frozenCount,
      this.firstMintTime,
      required this.freezePeriod,
      required this.destination,
      required this.authority});
  factory FreezeEscrowAccount.fromBuffer(List<int> data) {
    final decode = LayoutSerializable.decode(
        bytes: data,
        layout: _Utils.layout,
        validator: {'discriminator': _Utils.discriminator});
    return FreezeEscrowAccount(
        candyGuard: decode['candyGuard'],
        candyMachine: decode['candyMachine'],
        frozenCount: decode['frozenCount'],
        freezePeriod: decode['freezePeriod'],
        destination: decode['destination'],
        authority: decode['authority'],
        firstMintTime: decode['firstMintTime']);
  }

  @override
  StructLayout get layout => _Utils.layout;

  @override
  Map<String, dynamic> serialize() {
    return {
      'discriminator': _Utils.discriminator,
      'candyGuard': candyGuard,
      'candyMachine': candyMachine,
      'frozenCount': frozenCount,
      'firstMintTime': firstMintTime,
      'freezePeriod': freezePeriod,
      'destination': destination,
      'authority': authority
    };
  }

  @override
  String toString() {
    return 'FreezeEscrow${serialize()}';
  }
}
