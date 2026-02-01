import 'package:on_chain/solana/src/address/sol_address.dart';

class StakeProgramConst {
  static const SolAddress programId =
      SolAddress.unchecked('Stake11111111111111111111111111111111111111');
  static const SolAddress stakeConfigId =
      SolAddress.unchecked('StakeConfig11111111111111111111111111111111');
  static BigInt get stakeProgramSpace => BigInt.from(200);
}
