import 'package:blockchain_utils/blockchain_utils.dart';
import 'package:on_chain/solana/src/address/sol_address.dart';
import 'package:on_chain/solana/src/instructions/name_service/constant.dart';
import 'package:on_chain/solana/src/utils/utils.dart';

/// A utility class for working with the Name Service program.
class NameServiceProgramUtils {
  /// Returns the hashed name for the given name.
  static List<int> getHashedName(String name) {
    final combine = '${NameServiceProgramConst.hashPrefix}$name';
    final encode = StringUtils.encode(combine);
    return QuickCrypto.sha256Hash(encode);
  }

  /// find program address of name account.
  static SolAddress getNameAccountProgram({
    required List<int> hashedName,
    SolAddress? nameClass,
    SolAddress? nameParent,
  }) {
    final List<List<int>> seeds = [hashedName];
    seeds.add(nameClass?.toBytes() ?? List<int>.filled(32, 0));
    seeds.add(nameParent?.toBytes() ?? List<int>.filled(32, 0));
    return SolanaUtils.findProgramAddress(
      seeds: seeds,
      programId: NameServiceProgramConst.programId,
    ).item1;
  }

  static SolAddress getTwitterRegistryKey({required String twitterHandle}) {
    final hashedTwitterHandle =
        NameServiceProgramUtils.getHashedName(twitterHandle);
    return NameServiceProgramUtils.getNameAccountProgram(
      hashedName: hashedTwitterHandle,
      nameParent: NameServiceProgramConst.twitterRootPrentRegisteryKey,
    );
  }
}
