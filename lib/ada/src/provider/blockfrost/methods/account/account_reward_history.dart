import 'package:on_chain/ada/src/address/address.dart';
import 'package:on_chain/ada/src/provider/blockfrost/core/blockfrost.dart';
import 'package:on_chain/ada/src/provider/blockfrost/core/core.dart';
import 'package:on_chain/ada/src/provider/blockfrost/models/response_model.dart';

/// Obtain information about the reward history of a specific account.
/// https://blockfrost.dev/api/account-reward-history
class BlockfrostRequestAccountRewardHistory extends BlockforestRequestParam<
    List<ADARewardHistoryResponse>, List<Map<String, dynamic>>> {
  BlockfrostRequestAccountRewardHistory(this.stakeAddress,
      {BlockforestRequestFilterParams? filter})
      : super(filter: filter);

  /// stake address.
  final ADARewardAddress stakeAddress;

  /// Account reward history
  @override
  String get method => BlockfrostMethods.accountRewardHistory.url;

  @override
  List<String> get pathParameters => [stakeAddress.address];

  @override
  List<ADARewardHistoryResponse> onResonse(List<Map<String, dynamic>> result) {
    return result.map((e) => ADARewardHistoryResponse.fromJson(e)).toList();
  }
}
