import 'package:on_chain/solana/src/rpc/core/core.dart';
import 'package:on_chain/solana/src/rpc/core/methods.dart';
import 'package:on_chain/solana/src/rpc/models/rpc_models.dart';
import 'package:on_chain/solana/src/rpc/utils/solana_rpc_utils.dart';

/// Returns the current inflation governor
/// https://solana.com/docs/rpc/http/getinflationgovernor
class SolanaRequestGetInflationGovernor
    extends SolanaRequest<InflationGovernor, Map<String, dynamic>> {
  const SolanaRequestGetInflationGovernor({super.commitment});

  /// getInflationGovernor
  @override
  String get method => SolanaRequestMethods.getInflationGovernor.value;

  @override
  List<dynamic> toJson() {
    return [
      SolanaRequestUtils.createConfig([commitment?.toJson()]),
    ];
  }

  @override
  InflationGovernor onResonse(Map<String, dynamic> result) {
    return InflationGovernor.fromJson(result);
  }
}
