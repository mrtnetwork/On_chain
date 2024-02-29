import 'package:on_chain/solana/src/instructions/metaplex/candy_machine_core/layouts/instruction/instruction.dart';
import 'package:on_chain/solana/src/instructions/metaplex/candy_machine_core/types/candy_machine_types/types/config_line.dart';
import 'package:on_chain/solana/src/layout/layout.dart';

class MetaplexCandyMachineAddConfigLinesLayout
    extends MetaplexCandyMachineProgramLayout {
  final List<ConfigLine> configLines;
  MetaplexCandyMachineAddConfigLinesLayout(
      {required List<ConfigLine> configLines, required this.index})
      : configLines = List.unmodifiable(configLines);

  factory MetaplexCandyMachineAddConfigLinesLayout.fromBuffer(List<int> data) {
    final decode = MetaplexCandyMachineProgramLayout.decodeAndValidateStruct(
        layout: _layout,
        bytes: data,
        instruction:
            MetaplexCandyMachineProgramInstruction.addConfigLines.insturction);
    return MetaplexCandyMachineAddConfigLinesLayout(
        configLines: (decode["configLines"] as List)
            .map((e) => ConfigLine.fromJson(e))
            .toList(),
        index: decode["index"]);
  }

  final int index;
  static final Structure _layout = LayoutUtils.struct([
    LayoutUtils.blob(8, property: "instruction"),
    LayoutUtils.u32("index"),
    LayoutUtils.vec(ConfigLine.staticLayout, property: "configLines")
  ]);

  @override
  late final Structure layout = _layout;

  @override
  List<int> get instruction =>
      MetaplexCandyMachineProgramInstruction.addConfigLines.insturction;

  @override
  Map<String, dynamic> serialize() {
    return {
      "index": index,
      "configLines": configLines.map((e) => e.serialize()).toList()
    };
  }
}
