import 'package:on_chain/solana/src/address/sol_address.dart';
import 'package:on_chain/solana/src/instructions/metaplex/nft_packs/types/types/account_type.dart';
import 'package:blockchain_utils/layout/layout.dart';
import 'package:on_chain/solana/src/borsh_serialization/program_layout.dart';
import 'package:on_chain/solana/src/utils/layouts.dart';

class _Utils {
  static StructLayout get layout => LayoutConst.struct([
        LayoutConst.u8(property: 'accountType'),
        SolanaLayoutUtils.publicKey('packSet'),
        SolanaLayoutUtils.publicKey('master'),
        SolanaLayoutUtils.publicKey('metadata'),
      ]);
}

class PackVoucher extends BorshLayoutSerializable {
  static int get size => _Utils.layout.span;
  final NFTPacksAccountType accountType;
  final SolAddress packSet;
  final SolAddress master;
  final SolAddress metadata;
  const PackVoucher(
      {required this.accountType,
      required this.packSet,
      required this.master,
      required this.metadata});
  factory PackVoucher.fromBuffer(List<int> data) {
    final decode =
        BorshLayoutSerializable.decode(bytes: data, layout: _Utils.layout);
    return PackVoucher(
        accountType: NFTPacksAccountType.fromValue(decode['accountType']),
        master: decode['master'],
        metadata: decode['metadata'],
        packSet: decode['packSet']);
  }

  @override
  StructLayout get layout => _Utils.layout;
  @override
  Map<String, dynamic> serialize() {
    return {
      'accountType': accountType.value,
      'packSet': packSet,
      'metadata': metadata,
      'master': master
    };
  }

  @override
  String toString() {
    return 'PackVoucher${serialize()}';
  }
}
