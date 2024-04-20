import 'package:blockchain_utils/blockchain_utils.dart';
import 'package:on_chain/tron/src/models/contract/account/accout.dart';
import 'package:on_chain/tron/src/models/contract/assets_issue_contract/asset.dart';
import 'package:on_chain/tron/src/models/contract/balance/balance.dart';
import 'package:on_chain/tron/src/models/contract/base_contract/base.dart';
import 'package:on_chain/tron/src/models/contract/exchange/exchange.dart';
import 'package:on_chain/tron/src/models/contract/market/market.dart';
import 'package:on_chain/tron/src/models/contract/proposal/proposal.dart';
import 'package:on_chain/tron/src/models/contract/shield/shield_transfer_contract.dart';
import 'package:on_chain/tron/src/models/contract/smart_contract/contract.dart';
import 'package:on_chain/tron/src/models/contract/storage_contract/update_brokerage_contract.dart';

import 'package:on_chain/tron/src/models/contract/vote/vote.dart';
import 'package:on_chain/tron/src/models/contract/witness/witness.dart';
import 'package:on_chain/tron/src/protbuf/decoder.dart';

class Any extends TronProtocolBufferImpl {
  /// Create a new [Any] instance with specified parameters.
  Any({required this.typeUrl, required this.value});
  factory Any.deserialize(List<int> bytes) {
    final decode = TronProtocolBufferImpl.decode(bytes);
    final String typeUrl = decode.getField(1);
    final contractType = TransactionContractType.findByName(
        typeUrl.split("type.googleapis.com/protocol.").last);
    final List<int> contractBytes = decode.getField(2);
    TronBaseContract contract;
    switch (contractType) {
      case TransactionContractType.transferContract:
        contract = TransferContract.deserialize(contractBytes);
        break;
      case TransactionContractType.assetIssueContract:
        contract = AssetIssueContract.deserialize(contractBytes);
        break;
      case TransactionContractType.cancelAllUnfreezeV2Contract:
        contract = CancelAllUnfreezeV2Contract.deserialize(contractBytes);
        break;
      case TransactionContractType.updateAssetContract:
        contract = UpdateAssetContract.deserialize(contractBytes);
        break;
      case TransactionContractType.participateAssetIssueContract:
        contract = ParticipateAssetIssueContract.deserialize(contractBytes);
        break;
      case TransactionContractType.transferAssetContract:
        contract = TransferAssetContract.deserialize(contractBytes);
        break;
      case TransactionContractType.accountCreateContract:
        contract = AccountCreateContract.deserialize(contractBytes);
        break;
      case TransactionContractType.accountUpdateContract:
        contract = AccountUpdateContract.deserialize(contractBytes);
        break;
      case TransactionContractType.freezeBalanceV2Contract:
        contract = FreezeBalanceV2Contract.deserialize(contractBytes);
        break;
      case TransactionContractType.unfreezeBalanceV2Contract:
        contract = UnfreezeBalanceV2Contract.deserialize(contractBytes);
        break;
      case TransactionContractType.withdrawBalanceContract:
        contract = WithdrawBalanceContract.deserialize(contractBytes);
        break;
      case TransactionContractType.withdrawExpireUnfreezeContract:
        contract = WithdrawExpireUnfreezeContract.deserialize(contractBytes);
        break;
      case TransactionContractType.delegateResourceContract:
        contract = DelegateResourceContract.deserialize(contractBytes);
        break;
      case TransactionContractType.unDelegateResourceContract:
        contract = UnDelegateResourceContract.deserialize(contractBytes);
        break;
      case TransactionContractType.unfreezeBalanceContract:
        contract = UnfreezeBalanceContract.deserialize(contractBytes);
        break;
      case TransactionContractType.freezeBalanceContract:
        contract = FreezeBalanceContract.deserialize(contractBytes);
        break;
      case TransactionContractType.accountPermissionUpdateContract:
        contract = AccountPermissionUpdateContract.deserialize(contractBytes);
        break;
      case TransactionContractType.triggerSmartContract:
        contract = TriggerSmartContract.deserialize(contractBytes);
        break;
      case TransactionContractType.createSmartContract:
        contract = CreateSmartContract.deserialize(contractBytes);
        break;
      case TransactionContractType.setAccountIdContract:
        contract = SetAccountIdContract.deserialize(contractBytes);
        break;
      case TransactionContractType.exchangeCreateContract:
        contract = ExchangeCreateContract.deserialize(contractBytes);
        break;
      case TransactionContractType.exchangeInjectContract:
        contract = ExchangeInjectContract.deserialize(contractBytes);
        break;
      case TransactionContractType.exchangeTransactionContract:
        contract = ExchangeTransactionContract.deserialize(contractBytes);
        break;
      case TransactionContractType.exchangeWithdrawContract:
        contract = ExchangeWithdrawContract.deserialize(contractBytes);
        break;
      case TransactionContractType.marketCancelOrderContract:
        contract = MarketCancelOrderContract.deserialize(contractBytes);
        break;
      case TransactionContractType.marketSellAssetContract:
        contract = MarketSellAssetContract.deserialize(contractBytes);
        break;
      case TransactionContractType.proposalApproveContract:
        contract = ProposalApproveContract.deserialize(contractBytes);
        break;
      case TransactionContractType.proposalCreateContract:
        contract = ProposalCreateContract.deserialize(contractBytes);
        break;
      case TransactionContractType.proposalDeleteContract:
        contract = ProposalDeleteContract.deserialize(contractBytes);
        break;
      case TransactionContractType.shieldedTransferContract:
        contract = ShieldedTransferContract.deserialize(contractBytes);
        break;
      case TransactionContractType.clearABIContract:
        contract = ClearABIContract.deserialize(contractBytes);
        break;
      case TransactionContractType.updateEnergyLimitContract:
        contract = UpdateEnergyLimitContract.deserialize(contractBytes);
        break;
      case TransactionContractType.updateSettingContract:
        contract = UpdateSettingContract.deserialize(contractBytes);
        break;
      case TransactionContractType.updateBrokerageContract:
        contract = UpdateBrokerageContract.deserialize(contractBytes);
        break;
      case TransactionContractType.voteAssetContract:
        contract = VoteAssetContract.deserialize(contractBytes);
        break;
      case TransactionContractType.voteWitnessContract:
        contract = VoteWitnessContract.deserialize(contractBytes);
        break;
      case TransactionContractType.unfreezeAssetContract:
        contract = UnfreezeAssetContract.deserialize(contractBytes);
        break;
      case TransactionContractType.witnessUpdateContract:
        contract = WitnessUpdateContract.deserialize(contractBytes);
        break;
      case TransactionContractType.witnessCreateContract:
        contract = WitnessCreateContract.deserialize(contractBytes);
        break;
      default:
        throw MessageException("Unsupported contract",
            details: {"contract": contractType.name});
    }
    return Any(typeUrl: typeUrl, value: contract);
  }

  /// Create a new [Any] instance by parsing a JSON map.
  factory Any.fromJson(Map<String, dynamic> json) {
    final String typeUrl = json["type_url"];
    final contractType = TransactionContractType.findByName(
        typeUrl.split("type.googleapis.com/protocol.").last);
    final Map<String, dynamic> contractDetails = json["value"];
    TronBaseContract contract;
    switch (contractType) {
      case TransactionContractType.transferContract:
        contract = TransferContract.fromJson(contractDetails);
        break;
      case TransactionContractType.assetIssueContract:
        contract = AssetIssueContract.fromJson(contractDetails);
        break;
      case TransactionContractType.cancelAllUnfreezeV2Contract:
        contract = CancelAllUnfreezeV2Contract.fromJson(contractDetails);
        break;
      case TransactionContractType.updateAssetContract:
        contract = UpdateAssetContract.fromJson(contractDetails);
        break;
      case TransactionContractType.participateAssetIssueContract:
        contract = ParticipateAssetIssueContract.fromJson(contractDetails);
        break;
      case TransactionContractType.transferAssetContract:
        contract = TransferAssetContract.fromJson(contractDetails);
        break;
      case TransactionContractType.accountCreateContract:
        contract = AccountCreateContract.fromJson(contractDetails);
        break;
      case TransactionContractType.accountUpdateContract:
        contract = AccountUpdateContract.fromJson(contractDetails);
        break;
      case TransactionContractType.freezeBalanceV2Contract:
        contract = FreezeBalanceV2Contract.fromJson(contractDetails);
        break;
      case TransactionContractType.unfreezeBalanceV2Contract:
        contract = UnfreezeBalanceV2Contract.fromJson(contractDetails);
        break;
      case TransactionContractType.withdrawBalanceContract:
        contract = WithdrawBalanceContract.fromJson(contractDetails);
        break;
      case TransactionContractType.withdrawExpireUnfreezeContract:
        contract = WithdrawExpireUnfreezeContract.fromJson(contractDetails);
        break;
      case TransactionContractType.delegateResourceContract:
        contract = DelegateResourceContract.fromJson(contractDetails);
        break;
      case TransactionContractType.unDelegateResourceContract:
        contract = UnDelegateResourceContract.fromJson(contractDetails);
        break;
      case TransactionContractType.unfreezeBalanceContract:
        contract = UnfreezeBalanceContract.fromJson(contractDetails);
        break;
      case TransactionContractType.freezeBalanceContract:
        contract = FreezeBalanceContract.fromJson(contractDetails);
        break;
      case TransactionContractType.accountPermissionUpdateContract:
        contract = AccountPermissionUpdateContract.fromJson(contractDetails);
        break;
      case TransactionContractType.triggerSmartContract:
        contract = TriggerSmartContract.fromJson(contractDetails);
        break;
      case TransactionContractType.createSmartContract:
        contract = CreateSmartContract.fromJson(contractDetails);
        break;
      case TransactionContractType.setAccountIdContract:
        contract = SetAccountIdContract.fromJson(contractDetails);
        break;
      case TransactionContractType.exchangeCreateContract:
        contract = ExchangeCreateContract.fromJson(contractDetails);
        break;
      case TransactionContractType.exchangeInjectContract:
        contract = ExchangeInjectContract.fromJson(contractDetails);
        break;
      case TransactionContractType.exchangeTransactionContract:
        contract = ExchangeTransactionContract.fromJson(contractDetails);
        break;
      case TransactionContractType.exchangeWithdrawContract:
        contract = ExchangeWithdrawContract.fromJson(contractDetails);
        break;
      case TransactionContractType.marketCancelOrderContract:
        contract = MarketCancelOrderContract.fromJson(contractDetails);
        break;
      case TransactionContractType.marketSellAssetContract:
        contract = MarketSellAssetContract.fromJson(contractDetails);
        break;
      case TransactionContractType.proposalApproveContract:
        contract = ProposalApproveContract.fromJson(contractDetails);
        break;
      case TransactionContractType.proposalCreateContract:
        contract = ProposalCreateContract.fromJson(contractDetails);
        break;
      case TransactionContractType.proposalDeleteContract:
        contract = ProposalDeleteContract.fromJson(contractDetails);
        break;
      case TransactionContractType.shieldedTransferContract:
        contract = ShieldedTransferContract.fromJson(contractDetails);
        break;
      case TransactionContractType.clearABIContract:
        contract = ClearABIContract.fromJson(contractDetails);
        break;
      case TransactionContractType.updateEnergyLimitContract:
        contract = UpdateEnergyLimitContract.fromJson(contractDetails);
        break;
      case TransactionContractType.updateSettingContract:
        contract = UpdateSettingContract.fromJson(contractDetails);
        break;
      case TransactionContractType.updateBrokerageContract:
        contract = UpdateBrokerageContract.fromJson(contractDetails);
        break;
      case TransactionContractType.voteAssetContract:
        contract = VoteAssetContract.fromJson(contractDetails);
        break;
      case TransactionContractType.voteWitnessContract:
        contract = VoteWitnessContract.fromJson(contractDetails);
        break;
      case TransactionContractType.unfreezeAssetContract:
        contract = UnfreezeAssetContract.fromJson(contractDetails);
        break;
      case TransactionContractType.witnessUpdateContract:
        contract = WitnessUpdateContract.fromJson(contractDetails);
        break;
      case TransactionContractType.witnessCreateContract:
        contract = WitnessCreateContract.fromJson(contractDetails);
        break;
      default:
        throw MessageException("Unsupported contract",
            details: {"contract": contractType.name});
    }
    return Any(typeUrl: typeUrl, value: contract);
  }
  final String typeUrl;
  final TronBaseContract value;

  @override
  List<int> get fieldIds => [1, 2];

  @override
  List get values => [typeUrl, value];

  /// Convert the [Any] object to its string representation.
  @override
  String toString() {
    return "Any{${toJson()}}";
  }

  /// Convert the [Any] object to a JSON representation.
  @override
  Map<String, dynamic> toJson() {
    return {"value": value.toJson(), "type_url": typeUrl};
  }
}
