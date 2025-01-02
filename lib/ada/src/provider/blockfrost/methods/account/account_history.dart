import 'package:on_chain/ada/src/address/address.dart';
import 'package:on_chain/ada/src/provider/blockfrost/core/blockfrost.dart';
import 'package:on_chain/ada/src/provider/blockfrost/core/core.dart';
import 'package:on_chain/ada/src/provider/blockfrost/models/response_model.dart';

/// Obtain information about the history of a specific account.
/// https://blockfrost.dev/api/specific-account-address
class BlockfrostRequestAccountHistory extends BlockFrostRequest<
    List<ADAStakeAccountHistoryResponse>, List<Map<String, dynamic>>> {
  BlockfrostRequestAccountHistory(this.stakeAddress,
      {BlockFrostRequestFilterParams? filter})
      : super(filter: filter);

  /// stake address.
  final ADARewardAddress stakeAddress;

  /// Account history
  @override
  String get method => BlockfrostMethods.accountHistory.url;

  @override
  List<String> get pathParameters => [stakeAddress.address];

  @override
  List<ADAStakeAccountHistoryResponse> onResonse(
      List<Map<String, dynamic>> result) {
    return result
        .map((e) => ADAStakeAccountHistoryResponse.fromJson(e))
        .toList();
  }
}
