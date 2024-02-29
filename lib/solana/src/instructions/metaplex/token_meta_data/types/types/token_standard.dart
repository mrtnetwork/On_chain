import 'package:blockchain_utils/exception/exception.dart';
import 'package:on_chain/solana/src/layout/layout.dart';

class MetaDataTokenStandard extends LayoutSerializable {
  final String name;
  final int value;
  const MetaDataTokenStandard._(this.name, this.value);
  static const MetaDataTokenStandard nonFungible =
      MetaDataTokenStandard._("NonFungible", 0);
  static const MetaDataTokenStandard fungibleAsset =
      MetaDataTokenStandard._("FungibleAsset", 1);
  static const MetaDataTokenStandard fungible =
      MetaDataTokenStandard._("Fungible", 2);
  static const MetaDataTokenStandard nonFungibleEdition =
      MetaDataTokenStandard._("NonFungibleEdition", 3);
  static const MetaDataTokenStandard programmableNonFungible =
      MetaDataTokenStandard._("ProgrammableNonFungible", 4);
  static const MetaDataTokenStandard programmableNonFungibleEdition =
      MetaDataTokenStandard._("ProgrammableNonFungibleEdition", 5);
  static const List<MetaDataTokenStandard> values = [
    nonFungible,
    fungibleAsset,
    fungible,
    nonFungibleEdition,
    programmableNonFungible,
    programmableNonFungibleEdition
  ];
  static Structure staticLayout = LayoutUtils.struct([
    LayoutUtils.rustEnum(
        values.map((e) => LayoutUtils.none(e.name)).toList(), LayoutUtils.u8(),
        property: "metaDataTokenStandard")
  ]);
  static MetaDataTokenStandard fromValue(int? value) {
    return values.firstWhere(
      (element) => element.value == value,
      orElse: () => throw MessageException(
          "No MetaDataTokenStandard found matching the specified value",
          details: {"value": value}),
    );
  }

  static MetaDataTokenStandard fromName(String? value) {
    return values.firstWhere(
      (element) => element.name == value,
      orElse: () => throw MessageException(
          "No MetaDataTokenStandard found matching the specified value",
          details: {"value": value}),
    );
  }

  factory MetaDataTokenStandard.fromJson(Map<String, dynamic> json) {
    return fromName(json["metaDataTokenStandard"]["key"]);
  }

  @override
  Structure get layout => staticLayout;

  @override
  Map<String, dynamic> serialize() {
    return {
      "metaDataTokenStandard": {name: null}
    };
  }
}
