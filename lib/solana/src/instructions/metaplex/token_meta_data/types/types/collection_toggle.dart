import 'package:on_chain/solana/src/instructions/metaplex/bubblegum/bubblegum.dart';
import 'package:on_chain/solana/src/layout/layout.dart';

class CollectionToggle extends LayoutSerializable {
  final String name;
  final int value;
  final List<Collection>? fileds;
  const CollectionToggle._(this.name, this.value, this.fileds);

  factory CollectionToggle.fromJson(Map<String, dynamic> json) {
    final key = json["collectionToggle"]["key"];
    final List<dynamic> value = json["collectionToggle"]["value"];
    switch (key) {
      case "None":
        return none;
      case "Clear":
        return clear;
      default:
        return CollectionToggle.set(collection: Collection.fromJson(value[0]));
    }
  }
  static const CollectionToggle none = CollectionToggle._("None", 0, null);
  static const CollectionToggle clear = CollectionToggle._("Clear", 1, null);
  factory CollectionToggle.set({required Collection collection}) {
    return CollectionToggle._("Set", 2, [collection]);
  }

  static Structure staticLayout = LayoutUtils.struct([
    LayoutUtils.rustEnum([
      LayoutUtils.none("None"),
      LayoutUtils.none("Clear"),
      LayoutUtils.tuple([Collection.staticLayout], property: "Set"),
    ], LayoutUtils.u8(), property: "collectionToggle")
  ]);

  @override
  Structure get layout => staticLayout;

  @override
  Map<String, dynamic> serialize() {
    return {
      "collectionToggle": {name: fileds?.map((e) => e.serialize()).toList()}
    };
  }
}
