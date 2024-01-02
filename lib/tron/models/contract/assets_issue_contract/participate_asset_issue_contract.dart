import 'package:on_chain/tron/address/tron_address.dart';
import 'package:on_chain/tron/models/contract/base_contract/base.dart';
import 'package:blockchain_utils/blockchain_utils.dart';

/// Participate in an asset issue.
class ParticipateAssetIssueContract extends TronBaseContract {
  /// Create a new [ParticipateAssetIssueContract] instance by parsing a JSON map.
  factory ParticipateAssetIssueContract.fromJson(Map<String, dynamic> json) {
    return ParticipateAssetIssueContract(
      ownerAddress: TronAddress(json['owner_address']),
      toAddress: TronAddress(json['to_address']),
      assetName: StringUtils.encode(json['asset_name']),
      amount: BigintUtils.parse(json['amount']),
    );
  }

  /// Create a new [ParticipateAssetIssueContract] instance with specified parameters.
  ParticipateAssetIssueContract(
      {required this.ownerAddress,
      required this.toAddress,
      required List<int> assetName,
      required this.amount})
      : assetName = BytesUtils.toBytes(assetName, unmodifiable: true);

  /// Account address
  final TronAddress ownerAddress;

  /// Issuer's address
  final TronAddress toAddress;

  /// token iD
  final List<int> assetName;

  /// The amount of TRX used to purchase issued Token, the unit is sun
  final BigInt amount;

  @override
  List<int> get fieldIds => [1, 2, 3, 4];

  @override
  List get values => [ownerAddress, toAddress, assetName, amount];

  /// Convert the [ParticipateAssetIssueContract] object to a JSON representation.
  @override
  Map<String, dynamic> toJson() {
    return {
      "to_address": toAddress.toString(),
      "owner_address": ownerAddress.toString(),
      "amount": amount.toString(),
      "asset_name": StringUtils.decode(assetName)
    };
  }

  /// Convert the [ParticipateAssetIssueContract] object to its string representation.
  @override
  String toString() {
    return "ParticipateAssetIssueContract{${toJson()}}";
  }

  @override
  TransactionContractType get contractType =>
      TransactionContractType.participateAssetIssueContract;
}
