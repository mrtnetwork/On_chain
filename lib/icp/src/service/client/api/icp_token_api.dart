import 'package:blockchain_utils/blockchain_utils.dart';

import 'package:on_chain/exception/onchain_error.dart';
import 'package:on_chain/icp/src/address/address.dart';
import 'package:on_chain/icp/src/crypto/utils/utils.dart';
import 'package:on_chain/icp/src/did/icrc10/src/queries.dart';
import 'package:on_chain/icp/src/did/icrc2/src/types.dart';
import 'package:on_chain/icp/src/did/icrc2/src/updates.dart';
import 'package:on_chain/icp/src/did/icrc7/src/types.dart';
import 'package:on_chain/icp/src/did/icrc7/src/updates.dart';
import 'package:on_chain/icp/src/did/ledger/src/queries.dart';
import 'package:on_chain/icp/src/did/ledger/src/types.dart';
import 'package:on_chain/icp/src/did/ledger/src/updates.dart';
import 'package:on_chain/icp/src/did/nnsgovernance/src/queries.dart';
import 'package:on_chain/icp/src/did/nnsgovernance/src/types.dart';
import 'package:on_chain/icp/src/did/nnsgovernance/src/updates.dart';
import 'package:on_chain/icp/src/rpc/methods/methods/call.dart';
import 'package:on_chain/icp/src/rpc/methods/methods/read_state.dart';
import 'package:on_chain/icp/src/rpc/types/params.dart';
import 'package:on_chain/icp/src/rpc/types/types.dart';
import 'package:on_chain/icp/src/service/client/api/icp_icrc.dart';
import 'package:on_chain/icp/src/service/client/api/icp_quick_api.dart';
import 'package:on_chain/icp/src/service/client/constants/constants.dart';
import 'package:on_chain/icp/src/service/client/types/types.dart';
import 'package:on_chain/icp/src/service/core/service.dart';
import 'package:on_chain/icp/src/service/core/raw_update.dart';
import 'package:on_chain/icp/src/service/http/types/icp_http_content.dart';
import 'package:on_chain/icp/src/service/http/types/icp_http_envelope.dart';

/// Unified transaction status for block-index lookups (wallet
/// `WalletTransactionStatus` parity for the ICP cases).
enum IcpTxStatus {
  /// The block index resolves to blocks.
  block,

  /// The block index resolves to nothing yet.
  pending,
}

/// ICRC-1 token metadata (wallet `fetchTokenMetadata` parity without the
/// wallet `Token` wrapper).
class Icrc1TokenMetadata {
  final String name;
  final String symbol;
  final int decimals;
  const Icrc1TokenMetadata({
    required this.name,
    required this.symbol,
    required this.decimals,
  });
}

/// Token-level ICP reads and message builders over [ICPQuickApi] +
/// [ICPQuickQueryApi]. Consumers mix this in alongside those two (as
/// [ICPClientDefault] does).
///
/// Error contract: reads throw on transport failure; only the documented
/// probe fallbacks apply — `fetchSupportedStandards` maps replica-level
/// rejections ([BuError]) to empty, unknown ICRC-7 ids read as null
/// naturally. Malformed data is never mistaken for absence.
mixin ICPTokenQuickApi on ICPQuickApi, ICPQuickQueryApi {
  /// Native ledger balance of [address].
  Future<BigInt> getAccountBalance(BaseIcpAddress address) {
    return getLedgerAccountBalance(address);
  }

  /// ICRC-1 `balance_of` of [owner] at [canister]. Transport failures
  /// throw (a zero balance reads as zero from the ledger, never as an
  /// error mapping).
  Future<BigInt> getIcrc1Balance({
    required IcpPrincipalAddress canister,
    required IcpPrincipalAddress owner,
  }) {
    return getIcrc1LedgerIcrc1BalanceOf(
      IcpPrincipalAddressWithSubId(owner),
      canisterId: canister,
    );
  }

  /// ICRC-10 supported-standards probe: which ICRC standards [canister]
  /// advertises. Replica-level rejections (pre-ICRC-10 or non-compliant
  /// canisters) read as unknown (empty); transport failures rethrow, and
  /// callers fall back to what they verified by use.
  Future<List<String>> fetchSupportedStandards(
    IcpPrincipalAddress canister,
  ) async {
    try {
      final standards = await query(
        message: const ICRC10QueryIcrc10SupportedStandards(),
        canisterId: canister,
      );
      return standards.map((e) => e.name).toSet().toList();
    } on BuError {
      return [];
    }
  }

  /// ICRC-7 token owner: null when [tokenId] is unknown or the collection
  /// cannot be read as an opt-null. Transport failures and traps throw.
  Future<ICRC7Account?> getIcrc7TokenOwner({
    required IcpPrincipalAddress canister,
    required BigInt tokenId,
  }) async {
    final owners = await getIcrc7OwnerOf(canisterId: canister, ids: [tokenId]);
    if (owners.isEmpty) return null;
    return owners.first;
  }

  /// Native ledger transfer fee.
  Future<BigInt> getNativeTransferFee() {
    return getLedgerTransferFee();
  }

  /// ICRC-1 `icrc1_fee` of [canister].
  Future<BigInt> getIcrc1Fee(IcpPrincipalAddress canister) {
    return getIcrc1LedgerIcrc1Fee(canisterId: canister);
  }

  /// Minimum neuron stake in e8s.
  Future<BigInt> getNeuronMinimumStake() async {
    final economics = await query(
      message: const NnsGovernanceQueryGetNetworkEconomicsParameters(),
      canisterId: ICPNetworkConfig.governanceCanisterId,
    );
    return economics.neuronMinimumStakeE8s;
  }

  /// ICRC-1 `name`/`symbol`/`decimals` of [canister] as one record.
  /// Transport failures throw.
  Future<Icrc1TokenMetadata> getIcrc1TokenMetadata(
    IcpPrincipalAddress canister,
  ) async {
    final name = await getIcrc1Name(canisterId: canister);
    final symbol = await getIcrc1Symbol(canisterId: canister);
    final decimals = await getIcrc1Decimals(canisterId: canister);
    return Icrc1TokenMetadata(name: name, symbol: symbol, decimals: decimals);
  }

  /// Block-index status: block when [index] resolves to blocks, pending
  /// otherwise. Transport failures throw.
  Future<IcpTxStatus> getBlockTxStatus(BigInt index) async {
    final response = await query(
      message: LEDGERQueryQueryBlocks(
        LEDGERGetBlocksArgs(start: index, length: BigInt.one),
      ),
      canisterId: ICPNetworkConfig.defaultConfig.ledgerCanisterId,
    );
    if (response.blocks.isNotEmpty) return IcpTxStatus.block;
    return IcpTxStatus.pending;
  }

  /// Message builders (pure: no provider use). They centralize every
  /// transfer/approve/stake payload encoding previously inlined across
  /// wallet transaction types.

  /// Native ledger transfer content.
  Future<
    ({
      LEDGERUpdateTransfer message,
      ICPRequestCallParams params,
      ICPHttpContent content,
    })
  >
  buildTransferContent({
    required BaseIcpAddress to,
    required BigInt amount,
    required IcpPrincipalAddress sender,
    required ICPRequestCallParams params,
    List<int>? senderSubaccount,
    int? fee,
  }) async {
    final ledger = ICPNetworkConfig.defaultConfig.ledgerCanisterId;
    final message = LEDGERUpdateTransfer(
      LEDGERTransferArgs(
        memo: BigInt.zero,
        amount: LEDGERTokens(e8s: amount),
        fee: LEDGERTokens(
          e8s: BigInt.from(fee ?? AgentConstants.defaultLedgerTransferFee),
        ),
        to: to.toAccountIdentifier().toBytes(),
        fromSubaccount: senderSubaccount,
        createdAtTime: null,
      ),
    );
    final content = message.generateContent(
      canisterId: ledger,
      ingressExpiry: params.ingressExpiry,
      nonce: params.getNonce(),
      sender: sender,
    );
    return (message: message, params: params, content: content);
  }

  /// ICRC-1 transfer content for [canister].
  Future<
    ({
      LEDGERUpdateIcrc1Transfer message,
      ICPRequestCallParams params,
      ICPHttpContent content,
    })
  >
  buildIcrc1TransferContent({
    required IcpPrincipalAddress canister,
    required IcpPrincipalAddress to,
    required BigInt amount,
    required IcpPrincipalAddress sender,
    required ICPRequestCallParams params,
    BigInt? fee,
  }) async {
    final message = LEDGERUpdateIcrc1Transfer(
      LEDGERTransferArg(to: LEDGERAccount(owner: to), amount: amount, fee: fee),
    );
    final content = message.generateContent(
      canisterId: canister,
      ingressExpiry: params.ingressExpiry,
      nonce: params.getNonce(),
      sender: sender,
    );
    return (message: message, params: params, content: content);
  }

  /// ICRC-7 transfer content for [tokenId] at [canister].
  Future<
    ({
      ICRC7UpdateIcrc7Transfer message,
      ICPRequestCallParams params,
      ICPHttpContent content,
    })
  >
  buildIcrc7TransferContent({
    required IcpPrincipalAddress canister,
    required IcpPrincipalAddress to,
    required BigInt tokenId,
    required ICPRequestCallParams params,
    required IcpPrincipalAddress sender,
  }) async {
    final message = ICRC7UpdateIcrc7Transfer([
      ICRC7TransferArg(to: ICRC7Account(owner: to), tokenId: tokenId),
    ]);
    final content = message.generateContent(
      canisterId: canister,
      ingressExpiry: params.ingressExpiry,
      nonce: params.getNonce(),
      sender: sender,
    );
    return (message: message, params: params, content: content);
  }

  /// ICRC-2 approve content for [spender] at [canister].
  Future<
    ({
      ICRC2UpdateIcrc2Approve message,
      ICPRequestCallParams params,
      ICPHttpContent content,
    })
  >
  buildIcrc2ApproveContent({
    required IcpPrincipalAddress canister,
    required IcpPrincipalAddress spender,
    required BigInt amount,
    required IcpPrincipalAddress sender,
    required ICPRequestCallParams params,
    BigInt? fee,
  }) async {
    final message = ICRC2UpdateIcrc2Approve(
      ICRC2ApproveArgs(
        spender: ICRC2Account(owner: spender),
        amount: amount,
        fee: fee,
      ),
    );
    final content = message.generateContent(
      canisterId: canister,
      ingressExpiry: params.ingressExpiry,
      nonce: params.getNonce(),
      sender: sender,
    );
    return (message: message, params: params, content: content);
  }

  /// Neuron staking subaccount for ([controller], [nonce]).
  List<int> neuronStakingSubaccount({
    required IcpPrincipalAddress controller,
    required BigInt nonce,
  }) {
    final data = <int>[
      0x0c,
      ...StringUtils.encode('neuron-stake'),
      ...controller.toBytes(),
      ...BigintUtils.toBytes(nonce, length: 8),
    ];
    return QuickCrypto.sha256Hash(data);
  }

  /// Governance account identifier staking for ([controller], [nonce]).
  IcpAccountIdentifier neuronAccountIdentifier({
    required IcpPrincipalAddress controller,
    required BigInt nonce,
  }) {
    return ICPNetworkConfig.governanceCanisterId.toAccountIdentifier(
      subaccount: neuronStakingSubaccount(controller: controller, nonce: nonce),
    );
  }

  /// Stake transfer content (ledger transfer with [memo] to raw [to]).
  Future<
    ({
      LEDGERUpdateTransfer message,
      ICPRequestCallParams params,
      ICPHttpContent content,
    })
  >
  buildStakeTransferContent({
    required List<int> to,
    required BigInt amount,
    required BigInt memo,
    required IcpPrincipalAddress sender,
    required ICPRequestCallParams params,
    int? fee,
  }) async {
    final ledger = ICPNetworkConfig.defaultConfig.ledgerCanisterId;
    final message = LEDGERUpdateTransfer(
      LEDGERTransferArgs(
        memo: memo,
        amount: LEDGERTokens(e8s: amount),
        fee: LEDGERTokens(
          e8s: BigInt.from(fee ?? AgentConstants.defaultLedgerTransferFee),
        ),
        to: to,
        fromSubaccount: null,
        createdAtTime: null,
      ),
    );
    final content = message.generateContent(
      canisterId: ledger,
      ingressExpiry: params.ingressExpiry,
      nonce: params.getNonce(),
      sender: sender,
    );
    return (message: message, params: params, content: content);
  }

  /// Claim-or-refresh-neuron content for ([controller], [memo]).
  Future<
    ({
      NnsGovernanceUpdateClaimOrRefreshNeuronFromAccount message,
      ICPRequestCallParams params,
      ICPHttpContent content,
    })
  >
  buildClaimNeuronContent({
    required IcpPrincipalAddress controller,
    required BigInt memo,
    required ICPRequestCallParams params,
    required IcpPrincipalAddress sender,
  }) async {
    final governance = ICPNetworkConfig.governanceCanisterId;
    final message = NnsGovernanceUpdateClaimOrRefreshNeuronFromAccount(
      NnsGovernanceClaimOrRefreshNeuronFromAccount(
        controller: controller,
        memo: memo,
      ),
    );
    final content = message.generateContent(
      canisterId: governance,
      ingressExpiry: params.ingressExpiry,
      nonce: params.getNonce(),
      sender: sender,
    );
    return (message: message, params: params, content: content);
  }

  /// Raw update-call content for arbitrary ([method], [arg]) calls.
  Future<
    ({
      RawIcpUpdateCall message,
      ICPRequestCallParams params,
      ICPHttpContent content,
    })
  >
  buildRawCallContent({
    required IcpPrincipalAddress canister,
    required IcpPrincipalAddress sender,
    required ICPRequestCallParams params,
    required String method,
    required List<int> arg,
    List<int>? nonce,
  }) async {
    final message = RawIcpUpdateCall(methodName: method, arg: arg);
    final content = message.generateContent(
      canisterId: canister,
      ingressExpiry: params.ingressExpiry,
      nonce: nonce ?? params.getNonce(),
      sender: sender,
    );
    return (message: message, params: params, content: content);
  }

  /// Content digest for signing.
  List<int> contentDigest(ICPHttpContent content) {
    return ICPCryptoUtils.signContent(content);
  }

  /// Assembles signed content from [content], a DER [senderPubkeyDer] and
  /// [signature].
  ICPRequestContent assembleSignedContent({
    required ICPHttpContent content,
    required List<int> senderPubkeyDer,
    required List<int> signature,
  }) {
    return ICPRequestContent(
      content: content,
      envelope: ICPHttpEnvelope(
        content: content,
        senderPubkey: senderPubkeyDer,
        senderSig: signature,
      ),
      id: ICPCryptoUtils.hashContent(content),
    );
  }

  /// Polls a ledger transfer until its block index lands, returning it.
  /// Rejections and timeouts throw [BuError].
  Future<String> waitForLedgerBlockIndex({
    required LEDGERUpdateTransfer message,
    required ICPRequestCallParams params,
    required List<int> requestId,
    Duration timeout = const Duration(seconds: 60),
  }) async {
    ICPDecodedCallResponse<LEDGERTransferResult> result = await provider
        .request(
          ICPRequestCanisterReadStateCall(
            requestId: requestId,
            message: message,
            params: params,
          ),
        )
        .then((r) => r.getResult(requestId: requestId, message: message));
    final deadline = DateTime.now().toUtc().add(timeout);
    while (DateTime.now().toUtc().isBefore(deadline)) {
      switch (result) {
        case ICPDecodedCallRepliedWithResult(:final result):
          switch (result) {
            case LEDGERTransferResultOk(:final value):
              return value.toString();
            case LEDGERTransferResultErr(:final value):
              throw OnChainErrors.icpClient(
                'waitForLedgerBlockIndex',
                reason: 'Ledger transfer rejected by ledger.',
                details: {'error': '${value.toJson()}'},
              );
          }
        case ICPDecodedCallNonReplicatedRejection():
        case ICPDecodedCallDone():
          throw OnChainErrors.icpClient(
            'waitForLedgerBlockIndex',
            reason: 'Ledger transfer rejected before reply was read.',
          );
        case ICPDecodedCallReplied():
        case ICPDecodedCallAccepted():
        case ICPDecodedCallUnknown():
          break;
      }
      await Future<void>.delayed(const Duration(milliseconds: 500));
      params = ICPRequestCallParams(
        canisterId: params.canisterId,
        sender: params.sender,
      );
      result = await provider
          .request(
            ICPRequestCanisterReadStateCall(
              requestId: requestId,
              message: message,
              params: params,
            ),
          )
          .then((r) => r.getResult(requestId: requestId, message: message));
    }
    throw OnChainErrors.icpClient(
      'waitForLedgerBlockIndex',
      reason: 'Timed out waiting for ledger block index.',
      details: {'timeout': '$timeout'},
    );
  }

  /// Submits a pre-signed raw call and polls until its certificate lands,
  /// returning the content map and certificate bytes. Rejections and
  /// timeouts throw [BuError].
  Future<({List<int> contentMap, List<int> certificate})> submitSignedRawCall({
    required IICPUpdateMessage message,
    required ICPRequestCallParams params,
    required ICPRequestContent content,
    Duration timeout = const Duration(seconds: 60),
  }) async {
    final response = await provider.request(
      ICPRequestCanisterCall(
        message: message,
        params: params,
        content: content,
      ),
    );
    final requestId = content.id ?? const [];
    ICPDecodedCallResponse<dynamic> result = response.getResult(
      requestId: requestId,
      message: message,
    );
    final deadline = DateTime.now().toUtc().add(timeout);
    while (DateTime.now().toUtc().isBefore(deadline)) {
      switch (result) {
        case ICPDecodedCallRepliedWithResult(:final certificate):
          return (
            contentMap: content.content.toCborMap().encode(),
            certificate: certificate.certificate.toCbor().encode(),
          );
        case ICPDecodedCallNonReplicatedRejection():
          throw OnChainErrors.icpClient(
            'submitSignedRawCall',
            reason: 'Call request rejected.',
          );
        case ICPDecodedCallDone():
          throw OnChainErrors.icpClient(
            'submitSignedRawCall',
            reason: 'Call reply pruned before reading.',
          );
        case ICPDecodedCallReplied():
        case ICPDecodedCallAccepted():
        case ICPDecodedCallUnknown():
          break;
      }
      await Future<void>.delayed(const Duration(milliseconds: 500));
      params = ICPRequestCallParams(
        canisterId: params.canisterId,
        sender: params.sender,
      );
      result = await provider
          .request(
            ICPRequestCanisterReadStateCall(
              requestId: requestId,
              message: message,
              params: params,
            ),
          )
          .then((r) => r.getResult(requestId: requestId, message: message));
    }
    throw OnChainErrors.icpClient(
      'submitSignedRawCall',
      reason: 'Timed out waiting for call certificate.',
      details: {'timeout': '$timeout'},
    );
  }
}
