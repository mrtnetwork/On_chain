import 'package:on_chain/solana/src/instructions/metaplex/token_meta_data/types/types.dart';
import 'package:on_chain/solana/src/layout/layout.dart';

class _Utils {
  static final Structure layout = LayoutUtils.struct([
    LayoutUtils.u8("key"),
    LayoutUtils.u64("allowedUses"),
    LayoutUtils.u8("bump")
  ]);
}

class UseAuthorityRecord extends LayoutSerializable {
  final MetaDataKey key;
  final BigInt allowedUses;
  final int bump;

  const UseAuthorityRecord(
      {required this.key, required this.bump, required this.allowedUses});
  factory UseAuthorityRecord.fromBuffer(List<int> data) {
    final decode =
        LayoutSerializable.decode(bytes: data, layout: _Utils.layout);
    return UseAuthorityRecord(
        key: MetaDataKey.fromValue(decode["key"]),
        bump: decode["bump"],
        allowedUses: decode["allowedUses"]);
  }

  @override
  Structure get layout => _Utils.layout;
  @override
  Map<String, dynamic> serialize() {
    return {"key": key.value, "bump": bump, "allowedUses": allowedUses};
  }
}
