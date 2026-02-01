import 'package:on_chain/solana/src/address/sol_address.dart';
import 'package:blockchain_utils/layout/layout.dart';
import 'package:on_chain/solana/src/borsh_serialization/program_layout.dart';
import 'package:on_chain/solana/src/utils/layouts.dart';

class _Utils {
  static const List<int> discriminator = [22, 183, 249, 157, 247, 95, 150, 96];

  static StructLayout get layout => LayoutConst.struct([
        LayoutConst.blob(8, property: 'discriminator'),
        LayoutConst.boolean(property: 'isClaimed'),
        SolanaLayoutUtils.publicKey('claimant'),
        LayoutConst.i64(property: 'claimedAt'),
        LayoutConst.u64(property: 'amount'),
      ]);
}

class ClaimStatus extends BorshLayoutSerializable {
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
    final decode = BorshLayoutSerializable.decode(
        bytes: data,
        layout: _Utils.layout,
        validator: {'discriminator': _Utils.discriminator});
    return ClaimStatus(
        isClaimed: decode['isClaimed'],
        claimant: decode['claimant'],
        claimedAt: decode['claimedAt'],
        amount: decode['amount']);
  }

  @override
  StructLayout get layout => _Utils.layout;

  @override
  Map<String, dynamic> serialize() {
    return {
      'discriminator': _Utils.discriminator,
      'isClaimed': isClaimed,
      'claimant': claimant,
      'claimedAt': claimedAt,
      'amount': amount
    };
  }

  @override
  String toString() {
    return 'ClaimStatus${serialize()}';
  }
}
