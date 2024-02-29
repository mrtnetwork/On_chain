import 'package:on_chain/tron/src/address/tron_address.dart';
import 'package:on_chain/tron/src/models/contract/base_contract/base.dart';
import 'package:blockchain_utils/blockchain_utils.dart';

class WitnessUpdateContract extends TronBaseContract {
  /// Create a new [WitnessUpdateContract] instance by parsing a JSON map.
  factory WitnessUpdateContract.fromJson(Map<String, dynamic> json) {
    final ownerAddress = TronAddress(json['owner_address']);
    final updateUrl = StringUtils.tryEncode(json['update_url']);

    return WitnessUpdateContract(
      ownerAddress: ownerAddress,
      updateUrl: updateUrl,
    );
  }

  /// Create a new [WitnessUpdateContract] instance with specified parameters.
  WitnessUpdateContract({required this.ownerAddress, List<int>? updateUrl})
      : updateUrl = BytesUtils.tryToBytes(updateUrl, unmodifiable: true);
  final TronAddress ownerAddress;
  final List<int>? updateUrl;

  @override
  List<int> get fieldIds => [1, 12];

  @override
  List get values => [ownerAddress, updateUrl];

  /// Convert the [WitnessUpdateContract] object to a JSON representation.
  @override
  Map<String, dynamic> toJson() {
    return {
      "owner_address": ownerAddress.toString(),
      "update_url": StringUtils.tryDecode(updateUrl),
    };
  }

  /// Convert the [WitnessUpdateContract] object to its string representation.
  @override
  String toString() {
    return "WitnessUpdateContract{${toJson()}}";
  }

  @override
  TransactionContractType get contractType =>
      TransactionContractType.witnessUpdateContract;
}
