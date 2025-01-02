import 'package:on_chain/solana/src/address/sol_address.dart';
import 'package:on_chain/solana/src/instructions/metaplex/token_meta_data/types/types.dart';
import 'package:blockchain_utils/layout/layout.dart';
import 'package:on_chain/solana/src/borsh_serialization/program_layout.dart';
import 'package:on_chain/solana/src/utils/layouts.dart';

class _Utils {
  static final StructLayout layout = LayoutConst.struct([
    LayoutConst.u8(property: 'key'),
    LayoutConst.u64(property: 'supply'),
    LayoutConst.optional(LayoutConst.u64(), property: 'maxSupply'),
    SolanaLayoutUtils.publicKey('printingMint'),
    SolanaLayoutUtils.publicKey('oneTimePrintingAuthorizationMint'),
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
        key: MetaDataKey.fromValue(decode['key']),
        supply: decode['supply'],
        maxSupply: decode['maxSupply'],
        printingMint: decode['printingMint'],
        oneTimePrintingAuthorizationMint:
            decode['oneTimePrintingAuthorizationMint']);
  }

  @override
  StructLayout get layout => _Utils.layout;
  @override
  Map<String, dynamic> serialize() {
    return {
      'key': key.value,
      'supply': supply,
      'maxSupply': maxSupply,
      'printingMint': printingMint,
      'oneTimePrintingAuthorizationMint': oneTimePrintingAuthorizationMint
    };
  }
}
