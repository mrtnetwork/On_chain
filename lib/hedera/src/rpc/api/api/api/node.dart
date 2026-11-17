import 'dart:async';

import 'package:blockchain_utils/blockchain_utils.dart';
import 'package:on_chain/exception/onchain_error.dart';
import 'package:on_chain/hedera/src/address/src/address.dart';
import 'package:on_chain/hedera/src/proto_messages/proto/models.dart';
import 'package:on_chain/hedera/src/rpc/methods/grpc/query.dart';
import 'package:on_chain/hedera/src/rpc/rpc.dart';
import 'package:on_chain/hedera/src/serialization/protobuf/proto.dart';
import 'package:on_chain/hedera/src/transaction/utils/utils.dart';

mixin HederaQuickQueryApi {
  HederaClientSterategy get strategy;
  HederaAccountID get nodeAccountId;

  IGrpcProvider<
    IServiceProvider,
    BaseHederaServiceRequestParams,
    BaseGRPCServiceRequestParams
  >
  get internalProvider;

  IGrpcProvider<
    IServiceProvider,
    BaseHederaServiceRequestParams,
    BaseGRPCServiceRequestParams
  >
  _getProvider() {
    return switch (strategy.node) {
      null =>
        throw OnChainErrors.hederaPlugin(
          "HederaQuickQueryApi",
          reason: 'Node access disabled by client strategy.',
        ),
      _ => internalProvider,
    };
  }

  void ensureIsOnChainAccount(HederaAddress address) {
    if (!address.isOnChainAccount()) {
      throw OnChainErrors.hederaPlugin(
        "ensureIsOnChainAccount",
        reason:
            'Account $address is an alias/EVM address; query payment requires an on-chain account id.',
      );
    }
  }

  HederaTransactionBody _buildTxBody(BigInt cost, {HederaAddress? payer}) {
    final txId = HederaTransactionBuilderUtils.buildTxId(address: payer);
    return HederaTransactionBody(
      transactionID: txId.id,
      nodeAccountID: nodeAccountId,
      transactionFee: AmountConverter.hdra.toUnit('1'),
      transactionValidDuration: HederaDuration(
        seconds: BigInt.from(
          HederaTransactionBuilderUtils.maxTransactionValidDuration.inSeconds,
        ),
      ),
      cryptoTransfer: HederaCryptoTransferTransactionBody(
        transfers: HederaTransferList(
          accountAmounts: [
            HederaAccountAmount(
              accountID: payer?.toAccoutId() ?? HederaAccountID(),
              amount: -cost,
            ),
            HederaAccountAmount(accountID: nodeAccountId, amount: cost),
          ],
        ),
      ),
    );
  }

  Future<HederaTransaction> buildQueryPaymentTx({
    required IHederaQuery query,
  }) async {
    final paymentRequired = HederaClientUtils.queryPaymentRequired(query);
    BigInt cost = BigInt.zero;
    if (paymentRequired) {
      final costQuery = query.copyWith(
        header: HederaQueryHeader(responseType: HederaResponseType.costAnswer),
      );
      final response = await _getProvider().request(
        HederaGrpcRequestQuery(costQuery),
      );
      cost = response.header?.cost ?? BigInt.zero;
      final queryParams = strategy.node;
      if (queryParams is! HederaApiNodeStrategyPaidQuery) {
        throw OnChainErrors.hederaPlugin(
          "buildQueryPaymentTx",
          reason: 'Query paid disabled by client strategy.',
        );
      }
      final source = await queryParams.source(query);
      final body = _buildTxBody(cost, payer: source.payer);
      ensureIsOnChainAccount(source.payer);
      return source.signer.signQueryPaymentTransaction(
        body: body,
        query: query,
        cost: cost,
      );
    }
    final body = _buildTxBody(cost);

    return HederaTransaction(
      signedTransactionBytes:
          HederaSignedTransaction(bodyBytes: body.toBuffer()).toBuffer(),
    );
  }

  Future<RESPONSE> query<RESPONSE extends IHederaQueryRespone>({
    required IHederaQuery<RESPONSE> query,
  }) async {
    var q = query;
    if (q.header == null) {
      final payment = await buildQueryPaymentTx(query: q);
      q = q.copyWith(
        header: HederaQueryHeader(
          payment: payment,
          responseType: HederaResponseType.answerOnly,
        ),
      );
    }
    return await _getProvider().request(HederaGrpcRequestQuery(q));
  }

  Future<List<int>> queryNodeFileContents(HederaFileID id) async {
    final contents = await query(query: HederaFileGetContentsQuery(fileID: id));
    return contents.fileContents?.contents ?? [];
  }

  Future<HederaAccountBalanceSnapshot> getNodeBalance(
    HederaAddress account,
  ) async {
    final balance = await query(
      query: HederaCryptoGetAccountBalanceQuery(
        accountID: account.toAccoutId(),
      ),
    );
    return HederaAccountBalanceSnapshot(
      tokens:
          balance.tokenBalances.map((e) {
            final id = e.tokenId;
            if (id == null) {
              throw OnChainErrors.hederaPlugin(
                "getNodeBalance",
                reason: "Missing token ID in balance entry.",
              );
            }
            return HederaAccountTokenSnapshot(
              tokenId: HederaAddress.fromTokenId(id),
              balance: e.balance ?? BigInt.zero,
            );
          }).toList(),
      balance: balance.balance ?? BigInt.zero,
    );
  }

  Future<HederaCryptoGetInfoResponse> getNodeAccount({
    required HederaAddress account,
  }) {
    return query(
      query: HederaCryptoGetInfoQuery(accountID: account.toAccoutId()),
    );
  }

  Future<HederaTransactionGetReceiptResponse> getNodeTransactionReceipt({
    required HederaTransactionID transactionId,
    bool includeDuplicates = false,
    bool includeChildReceipts = false,
  }) {
    return query(
      query: HederaTransactionGetReceiptQuery(
        transactionID: transactionId,
        includeDuplicates: includeDuplicates,
        includeChildReceipts: includeChildReceipts,
      ),
    );
  }

  Future<HederaContractGetInfoResponse> getNodeContract({
    required HederaContractID contractId,
  }) {
    return query(query: HederaContractGetInfoQuery(contractID: contractId));
  }

  Future<HederaTokenGetInfoResponse> getNodeToken({
    required HederaTokenID tokenId,
  }) {
    return query(query: HederaTokenGetInfoQuery(token: tokenId));
  }

  Future<HederaConsensusGetTopicInfoResponse> getNodeTopic({
    required HederaTopicID topicId,
  }) {
    return query(query: HederaConsensusGetTopicInfoQuery(topicID: topicId));
  }

  /// Local contract call on the consensus node (ContractCallLocalQuery).
  Future<HederaContractCallLocalResponse> getNodeContractCall({
    required HederaContractID contractId,
    HederaAccountID? senderId,
    required List<int> functionParameters,
    BigInt? gas,
    BigInt? maxResultSize,
  }) {
    return query(
      query: HederaContractCallLocalQuery(
        contractID: contractId,
        functionParameters: functionParameters,
        gas: gas,
        maxResultSize: maxResultSize,
        senderId: senderId,
      ),
    );
  }
}
mixin HederaQuickNodeApi on HederaQuickQueryApi {
  /// Submit a signed transaction to the consensus node (CryptoService).
  Future<HederaTransactionResponse> submitTransaction({
    required HederaTransaction transaction,
    required HederaTransactionBody body,
  }) async {
    return _getProvider().request(
      HederaGrpcRequestMessage(
        request: HederaClientUtils.hederaServiceMessageForTransaction(
          transaction: transaction,
          body: body,
        ),
      ),
    );
  }

  /// Submit and poll until a receipt is available (or timeout).
  ///
  /// Uses node [getNodeTransactionReceipt] by default. Set [useMirror] to also
  /// try mirror REST if node receipt is not yet available.
  Future<HederaSubmitResult> submitTransactionAndWait({
    required HederaTransaction transaction,
    required HederaTransactionID transactionId,
    required HederaTransactionBody body,
    Duration timeout = const Duration(seconds: 60),
    Duration pollInterval = const Duration(milliseconds: 500),
    bool useMirrorFallback = true,
  }) async {
    final submit = await submitTransaction(
      transaction: transaction,
      body: body,
    );

    // Immediate node precheck failure
    final nodeStatus = submit.nodeTransactionPrecheckCode;
    if (nodeStatus != null &&
        nodeStatus != HederaResponseCodeEnum.ok &&
        nodeStatus != HederaResponseCodeEnum.success) {
      return HederaSubmitResult(
        submitResponse: submit,
        transactionId: transactionId,
        success: false,
      );
    }

    final deadline = DateTime.now().toUtc().add(timeout);
    HederaTransactionReceipt? receipt;
    String? mirrorResult;

    while (DateTime.now().toUtc().isBefore(deadline)) {
      try {
        final resp = await getNodeTransactionReceipt(
          transactionId: transactionId,
        );
        receipt = resp.receipt;
        final status = receipt?.status;
        if (status != null &&
            status != HederaResponseCodeEnum.unknown &&
            status != HederaResponseCodeEnum.receiptNotFound) {
          final ok = status == HederaResponseCodeEnum.success;
          return HederaSubmitResult(
            submitResponse: submit,
            receipt: receipt,
            transactionId: transactionId,
            success: ok,
          );
        }
      } catch (_) {
        // keep polling
      }

      if (useMirrorFallback && this is HederaQuickMirrorApi) {
        try {
          final mirror = this as HederaQuickMirrorApi;
          final tx = await mirror.getMirrorTransaction(
            transactionId: transactionId.toTxId(),
          );
          final list = tx.transactions;
          final first = (list != null && list.isNotEmpty) ? list.first : null;
          if (first?.result != null) {
            mirrorResult = first!.result;
            final ok = mirrorResult == 'SUCCESS';
            if (ok || _isFinalMirrorResult(mirrorResult)) {
              return HederaSubmitResult(
                submitResponse: submit,
                receipt: receipt,
                transactionId: transactionId,
                mirrorResult: mirrorResult,
                success: ok,
              );
            }
          }
        } catch (_) {}
      }

      await Future<void>.delayed(pollInterval);
    }

    return HederaSubmitResult(
      submitResponse: submit,
      receipt: receipt,
      transactionId: transactionId,
      mirrorResult: mirrorResult,
      success: false,
    );
  }

  static bool _isFinalMirrorResult(String? result) {
    if (result == null) return false;
    const pending = {'UNKNOWN', 'RECEIPT_NOT_FOUND', 'RECORD_NOT_FOUND'};
    return !pending.contains(result);
  }
}

extension ExtHederaTransactionID on HederaTransactionID? {
  String toTxId() {
    final id = this;
    if (id == null) return "0.0.0-0.0";
    final a = id.accountID;
    final start = id.transactionValidStart;
    final account =
        '${a?.shardNum ?? 0}.${a?.realmNum ?? 0}.${a?.accountNum ?? 0}';
    final seconds = start?.seconds ?? BigInt.zero;
    final nanos = start?.nanos ?? 0;
    return '$account-$seconds-$nanos';
  }
}
