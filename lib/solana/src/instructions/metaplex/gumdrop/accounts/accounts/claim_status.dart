import 'package:on_chain/solana/src/address/sol_address.dart';
import 'package:on_chain/solana/src/layout/layout.dart';

class _Utils {
  static const List<int> discriminator = [22, 183, 249, 157, 247, 95, 150, 96];

  static final Structure layout = LayoutUtils.struct([
    LayoutUtils.blob(8, property: "discriminator"),
    LayoutUtils.boolean(property: "isClaimed"),
    LayoutUtils.publicKey("claimant"),
    LayoutUtils.i64("claimedAt"),
    LayoutUtils.u64("amount"),
  ]);
}

class ClaimStatus extends LayoutSerializable {
  static int get size => _Utils.layout.span;
  final bool isClaimed;
  final SolAddress claimant;
  final BigInt claimedAt;
  final BigInt amount;
  ClaimStatus(
      {required this.isClaimed,
      required this.claimant,
      required this.claimedAt,
      required this.amount});
  factory ClaimStatus.fromBuffer(List<int> data) {
    final decode = LayoutSerializable.decode(
        bytes: data,
        layout: _Utils.layout,
        validator: {"discriminator": _Utils.discriminator});
    return ClaimStatus(
        isClaimed: decode["isClaimed"],
        claimant: decode["claimant"],
        claimedAt: decode["claimedAt"],
        amount: decode["amount"]);
  }

  @override
  Structure get layout => _Utils.layout;

  @override
  Map<String, dynamic> serialize() {
    return {
      "discriminator": _Utils.discriminator,
      "isClaimed": isClaimed,
      "claimant": claimant,
      "claimedAt": claimedAt,
      "amount": amount
    };
  }

  @override
  String toString() {
    return "ClaimStatus${serialize()}";
  }
}
