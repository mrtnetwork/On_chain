import 'package:on_chain/tron/address/tron_address.dart';
import 'package:on_chain/tron/provider/core/request.dart';
import 'package:on_chain/tron/provider/methods/request_methods.dart';

/// Deletes Proposal Transaction.
/// [developers.tron.network](https://developers.tron.network/reference/proposaldelete).
class TronRequestProposalDelete
    extends TVMRequestParam<Map<String, dynamic>, Map<String, dynamic>> {
  TronRequestProposalDelete(
      {required this.ownerAddress,
      required this.proposalId,
      this.permissionId,
      this.visible = true});

  /// Address of proposal owner.
  final TronAddress ownerAddress;

  /// Proposal ID
  final BigInt proposalId;

  /// for multi-signature use
  final int? permissionId;
  @override
  final bool visible;

  /// wallet/proposaldelete
  @override
  TronHTTPMethods get method => TronHTTPMethods.proposaldelete;

  @override
  Map<String, dynamic> toJson() {
    return {
      "owner_address": ownerAddress,
      "proposal_id": proposalId,
      "Permission_id": permissionId,
      "visible": visible
    };
  }

  @override
  String toString() {
    return "TronRequestProposalDelete{${toJson()}}";
  }
}
