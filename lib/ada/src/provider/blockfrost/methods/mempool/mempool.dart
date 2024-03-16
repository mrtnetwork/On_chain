import 'package:on_chain/ada/src/provider/blockfrost/core/blockfrost.dart';
import 'package:on_chain/ada/src/provider/blockfrost/core/core.dart';
import 'package:on_chain/ada/src/provider/blockfrost/models/response_model.dart';

/// Return transactions that are currently stored in Blockfrost mempool,
/// waiting to be included in a newly minted block.
/// Shows only transactions submitted via Blockfrost.io.
/// https://blockfrost.dev/api/mempool
class BlockfrostRequestMempool
    extends BlockforestRequestParam<List<String>, List<Map<String, dynamic>>> {
  BlockfrostRequestMempool({BlockforestRequestFilterParams? filter})
      : super(filter: filter);

  /// Mempool
  @override
  String get method => BlockfrostMethods.mempool.url;

  @override
  List<String> get pathParameters => [];

  @override
  List<String> onResonse(List<Map<String, dynamic>> result) {
    return result.map<String>((e) => e["tx_hash"]).toList();
  }
}
