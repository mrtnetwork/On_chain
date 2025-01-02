import 'package:on_chain/solana/src/rpc/core/core.dart';
import 'package:on_chain/solana/src/rpc/core/methods.dart';
import 'package:on_chain/solana/src/rpc/models/rpc_models.dart';
import 'package:on_chain/solana/src/rpc/utils/solana_rpc_utils.dart';

/// Returns information about the current epoch
/// https://solana.com/docs/rpc/http/getepochinfo
class SolanaRequestGetEpochInfo
    extends SolanaRequest<EpochInfo, Map<String, dynamic>> {
  const SolanaRequestGetEpochInfo({super.commitment, super.minContextSlot});

  /// getEpochInfo
  @override
  String get method => SolanaRequestMethods.getEpochInfo.value;

  @override
  List<dynamic> toJson() {
    return [
      SolanaRequestUtils.createConfig([
        commitment?.toJson(),
        minContextSlot?.toJson(),
      ]),
    ];
  }

  @override
  EpochInfo onResonse(Map<String, dynamic> result) {
    return EpochInfo.fromJson(result);
  }
}
