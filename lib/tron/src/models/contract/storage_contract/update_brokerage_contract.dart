import 'package:on_chain/tron/src/address/tron_address.dart';
import 'package:on_chain/tron/src/models/contract/base_contract/base.dart';
import 'package:on_chain/tron/src/protbuf/decoder.dart';
import 'package:on_chain/utils/utils.dart';

class UpdateBrokerageContract extends TronBaseContract {
  /// Create a new [UpdateBrokerageContract] instance with specified parameters.
  UpdateBrokerageContract({required this.ownerAddress, this.brokerage});

  /// Create a new [UpdateBrokerageContract] instance by parsing a JSON map.
  factory UpdateBrokerageContract.fromJson(Map<String, dynamic> json) {
    return UpdateBrokerageContract(
      ownerAddress: OnChainUtils.parseTronAddress(
          value: json["owner_address"], name: "owner_address"),
      brokerage:
          OnChainUtils.parseInt(value: json["brokerage"], name: "brokerage"),
    );
  }
  factory UpdateBrokerageContract.deserialize(List<int> bytes) {
    final decode = TronProtocolBufferImpl.decode(bytes);
    return UpdateBrokerageContract(
        ownerAddress: TronAddress.fromBytes(decode.getField(1)),
        brokerage: decode.getField(2));
  }

  /// Account address
  @override
  final TronAddress ownerAddress;

  /// Dividend ratio, from 0 to 100, 1 represents 1%
  final int? brokerage;

  @override
  List<int> get fieldIds => [1, 2];

  @override
  List get values => [ownerAddress, brokerage];

  /// Convert the [UpdateBrokerageContract] object to a JSON representation.
  @override
  Map<String, dynamic> toJson() {
    return {
      "owner_address": ownerAddress.toString(),
      "brokerage": brokerage,
    };
  }

  /// Convert the [UpdateBrokerageContract] object to its string representation.
  @override
  String toString() {
    return "UpdateBrokerageContract{${toJson()}}";
  }

  @override
  TransactionContractType get contractType =>
      TransactionContractType.updateBrokerageContract;
}
