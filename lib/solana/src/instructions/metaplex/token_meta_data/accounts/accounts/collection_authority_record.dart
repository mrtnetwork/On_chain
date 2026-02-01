import 'package:on_chain/solana/src/address/sol_address.dart';
import 'package:on_chain/solana/src/instructions/metaplex/token_meta_data/types/types.dart';
import 'package:blockchain_utils/layout/layout.dart';
import 'package:on_chain/solana/src/borsh_serialization/program_layout.dart';
import 'package:on_chain/solana/src/utils/layouts.dart';

class _Utils {
  static StructLayout get layout => LayoutConst.struct([
        LayoutConst.u8(property: 'key'),
        LayoutConst.u8(property: 'bump'),
        SolanaLayoutUtils.optionPubkey(property: 'updateAuthority')
      ]);
}

class CollectionAuthorityRecord extends BorshLayoutSerializable {
  final MetaDataKey key;
  final int bump;
  final SolAddress? updateAuthority;

  const CollectionAuthorityRecord(
      {required this.key, required this.bump, this.updateAuthority});
  factory CollectionAuthorityRecord.fromBuffer(List<int> data) {
    final decode =
        BorshLayoutSerializable.decode(bytes: data, layout: _Utils.layout);
    return CollectionAuthorityRecord(
        key: MetaDataKey.fromValue(decode['key']),
        bump: decode['bump'],
        updateAuthority: decode['updateAuthority']);
  }

  @override
  StructLayout get layout => _Utils.layout;
  @override
  Map<String, dynamic> serialize() {
    return {'key': key.value, 'bump': bump, 'updateAuthority': updateAuthority};
  }

  @override
  String toString() {
    return 'CollectionAuthorityRecord${serialize()}';
  }
}
