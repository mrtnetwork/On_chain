import 'package:on_chain/ada/src/address/era/shelly/ada_reward_address.dart';
import 'package:on_chain/ada/src/provider/blockfrost/core/blockfrost.dart';
import 'package:on_chain/ada/src/provider/blockfrost/core/core.dart';
import 'package:on_chain/ada/src/provider/blockfrost/models/response_model.dart';

/// Obtain information about the addresses of a specific account.
/// https://blockfrost.dev/api/specific-account-address
class BlockfrostRequestAccountAssociatedAddresses
    extends BlockFrostRequest<List<String>, List<Map<String, dynamic>>> {
  BlockfrostRequestAccountAssociatedAddresses(this.stakeAddress,
      {BlockFrostRequestFilterParams? filter})
      : super(filter: filter);

  /// stake address.
  final ADARewardAddress stakeAddress;

  /// Account associated addresses
  @override
  String get method => BlockfrostMethods.accountAssociatedAddresses.url;

  @override
  List<String> get pathParameters => [stakeAddress.address];

  @override
  List<String> onResonse(List<Map<String, dynamic>> result) {
    return result.map<String>((e) => e['address']).toList();
  }
}
