import 'package:on_chain/solana/src/address/sol_address.dart';
import 'package:on_chain/solana/src/layout/layout.dart';

class AuthorizedVoter extends LayoutSerializable {
  final BigInt epoch;
  final SolAddress authorizedVoter;
  const AuthorizedVoter({required this.epoch, required this.authorizedVoter});
  factory AuthorizedVoter.fromJson(Map<String, dynamic> json) {
    return AuthorizedVoter(
        epoch: json["epoch"], authorizedVoter: json["authorizedVoter"]);
  }

  static final Structure staticLayout = LayoutUtils.struct(
      [LayoutUtils.u64("epoch"), LayoutUtils.publicKey("authorizedVoter")],
      "authorizedVoter");
  @override
  Structure get layout => staticLayout;

  @override
  Map<String, dynamic> serialize() {
    return {"epoch": epoch, "authorizedVoter": authorizedVoter};
  }

  @override
  String toString() {
    return "AuthorizedVoter${serialize()}";
  }
}
