import 'package:blockchain_utils/cbor/cbor.dart';
import 'package:on_chain/ada/src/models/unit_interval.dart';
import 'package:on_chain/ada/src/serialization/cbor_serialization.dart';

class ExUnitPrices with ADASerialization {
  final UnitInterval memPrice;
  final UnitInterval stepPrice;
  const ExUnitPrices({required this.memPrice, required this.stepPrice});
  factory ExUnitPrices.deserialize(CborListValue cbor) {
    return ExUnitPrices(
        memPrice: UnitInterval.deserialize(cbor.getIndex(0)),
        stepPrice: UnitInterval.deserialize(cbor.getIndex(1)));
  }
  factory ExUnitPrices.fromJson(Map<String, dynamic> json) {
    return ExUnitPrices(
        memPrice: UnitInterval.fromJson(json["mem_price"]),
        stepPrice: UnitInterval.fromJson(json["step_price"]));
  }
  ExUnitPrices copyWith({
    UnitInterval? memPrice,
    UnitInterval? stepPrice,
  }) {
    return ExUnitPrices(
      memPrice: memPrice ?? this.memPrice,
      stepPrice: stepPrice ?? this.stepPrice,
    );
  }

  @override
  CborObject toCbor() {
    return CborListValue.fixedLength([
      memPrice.toCbor(),
      stepPrice.toCbor(),
    ]);
  }

  @override
  Map<String, dynamic> toJson() {
    return {"mem_price": memPrice.toJson(), "step_price": stepPrice.toJson()};
  }
}
