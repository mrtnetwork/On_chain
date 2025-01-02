import 'package:on_chain/solana/src/address/sol_address.dart';

class MetaplexCandyMachineCoreProgramConst {
  static const int mintCounterSize = 2;
  static const int allowListProofSize = 8;
  static const int allocationTrackerSize = 4;
  static const SolAddress candyMachineV3programId =
      SolAddress.unchecked('CndyV3LdqHUfDLmE5naZjVN8rBZz4tqhdefbAnjHG3JR');
  static const SolAddress candyGuardProgramId =
      SolAddress.unchecked('Guard1JwRhJkVH6XZhzoYxeBVQe872VH6QggF4BWmS9g');
}
