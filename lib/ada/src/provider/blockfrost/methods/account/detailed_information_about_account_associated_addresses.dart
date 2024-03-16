import 'package:on_chain/ada/src/address/address.dart';
import 'package:on_chain/ada/src/provider/blockfrost/core/blockfrost.dart';
import 'package:on_chain/ada/src/provider/blockfrost/core/core.dart';
import 'package:on_chain/ada/src/provider/blockfrost/models/response_model.dart';

/// Obtain summed details about all addresses associated with a given account.
/// https://blockfrost.dev/api/assets-associated-with-the-account-addresses
class BlockfrostRequestDetailedInformationAboutAccountAssociatedAddresses
    extends BlockforestRequestParam<ADAAccountSummaryResponse, Map<String, dynamic>> {
  BlockfrostRequestDetailedInformationAboutAccountAssociatedAddresses(
    this.stakeAddress,
  );

  final ADARewardAddress stakeAddress;

  /// Detailed information about account associated addresses
  @override
  String get method =>
      BlockfrostMethods.detailedInformationAboutAccountAssociatedAddresses.url;

  @override
  List<String> get pathParameters => [stakeAddress.address];

  @override
  ADAAccountSummaryResponse onResonse(Map<String, dynamic> result) {
    return ADAAccountSummaryResponse.fromJson(result);
  }
}
