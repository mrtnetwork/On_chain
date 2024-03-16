import 'package:on_chain/ada/src/address/address.dart';
import 'package:on_chain/ada/src/provider/blockfrost/core/blockfrost.dart';
import 'package:on_chain/ada/src/provider/blockfrost/core/core.dart';
import 'package:on_chain/ada/src/provider/blockfrost/models/response_model.dart';

/// Obtain information about the registrations and deregistrations of a specific account.
/// https://blockfrost.dev/api/account-registration-history
class BlockfrostRequestAccountRegistrationHistory
    extends BlockforestRequestParam<
        List<ADAStakeAccountRegistrationHistoryResponse>,
        List<Map<String, dynamic>>> {
  BlockfrostRequestAccountRegistrationHistory(this.stakeAddress,
      {BlockforestRequestFilterParams? filter})
      : super(filter: filter);

  final ADARewardAddress stakeAddress;

  /// Account registration history
  @override
  String get method => BlockfrostMethods.accountRegistrationHistory.url;

  @override
  List<String> get pathParameters => [stakeAddress.address];

  @override
  List<ADAStakeAccountRegistrationHistoryResponse> onResonse(
      List<Map<String, dynamic>> result) {
    return result
        .map((e) => ADAStakeAccountRegistrationHistoryResponse.fromJson(e))
        .toList();
  }
}
