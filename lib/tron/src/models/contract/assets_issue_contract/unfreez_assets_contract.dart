import 'package:on_chain/tron/src/address/tron_address.dart';
import 'package:on_chain/tron/src/models/contract/base_contract/base.dart';
import 'package:on_chain/tron/src/protbuf/decoder.dart';

/// Unstake a token that has passed the minimum freeze duration.
class UnfreezeAssetContract extends TronBaseContract {
  /// Create a new [UnfreezeAssetContract] instance with specified parameters.
  UnfreezeAssetContract({required this.ownerAddress});

  /// Create a new [UnfreezeAssetContract] instance by parsing a JSON map.
  factory UnfreezeAssetContract.fromJson(Map<String, dynamic> json) {
    return UnfreezeAssetContract(
        ownerAddress: TronAddress(json["owner_address"]));
  }
  factory UnfreezeAssetContract.deserialize(List<int> bytes) {
    final decode = TronProtocolBufferImpl.decode(bytes);
    return UnfreezeAssetContract(
        ownerAddress: TronAddress.fromBytes(decode.getField(1)));
  }

  /// owner Address
  final TronAddress ownerAddress;

  @override
  List<int> get fieldIds => [1];

  @override
  List get values => [ownerAddress];

  /// Convert the [UnfreezeAssetContract] object to a JSON representation.
  @override
  Map<String, dynamic> toJson() {
    return {"owner_address": ownerAddress.toString()};
  }

  /// Convert the [UnfreezeAssetContract] object to its string representation.
  @override
  String toString() {
    return "UnfreezeAssetContract{${toJson()}}";
  }

  @override
  TransactionContractType get contractType =>
      TransactionContractType.unfreezeAssetContract;
}
