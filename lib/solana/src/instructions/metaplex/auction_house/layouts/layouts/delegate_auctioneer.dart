import 'package:on_chain/solana/src/instructions/metaplex/auction_house/layouts/instruction/instruction.dart';
import 'package:on_chain/solana/src/instructions/metaplex/auction_house/types/types/authority_scope.dart';
import 'package:blockchain_utils/layout/layout.dart';

class MetaplexAuctionHouseDelegateAuctioneerLayout
    extends MetaplexAuctionHouseProgramLayout {
  final List<AuthorityScope> scopes;
  const MetaplexAuctionHouseDelegateAuctioneerLayout({required this.scopes});

  /// Constructs the layout from raw bytes.
  factory MetaplexAuctionHouseDelegateAuctioneerLayout.fromBuffer(
      List<int> data) {
    final decode = MetaplexAuctionHouseProgramLayout.decodeAndValidateStruct(
        layout: _layout,
        bytes: data,
        instruction: MetaplexAuctionHouseProgramInstruction
            .delegateAuctioneer.insturction);
    return MetaplexAuctionHouseDelegateAuctioneerLayout(
        scopes: (decode["scopes"] as List)
            .map((e) => AuthorityScope.fromValue(e))
            .toList());
  }

  /// StructLayout layout definition.
  static final StructLayout _layout = LayoutConst.struct([
    LayoutConst.blob(8, property: "instruction"),
    LayoutConst.vec(LayoutConst.u8(), property: "scopes")
  ]);

  @override
  StructLayout get layout => _layout;

  @override
  MetaplexAuctionHouseProgramInstruction get instruction =>
      MetaplexAuctionHouseProgramInstruction.delegateAuctioneer;

  @override
  Map<String, dynamic> serialize() {
    return {
      "scopes": scopes.map((e) => e.value).toList(),
      "length": scopes.length
    };
  }
}
