import 'package:blockchain_utils/blockchain_utils.dart';
import 'package:on_chain/solana/src/layout/layout.dart';

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

  static final Structure staticLayout = LayoutUtils.struct([
    LayoutUtils.string("name"),
    LayoutUtils.string("uri"),
    LayoutUtils.blob(32, property: "hash")
  ], "hiddenSettings");

  @override
  Structure get layout => staticLayout;

  @override
  Map<String, dynamic> serialize() {
    return {"name": name, "uri": uri, "hash": hash};
  }

  @override
  String toString() {
    return "CandyMachineHiddenSettings${serialize()}";
  }
}
