import 'package:on_chain/solana/src/address/sol_address.dart';

class VoteProgramConst {
  static const SolAddress programId =
      SolAddress.unchecked('Vote111111111111111111111111111111111111111');
  static final BigInt space = BigInt.from(3731);
}
