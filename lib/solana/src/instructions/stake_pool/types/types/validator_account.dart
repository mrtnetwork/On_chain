import 'package:on_chain/solana/src/address/sol_address.dart';

import 'validator_account_type.dart';

class ValidatorAccount {
  const ValidatorAccount(
      {required this.type,
      required this.stakeAddress,
      this.voteAddress,
      required this.lamports});
  final ValidatorAccountType type;
  final SolAddress? voteAddress;
  final SolAddress stakeAddress;
  final BigInt lamports;
}
