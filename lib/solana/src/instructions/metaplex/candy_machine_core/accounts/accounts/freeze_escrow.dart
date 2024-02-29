import 'package:on_chain/solana/src/address/sol_address.dart';
import 'package:on_chain/solana/src/layout/layout.dart';

class _Utils {
  static const List<int> discriminator = [227, 186, 40, 152, 7, 174, 131, 184];

  static final Structure layout = LayoutUtils.struct([
    LayoutUtils.blob(8, property: "discriminator"),
    LayoutUtils.publicKey("candyGuard"),
    LayoutUtils.publicKey("candyMachine"),
    LayoutUtils.u64("frozenCount"),
    LayoutUtils.optional(LayoutUtils.i64(), property: "firstMintTime"),
    LayoutUtils.u64("freezePeriod"),
    LayoutUtils.publicKey("destination"),
    LayoutUtils.publicKey("authority")
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
        validator: {"discriminator": _Utils.discriminator});
    return FreezeEscrowAccount(
        candyGuard: decode["candyGuard"],
        candyMachine: decode["candyMachine"],
        frozenCount: decode["frozenCount"],
        freezePeriod: decode["freezePeriod"],
        destination: decode["destination"],
        authority: decode["authority"],
        firstMintTime: decode["firstMintTime"]);
  }

  @override
  Structure get layout => _Utils.layout;

  @override
  Map<String, dynamic> serialize() {
    return {
      "discriminator": _Utils.discriminator,
      "candyGuard": candyGuard,
      "candyMachine": candyMachine,
      "frozenCount": frozenCount,
      "firstMintTime": firstMintTime,
      "freezePeriod": freezePeriod,
      "destination": destination,
      "authority": authority
    };
  }

  @override
  String toString() {
    return "FreezeEscrow${serialize()}";
  }
}
