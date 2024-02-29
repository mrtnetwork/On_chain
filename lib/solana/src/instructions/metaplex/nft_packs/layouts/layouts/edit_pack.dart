import 'package:blockchain_utils/blockchain_utils.dart';
import 'package:on_chain/solana/src/instructions/metaplex/nft_packs/layouts/instruction/instruction.dart';
import 'package:on_chain/solana/src/layout/layout.dart';

class MetaplexNFTPacksEditPackLayout extends MetaplexNFTPacksProgramLayout {
  final List<int>? name;
  final String? desciption;
  final String? uri;
  final bool? mutable;
  MetaplexNFTPacksEditPackLayout(
      {List<int>? name, this.desciption, this.uri, this.mutable})
      : name = BytesUtils.tryToBytes(name, unmodifiable: true);

  factory MetaplexNFTPacksEditPackLayout.fromBuffer(List<int> data) {
    final decode = ProgramLayout.decodeAndValidateStruct(
        layout: _layout,
        bytes: data,
        instruction: MetaplexNFTPacksProgramInstruction.editPack.insturction);
    return MetaplexNFTPacksEditPackLayout(
        name: decode["name"],
        desciption: decode["desciption"],
        uri: decode["uri"],
        mutable: decode["mutable"]);
  }

  static final Structure _layout = LayoutUtils.struct([
    LayoutUtils.u8("instruction"),
    LayoutUtils.optional(LayoutUtils.blob(32), property: "name"),
    LayoutUtils.optional(LayoutUtils.string(), property: "desciption"),
    LayoutUtils.optional(LayoutUtils.string(), property: "uri"),
    LayoutUtils.optional(LayoutUtils.boolean(), property: "mutable"),
  ]);

  @override
  Structure get layout => _layout;

  @override
  int get instruction =>
      MetaplexNFTPacksProgramInstruction.editPack.insturction;

  @override
  Map<String, dynamic> serialize() {
    return {
      "name": name,
      "desciption": desciption,
      "uri": uri,
      "mutable": mutable
    };
  }
}
