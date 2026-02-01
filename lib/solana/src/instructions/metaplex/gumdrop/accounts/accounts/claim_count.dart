import 'package:on_chain/solana/src/address/sol_address.dart';
import 'package:blockchain_utils/layout/layout.dart';
import 'package:on_chain/solana/src/borsh_serialization/program_layout.dart';
import 'package:on_chain/solana/src/utils/layouts.dart';

class _Utils {
  static const List<int> discriminator = [78, 134, 220, 213, 34, 152, 102, 167];

  static StructLayout get layout => LayoutConst.struct([
        LayoutConst.blob(8, property: 'discriminator'),
        LayoutConst.u64(property: 'count'),
        SolanaLayoutUtils.publicKey('claimant'),
      ]);
}

class ClaimCount extends BorshLayoutSerializable {
  static int get size => _Utils.layout.span;
  final BigInt count;
  final SolAddress claimant;
  const ClaimCount({required this.claimant, required this.count});
  factory ClaimCount.fromBuffer(List<int> data) {
    final decode = BorshLayoutSerializable.decode(
        bytes: data,
        layout: _Utils.layout,
        validator: {'discriminator': _Utils.discriminator});
    return ClaimCount(claimant: decode['claimant'], count: decode['count']);
  }

  @override
  StructLayout get layout => _Utils.layout;

  @override
  Map<String, dynamic> serialize() {
    return {
      'discriminator': _Utils.discriminator,
      'count': count,
      'claimant': claimant,
    };
  }

  @override
  String toString() {
    return 'ClaimCount${serialize()}';
  }
}
