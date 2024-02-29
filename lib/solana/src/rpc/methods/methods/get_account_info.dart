import 'package:on_chain/solana/src/address/sol_address.dart';
import 'package:on_chain/solana/src/rpc/core/core.dart';
import 'package:on_chain/solana/src/rpc/core/methods.dart';
import 'package:on_chain/solana/src/rpc/models/rpc_models.dart';
import 'package:on_chain/solana/src/rpc/utils/solana_rpc_utils.dart';

/// Returns all information associated with the account of provided Pubkey
/// https://solana.com/docs/rpc/http/getaccountinfo
class SolanaRPCGetAccountInfo extends SolanaRPCRequest<SolanaAccountInfo?> {
  const SolanaRPCGetAccountInfo(
      {required this.account,
      this.dataSlice,
      Commitment? commitment,
      MinContextSlot? minContextSlot,
      SolanaRPCEncoding? encoding = SolanaRPCEncoding.base64})
      : super(
            commitment: commitment,
            encoding: encoding,
            minContextSlot: minContextSlot);

  /// getAccountInfo
  @override
  String get method => SolanaRPCMethods.getAccountInfo.value;

  /// Pubkey of account to query, as base-58 encoded string
  final SolAddress account;

  /// Request a slice of the account's data.
  final RPCDataSliceConfig? dataSlice;

  @override
  List<dynamic> toJson() {
    return [
      account.address,
      SolanaRPCUtils.createConfig([
        commitment?.toJson(),
        encoding?.toJson(),
        dataSlice?.toJson(),
        minContextSlot?.toJson()
      ])
    ];
  }

  @override
  SolanaAccountInfo? onResonse(result) {
    if (result == null) return null;
    return SolanaAccountInfo.fromJson(result);
  }
}
