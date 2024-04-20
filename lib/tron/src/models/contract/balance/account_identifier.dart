import 'package:on_chain/tron/src/address/tron_address.dart';
import 'package:on_chain/tron/src/models/contract/base_contract/base.dart';
import 'package:on_chain/tron/src/protbuf/decoder.dart';

class AccountIdentifier extends TronProtocolBufferImpl {
  /// Create a new [AccountIdentifier] instance by parsing a JSON map.
  factory AccountIdentifier.fromJson(Map<String, dynamic> json) {
    return AccountIdentifier(address: TronAddress(json["address"]));
  }

  factory AccountIdentifier.deserialize(List<int> bytes) {
    final decode = TronProtocolBufferImpl.decode(bytes);
    return AccountIdentifier(
        address: TronAddress.fromBytes(decode.getField(1)));
  }

  /// Create a new [AccountIdentifier] instance with specified parameters.
  AccountIdentifier({required this.address});
  final TronAddress address;

  @override
  List<int> get fieldIds => [1];

  @override
  List get values => [address];

  /// Create a new [AccountIdentifier] instance by parsing a JSON map.
  @override
  Map<String, dynamic> toJson() {
    return {
      "address": address.toString(),
    };
  }

  /// Convert the [AccountIdentifier] object to its string representation.
  @override
  String toString() {
    return "AccountIdentifier{${toJson()}}";
  }
}
