import 'package:blockchain_utils/exception/exception.dart';
import 'package:blockchain_utils/layout/layout.dart';

class MetadataDelegateRole {
  final String name;
  final String seed;
  final int value;
  const MetadataDelegateRole._(this.name, this.value, this.seed);
  static const MetadataDelegateRole authorityItem =
      MetadataDelegateRole._("AuthorityItem", 0, "authority_item_delegate");
  static const MetadataDelegateRole collection =
      MetadataDelegateRole._("Collection", 1, "collection_delegate");
  static const MetadataDelegateRole use =
      MetadataDelegateRole._("Use", 2, "use_delegate");
  static const MetadataDelegateRole data =
      MetadataDelegateRole._("Data", 3, "data_delegate");
  static const MetadataDelegateRole programmableConfig = MetadataDelegateRole._(
      "ProgrammableConfig", 4, "programmable_config_delegate");
  static const MetadataDelegateRole dataItem =
      MetadataDelegateRole._("DataItem", 5, "data_item_delegate");
  static const MetadataDelegateRole collectionItem =
      MetadataDelegateRole._("CollectionItem", 6, "collection_item_delegate");
  static const MetadataDelegateRole programmableConfigItem =
      MetadataDelegateRole._(
          "ProgrammableConfigItem", 7, "prog_config_item_delegate");
  static const List<MetadataDelegateRole> values = [
    authorityItem,
    collection,
    use,
    data,
    programmableConfig,
    dataItem,
    collectionItem,
    programmableConfigItem
  ];
  static StructLayout staticLayout = LayoutConst.struct([
    LayoutConst.rustEnum(
        values.map((e) => LayoutConst.none(property: e.name)).toList(),
        property: "metaDataTokenStandard")
  ]);
  static MetadataDelegateRole fromValue(int? value) {
    return values.firstWhere(
      (element) => element.value == value,
      orElse: () => throw MessageException(
          "No MetaDataTokenStandard found matching the specified value",
          details: {"value": value}),
    );
  }

  static MetadataDelegateRole fromName(String? value) {
    return values.firstWhere(
      (element) => element.name == value,
      orElse: () => throw MessageException(
          "No MetaDataTokenStandard found matching the specified value",
          details: {"value": value}),
    );
  }

  factory MetadataDelegateRole.fromJson(Map<String, dynamic> json) {
    return fromName(json["metaDataTokenStandard"]["key"]);
  }
}
