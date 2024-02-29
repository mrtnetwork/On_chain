import 'package:on_chain/solana/src/address/sol_address.dart';
import 'package:on_chain/solana/src/instructions/metaplex/token_meta_data/types/types.dart';
import 'package:on_chain/solana/src/layout/layout.dart';

class _Utils {
  static final Structure layout = LayoutUtils.struct([
    LayoutUtils.u8("key"),
    LayoutUtils.publicKey("baseToken"),
    LayoutUtils.wrap(EscrowAuthority.staticLayout, property: "authority"),
    LayoutUtils.u8("bump"),
  ]);
}

class TokenOwnedEscrow extends LayoutSerializable {
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
        LayoutSerializable.decode(bytes: data, layout: _Utils.layout);
    return TokenOwnedEscrow(
        key: MetaDataKey.fromValue(decode["key"]),
        baseToken: decode["baseToken"],
        authority: EscrowAuthority.fromJson(decode["authority"]),
        bump: decode["bump"]);
  }

  @override
  Structure get layout => _Utils.layout;
  @override
  Map<String, dynamic> serialize() {
    return {
      "key": key.value,
      "baseToken": baseToken,
      "authority": authority.serialize(),
      "bump": bump
    };
  }
}
