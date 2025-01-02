import 'package:on_chain/ada/src/address/address.dart';
import 'package:on_chain/ada/src/provider/blockfrost/core/blockfrost.dart';
import 'package:on_chain/ada/src/provider/blockfrost/core/core.dart';
import 'package:on_chain/ada/src/provider/blockfrost/models/response_model.dart';

/// Obtain information about the MIRs of a specific account.
/// https://blockfrost.dev/api/account-mir-history
class BlockfrostRequestAccountMIRHistory extends BlockFrostRequest<
    List<ADAStakeAccountMIRHistoryResponse>, List<Map<String, dynamic>>> {
  BlockfrostRequestAccountMIRHistory(this.stakeAddress,
      {BlockFrostRequestFilterParams? filter})
      : super(filter: filter);

  /// stake address.
  final ADARewardAddress stakeAddress;

  /// Account MIR history
  @override
  String get method => BlockfrostMethods.accountMIRHistory.url;

  @override
  List<String> get pathParameters => [stakeAddress.address];

  @override
  List<ADAStakeAccountMIRHistoryResponse> onResonse(
      List<Map<String, dynamic>> result) {
    return result
        .map((e) => ADAStakeAccountMIRHistoryResponse.fromJson(e))
        .toList();
  }
}
