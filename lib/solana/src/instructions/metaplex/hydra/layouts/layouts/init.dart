import 'package:on_chain/solana/src/instructions/metaplex/hydra/layouts/instruction/instruction.dart';
import 'package:on_chain/solana/src/instructions/metaplex/hydra/types/types/member_ship_model.dart';
import 'package:blockchain_utils/layout/layout.dart';

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
        bumpSeed: decode['bumpSeed'],
        name: decode['name'],
        nativeAccountBumpSeed: decode['nativeAccountBumpSeed'],
        totalShares: decode['totalShares'],
        membershipModel: MembershipModel.fromValue(decode['membershipModel']));
  }

  static StructLayout get _layout => LayoutConst.struct([
        LayoutConst.blob(8, property: 'instruction'),
        LayoutConst.u8(property: 'bumpSeed'),
        LayoutConst.u8(property: 'nativeAccountBumpSeed'),
        LayoutConst.string(property: 'name'),
        LayoutConst.u64(property: 'totalShares'),
        LayoutConst.u8(property: 'membershipModel')
      ]);

  @override
  StructLayout get layout => _layout;

  @override
  MetaplexHydraProgramInstruction get instruction =>
      MetaplexHydraProgramInstruction.processInit;

  @override
  Map<String, dynamic> serialize() {
    return {
      'membershipModel': membershipModel.value,
      'bumpSeed': bumpSeed,
      'nativeAccountBumpSeed': nativeAccountBumpSeed,
      'name': name,
      'totalShares': totalShares
    };
  }
}
