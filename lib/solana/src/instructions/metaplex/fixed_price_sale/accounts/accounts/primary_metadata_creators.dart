import 'package:on_chain/solana/src/instructions/metaplex/fixed_price_sale/types/types/creator.dart';
import 'package:blockchain_utils/layout/layout.dart';
import 'package:on_chain/solana/src/borsh_serialization/program_layout.dart';

class _Utils {
  static const List<int> discriminator = [66, 131, 48, 36, 100, 130, 177, 11];
  static StructLayout get layout => LayoutConst.struct([
        LayoutConst.blob(8, property: 'discriminator'),
        LayoutConst.vec(Creator.creatorLayout, property: 'creators'),
      ]);
}

class PrimaryMetadataCreators extends BorshLayoutSerializable {
  final List<Creator> creators;
  const PrimaryMetadataCreators({required this.creators});
  factory PrimaryMetadataCreators.fromBuffer(List<int> data) {
    final decode = BorshLayoutSerializable.decode(
        bytes: data,
        layout: _Utils.layout,
        validator: {'discriminator': _Utils.discriminator});
    return PrimaryMetadataCreators(
        creators: (decode['creators'] as List)
            .map((e) => Creator.fromJson(e))
            .toList());
  }

  @override
  StructLayout get layout => _Utils.layout;

  @override
  Map<String, dynamic> serialize() {
    return {
      'discriminator': _Utils.discriminator,
      'creators': creators.map((e) => e.serialize()).toList()
    };
  }

  @override
  String toString() {
    return 'PrimaryMetadataCreators${serialize()}';
  }
}
