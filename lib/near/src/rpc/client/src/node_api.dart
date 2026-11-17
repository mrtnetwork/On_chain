import 'package:blockchain_utils/blockchain_utils.dart';

import 'package:on_chain/exception/onchain_error.dart';
import 'package:on_chain/near/src/address/address.dart';
import 'package:on_chain/near/src/contract/src/types.dart';
import 'package:on_chain/near/src/rpc/rpc.dart';
import 'package:on_chain/near/src/transaction/src/transaction.dart';
import 'package:on_chain/near/src/types/types.dart';

mixin NearQuickNodeApi {
  IProvider<IServiceProvider, BaseServiceRequestParams> get provider;

  Future<NearRpcRpcQueryResponseAccountView> viewAccount(
    BaseNearAddress accountId, {
    NearBlockReference blockReference = NearBlockReference.optimistic,
    Duration? timeout,
  }) async {
    return await provider.request(
      NearNodeRequestQueryViewAccount(
        accountId: accountId.address,
        blockReference: blockReference,
      ),
      timeout: timeout,
    );
  }

  Future<NearRpcRpcQueryResponseAccessKeyView> viewAccessKey({
    required BaseNearAddress accountId,
    required String publicKey,
    NearBlockReference blockReference = NearBlockReference.optimistic,
    Duration? timeout,
  }) async {
    return await provider.request(
      NearNodeRequestQueryViewAccessKey(
        accountId: accountId.address,
        blockReference: blockReference,
        publicKey: publicKey,
      ),
      timeout: timeout,
    );
  }

  Future<NearRpcRpcQueryResponseAccessKeyList> viewAccessKeyList(
    BaseNearAddress accountId, {
    NearBlockReference blockReference = NearBlockReference.optimistic,
    Duration? timeout,
  }) async {
    return await provider.request(
      NearNodeRequestQueryViewAccessKeyList(
        accountId.address,
        blockReference: blockReference,
      ),
      timeout: timeout,
    );
  }

  Future<NearRpcRpcQueryResponseContractCodeView> viewContractCode(
    BaseNearAddress accountId, {
    NearBlockReference blockReference = NearBlockReference.optimistic,
    Duration? timeout,
  }) async {
    return await provider.request(
      NearNodeRequestQueryViewContractCode(
        accountId: accountId.address,
        blockReference: blockReference,
      ),
      timeout: timeout,
    );
  }

  Future<NearRpcRpcQueryResponseViewStateResult> viewContractState({
    required String contractId,
    required String prefix,
    NearBlockReference blockReference = NearBlockReference.optimistic,
    Duration? timeout,
  }) async {
    return await provider.request(
      NearNodeRequestQueryViewContractState(
        accountId: contractId,
        blockReference: blockReference,
        prefixBase64: StringUtils.decode(
          StringUtils.encode(prefix),
          encoding: StringEncoding.base64,
        ),
      ),
      timeout: timeout,
    );
  }

  Future<NearRpcRpcQueryResponseContractCodeView> viewGlobalContractCode({
    String? accountId,
    String? codeHash,
    NearBlockReference blockReference = NearBlockReference.optimistic,
    Duration? timeout,
  }) async {
    if (accountId != null) {
      return await provider.request(
        NearNodeRequestQueryViewContractCode.globalContractByAccountId(
          accountId: accountId,
          blockReference: blockReference,
        ),
        timeout: timeout,
      );
    }
    if (codeHash != null) {
      return await provider.request(
        NearNodeRequestQueryViewContractCode.globalContractByCodeHash(
          codeHash: codeHash,
          blockReference: blockReference,
        ),
        timeout: timeout,
      );
    }
    throw OnChainErrors.nearPlugin(
      "viewGlobalContractCode",
      reason: "Either accountId or codeHash must be provided.",
    );
  }

  Future<String> getNetworkId({Duration? timeout}) async {
    final result = await provider.request(
      NearNodeRequestStatus(),
      timeout: timeout,
    );
    return result.chainId;
  }

  Future<NearRpcRpcStatusResponse> getStatus({Duration? timeout}) async {
    final result = await provider.request(
      NearNodeRequestStatus(),
      timeout: timeout,
    );
    return result;
  }

  Future<NearRpcRpcQueryResponseCallResult> readFunction({
    required BaseNearAddress accountId,
    required List<int> argBytes,
    required String method,
    NearBlockReference blockReference = NearBlockReference.optimistic,
    Duration? timeout,
  }) async {
    return await provider.request(
      NearNodeRequestQueryCallFunction(
        accountId: accountId.address,
        argsBase64: StringUtils.decode(
          argBytes,
          encoding: StringEncoding.base64,
        ),
        blockReference: blockReference,
        methodName: method,
      ),
      timeout: timeout,
    );
  }

  Future<DECODE>
  readFunctionResponse<ENCODE extends Object?, DECODE extends Object?>({
    required BaseNearAddress contractId,
    required ENCODE args,
    required NearContractFunction<ENCODE, DECODE> function,
    NearBlockReference blockReference = NearBlockReference.optimistic,
    Duration? timeout,
  }) async {
    final result = await provider.request(
      NearNodeRequestQueryCallFunction(
        accountId: contractId.address,
        argsBase64: StringUtils.decode(
          function.encode(args),
          encoding: StringEncoding.base64,
        ),
        blockReference: blockReference,
        methodName: function.name,
      ),
      timeout: timeout,
    );
    return function.decode(result.value.result);
  }

  Future<NearRpcRpcBlockResponse> block({
    NearBlockReference blockReference = NearBlockReference.optimistic,
    Duration? timeout,
  }) async {
    return await provider.request(
      NearNodeRequestBlock(
        blockReference.fold(
          onBlockId:
              (blockId) => NearRpcRpcBlockRequestBlockId(blockId: blockId),
          onFinality:
              (finality) => NearRpcRpcBlockRequestFinality(finality: finality),
        ),
      ),
      timeout: timeout,
    );
  }

  Future<NearRpcRpcChunkResponse> chunk(
    String chunkId, {
    Duration? timeout,
  }) async {
    return await provider.request(
      NearNodeRequestChunk(NearRpcRpcChunkRequestChunkHash(chunkId: chunkId)),
      timeout: timeout,
    );
  }

  Future<NearRpcRpcGasPriceResponse> gasPrice({
    NearRpcBlockId? blockId,
    Duration? timeout,
  }) async {
    return await provider.request(
      NearNodeRequestGasPrice(NearRpcRpcGasPriceRequest(blockId: blockId)),
      timeout: timeout,
    );
  }

  Future<NearRpcRpcValidatorResponse> validators({
    NearBlockReference blockReference = NearBlockReference.optimistic,
    Duration? timeout,
    String? epochId,
  }) async {
    return await provider.request(
      NearNodeRequestValidators(
        epochId != null
            ? NearRpcRpcValidatorRequestEpochId(epochId: epochId)
            : blockReference.fold(
              onBlockId:
                  (blockId) =>
                      NearRpcRpcValidatorRequestBlockId(blockId: blockId),
              onFinality:
                  (finality) => NearRpcRpcValidatorRequestLatest(latest: {}),
            ),
      ),
      timeout: timeout,
    );
  }

  Future<NearRpcRpcTransactionResponse> transactionStatus({
    required String txId,
    required BaseNearAddress accountId,
    Duration? timeout,
  }) async {
    return await provider.request(
      NearNodeRequestTx(
        NearRpcRpcTransactionStatusRequestTxHashSenderAccountId(
          senderAccountId: accountId.address,
          txHash: txId,
        ),
      ),
      timeout: timeout,
    );
  }

  Future<NearRpcRpcTransactionResponse> viewTransactionStatusWithReceipts({
    required String txId,
    required BaseNearAddress accountId,
    Duration? timeout,
  }) async {
    return await provider.request(
      NearNodeRequestExperimentalTxStatus(
        NearRpcRpcTransactionStatusRequestTxHashSenderAccountId(
          senderAccountId: accountId.address,
          txHash: txId,
        ),
      ),
      timeout: timeout,
    );
  }

  Future<NearRpcRpcReceiptResponse> viewTransactionReceipt(
    String receiptId, {
    Duration? timeout,
  }) async {
    return await provider.request(
      NearNodeRequestExperimentalReceipt(
        NearRpcRpcReceiptRequest(receiptId: receiptId),
      ),
      timeout: timeout,
    );
  }

  Future<NearRpcRpcTransactionResponse> sendTransactionUntil({
    required NearSignedTransaction transaction,
    NearRpcTxExecutionStatus? waitUntil =
        NearRpcTxExecutionStatus.executedOptimistic,
    Duration? timeout,
  }) async {
    return await provider.request(
      NearNodeRequestSendTx(
        NearRpcRpcSendTransactionRequest(
          signedTxBase64: StringUtils.decode(
            transaction.toSerializeBytes(),
            encoding: StringEncoding.base64,
          ),
          waitUntil: waitUntil,
        ),
      ),
      timeout: timeout,
    );
  }

  Future<NearRpcRpcTransactionResponse> sendTransactionAsync({
    required NearSignedTransaction transaction,
    NearRpcTxExecutionStatus? waitUntil =
        NearRpcTxExecutionStatus.executedOptimistic,
    Duration? timeout,
  }) async {
    return sendTransactionUntil(
      transaction: transaction,
      waitUntil: NearRpcTxExecutionStatus.none,
      timeout: timeout,
    );
  }

  Future<T> query<T extends NearRpcRpcQueryResponse>(
    NearRpcRpcQueryRequest request, {
    Duration? timeout,
  }) async {
    final result = await provider.request(
      NearNodeRequestQuery(request),
      timeout: timeout,
    );
    if (result is T) {
      return result;
    }
    throw OnChainErrors.nearPlugin(
      "query",
      reason: "Unable to decode response as $T.",
      details: {"expected": "$T", "actual": "${result.runtimeType}"},
    );
  }

  Future<NearRpcRpcStateChangesInBlockByTypeResponse> blockChanges({
    NearBlockReference blockReference = NearBlockReference.optimistic,
    Duration? timeout,
  }) async {
    return await provider.request(
      NearNodeRequestExperimentalChangesInBlock(
        blockReference.fold(
          onBlockId:
              (blockId) =>
                  NearRpcRpcStateChangesInBlockRequestBlockId(blockId: blockId),
          onFinality:
              (finality) => NearRpcRpcStateChangesInBlockRequestFinality(
                finality: finality,
              ),
        ),
      ),
      timeout: timeout,
    );
  }

  Future<NearRpcRpcProtocolConfigResponse> protocolConfig({
    NearBlockReference blockReference = NearBlockReference.optimistic,
    Duration? timeout,
  }) async {
    return await provider.request(
      NearNodeRequestExperimentalProtocolConfig(
        blockReference.fold(
          onBlockId:
              (blockId) =>
                  NearRpcRpcProtocolConfigRequestBlockId(blockId: blockId),
          onFinality:
              (finality) =>
                  NearRpcRpcProtocolConfigRequestFinality(finality: finality),
        ),
      ),
      timeout: timeout,
    );
  }
}
