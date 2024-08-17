import 'package:on_chain/ada/src/provider/blockfrost/core/blockfrost.dart';
import 'package:on_chain/ada/src/provider/blockfrost/core/core.dart';
import 'package:on_chain/ada/src/provider/blockfrost/models/response_model.dart';

/// Return the information about blockchain genesis.
/// https://blockfrost.dev/api/blockchain-genesis
class BlockfrostRequestBlockchainGenesis extends BlockforestRequestParam<
    ADAGenesisParametersResponse, Map<String, dynamic>> {
  BlockfrostRequestBlockchainGenesis();

  /// Blockchain genesis
  @override
  String get method => BlockfrostMethods.blockchainGenesis.url;

  @override
  List<String> get pathParameters => [];

  @override
  ADAGenesisParametersResponse onResonse(Map<String, dynamic> result) {
    return ADAGenesisParametersResponse.fromJson(result);
  }
}
