import 'package:on_chain/tron/src/address/tron_address.dart';
import 'package:on_chain/tron/src/models/contract/base_contract/base.dart';
import 'package:blockchain_utils/blockchain_utils.dart';
import 'package:on_chain/tron/src/protbuf/decoder.dart';
import 'package:on_chain/utils/utils.dart';

/// Participate in an asset issue.
class ParticipateAssetIssueContract extends TronBaseContract {
  /// Create a new [ParticipateAssetIssueContract] instance by parsing a JSON map.
  factory ParticipateAssetIssueContract.fromJson(Map<String, dynamic> json) {
    return ParticipateAssetIssueContract(
      ownerAddress: OnChainUtils.parseTronAddress(
          value: json['owner_address'], name: 'owner_address'),
      toAddress: OnChainUtils.parseTronAddress(
          value: json['to_address'], name: 'to_address'),
      assetName: OnChainUtils.parseBytes(
          value: json['asset_name'], name: 'asset_name'),
      amount: OnChainUtils.parseBigInt(value: json['amount'], name: 'amount'),
    );
  }

  /// Create a new [ParticipateAssetIssueContract] instance with specified parameters.
  ParticipateAssetIssueContract(
      {required this.ownerAddress,
      required this.toAddress,
      required List<int> assetName,
      required this.amount})
      : assetName = BytesUtils.toBytes(assetName, unmodifiable: true);
  factory ParticipateAssetIssueContract.deserialize(List<int> bytes) {
    final decode = TronProtocolBufferImpl.decode(bytes);
    return ParticipateAssetIssueContract(
        ownerAddress: TronAddress.fromBytes(decode.getField(1)),
        toAddress: TronAddress.fromBytes(decode.getField(2)),
        assetName: decode.getField(3),
        amount: decode.getField(4));
  }

  /// Account address
  @override
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
  Map<String, dynamic> toJson({bool visible = true}) {
    return {
      'to_address': toAddress.toAddress(visible),
      'owner_address': ownerAddress.toAddress(visible),
      'amount': amount.toString(),
      'asset_name': StringUtils.decode(assetName)
    };
  }

  /// Convert the [ParticipateAssetIssueContract] object to its string representation.
  @override
  String toString() {
    return 'ParticipateAssetIssueContract{${toJson()}}';
  }

  @override
  TransactionContractType get contractType =>
      TransactionContractType.participateAssetIssueContract;
}
