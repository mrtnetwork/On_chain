import 'package:on_chain/solana/src/address/sol_address.dart';
import 'package:on_chain/solana/src/rpc/core/core.dart';
import 'package:on_chain/solana/src/rpc/core/methods.dart';
import 'package:on_chain/solana/src/rpc/models/rpc_models.dart';
import 'package:on_chain/solana/src/rpc/utils/solana_rpc_utils.dart';

/// Returns all SPL Token accounts by token owner.
/// https://solana.com/docs/rpc/http/gettokenaccountsbyowner
class SolanaRPCGetTokenAccountsByOwner
    extends SolanaRPCRequest<List<TokenAccountResponse>> {
  const SolanaRPCGetTokenAccountsByOwner(
      {required this.account,
      this.mint,
      this.programId,
      this.dataSlice,
      Commitment? commitment,
      MinContextSlot? minContextSlot,
      SolanaRPCEncoding? encoding})
      : super(
            commitment: commitment,
            minContextSlot: minContextSlot,
            encoding: encoding);

  /// getTokenAccountsByOwner
  @override
  String get method => SolanaRPCMethods.getTokenAccountsByOwner.value;

  /// Pubkey of account delegate to query, as base-58 encoded string
  final SolAddress account;

  /// Pubkey of the specific token Mint to limit accounts to, as base-58 encoded string
  final SolAddress? mint;

  ///  Pubkey of the Token program that owns the accounts, as base-58 encoded string
  final SolAddress? programId;

  /// Request a slice of the account's data.
  final RPCDataSliceConfig? dataSlice;

  @override
  List<dynamic> toJson() {
    return [
      account.address,
      SolanaRPCUtils.createConfig([
        {"mint": mint?.address},
        {"programId": programId?.address}
      ]),
      SolanaRPCUtils.createConfig([
        commitment?.toJson(),
        minContextSlot?.toJson(),
        dataSlice?.toJson(),
        encoding?.toJson()
      ])
    ];
  }

  @override
  List<TokenAccountResponse> onResonse(result) {
    return (result as List)
        .map((e) => TokenAccountResponse.fromJson(e))
        .toList();
  }
}
