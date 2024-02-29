import 'package:on_chain/solana/src/address/sol_address.dart';

class WithdrawAccount {
  const WithdrawAccount(
      {required this.stakeAddress,
      required this.voteAddress,
      required this.poolAmount});
  final SolAddress stakeAddress;
  final SolAddress? voteAddress;
  final BigInt poolAmount;
}
