import 'package:on_chain/solana/src/address/sol_address.dart';
import 'package:on_chain/solana/src/instructions/metaplex/token_meta_data/types/types.dart';
import 'package:blockchain_utils/layout/layout.dart';
import 'package:on_chain/solana/src/borsh_serialization/program_layout.dart';
import 'package:on_chain/solana/src/utils/layouts.dart';

class _Utils {
  static StructLayout get layout => LayoutConst.struct([
        LayoutConst.u8(property: 'key'),
        SolanaLayoutUtils.publicKey('baseToken'),
        LayoutConst.wrap(EscrowAuthority.staticLayout, property: 'authority'),
        LayoutConst.u8(property: 'bump'),
      ]);
}

class TokenOwnedEscrow extends BorshLayoutSerializable {
  final MetaDataKey key;
  final SolAddress baseToken;
  final EscrowAuthority authority;
  final int bump;

  const TokenOwnedEscrow(
      {required this.key,
      required this.baseToken,
      required this.authority,
      required this.bump});
  factory TokenOwnedEscrow.fromBuffer(List<int> data) {
    final decode =
        BorshLayoutSerializable.decode(bytes: data, layout: _Utils.layout);
    return TokenOwnedEscrow(
        key: MetaDataKey.fromValue(decode['key']),
        baseToken: decode['baseToken'],
        authority: EscrowAuthority.fromJson(decode['authority']),
        bump: decode['bump']);
  }

  @override
  StructLayout get layout => _Utils.layout;
  @override
  Map<String, dynamic> serialize() {
    return {
      'key': key.value,
      'baseToken': baseToken,
      'authority': authority.serialize(),
      'bump': bump
    };
  }
}
