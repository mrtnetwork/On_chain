import 'package:on_chain/solana/src/exception/exception.dart';
import 'package:blockchain_utils/layout/layout.dart';
import 'package:on_chain/solana/src/borsh_serialization/program_layout.dart';

class MetadataPointerInstruction extends LayoutSerializable {
  const MetadataPointerInstruction._(this.name);
  final String name;
  static const MetadataPointerInstruction initialize =
      MetadataPointerInstruction._("Initialize");
  static const MetadataPointerInstruction update =
      MetadataPointerInstruction._("Update");

  static const List<MetadataPointerInstruction> values = [initialize, update];

  static StructLayout staticLayout = LayoutConst.struct([
    LayoutConst.rustEnum(
        values.map((e) => LayoutConst.none(property: e.name)).toList(),
        property: "metadataPointer")
  ]);
  @override
  StructLayout get layout => staticLayout;

  @override
  Map<String, dynamic> serialize() {
    return {
      "metadataPointer": {name: null}
    };
  }

  factory MetadataPointerInstruction.fromJson(Map<String, dynamic> json) {
    return fromName(json["metadataPointer"]["key"]);
  }
  static MetadataPointerInstruction fromName(String? value) {
    return values.firstWhere(
      (element) => element.name == value,
      orElse: () => throw SolanaPluginException(
          "No MetadataPointerInstruction found matching the specified value",
          details: {"value": value}),
    );
  }

  @override
  String toString() {
    return "MetadataPointerInstruction${serialize()}";
  }
}
