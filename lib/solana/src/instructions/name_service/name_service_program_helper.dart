import 'dart:async';
import 'package:on_chain/solana/src/exception/exception.dart';
import 'package:on_chain/solana/src/address/sol_address.dart';
import 'package:on_chain/solana/src/instructions/name_service/name_service.dart';
import 'package:on_chain/solana/src/models/transaction/instruction.dart';
import 'package:on_chain/solana/src/rpc/rpc.dart';

class NameServiceProgramHelper {
  /// Creates a name account with the given rent budget, allocated space, owner and class
  static Future<TransactionInstruction> createNameRegistry(
      {
      /// The solana connection object to the RPC node
      required SolanaRPC rpc,

      /// The name of the new account
      required String name,

      /// The space in bytes allocated to the account
      required int space,

      /// The allocation cost payer
      required SolAddress payerKey,

      /// The pubkey to be set as owner of the new name account
      required SolAddress nameOwner,

      /// The budget to be set for the name account. If not specified, it'll be the minimum for rent exemption
      BigInt? lamports,

      /// The class of this new name
      SolAddress? nameClass,

      /// The parent name of the new name. If specified its owner needs to sign
      SolAddress? parentName}) async {
    final hashedName = NameServiceProgramUtils.getHashedName(name);
    final nameAccountKey = NameServiceProgramUtils.getNameAccountProgram(
      hashedName: hashedName,
      nameClass: nameClass,
      nameParent: parentName,
    );

    final BigInt balance = lamports ??
        await rpc
            .request(SolanaRPCGetMinimumBalanceForRentExemption(size: space));

    SolAddress? nameParentOwner;
    if (parentName != null) {
      final account =
          await rpc.request(SolanaRPCNameRegistryAccount(account: parentName));
      if (account == null) {
        throw const SolanaPluginException("Account not found.");
      }
      nameParentOwner = account.owner;
    }

    final createNameInstr = NameServiceProgram.create(
      nameKey: nameAccountKey,
      nameOwnerKey: nameOwner,
      payerKey: payerKey,
      layout: NameServiceCreateLayout(
          lamports: balance, hashedName: hashedName, space: space),
      nameClassKey: nameClass,
      nameParent: parentName,
      nameParentOwner: nameParentOwner,
    );

    return createNameInstr;
  }

  /// Overwrite the data of the given name registry.
  static Future<TransactionInstruction> updateNameRegistryData(
      {
      /// The solana connection object to the RPC node
      required SolanaRPC rpc,

      /// The name of the name registry to update
      required String name,

      /// The offset to which the data should be written into the registry
      required int offset,

      /// The data to be written
      required List<int> inputData,

      /// The class of this name, if it exsists
      SolAddress? nameClass,

      /// The parent name of this name, if it exists
      SolAddress? nameParent}) async {
    final hashedName = NameServiceProgramUtils.getHashedName(name);
    final nameAccountKey = NameServiceProgramUtils.getNameAccountProgram(
      hashedName: hashedName,
      nameClass: nameClass,
      nameParent: nameParent,
    );

    SolAddress? signer = nameClass;
    if (signer == null) {
      final account = await rpc
          .request(SolanaRPCNameRegistryAccount(account: nameAccountKey));
      if (account == null) {
        throw const SolanaPluginException("Account not found.");
      }
      signer = account.owner;
    }

    return NameServiceProgram.update(
      nameAccountKey: nameAccountKey,
      layout: NameServiceUpdateLayout(inputData: inputData, offset: offset),
      nameUpdateSigner: signer,
      parentNameKey: nameParent,
    );
  }

  /// Change the owner of a given name account.
  static Future<TransactionInstruction> transferNameOwnership(
      {
      /// The solana connection object to the RPC node
      required SolanaRPC rpc,

      /// The name of the name account
      required String name,

      /// The new owner to be set
      required SolAddress newOwner,

      /// The class of this name, if it exsists
      SolAddress? nameClass,

      /// The parent name of this name, if it exists
      SolAddress? nameParent}) async {
    final hashedName = NameServiceProgramUtils.getHashedName(name);
    final nameAccountKey = NameServiceProgramUtils.getNameAccountProgram(
      hashedName: hashedName,
      nameClass: nameClass,
      nameParent: nameParent,
    );

    SolAddress? currentNameOwner = nameClass;
    if (currentNameOwner == null) {
      final account = await rpc
          .request(SolanaRPCNameRegistryAccount(account: nameAccountKey));
      if (account == null) {
        throw const SolanaPluginException("Account not found.");
      }
      currentNameOwner = account.owner;
    }

    return NameServiceProgram.transfer(
      nameAccountKey: nameAccountKey,
      layout: NameServiceTransferLayout(newOwnerKey: newOwner),
      currentNameOwnerKey: currentNameOwner,
      nameClassKey: nameClass,
      nameParent: nameParent,
    );
  }

  /// Delete the name account and transfer the rent to the target.
  static Future<TransactionInstruction> deleteNameRegistry({
    /// The solana connection object to the RPC node
    required SolanaRPC rpc,

    /// The name of the name account
    required String name,

    /// The refund destination address
    required SolAddress refundTargetKey,

    /// The class of this name, if it exsists
    SolAddress? nameClass,

    /// The parent name of this name, if it exists
    SolAddress? nameParent,
  }) async {
    final hashedName = NameServiceProgramUtils.getHashedName(name);
    final nameAccountKey = NameServiceProgramUtils.getNameAccountProgram(
      hashedName: hashedName,
      nameClass: nameClass,
      nameParent: nameParent,
    );

    SolAddress? nameOwner = nameClass;
    if (nameOwner == null) {
      final account = await rpc
          .request(SolanaRPCNameRegistryAccount(account: nameAccountKey));
      if (account == null) {
        throw const SolanaPluginException("Account not found.");
      }
      nameOwner = account.owner;
    }

    return NameServiceProgram.delete(
      nameAccountKey: nameAccountKey,
      refundTargetKey: refundTargetKey,
      nameOwnerKey: nameOwner,
    );
  }

  /// Realloc the name account space.
  static Future<TransactionInstruction> reallocNameAccount({
    /// The solana connection object to the RPC node
    required SolanaRPC rpc,

    /// The name of the name account
    required String name,

    /// The new space to be allocated
    required int space,

    /// The allocation cost payer if new space is larger than current or the refund destination if smaller
    required SolAddress payerKey,

    /// The class of this name, if it exsists
    SolAddress? nameClass,

    /// The parent name of this name, if it exists
    SolAddress? nameParent,
  }) async {
    final hashedName = NameServiceProgramUtils.getHashedName(name);
    final nameAccountKey = NameServiceProgramUtils.getNameAccountProgram(
      hashedName: hashedName,
      nameClass: nameClass,
      nameParent: nameParent,
    );

    SolAddress? nameOwner = nameClass;
    if (nameOwner == null) {
      final account = await rpc
          .request(SolanaRPCNameRegistryAccount(account: nameAccountKey));
      if (account == null) {
        throw const SolanaPluginException("Account not found.");
      }
      nameOwner = account.owner;
    }

    return NameServiceProgram.realloc(
      payerKey: payerKey,
      nameAccountKey: nameAccountKey,
      nameOwnerKey: nameOwner,
      layout: NameServiceReallocLayout(space: space),
    );
  }
}
