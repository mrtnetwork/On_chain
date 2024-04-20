import 'package:on_chain/tron/src/address/tron_address.dart';
import 'package:on_chain/tron/src/models/contract/base_contract/base.dart';
import 'package:blockchain_utils/blockchain_utils.dart';
import 'package:on_chain/tron/src/protbuf/decoder.dart';

class AccountId extends TronProtocolBufferImpl {
  ///     final decode = TronProtocolBufferImpl.decode(bytes);

  factory AccountId.fromJson(Map<String, dynamic> json) {
    return AccountId(
        name: StringUtils.tryEncode(json["name"]),
        address: TronAddress(json["address"]));
  }
  factory AccountId.deserialize(List<int> bytes) {
    final decode = TronProtocolBufferImpl.decode(bytes);
    return AccountId(
        name: decode.getField(1),
        address: TronAddress.fromBytes(decode.getField(2)));
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
