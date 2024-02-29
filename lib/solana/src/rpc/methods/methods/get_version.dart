import 'package:on_chain/solana/src/rpc/core/core.dart';
import 'package:on_chain/solana/src/rpc/core/methods.dart';

/// Returns the current Solana version running on the node.
/// https://solana.com/docs/rpc/http/getversion
class SolanaRPCGetVersion extends SolanaRPCRequest<Map<String, dynamic>> {
  /// getVersion
  @override
  String get method => SolanaRPCMethods.getVersion.value;

  @override
  List<dynamic> toJson() {
    return [];
  }
}
