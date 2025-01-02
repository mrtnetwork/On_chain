import 'package:on_chain/solana/src/address/sol_address.dart';

class SPLTokenProgramConst {
  /// spl-token ProgramId
  static const tokenProgramId =
      SolAddress.unchecked('TokenkegQfeZyiNwAJbNbGKPFXCWuBvf9Ss623VQ5DA');

  /// spl-token-2022 Progarm id
  static const token2022ProgramId =
      SolAddress.unchecked('TokenzQdBNbLqP5VEhdkAS6EPFLC1PHnBqCXEpPxuEb');

  /// Address of the special mint for wrapped native SOL in spl-token
  static const nativeMint =
      SolAddress.unchecked('So11111111111111111111111111111111111111112');

  /// Address of the special mint for wrapped native SOL in spl-token-2022
  static const nativeMint2022 =
      SolAddress.unchecked('9pan9bMn5HatX4EJdBwg9VgCa7Uz5HL8N1m5D3NdXejP');

  static const metaDataProgramId =
      SolAddress.unchecked('metaqbxxUerdq28cj1RbAWkYQm3ybzjb6a8bt518x1s');
}
