import 'dart:async';

import 'package:blockchain_utils/blockchain_utils.dart';
import 'package:on_chain/exception/onchain_error.dart';
import 'package:on_chain/solidity/solidity.dart';
import 'package:on_chain/tron/src/address/tron_address.dart';
import 'package:on_chain/tron/src/models/contracts/contracts.dart';
import 'package:on_chain/tron/src/proto_messages/protocol/models.dart';
import 'package:on_chain/tron/src/provider/core/request.dart';
import 'package:on_chain/tron/src/provider/methods/methods/full_node.dart';
import 'package:on_chain/tron/src/provider/methods/methods/grpc.dart';
import 'package:on_chain/tron/src/provider/models/broadcast_tx.dart';
import 'package:on_chain/tron/src/provider/models/types.dart';
import 'package:on_chain/tron/src/provider/utils/utils.dart';

/// Unified transaction status (wallet `WalletTransactionStatus` parity for
/// the TRON cases).
enum TronTxStatus {
  /// The transaction receipt reflects success.
  block,

  /// The transaction receipt reflects failure.
  failed,

  /// The transaction is unknown to the node.
  unknown,
}

mixin TronQuickClientApi {
  IGrpcProvider<
    IServiceProvider,
    BaseTronServiceRequestParams,
    TronGrpcRequestDetails
  >
  get provider;

  List<TronProviderApi> get availableProviders;
  Future<T> mapProviderApi<T>({
    required Future<T> Function() onGrpc,
    required Future<T> Function() onFullNode,
  }) async {
    if (availableProviders.contains(TronProviderApi.grpc)) {
      return onGrpc();
    }
    if (availableProviders.contains(TronProviderApi.fullnode)) {
      return onFullNode();
    }
    throw BuError(
      OnChainErrorType.tronPlugin,
      "No available provider.",
      details: {"available": "$availableProviders"},
    );
  }

  Future<TronBlock> getNowBlock() async {
    return mapProviderApi(
      onGrpc:
          () =>
              provider.request(TronGrpcRequestMessage(TronWalletGetNowBlock())),
      onFullNode:
          () => provider.request(TronFullNodeRequestWalletGetnowblockGet()),
    );
  }

  Future<TronBlock> getBlockByBlockId(int blockId) async {
    return mapProviderApi(
      onGrpc:
          () => provider.request(
            TronGrpcRequestMessage(
              TronWalletGetBlockByNum(
                getBlockByNum: TronNumberMessage(num: BigInt.from(blockId)),
              ),
            ),
          ),
      onFullNode:
          () => provider.request(
            TronFullNodeRequestWalletGetblockbynumPost(
              requestBody: TronHttpBlockHeightNumberMessageRequest(
                num_: BigInt.from(blockId),
              ),
            ),
          ),
    );
  }

  Future<TronChainParameters> getChainParameters() async {
    return mapProviderApi(
      onGrpc:
          () => provider.request(
            TronGrpcRequestMessage(TronWalletGetChainParameters()),
          ),
      onFullNode:
          () => provider.request(
            TronFullNodeRequestWalletGetchainparametersGet(),
          ),
    );
  }

  /// Returns bandwidth, energy and storage resources for [address].
  Future<TronAccountResourceMessage> getAccountResource(
    TronAddress address, {
    bool visible = false,
  }) async {
    return mapProviderApi(
      onGrpc:
          () => provider.request(
            TronGrpcRequestMessage(TronWalletGetAccountResource()),
          ),
      onFullNode:
          () => provider.request(
            TronFullNodeRequestWalletGetaccountresourcePost(
              requestBody: TronHttpWalletGetaccountresourcePostBody(
                address: address.toAddress(visible),
                visible: visible,
              ),
            ),
          ),
    );
  }

  Future<int> estimateCallContractEnergy({
    required TronAddress ownerAddress,
    required TronAddress contractAddress,
    AbiFunctionFragment? fragment,
    required List<int> data,
    BigInt? callValue,
    BigInt? callTokenValue,
    BigInt? tokenID,
  }) async {
    final TronTransactionExtention energyRequired = await mapProviderApi(
      onGrpc: () async {
        return provider.request(
          TronGrpcRequestMessage(
            TronWalletTriggerConstantContract(
              triggerConstantContract: TronTriggerSmartContract(
                ownerAddress: ownerAddress,
                callTokenValue: callTokenValue,
                callValue: callValue,
                tokenId: tokenID,
                contractAddress: contractAddress,
                data: data,
              ),
            ),
          ),
        );
      },
      onFullNode:
          () => provider.request(
            TronFullNodeRequestWalletTriggerconstantcontractPost(
              ownerAddress: ownerAddress,
              contractAddress: contractAddress,
              data: BytesUtils.toHexString(data),
              fragment: fragment,
              callValue: callValue,
              callTokenValue: callTokenValue,
              tokenId: tokenID,
            ),
          ),
    );
    if (!energyRequired.isSuccess) {
      final error = energyRequired.error;
      throw BuError(
        OnChainErrorType.tronPlugin,
        "Energy estimation failed: ${error ?? "unknown energy error"}.",
      );
    }
    final energy = energyRequired.energyUsed;
    if (energy == null) {
      throw BuError(
        OnChainErrorType.tronPlugin,
        "Contract energy estimation failed: energy missing in response.",
      );
    }
    return energy.asSafeInt;
  }

  Future<int> estimateCreateContractEnergy({
    required TronAddress ownerAddress,
    required List<int> byteCode,
    BigInt? callValue,
    BigInt? callTokenValue,
    BigInt? tokenID,
  }) async {
    final energyRequired = await mapProviderApi(
      onGrpc:
          () => provider.request(
            TronGrpcRequestMessage(
              TronWalletTriggerConstantContract(
                triggerConstantContract: TronTriggerSmartContract(
                  ownerAddress: ownerAddress,
                  callTokenValue: callTokenValue,
                  callValue: callValue,
                  tokenId: tokenID,
                  data: byteCode,
                ),
              ),
            ),
          ),
      onFullNode:
          () => provider.request(
            TronFullNodeRequestWalletTriggerconstantcontractPost(
              ownerAddress: ownerAddress,
              data: BytesUtils.toHexString(byteCode),
              callValue: callValue,
              callTokenValue: callTokenValue,
              tokenId: tokenID,
            ),
          ),
    );
    if (!energyRequired.isSuccess) {
      final error = energyRequired.error;

      throw BuError(
        OnChainErrorType.tronPlugin,
        "Energy estimation failed: ${error ?? "unknown energy error"}.",
      );
    }
    final energy = energyRequired.energyUsed;
    if (energy == null) {
      throw BuError(
        OnChainErrorType.tronPlugin,
        "Contract energy estimation failed: energy missing in response.",
      );
    }
    return energy.asSafeInt;
  }

  Future<TronAccount?> getActiveAccount(
    TronAddress address, {
    bool visible = false,
  }) async {
    final account = await getAccount(address, visible: visible);
    if (account.address != null) return account;
    return null;
  }

  Future<TronAssetIssueList> issueAssetList() async {
    return mapProviderApi(
      onGrpc: () async {
        return await provider.request(
          TronGrpcRequestMessage(TronWalletGetAssetIssueList()),
        );
      },
      onFullNode: () async {
        return await provider.request(
          TronFullNodeRequestWalletGetassetissuelistPost(),
        );
      },
    );
  }

  Future<TronDelegatedResourceList> getDelegateResourceV2({
    required TronAddress fromAddress,
    required TronAddress toAddress,
  }) async {
    return mapProviderApi(
      onGrpc: () async {
        return await provider.request(
          TronGrpcRequestMessage(
            TronWalletGetDelegatedResourceV2(
              getDelegatedResourceV2: TronDelegatedResourceMessage(
                fromAddress: fromAddress.toBytes(),
                toAddress: toAddress.toBytes(),
              ),
            ),
          ),
        );
      },
      onFullNode: () async {
        return await provider.request(
          TronFullNodeRequestWalletGetdelegatedresourcev2Post(
            requestBody: TronHttpDelegatedResourceMessageRequest(
              fromAddress: fromAddress.toAddress(false),
              toAddress: toAddress.toAddress(false),
              visible: false,
            ),
          ),
        );
      },
    );
  }

  Future<List<TronAddress>> accountDelegateResourceAddress(
    TronAddress address,
  ) async {
    return mapProviderApi(
      onGrpc: () async {
        final result = await provider.request(
          TronGrpcRequestMessage(
            TronWalletGetDelegatedResourceAccountIndexV2(
              getDelegatedResourceAccountIndexV2: TronBytesMessage(
                value: address.toBytes(),
              ),
            ),
          ),
        );
        return result.toAccounts.map(TronAddress.fromBytes).toList();
      },
      onFullNode: () async {
        final result = await provider.request(
          TronFullNodeRequestWalletGetdelegatedresourceaccountindexv2Post(
            requestBody: TronHttpBytesMessageRequest(
              value: address.toAddress(false),
              visible: false,
            ),
          ),
        );
        return result.toAccounts.map(TronAddress.fromBytes).toList();
      },
    );
  }

  Future<BigInt?> canDelegatedMaxSizeRequestMessage({
    required TronAddress address,
    required TronResourceCode type,
  }) async {
    return mapProviderApi(
      onGrpc: () async {
        final result = await provider.request(
          TronGrpcRequestMessage(
            TronWalletGetCanDelegatedMaxSize(
              getCanDelegatedMaxSize: TronCanDelegatedMaxSizeRequestMessage(
                ownerAddress: address.toBytes(),
                type: type.value,
              ),
            ),
          ),
        );
        return result.maxSize;
      },
      onFullNode: () async {
        final result = await provider.request(
          TronFullNodeRequestWalletGetcandelegatedmaxsizePost(
            requestBody: TronHttpCanDelegatedMaxSizeRequestMessageRequest(
              ownerAddress: address.toAddress(false),
              visible: false,
              type: type.value,
            ),
          ),
        );
        return result.maxSize;
      },
    );
  }

  Future<TronAssetIssueContract?> assetIssueById(String assetId) async {
    return mapProviderApi(
      onGrpc: () async {
        final result = await provider.request(
          TronGrpcRequestMessage(
            TronWalletGetAssetIssueById(
              getAssetIssueById: TronBytesMessage(
                value: StringUtils.encode(assetId),
              ),
            ),
          ),
        );
        if (result.id == null) return null;
        return result;
      },
      onFullNode: () async {
        return await provider.request(
          TronFullNodeRequestWalletGetassetissuebyidPost(
            requestBody: TronHttpWalletGetassetissuebyidPostBody(
              value: assetId,
            ),
          ),
        );
      },
    );
  }

  Future<TronAccount> getAccount(
    TronAddress address, {
    bool visible = false,
  }) async {
    return mapProviderApi(
      onGrpc: () {
        return provider.request(
          TronGrpcRequestMessage(
            TronWalletGetAccount(
              getAccount: TronAccount(address: address.toBytes()),
            ),
          ),
        );
      },
      onFullNode:
          () => provider.request(
            TronFullNodeRequestWalletGetaccountPost(
              requestBody: TronHttpAccountRequest(
                address: address.toAddress(visible),
                visible: visible,
              ),
            ),
          ),
    );
  }

  /// Returns TRC-10 balances keyed by token id.
  Future<Map<String, BigInt>> getAccountTrc10Tokens(
    TronAddress address, {
    bool visible = false,
  }) async {
    final result = await getAccount(address, visible: visible);
    return {...result.asset, ...result.assetV2};
  }

  /// Returns true when the account exists on-chain.
  Future<bool> isAccountActive(
    TronAddress address, {
    bool visible = false,
  }) async {
    final account = await getActiveAccount(address, visible: visible);
    return account != null;
  }

  /// Broadcasts a signed [transaction].
  Future<TronBroadcastTxResult> broadcastTx(
    TronTransaction transaction, {
    bool visible = false,
  }) async {
    return await mapProviderApi(
      onGrpc: () async {
        final result = await provider.request(
          TronGrpcRequestMessage(
            TronWalletBroadcastTransaction(broadcastTransaction: transaction),
          ),
        );
        return TronBroadcastTxResult(
          txid: transaction.rawData.txID,
          transaction: transaction,
          code: result.code?.name,
          message: StringUtils.tryDecode(result.message),
          result: result.result,
        );
      },
      onFullNode: () async {
        final result = await provider.request(
          TronFullNodeRequestWalletBroadcasthexPost(
            requestBody: TronHttpWalletBroadcasthexPostBody(
              transaction: transaction.toBuffer().toHex(),
            ),
          ),
        );
        return TronBroadcastTxResult(
          txid: transaction.rawData.txID,
          transaction: transaction,
          code: result.code,
          message: result.message,
          result: result.result,
        );
      },
    );
  }

  /// Fetches a transaction by its [txId].
  Future<TronTransaction?> getTransactionByTxId(
    String txId, {
    bool visible = false,
    int? permissionId,
  }) async {
    final result = await mapProviderApi(
      onGrpc:
          () => provider.request(
            TronGrpcRequestMessage(
              TronWalletGetTransactionById(
                getTransactionById: TronBytesMessage(
                  value: BytesUtils.fromHexString(txId),
                ),
              ),
            ),
          ),
      onFullNode:
          () => provider.request(
            TronFullNodeRequestWalletGettransactionbyidPost(
              txId: txId,
              visible: visible,
            ),
          ),
    );
    return result;
  }

  /// Native (TRX) balance of [address]; missing accounts read as zero.
  Future<BigInt> getBalance(TronAddress address) async {
    final account = await getAccount(address);
    return account.balance ?? BigInt.zero;
  }

  /// Current block height, or null when the header carries none.
  Future<BigInt?> getBlockHeight() async {
    final block = await getNowBlock();
    return block.blockHeader?.rawData?.number;
  }

  /// Polls until [transactionId] is served, returning it. Unknown
  /// transactions keep polling; timeouts throw.
  Future<TronTransaction> trackTransaction({
    required String transactionId,
    Duration timeout = const Duration(minutes: 5),
    Duration periodicTimeOut = const Duration(seconds: 10),
  }) async {
    Timer? timer;
    try {
      final Completer<TronTransaction> completer = Completer<TronTransaction>();
      timer = Timer.periodic(periodicTimeOut, (_) async {
        try {
          final receipt = await getTransactionByTxId(transactionId);
          if (receipt != null && !completer.isCompleted) {
            completer.complete(receipt);
          }
        } catch (_) {}
      });
      return await completer.future.timeout(timeout);
    } on TimeoutException {
      throw BuError(
        OnChainErrorType.tronPlugin,
        "Transaction confirmation failed within the allotted timeout.",
        details: {"transactionId": transactionId},
      );
    } finally {
      timer?.cancel();
      timer = null;
    }
  }

  /// Status of [txId]: unknown when the node has no such transaction,
  /// block/failed from the receipt result otherwise.
  Future<TronTxStatus> getTransactionStatus(String txId) async {
    final tx = await getTransactionByTxId(txId);
    if (tx == null) return TronTxStatus.unknown;
    if (tx.ret.isSuccess()) return TronTxStatus.block;
    return TronTxStatus.failed;
  }
}
