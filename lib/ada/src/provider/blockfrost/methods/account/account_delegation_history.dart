import 'package:on_chain/ada/src/address/address.dart';
import 'package:on_chain/ada/src/provider/blockfrost/core/blockfrost.dart';
import 'package:on_chain/ada/src/provider/blockfrost/core/core.dart';
import 'package:on_chain/ada/src/provider/blockfrost/models/response_model.dart';

/// Obtain information about the delegation of a specific account.
/// https://blockfrost.dev/api/account-delegation-history
class BlockfrostRequestAccountDelegationHistory extends BlockforestRequestParam<
    List<ADAStakeAccountDelegationHistoryResponse>, List<Map<String, dynamic>>> {
  BlockfrostRequestAccountDelegationHistory(this.stakeAddress,
      {BlockforestRequestFilterParams? filter})
      : super(filter: filter);

  /// stake address.
  final ADARewardAddress stakeAddress;

  /// Account delegation history
  @override
  String get method => BlockfrostMethods.accountDelegationHistory.url;

  @override
  List<String> get pathParameters => [stakeAddress.address];

  @override
  List<ADAStakeAccountDelegationHistoryResponse> onResonse(
      List<Map<String, dynamic>> result) {
    return result
        .map((e) => ADAStakeAccountDelegationHistoryResponse.fromJson(e))
        .toList();
  }
}
