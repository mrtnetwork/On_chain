import 'package:on_chain/solana/src/address/sol_address.dart';
import 'package:on_chain/solana/src/instructions/metaplex/token_meta_data/layouts/instruction/instruction.dart';
import 'package:on_chain/solana/src/instructions/metaplex/token_meta_data/types/types/meta_data_v2.dart';
import 'package:on_chain/solana/src/layout/layout.dart';

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

  static final Structure _layout = LayoutUtils.struct([
    LayoutUtils.u8("instruction"),
    LayoutUtils.optional(MetaDataV2.staticLayout, property: "data"),
    LayoutUtils.optionPubkey(property: "newUpdateAuthority"),
    LayoutUtils.optional(LayoutUtils.boolean(),
        property: "primarySaleHappened"),
    LayoutUtils.optional(LayoutUtils.boolean(), property: "isMutable"),
  ]);

  @override
  Structure get layout => _layout;

  @override
  int get instruction => MetaplexTokenMetaDataProgramInstruction
      .updateMetadataAccountV2.insturction;

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
