import 'package:on_chain/solana/src/instructions/metaplex/hydra/layouts/instruction/instruction.dart';
import 'package:on_chain/solana/src/instructions/metaplex/hydra/types/types/member_ship_model.dart';
import 'package:on_chain/solana/src/layout/layout.dart';

class MetaplexHydraInitLayout extends MetaplexHydraProgramLayout {
  final int bumpSeed;
  final int nativeAccountBumpSeed;
  final String name;
  final BigInt totalShares;
  final MembershipModel membershipModel;
  const MetaplexHydraInitLayout({
    required this.bumpSeed,
    required this.name,
    required this.nativeAccountBumpSeed,
    required this.totalShares,
    required this.membershipModel,
  });

  factory MetaplexHydraInitLayout.fromBuffer(List<int> data) {
    final decode = MetaplexHydraProgramLayout.decodeAndValidateStruct(
        layout: _layout,
        bytes: data,
        instruction: MetaplexHydraProgramInstruction.processInit.insturction);
    return MetaplexHydraInitLayout(
        bumpSeed: decode["bumpSeed"],
        name: decode["name"],
        nativeAccountBumpSeed: decode["nativeAccountBumpSeed"],
        totalShares: decode["totalShares"],
        membershipModel: MembershipModel.fromValue(decode["membershipModel"]));
  }

  static final Structure _layout = LayoutUtils.struct([
    LayoutUtils.blob(8, property: "instruction"),
    LayoutUtils.u8("bumpSeed"),
    LayoutUtils.u8("nativeAccountBumpSeed"),
    LayoutUtils.string("name"),
    LayoutUtils.u64("totalShares"),
    LayoutUtils.u8("membershipModel")
  ]);

  @override
  Structure get layout => _layout;

  @override
  List<int> get instruction =>
      MetaplexHydraProgramInstruction.processInit.insturction;

  @override
  Map<String, dynamic> serialize() {
    return {
      "membershipModel": membershipModel.value,
      "bumpSeed": bumpSeed,
      "nativeAccountBumpSeed": nativeAccountBumpSeed,
      "name": name,
      "totalShares": totalShares
    };
  }
}
