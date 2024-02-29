import 'package:on_chain/solana/src/address/sol_address.dart';
import 'package:on_chain/solana/src/instructions/metaplex/token_meta_data/layouts/instruction/instruction.dart';
import 'package:on_chain/solana/src/instructions/metaplex/token_meta_data/types/types/payload.dart';
import 'package:on_chain/solana/src/instructions/metaplex/token_meta_data/types/types/token_standard.dart';
import 'package:on_chain/solana/src/layout/layout.dart';

class MetaplexTokenMetaDataUpdateAsAuthorityItemDelegateV2Layout
    extends MetaplexTokenMetaDataUpdateProgramLayout {
  final Payload? authorizationData;
  final MetaDataTokenStandard? tokenStandard;
  final bool? isMutable;
  final bool? primarySaleHappened;
  final SolAddress? newUpdateAuthority;
  static int discriminator = 2;
  const MetaplexTokenMetaDataUpdateAsAuthorityItemDelegateV2Layout(
      {this.authorizationData,
      required this.tokenStandard,
      required this.isMutable,
      required this.primarySaleHappened,
      required this.newUpdateAuthority});

  factory MetaplexTokenMetaDataUpdateAsAuthorityItemDelegateV2Layout.fromBuffer(
      List<int> data) {
    final decode = ProgramLayout.decodeAndValidateStruct(
        layout: _layout,
        bytes: data,
        instruction: MetaplexTokenMetaDataProgramInstruction
            .updateAsAuthorityItemDelegateV2.insturction,
        discriminator: discriminator);
    return MetaplexTokenMetaDataUpdateAsAuthorityItemDelegateV2Layout(
        authorizationData: decode["authorizationData"] == null
            ? null
            : Payload.fromJson(decode["authorizationData"]),
        tokenStandard: decode["tokenStandard"] == null
            ? null
            : MetaDataTokenStandard.fromJson(decode["tokenStandard"]),
        isMutable: decode["isMutable"],
        primarySaleHappened: decode["primarySaleHappened"],
        newUpdateAuthority: decode["newUpdateAuthority"]);
  }

  static final Structure _layout = LayoutUtils.struct([
    LayoutUtils.u8("instruction"),
    LayoutUtils.u8("discriminator"),
    LayoutUtils.optionPubkey(property: "newUpdateAuthority"),
    LayoutUtils.optional(LayoutUtils.boolean(),
        property: "primarySaleHappened"),
    LayoutUtils.optional(LayoutUtils.boolean(), property: "isMutable"),
    LayoutUtils.optional(MetaDataTokenStandard.staticLayout,
        property: "tokenStandard"),
    LayoutUtils.optional(Payload.staticLayout, property: "authorizationData"),
  ]);

  @override
  Structure get layout => _layout;

  @override
  int get instruction => MetaplexTokenMetaDataProgramInstruction
      .updateAsAuthorityItemDelegateV2.insturction;

  @override
  Map<String, dynamic> serialize() {
    return {
      "discriminator": discriminator,
      "newUpdateAuthority": newUpdateAuthority,
      "primarySaleHappened": primarySaleHappened,
      "isMutable": isMutable,
      "tokenStandard": tokenStandard?.serialize(),
      "authorizationData": authorizationData?.serialize()
    };
  }
}
