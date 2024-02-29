import 'package:blockchain_utils/exception/exception.dart';
import 'package:on_chain/solana/src/layout/layout.dart';

class MetadataPointerInstruction extends LayoutSerializable {
  const MetadataPointerInstruction._(this.name);
  final String name;
  static const MetadataPointerInstruction initialize =
      MetadataPointerInstruction._("Initialize");
  static const MetadataPointerInstruction update =
      MetadataPointerInstruction._("Update");

  static const List<MetadataPointerInstruction> values = [initialize, update];

  static Structure staticLayout = LayoutUtils.struct([
    LayoutUtils.rustEnum(
        values.map((e) => LayoutUtils.none(e.name)).toList(), LayoutUtils.u8(),
        property: "metadataPointer")
  ]);
  @override
  Structure get layout => staticLayout;

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
      orElse: () => throw MessageException(
          "No MetadataPointerInstruction found matching the specified value",
          details: {"value": value}),
    );
  }

  @override
  String toString() {
    return "MetadataPointerInstruction${serialize()}";
  }
}
