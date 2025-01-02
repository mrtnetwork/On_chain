import 'package:on_chain/tron/src/address/tron_address.dart';
import 'package:on_chain/tron/src/provider/core/request.dart';
import 'package:on_chain/tron/src/provider/methods/request_methods.dart';

/// Approves proposed transaction.
/// [developers.tron.network](https://developers.tron.network/reference/proposalapprove).
class TronRequestProposalApprove
    extends TronRequest<Map<String, dynamic>, Map<String, dynamic>> {
  TronRequestProposalApprove(
      {required this.ownerAddress,
      required this.proposalId,
      required this.isAddApproval,
      this.permissionId,
      required this.visible});

  /// Approver address
  final TronAddress ownerAddress;

  /// Proposal ID
  final int proposalId;

  /// Approved
  final bool isAddApproval;

  /// for multi-signature use
  final int? permissionId;
  @override
  final bool visible;

  /// "wallet/proposalapprove"
  @override
  TronHTTPMethods get method => TronHTTPMethods.proposalapprove;

  @override
  Map<String, dynamic> toJson() {
    return {
      'owner_address': ownerAddress.toAddress(visible),
      'proposal_id': proposalId,
      'is_add_approval': isAddApproval,
      'Permission_id': permissionId,
      'visible': visible
    };
  }

  @override
  String toString() {
    return 'TronRequestProposalApprove{${toJson()}}';
  }
}
