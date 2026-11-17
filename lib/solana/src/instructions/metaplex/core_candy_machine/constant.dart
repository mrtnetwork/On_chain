import 'package:on_chain/solana/src/address/sol_address.dart';

class CoreCandyMachineProgramConst {
  /// Core Candy Machine program.
  static const SolAddress candyMachineProgramId = SolAddress.unchecked(
    'CMACYFENjoBMHzapRXyo1JZkVS6EtaDDzkjMrmQLvr4J',
  );

  /// Core Candy Guard program.
  static const SolAddress candyGuardProgramId = SolAddress.unchecked(
    'CMAGAKJ67e9hRZgfC5SFTbZH8MgEmtqazKXjmkaJjWTJ',
  );
}
