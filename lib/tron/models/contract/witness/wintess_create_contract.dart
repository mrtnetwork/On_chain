import 'package:on_chain/tron/address/tron_address.dart';
import 'package:on_chain/tron/models/contract/base_contract/base.dart';
import 'package:blockchain_utils/blockchain_utils.dart';

class WitnessCreateContract extends TronBaseContract {
  /// Create a new [WitnessCreateContract] instance by parsing a JSON map.
  factory WitnessCreateContract.fromJson(Map<String, dynamic> json) {
    final ownerAddress = TronAddress(json['owner_address']);
    final url = StringUtils.tryEncode(json['url']);

    return WitnessCreateContract(
      ownerAddress: ownerAddress,
      url: url,
    );
  }

  /// Create a new [WitnessCreateContract] instance with specified parameters.
  WitnessCreateContract({required this.ownerAddress, List<int>? url})
      : url = BytesUtils.tryToBytes(url, unmodifiable: true);
  final TronAddress ownerAddress;
  final List<int>? url;

  @override
  List<int> get fieldIds => [1, 2];

  @override
  List get values => [ownerAddress, url];

  /// Convert the [WitnessCreateContract] object to a JSON representation.
  @override
  Map<String, dynamic> toJson() {
    return {
      "owner_address": ownerAddress.toString(),
      "url": StringUtils.tryDecode(url),
    };
  }

  /// Convert the [WitnessCreateContract] object to its string representation.
  @override
  String toString() {
    return "WitnessCreateContract{${toJson()}}";
  }

  @override
  TransactionContractType get contractType =>
      TransactionContractType.witnessCreateContract;
}
