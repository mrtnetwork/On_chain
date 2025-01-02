import 'package:on_chain/solana/src/rpc/core/core.dart';
import 'package:on_chain/solana/src/rpc/core/methods.dart';
import 'package:on_chain/solana/src/rpc/models/rpc_models.dart';

/// Returns the specific inflation values for the current epoch
/// https://solana.com/docs/rpc/http/getinflationrate
class SolanaRequestGetInflationRate
    extends SolanaRequest<InflationRate, Map<String, dynamic>> {
  /// getInflationRate
  @override
  String get method => SolanaRequestMethods.getInflationRate.value;

  @override
  List<dynamic> toJson() {
    return [];
  }

  @override
  InflationRate onResonse(Map<String, dynamic> result) {
    return InflationRate.fromJson(result);
  }
}
