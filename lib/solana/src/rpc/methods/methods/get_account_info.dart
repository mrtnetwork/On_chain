import 'package:on_chain/solana/src/address/sol_address.dart';
import 'package:on_chain/solana/src/rpc/core/core.dart';
import 'package:on_chain/solana/src/rpc/core/methods.dart';
import 'package:on_chain/solana/src/rpc/models/rpc_models.dart';
import 'package:on_chain/solana/src/rpc/utils/solana_rpc_utils.dart';

/// Returns all information associated with the account of provided Pubkey
/// https://solana.com/docs/rpc/http/getaccountinfo
class SolanaRequestGetAccountInfo
    extends SolanaRequest<SolanaAccountInfo?, Map<String, dynamic>?> {
  const SolanaRequestGetAccountInfo(
      {required this.account,
      this.dataSlice,
      super.commitment,
      super.minContextSlot,
      super.encoding = SolanaRequestEncoding.base64});

  /// getAccountInfo
  @override
  String get method => SolanaRequestMethods.getAccountInfo.value;

  /// Pubkey of account to query, as base-58 encoded string
  final SolAddress account;

  /// Request a slice of the account's data.
  final RPCDataSliceConfig? dataSlice;

  @override
  List<dynamic> toJson() {
    return [
      account.address,
      SolanaRequestUtils.createConfig([
        commitment?.toJson(),
        encoding?.toJson(),
        dataSlice?.toJson(),
        minContextSlot?.toJson()
      ])
    ];
  }

  @override
  SolanaAccountInfo? onResonse(Map<String, dynamic>? result) {
    if (result == null) return null;
    return SolanaAccountInfo.fromJson(result);
  }
}
