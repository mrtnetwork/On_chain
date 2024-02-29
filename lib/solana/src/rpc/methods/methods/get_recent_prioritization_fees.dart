import 'package:on_chain/solana/src/address/sol_address.dart';
import 'package:on_chain/solana/src/rpc/core/core.dart';
import 'package:on_chain/solana/src/rpc/core/methods.dart';
import 'package:on_chain/solana/src/rpc/models/rpc_models.dart';

/// Returns a list of prioritization fees from recent blocks.
/// Currently, a node's prioritization-fee cache stores data from up to 150 blocks.
///
/// https://solana.com/docs/rpc/http/getrecentprioritizationfees
class SolanaRPCGetRecentPrioritizationFees
    extends SolanaRPCRequest<List<RecentPrioritizationFees>> {
  const SolanaRPCGetRecentPrioritizationFees({
    this.addresses,
  });

  /// getRecentPrioritizationFees
  @override
  String get method => SolanaRPCMethods.getRecentPrioritizationFees.value;

  /// An array of Account addresses (up to a maximum of 128 addresses), as base-58 encoded strings
  ///
  /// If this parameter is provided,
  /// the response will reflect a fee to land a transaction locking all of the provided accounts as writable.
  final List<SolAddress>? addresses;

  @override
  List<dynamic> toJson() {
    return [addresses?.map((e) => e.address).toList()];
  }

  @override
  List<RecentPrioritizationFees> onResonse(result) {
    return (result as List)
        .map((e) => RecentPrioritizationFees.fromJson(e))
        .toList();
  }
}
