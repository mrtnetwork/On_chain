import 'package:on_chain/solana/src/address/sol_address.dart';
import 'package:on_chain/solana/src/instructions/metaplex/nft_packs/types/types/account_type.dart';
import 'package:blockchain_utils/layout/layout.dart';
import 'package:on_chain/solana/src/borsh_serialization/program_layout.dart';
import 'package:on_chain/solana/src/utils/layouts.dart';

class _Utils {
  static final StructLayout layout = LayoutConst.struct([
    LayoutConst.u8(property: "accountType"),
    SolanaLayoutUtils.publicKey("packSet"),
    SolanaLayoutUtils.publicKey("master"),
    SolanaLayoutUtils.publicKey("metadata"),
    SolanaLayoutUtils.publicKey("tokenAccount"),
    LayoutConst.u32(property: "maxSupply"),
    LayoutConst.u16(property: "weight"),
  ]);
}

class PackCard extends LayoutSerializable {
  static int get size => _Utils.layout.span;
  final NFTPacksAccountType accountType;
  final SolAddress packSet;
  final SolAddress master;
  final SolAddress metadata;
  final SolAddress tokenAccount;
  final int maxSupply;
  final int weight;

  const PackCard(
      {required this.accountType,
      required this.packSet,
      required this.master,
      required this.metadata,
      required this.tokenAccount,
      required this.maxSupply,
      required this.weight});
  factory PackCard.fromBuffer(List<int> data) {
    final decode =
        LayoutSerializable.decode(bytes: data, layout: _Utils.layout);
    return PackCard(
        accountType: NFTPacksAccountType.fromValue(decode["accountType"]),
        packSet: decode["packSet"],
        master: decode["master"],
        metadata: decode["metadata"],
        tokenAccount: decode["tokenAccount"],
        maxSupply: decode["maxSupply"],
        weight: decode["weight"]);
  }

  @override
  StructLayout get layout => _Utils.layout;
  @override
  Map<String, dynamic> serialize() {
    return {
      "accountType": accountType.value,
      "packSet": packSet,
      "master": master,
      "metadata": metadata,
      "tokenAccount": tokenAccount,
      "maxSupply": maxSupply,
      "weight": weight
    };
  }

  @override
  String toString() {
    return "PackCard${serialize()}";
  }
}
