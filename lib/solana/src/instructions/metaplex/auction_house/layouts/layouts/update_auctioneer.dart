import 'package:on_chain/solana/src/instructions/metaplex/auction_house/layouts/instruction/instruction.dart';
import 'package:on_chain/solana/src/instructions/metaplex/auction_house/types/types/authority_scope.dart';
import 'package:blockchain_utils/layout/layout.dart';

class MetaplexAuctionHouseUpdateAuctioneerLayout
    extends MetaplexAuctionHouseProgramLayout {
  final List<AuthorityScope> scopes;
  const MetaplexAuctionHouseUpdateAuctioneerLayout({required this.scopes});

  /// Constructs the layout from raw bytes.
  factory MetaplexAuctionHouseUpdateAuctioneerLayout.fromBuffer(
      List<int> data) {
    final decode = MetaplexAuctionHouseProgramLayout.decodeAndValidateStruct(
        layout: _layout,
        bytes: data,
        instruction: MetaplexAuctionHouseProgramInstruction
            .updateAuctioneer.insturction);
    return MetaplexAuctionHouseUpdateAuctioneerLayout(
        scopes: (decode["scopes"] as List)
            .map((e) => AuthorityScope.fromValue(e))
            .toList());
  }

  /// StructLayout layout definition.
  static final StructLayout _layout = LayoutConst.struct([
    LayoutConst.blob(8, property: "instruction"),
    LayoutConst.vec(LayoutConst.u8(), property: "scopes"),
  ]);

  @override
  StructLayout get layout => _layout;

  @override
  List<int> get instruction =>
      MetaplexAuctionHouseProgramInstruction.updateAuctioneer.insturction;

  @override
  Map<String, dynamic> serialize() {
    return {"scopes": scopes.map((e) => e.value).toList()};
  }
}
