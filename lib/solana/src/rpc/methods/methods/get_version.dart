import 'package:on_chain/solana/src/rpc/core/core.dart';
import 'package:on_chain/solana/src/rpc/core/methods.dart';

/// Returns the current Solana version running on the node.
/// https://solana.com/docs/rpc/http/getversion
class SolanaRequestGetVersion
    extends SolanaRequest<Map<String, dynamic>, Map<String, dynamic>> {
  /// getVersion
  @override
  String get method => SolanaRequestMethods.getVersion.value;

  @override
  List<dynamic> toJson() {
    return [];
  }
}
