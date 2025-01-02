import 'package:on_chain/ada/src/provider/blockfrost/core/blockfrost.dart';
import 'package:on_chain/ada/src/provider/blockfrost/core/core.dart';

/// List metadata about specific address.
/// https://blockfrost.dev/api/specific-nut-link-address
class BlockfrostRequestSpecificNutLinkAddress
    extends BlockFrostRequest<Map<String, dynamic>, Map<String, dynamic>> {
  BlockfrostRequestSpecificNutLinkAddress(this.address);
  final String address;

  /// Specific nut.link address
  @override
  String get method => BlockfrostMethods.specificNutlinkAddress.url;

  @override
  List<String> get pathParameters => [address];
}
