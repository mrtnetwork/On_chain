import 'package:on_chain/solana/src/exception/exception.dart';
import 'package:blockchain_utils/layout/layout.dart';
import 'package:on_chain/solana/src/borsh_serialization/program_layout.dart';

class MetaDataTokenStandard extends LayoutSerializable {
  final String name;
  final int value;
  const MetaDataTokenStandard._(this.name, this.value);
  static const MetaDataTokenStandard nonFungible =
      MetaDataTokenStandard._('NonFungible', 0);
  static const MetaDataTokenStandard fungibleAsset =
      MetaDataTokenStandard._('FungibleAsset', 1);
  static const MetaDataTokenStandard fungible =
      MetaDataTokenStandard._('Fungible', 2);
  static const MetaDataTokenStandard nonFungibleEdition =
      MetaDataTokenStandard._('NonFungibleEdition', 3);
  static const MetaDataTokenStandard programmableNonFungible =
      MetaDataTokenStandard._('ProgrammableNonFungible', 4);
  static const MetaDataTokenStandard programmableNonFungibleEdition =
      MetaDataTokenStandard._('ProgrammableNonFungibleEdition', 5);
  static const List<MetaDataTokenStandard> values = [
    nonFungible,
    fungibleAsset,
    fungible,
    nonFungibleEdition,
    programmableNonFungible,
    programmableNonFungibleEdition
  ];
  static StructLayout staticLayout = LayoutConst.struct([
    LayoutConst.rustEnum(
        values.map((e) => LayoutConst.none(property: e.name)).toList(),
        property: 'metaDataTokenStandard')
  ]);
  static MetaDataTokenStandard fromValue(int? value) {
    return values.firstWhere(
      (element) => element.value == value,
      orElse: () => throw SolanaPluginException(
          'No MetaDataTokenStandard found matching the specified value',
          details: {'value': value}),
    );
  }

  static MetaDataTokenStandard fromName(String? value) {
    return values.firstWhere(
      (element) => element.name == value,
      orElse: () => throw SolanaPluginException(
          'No MetaDataTokenStandard found matching the specified value',
          details: {'value': value}),
    );
  }

  factory MetaDataTokenStandard.fromJson(Map<String, dynamic> json) {
    return fromName(json['metaDataTokenStandard']['key']);
  }

  @override
  StructLayout get layout => staticLayout;

  @override
  Map<String, dynamic> serialize() {
    return {
      'metaDataTokenStandard': {name: null}
    };
  }
}
