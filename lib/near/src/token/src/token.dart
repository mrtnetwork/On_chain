import 'package:blockchain_utils/utils/utils.dart';
import 'package:on_chain/near/src/address/address.dart';
import 'package:on_chain/near/src/contract/src/contract.dart';
import 'package:on_chain/near/src/contract/src/types.dart';
import 'package:on_chain/near/src/crypto/private_key/secret_key.dart';
import 'package:on_chain/near/src/crypto/public_key/public_key.dart';
import 'package:on_chain/near/src/rpc/client/src/client.dart';
import 'package:on_chain/near/src/transaction/src/action.dart';
import 'types.dart';

class NearTokenConst {
  static final BigInt defaultGas = BigInt.parse("30000000000000");
}

abstract class NearContractToken<
  BALANCRARGS extends BaseTokenBalanceArgs,
  TRANSFERARGS extends BaseTokenTransferArgs
>
    extends DefaultNearContract {
  @override
  final BaseNearAddress contractId;
  const NearContractToken({required this.contractId});
  Future<BigInt> getBalance({
    required BALANCRARGS args,
    required NearQuickClient client,
  });
  Future<ExecuteContractResult> transfer({
    required NearQuickClient client,
    required TRANSFERARGS args,
    required NearSecretKey secretKey,
  });
}

class NearFungibleToken
    extends
        NearContractToken<
          SignleTokenContractBalanceArgs,
          FungibleTokenTransferArgs
        > {
  final FTMetadata? metadata;
  NearFungibleToken({this.metadata, required super.contractId});

  @override
  Future<BigInt> getBalance({
    required SignleTokenContractBalanceArgs args,
    required NearQuickClient client,
  }) async {
    final result = await read<Map<String, dynamic>?, String>(
      client: client,
      args: {"account_id": args.accountId.address},
      function: NearContractJsonFunction("ft_balance_of"),
    );
    return JsonParser.valueAsBigInt(result);
  }

  Future<StorageBalanceBounds> storageBalanceBounds({
    required NearQuickClient client,
  }) async {
    final result = await read<Map<String, dynamic>?, Map<String, dynamic>>(
      client: client,
      args: null,
      function: NearContractJsonFunction("storage_balance_bounds"),
    );
    return StorageBalanceBounds.fromJson(result);
  }

  Future<StorageBalance?> storageBalanceOf({
    required NearQuickClient client,
    required BaseNearAddress accountId,
  }) async {
    final result = await read<Map<String, dynamic>?, Map<String, dynamic>?>(
      client: client,
      args: {"account_id": accountId.address},
      function: NearContractJsonFunction("storage_balance_of"),
    );
    if (result == null) return null;
    return StorageBalance.fromJson(result);
  }

  Future<NearFunctionCall?> createDeposit({
    required BaseNearAddress accountId,
    required NearQuickClient client,
    required BigInt? gas,
  }) async {
    final storageBalance = await storageBalanceOf(
      client: client,
      accountId: accountId,
    );
    if (storageBalance != null) return null;
    final bounds = await storageBalanceBounds(client: client);
    return NearContractJsonFunction<Map<String, dynamic>>(
      "storage_deposit",
    ).createFunctionCall(
      args: {"account_id": accountId.address},
      gas: gas ?? NearTokenConst.defaultGas,
      deposit: bounds.min,
    );
  }

  @override
  Future<ExecuteContractResult> transfer({
    required NearQuickClient client,
    required FungibleTokenTransferArgs args,
    required NearSecretKey<NearPublicKey> secretKey,
  }) async {
    final deposit = await createDeposit(
      accountId: args.receiverId,
      client: client,
      gas: args.gas,
    );
    final message = args.message;
    if (deposit == null) {
      return await call(
        client: client,
        accountId: args.accountId,
        gas: args.gas ?? NearTokenConst.defaultGas,
        secretKey: secretKey,
        args: {
          "amount": args.amount.toString(),
          "receiver_id": args.receiverId.address,
          if (message != null) "msg": message,
        },
        deposit: args.deposit ?? BigInt.one,
        waitUntil: args.waitUntil,
        function: NearContractJsonFunction(
          message == null ? "ft_transfer" : "ft_transfer_call",
        ),
      );
    }
    return await batchCall(
      client: client,
      accountId: args.accountId,
      actions: [
        deposit,
        NearContractJsonFunction(
          message == null ? "ft_transfer" : "ft_transfer_call",
        ).createFunctionCall(
          args: {
            "amount": args.amount.toString(),
            "receiver_id": args.receiverId.address,
            if (message != null) "msg": message,
          },
          gas: args.gas ?? NearTokenConst.defaultGas,
          deposit: args.deposit ?? BigInt.one,
        ),
      ],
      secretKey: secretKey,
    );
  }
}

class MultiTokenContract
    extends
        NearContractToken<
          MultiTokenContractBalanceArgs,
          MultiTokenContractTransferArgs
        > {
  const MultiTokenContract({required super.contractId});
  @override
  Future<BigInt> getBalance({
    required MultiTokenContractBalanceArgs args,
    required NearQuickClient client,
  }) async {
    final result = await read<Map<String, dynamic>?, String>(
      client: client,
      args: {"account_id": args.accountId.address, "token_id": args.tokenId},
      function: NearContractJsonFunction<String>("mt_balance_of"),
    );
    return JsonParser.valueAsBigInt(result);
  }

  Future<List<BigInt>> getBalances({
    required List<String> tokenIds,
    required BaseNearAddress accountId,
    required NearQuickClient client,
  }) async {
    final result = await read<Map<String, dynamic>?, List<String>>(
      client: client,
      args: {"account_id": accountId.address, "token_ids": tokenIds},
      function: NearContractJsonFunction<List<String>>("mt_batch_balance_of"),
    );
    return result.map((e) => BigintUtils.parse(e)).toList();
  }

  Future<List<MultiTokenTokenMetadata>> metadataTokenByTokenId({
    required List<String> tokenIds,
    required NearQuickClient client,
  }) async {
    final result =
        await read<Map<String, dynamic>?, List<Map<String, dynamic>>>(
          client: client,
          args: {"token_ids": tokenIds},
          function: NearContractJsonFunction<List<Map<String, dynamic>>>(
            "mt_metadata_token_by_token_id",
          ),
        );
    return result.map((e) => MultiTokenTokenMetadata.fromJson(e)).toList();
  }

  Future<List<MultiTokenTokenMetadataAll>> metadataTokenAll({
    required List<String> tokenIds,
    required NearQuickClient client,
  }) async {
    final result =
        await read<Map<String, dynamic>?, List<Map<String, dynamic>>>(
          client: client,
          args: {"token_ids": tokenIds},
          function: NearContractJsonFunction<List<Map<String, dynamic>>>(
            "mt_metadata_token_all",
          ),
        );
    return result.map((e) => MultiTokenTokenMetadataAll.fromJson(e)).toList();
  }

  Future<List<MultiTokenBaseMetadata>> metadataBaseByTokenId({
    required List<String> tokenIds,
    required NearQuickClient client,
  }) async {
    final result =
        await read<Map<String, dynamic>?, List<Map<String, dynamic>>>(
          client: client,
          args: {"token_ids": tokenIds},
          function: NearContractJsonFunction<List<Map<String, dynamic>>>(
            "mt_metadata_base_by_token_id",
          ),
        );
    return result.map((e) => MultiTokenBaseMetadata.fromJson(e)).toList();
  }

  Future<ContractMetadata> metadataContract({
    required NearQuickClient client,
  }) async {
    final result = await read<Map<String, dynamic>?, Map<String, dynamic>>(
      client: client,
      args: null,
      function: NearContractJsonFunction<Map<String, dynamic>>(
        "mt_metadata_contract",
      ),
    );
    return ContractMetadata.fromJson(result);
  }

  Future<StorageBalance?> storageBalanceOf({
    required NearQuickClient client,
    required BaseNearAddress accountId,
    required List<String> tokenIds,
  }) async {
    final result = await read<Map<String, dynamic>?, Map<String, dynamic>?>(
      client: client,
      args: {"account_id": accountId.address, "token_ids": tokenIds},
      function: NearContractJsonFunction("storage_balance_of"),
    );
    if (result == null) return null;
    return StorageBalance.fromJson(result);
  }

  Future<StorageBalanceBounds> storageBalanceBounds({
    required NearQuickClient client,
    required List<String> tokenIds,
  }) async {
    final result = await read<Map<String, dynamic>?, Map<String, dynamic>>(
      client: client,
      args: {"token_ids": tokenIds},
      function: NearContractJsonFunction("storage_balance_bounds"),
    );
    return StorageBalanceBounds.fromJson(result);
  }

  Future<NearFunctionCall?> createDeposit({
    required BaseNearAddress accountId,
    required NearQuickClient client,
    required BigInt? gas,
    required List<String> tokenIds,
  }) async {
    final storageBalance = await storageBalanceOf(
      client: client,
      accountId: accountId,
      tokenIds: tokenIds,
    );
    if (storageBalance != null) return null;
    final bounds = await storageBalanceBounds(
      client: client,
      tokenIds: tokenIds,
    );
    return NearContractJsonFunction<Map<String, dynamic>>(
      "storage_deposit",
    ).createFunctionCall(
      args: {"account_id": accountId.address, "token_ids": tokenIds},
      gas: gas ?? NearTokenConst.defaultGas,
      deposit: bounds.min,
    );
  }

  @override
  Future<ExecuteContractResult> transfer({
    required NearQuickClient client,
    required MultiTokenContractTransferArgs args,
    required NearSecretKey<NearPublicKey> secretKey,
  }) async {
    final message = args.message;
    final deposit = await createDeposit(
      accountId: args.accountId,
      client: client,
      gas: args.gas ?? NearTokenConst.defaultGas,
      tokenIds: [args.tokenId],
    );
    return await batchCall(
      client: client,
      accountId: args.accountId,
      secretKey: secretKey,
      actions: [
        if (deposit != null) deposit,
        NearContractJsonFunction(
          message == null ? "mt_transfer" : "mt_transfer_call",
        ).createFunctionCall(
          args: {
            "amount": args.amount.toString(),
            "receiver_id": args.receiverId.address,
            "token_id": args.tokenId,
            if (args.approval != null) "approval": args.approval?.toJson(),
            "memo": args.memo,
            if (message != null) "msg": message,
          },
          gas: args.gas ?? NearTokenConst.defaultGas,
          deposit: args.deposit ?? BigInt.one,
        ),
      ],
      waitUntil: args.waitUntil,
    );
  }

  Future<ExecuteContractResult> batchTransfer({
    required NearQuickClient client,
    required MultiTokenContractBatchTransferArgs args,
    required NearSecretKey<NearPublicKey> secretKey,
  }) async {
    final message = args.message;
    final deposit = await createDeposit(
      accountId: args.accountId,
      client: client,
      gas: args.gas ?? NearTokenConst.defaultGas,
      tokenIds: args.amounts.map((e) => e.tokenId).toList(),
    );
    return await batchCall(
      client: client,
      accountId: args.accountId,
      secretKey: secretKey,
      actions: [
        if (deposit != null) deposit,
        NearContractJsonFunction(
          message == null ? "mt_batch_transfer" : "mt_batch_transfer_call",
        ).createFunctionCall(
          args: {
            "receiver_id": args.receiverId.address,
            "token_ids": args.amounts.map((e) => e.tokenId).toList(),
            "amounts": args.amounts.map((e) => e.amount).toList(),
            if (args.approvals != null)
              "approvals": args.approvals?.map((e) => e?.toJson()).toList(),
            "memo": args.memo,
            if (message != null) "msg": message,
          },
          gas: args.gas ?? NearTokenConst.defaultGas,
          deposit: args.deposit ?? BigInt.one,
        ),
      ],
      waitUntil: args.waitUntil,
    );
  }
}
