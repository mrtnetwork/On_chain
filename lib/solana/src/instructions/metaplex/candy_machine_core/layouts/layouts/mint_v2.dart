import 'package:blockchain_utils/binary/binary.dart';
import 'package:on_chain/solana/src/instructions/metaplex/candy_machine_core/layouts/instruction/instruction.dart';
import 'package:on_chain/solana/src/layout/layout.dart';

class MetaplexCandyMachineMintV2Layout
    extends MetaplexCandyMachineProgramLayout {
  final List<int> mintArgs;
  final String? group;
  MetaplexCandyMachineMintV2Layout(
      {required List<int> mintArgs, required this.group})
      : mintArgs = BytesUtils.toBytes(mintArgs, unmodifiable: true);

  factory MetaplexCandyMachineMintV2Layout.fromBuffer(List<int> data) {
    final decode = MetaplexCandyMachineProgramLayout.decodeAndValidateStruct(
        layout: _layout,
        bytes: data,
        instruction: MetaplexCandyMachineProgramInstruction.mintV2.insturction);
    return MetaplexCandyMachineMintV2Layout(
        mintArgs: (decode["mintArgs"] as List).cast(), group: decode["group"]);
  }
  static final Structure _layout = LayoutUtils.struct([
    LayoutUtils.blob(8, property: "instruction"),
    LayoutUtils.vecU8("mintArgs"),
    LayoutUtils.optional(LayoutUtils.string(), property: "group")
  ]);

  @override
  Structure get layout => _layout;

  @override
  List<int> get instruction =>
      MetaplexCandyMachineProgramInstruction.mintV2.insturction;

  @override
  Map<String, dynamic> serialize() {
    return {"group": group, "mintArgs": mintArgs};
  }
}
