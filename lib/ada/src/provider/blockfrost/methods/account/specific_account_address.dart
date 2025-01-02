import 'package:on_chain/ada/src/address/address.dart';
import 'package:on_chain/ada/src/provider/blockfrost/core/blockfrost.dart';
import 'package:on_chain/ada/src/provider/blockfrost/core/core.dart';
import 'package:on_chain/ada/src/provider/blockfrost/models/response_model.dart';

/// Obtain information about a specific stake account.
/// https://blockfrost.dev/api/specific-account-address
class BlockfrostRequestSpecificAccountAddress
    extends BlockFrostRequest<ADAStakeAccountResponse, Map<String, dynamic>> {
  BlockfrostRequestSpecificAccountAddress(this.stakeAddress);

  /// stake address.
  final ADARewardAddress stakeAddress;

  /// Specific account address
  @override
  String get method => BlockfrostMethods.specificAccountAddress.url;

  @override
  List<String> get pathParameters => [stakeAddress.address];

  @override
  ADAStakeAccountResponse onResonse(Map<String, dynamic> result) {
    return ADAStakeAccountResponse.fromJson(result);
  }
}
