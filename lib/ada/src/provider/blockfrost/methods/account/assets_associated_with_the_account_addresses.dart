import 'package:on_chain/ada/src/address/era/shelly/ada_reward_address.dart';
import 'package:on_chain/ada/src/provider/blockfrost/core/blockfrost.dart';
import 'package:on_chain/ada/src/provider/blockfrost/core/core.dart';
import 'package:on_chain/ada/src/provider/blockfrost/models/response_model.dart';

/// Obtain information about assets associated with addresses of a specific account.
/// https://blockfrost.dev/api/assets-associated-with-the-account-addresses
class BlockfrostRequestAssetsAssociatedWithTheAccountAddresses
    extends BlockforestRequestParam<List<ADAAmountResponse>,
        List<Map<String, dynamic>>> {
  BlockfrostRequestAssetsAssociatedWithTheAccountAddresses(this.stakeAddress,
      {BlockforestRequestFilterParams? filter})
      : super(filter: filter);

  /// stake address.
  final ADARewardAddress stakeAddress;

  /// Assets associated with the account addresses
  @override
  String get method =>
      BlockfrostMethods.assetsAssociatedWithTheAccountAddresses.url;

  @override
  List<String> get pathParameters => [stakeAddress.address];

  @override
  List<ADAAmountResponse> onResonse(List<Map<String, dynamic>> result) {
    return result.map((e) => ADAAmountResponse.fromJson(e)).toList();
  }
}
