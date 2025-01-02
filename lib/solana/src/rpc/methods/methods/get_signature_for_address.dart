import 'package:on_chain/solana/src/address/sol_address.dart';
import 'package:on_chain/solana/src/rpc/core/core.dart';
import 'package:on_chain/solana/src/rpc/core/methods.dart';
import 'package:on_chain/solana/src/rpc/utils/solana_rpc_utils.dart';

/// Returns signatures for confirmed transactions that include the given address in their accountKeys list.
/// Returns signatures backwards in time from the provided signature or most recent confirmed block
/// https://solana.com/docs/rpc/http/getsignaturesforaddress
class SolanaRequestGetSignaturesForAddress
    extends SolanaRequest<List<Map<String, dynamic>>, List> {
  const SolanaRequestGetSignaturesForAddress(
      {required this.account,
      this.limit = 1000,
      this.before,
      this.until,
      super.commitment,
      super.minContextSlot});

  /// getSignaturesForAddress
  @override
  String get method => SolanaRequestMethods.getSignaturesForAddress.value;

  /// Account address as base-58 encoded string
  final SolAddress account;

  /// maximum transaction signatures to return (between 1 and 1,000).
  final int limit;

  /// start searching backwards from this transaction signature.
  /// If not provided the search starts from the top of the highest max confirmed block.
  final String? before;

  /// search until this transaction signature, if found before limit reached
  final String? until;

  @override
  List<dynamic> toJson() {
    return [
      account.address,
      SolanaRequestUtils.createConfig([
        commitment?.toJson(),
        minContextSlot?.toJson(),
        {'limit': limit},
        {'before': before},
        {'until': until}
      ])
    ];
  }

  @override
  List<Map<String, dynamic>> onResonse(List result) {
    return result.map((e) => Map<String, dynamic>.from(e)).toList();
  }
}
