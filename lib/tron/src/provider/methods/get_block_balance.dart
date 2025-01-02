import 'package:on_chain/tron/src/provider/core/request.dart';
import 'package:on_chain/tron/src/provider/methods/request_methods.dart';

/// Get all balance change operations in a block.
/// [developers.tron.network](https://developers.tron.network/reference/getblockbalance).
class TronRequestGetBlockBalance
    extends TronRequest<Map<String, dynamic>, Map<String, dynamic>> {
  TronRequestGetBlockBalance(
      {required this.hash, required this.number, required this.visible});
  final String hash;
  final int number;
  @override
  final bool visible;

  /// wallet/getblockbalance
  @override
  TronHTTPMethods get method => TronHTTPMethods.getblockbalance;

  @override
  Map<String, dynamic> toJson() {
    return {'hash': hash, 'number': number, 'visible': visible};
  }

  @override
  String toString() {
    return 'TronRequestGetBlockBalance{${toJson()}}';
  }
}
