import 'package:on_chain/ada/src/address/address.dart';
import 'package:on_chain/ada/src/provider/blockfrost/core/blockfrost.dart';
import 'package:on_chain/ada/src/provider/blockfrost/core/core.dart';
import 'package:on_chain/ada/src/provider/blockfrost/models/response_model.dart';

/// Obtain details about an address.
/// https://blockfrost.dev/api/address-details
class BlockfrostRequestAddressDetails extends BlockforestRequestParam<
    ADAAccountSummaryResponse, Map<String, dynamic>> {
  BlockfrostRequestAddressDetails(this.address);

  final ADAAddress address;

  /// Address details
  @override
  String get method => BlockfrostMethods.addressDetails.url;

  @override
  List<String> get pathParameters => [address.bech32Address];

  @override
  ADAAccountSummaryResponse onResonse(Map<String, dynamic> result) {
    return ADAAccountSummaryResponse.fromJson(result);
  }
}
