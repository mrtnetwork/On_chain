import 'package:blockchain_utils/binary/binary.dart';
import 'package:blockchain_utils/layout/layout.dart';
import 'package:on_chain/solana/src/borsh_serialization/program_layout.dart';

class CandyMachineHiddenSettings extends LayoutSerializable {
  final String name;
  final String uri;
  final List<int> hash;
  CandyMachineHiddenSettings(
      {required this.name, required this.uri, required List<int> hash})
      : assert(hash.length == 32, "Hash must be exactly 32 bytes."),
        hash = BytesUtils.toBytes(hash, unmodifiable: true);
  factory CandyMachineHiddenSettings.fromJson(Map<String, dynamic> json) {
    return CandyMachineHiddenSettings(
        name: json["name"], uri: json["uri"], hash: json["hash"]);
  }

  static final StructLayout staticLayout = LayoutConst.struct([
    LayoutConst.string(property: "name"),
    LayoutConst.string(property: "uri"),
    LayoutConst.blob(32, property: "hash")
  ], property: "hiddenSettings");

  @override
  StructLayout get layout => staticLayout;

  @override
  Map<String, dynamic> serialize() {
    return {"name": name, "uri": uri, "hash": hash};
  }

  @override
  String toString() {
    return "CandyMachineHiddenSettings${serialize()}";
  }
}
