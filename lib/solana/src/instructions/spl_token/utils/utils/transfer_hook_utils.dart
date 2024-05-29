import 'package:blockchain_utils/blockchain_utils.dart';
import 'package:on_chain/solana/src/address/sol_address.dart';
import 'package:on_chain/solana/src/instructions/spl_token/types/types.dart';
import 'package:on_chain/solana/src/models/models.dart';
import 'package:on_chain/solana/src/models/pda/pda.dart';
import 'package:on_chain/solana/src/rpc/rpc.dart';

class TransferHookUtils {
  static Tuple<List<int>, int> unpackSeedLiteral(List<int> seeds) {
    if (seeds.isEmpty) {
      throw const MessageException("Transfer hook invalid seeds");
    }
    int length = seeds[0];
    if (seeds.length < length + 1) {
      throw const MessageException("Transfer hook invalid seeds");
    }
    return Tuple(seeds.sublist(1, length + 1), 2 + length);
  }

  static Tuple<List<int>, int> unpackSeedInstructionArg(
      {required List<int> seeds, required List<int> instructionData}) {
    if (seeds.length < 2) {
      throw const MessageException("Transfer hook invalid seeds");
    }
    int index = seeds[0];
    int length = seeds[1];
    if (instructionData.length < length + index) {
      throw const MessageException("Transfer hook invalid seeds");
    }
    return Tuple(instructionData.sublist(index, index + length), 3);
  }

  static Tuple<List<int>, int> unpackSeedAccountKey(
      {required List<int> seeds, required List<AccountMeta> previousMetas}) {
    if (seeds.isEmpty) {
      throw const MessageException("Transfer hook invalid seeds");
    }
    int index = seeds[0];
    if (previousMetas.length <= index) {
      throw const MessageException("Transfer hook invalid seeds");
    }
    return Tuple(previousMetas[index].publicKey.toBytes(), 2);
  }

  static Future<Tuple<List<int>, int>> unpackSeedAccountData(
      {required List<int> seeds,
      required List<AccountMeta> previousMetas,
      required SolanaRPC connection}) async {
    if (seeds.length < 3) {
      throw const MessageException("Transfer hook invalid seeds");
    }
    int accountIndex = seeds[0];
    int dataIndex = seeds[1];
    int length = seeds[2];
    if (previousMetas.length <= accountIndex) {
      throw const MessageException("Transfer hook invalid seeds");
    }
    SolanaAccountInfo? accountInfo = await connection.request(
        SolanaRPCGetAccountInfo(
            account: previousMetas[accountIndex].publicKey));
    if (accountInfo == null) {
      throw const MessageException("Account not found");
    }
    final accountBytes = accountInfo.toBytesData();
    if (accountBytes.length < dataIndex + length) {
      throw const MessageException("Transfer hook invalid seeds");
    }
    return Tuple(accountBytes.sublist(dataIndex, dataIndex + length), 4);
  }

  Future<Tuple<List<int>, int>?> unpackFirstSeed(
      {required List<int> seeds,
      required List<AccountMeta> previousMetas,
      required List<int> instructionData,
      required SolanaRPC connection}) async {
    int discriminator = seeds[0];
    List<int> remaining = seeds.sublist(1);
    switch (discriminator) {
      case 0:
        return null;
      case 1:
        return unpackSeedLiteral(remaining);
      case 2:
        return unpackSeedInstructionArg(
            seeds: remaining, instructionData: instructionData);
      case 3:
        return unpackSeedAccountKey(
            seeds: remaining, previousMetas: previousMetas);
      case 4:
        return unpackSeedAccountData(
            seeds: remaining,
            previousMetas: previousMetas,
            connection: connection);
      default:
        throw const MessageException("Transfer hook invalid seeds");
    }
  }

  Future<List<List<int>>> unpackSeeds(
      {required List<int> seeds,
      required List<AccountMeta> previousMetas,
      required List<int> instructionData,
      required SolanaRPC connection}) async {
    List<List<int>> unpackedSeeds = [];
    int i = 0;
    while (i < 32) {
      final seed = await unpackFirstSeed(
          seeds: seeds.sublist(i),
          previousMetas: previousMetas,
          instructionData: instructionData,
          connection: connection);
      if (seed == null) {
        break;
      }
      unpackedSeeds.add(seed.item1);
      i += seed.item2;
    }
    return unpackedSeeds;
  }

  Future<AccountMeta> resolveExtraAccountMeta({
    required SolanaRPC connection,
    required ExtraAccountMeta extraMeta,
    required List<AccountMeta> previousMetas,
    required List<int> instructionData,
    required SolAddress transferHookProgramId,
  }) async {
    if (extraMeta.discriminator == 0) {
      return AccountMeta(
        publicKey: SolAddress.uncheckBytes(extraMeta.addressConfig),
        isSigner: extraMeta.isSigner,
        isWritable: extraMeta.isWritable,
      );
    }
    SolAddress programId;
    if (extraMeta.discriminator == 1) {
      programId = transferHookProgramId;
    } else {
      int accountIndex = extraMeta.discriminator - (1 << 7);
      if (previousMetas.length <= accountIndex) {
        throw const MessageException("account not found.");
      }
      programId = previousMetas[accountIndex].publicKey;
    }

    final List<List<int>> seeds = await unpackSeeds(
        seeds: extraMeta.addressConfig,
        previousMetas: previousMetas,
        instructionData: instructionData,
        connection: connection);
    final SolAddress pubkey =
        ProgramDerivedAddress.find(seedBytes: seeds, programId: programId)
            .address;

    return AccountMeta(
        publicKey: pubkey,
        isSigner: extraMeta.isSigner,
        isWritable: extraMeta.isWritable);
  }
}
