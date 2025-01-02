import 'package:on_chain/solana/src/address/sol_address.dart';
import 'package:on_chain/solana/src/instructions/metaplex/token_meta_data/layouts/instruction/instruction.dart';
import 'package:on_chain/solana/src/instructions/metaplex/token_meta_data/types/types.dart';
import 'package:blockchain_utils/layout/layout.dart';
import 'package:on_chain/solana/src/borsh_serialization/program_layout.dart';
import 'package:on_chain/solana/src/utils/layouts.dart';

class MetaplexTokenMetaDataUpdateAsUpdateAuthorityV2Layout
    extends MetaplexTokenMetaDataUpdateProgramLayout {
  final SolAddress? newUpdateAuthority;
  final MetaDataData? data;
  final bool? primarySaleHappened;
  final bool? isMutable;
  final CollectionToggle collection;
  final CollectionDetailsToggle collectionDetails;
  final UsesToggle uses;
  final RuleSetToggle ruleSet;
  final MetaDataTokenStandard? tokenStandard;
  final Payload? authorizationData;

  const MetaplexTokenMetaDataUpdateAsUpdateAuthorityV2Layout(
      {this.newUpdateAuthority,
      this.data,
      this.primarySaleHappened,
      this.isMutable,
      required this.collection,
      required this.collectionDetails,
      required this.uses,
      required this.ruleSet,
      this.tokenStandard,
      this.authorizationData});

  factory MetaplexTokenMetaDataUpdateAsUpdateAuthorityV2Layout.fromBuffer(
      List<int> data) {
    final decode = ProgramLayout.decodeAndValidateStruct(
        layout: _layout,
        bytes: data,
        instruction: MetaplexTokenMetaDataProgramInstruction
            .updateAsUpdateAuthorityV2.insturction,
        discriminator: discriminator);
    return MetaplexTokenMetaDataUpdateAsUpdateAuthorityV2Layout(
        collection: CollectionToggle.fromJson(decode['collection']),
        collectionDetails:
            CollectionDetailsToggle.fromJson(decode['collectionDetails']),
        uses: UsesToggle.fromJson(decode['uses']),
        ruleSet: RuleSetToggle.fromJson(decode['ruleSet']),
        authorizationData: decode['authorizationData'] == null
            ? null
            : Payload.fromJson(decode['authorizationData']),
        data: decode['data'] == null
            ? null
            : MetaDataData.fromJson(decode['data']),
        isMutable: decode['isMutable'],
        newUpdateAuthority: decode['newUpdateAuthority'],
        primarySaleHappened: decode['primarySaleHappened'],
        tokenStandard: decode['tokenStandard'] == null
            ? null
            : MetaDataTokenStandard.fromJson(decode['tokenStandard']));
  }

  static final StructLayout _layout = LayoutConst.struct([
    LayoutConst.u8(property: 'instruction'),
    LayoutConst.u8(property: 'discriminator'),
    SolanaLayoutUtils.optionPubkey(property: 'newUpdateAuthority'),
    LayoutConst.optional(MetaDataData.staticLayout, property: 'data'),
    LayoutConst.optional(LayoutConst.boolean(),
        property: 'primarySaleHappened'),
    LayoutConst.optional(LayoutConst.boolean(), property: 'isMutable'),
    LayoutConst.wrap(CollectionToggle.staticLayout, property: 'collection'),
    LayoutConst.wrap(CollectionDetailsToggle.staticLayout,
        property: 'collectionDetails'),
    LayoutConst.wrap(UsesToggle.staticLayout, property: 'uses'),
    LayoutConst.wrap(RuleSetToggle.staticLayout, property: 'ruleSet'),
    LayoutConst.optional(MetaDataTokenStandard.staticLayout,
        property: 'tokenStandard'),
    LayoutConst.optional(Payload.staticLayout, property: 'authorizationData'),
  ]);

  @override
  StructLayout get layout => _layout;

  @override
  MetaplexTokenMetaDataProgramInstruction get instruction =>
      MetaplexTokenMetaDataProgramInstruction.updateAsUpdateAuthorityV2;

  static int discriminator = 1;

  @override
  Map<String, dynamic> serialize() {
    return {
      'discriminator': discriminator,
      'newUpdateAuthority': newUpdateAuthority,
      'data': data?.serialize(),
      'primarySaleHappened': primarySaleHappened,
      'isMutable': isMutable,
      'collection': collection.serialize(),
      'collectionDetails': collectionDetails.serialize(),
      'uses': uses.serialize(),
      'ruleSet': ruleSet.serialize(),
      'tokenStandard': tokenStandard?.serialize(),
      'authorizationData': authorizationData?.serialize()
    };
  }
}
