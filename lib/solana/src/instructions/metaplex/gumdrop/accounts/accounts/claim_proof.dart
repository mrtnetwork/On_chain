import 'package:blockchain_utils/blockchain_utils.dart';
import 'package:on_chain/solana/src/address/sol_address.dart';
import 'package:on_chain/solana/src/layout/layout.dart';

class _Utils {
  static const List<int> discriminator = [48, 173, 176, 137, 53, 116, 40, 112];

  static final Structure layout = LayoutUtils.struct([
    LayoutUtils.blob(8, property: "discriminator"),
    LayoutUtils.u64("amount"),
    LayoutUtils.u64("count"),
    LayoutUtils.publicKey("claimant"),
    LayoutUtils.publicKey("resource"),
    LayoutUtils.vecU8("resourceNonce")
  ]);
}

class ClaimProof extends LayoutSerializable {
  final BigInt amount;
  final BigInt count;
  final SolAddress claimant;
  final SolAddress resource;
  final List<int> resourceNonce;
  ClaimProof(
      {required this.amount,
      required this.count,
      required this.claimant,
      required this.resource,
      required List<int> resourceNonce})
      : resourceNonce = BytesUtils.toBytes(resourceNonce, unmodifiable: true);
  factory ClaimProof.fromBuffer(List<int> data) {
    final decode = LayoutSerializable.decode(
        bytes: data,
        layout: _Utils.layout,
        validator: {"discriminator": _Utils.discriminator});
    return ClaimProof(
        amount: decode["amount"],
        count: decode["count"],
        claimant: decode["claimant"],
        resource: decode["resource"],
        resourceNonce: (decode["resourceNonce"] as List).cast());
  }

  @override
  Structure get layout => _Utils.layout;

  @override
  Map<String, dynamic> serialize() {
    return {
      "discriminator": _Utils.discriminator,
      "amount": amount,
      "count": count,
      "claimant": claimant,
      "resource": resource,
      "resourceNonce": resourceNonce
    };
  }

  @override
  String toString() {
    return "ClaimProof${serialize()}";
  }
}
