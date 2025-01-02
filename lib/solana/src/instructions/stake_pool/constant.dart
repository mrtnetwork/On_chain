import 'package:on_chain/solana/src/address/sol_address.dart';

class StakePoolProgramConst {
  /// Public key that identifies the SPL Stake Pool program.
  static const programId =
      SolAddress.unchecked('SPoo1Ku8WFXoNDMHPsrGSTSG1Y47rzgn41SLUNakuHy');

  static const int metadataMaxNameLength = 32;
  static const int metadataMaxSymbolLength = 10;
  static const int metadataMaxUriLength = 200;

  static final BigInt minimumActiveStake = BigInt.from(1000000000);
}
