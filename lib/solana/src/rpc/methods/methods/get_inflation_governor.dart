import 'package:on_chain/solana/src/rpc/core/core.dart';
import 'package:on_chain/solana/src/rpc/core/methods.dart';
import 'package:on_chain/solana/src/rpc/models/rpc_models.dart';
import 'package:on_chain/solana/src/rpc/utils/solana_rpc_utils.dart';

/// Returns the current inflation governor
/// https://solana.com/docs/rpc/http/getinflationgovernor
class SolanaRPCGetInflationGovernor
    extends SolanaRPCRequest<InflationGovernor> {
  const SolanaRPCGetInflationGovernor({Commitment? commitment})
      : super(commitment: commitment);

  /// getInflationGovernor
  @override
  String get method => SolanaRPCMethods.getInflationGovernor.value;

  @override
  List<dynamic> toJson() {
    return [
      SolanaRPCUtils.createConfig([commitment?.toJson()]),
    ];
  }

  @override
  InflationGovernor onResonse(result) {
    return InflationGovernor.fromJson(result);
  }
}
