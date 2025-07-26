import 'package:blockchain_utils/blockchain_utils.dart';
import 'package:on_chain/solana/src/address/sol_address.dart';
import 'package:on_chain/solana/src/borsh_serialization/program_layout.dart';
import 'package:on_chain/solana/src/utils/layouts.dart';

class _Utils {
  static const List<int> discriminator = [48, 173, 176, 137, 53, 116, 40, 112];

  static final StructLayout layout = LayoutConst.struct([
    LayoutConst.blob(8, property: 'discriminator'),
    LayoutConst.u64(property: 'amount'),
    LayoutConst.u64(property: 'count'),
    SolanaLayoutUtils.publicKey('claimant'),
    SolanaLayoutUtils.publicKey('resource'),
    LayoutConst.vecU8(property: 'resourceNonce')
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
      : resourceNonce = resourceNonce.asImmutableBytes;
  factory ClaimProof.fromBuffer(List<int> data) {
    final decode = LayoutSerializable.decode(
        bytes: data,
        layout: _Utils.layout,
        validator: {'discriminator': _Utils.discriminator});
    return ClaimProof(
        amount: decode['amount'],
        count: decode['count'],
        claimant: decode['claimant'],
        resource: decode['resource'],
        resourceNonce: (decode['resourceNonce'] as List).cast());
  }

  @override
  StructLayout get layout => _Utils.layout;

  @override
  Map<String, dynamic> serialize() {
    return {
      'discriminator': _Utils.discriminator,
      'amount': amount,
      'count': count,
      'claimant': claimant,
      'resource': resource,
      'resourceNonce': resourceNonce
    };
  }

  @override
  String toString() {
    return 'ClaimProof${serialize()}';
  }
}
