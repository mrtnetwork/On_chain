import 'package:on_chain/solana/src/address/sol_address.dart';
import 'package:blockchain_utils/layout/layout.dart';
import 'package:on_chain/solana/src/borsh_serialization/program_layout.dart';
import 'package:on_chain/solana/src/utils/layouts.dart';

class AuthorizedVoter extends BorshLayoutSerializable {
  final BigInt epoch;
  final SolAddress authorizedVoter;
  const AuthorizedVoter({required this.epoch, required this.authorizedVoter});
  factory AuthorizedVoter.fromJson(Map<String, dynamic> json) {
    return AuthorizedVoter(
        epoch: json['epoch'], authorizedVoter: json['authorizedVoter']);
  }

  static StructLayout get staticLayout => LayoutConst.struct([
        LayoutConst.u64(property: 'epoch'),
        SolanaLayoutUtils.publicKey('authorizedVoter')
      ], property: 'authorizedVoter');
  @override
  StructLayout get layout => staticLayout;

  @override
  Map<String, dynamic> serialize() {
    return {'epoch': epoch, 'authorizedVoter': authorizedVoter};
  }

  @override
  String toString() {
    return 'AuthorizedVoter${serialize()}';
  }
}
