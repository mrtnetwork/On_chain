import 'package:on_chain/solana/src/instructions/metaplex/bubblegum/layouts/instructions/instruction.dart';
import 'package:blockchain_utils/layout/layout.dart';

class MetaplexBubblegumCreateTreeLayout extends MetaplexBubblegumProgramLayout {
  final int maxDepth;
  final int maxBufferSize;
  final bool? public;
  const MetaplexBubblegumCreateTreeLayout({
    required this.maxBufferSize,
    this.public,
    required this.maxDepth,
  });

  factory MetaplexBubblegumCreateTreeLayout.fromBuffer(List<int> data) {
    final decode = MetaplexBubblegumProgramLayout.decodeAndValidateStruct(
        layout: _layout,
        bytes: data,
        instruction:
            MetaplexBubblegumProgramInstruction.createTreeConfig.insturction);
    return MetaplexBubblegumCreateTreeLayout(
        maxBufferSize: decode["maxBufferSize"],
        public: decode["public"],
        maxDepth: decode["maxDepth"]);
  }

  static final StructLayout _layout = LayoutConst.struct([
    LayoutConst.blob(8, property: "instruction"),
    LayoutConst.u32(property: "maxDepth"),
    LayoutConst.u32(property: "maxBufferSize"),
    LayoutConst.optional(LayoutConst.boolean(), property: "public")
  ]);

  @override
  StructLayout get layout => _layout;

  @override
  List<int> get instruction =>
      MetaplexBubblegumProgramInstruction.createTreeConfig.insturction;

  @override
  Map<String, dynamic> serialize() {
    return {
      "public": public,
      "maxBufferSize": maxBufferSize,
      "maxDepth": maxDepth
    };
  }
}
