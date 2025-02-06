import 'package:blockchain_utils/cbor/cbor.dart';
import 'package:blockchain_utils/utils/utils.dart';
import 'package:on_chain/ada/src/exception/exception.dart';
import 'package:on_chain/ada/src/serialization/cbor_serialization.dart';

class UnitInterval with ADASerialization {
  static const List<int> _cborTag = [30];
  final BigInt numerator;
  final BigInt denominator;

  const UnitInterval({required this.numerator, required this.denominator});
  UnitInterval copyWith({BigInt? numerator, BigInt? denominator}) {
    return UnitInterval(
        numerator: numerator ?? this.numerator,
        denominator: denominator ?? this.denominator);
  }

  factory UnitInterval.deserialize(CborTagValue cbor) {
    if (!BytesUtils.bytesEqual(cbor.tags, _cborTag)) {
      throw ADAPluginException('Invalid UnitInterval cbor tag.',
          details: {'expected': _cborTag, 'Tag': cbor.tags});
    }
    final cborList = cbor.getValue<CborListValue>();
    return UnitInterval(
        numerator: cborList.getIndex<CborObject>(0).getInteger(),
        denominator: cborList.getIndex<CborObject>(1).getInteger());
  }
  factory UnitInterval.fromJson(Map<String, dynamic> json) {
    return UnitInterval(
        numerator: BigintUtils.parse(json['numerator']),
        denominator: BigintUtils.parse(json['denominator']));
  }

  @override
  CborObject toCbor() {
    return CborTagValue(
        CborListValue.fixedLength([
          CborUnsignedValue.u64(numerator),
          CborUnsignedValue.u64(denominator)
        ]),
        _cborTag);
  }

  @override
  Map<String, dynamic> toJson() {
    return {
      'numerator': numerator.toString(),
      'denominator': denominator.toString()
    };
  }
}
