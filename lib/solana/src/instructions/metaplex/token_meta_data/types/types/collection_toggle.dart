import 'package:on_chain/solana/src/instructions/metaplex/bubblegum/bubblegum.dart';
import 'package:blockchain_utils/layout/layout.dart';
import 'package:on_chain/solana/src/borsh_serialization/program_layout.dart';

class CollectionToggle extends BorshLayoutSerializable {
  final String name;
  final int value;
  final List<Collection>? fileds;
  const CollectionToggle._(this.name, this.value, this.fileds);

  factory CollectionToggle.fromJson(Map<String, dynamic> json) {
    final key = json['collectionToggle']['key'];
    final List<dynamic> value = json['collectionToggle']['value'];
    switch (key) {
      case 'NoneLayout':
        return none;
      case 'Clear':
        return clear;
      default:
        return CollectionToggle.set(collection: Collection.fromJson(value[0]));
    }
  }
  static const CollectionToggle none =
      CollectionToggle._('NoneLayout', 0, null);
  static const CollectionToggle clear = CollectionToggle._('Clear', 1, null);
  factory CollectionToggle.set({required Collection collection}) {
    return CollectionToggle._('Set', 2, [collection]);
  }

  static StructLayout staticLayout = LayoutConst.struct([
    LayoutConst.rustEnum([
      LayoutConst.none(property: 'NoneLayout'),
      LayoutConst.none(property: 'Clear'),
      LayoutConst.tuple([Collection.staticLayout], property: 'Set'),
    ], property: 'collectionToggle')
  ]);

  @override
  StructLayout get layout => staticLayout;

  @override
  Map<String, dynamic> serialize() {
    return {
      'collectionToggle': {name: fileds?.map((e) => e.serialize()).toList()}
    };
  }
}
