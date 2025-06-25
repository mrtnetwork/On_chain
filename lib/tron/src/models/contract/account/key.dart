import 'package:on_chain/tron/src/address/tron_address.dart';
import 'package:on_chain/tron/src/models/contract/base_contract/base.dart';
import 'package:on_chain/tron/src/protbuf/decoder.dart';
import 'package:on_chain/utils/utils/utils.dart';

class TronKey extends TronProtocolBufferImpl {
  /// Create a new [TronKey] instance by parsing a JSON map.
  factory TronKey.fromJson(Map<String, dynamic> json) {
    return TronKey(
        address: OnChainUtils.parseTronAddress(
            value: json['address'], name: 'address'),
        weight:
            OnChainUtils.parseBigInt(value: json['weight'], name: 'weight'));
  }
  factory TronKey.deserialize(List<int> bytes) {
    final decode = TronProtocolBufferImpl.decode(bytes);

    return TronKey(
        address: TronAddress.fromBytes(decode.getField(1)),
        weight: decode.getField(2));
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
  Map<String, dynamic> toJson({bool visible = true}) {
    return {'address': address.toAddress(visible), 'weight': weight};
  }

  /// Convert the [TronKey] object to its string representation.
  @override
  String toString() {
    return 'TronKey{${toJson()}}';
  }
}
