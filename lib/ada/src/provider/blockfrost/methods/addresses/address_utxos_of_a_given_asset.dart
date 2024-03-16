import 'package:on_chain/ada/src/address/era/core/address.dart';
import 'package:on_chain/ada/src/provider/blockfrost/core/blockfrost.dart';
import 'package:on_chain/ada/src/provider/blockfrost/core/core.dart';
import 'package:on_chain/ada/src/provider/blockfrost/models/response_model.dart';

/// UTXOs of the address.
/// https://blockfrost.dev/api/specific-account-address
class BlockfrostRequestAddressUTXOsOfAGivenAsset
    extends BlockforestRequestParam<List<ADAAccountUTXOResponse>,
        List<Map<String, dynamic>>> {
  BlockfrostRequestAddressUTXOsOfAGivenAsset(
      {required this.address,
      required this.asset,
      BlockforestRequestFilterParams? filter})
      : super(filter: filter);

  final ADAAddress address;

  /// Concatenation of the policy_id and hex-encoded asset_name
  final String asset;

  /// Address UTXOs of a given asset
  @override
  String get method => BlockfrostMethods.addressUTXOsOfaGivenAsset.url;

  @override
  List<String> get pathParameters => [address.bech32Address, asset];

  @override
  List<ADAAccountUTXOResponse> onResonse(List<Map<String, dynamic>> result) {
    return result.map((e) => ADAAccountUTXOResponse.fromJson(e)).toList();
  }
}
