import 'package:on_chain/solana/src/rpc/core/core.dart';
import 'package:on_chain/solana/src/rpc/core/methods.dart';
import 'package:on_chain/solana/src/rpc/models/rpc_models.dart';

/// Returns the current Solana version running on the node.
/// https://solana.com/docs/rpc/http/getversion
class SolanaRequestGetVersion
    extends SolanaRequest<SolanaVersionResponse, Map<String, dynamic>> {
  /// getVersion
  @override
  String get method => SolanaRequestMethods.getVersion.value;

  @override
  List<dynamic> toJson() {
    return [];
  }

  @override
  SolanaVersionResponse onResponse(Map<String, dynamic> result) {
    return SolanaVersionResponse.fromJson(result);
  }
}
