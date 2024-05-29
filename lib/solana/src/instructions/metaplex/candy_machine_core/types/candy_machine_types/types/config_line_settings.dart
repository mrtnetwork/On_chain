import 'package:blockchain_utils/layout/layout.dart';
import 'package:on_chain/solana/src/borsh_serialization/program_layout.dart';

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

  static final StructLayout staticLayout = LayoutConst.struct([
    LayoutConst.string(property: "prefixName"),
    LayoutConst.u32(property: "nameLength"),
    LayoutConst.string(property: "prefixUri"),
    LayoutConst.u32(property: "uriLength"),
    LayoutConst.boolean(property: "isSequential"),
  ], property: "configLineSettings");

  @override
  StructLayout get layout => staticLayout;
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
