import 'package:on_chain/tron/src/address/tron_address.dart';
import 'package:on_chain/tron/src/models/contract/base_contract/base.dart';
import 'package:on_chain/tron/src/protbuf/decoder.dart';
import 'package:on_chain/utils/utils.dart';

/// Update the consume_user_resource_percent parameter of a smart contract
class UpdateSettingContract extends TronBaseContract {
  /// Create a new [UpdateSettingContract] instance by parsing a JSON map.
  factory UpdateSettingContract.fromJson(Map<String, dynamic> json) {
    return UpdateSettingContract(
      ownerAddress: OnChainUtils.parseTronAddress(
          value: json['owner_address'], name: 'owner_address'),
      contractAddress: OnChainUtils.parseTronAddress(
          value: json['contract_address'], name: 'contract_address'),
      consumeUserResourcePercent: OnChainUtils.parseBigInt(
          value: json['consume_user_resource_percent'],
          name: 'consume_user_resource_percent'),
    );
  }

  /// Create a new [UpdateSettingContract] instance with specified parameters.
  UpdateSettingContract(
      {required this.ownerAddress,
      required this.contractAddress,
      this.consumeUserResourcePercent});
  factory UpdateSettingContract.deserialize(List<int> bytes) {
    final decode = TronProtocolBufferImpl.decode(bytes);
    return UpdateSettingContract(
        ownerAddress: TronAddress.fromBytes(decode.getField(1)),
        contractAddress: TronAddress.fromBytes(decode.getField(2)),
        consumeUserResourcePercent: decode.getField(3));
  }

  /// Account address
  @override
  final TronAddress ownerAddress;

  /// Contract address
  final TronAddress contractAddress;

  /// User Energy Proportion
  final BigInt? consumeUserResourcePercent;

  @override
  List<int> get fieldIds => [1, 2, 3];

  /// Convert the [UpdateSettingContract] object to a JSON representation.
  @override
  Map<String, dynamic> toJson({bool visible = true}) {
    return {
      'owner_address': ownerAddress.toAddress(visible),
      'contract_address': contractAddress.toAddress(visible),
      'consume_user_resource_percent': consumeUserResourcePercent?.toString(),
    }..removeWhere((key, value) => value == null);
  }

  @override
  List get values =>
      [ownerAddress, contractAddress, consumeUserResourcePercent];

  /// Convert the [UpdateSettingContract] object to its string representation.
  @override
  String toString() {
    return 'UpdateSettingContract{${toJson()}}';
  }

  @override
  TransactionContractType get contractType =>
      TransactionContractType.updateSettingContract;
}
