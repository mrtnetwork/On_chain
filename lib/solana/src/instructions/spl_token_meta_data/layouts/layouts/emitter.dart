import 'package:on_chain/solana/src/instructions/spl_token_meta_data/layouts/instruction/instruction.dart';
import 'package:blockchain_utils/layout/layout.dart';

/// Emits the token-metadata as return data layout.
class SPLTokenMetaDataEmitLayout extends SPLTokenMetaDataProgramLayout {
  /// Start of range of data to emit.
  final BigInt? start;

  /// End of range of data to emit
  final BigInt? end;

  /// Constructs a new instance of [SPLTokenMetaDataEmitLayout] with the provided start and end values.
  const SPLTokenMetaDataEmitLayout({this.start, this.end});

  /// Decodes the provided byte array to construct a new [SPLTokenMetaDataEmitLayout] instance.
  factory SPLTokenMetaDataEmitLayout.fromBuffer(List<int> bytes) {
    final decode = SPLTokenMetaDataProgramLayout.decodeAndValidateStruct(
        layout: _layout,
        bytes: bytes,
        instructionBytes:
            SPLTokenMetaDataProgramSplDiscriminate.emit.insturction);

    return SPLTokenMetaDataEmitLayout(
        end: decode["end"], start: decode["start"]);
  }

  /// The layout structure for this emit instruction.
  static final StructLayout _layout = LayoutConst.struct([
    LayoutConst.blob(8, property: "instruction"),
    LayoutConst.optionU64(property: "start"),
    LayoutConst.optionU64(property: "end")
  ]);

  /// Gets the layout structure of this emit instruction.
  @override
  StructLayout get layout => _layout;

  /// Gets the instruction bytes for the emit instruction.
  @override
  List<int> get instruction =>
      SPLTokenMetaDataProgramSplDiscriminate.emit.insturction;

  /// Serializes the emit instruction data.
  @override
  Map<String, dynamic> serialize() {
    return {"start": start, "end": end};
  }
}
