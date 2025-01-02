import 'package:blockchain_utils/blockchain_utils.dart';
import 'package:on_chain/ada/src/exception/exception.dart';
import 'package:on_chain/ada/src/serialization/cbor_serialization.dart';

class Language with ADASerialization {
  final String name;
  final int value;
  final int scriptHashNameSpace;
  const Language._(this.name, this.value, this.scriptHashNameSpace);
  factory Language.deserialize(CborObject cbor) {
    if (cbor is CborBytesValue) {
      final decodingView = CborObject.fromCbor(cbor.value)
          .cast<CborIntValue>('Invalid language view encoding cbor bytes.');
      return fromValue(decodingView.value);
    }
    return fromValue(
        cbor.cast<CborIntValue>('Invalid language cbor bytes.').value);
  }
  static const Language plutusV1 = Language._('plutus_v1', 0, 1);
  static const Language plutusV2 = Language._('plutus_v2', 1, 2);

  static const List<Language> values = [plutusV1, plutusV2];

  @override
  String toString() {
    return 'Language.$name';
  }

  @override
  CborObject toCbor([bool serialize = false]) {
    if (serialize) return CborBytesValue(CborIntValue(value).encode());
    return CborIntValue(value);
  }

  static Language fromValue(int? value) {
    return values.firstWhere(
      (element) => element.value == value,
      orElse: () => throw ADAPluginException(
          'No Language found matching the specified value',
          details: {'value': value}),
    );
  }

  static Language fromName(String? name) {
    return values.firstWhere(
      (element) => element.name == name,
      orElse: () => throw ADAPluginException(
          'No Language found matching the specified name',
          details: {'name': name}),
    );
  }

  @override
  String toJson() {
    return name;
  }
}
