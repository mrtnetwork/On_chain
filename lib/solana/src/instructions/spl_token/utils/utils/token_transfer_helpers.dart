import 'package:on_chain/solana/src/address/sol_address.dart';
import 'package:blockchain_utils/blockchain_utils.dart';
import 'package:on_chain/solana/src/borsh_serialization/program_layout.dart';

import 'package:on_chain/solana/src/instructions/spl_token/accounts/accounts/transfer_fee_config.dart';
import 'package:on_chain/solana/src/instructions/spl_token/accounts/accounts/transfer_hook.dart';
import 'package:on_chain/solana/src/instructions/spl_token/constant.dart';
import 'package:on_chain/solana/src/instructions/spl_token/layouts/layouts.dart';
import 'package:on_chain/solana/src/instructions/spl_token/program.dart';
import 'package:on_chain/solana/src/instructions/spl_token/spl_token_2022_extensions_program.dart';
import 'package:on_chain/solana/src/instructions/spl_token/types/types/extra_account_meta.dart';
import 'package:on_chain/solana/src/instructions/spl_token/types/types/extra_account_meta_list.dart';
import 'package:on_chain/solana/src/instructions/spl_token/utils/utils/transfer_hook_utils.dart';
import 'package:on_chain/solana/src/models/account/account_meta.dart';
import 'package:on_chain/solana/src/models/pda/pda.dart';
import 'package:on_chain/solana/src/models/transaction/instruction.dart';
import 'package:on_chain/solana/src/rpc/methods/methods/get_account_info.dart';
import 'package:on_chain/solana/src/rpc/provider/provider.dart';

class SolanaTokenTransferHelpers {
  static BigInt calculateTransferFee({
    required List<int> mintAccountData,
    required BigInt amount,
    required BigInt epoch,
  }) {
    try {
      final config = TransferFeeConfig.fromAccountBytes(mintAccountData);
      return config.calculateEpochFee(preFeeAmount: amount, epoch: epoch);
    } on BuError {
      return BigInt.zero;
    }
  }

  static TransactionInstruction buildTransfer({
    required SolAddress source,
    required SolAddress mint,
    required SolAddress destination,
    required SolAddress owner,
    required BigInt amount,
    required int decimals,
    required BigInt fee,
    List<SolAddress> multiSigners = const [],
    List<AccountMeta> extraHookAccounts = const [],
    SolAddress programId = SPLTokenProgramConst.tokenProgramId,
  }) {
    if (programId == SPLTokenProgramConst.token2022ProgramId &&
        fee > BigInt.zero) {
      final ix = SPLToken2022ExtensionsProgram.transferCheckedWithFee(
        source: source,
        mint: mint,
        destination: destination,
        authority: owner,
        layout: SPLToken2022TransferCheckedWithFeeLayout(
          amount: amount,
          decimals: decimals,
          fee: fee,
        ),
        programId: programId,
        multiSigners: multiSigners,
      );
      if (extraHookAccounts.isEmpty) return ix;
      return TransactionInstruction(
        programId: ix.programId,
        data: ix.data,
        keys: [...ix.keys, ...extraHookAccounts],
      );
    }
    final ix = SPLTokenProgram.transferChecked(
      source: source,
      mint: mint,
      destination: destination,
      owner: owner,
      layout: SPLTokenTransferCheckedLayout(amount: amount, decimals: decimals),
      programId: programId,
      multiSigners: multiSigners,
    );
    if (extraHookAccounts.isEmpty) return ix;
    return TransactionInstruction(
      programId: ix.programId,
      data: ix.data,
      keys: [...ix.keys, ...extraHookAccounts],
    );
  }

  static Future<List<AccountMeta>> resolveTransferHookAccounts({
    required SolanaProvider provider,
    required List<int> mintAccountData,
    required SolAddress source,
    required SolAddress mint,
    required SolAddress destination,
    required SolAddress owner,
    required List<int> transferInstructionData,
  }) async {
    late final TransferHook hook;
    try {
      hook = TransferHook.fromAccountBytes(mintAccountData);
    } on BuError {
      return const [];
    }
    final hookUtils = TransferHookUtils();
    // Validation-state PDA derived by the hook program; the canonical
    // seed is ["__transfer-hook-validate__"] per the SPL transfer-hook spec.
    final validateState =
        ProgramDerivedAddress.find(
          seedBytes: const [
            [
              95,
              95,
              116,
              114,
              97,
              110,
              115,
              102,
              101,
              114,
              45,
              104,
              111,
              111,
              107,
              45,
              118,
              97,
              108,
              105,
              100,
              97,
              116,
              101,
              95,
              95,
            ],
          ],
          programId: hook.programId,
        ).address;
    final baseMetas = [
      source.toWritable(),
      mint.toReadOnly(),
      destination.toWritable(),
      owner.toReadOnly(),
      validateState.toReadOnly(),
    ];
    final extraMetaAddress =
        ProgramDerivedAddress.find(
          seedBytes: [
            const [
              101,
              120,
              116,
              114,
              97,
              45,
              97,
              99,
              99,
              111,
              117,
              110,
              116,
              45,
              109,
              101,
              116,
              97,
              115,
            ],
            mint.toBytes(),
          ],
          programId: hook.programId,
        ).address;
    final extraInfo = await provider.request(
      SolanaRequestGetAccountInfo(account: extraMetaAddress),
    );
    if (extraInfo == null) return const [];
    final extraData = extraInfo.toBytesData();
    // Skip the 32-byte discriminator prefix used by ExtraMetaAccountData.
    final decoded = BorshLayoutSerializable.decode(
      bytes: extraData.length > 32 ? extraData.sublist(32) : extraData,
      layout: ExtraAccountMetaList.staticLayout,
    );
    final rawList = decoded['extraAccountMetaList'] as Map<String, dynamic>;
    final parsed = ExtraAccountMetaList.fromJson({
      'count': rawList['count'],
      'extraAccounts':
          (rawList['extraAccounts'] as List)
              .map((e) => (e as Map<String, dynamic>)['extraAccountMeta'])
              .toList(),
    });
    final List<AccountMeta> out = [];
    for (final ExtraAccountMeta meta in parsed.extraAccounts) {
      out.add(
        await hookUtils.resolveExtraAccountMeta(
          connection: provider,
          extraMeta: meta,
          previousMetas: [...baseMetas, ...out],
          instructionData: transferInstructionData,
          transferHookProgramId: hook.programId,
        ),
      );
    }
    return out;
  }

  static TransactionInstruction buildHarvestToMint({
    required SolAddress mint,
    required List<SolAddress> sources,
    SolAddress programId = SPLTokenProgramConst.token2022ProgramId,
  }) {
    return SPLToken2022ExtensionsProgram.harvestWithheldTokensToMint(
      mint: mint,
      sources: sources,
      programId: programId,
    );
  }
}
