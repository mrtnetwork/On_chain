import 'package:on_chain/solana/src/address/sol_address.dart';
import 'package:on_chain/solana/src/rpc/core/core.dart';
import 'package:on_chain/solana/src/rpc/core/methods.dart';
import 'package:on_chain/solana/src/rpc/models/rpc_models.dart';
import 'package:on_chain/solana/src/rpc/utils/solana_rpc_utils.dart';

/// Returns the account information for a list of Pubkeys.
/// https://solana.com/docs/rpc/http/getmultipleaccounts
class SolanaRequestGetMultipleAccounts
    extends SolanaRequest<Map<String, dynamic>, Map<String, dynamic>> {
  const SolanaRequestGetMultipleAccounts(
      {required this.pubkeys,
      this.dataSlice,
      super.commitment,
      super.minContextSlot,
      super.encoding});

  /// getMultipleAccounts
  @override
  String get method => SolanaRequestMethods.getMultipleAccounts.value;

  /// An array of Pubkeys to query, as base-58 encoded strings (up to a maximum of 100)
  final List<SolAddress> pubkeys;

  /// Request a slice of the account's data.
  final RPCDataSliceConfig? dataSlice;

  @override
  List<dynamic> toJson() {
    return [
      pubkeys.map((e) => e.address).toList(),
      SolanaRequestUtils.createConfig([
        commitment?.toJson(),
        minContextSlot?.toJson(),
        dataSlice?.toJson(),
        encoding?.toJson()
      ]),
    ];
  }
}
