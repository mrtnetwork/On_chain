// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: prefer_const_constructors, unused_import

import 'package:blockchain_utils/blockchain_utils.dart';
import 'package:on_chain/icp/src/address/address.dart';
import 'package:on_chain/icp/src/serialization/serialization.dart';
import '../../utils/utils.dart';

/// Candid type alias `SupportedStandardsResponse`.
typedef ICRC10SupportedStandardsResponse = List<ICRC10SupportedStandard>;

/// CType for alias `SupportedStandardsResponse`.
abstract final class ICRC10SupportedStandardsResponseCandid {
  static CType get ctype => CType.vec(ICRC10SupportedStandard.ctype);
}

/// Candid record `SupportedStandard`.
final class ICRC10SupportedStandard with CandidSerializable {
  final String name;
  final String url;

  const ICRC10SupportedStandard({required this.name, required this.url});

  static CType get ctype => CType.record([
    Field(Label.named('name'), CType.text),
    Field(Label.named('url'), CType.text),
  ]);

  @override
  CType get candidType => ctype;

  @override
  dynamic get candidValue => {'name': name, 'url': url};

  Map<String, dynamic> toJson() => {'name': name, 'url': url};

  factory ICRC10SupportedStandard.fromCandid(Map<String, dynamic> json) {
    return ICRC10SupportedStandard(
      name: json.valueAsString<String>('name'),
      url: json.valueAsString<String>('url'),
    );
  }

  factory ICRC10SupportedStandard.fromBytes(List<int> bytes) {
    final raw = CandidUtils.decodeOneTyped(bytes, ctype);
    return ICRC10SupportedStandard.fromCandid(
      JsonParser.valueEnsureAsMap<String, dynamic>(raw),
    );
  }
}
