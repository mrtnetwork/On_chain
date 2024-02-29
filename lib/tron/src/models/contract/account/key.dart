import 'package:on_chain/tron/src/address/tron_address.dart';
import 'package:on_chain/tron/src/models/contract/base_contract/base.dart';
import 'package:blockchain_utils/blockchain_utils.dart';

class TronKey extends TronProtocolBufferImpl {
  /// Create a new [TronKey] instance by parsing a JSON map.
  factory TronKey.fromJson(Map<String, dynamic> json) {
    return TronKey(
        address: TronAddress(json["address"]),
        weight: BigintUtils.parse(json["weight"]));
  }

  /// Create a new [TronKey] instance with specified parameters.
  TronKey({required this.address, required this.weight});

  /// Signer
  final TronAddress address;

  /// Weight
  final BigInt weight;

  /// Create a new [TronKey] instance by copying the existing one
  /// and replacing specified fields with new values.
  TronKey copyWith({
    TronAddress? address,
    BigInt? weight,
  }) {
    return TronKey(
      address: address ?? this.address,
      weight: weight ?? this.weight,
    );
  }

  @override
  List<int> get fieldIds => [1, 2];

  @override
  List get values => [address, weight];

  /// Convert the [TronKey] object to a JSON representation.
  @override
  Map<String, dynamic> toJson() {
    return {
      "address": address,
      "weight": weight,
    };
  }

  /// Convert the [TronKey] object to its string representation.
  @override
  String toString() {
    return "TronKey{${toJson()}}";
  }
}
