import 'dart:async';

import 'package:blockchain_utils/blockchain_utils.dart';
import 'package:on_chain/exception/onchain_error.dart';
import 'package:on_chain/hedera/src/address/src/address.dart';
import 'package:on_chain/hedera/src/address/src/utils.dart';
import 'package:on_chain/hedera/src/proto_messages/proto/models.dart';
import 'package:on_chain/hedera/src/rpc/rpc.dart';
import 'package:on_chain/solidity/contract/contract_abi.dart';

mixin HederaQuickMirrorApi {
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
    return switch (strategy.mirror) {
      null =>
        throw OnChainErrors.hederaPlugin(
          "HederaQuickMirrorApi",
          reason: 'Mirror access disabled by client strategy.',
        ),
      _ => internalProvider,
    };
  }

  HederaClientSterategy get strategy;
  Future<T> mirrorRequest<T>(HederaMirrorRequest<T, Map<String, dynamic>> req) {
    return _getProvider().request(req);
  }

  Future<HederaMirrorTypesAccountBalanceTransactions> getMirrorAccount(
    HederaAddress account, {
    bool? transactions,
    int? limit,
  }) {
    return mirrorRequest(
      HederaMirrorRequestGetAccount(
        idOrAliasOrEvmAddress: account.toMirrorEntityId(),
        transactions: transactions,
        limit: limit,
      ),
    );
  }

  Future<HederaMirrorTypesNetworkFeesResponse> mirrorGetFees() async {
    return await mirrorRequest(HederaMirrorRequestGetNetworkFees());
  }

  Future<HederaExchangeRateSet> getMirrorExchangeRateSet() async {
    final result = await mirrorRequest(
      HederaMirrorRequestGetNetworkExchangeRate(),
    );
    return HederaExchangeRateSet(
      currentRate: HederaExchangeRate(
        centEquiv: result.currentRate?.centEquivalent,
        hbarEquiv: result.currentRate?.hbarEquivalent,
        expirationTime: HederaTimestampSeconds(
          seconds: result.currentRate?.expirationTime,
        ),
      ),
      nextRate: HederaExchangeRate(
        centEquiv: result.nextRate?.centEquivalent,
        hbarEquiv: result.nextRate?.hbarEquivalent,
        expirationTime: HederaTimestampSeconds(
          seconds: result.currentRate?.expirationTime,
        ),
      ),
    );
  }

  Future<HederaMirrorTypesAccountsResponse> listMirrorAccounts({
    String? accountId,
    int? limit,
    bool? balance,
  }) {
    return mirrorRequest(
      HederaMirrorRequestGetAccounts(
        accountId: accountId,
        limit: limit,
        balance: balance,
      ),
    );
  }

  // ── Tokens ───────────────────────────────────────────────────────────────

  Future<HederaMirrorTypesTokenInfo> getMirrorToken(HederaTokenID id) {
    return mirrorRequest(
      HederaMirrorRequestGetToken(
        tokenId: HederaAddrUtils.normalizeTokenId(id),
      ),
    );
  }

  // ── Topics ───────────────────────────────────────────────────────────────

  Future<HederaMirrorTypesTopic> getMirrorTopic(HederaTopicID id) {
    return mirrorRequest(
      HederaMirrorRequestGetTopic(
        topicId: HederaAddrUtils.normalizeTopicId(id),
      ),
    );
  }

  Future<HederaMirrorTypesTopicMessagesResponse> getMirrorTopicMessages(
    String topicId, {
    int? limit,
    int? sequencenumber,
  }) {
    return mirrorRequest(
      HederaMirrorRequestGetTopicMessages(
        topicId: topicId,
        limit: limit,
        sequencenumber: sequencenumber,
      ),
    );
  }

  // ── Transactions ─────────────────────────────────────────────────────────

  Future<HederaMirrorTypesTransactionByIdResponse> getMirrorTransaction({
    required String transactionId,
    int? nonce,
    bool? scheduled,
  }) {
    return mirrorRequest(
      HederaMirrorRequestGetTransaction(
        transactionId: transactionId,
        nonce: nonce,
        scheduled: scheduled,
      ),
    );
  }

  Future<HederaAccountBalanceSnapshot> getMirrorBalance(
    HederaAddress account,
  ) async {
    final accintData = await getMirrorAccount(account);
    return HederaAccountBalanceSnapshot(
      tokens:
          accintData.balance?.tokens.map((e) {
            final id = e.tokenId;
            if (id == null) {
              throw OnChainErrors.hederaPlugin(
                "getMirrorBalance",
                reason: "Missing token ID in balance entry.",
              );
            }
            return HederaAccountTokenSnapshot(
              tokenId: HederaAddress(id),
              balance: e.balance ?? BigInt.zero,
            );
          }).toList() ??
          [],
      balance: accintData.balance?.balance ?? BigInt.zero,
    );
  }

  // ── Contracts ────────────────────────────────────────────────────────────

  Future<HederaMirrorTypesContractResponse> getMirrorContract(
    HederaAddress contract,
  ) {
    return mirrorRequest(
      HederaMirrorRequestGetContract(
        contractIdOrAddress: contract.toMirrorEntityId(),
      ),
    );
  }

  /// Mirror eth_call-style contract execution.
  ///
  /// [to] / [from] are [HederaAddress] (numeric, long-zero, or EVM alias).
  /// Converted to EVM hex only at the REST boundary via [HederaAddress.toMirrorEvmHex].
  ///
  /// Set [estimate] to `true` for gas estimation (result is gas as hex).
  Future<HederaContractCallResult> mirrorContractCall({
    required HederaAddress to,
    String? data,
    HederaAddress? from,
    bool estimate = false,
    BigInt? gas,
    BigInt? gasPrice,
    BigInt? value,
    String? block,
  }) async {
    final response = await mirrorRequest(
      HederaMirrorRequestContractCall(
        requestBody: HederaMirrorTypesContractCallRequest(
          to: to.toMirrorEvmHex(),
          data: data,
          from: from?.toMirrorEvmHex(),
          estimate: estimate,
          gas: gas,
          gasPrice: gasPrice,
          value: value,
          block: block,
        ),
      ),
    );

    BigInt? gasEstimate;
    if (estimate && response.result != null) {
      gasEstimate = BigintUtils.parse(response.result);
    }
    String? result;
    if (!estimate && response.result != null) {
      result = StringUtils.strip0x(response.result ?? '');
      if (result.isEmpty) result = null;
    }

    return HederaContractCallResult(
      resultHex: result,
      gasEstimate: gasEstimate ?? BigInt.zero,
      mirrorResponse: response,
    );
  }

  /// ABI-friendly gas estimate.
  Future<HederaContractCallResult> estimateContractGasWithAbi({
    required HederaAddress to,
    required ContractABI abi,
    required String functionName,
    required List<dynamic> params,
    HederaAddress? from,
    BigInt? value,
  }) async {
    final func = abi.functionFromName(functionName);
    final encoded = func.encode(params);
    final result = await mirrorContractCall(
      to: to,
      data: BytesUtils.toHexString(encoded, prefix: "0x"),
      from: from,
      value: value,
    );
    final contractResult = result.resultHex;
    if (func.outputs.isNotEmpty && contractResult != null) {
      return result.copyWith(
        result: func.decodeOutput(BytesUtils.fromHexString(contractResult)),
      );
    }
    return result;
  }

  /// ABI-friendly contract call (returns decoded outputs when possible).
  Future<HederaContractCallResult> mirrorContractCallWithAbi({
    required HederaAddress to,
    required ContractABI abi,
    required String functionName,
    required List<dynamic> params,
    HederaAddress? from,
    BigInt? gas,
    BigInt? value,
    bool estimate = false,
  }) {
    final encoded = abi.functionFromName(functionName).encode(params);
    return mirrorContractCall(
      to: to,
      data: BytesUtils.toHexString(encoded, prefix: "0x"),
      from: from,
      gas: gas,
      value: value,
      estimate: estimate,
    );
  }

  Future<HederaMirrorTypesNetworkFeesResponse> getMirrorNetworkFees() {
    return mirrorRequest(const HederaMirrorRequestGetNetworkFees());
  }

  Future<HederaMirrorTypesNetworkSupplyResponse> getMirrorNetworkSupply() {
    return mirrorRequest(const HederaMirrorRequestGetNetworkSupply());
  }
}
