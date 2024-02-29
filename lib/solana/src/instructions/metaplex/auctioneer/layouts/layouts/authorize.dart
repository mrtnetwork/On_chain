import 'package:on_chain/solana/src/instructions/metaplex/auctioneer/layouts/instruction/instruction.dart';
import 'package:on_chain/solana/src/layout/layout.dart';

/// Auctioneer authorize Layout.
class MetaplexAuctioneerAuthorizeLayout
    extends MetaplexAuctioneerProgramLayout {
  const MetaplexAuctioneerAuthorizeLayout();

  /// Constructs the layout from raw bytes.
  factory MetaplexAuctioneerAuthorizeLayout.fromBuffer(List<int> data) {
    MetaplexAuctioneerProgramLayout.decodeAndValidateStruct(
        layout: _layout,
        bytes: data,
        instruction:
            MetaplexAuctioneerProgramInstruction.authorize.insturction);
    return MetaplexAuctioneerAuthorizeLayout();
  }

  /// Structure layout definition.
  static final Structure _layout =
      LayoutUtils.struct([LayoutUtils.blob(8, property: "instruction")]);

  @override
  Structure get layout => _layout;

  @override
  List<int> get instruction =>
      MetaplexAuctioneerProgramInstruction.authorize.insturction;

  @override
  Map<String, dynamic> serialize() {
    return {};
  }
}
