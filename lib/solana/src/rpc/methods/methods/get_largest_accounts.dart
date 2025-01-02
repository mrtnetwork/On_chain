import 'package:on_chain/solana/src/rpc/core/core.dart';
import 'package:on_chain/solana/src/rpc/core/methods.dart';
import 'package:on_chain/solana/src/rpc/models/rpc_models.dart';
import 'package:on_chain/solana/src/rpc/utils/solana_rpc_utils.dart';

/// Returns the 20 largest accounts, by lamport balance (results may be cached up to two hours)
/// https://solana.com/docs/rpc/http/getlargestaccounts
class SolanaRequestGetLargestAccounts
    extends SolanaRequest<List<AccountBalancePairResponse>, List> {
  const SolanaRequestGetLargestAccounts({this.filter, super.commitment});

  /// getLargestAccounts
  @override
  String get method => SolanaRequestMethods.getLargestAccounts.value;

  /// filter results by account type
  /// Values: circulating, nonCirculating
  final String? filter;

  @override
  List<dynamic> toJson() {
    return [
      SolanaRequestUtils.createConfig([
        commitment?.toJson(),
        {'filter': filter}
      ]),
    ];
  }

  @override
  List<AccountBalancePairResponse> onResonse(List result) {
    return result.map((e) => AccountBalancePairResponse.fromJson(e)).toList();
  }
}
