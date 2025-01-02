import 'package:on_chain/solana/src/rpc/core/core.dart';
import 'package:on_chain/solana/src/rpc/core/methods.dart';
import 'package:on_chain/solana/src/rpc/models/rpc_models.dart';

/// Returns the epoch schedule information from this cluster's genesis config
/// https://solana.com/docs/rpc/http/getepochschedule
class SolanaRequestGetEpochSchedule
    extends SolanaRequest<EpochSchedule, Map<String, dynamic>> {
  @override
  String get method => SolanaRequestMethods.getEpochSchedule.value;

  @override
  List<dynamic> toJson() {
    return [];
  }

  @override
  EpochSchedule onResonse(Map<String, dynamic> result) {
    return EpochSchedule.fromJson(result);
  }
}
