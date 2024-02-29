import 'package:on_chain/solana/src/layout/layout.dart';

/// Represents an unknown program layout.
class UnknownProgramLayout extends ProgramLayout {
  /// The data of the unknown program layout.
  const UnknownProgramLayout(this.data);
  final List<int> data;
  @override
  get instruction => null;

  @override
  Structure get layout =>
      LayoutUtils.struct([LayoutUtils.blob(data.length, property: "data")]);

  /// Serializes the unknown program layout.
  @override
  Map<String, dynamic> serialize() {
    return {"data": data};
  }

  /// Converts the unknown program layout to bytes.
  @override
  List<int> toBytes() {
    return data;
  }
}
