import 'package:on_chain/tron/models/contract/base_contract/common.dart';

/// Enum representing different types of transaction contracts on the Tron blockchain.
///
/// Each contract type has a unique [value] associated with it and a [name] for identification.
/// The available contract types are specific to Tron transactions and cover various functionalities.
/// To use a contract type, refer to the predefined instances provided as static constants in this class.
///
class TransactionContractType implements TronEnumerate {
  /// Internal constructor to create a [TransactionContractType] instance.
  const TransactionContractType._(this.value, this.name);
  @override
  final int value;

  /// The name associated with the transaction contract type.
  final String name;
  static const TransactionContractType accountCreateContract =
      TransactionContractType._(0, 'AccountCreateContract');
  static const TransactionContractType transferContract =
      TransactionContractType._(1, 'TransferContract');
  static const TransactionContractType transferAssetContract =
      TransactionContractType._(2, 'TransferAssetContract');
  static const TransactionContractType voteAssetContract =
      TransactionContractType._(3, 'VoteAssetContract');
  static const TransactionContractType voteWitnessContract =
      TransactionContractType._(4, 'VoteWitnessContract');
  static const TransactionContractType witnessCreateContract =
      TransactionContractType._(5, 'WitnessCreateContract');
  static const TransactionContractType assetIssueContract =
      TransactionContractType._(6, 'AssetIssueContract');
  static const TransactionContractType witnessUpdateContract =
      TransactionContractType._(8, 'WitnessUpdateContract');
  static const TransactionContractType participateAssetIssueContract =
      TransactionContractType._(9, 'ParticipateAssetIssueContract');
  static const TransactionContractType accountUpdateContract =
      TransactionContractType._(10, 'AccountUpdateContract');
  static const TransactionContractType freezeBalanceContract =
      TransactionContractType._(11, 'FreezeBalanceContract');
  static const TransactionContractType unfreezeBalanceContract =
      TransactionContractType._(12, 'UnfreezeBalanceContract');
  static const TransactionContractType withdrawBalanceContract =
      TransactionContractType._(13, 'WithdrawBalanceContract');
  static const TransactionContractType unfreezeAssetContract =
      TransactionContractType._(14, 'UnfreezeAssetContract');
  static const TransactionContractType updateAssetContract =
      TransactionContractType._(15, 'UpdateAssetContract');
  static const TransactionContractType proposalCreateContract =
      TransactionContractType._(16, 'ProposalCreateContract');
  static const TransactionContractType proposalApproveContract =
      TransactionContractType._(17, 'ProposalApproveContract');
  static const TransactionContractType proposalDeleteContract =
      TransactionContractType._(18, 'ProposalDeleteContract');
  static const TransactionContractType setAccountIdContract =
      TransactionContractType._(19, 'SetAccountIdContract');
  static const TransactionContractType customContract =
      TransactionContractType._(20, 'CustomContract');
  static const TransactionContractType createSmartContract =
      TransactionContractType._(30, 'CreateSmartContract');
  static const TransactionContractType triggerSmartContract =
      TransactionContractType._(31, 'TriggerSmartContract');
  static const TransactionContractType getContract =
      TransactionContractType._(32, 'GetContract');
  static const TransactionContractType updateSettingContract =
      TransactionContractType._(33, 'UpdateSettingContract');
  static const TransactionContractType exchangeCreateContract =
      TransactionContractType._(41, 'ExchangeCreateContract');
  static const TransactionContractType exchangeInjectContract =
      TransactionContractType._(42, 'ExchangeInjectContract');
  static const TransactionContractType exchangeWithdrawContract =
      TransactionContractType._(43, 'ExchangeWithdrawContract');
  static const TransactionContractType exchangeTransactionContract =
      TransactionContractType._(44, 'ExchangeTransactionContract');
  static const TransactionContractType updateEnergyLimitContract =
      TransactionContractType._(45, 'UpdateEnergyLimitContract');
  static const TransactionContractType accountPermissionUpdateContract =
      TransactionContractType._(46, 'AccountPermissionUpdateContract');
  static const TransactionContractType clearABIContract =
      TransactionContractType._(48, 'ClearABIContract');
  static const TransactionContractType updateBrokerageContract =
      TransactionContractType._(49, 'UpdateBrokerageContract');
  static const TransactionContractType shieldedTransferContract =
      TransactionContractType._(51, 'ShieldedTransferContract');
  static const TransactionContractType marketSellAssetContract =
      TransactionContractType._(52, 'MarketSellAssetContract');
  static const TransactionContractType marketCancelOrderContract =
      TransactionContractType._(53, 'MarketCancelOrderContract');
  static const TransactionContractType freezeBalanceV2Contract =
      TransactionContractType._(54, 'FreezeBalanceV2Contract');
  static const TransactionContractType unfreezeBalanceV2Contract =
      TransactionContractType._(55, 'UnfreezeBalanceV2Contract');
  static const TransactionContractType withdrawExpireUnfreezeContract =
      TransactionContractType._(56, 'WithdrawExpireUnfreezeContract');
  static const TransactionContractType delegateResourceContract =
      TransactionContractType._(57, 'DelegateResourceContract');
  static const TransactionContractType unDelegateResourceContract =
      TransactionContractType._(58, 'UnDelegateResourceContract');
  static const TransactionContractType cancelAllUnfreezeV2Contract =
      TransactionContractType._(59, 'CancelAllUnfreezeV2Contract');

  /// List of all available transaction contract types.
  static const List<TransactionContractType> values = <TransactionContractType>[
    accountCreateContract,
    transferContract,
    transferAssetContract,
    voteAssetContract,
    voteWitnessContract,
    witnessCreateContract,
    assetIssueContract,
    witnessUpdateContract,
    participateAssetIssueContract,
    accountUpdateContract,
    freezeBalanceContract,
    unfreezeBalanceContract,
    withdrawBalanceContract,
    unfreezeAssetContract,
    updateAssetContract,
    proposalCreateContract,
    proposalApproveContract,
    proposalDeleteContract,
    setAccountIdContract,
    customContract,
    createSmartContract,
    triggerSmartContract,
    getContract,
    updateSettingContract,
    exchangeCreateContract,
    exchangeInjectContract,
    exchangeWithdrawContract,
    exchangeTransactionContract,
    updateEnergyLimitContract,
    accountPermissionUpdateContract,
    clearABIContract,
    updateBrokerageContract,
    shieldedTransferContract,
    marketSellAssetContract,
    marketCancelOrderContract,
    freezeBalanceV2Contract,
    unfreezeBalanceV2Contract,
    withdrawExpireUnfreezeContract,
    delegateResourceContract,
    unDelegateResourceContract,
    cancelAllUnfreezeV2Contract,
  ];

  /// Finds and returns a [TransactionContractType] by its [name].
  ///
  /// Case-sensitive matching is performed.
  static TransactionContractType findByName(String name) {
    return values.firstWhere((element) => element.name == name);
  }

  /// Finds and returns a [TransactionContractType] by its [value].
  ///
  /// Returns `null` if the contract type with the specified value is not found.
  static TransactionContractType? findByValue(int value) {
    try {
      return values.firstWhere((element) => element.value == value);
    } on StateError {
      return null;
    }
  }

  @override
  String toString() {
    return name;
  }
}
