import 'package:on_chain/solana/src/rpc/core/core.dart';
import 'package:on_chain/solana/src/rpc/core/methods.dart';

/// Returns the genesis hash
/// https://solana.com/docs/rpc/http/getgenesishash
class SolanaRequestGetGenesisHash extends SolanaRequest<String, String> {
  /// getGenesisHash
  @override
  String get method => SolanaRequestMethods.getGenesisHash.value;

  @override
  List<dynamic> toJson() {
    return [];
  }
}
