import 'package:on_chain/ada/src/address/address.dart';
import 'package:on_chain/ada/src/provider/blockfrost/core/blockfrost.dart';
import 'package:on_chain/ada/src/provider/blockfrost/core/core.dart';
import 'package:on_chain/ada/src/provider/blockfrost/models/response_model.dart';

/// Obtain information about the withdrawals of a specific account.
/// https://blockfrost.dev/api/account-withdrawal-history
class BlockfrostRequestAccountWithdrawalHistory extends BlockforestRequestParam<
    List<ADAStakeAccountWithdrawalHistoryResponse>, List<Map<String, dynamic>>> {
  BlockfrostRequestAccountWithdrawalHistory(this.stakeAddress,
      {BlockforestRequestFilterParams? filter})
      : super(filter: filter);

  /// stake address.
  final ADARewardAddress stakeAddress;

  /// Account withdrawal history
  @override
  String get method => BlockfrostMethods.accountWithdrawalHistory.url;

  @override
  List<String> get pathParameters => [stakeAddress.address];

  @override
  List<ADAStakeAccountWithdrawalHistoryResponse> onResonse(
      List<Map<String, dynamic>> result) {
    return result
        .map((e) => ADAStakeAccountWithdrawalHistoryResponse.fromJson(e))
        .toList();
  }
}
