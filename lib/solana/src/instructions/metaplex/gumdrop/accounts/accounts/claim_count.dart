import 'package:on_chain/solana/src/address/sol_address.dart';
import 'package:on_chain/solana/src/layout/layout.dart';

class _Utils {
  static const List<int> discriminator = [78, 134, 220, 213, 34, 152, 102, 167];

  static final Structure layout = LayoutUtils.struct([
    LayoutUtils.blob(8, property: "discriminator"),
    LayoutUtils.u64("count"),
    LayoutUtils.publicKey("claimant"),
  ]);
}

class ClaimCount extends LayoutSerializable {
  static int get size => _Utils.layout.span;
  final BigInt count;
  final SolAddress claimant;
  const ClaimCount({required this.claimant, required this.count});
  factory ClaimCount.fromBuffer(List<int> data) {
    final decode = LayoutSerializable.decode(
        bytes: data,
        layout: _Utils.layout,
        validator: {"discriminator": _Utils.discriminator});
    return ClaimCount(claimant: decode["claimant"], count: decode["count"]);
  }

  @override
  Structure get layout => _Utils.layout;

  @override
  Map<String, dynamic> serialize() {
    return {
      "discriminator": _Utils.discriminator,
      "count": count,
      "claimant": claimant,
    };
  }

  @override
  String toString() {
    return "ClaimCount${serialize()}";
  }
}
