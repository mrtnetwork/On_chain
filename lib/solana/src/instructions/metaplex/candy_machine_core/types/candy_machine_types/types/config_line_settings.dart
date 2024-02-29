import 'package:on_chain/solana/src/layout/layout.dart';

class ConfigLineSettings extends LayoutSerializable {
  final String prefixName;
  final int nameLength;
  final String prefixUri;
  final int uriLength;
  final bool isSequential;

  const ConfigLineSettings(
      {required this.prefixName,
      required this.nameLength,
      required this.prefixUri,
      required this.uriLength,
      required this.isSequential});
  factory ConfigLineSettings.fromJson(Map<String, dynamic> json) {
    return ConfigLineSettings(
        prefixName: json["prefixName"],
        nameLength: json["nameLength"],
        prefixUri: json["prefixUri"],
        uriLength: json["uriLength"],
        isSequential: json["isSequential"]);
  }

  static final Structure staticLayout = LayoutUtils.struct([
    LayoutUtils.string("prefixName"),
    LayoutUtils.u32("nameLength"),
    LayoutUtils.string("prefixUri"),
    LayoutUtils.u32("uriLength"),
    LayoutUtils.boolean(property: "isSequential"),
  ], "configLineSettings");

  @override
  Structure get layout => staticLayout;
  @override
  Map<String, dynamic> serialize() {
    return {
      "prefixName": prefixName,
      "nameLength": nameLength,
      "prefixUri": prefixUri,
      "uriLength": uriLength,
      "isSequential": isSequential
    };
  }

  @override
  String toString() {
    return "ConfigLineSettings${serialize()}";
  }
}
