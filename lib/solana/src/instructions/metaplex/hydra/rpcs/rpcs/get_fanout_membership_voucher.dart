import 'package:on_chain/solana/src/address/sol_address.dart';
import 'package:on_chain/solana/src/instructions/metaplex/hydra/accounts/accounts.dart';
import 'package:on_chain/solana/src/rpc/rpc.dart';

/// Retrieves the account info from the provided address and deserializes
/// the [FanoutMembershipVoucher] from its data.
class SolanaRPCGetFanoutMembershipVoucherAccount
    extends SolanaRequest<FanoutMembershipVoucher?, Map<String, dynamic>?> {
  const SolanaRPCGetFanoutMembershipVoucherAccount({
    required this.account,
    super.commitment,
    super.minContextSlot,
  });

  @override
  String get method => SolanaRequestMethods.getAccountInfo.value;
  final SolAddress account;

  @override
  List<dynamic> toJson() {
    return [
      account.address,
      SolanaRequestUtils.createConfig([
        commitment?.toJson(),
        SolanaRequestEncoding.base64.toJson(),
        minContextSlot?.toJson()
      ])
    ];
  }

  @override
  FanoutMembershipVoucher? onResonse(result) {
    if (result == null) return null;
    final accountInfo = SolanaAccountInfo.fromJson(result);
    return FanoutMembershipVoucher.fromBuffer(accountInfo.toBytesData());
  }
}
