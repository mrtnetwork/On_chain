import 'package:on_chain/ada/src/provider/blockfrost/core/blockfrost.dart';
import 'package:on_chain/ada/src/provider/blockfrost/core/core.dart';

import 'package:on_chain/ada/src/provider/blockfrost/models/response_model.dart';

/// List of scripts.
/// https://blockfrost.dev/api/scripts
class BlockfrostRequestScripts
    extends BlockFrostRequest<List<String>, List<Map<String, dynamic>>> {
  BlockfrostRequestScripts({BlockFrostRequestFilterParams? filter})
      : super(filter: filter);

  /// Scripts
  @override
  String get method => BlockfrostMethods.scripts.url;

  @override
  List<String> get pathParameters => [];

  @override
  List<String> onResonse(List<Map<String, dynamic>> result) {
    return result.map<String>((e) => e['script_hash']).toList();
  }
}
