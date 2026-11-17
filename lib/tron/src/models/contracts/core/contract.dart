import 'package:on_chain/tron/src/address/tron_address.dart';
import 'package:blockchain_utils/blockchain_utils.dart';

import 'package:on_chain/tron/src/models/contracts/contracts/account_contract.dart';
import 'package:on_chain/tron/src/models/contracts/contracts/asset_issue_contract.dart';
import 'package:on_chain/tron/src/models/contracts/contracts/balance_contract.dart';
import 'package:on_chain/tron/src/models/contracts/contracts/exchange_contract.dart';
import 'package:on_chain/tron/src/models/contracts/contracts/market_contract.dart';
import 'package:on_chain/tron/src/models/contracts/contracts/proposal_contract.dart';
import 'package:on_chain/tron/src/models/contracts/contracts/shield_contract.dart';
import 'package:on_chain/tron/src/models/contracts/contracts/smart_contract.dart';
import 'package:on_chain/tron/src/models/contracts/contracts/storage_contract.dart';
import 'package:on_chain/tron/src/models/contracts/contracts/vote_asset_contract.dart';
import 'package:on_chain/tron/src/models/contracts/contracts/witness_contract.dart';
import 'package:on_chain/tron/src/proto_messages/protocol/src/tron.dart';
import 'package:on_chain/tron/src/serialization/protobuf/proto.dart';

abstract class ITronContract extends TronProtoMessage {
  final TronTransactionContractContractType contractType;
  const ITronContract(this.contractType);
  @override
  Map<String, dynamic> toJson({
    TronProtoJsonConfig config = TronProtoJsonConfig.config,
  });
  TronAddress get ownerAddress;

  BigInt get trxAmount => BigInt.zero;

  static ITronContract deserializeBytes({
    required TronTransactionContractContractType contractType,
    required List<int> contractBytes,
  }) {
    switch (contractType) {
      case TronTransactionContractContractType.accountCreateContract:
        return TronAccountCreateContract.deserialize(contractBytes);

      case TronTransactionContractContractType.transferContract:
        return TronTransferContract.deserialize(contractBytes);

      case TronTransactionContractContractType.transferAssetContract:
        return TronTransferAssetContract.deserialize(contractBytes);

      case TronTransactionContractContractType.voteAssetContract:
        return TronVoteAssetContract.deserialize(contractBytes);

      case TronTransactionContractContractType.voteWitnessContract:
        return TronVoteWitnessContract.deserialize(contractBytes);

      case TronTransactionContractContractType.witnessCreateContract:
        return TronWitnessCreateContract.deserialize(contractBytes);

      case TronTransactionContractContractType.assetIssueContract:
        return TronAssetIssueContract.deserialize(contractBytes);

      case TronTransactionContractContractType.witnessUpdateContract:
        return TronWitnessUpdateContract.deserialize(contractBytes);

      case TronTransactionContractContractType.participateAssetIssueContract:
        return TronParticipateAssetIssueContract.deserialize(contractBytes);

      case TronTransactionContractContractType.accountUpdateContract:
        return TronAccountUpdateContract.deserialize(contractBytes);

      case TronTransactionContractContractType.freezeBalanceContract:
        return TronFreezeBalanceContract.deserialize(contractBytes);

      case TronTransactionContractContractType.unfreezeBalanceContract:
        return TronUnfreezeBalanceContract.deserialize(contractBytes);

      case TronTransactionContractContractType.withdrawBalanceContract:
        return TronWithdrawBalanceContract.deserialize(contractBytes);

      case TronTransactionContractContractType.unfreezeAssetContract:
        return TronUnfreezeAssetContract.deserialize(contractBytes);

      case TronTransactionContractContractType.updateAssetContract:
        return TronUpdateAssetContract.deserialize(contractBytes);

      case TronTransactionContractContractType.proposalCreateContract:
        return TronProposalCreateContract.deserialize(contractBytes);

      case TronTransactionContractContractType.proposalApproveContract:
        return TronProposalApproveContract.deserialize(contractBytes);

      case TronTransactionContractContractType.proposalDeleteContract:
        return TronProposalDeleteContract.deserialize(contractBytes);

      case TronTransactionContractContractType.setAccountIdContract:
        return TronSetAccountIdContract.deserialize(contractBytes);

      case TronTransactionContractContractType.createSmartContract:
        return TronCreateSmartContract.deserialize(contractBytes);

      case TronTransactionContractContractType.triggerSmartContract:
        return TronTriggerSmartContract.deserialize(contractBytes);

      case TronTransactionContractContractType.updateSettingContract:
        return TronUpdateSettingContract.deserialize(contractBytes);

      case TronTransactionContractContractType.exchangeCreateContract:
        return TronExchangeCreateContract.deserialize(contractBytes);

      case TronTransactionContractContractType.exchangeInjectContract:
        return TronExchangeInjectContract.deserialize(contractBytes);

      case TronTransactionContractContractType.exchangeWithdrawContract:
        return TronExchangeWithdrawContract.deserialize(contractBytes);

      case TronTransactionContractContractType.exchangeTransactionContract:
        return TronExchangeTransactionContract.deserialize(contractBytes);

      case TronTransactionContractContractType.updateEnergyLimitContract:
        return TronUpdateEnergyLimitContract.deserialize(contractBytes);

      case TronTransactionContractContractType.accountPermissionUpdateContract:
        return TronAccountPermissionUpdateContract.deserialize(contractBytes);

      case TronTransactionContractContractType.clearABIContract:
        return TronClearABIContract.deserialize(contractBytes);

      case TronTransactionContractContractType.updateBrokerageContract:
        return TronUpdateBrokerageContract.deserialize(contractBytes);

      case TronTransactionContractContractType.shieldedTransferContract:
        return TronShieldedTransferContract.deserialize(contractBytes);

      case TronTransactionContractContractType.marketSellAssetContract:
        return TronMarketSellAssetContract.deserialize(contractBytes);

      case TronTransactionContractContractType.marketCancelOrderContract:
        return TronMarketCancelOrderContract.deserialize(contractBytes);

      case TronTransactionContractContractType.freezeBalanceV2Contract:
        return TronFreezeBalanceV2Contract.deserialize(contractBytes);

      case TronTransactionContractContractType.unfreezeBalanceV2Contract:
        return TronUnfreezeBalanceV2Contract.deserialize(contractBytes);

      case TronTransactionContractContractType.withdrawExpireUnfreezeContract:
        return TronWithdrawExpireUnfreezeContract.deserialize(contractBytes);

      case TronTransactionContractContractType.delegateResourceContract:
        return TronDelegateResourceContract.deserialize(contractBytes);

      case TronTransactionContractContractType.unDelegateResourceContract:
        return TronUnDelegateResourceContract.deserialize(contractBytes);

      case TronTransactionContractContractType.cancelAllUnfreezeV2Contract:
        return TronCancelAllUnfreezeV2Contract.deserialize(contractBytes);
      case TronTransactionContractContractType.customContract:
      case TronTransactionContractContractType.getContract:
        throw BuError(
          DefaultErrorType.unsupported,
          "Unsupported Tron contract: $contractType.",
        );
    }
  }

  static ITronContract deserializeJson({
    required TronTransactionContractContractType contractType,
    required Map<String, dynamic> json,
  }) {
    switch (contractType) {
      case TronTransactionContractContractType.accountCreateContract:
        return TronAccountCreateContract.fromJson(json);
      case TronTransactionContractContractType.transferContract:
        return TronTransferContract.fromJson(json);

      case TronTransactionContractContractType.transferAssetContract:
        return TronTransferAssetContract.fromJson(json);

      case TronTransactionContractContractType.voteAssetContract:
        return TronVoteAssetContract.fromJson(json);

      case TronTransactionContractContractType.voteWitnessContract:
        return TronVoteWitnessContract.fromJson(json);

      case TronTransactionContractContractType.witnessCreateContract:
        return TronWitnessCreateContract.fromJson(json);

      case TronTransactionContractContractType.assetIssueContract:
        return TronAssetIssueContract.fromJson(json);

      case TronTransactionContractContractType.witnessUpdateContract:
        return TronWitnessUpdateContract.fromJson(json);

      case TronTransactionContractContractType.participateAssetIssueContract:
        return TronParticipateAssetIssueContract.fromJson(json);

      case TronTransactionContractContractType.accountUpdateContract:
        return TronAccountUpdateContract.fromJson(json);

      case TronTransactionContractContractType.freezeBalanceContract:
        return TronFreezeBalanceContract.fromJson(json);

      case TronTransactionContractContractType.unfreezeBalanceContract:
        return TronUnfreezeBalanceContract.fromJson(json);

      case TronTransactionContractContractType.withdrawBalanceContract:
        return TronWithdrawBalanceContract.fromJson(json);

      case TronTransactionContractContractType.unfreezeAssetContract:
        return TronUnfreezeAssetContract.fromJson(json);

      case TronTransactionContractContractType.updateAssetContract:
        return TronUpdateAssetContract.fromJson(json);

      case TronTransactionContractContractType.proposalCreateContract:
        return TronProposalCreateContract.fromJson(json);

      case TronTransactionContractContractType.proposalApproveContract:
        return TronProposalApproveContract.fromJson(json);

      case TronTransactionContractContractType.proposalDeleteContract:
        return TronProposalDeleteContract.fromJson(json);

      case TronTransactionContractContractType.setAccountIdContract:
        return TronSetAccountIdContract.fromJson(json);

      case TronTransactionContractContractType.createSmartContract:
        return TronCreateSmartContract.fromJson(json);

      case TronTransactionContractContractType.triggerSmartContract:
        return TronTriggerSmartContract.fromJson(json);

      case TronTransactionContractContractType.updateSettingContract:
        return TronUpdateSettingContract.fromJson(json);

      case TronTransactionContractContractType.exchangeCreateContract:
        return TronExchangeCreateContract.fromJson(json);

      case TronTransactionContractContractType.exchangeInjectContract:
        return TronExchangeInjectContract.fromJson(json);

      case TronTransactionContractContractType.exchangeWithdrawContract:
        return TronExchangeWithdrawContract.fromJson(json);

      case TronTransactionContractContractType.exchangeTransactionContract:
        return TronExchangeTransactionContract.fromJson(json);

      case TronTransactionContractContractType.updateEnergyLimitContract:
        return TronUpdateEnergyLimitContract.fromJson(json);

      case TronTransactionContractContractType.accountPermissionUpdateContract:
        return TronAccountPermissionUpdateContract.fromJson(json);

      case TronTransactionContractContractType.clearABIContract:
        return TronClearABIContract.fromJson(json);

      case TronTransactionContractContractType.updateBrokerageContract:
        return TronUpdateBrokerageContract.fromJson(json);

      case TronTransactionContractContractType.shieldedTransferContract:
        return TronShieldedTransferContract.fromJson(json);

      case TronTransactionContractContractType.marketSellAssetContract:
        return TronMarketSellAssetContract.fromJson(json);

      case TronTransactionContractContractType.marketCancelOrderContract:
        return TronMarketCancelOrderContract.fromJson(json);

      case TronTransactionContractContractType.freezeBalanceV2Contract:
        return TronFreezeBalanceV2Contract.fromJson(json);

      case TronTransactionContractContractType.unfreezeBalanceV2Contract:
        return TronUnfreezeBalanceV2Contract.fromJson(json);

      case TronTransactionContractContractType.withdrawExpireUnfreezeContract:
        return TronWithdrawExpireUnfreezeContract.fromJson(json);

      case TronTransactionContractContractType.delegateResourceContract:
        return TronDelegateResourceContract.fromJson(json);

      case TronTransactionContractContractType.unDelegateResourceContract:
        return TronUnDelegateResourceContract.fromJson(json);

      case TronTransactionContractContractType.cancelAllUnfreezeV2Contract:
        return TronCancelAllUnfreezeV2Contract.fromJson(json);
      case TronTransactionContractContractType.customContract:
      case TronTransactionContractContractType.getContract:
        throw BuError(
          DefaultErrorType.unsupported,
          "Unsupported Tron contract: $contractType.",
        );
    }
  }

  T cast<T extends ITronContract>() {
    if (this is! T) {
      throw BuError(DefaultErrorType.invalidArgument, "Invalid contract cast.");
    }
    return this as T;
  }
}
