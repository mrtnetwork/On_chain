// Imports the necessary packages for interacting with blockchain utilities and Solana's layout structure.
import 'package:on_chain/solana/src/instructions/spl_token_meta_data/layouts/instruction/instruction.dart';
import 'package:on_chain/solana/src/layout/layout.dart';
import 'package:on_chain/solana/src/instructions/spl_token_meta_data/types/types/field.dart';

/// Updates a field in a token-metadata account layout.
class SPLTokenMetaDataUpdateLayout extends SPLTokenMetaDataProgramLayout {
  /// Field to update in the metadata
  final SPLTokenMetaDataField field;

  /// Constructs a new instance of [SPLTokenMetaDataUpdateLayout] with the provided field, value, and instruction.
  const SPLTokenMetaDataUpdateLayout({required this.field});

  /// Decodes the provided byte array to construct a new `SPLTokenMetaDataUpdateLayout` instance.
  factory SPLTokenMetaDataUpdateLayout.fromBuffer(List<int> bytes) {
    Map<String, dynamic> decode =
        SPLTokenMetaDataProgramLayout.decodeAndValidateStruct(
            layout: _layout,
            bytes: bytes,
            instructionBytes:
                SPLTokenMetaDataProgramSplDiscriminate.update.insturction);

    return SPLTokenMetaDataUpdateLayout(
        field: SPLTokenMetaDataField.fromJson(decode["metaDataField"]));
  }

  /// Creates a static layout based on the provided value length and key length.
  static final _layout = LayoutUtils.struct([
    LayoutUtils.blob(8, property: "instruction"),
    LayoutUtils.wrap(SPLTokenMetaDataField.staticLayout,
        property: "metaDataField")
  ]);

  /// The layout structure of this update instruction.
  @override
  Structure get layout => _layout;

  /// Gets the instruction bytes for the update instruction.
  @override
  List<int> get instruction =>
      SPLTokenMetaDataProgramSplDiscriminate.update.insturction;

  /// Serializes the update instruction data.
  @override
  Map<String, dynamic> serialize() {
    return {"metaDataField": field.serialize()};
  }
}
