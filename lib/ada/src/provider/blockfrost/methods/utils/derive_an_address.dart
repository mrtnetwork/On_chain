import 'package:on_chain/ada/src/provider/blockfrost/core/blockfrost.dart';
import 'package:on_chain/ada/src/provider/blockfrost/core/core.dart';
import 'package:on_chain/ada/src/provider/blockfrost/models/response_model.dart';

/// Derive Shelley address from an xpub
/// https://blockfrost.dev/api/derive-an-address
class BlockfrostRequestDeriveAnAddress
    extends BlockforestRequestParam<ADADeriveAddressResponse, Map<String, dynamic>> {
  BlockfrostRequestDeriveAnAddress(
      {required this.xpub, required this.role, required this.index});

  /// Hex xpub
  final String xpub;

  /// Account role
  final int role;

  /// Address index
  final int index;

  /// Derive an address
  @override
  String get method => BlockfrostMethods.deriveAnAddress.url;

  @override
  List<String> get pathParameters => [xpub, role.toString(), index.toString()];

  @override
  ADADeriveAddressResponse onResonse(Map<String, dynamic> result) {
    return ADADeriveAddressResponse.fromJson(result);
  }
}
