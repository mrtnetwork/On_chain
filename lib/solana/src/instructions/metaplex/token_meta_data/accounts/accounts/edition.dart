import 'package:on_chain/solana/src/address/sol_address.dart';
import 'package:on_chain/solana/src/instructions/metaplex/token_meta_data/types/types.dart';
import 'package:on_chain/solana/src/layout/layout.dart';

class _Utils {
  static final Structure layout = LayoutUtils.struct([
    LayoutUtils.u8("key"),
    LayoutUtils.publicKey("parent"),
    LayoutUtils.u64("edition"),
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
        key: MetaDataKey.fromValue(decode["key"]),
        edition: decode["edition"],
        parent: decode["parent"]);
  }

  @override
  Structure get layout => _Utils.layout;
  @override
  Map<String, dynamic> serialize() {
    return {"key": key.value, "parent": parent, "edition": edition};
  }

  @override
  String toString() {
    return "Edition${serialize()}";
  }
}
