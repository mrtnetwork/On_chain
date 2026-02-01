import 'package:on_chain/solana/src/instructions/metaplex/auctioneer/layouts/instruction/instruction.dart';
import 'package:blockchain_utils/layout/layout.dart';

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
    return const MetaplexAuctioneerAuthorizeLayout();
  }

  /// StructLayout layout definition.
  static StructLayout get _layout =>
      LayoutConst.struct([LayoutConst.blob(8, property: 'instruction')]);

  @override
  StructLayout get layout => _layout;

  @override
  MetaplexAuctioneerProgramInstruction get instruction =>
      MetaplexAuctioneerProgramInstruction.authorize;

  @override
  Map<String, dynamic> serialize() {
    return {};
  }
}
