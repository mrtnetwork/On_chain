import 'package:on_chain/solana/src/instructions/spl_token_meta_data/layouts/instruction/instruction.dart';
import 'package:blockchain_utils/layout/layout.dart';

/// Initializes a TLV layout.
class SPLTokenMetaDataInitializeLayout extends SPLTokenMetaDataProgramLayout {
  /// Longer name of the token
  final String name;

  /// URI pointing to more metadata (image, video, etc.)
  final String uri;

  /// Shortened symbol of the token
  final String symbol;

  /// Constructs a new instance of [SPLTokenMetaDataInitializeLayout] with the provided name, URI, and symbol.
  const SPLTokenMetaDataInitializeLayout._(this.name, this.uri, this.symbol);

  /// Constructs a new instance of [SPLTokenMetaDataInitializeLayout] from the provided name, URI, and symbol.
  factory SPLTokenMetaDataInitializeLayout({
    required String name,
    required String uri,
    required String symbol,
  }) {
    return SPLTokenMetaDataInitializeLayout._(name, uri, symbol);
  }

  /// Decodes the provided byte array to construct a new [SPLTokenMetaDataInitializeLayout] instance.
  factory SPLTokenMetaDataInitializeLayout.fromBuffer(List<int> data) {
    Map<String, dynamic> decode =
        SPLTokenMetaDataProgramLayout.decodeAndValidateStruct(
            layout: staticLayout,
            bytes: data,
            instructionBytes:
                SPLTokenMetaDataProgramSplDiscriminate.initialize.insturction);
    return SPLTokenMetaDataInitializeLayout(
        name: decode["name"], uri: decode["uri"], symbol: decode["symbol"]);
  }

  /// Creates a static layout based on the provided lengths of name, symbol, and URI bytes.
  static final StructLayout staticLayout = LayoutConst.struct([
    LayoutConst.blob(8, property: "instruction"),
    LayoutConst.string(property: "name"),
    LayoutConst.string(property: "symbol"),
    LayoutConst.string(property: "uri"),
  ]);

  /// The layout structure of this create instruction.
  @override
  StructLayout get layout => staticLayout;

  /// Gets the instruction bytes for the create instruction.
  @override
  SPLTokenMetaDataProgramSplDiscriminate get instruction =>
      SPLTokenMetaDataProgramSplDiscriminate.initialize;

  /// Serializes the create instruction data.
  @override
  Map<String, dynamic> serialize() {
    return {
      "name": name,
      "symbol": symbol,
      "uri": uri,
    };
  }
}
