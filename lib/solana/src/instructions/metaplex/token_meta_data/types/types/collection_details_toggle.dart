import 'package:on_chain/solana/src/instructions/metaplex/token_meta_data/token_meta_data.dart';
import 'package:blockchain_utils/layout/layout.dart';
import 'package:on_chain/solana/src/borsh_serialization/program_layout.dart';

class CollectionDetailsToggle extends LayoutSerializable {
  final String name;
  final int value;
  final List<CollectionDetailsV1>? fileds;
  const CollectionDetailsToggle._(this.name, this.value, this.fileds);

  factory CollectionDetailsToggle.fromJson(Map<String, dynamic> json) {
    final key = json['collectionDetailsToggle']['key'];
    final List<dynamic> value = json['collectionDetailsToggle']['value'];
    switch (key) {
      case 'NoneLayout':
        return none;
      case 'Clear':
        return clear;
      default:
        return CollectionDetailsToggle.set(
            collection: CollectionDetailsV1.fromJson(value[0]));
    }
  }
  static const CollectionDetailsToggle none =
      CollectionDetailsToggle._('NoneLayout', 0, null);
  static const CollectionDetailsToggle clear =
      CollectionDetailsToggle._('Clear', 1, null);
  factory CollectionDetailsToggle.set(
      {required CollectionDetailsV1 collection}) {
    return CollectionDetailsToggle._('Set', 2, [collection]);
  }

  static StructLayout staticLayout = LayoutConst.struct([
    LayoutConst.rustEnum([
      LayoutConst.none(property: 'NoneLayout'),
      LayoutConst.none(property: 'Clear'),
      LayoutConst.tuple([CollectionDetailsV1.staticLayout], property: 'Set'),
    ], property: 'collectionDetailsToggle')
  ]);

  @override
  StructLayout get layout => staticLayout;

  @override
  Map<String, dynamic> serialize() {
    return {
      'collectionDetailsToggle': {
        name: fileds?.map((e) => e.serialize()).toList()
      }
    };
  }
}
