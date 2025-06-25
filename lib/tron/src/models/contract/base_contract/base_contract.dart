import 'package:on_chain/tron/src/address/tron_address.dart';
import 'package:on_chain/tron/src/exception/exception.dart';
import 'package:blockchain_utils/blockchain_utils.dart';
import 'package:on_chain/tron/src/protbuf/decoder.dart';
import 'package:on_chain/tron/src/protbuf/encoder.dart';
import 'package:on_chain/tron/src/models/contract/account/account.dart';
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

/// Abstract class providing a common implementation for encoding Tron models using minimal protobuf encoding.
abstract class TronProtocolBufferImpl {
  /// List of dynamic values to be encoded.
  abstract final List<dynamic> values;

  /// List of field IDs corresponding to the values.
  abstract final List<int> fieldIds;

  /// Converts the data to a JSON representation.
  Map<String, dynamic> toJson();

  /// Converts the protocol buffer data to a byte buffer.
  List<int> toBuffer() {
    if (values.length != fieldIds.length) {
      throw TronPluginException(
          'The values and field IDs must have the same length.',
          details: {
            'values': values,
            'fieldIds': fieldIds,
            'class': runtimeType.toString()
          });
    }
    final bytes = DynamicByteTracker();
    for (int i = 0; i < values.length; i++) {
      final value = values[i];
      final tagNumber = fieldIds[i];
      List<int> encode;
      if (value == null) continue;
      if (value is TronBaseContract) {
        encode = ProtocolBufferEncoder.encode(tagNumber, value.toBuffer());
      } else if (value is TronEnumerate) {
        encode = ProtocolBufferEncoder.encode(tagNumber, value.value);
      } else {
        encode = ProtocolBufferEncoder.encode(tagNumber, value);
      }

      bytes.add(encode);
    }
    return bytes.toBytes();
  }

  /// Gets the hexadecimal representation of the protocol buffer data.
  String get toHex => BytesUtils.toHexString(toBuffer());

  static List<ProtocolBufferDecoderResult> decode(List<int> bytes) {
    return ProtocolBufferDecoder.decode(bytes);
  }
}

/// contracts
abstract class TronBaseContract extends TronProtocolBufferImpl {
  TronBaseContract();
  factory TronBaseContract.deserialize(
      {required TransactionContractType contractType,
      required List<int> contractBytes}) {
    switch (contractType) {
      case TransactionContractType.transferContract:
        return TransferContract.deserialize(contractBytes);

      case TransactionContractType.assetIssueContract:
        return AssetIssueContract.deserialize(contractBytes);

      case TransactionContractType.cancelAllUnfreezeV2Contract:
        return CancelAllUnfreezeV2Contract.deserialize(contractBytes);

      case TransactionContractType.updateAssetContract:
        return UpdateAssetContract.deserialize(contractBytes);

      case TransactionContractType.participateAssetIssueContract:
        return ParticipateAssetIssueContract.deserialize(contractBytes);

      case TransactionContractType.transferAssetContract:
        return TransferAssetContract.deserialize(contractBytes);

      case TransactionContractType.accountCreateContract:
        return AccountCreateContract.deserialize(contractBytes);

      case TransactionContractType.accountUpdateContract:
        return AccountUpdateContract.deserialize(contractBytes);

      case TransactionContractType.freezeBalanceV2Contract:
        return FreezeBalanceV2Contract.deserialize(contractBytes);

      case TransactionContractType.unfreezeBalanceV2Contract:
        return UnfreezeBalanceV2Contract.deserialize(contractBytes);

      case TransactionContractType.withdrawBalanceContract:
        return WithdrawBalanceContract.deserialize(contractBytes);

      case TransactionContractType.withdrawExpireUnfreezeContract:
        return WithdrawExpireUnfreezeContract.deserialize(contractBytes);

      case TransactionContractType.delegateResourceContract:
        return DelegateResourceContract.deserialize(contractBytes);

      case TransactionContractType.unDelegateResourceContract:
        return UnDelegateResourceContract.deserialize(contractBytes);

      case TransactionContractType.unfreezeBalanceContract:
        return UnfreezeBalanceContract.deserialize(contractBytes);

      case TransactionContractType.freezeBalanceContract:
        return FreezeBalanceContract.deserialize(contractBytes);

      case TransactionContractType.accountPermissionUpdateContract:
        return AccountPermissionUpdateContract.deserialize(contractBytes);

      case TransactionContractType.triggerSmartContract:
        return TriggerSmartContract.deserialize(contractBytes);

      case TransactionContractType.createSmartContract:
        return CreateSmartContract.deserialize(contractBytes);

      case TransactionContractType.setAccountIdContract:
        return SetAccountIdContract.deserialize(contractBytes);

      case TransactionContractType.exchangeCreateContract:
        return ExchangeCreateContract.deserialize(contractBytes);

      case TransactionContractType.exchangeInjectContract:
        return ExchangeInjectContract.deserialize(contractBytes);

      case TransactionContractType.exchangeTransactionContract:
        return ExchangeTransactionContract.deserialize(contractBytes);

      case TransactionContractType.exchangeWithdrawContract:
        return ExchangeWithdrawContract.deserialize(contractBytes);

      case TransactionContractType.marketCancelOrderContract:
        return MarketCancelOrderContract.deserialize(contractBytes);

      case TransactionContractType.marketSellAssetContract:
        return MarketSellAssetContract.deserialize(contractBytes);

      case TransactionContractType.proposalApproveContract:
        return ProposalApproveContract.deserialize(contractBytes);

      case TransactionContractType.proposalCreateContract:
        return ProposalCreateContract.deserialize(contractBytes);

      case TransactionContractType.proposalDeleteContract:
        return ProposalDeleteContract.deserialize(contractBytes);

      case TransactionContractType.shieldedTransferContract:
        return ShieldedTransferContract.deserialize(contractBytes);

      case TransactionContractType.clearABIContract:
        return ClearABIContract.deserialize(contractBytes);

      case TransactionContractType.updateEnergyLimitContract:
        return UpdateEnergyLimitContract.deserialize(contractBytes);

      case TransactionContractType.updateSettingContract:
        return UpdateSettingContract.deserialize(contractBytes);

      case TransactionContractType.updateBrokerageContract:
        return UpdateBrokerageContract.deserialize(contractBytes);

      case TransactionContractType.voteAssetContract:
        return VoteAssetContract.deserialize(contractBytes);

      case TransactionContractType.voteWitnessContract:
        return VoteWitnessContract.deserialize(contractBytes);

      case TransactionContractType.unfreezeAssetContract:
        return UnfreezeAssetContract.deserialize(contractBytes);

      case TransactionContractType.witnessUpdateContract:
        return WitnessUpdateContract.deserialize(contractBytes);

      case TransactionContractType.witnessCreateContract:
        return WitnessCreateContract.deserialize(contractBytes);

      default:
        throw TronPluginException('Unsupported contract',
            details: {'contract': contractType.name});
    }
  }
  factory TronBaseContract.fromJson(
      {required TransactionContractType contractType,
      required Map<String, dynamic> json}) {
    switch (contractType) {
      case TransactionContractType.transferContract:
        return TransferContract.fromJson(json);

      case TransactionContractType.assetIssueContract:
        return AssetIssueContract.fromJson(json);

      case TransactionContractType.cancelAllUnfreezeV2Contract:
        return CancelAllUnfreezeV2Contract.fromJson(json);

      case TransactionContractType.updateAssetContract:
        return UpdateAssetContract.fromJson(json);

      case TransactionContractType.participateAssetIssueContract:
        return ParticipateAssetIssueContract.fromJson(json);

      case TransactionContractType.transferAssetContract:
        return TransferAssetContract.fromJson(json);

      case TransactionContractType.accountCreateContract:
        return AccountCreateContract.fromJson(json);

      case TransactionContractType.accountUpdateContract:
        return AccountUpdateContract.fromJson(json);

      case TransactionContractType.freezeBalanceV2Contract:
        return FreezeBalanceV2Contract.fromJson(json);

      case TransactionContractType.unfreezeBalanceV2Contract:
        return UnfreezeBalanceV2Contract.fromJson(json);

      case TransactionContractType.withdrawBalanceContract:
        return WithdrawBalanceContract.fromJson(json);

      case TransactionContractType.withdrawExpireUnfreezeContract:
        return WithdrawExpireUnfreezeContract.fromJson(json);

      case TransactionContractType.delegateResourceContract:
        return DelegateResourceContract.fromJson(json);

      case TransactionContractType.unDelegateResourceContract:
        return UnDelegateResourceContract.fromJson(json);

      case TransactionContractType.unfreezeBalanceContract:
        return UnfreezeBalanceContract.fromJson(json);

      case TransactionContractType.freezeBalanceContract:
        return FreezeBalanceContract.fromJson(json);

      case TransactionContractType.accountPermissionUpdateContract:
        return AccountPermissionUpdateContract.fromJson(json);

      case TransactionContractType.triggerSmartContract:
        return TriggerSmartContract.fromJson(json);

      case TransactionContractType.createSmartContract:
        return CreateSmartContract.fromJson(json);

      case TransactionContractType.setAccountIdContract:
        return SetAccountIdContract.fromJson(json);

      case TransactionContractType.exchangeCreateContract:
        return ExchangeCreateContract.fromJson(json);

      case TransactionContractType.exchangeInjectContract:
        return ExchangeInjectContract.fromJson(json);

      case TransactionContractType.exchangeTransactionContract:
        return ExchangeTransactionContract.fromJson(json);

      case TransactionContractType.exchangeWithdrawContract:
        return ExchangeWithdrawContract.fromJson(json);

      case TransactionContractType.marketCancelOrderContract:
        return MarketCancelOrderContract.fromJson(json);

      case TransactionContractType.marketSellAssetContract:
        return MarketSellAssetContract.fromJson(json);

      case TransactionContractType.proposalApproveContract:
        return ProposalApproveContract.fromJson(json);

      case TransactionContractType.proposalCreateContract:
        return ProposalCreateContract.fromJson(json);

      case TransactionContractType.proposalDeleteContract:
        return ProposalDeleteContract.fromJson(json);

      case TransactionContractType.shieldedTransferContract:
        return ShieldedTransferContract.fromJson(json);

      case TransactionContractType.clearABIContract:
        return ClearABIContract.fromJson(json);

      case TransactionContractType.updateEnergyLimitContract:
        return UpdateEnergyLimitContract.fromJson(json);

      case TransactionContractType.updateSettingContract:
        return UpdateSettingContract.fromJson(json);

      case TransactionContractType.updateBrokerageContract:
        return UpdateBrokerageContract.fromJson(json);

      case TransactionContractType.voteAssetContract:
        return VoteAssetContract.fromJson(json);

      case TransactionContractType.voteWitnessContract:
        return VoteWitnessContract.fromJson(json);

      case TransactionContractType.unfreezeAssetContract:
        return UnfreezeAssetContract.fromJson(json);

      case TransactionContractType.witnessUpdateContract:
        return WitnessUpdateContract.fromJson(json);

      case TransactionContractType.witnessCreateContract:
        return WitnessCreateContract.fromJson(json);

      default:
        throw TronPluginException('Unsupported contract',
            details: {'contract': contractType.name});
    }
  }

  TransactionContractType get contractType;
  String get typeURL => 'type.googleapis.com/protocol.${contractType.name}';

  /// the owner of contract.
  TronAddress get ownerAddress;

  /// the trx amount of contract;
  /// if contract need any trx amount for spending, stack, freez or ....
  BigInt get trxAmount => BigInt.zero;

  T cast<T extends TronBaseContract>() {
    if (this is! T) {
      throw const TronPluginException('Incorrect contract casting.');
    }
    return this as T;
  }

  @override
  Map<String, dynamic> toJson({bool visible = true});
}
