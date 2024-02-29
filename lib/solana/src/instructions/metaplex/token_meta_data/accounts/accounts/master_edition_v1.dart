import 'package:on_chain/solana/src/address/sol_address.dart';
import 'package:on_chain/solana/src/instructions/metaplex/token_meta_data/types/types.dart';
import 'package:on_chain/solana/src/layout/layout.dart';

class _Utils {
  static final Structure layout = LayoutUtils.struct([
    LayoutUtils.u8("key"),
    LayoutUtils.u64("supply"),
    LayoutUtils.optional(LayoutUtils.u64(), property: "maxSupply"),
    LayoutUtils.publicKey("printingMint"),
    LayoutUtils.publicKey("oneTimePrintingAuthorizationMint"),
  ]);
}

class MasterEditionV1 extends LayoutSerializable {
  final MetaDataKey key;
  final BigInt supply;
  final BigInt? maxSupply;
  final SolAddress printingMint;
  final SolAddress oneTimePrintingAuthorizationMint;

  MasterEditionV1(
      {required this.key,
      required this.supply,
      this.maxSupply,
      required this.printingMint,
      required this.oneTimePrintingAuthorizationMint});
  factory MasterEditionV1.fromBuffer(List<int> data) {
    final decode =
        LayoutSerializable.decode(bytes: data, layout: _Utils.layout);
    return MasterEditionV1(
        key: MetaDataKey.fromValue(decode["key"]),
        supply: decode["supply"],
        maxSupply: decode["maxSupply"],
        printingMint: decode["printingMint"],
        oneTimePrintingAuthorizationMint:
            decode["oneTimePrintingAuthorizationMint"]);
  }

  @override
  Structure get layout => _Utils.layout;
  @override
  Map<String, dynamic> serialize() {
    return {
      "key": key.value,
      "supply": supply,
      "maxSupply": maxSupply,
      "printingMint": printingMint,
      "oneTimePrintingAuthorizationMint": oneTimePrintingAuthorizationMint
    };
  }
}
