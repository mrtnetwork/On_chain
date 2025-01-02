import 'package:on_chain/solana/src/address/sol_address.dart';
import 'package:on_chain/solana/src/instructions/metaplex/token_meta_data/types/types.dart';
import 'package:blockchain_utils/layout/layout.dart';
import 'package:on_chain/solana/src/borsh_serialization/program_layout.dart';
import 'package:on_chain/solana/src/utils/layouts.dart';

class _Utils {
  static final StructLayout layout = LayoutConst.struct([
    LayoutConst.u8(property: 'key'),
    SolanaLayoutUtils.publicKey('parent'),
    LayoutConst.u64(property: 'edition'),
  ]);
}

class Edition extends LayoutSerializable {
  static int get size => _Utils.layout.span;
  final MetaDataKey key;
  final BigInt edition;
  final SolAddress parent;

  const Edition(
      {required this.key, required this.edition, required this.parent});
  factory Edition.fromBuffer(List<int> data) {
    final decode =
        LayoutSerializable.decode(bytes: data, layout: _Utils.layout);
    return Edition(
        key: MetaDataKey.fromValue(decode['key']),
        edition: decode['edition'],
        parent: decode['parent']);
  }

  @override
  StructLayout get layout => _Utils.layout;
  @override
  Map<String, dynamic> serialize() {
    return {'key': key.value, 'parent': parent, 'edition': edition};
  }

  @override
  String toString() {
    return 'Edition${serialize()}';
  }
}
