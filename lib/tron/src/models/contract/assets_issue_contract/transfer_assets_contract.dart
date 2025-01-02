import 'package:on_chain/tron/src/address/tron_address.dart';
import 'package:on_chain/tron/src/models/contract/base_contract/base.dart';
import 'package:blockchain_utils/blockchain_utils.dart';
import 'package:on_chain/tron/src/protbuf/decoder.dart';
import 'package:on_chain/utils/utils/utils.dart';

/// Transfer TRC10 token.
class TransferAssetContract extends TronBaseContract {
  /// Create a new [TransferAssetContract] instance by parsing a JSON map.
  factory TransferAssetContract.fromJson(Map<String, dynamic> json) {
    return TransferAssetContract(
      assetName: OnChainUtils.parseBytes(
          value: json['asset_name'], name: 'asset_name'),
      ownerAddress: OnChainUtils.parseTronAddress(
          value: json['owner_address'], name: 'owner_address'),
      toAddress: OnChainUtils.parseTronAddress(
          value: json['to_address'], name: 'to_address'),
      amount: OnChainUtils.parseBigInt(value: json['amount'], name: 'amount'),
    );
  }

  /// Create a new [TransferAssetContract] instance with specified parameters.
  TransferAssetContract(
      {required List<int> assetName,
      required this.ownerAddress,
      required this.toAddress,
      required this.amount})
      : assetName = BytesUtils.toBytes(assetName, unmodifiable: true);
  factory TransferAssetContract.deserialize(List<int> bytes) {
    final decode = TronProtocolBufferImpl.decode(bytes);
    return TransferAssetContract(
        ownerAddress: TronAddress.fromBytes(decode.getField(2)),
        toAddress: TronAddress.fromBytes(decode.getField(3)),
        assetName: decode.getField(1),
        amount: decode.getField(4));
  }

  /// Token id
  final List<int> assetName;

  String get assestId => StringUtils.decode(assetName);

  /// Owner address
  @override
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
      'owner_address': ownerAddress.toString(),
      'to_address': toAddress.toString(),
      'asset_name': StringUtils.decode(assetName),
      'amount': amount.toString()
    }..removeWhere((key, value) => value == null);
  }

  /// Convert the [TransferAssetContract] object to its string representation.
  @override
  String toString() {
    return 'TransferAssetContract{${toJson()}}';
  }

  @override
  TransactionContractType get contractType =>
      TransactionContractType.transferAssetContract;
}
