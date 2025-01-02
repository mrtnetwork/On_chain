import 'package:on_chain/solana/src/address/sol_address.dart';
import 'package:on_chain/solana/src/instructions/metaplex/candy_machine_core/types/types.dart';
import 'package:on_chain/solana/src/instructions/metaplex/token_meta_data/types/types/token_standard.dart';
import 'package:blockchain_utils/layout/layout.dart';
import 'package:on_chain/solana/src/borsh_serialization/program_layout.dart';
import 'package:on_chain/solana/src/utils/layouts.dart';

class _Utils {
  static const List<int> discriminator = [51, 173, 177, 113, 25, 241, 109, 189];
  static final StructLayout layout = LayoutConst.struct([
    LayoutConst.blob(8, property: 'discriminator'),
    LayoutConst.wrap(CandyMachineAccountVersion.staticLayout,
        property: 'version'),
    LayoutConst.wrap(MetaDataTokenStandard.staticLayout,
        property: 'tokenStandard'),
    LayoutConst.blob(6, property: 'features'),
    SolanaLayoutUtils.publicKey('authority'),
    SolanaLayoutUtils.publicKey('mintAuthority'),
    SolanaLayoutUtils.publicKey('collectionMint'),
    LayoutConst.u64(property: 'itemsRedeemed'),
    CandyMachineData.staticLayout
  ]);
}

class CandyMachineAccount extends LayoutSerializable {
  final CandyMachineAccountVersion version;
  final MetaDataTokenStandard tokenStandard;
  final List<int> features;
  final SolAddress authority;
  final SolAddress mintAuthority;
  final SolAddress collectionMint;
  final BigInt itemsRedeemed;
  final CandyMachineData data;
  const CandyMachineAccount(
      {required this.version,
      required this.tokenStandard,
      required this.features,
      required this.authority,
      required this.mintAuthority,
      required this.collectionMint,
      required this.itemsRedeemed,
      required this.data});
  factory CandyMachineAccount.fromBuffer(List<int> data) {
    final decode = LayoutSerializable.decode(
        bytes: data,
        layout: _Utils.layout,
        validator: {'discriminator': _Utils.discriminator});
    return CandyMachineAccount(
        version: CandyMachineAccountVersion.fromJson(decode['version']),
        tokenStandard: MetaDataTokenStandard.fromJson(decode['tokenStandard']),
        features: (decode['features'] as List).cast(),
        authority: decode['authority'],
        mintAuthority: decode['mintAuthority'],
        collectionMint: decode['collectionMint'],
        itemsRedeemed: decode['itemsRedeemed'],
        data: CandyMachineData.fromJson(decode['candyMachineData']));
  }

  @override
  StructLayout get layout => _Utils.layout;

  @override
  Map<String, dynamic> serialize() {
    return {
      'discriminator': _Utils.discriminator,
      'version': version.serialize(),
      'tokenStandard': tokenStandard.serialize(),
      'features': features,
      'authority': authority,
      'mintAuthority': mintAuthority,
      'collectionMint': collectionMint,
      'itemsRedeemed': itemsRedeemed,
      'candyMachineData': data.serialize()
    };
  }

  @override
  String toString() {
    return 'CandyMachineAccount${serialize()}';
  }
}
