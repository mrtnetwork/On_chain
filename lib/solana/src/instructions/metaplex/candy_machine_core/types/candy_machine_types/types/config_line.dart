import 'package:on_chain/solana/src/layout/layout.dart';

class ConfigLine extends LayoutSerializable {
  final String name;
  final String uri;
  const ConfigLine({required this.name, required this.uri});
  factory ConfigLine.fromJson(Map<String, dynamic> json) {
    return ConfigLine(name: json["name"], uri: json["uri"]);
  }

  static final Structure staticLayout = LayoutUtils.struct(
      [LayoutUtils.string("name"), LayoutUtils.string("uri")], "configLine");

  @override
  Structure get layout => staticLayout;
  @override
  Map<String, dynamic> serialize() {
    return {"name": name, "uri": uri};
  }

  @override
  String toString() {
    return "ConfigLine${serialize()}";
  }
}
