import 'package:on_chain/solana/src/address/sol_address.dart';
import 'package:on_chain/solana/src/instructions/spl_token/types/types.dart';
import 'package:on_chain/solana/src/models/models.dart';
import 'package:on_chain/solana/src/models/pda/pda.dart';
import 'package:on_chain/solana/src/rpc/rpc.dart';
import 'package:on_chain/solana/src/exception/exception.dart';

class TransferHookUtils {
  static (List<int>, int) unpackSeedLiteral(List<int> seeds) {
    if (seeds.isEmpty) {
      throw const SolanaPluginException('Transfer hook invalid seeds');
    }
    final int length = seeds[0];
    if (seeds.length < length + 1) {
      throw const SolanaPluginException('Transfer hook invalid seeds');
    }
    return (seeds.sublist(1, length + 1), 2 + length);
  }

  static (List<int>, int) unpackSeedInstructionArg(
      {required List<int> seeds, required List<int> instructionData}) {
    if (seeds.length < 2) {
      throw const SolanaPluginException('Transfer hook invalid seeds');
    }
    final int index = seeds[0];
    final int length = seeds[1];
    if (instructionData.length < length + index) {
      throw const SolanaPluginException('Transfer hook invalid seeds');
    }
    return (instructionData.sublist(index, index + length), 3);
  }

  static (List<int>, int) unpackSeedAccountKey(
      {required List<int> seeds, required List<AccountMeta> previousMetas}) {
    if (seeds.isEmpty) {
      throw const SolanaPluginException('Transfer hook invalid seeds');
    }
    final int index = seeds[0];
    if (previousMetas.length <= index) {
      throw const SolanaPluginException('Transfer hook invalid seeds');
    }
    return (previousMetas[index].publicKey.toBytes(), 2);
  }

  static Future<(List<int>, int)> unpackSeedAccountData(
      {required List<int> seeds,
      required List<AccountMeta> previousMetas,
      required SolanaProvider connection}) async {
    if (seeds.length < 3) {
      throw const SolanaPluginException('Transfer hook invalid seeds');
    }
    final int accountIndex = seeds[0];
    final int dataIndex = seeds[1];
    final int length = seeds[2];
    if (previousMetas.length <= accountIndex) {
      throw const SolanaPluginException('Transfer hook invalid seeds');
    }
    final SolanaAccountInfo? accountInfo = await connection.request(
        SolanaRequestGetAccountInfo(
            account: previousMetas[accountIndex].publicKey));
    if (accountInfo == null) {
      throw const SolanaPluginException('Account not found');
    }
    final accountBytes = accountInfo.toBytesData();
    if (accountBytes.length < dataIndex + length) {
      throw const SolanaPluginException('Transfer hook invalid seeds');
    }
    return (accountBytes.sublist(dataIndex, dataIndex + length), 4);
  }

  Future<(List<int>, int)?> unpackFirstSeed(
      {required List<int> seeds,
      required List<AccountMeta> previousMetas,
      required List<int> instructionData,
      required SolanaProvider connection}) async {
    final int discriminator = seeds[0];
    final List<int> remaining = seeds.sublist(1);
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
        throw const SolanaPluginException('Transfer hook invalid seeds');
    }
  }

  Future<List<List<int>>> unpackSeeds(
      {required List<int> seeds,
      required List<AccountMeta> previousMetas,
      required List<int> instructionData,
      required SolanaProvider connection}) async {
    final List<List<int>> unpackedSeeds = [];
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
      unpackedSeeds.add(seed.$1);
      i += seed.$2;
    }
    return unpackedSeeds;
  }

  Future<AccountMeta> resolveExtraAccountMeta({
    required SolanaProvider connection,
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
      final int accountIndex = extraMeta.discriminator - (1 << 7);
      if (previousMetas.length <= accountIndex) {
        throw const SolanaPluginException('account not found.');
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
