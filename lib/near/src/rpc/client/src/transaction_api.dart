import 'package:blockchain_utils/utils/utils.dart';

import 'package:on_chain/exception/onchain_error.dart';
import 'package:on_chain/near/src/account/src/types.dart';
import 'package:on_chain/near/src/address/address.dart';
import 'package:on_chain/near/src/crypto/crypto.dart';
import 'package:on_chain/near/src/rpc/rpc.dart';
import 'package:on_chain/near/src/transaction/src/action.dart';
import 'package:on_chain/near/src/transaction/src/transaction.dart';
import 'package:on_chain/near/src/types/types.dart';

mixin NearQuickTransactionApi on NearQuickNodeApi {
  Future<NearAccountState> accountState(
    BaseNearAddress address, {
    NearBlockReference blockReference = NearBlockReference.optimistic,
    Duration? timeout,
  }) async {
    final result = await protocolConfig(
      blockReference: blockReference,
      timeout: timeout,
    );
    final account = await viewAccount(address, timeout: timeout);
    final runtimeConfig = result.runtimeConfig;
    final storageAmount = runtimeConfig?.storageAmountPerByte;
    if (runtimeConfig == null || storageAmount == null) {
      throw OnChainErrors.nearPlugin(
        "accountState",
        reason: "Missing protocol runtime config: storageAmountPerByte.",
        details: {"address": address.address},
      );
    }
    final storageUsed =
        account.value.storageUsage * BigintUtils.parse(storageAmount);
    final locked = BigintUtils.parse(account.value.locked);
    final total = BigintUtils.parse(account.value.amount) + locked;
    final available = total - (locked > storageUsed ? locked : storageUsed);
    return NearAccountState(
      balance: NearAccountStateBalance(
        total: total,
        usedOnStorage: storageUsed,
        locked: locked,
        available: available,
      ),
      storageUsage: account.value.storageUsage.toInt(),
      codeHash: account.value.codeHash,
    );
  }

  Future<({BigInt nonce, List<int> blockHash, BigInt maxBlockHeight})>
  _getTransactionRequirement({
    required BaseNearAddress accountId,
    required NearPublicKey publicKey,
    int blockHeightTtl = 200,
    Duration? timeout,
  }) async {
    final viewAccount = await viewAccessKey(
      accountId: accountId,
      publicKey: publicKey.encode(),
      timeout: timeout,
    );
    final block = await this.block(
      blockReference: NearBlockRefrenceFinality(
        finality: NearRpcFinality.final_,
      ),
      timeout: timeout,
    );
    final blockHash = block.header.hash;
    final maxBlockHeight = block.header.height + BigInt.from(blockHeightTtl);
    return (
      nonce: viewAccount.value.nonce,
      blockHash: StringUtils.encode(blockHash, encoding: StringEncoding.base58),
      maxBlockHeight: maxBlockHeight,
    );
  }

  Future<NearTransaction> createUnsignedTransaction({
    required BaseNearAddress accountId,
    required BaseNearAddress receiverId,
    required List<NearAction> actions,
    required NearPublicKey publicKey,
    Duration? timeout,
  }) async {
    final requirement = await _getTransactionRequirement(
      accountId: accountId,
      publicKey: publicKey,
      timeout: timeout,
    );
    return NearTransaction(
      signerId: accountId.address,
      publicKey: publicKey,
      nonce: requirement.nonce + BigInt.one,
      receiverId: receiverId.address,
      actions: actions,
      blockHash: requirement.blockHash,
    );
  }

  Future<NearSignedTransactionWithHash> createSignedTransaction({
    required BaseNearAddress accountId,
    required BaseNearAddress receiverId,
    required List<NearAction> actions,
    required NearSecretKey secretKey,
    Duration? timeout,
  }) async {
    final transaction = await createUnsignedTransaction(
      accountId: accountId,
      receiverId: receiverId,
      actions: actions,
      publicKey: secretKey.toPublicKey(),
      timeout: timeout,
    );
    return secretKey.signTransaction(transaction);
  }

  Future<NearDelegateAction> createMetadataTransaction({
    required BaseNearAddress accountId,
    required BaseNearAddress receiverId,
    required List<NearClassicAction> actions,
    required NearPublicKey publicKey,
    Duration? timeout,
    int blockHeightTtl = 200,
  }) async {
    final requirement = await _getTransactionRequirement(
      accountId: accountId,
      publicKey: publicKey,
      blockHeightTtl: blockHeightTtl,
      timeout: timeout,
    );
    return NearDelegateAction(
      actions: actions,
      maxBlockHeight: requirement.maxBlockHeight,
      nonce: requirement.nonce + BigInt.one,
      publicKey: publicKey,
      receiverId: receiverId.address,
      senderId: accountId.address,
    );
  }

  Future<NearSignedDelegateAction> createSignedMetadataTransaction({
    required BaseNearAddress accountId,
    required BaseNearAddress receiverId,
    required List<NearClassicAction> actions,
    required NearSecretKey secretKey,
    Duration? timeout,
    int blockHeightTtl = 200,
  }) async {
    final delegate = await createMetadataTransaction(
      accountId: accountId,
      receiverId: receiverId,
      actions: actions,
      publicKey: secretKey.toPublicKey(),
      blockHeightTtl: blockHeightTtl,
      timeout: timeout,
    );
    return secretKey.signDelegateAction(delegate);
  }

  Future<NearRpcRpcTransactionResponse> signAndSendTransaction({
    required BaseNearAddress accountId,
    required BaseNearAddress receiverId,
    required List<NearAction> actions,
    required NearSecretKey secretKey,
    Duration? timeout,
    NearRpcTxExecutionStatus waitUntil =
        NearRpcTxExecutionStatus.executedOptimistic,
  }) async {
    final transaction = await createSignedTransaction(
      accountId: accountId,
      receiverId: receiverId,
      actions: actions,
      secretKey: secretKey,
      timeout: timeout,
    );
    return await sendTransactionUntil(
      transaction: transaction.signedTransaction,
      waitUntil: waitUntil,
    );
  }

  Future<NearRpcRpcTransactionResponse> createAndSendSubAccountIdTransaction({
    required BaseNearAddress accountId,
    required BaseNearAddress newAccountId,
    required NearSecretKey secretKey,
    required NearPublicKey newAccountPublicKey,
    Duration? timeout,
    BigInt? initialAmount,
    NearRpcTxExecutionStatus waitUntil =
        NearRpcTxExecutionStatus.executedOptimistic,
  }) async {
    if (!newAccountId.address.endsWith(accountId.address)) {
      throw OnChainErrors.nearPlugin(
        "createSubAccountIdTransaction",
        reason: "Invalid sub account ID.",
        details: {
          "newAccountId": newAccountId.address,
          "accountId": accountId.address,
        },
      );
    }
    final List<NearAction> actions = [
      ActionCreateAccount(),
      ActionTransfer(NearTransfer(deposit: initialAmount ?? BigInt.zero)),
      ActionAddKey(
        NearAddKey(
          publicKey: newAccountPublicKey,
          accessKey: NearAccessKey(
            nonce: BigInt.zero,
            permission: NearAccessKeyPermissionFullAccess(),
          ),
        ),
      ),
    ];
    return await signAndSendTransaction(
      accountId: accountId,
      receiverId: newAccountId,
      actions: actions,
      secretKey: secretKey,
      waitUntil: waitUntil,
      timeout: timeout,
    );
  }

  Future<NearRpcRpcTransactionResponse> createAndSendAccountIdTransaction({
    required BaseNearAddress accountId,
    required BaseNearAddress newAccountId,
    required NearSecretKey secretKey,
    required NearPublicKey newAccountPublicKey,
    Duration? timeout,
    BigInt? initialAmount,
    NearRpcTxExecutionStatus waitUntil =
        NearRpcTxExecutionStatus.executedOptimistic,
  }) async {
    final segments = newAccountId.address.split(".");
    if (segments.length != 2) {
      throw OnChainErrors.nearPlugin(
        "createAndSendAccountIdTransaction",
        reason: "Invalid new address: expected <account>.<top-level-account>.",
        details: {"newAccountId": newAccountId.address},
      );
    }
    return await signAndSendTransaction(
      accountId: accountId,
      receiverId: NearNamedAddress(newAccountId.address.split(".")[1]),
      actions: [
        ActionFunctionCall(
          NearFunctionCall(
            methodName: "create_account",
            args: StringUtils.encodeJson({
              "new_account_id": newAccountId.address,
              "new_public_key": newAccountPublicKey.encode(),
            }),
            gas: BigInt.parse("60000000000000"),
            deposit: initialAmount ?? BigInt.zero,
          ),
        ),
      ],
      secretKey: secretKey,
      waitUntil: waitUntil,
      timeout: timeout,
    );
  }

  Future<NearRpcRpcTransactionResponse> createAndSendFunctionCallTransaction({
    required BaseNearAddress contractId,
    required BaseNearAddress accountId,
    required String methodName,
    required BigInt gas,
    required NearSecretKey secretKey,
    NearRpcTxExecutionStatus waitUntil =
        NearRpcTxExecutionStatus.executedOptimistic,
    BigInt? deposit,
    List<int> args = const [],
    Duration? timeout,
  }) async {
    final functionCall = NearFunctionCall(
      methodName: methodName,
      args: args,
      gas: gas,
      deposit: deposit ?? BigInt.zero,
    );
    return signAndSendTransaction(
      accountId: accountId,
      receiverId: contractId,
      actions: [ActionFunctionCall(functionCall)],
      secretKey: secretKey,
      waitUntil: waitUntil,
      timeout: timeout,
    );
  }

  Future<NearRpcRpcTransactionResponse> createAndSendRelayMetaTransaction({
    required BaseNearAddress accountId,
    required NearSecretKey<NearPublicKey> secretKey,
    NearRpcTxExecutionStatus waitUntil =
        NearRpcTxExecutionStatus.executedOptimistic,
    required NearSignedDelegate delegate,
    Duration? timeout,
  }) async {
    return await signAndSendTransaction(
      accountId: accountId,
      receiverId: BaseNearAddress(delegate.delegateAction.senderId),
      actions: [ActionSignedDelegate(delegate)],
      secretKey: secretKey,
      waitUntil: waitUntil,
      timeout: timeout,
    );
  }

  Future<NearRpcRpcTransactionResponse> createAndSendAddKeyTransaction({
    required BaseNearAddress accountId,
    required List<NearAddKey> keys,
    required NearSecretKey secretKey,
    NearRpcTxExecutionStatus waitUntil =
        NearRpcTxExecutionStatus.executedOptimistic,
    Duration? timeout,
  }) async {
    return signAndSendTransaction(
      accountId: accountId,
      receiverId: accountId,
      actions: keys.map((e) => ActionAddKey(e)).toList(),
      secretKey: secretKey,
      waitUntil: waitUntil,
      timeout: timeout,
    );
  }

  Future<NearRpcRpcTransactionResponse> createAndSendRemoveKeyTransaction({
    required BaseNearAddress accountId,
    required List<NearDeleteKey> keys,
    required NearSecretKey secretKey,
    NearRpcTxExecutionStatus waitUntil =
        NearRpcTxExecutionStatus.executedOptimistic,
    Duration? timeout,
  }) async {
    return signAndSendTransaction(
      accountId: accountId,
      receiverId: accountId,
      actions: keys.map((e) => ActionDeleteKey(e)).toList(),
      secretKey: secretKey,
      waitUntil: waitUntil,
      timeout: timeout,
    );
  }
}
