import 'package:on_chain/ada/src/address/address.dart';
import 'package:on_chain/ada/src/provider/blockfrost/core/blockfrost.dart';
import 'package:on_chain/ada/src/provider/blockfrost/core/core.dart';
import 'package:on_chain/ada/src/provider/blockfrost/models/response_model.dart';

/// Obtain extended information about a specific address.
/// https://blockfrost.dev/api/extended-information-of-a-specific-address
class BlockfrostRequestExtendedInformationOfaSpecificAddress
    extends BlockforestRequestParam<ADAAddressSummaryResponse, Map<String, dynamic>> {
  BlockfrostRequestExtendedInformationOfaSpecificAddress(this.address);

  final ADAAddress address;

  /// Extended information of a specific address
  @override
  String get method =>
      BlockfrostMethods.extendedInformationOfaSpecificAddress.url;

  @override
  List<String> get pathParameters => [address.bech32Address];

  @override
  ADAAddressSummaryResponse onResonse(Map<String, dynamic> result) {
    return ADAAddressSummaryResponse.fromJson(result);
  }
}
