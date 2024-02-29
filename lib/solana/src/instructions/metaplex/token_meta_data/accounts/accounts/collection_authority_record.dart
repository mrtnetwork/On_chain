import 'package:on_chain/solana/src/address/sol_address.dart';
import 'package:on_chain/solana/src/instructions/metaplex/token_meta_data/types/types.dart';
import 'package:on_chain/solana/src/layout/layout.dart';

class _Utils {
  static final Structure layout = LayoutUtils.struct([
    LayoutUtils.u8("key"),
    LayoutUtils.u8("bump"),
    LayoutUtils.optionPubkey(property: "updateAuthority")
  ]);
}

class CollectionAuthorityRecord extends LayoutSerializable {
  final MetaDataKey key;
  final int bump;
  final SolAddress? updateAuthority;

  const CollectionAuthorityRecord(
      {required this.key, required this.bump, this.updateAuthority});
  factory CollectionAuthorityRecord.fromBuffer(List<int> data) {
    final decode =
        LayoutSerializable.decode(bytes: data, layout: _Utils.layout);
    return CollectionAuthorityRecord(
        key: MetaDataKey.fromValue(decode["key"]),
        bump: decode["bump"],
        updateAuthority: decode["updateAuthority"]);
  }

  @override
  Structure get layout => _Utils.layout;
  @override
  Map<String, dynamic> serialize() {
    return {"key": key.value, "bump": bump, "updateAuthority": updateAuthority};
  }

  @override
  String toString() {
    return "CollectionAuthorityRecord${serialize()}";
  }
}
