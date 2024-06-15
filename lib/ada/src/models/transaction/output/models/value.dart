import 'package:blockchain_utils/cbor/cbor.dart';
import 'package:blockchain_utils/utils/utils.dart';
import 'package:on_chain/ada/src/serialization/cbor_serialization.dart';
import 'package:on_chain/ada/src/models/transaction/output/models/multi_assets.dart';

/// Represents the value of an output.
class Value with ADASerialization {
  /// The amount of the coin.
  final BigInt coin;

  /// The multi-asset.
  final MultiAsset? multiAsset;

  /// Constructs a [Value] instance.
  const Value({required this.coin, this.multiAsset});

  /// Deserializes a [Value] instance from a CBOR object.
  factory Value.deserialize(CborObject cbor) {
    if (cbor is CborListValue) {
      return Value(
          coin: cbor.getIndex<CborObject>(0).getInteger(),
          multiAsset: MultiAsset.deserialize(cbor.getIndex(1)));
    }
    return Value(coin: cbor.getInteger());
  }
  factory Value.fromJson(Map<String, dynamic> json) {
    return Value(
        coin: BigintUtils.parse(json["coin"]),
        multiAsset: json["multiasset"] == null
            ? null
            : MultiAsset.fromJson(json["multiasset"]));
  }

  Value copyWith({
    BigInt? coin,
    MultiAsset? multiAsset,
  }) {
    return Value(
        coin: coin ?? this.coin, multiAsset: multiAsset ?? this.multiAsset);
  }

  @override
  CborObject toCbor() {
    if (multiAsset == null) return CborUnsignedValue.u64(coin);
    return CborListValue.fixedLength(
        [CborUnsignedValue.u64(coin), multiAsset!.toCbor()]);
  }

  @override
  Map<String, dynamic> toJson() {
    return {"coin": coin.toString(), "multiasset": multiAsset?.toJson()};
  }
}
