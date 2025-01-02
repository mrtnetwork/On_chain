import 'package:on_chain/tron/src/address/tron_address.dart';
import 'package:on_chain/tron/src/provider/core/request.dart';
import 'package:on_chain/tron/src/provider/methods/request_methods.dart';

/// Creates a proposal transaction.
/// [developers.tron.network](https://developers.tron.network/reference/proposalcreate).
class TronRequestProposalCreate
    extends TronRequest<Map<String, dynamic>, Map<String, dynamic>> {
  TronRequestProposalCreate(
      {required this.ownerAddress,
      required this.parameters,
      this.permissionId,
      required this.visible});

  /// Address of the transaction creator
  final TronAddress ownerAddress;

  /// Proposal parameters
  final List<Map<String, BigInt>> parameters;

  /// for multi-signature use
  final int? permissionId;
  @override
  final bool visible;

  /// wallet/proposalcreate
  @override
  TronHTTPMethods get method => TronHTTPMethods.proposalcreate;

  @override
  Map<String, dynamic> toJson() {
    return {
      'owner_address': ownerAddress.toAddress(visible),
      'parameters': parameters,
      'Permission_id': permissionId,
      'visible': visible
    };
  }

  @override
  String toString() {
    return 'TronRequestProposalCreate{${toJson()}}';
  }
}
