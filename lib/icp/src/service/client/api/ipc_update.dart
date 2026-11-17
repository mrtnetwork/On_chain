import 'package:blockchain_utils/blockchain_utils.dart';
import 'package:on_chain/icp/src/address/address.dart';
import 'package:on_chain/icp/src/did/ledger/src/types.dart';
import 'package:on_chain/icp/src/did/ledger/src/updates.dart';
import 'package:on_chain/icp/src/did/nnscyclesminting/src/types.dart';
import 'package:on_chain/icp/src/did/nnscyclesminting/src/updates.dart';
import 'package:on_chain/icp/src/rpc/types/params.dart';
import 'package:on_chain/icp/src/service/core/service.dart';
import 'package:on_chain/icp/src/service/client/constants/constants.dart';
import 'package:on_chain/icp/src/service/client/types/types.dart';

mixin ICPUpdateQuickApi {
  ICPNetworkConfig get networkConfig;
  Future<RESULT> callWithResult<RESULT>({
    required IICPUpdateMessage<RESULT> message,
    required IcpPrincipalAddress sender,
    required IcpPrincipalAddress canisterId,
    Duration timeout = const Duration(seconds: 60),
    Duration pollInterval = const Duration(seconds: 1),
    ICPRequestCallParams? params,
    IcpPrincipalAddress? effectiveCanisterId,
  });

  Future<LEDGERTransferResult> ledgerTransfer({
    required BaseIcpAddress to,
    required BigInt amount,
    required IcpPrincipalAddressWithSubId sender,
    IcpPrincipalAddress? canisterId,
    int? fee,
    BigInt? memo,
    BigInt? createdAtNanos,
    ICPRequestCallParams? params,
  }) async {
    return await callWithResult(
      message: LEDGERUpdateTransfer(
        LEDGERTransferArgs(
          memo: memo ?? BigInt.zero,
          amount: LEDGERTokens(e8s: amount),
          fee: LEDGERTokens(
            e8s: BigInt.from(fee ?? AgentConstants.defaultLedgerTransferFee),
          ),
          to: to.toAccountIdentifier().toBytes(),
          fromSubaccount: sender.subaccountId,
          createdAtTime:
              createdAtNanos == null
                  ? null
                  : LEDGERTimeStamp(timestampNanos: createdAtNanos),
        ),
      ),
      sender: sender.address,

      canisterId: canisterId ?? networkConfig.ledgerCanisterId,
      params: params,
    );
  }

  Future<LEDGERIcrc1TransferResult> icrc1Transfer({
    required IcpPrincipalAddressWithSubId to,
    required BigInt amount,
    required IcpPrincipalAddressWithSubId sender,
    IcpPrincipalAddress? canisterId,
    int? fee,
    List<int>? memo,
    BigInt? createdAtTime,
    ICPRequestCallParams? params,
  }) async {
    return await callWithResult(
      message: LEDGERUpdateIcrc1Transfer(
        LEDGERTransferArg(
          memo: memo,
          amount: amount,
          fee: fee?.toBigInt,
          to: LEDGERAccount(owner: to.address, subaccount: to.subaccountId),
          fromSubaccount: sender.subaccountId,
          createdAtTime: createdAtTime,
        ),
      ),
      sender: sender.address,
      canisterId: canisterId ?? networkConfig.ledgerCanisterId,
      params: params,
    );
  }

  Future<LEDGERApproveResult> icrc2Approve({
    required IcpPrincipalAddressWithSubId spender,
    required BigInt amount,
    required IcpPrincipalAddressWithSubId sender,
    IcpPrincipalAddress? canisterId,
    BigInt? expectedAllowance,
    BigInt? expiresAt,
    BigInt? createdAtTime,
    int? fee,
    List<int>? memo,
    ICPRequestCallParams? params,
  }) async {
    return await callWithResult(
      message: LEDGERUpdateIcrc2Approve(
        LEDGERApproveArgs(
          memo: memo,
          amount: amount,
          fee: fee?.toBigInt,
          fromSubaccount: sender.subaccountId,
          createdAtTime: createdAtTime,
          expiresAt: expiresAt,
          expectedAllowance: expectedAllowance,

          spender: LEDGERAccount(
            owner: spender.address,
            subaccount: spender.subaccountId,
          ),
        ),
      ),
      sender: sender.address,
      canisterId: canisterId ?? networkConfig.ledgerCanisterId,
      params: params,
    );
  }

  Future<LEDGERTransferFromResult> icrc2TransferFrom({
    required BigInt amount,
    required IcpPrincipalAddressWithSubId from,
    required IcpPrincipalAddressWithSubId to,
    required IcpPrincipalAddressWithSubId sender,

    IcpPrincipalAddress? canisterId,
    BigInt? expectedAllowance,
    BigInt? expiresAt,
    BigInt? createdAtTime,
    int? fee,
    List<int>? memo,
    ICPRequestCallParams? params,
  }) async {
    return await callWithResult(
      message: LEDGERUpdateIcrc2TransferFrom(
        LEDGERTransferFromArgs(
          memo: memo,
          amount: amount,
          fee: fee?.toBigInt,
          to: LEDGERAccount(owner: to.address, subaccount: to.subaccountId),
          from: LEDGERAccount(
            owner: from.address,
            subaccount: from.subaccountId,
          ),
          createdAtTime: createdAtTime,
        ),
      ),
      sender: sender.address,
      canisterId: canisterId ?? networkConfig.ledgerCanisterId,
      params: params,
    );
  }

  Future<NnsCyclesMintingNotifyCreateCanisterResult>
  cyclesMintingNotifyCreateCanister({
    required IcpPrincipalAddressWithSubId sender,
    required BigInt blockIndex,
    required IcpPrincipalAddress controller,
    String? subnetType,
    NnsCyclesMintingSubnetSelection? subnetSelection,
    NnsCyclesMintingCanisterSettings? settings,
    IcpPrincipalAddress? canisterId,
    ICPRequestCallParams? params,
  }) async {
    return await callWithResult(
      message: NnsCyclesMintingUpdateNotifyCreateCanister(
        NnsCyclesMintingNotifyCreateCanisterArg(
          blockIndex: blockIndex,
          controller: controller,
          settings: settings,
          subnetSelection: subnetSelection,
          subnetType: subnetType,
        ),
      ),
      sender: sender.address,
      canisterId: canisterId ?? networkConfig.cyclesMintingCanisterId,
      params: params,
    );
  }
}
