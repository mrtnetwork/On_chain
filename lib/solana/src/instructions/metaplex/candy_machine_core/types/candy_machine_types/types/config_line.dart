import 'package:blockchain_utils/layout/layout.dart';
import 'package:on_chain/solana/src/borsh_serialization/program_layout.dart';

class ConfigLine extends LayoutSerializable {
  final String name;
  final String uri;
  const ConfigLine({required this.name, required this.uri});
  factory ConfigLine.fromJson(Map<String, dynamic> json) {
    return ConfigLine(name: json['name'], uri: json['uri']);
  }

  static final StructLayout staticLayout = LayoutConst.struct([
    LayoutConst.string(property: 'name'),
    LayoutConst.string(property: 'uri')
  ], property: 'configLine');

  @override
  StructLayout get layout => staticLayout;
  @override
  Map<String, dynamic> serialize() {
    return {'name': name, 'uri': uri};
  }

  @override
  String toString() {
    return 'ConfigLine${serialize()}';
  }
}
