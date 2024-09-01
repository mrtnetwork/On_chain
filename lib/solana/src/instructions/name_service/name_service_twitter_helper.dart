import 'dart:async';
import 'package:on_chain/solana/src/exception/exception.dart';
import 'package:on_chain/solana/src/address/sol_address.dart';
import 'package:on_chain/solana/src/instructions/name_service/name_service.dart';
import 'package:on_chain/solana/src/models/models.dart';
import 'package:on_chain/solana/src/rpc/rpc.dart';

class NameServiceProgramTwitterHelper {
  /// Signed by the authority, the payer and the verified pubkey
  static Future<List<TransactionInstruction>> createVerifiedTwitterRegistry({
    required SolanaRPC rpc,
    required String twitterHandle,
    required SolAddress verifiedPubkey,
    required int space,
    required SolAddress payerKey,
  }) async {
    final hashedTwitterHandle =
        NameServiceProgramUtils.getHashedName(twitterHandle);
    final twitterHandleRegistryKey =
        NameServiceProgramUtils.getNameAccountProgram(
      hashedName: hashedTwitterHandle,
      nameParent: NameServiceProgramConst.twitterRootPrentRegisteryKey,
    );

    List<TransactionInstruction> instructions = [
      NameServiceProgram.create(
        nameKey: twitterHandleRegistryKey,
        nameOwnerKey: verifiedPubkey,
        payerKey: payerKey,
        layout: NameServiceCreateLayout(
            lamports: await rpc.request(
                SolanaRPCGetMinimumBalanceForRentExemption(size: space)),
            hashedName: hashedTwitterHandle,
            space: space),
        nameParent: NameServiceProgramConst.twitterRootPrentRegisteryKey,
        nameParentOwner: NameServiceProgramConst.twitterVerificationAuthority,
      ),
    ];

    instructions.addAll(await createReverseTwitterRegistry(
      rpc: rpc,
      twitterHandle: twitterHandle,
      twitterRegistryKey: twitterHandleRegistryKey,
      verifiedPubkey: verifiedPubkey,
      payerKey: payerKey,
    ));

    return instructions;
  }

  /// Overwrite the data that is written in the user facing registry
  static TransactionInstruction changeTwitterRegistryData({
    required String twitterHandle,
    required SolAddress verifiedPubkey,
    required int offset,
    required List<int> inputData,
  }) {
    final hashedTwitterHandle =
        NameServiceProgramUtils.getHashedName(twitterHandle);
    final twitterHandleRegistryKey =
        NameServiceProgramUtils.getNameAccountProgram(
      hashedName: hashedTwitterHandle,
      nameParent: NameServiceProgramConst.twitterRootPrentRegisteryKey,
    );

    return NameServiceProgram.update(
      nameAccountKey: twitterHandleRegistryKey,
      layout: NameServiceUpdateLayout(inputData: inputData, offset: offset),
      nameUpdateSigner: verifiedPubkey,
    );
  }

  /// Change the verified pubkey for a given twitter handle
  static Future<List<TransactionInstruction>> changeVerifiedPubkey({
    required SolanaRPC rpc,
    required String twitterHandle,
    required SolAddress currentVerifiedPubkey,
    required SolAddress newVerifiedPubkey,
    required SolAddress payerKey,
  }) async {
    final hashedTwitterHandle =
        NameServiceProgramUtils.getHashedName(twitterHandle);
    final twitterHandleRegistryKey =
        NameServiceProgramUtils.getNameAccountProgram(
      hashedName: hashedTwitterHandle,
      nameParent: NameServiceProgramConst.twitterRootPrentRegisteryKey,
    );

    final List<TransactionInstruction> instructions = [
      NameServiceProgram.transfer(
        nameAccountKey: twitterHandleRegistryKey,
        layout: NameServiceTransferLayout(newOwnerKey: newVerifiedPubkey),
        currentNameOwnerKey: currentVerifiedPubkey,
      ),
      await NameServiceProgramHelper.deleteNameRegistry(
        rpc: rpc,
        name: currentVerifiedPubkey.address,
        refundTargetKey: payerKey,
        nameClass: NameServiceProgramConst.twitterVerificationAuthority,
        nameParent: NameServiceProgramConst.twitterRootPrentRegisteryKey,
      ),
      ...await createReverseTwitterRegistry(
        rpc: rpc,
        twitterHandle: twitterHandle,
        twitterRegistryKey: twitterHandleRegistryKey,
        verifiedPubkey: newVerifiedPubkey,
        payerKey: payerKey,
      )
    ];

    return instructions;
  }

  /// Delete the verified registry for a given twitter handle
  static List<TransactionInstruction> deleteTwitterRegistry({
    required String twitterHandle,
    required SolAddress verifiedPubkey,
  }) {
    final hashedTwitterHandle =
        NameServiceProgramUtils.getHashedName(twitterHandle);
    final twitterHandleRegistryKey =
        NameServiceProgramUtils.getNameAccountProgram(
      hashedName: hashedTwitterHandle,
      nameParent: NameServiceProgramConst.twitterRootPrentRegisteryKey,
    );

    final hashedVerifiedPubkey =
        NameServiceProgramUtils.getHashedName(verifiedPubkey.address);
    final reverseRegistryKey = NameServiceProgramUtils.getNameAccountProgram(
      hashedName: hashedVerifiedPubkey,
      nameClass: NameServiceProgramConst.twitterVerificationAuthority,
      nameParent: NameServiceProgramConst.twitterRootPrentRegisteryKey,
    );

    return [
      NameServiceProgram.delete(
        nameAccountKey: twitterHandleRegistryKey,
        refundTargetKey: verifiedPubkey,
        nameOwnerKey: verifiedPubkey,
      ),
      NameServiceProgram.delete(
        nameAccountKey: reverseRegistryKey,
        refundTargetKey: verifiedPubkey,
        nameOwnerKey: verifiedPubkey,
      )
    ];
  }

  static Future<NameRegistryAccount> getTwitterRegistry({
    required SolanaRPC rpc,
    required String twitterHandle,
  }) async {
    final hashedTwitterHandle =
        NameServiceProgramUtils.getHashedName(twitterHandle);
    final twitterHandleRegistryKey =
        NameServiceProgramUtils.getNameAccountProgram(
      hashedName: hashedTwitterHandle,
      nameParent: NameServiceProgramConst.twitterRootPrentRegisteryKey,
    );
    final registry = await rpc.request(
        SolanaRPCNameRegistryAccount(account: twitterHandleRegistryKey));
    if (registry == null) {
      throw const SolanaPluginException("Account not found.");
    }

    return registry;
  }

  static Future<ReverseTwitterRegistryAccount> getHandleAndRegistryKey({
    required SolanaRPC rpc,
    required SolAddress verifiedPubkey,
  }) async {
    final hashedVerifiedPubkey =
        NameServiceProgramUtils.getHashedName(verifiedPubkey.address);
    final reverseRegistryKey = NameServiceProgramUtils.getNameAccountProgram(
      hashedName: hashedVerifiedPubkey,
      nameClass: NameServiceProgramConst.twitterVerificationAuthority,
      nameParent: NameServiceProgramConst.twitterRootPrentRegisteryKey,
    );

    final reverseRegistryState = await rpc.request(
        SolanaRPCReverseTwitterRegistryAccount(account: reverseRegistryKey));
    if (reverseRegistryState == null) {
      throw const SolanaPluginException("Account not found.");
    }
    return reverseRegistryState;
  }

  /// Uses the RPC node filtering feature, execution speed may vary
  static Future<ReverseTwitterRegistryAccount>
      getTwitterHandleandRegistryKeyViaFilters({
    required SolanaRPC rpc,
    required SolAddress verifiedPubkey,
  }) async {
    final filteredAccounts = await rpc.request(SolanaRPCGetProgramAccounts(
        account: NameServiceProgramConst.programId,
        filters: [
          RPCMemcmpFilterConfig(
              offset: 0,
              bytes:
                  NameServiceProgramConst.twitterRootPrentRegisteryKey.address),
          RPCMemcmpFilterConfig(offset: 32, bytes: verifiedPubkey.address),
          RPCMemcmpFilterConfig(
              offset: 64,
              bytes:
                  NameServiceProgramConst.twitterVerificationAuthority.address),
        ]));

    for (final account in filteredAccounts) {
      final accountBytes = account.toBytesData();
      if (accountBytes.length >
          NameRegistryAccountUtils.hiddenDataOffset + 32) {
        return ReverseTwitterRegistryAccount.fromAccountBytes(accountBytes);
      }
    }
    throw Exception('Registry not found.');
  }

  /// Uses the RPC node filtering feature, execution speed may vary
  /// Does not give you the handle, but is an alternative to getHandlesAndKeysFromVerifiedPubkey + getTwitterRegistry to get the data
  static Future<List<int>> getTwitterRegistryData({
    required SolanaRPC rpc,
    required SolAddress verifiedPubkey,
  }) async {
    final filteredAccounts = await rpc.request(SolanaRPCGetProgramAccounts(
        account: NameServiceProgramConst.programId,
        filters: [
          RPCMemcmpFilterConfig(
              offset: 0,
              bytes:
                  NameServiceProgramConst.twitterRootPrentRegisteryKey.address),
          RPCMemcmpFilterConfig(offset: 32, bytes: verifiedPubkey.address),
          RPCMemcmpFilterConfig(
              offset: 64, bytes: SolAddress.defaultPubKey.address),
        ]));
    if (filteredAccounts.length != 1) {
      throw const SolanaPluginException(
          'Account not found or more than one registry found.');
    }
    final account = filteredAccounts[0];
    return account
        .toBytesData()
        .sublist(NameRegistryAccountUtils.hiddenDataOffset);
  }

  static Future<List<TransactionInstruction>> createReverseTwitterRegistry({
    required SolanaRPC rpc,
    required String twitterHandle,
    required SolAddress twitterRegistryKey,
    required SolAddress verifiedPubkey,
    required SolAddress payerKey,
  }) async {
    final hashedVerifiedPubkey =
        NameServiceProgramUtils.getHashedName(verifiedPubkey.address);
    final reverseRegistryKey = NameServiceProgramUtils.getNameAccountProgram(
      hashedName: hashedVerifiedPubkey,
      nameClass: NameServiceProgramConst.twitterVerificationAuthority,
      nameParent: NameServiceProgramConst.twitterRootPrentRegisteryKey,
    );
    final reverseTwitterRegistryStateBuff = ReverseTwitterRegistryAccount(
            twitterRegistryKey: twitterRegistryKey,
            twitterHandle: twitterHandle)
        .toBytes();
    return [
      NameServiceProgram.create(
        nameKey: reverseRegistryKey,
        nameOwnerKey: verifiedPubkey,
        payerKey: payerKey,
        layout: NameServiceCreateLayout(
            lamports: await rpc.request(
                SolanaRPCGetMinimumBalanceForRentExemption(
                    size: reverseTwitterRegistryStateBuff.length)),
            hashedName: hashedVerifiedPubkey,
            space: reverseTwitterRegistryStateBuff.length),
        nameClassKey: NameServiceProgramConst.twitterVerificationAuthority,
        nameParent: NameServiceProgramConst.twitterRootPrentRegisteryKey,
        nameParentOwner: NameServiceProgramConst.twitterVerificationAuthority,
      ),
      NameServiceProgram.update(
          nameAccountKey: reverseRegistryKey,
          layout: NameServiceUpdateLayout(
              inputData: reverseTwitterRegistryStateBuff, offset: 0),
          nameUpdateSigner:
              NameServiceProgramConst.twitterVerificationAuthority),
    ];
  }
}
