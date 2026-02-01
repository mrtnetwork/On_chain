import 'package:on_chain/solana/src/address/sol_address.dart';
import 'package:on_chain/solana/src/instructions/metaplex/token_meta_data/types/types.dart';
import 'package:blockchain_utils/layout/layout.dart';
import 'package:on_chain/solana/src/borsh_serialization/program_layout.dart';
import 'package:on_chain/solana/src/utils/layouts.dart';

class _Utils {
  static StructLayout get layout => LayoutConst.struct([
        LayoutConst.u8(property: 'key'),
        LayoutConst.u8(property: 'bump'),
        SolanaLayoutUtils.publicKey('mint'),
        SolanaLayoutUtils.publicKey('delegate'),
        SolanaLayoutUtils.publicKey('updateAuthority'),
      ]);
}

class MetadataDelegateRecord extends BorshLayoutSerializable {
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
        BorshLayoutSerializable.decode(bytes: data, layout: _Utils.layout);
    return MetadataDelegateRecord(
        key: MetaDataKey.fromValue(decode['key']),
        updateAuthority: decode['updateAuthority'],
        mint: decode['mint'],
        bump: decode['bump'],
        delegate: decode['delegate']);
  }

  @override
  StructLayout get layout => _Utils.layout;
  @override
  Map<String, dynamic> serialize() {
    return {
      'key': key.value,
      'updateAuthority': updateAuthority,
      'mint': mint,
      'bump': bump,
      'delegate': delegate
    };
  }
}
