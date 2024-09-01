import 'package:on_chain/solana/src/address/sol_address.dart';
import 'package:on_chain/solana/src/instructions/metaplex/token_meta_data/layouts/instruction/instruction.dart';
import 'package:on_chain/solana/src/instructions/metaplex/token_meta_data/types/types/meta_data_v2.dart';
import 'package:blockchain_utils/layout/layout.dart';
import 'package:on_chain/solana/src/borsh_serialization/program_layout.dart';
import 'package:on_chain/solana/src/utils/layouts.dart';

class MetaplexTokenMetaDataUpdateMetadataAccountV2Layout
    extends MetaplexTokenMetaDataProgramLayout {
  final MetaDataV2? data;
  final SolAddress? newUpdateAuthority;
  final bool? isMutable;
  final bool? primarySaleHappened;

  const MetaplexTokenMetaDataUpdateMetadataAccountV2Layout(
      {required this.isMutable,
      required this.primarySaleHappened,
      required this.newUpdateAuthority,
      required this.data});

  factory MetaplexTokenMetaDataUpdateMetadataAccountV2Layout.fromBuffer(
      List<int> data) {
    final decode = ProgramLayout.decodeAndValidateStruct(
        layout: _layout,
        bytes: data,
        instruction: MetaplexTokenMetaDataProgramInstruction
            .updateMetadataAccountV2.insturction);
    return MetaplexTokenMetaDataUpdateMetadataAccountV2Layout(
        data:
            decode["data"] == null ? null : MetaDataV2.fromJson(decode["data"]),
        isMutable: decode["isMutable"],
        primarySaleHappened: decode["primarySaleHappened"],
        newUpdateAuthority: decode["newUpdateAuthority"]);
  }

  static final StructLayout _layout = LayoutConst.struct([
    LayoutConst.u8(property: "instruction"),
    LayoutConst.optional(MetaDataV2.staticLayout, property: "data"),
    SolanaLayoutUtils.optionPubkey(property: "newUpdateAuthority"),
    LayoutConst.optional(LayoutConst.boolean(),
        property: "primarySaleHappened"),
    LayoutConst.optional(LayoutConst.boolean(), property: "isMutable"),
  ]);

  @override
  StructLayout get layout => _layout;

  @override
  MetaplexTokenMetaDataProgramInstruction get instruction =>
      MetaplexTokenMetaDataProgramInstruction.updateMetadataAccountV2;

  @override
  Map<String, dynamic> serialize() {
    return {
      "newUpdateAuthority": newUpdateAuthority,
      "primarySaleHappened": primarySaleHappened,
      "isMutable": isMutable,
      "data": data?.serialize()
    };
  }
}
