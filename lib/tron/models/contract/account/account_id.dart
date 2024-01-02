import 'package:on_chain/tron/address/tron_address.dart';
import 'package:on_chain/tron/models/contract/base_contract/base.dart';
import 'package:blockchain_utils/blockchain_utils.dart';

class AccountId extends TronProtocolBufferImpl {
  factory AccountId.fromJson(Map<String, dynamic> json) {
    return AccountId(
        name: StringUtils.tryEncode(json["name"]),
        address: TronAddress(json["address"]));
  }

  /// Factory method to create an instance of AccountId with an unmodifiable list for the 'name' field.
  AccountId({List<int>? name, required this.address})
      : name = BytesUtils.tryToBytes(name, unmodifiable: true);
  final TronAddress address;
  final List<int>? name;

  @override
  List<int> get fieldIds => [1, 2];

  @override
  List get values => [name, address];

  @override
  Map<String, dynamic> toJson() {
    return {"address": address.toString(), "name": StringUtils.tryDecode(name)}
      ..removeWhere((key, value) => value == null);
  }

  @override
  String toString() {
    return "AccountId{${toJson()}}";
  }
}
