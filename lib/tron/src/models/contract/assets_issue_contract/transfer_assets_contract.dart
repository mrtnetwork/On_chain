import 'package:on_chain/tron/src/address/tron_address.dart';
import 'package:on_chain/tron/src/models/contract/base_contract/base.dart';
import 'package:blockchain_utils/blockchain_utils.dart';

/// Transfer TRC10 token.
class TransferAssetContract extends TronBaseContract {
  /// Create a new [TransferAssetContract] instance by parsing a JSON map.
  factory TransferAssetContract.fromJson(Map<String, dynamic> json) {
    return TransferAssetContract(
      assetName: StringUtils.encode(json['asset_name']),
      ownerAddress: TronAddress(json['owner_address']),
      toAddress: TronAddress(json['to_address']),
      amount: BigintUtils.parse(json['amount']),
    );
  }

  /// Create a new [TransferAssetContract] instance with specified parameters.
  TransferAssetContract(
      {required List<int> assetName,
      required this.ownerAddress,
      required this.toAddress,
      required this.amount})
      : assetName = BytesUtils.toBytes(assetName, unmodifiable: true);

  /// Token id
  final List<int> assetName;

  /// Owner address
  final TronAddress ownerAddress;

  /// receiving address
  final TronAddress toAddress;

  /// amount
  final BigInt amount;

  @override
  List<int> get fieldIds => [1, 2, 3, 4];

  @override
  List get values => [assetName, ownerAddress, toAddress, amount];

  /// Convert the [TransferAssetContract] object to a JSON representation.
  @override
  Map<String, dynamic> toJson() {
    return {
      "owner_address": ownerAddress.toString(),
      "to_address": toAddress.toString(),
      "asset_name": StringUtils.decode(assetName),
      "amount": amount.toString()
    }..removeWhere((key, value) => value == null);
  }

  /// Convert the [TransferAssetContract] object to its string representation.
  @override
  String toString() {
    return "TransferAssetContract{${toJson()}}";
  }

  @override
  TransactionContractType get contractType =>
      TransactionContractType.transferAssetContract;
}
