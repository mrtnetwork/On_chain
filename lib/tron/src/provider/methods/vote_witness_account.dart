import 'package:on_chain/tron/src/address/tron_address.dart';
import 'package:on_chain/tron/src/provider/core/request.dart';
import 'package:on_chain/tron/src/provider/methods/request_methods.dart';

/// Vote for witnesses
/// [developers.tron.network](https://developers.tron.network/reference/votewitnessaccount).
class TronRequestVoteWitnessAccount
    extends TVMRequestParam<Map<String, dynamic>, Map<String, dynamic>> {
  TronRequestVoteWitnessAccount(
      {required this.ownerAddress,
      this.permissionId,
      required this.votes,
      this.visible = true});

  /// Owner address
  final TronAddress ownerAddress;

  /// for multi-signature use
  final int? permissionId;
  @override
  final bool visible;

  /// vote_address' stands for the address of the witness you want to vote
  final List<Map<TronAddress, int>> votes;

  /// wallet/votewitnessaccount
  @override
  TronHTTPMethods get method => TronHTTPMethods.votewitnessaccount;

  @override
  Map<String, dynamic> toJson() {
    return {
      "owner_address": ownerAddress,
      "votes": votes,
      "Permission_id": permissionId,
      "visible": visible
    };
  }

  @override
  String toString() {
    return "TronRequestVoteWitnessAccount{${toJson()}}";
  }
}
