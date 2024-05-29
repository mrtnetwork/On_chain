import 'package:on_chain/solana/src/instructions/metaplex/token_meta_data/types/types.dart';
import 'package:blockchain_utils/layout/layout.dart';
import 'package:on_chain/solana/src/borsh_serialization/program_layout.dart';

class _Utils {
  static final StructLayout layout = LayoutConst.struct([
    LayoutConst.u8(property: "key"),
    LayoutConst.u64(property: "supply"),
    LayoutConst.optional(LayoutConst.u64(), property: "maxSupply")
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
  StructLayout get layout => _Utils.layout;
  @override
  Map<String, dynamic> serialize() {
    return {"key": key.value, "supply": supply, "maxSupply": maxSupply};
  }
}
