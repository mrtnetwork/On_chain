import 'package:blockchain_utils/utils/utils.dart';
import 'package:blockchain_utils/layout/layout.dart';
import 'package:on_chain/solana/src/instructions/metaplex/nft_packs/layouts/instruction/instruction.dart';

import 'package:on_chain/solana/src/borsh_serialization/program_layout.dart';

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
        name: decode['name'],
        desciption: decode['desciption'],
        uri: decode['uri'],
        mutable: decode['mutable']);
  }

  static final StructLayout _layout = LayoutConst.struct([
    LayoutConst.u8(property: 'instruction'),
    LayoutConst.optional(LayoutConst.blob(32), property: 'name'),
    LayoutConst.optional(LayoutConst.string(), property: 'desciption'),
    LayoutConst.optional(LayoutConst.string(), property: 'uri'),
    LayoutConst.optional(LayoutConst.boolean(), property: 'mutable'),
  ]);

  @override
  StructLayout get layout => _layout;

  @override
  MetaplexNFTPacksProgramInstruction get instruction =>
      MetaplexNFTPacksProgramInstruction.editPack;

  @override
  Map<String, dynamic> serialize() {
    return {
      'name': name,
      'desciption': desciption,
      'uri': uri,
      'mutable': mutable
    };
  }
}
