import 'package:on_chain/ada/src/address/era/core/address.dart';
import 'package:on_chain/ada/src/provider/blockfrost/core/blockfrost.dart';
import 'package:on_chain/ada/src/provider/blockfrost/core/core.dart';
import 'package:on_chain/ada/src/provider/blockfrost/models/response_model.dart';

/// List of mempool transactions where at least one of the transaction inputs or outputs belongs to the address. Shows only transactions submitted via Blockfrost.io.
/// https://blockfrost.dev/api/mempool-by-address
class BlockfrostRequestMempoolByAddress
    extends BlockforestRequestParam<List<String>, List<Map<String, dynamic>>> {
  BlockfrostRequestMempoolByAddress(this.addresss,
      {BlockforestRequestFilterParams? filter})
      : super(filter: filter);

  final ADAAddress addresss;

  /// Mempool by address
  @override
  String get method => BlockfrostMethods.mempoolByAddress.url;

  @override
  List<String> get pathParameters => [addresss.bech32Address];

  @override
  List<String> onResonse(List<Map<String, dynamic>> result) {
    return result.map<String>((e) => e["tx_hash"]).toList();
  }
}
