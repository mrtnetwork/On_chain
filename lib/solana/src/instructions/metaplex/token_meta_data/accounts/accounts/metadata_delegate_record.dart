import 'package:on_chain/solana/src/address/sol_address.dart';
import 'package:on_chain/solana/src/instructions/metaplex/token_meta_data/types/types.dart';
import 'package:on_chain/solana/src/layout/layout.dart';

class _Utils {
  static final Structure layout = LayoutUtils.struct([
    LayoutUtils.u8("key"),
    LayoutUtils.u8("bump"),
    LayoutUtils.publicKey("mint"),
    LayoutUtils.publicKey("delegate"),
    LayoutUtils.publicKey("updateAuthority"),
  ]);
}

class MetadataDelegateRecord extends LayoutSerializable {
  final MetaDataKey key;
  final int bump;
  final SolAddress mint;
  final SolAddress delegate;
  final SolAddress updateAuthority;

  MetadataDelegateRecord(
      {required this.key,
      required this.updateAuthority,
      required this.mint,
      required this.bump,
      required this.delegate});
  factory MetadataDelegateRecord.fromBuffer(List<int> data) {
    final decode =
        LayoutSerializable.decode(bytes: data, layout: _Utils.layout);
    return MetadataDelegateRecord(
        key: MetaDataKey.fromValue(decode["key"]),
        updateAuthority: decode["updateAuthority"],
        mint: decode["mint"],
        bump: decode["bump"],
        delegate: decode["delegate"]);
  }

  @override
  Structure get layout => _Utils.layout;
  @override
  Map<String, dynamic> serialize() {
    return {
      "key": key.value,
      "updateAuthority": updateAuthority,
      "mint": mint,
      "bump": bump,
      "delegate": delegate
    };
  }
}
