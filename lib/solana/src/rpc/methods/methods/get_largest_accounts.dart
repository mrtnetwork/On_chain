import 'package:on_chain/solana/src/rpc/core/core.dart';
import 'package:on_chain/solana/src/rpc/core/methods.dart';
import 'package:on_chain/solana/src/rpc/models/rpc_models.dart';
import 'package:on_chain/solana/src/rpc/utils/solana_rpc_utils.dart';

/// Returns the 20 largest accounts, by lamport balance (results may be cached up to two hours)
/// https://solana.com/docs/rpc/http/getlargestaccounts
class SolanaRPCGetLargestAccounts
    extends SolanaRPCRequest<List<AccountBalancePairResponse>> {
  const SolanaRPCGetLargestAccounts({this.filter, Commitment? commitment})
      : super(commitment: commitment);

  /// getLargestAccounts
  @override
  String get method => SolanaRPCMethods.getLargestAccounts.value;

  /// filter results by account type
  /// Values: circulating, nonCirculating
  final String? filter;

  @override
  List<dynamic> toJson() {
    return [
      SolanaRPCUtils.createConfig([
        commitment?.toJson(),
        {"filter": filter}
      ]),
    ];
  }

  @override
  List<AccountBalancePairResponse> onResonse(result) {
    return (result as List)
        .map((e) => AccountBalancePairResponse.fromJson(e))
        .toList();
  }
}
