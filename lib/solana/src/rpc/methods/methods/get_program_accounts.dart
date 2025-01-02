import 'package:on_chain/solana/src/address/sol_address.dart';
import 'package:on_chain/solana/src/rpc/core/core.dart';
import 'package:on_chain/solana/src/rpc/core/methods.dart';
import 'package:on_chain/solana/src/rpc/models/rpc_models.dart';
import 'package:on_chain/solana/src/rpc/utils/solana_rpc_utils.dart';

/// Returns all accounts owned by the provided program Pubkey
/// https://solana.com/docs/rpc/http/getprogramaccounts
class SolanaRequestGetProgramAccounts
    extends SolanaRequest<List<SolanaAccountInfo>, List> {
  const SolanaRequestGetProgramAccounts(
      {required this.account,
      this.withContext,
      this.dataSlice,
      this.filters,
      super.commitment,
      super.minContextSlot,
      super.encoding = SolanaRequestEncoding.base64});

  /// getProgramAccounts
  @override
  String get method => SolanaRequestMethods.getProgramAccounts.value;

  /// Pubkey of program, as base-58 encoded string
  final SolAddress account;

  /// wrap the result in an RpcResponse JSON object
  final bool? withContext;

  /// Request a slice of the account's data.
  final RPCDataSliceConfig? dataSlice;

  /// filter results using up to 4 filter objects
  /// The resultant account(s) must meet ALL filter criteria to be included in the returned results
  final List<RPCFilterConfig>? filters;

  @override
  List<dynamic> toJson() {
    return [
      account.address,
      SolanaRequestUtils.createConfig([
        commitment?.toJson(),
        minContextSlot?.toJson(),
        {'withContext': withContext},
        encoding?.toJson(),
        dataSlice?.toJson(),
        {'filters': filters?.map((e) => e.toJson()).toList()}
      ])
    ];
  }

  @override
  List<SolanaAccountInfo> onResonse(List result) {
    return result.map((e) => SolanaAccountInfo.fromJson(e['account'])).toList();
  }
}
