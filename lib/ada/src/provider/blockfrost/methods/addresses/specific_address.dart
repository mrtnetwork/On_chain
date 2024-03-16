import 'package:on_chain/ada/src/address/address.dart';
import 'package:on_chain/ada/src/provider/blockfrost/core/blockfrost.dart';
import 'package:on_chain/ada/src/provider/blockfrost/core/core.dart';
import 'package:on_chain/ada/src/provider/blockfrost/models/response_model.dart';

/// Obtain information about a specific address.
/// https://blockfrost.dev/api/specific-address
class BlockfrostRequestSpecificAddress
    extends BlockforestRequestParam<ADAAddressSummaryResponse, Map<String, dynamic>> {
  BlockfrostRequestSpecificAddress(this.address);

  final ADAAddress address;

  /// Specific address
  @override
  String get method => BlockfrostMethods.specificAddress.url;

  @override
  List<String> get pathParameters => [address.bech32Address];

  @override
  ADAAddressSummaryResponse onResonse(Map<String, dynamic> result) {
    return ADAAddressSummaryResponse.fromJson(result);
  }
}
