import 'package:on_chain/solana/src/instructions/metaplex/token_meta_data/types/types.dart';
import 'package:on_chain/solana/src/layout/layout.dart';

class _Utils {
  static final Structure layout = LayoutUtils.struct([
    LayoutUtils.u8("key"),
    LayoutUtils.u64("supply"),
    LayoutUtils.optional(LayoutUtils.u64(), property: "maxSupply")
  ]);
}

class MasterEditionV2 extends LayoutSerializable {
  final MetaDataKey key;
  final BigInt supply;
  final BigInt? maxSupply;

  MasterEditionV2({required this.key, required this.supply, this.maxSupply});
  factory MasterEditionV2.fromBuffer(List<int> data) {
    final decode =
        LayoutSerializable.decode(bytes: data, layout: _Utils.layout);
    return MasterEditionV2(
        key: MetaDataKey.fromValue(decode["key"]),
        supply: decode["supply"],
        maxSupply: decode["maxSupply"]);
  }

  @override
  Structure get layout => _Utils.layout;
  @override
  Map<String, dynamic> serialize() {
    return {"key": key.value, "supply": supply, "maxSupply": maxSupply};
  }
}
