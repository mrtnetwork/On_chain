import 'package:blockchain_utils/numbers/bigint_utils.dart';
import 'package:on_chain/solana/src/address/sol_address.dart';

class AccountBalancePairResponse {
  const AccountBalancePairResponse(
      {required this.address, required this.lamports});
  factory AccountBalancePairResponse.fromJson(Map<String, dynamic> json) {
    return AccountBalancePairResponse(
        address: SolAddress.uncheckCurve(json["address"]),
        lamports: BigintUtils.parse(json["lamports"]));
  }
  final SolAddress address;
  final BigInt lamports;
}
