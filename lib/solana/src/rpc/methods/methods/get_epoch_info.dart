import 'package:on_chain/solana/src/rpc/core/core.dart';
import 'package:on_chain/solana/src/rpc/core/methods.dart';
import 'package:on_chain/solana/src/rpc/models/rpc_models.dart';
import 'package:on_chain/solana/src/rpc/utils/solana_rpc_utils.dart';

/// Returns information about the current epoch
/// https://solana.com/docs/rpc/http/getepochinfo
class SolanaRPCGetEpochInfo extends SolanaRPCRequest<EpochInfo> {
  const SolanaRPCGetEpochInfo(
      {Commitment? commitment, MinContextSlot? minContextSlot})
      : super(commitment: commitment, minContextSlot: minContextSlot);

  /// getEpochInfo
  @override
  String get method => SolanaRPCMethods.getEpochInfo.value;

  @override
  List<dynamic> toJson() {
    return [
      SolanaRPCUtils.createConfig([
        commitment?.toJson(),
        minContextSlot?.toJson(),
      ]),
    ];
  }

  @override
  EpochInfo onResonse(result) {
    return EpochInfo.fromJson(result);
  }
}
