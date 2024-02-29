import 'package:on_chain/solana/src/rpc/core/core.dart';
import 'package:on_chain/solana/src/rpc/core/methods.dart';

/// Returns the genesis hash
/// https://solana.com/docs/rpc/http/getgenesishash
class SolanaRPCGetGenesisHash extends SolanaRPCRequest<String> {
  /// getGenesisHash
  @override
  String get method => SolanaRPCMethods.getGenesisHash.value;

  @override
  List<dynamic> toJson() {
    return [];
  }
}
