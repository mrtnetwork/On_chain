import 'package:on_chain/solana/src/instructions/metaplex/token_meta_data/types/types.dart';
import 'package:blockchain_utils/layout/layout.dart';
import 'package:on_chain/solana/src/borsh_serialization/program_layout.dart';

class _Utils {
  static final StructLayout layout = LayoutConst.struct([
    LayoutConst.u8(property: 'key'),
    LayoutConst.u64(property: 'allowedUses'),
    LayoutConst.u8(property: 'bump')
  ]);
}

class UseAuthorityRecord extends LayoutSerializable {
  final MetaDataKey key;
  final BigInt allowedUses;
  final int bump;

  const UseAuthorityRecord(
      {required this.key, required this.bump, required this.allowedUses});
  factory UseAuthorityRecord.fromBuffer(List<int> data) {
    final decode =
        LayoutSerializable.decode(bytes: data, layout: _Utils.layout);
    return UseAuthorityRecord(
        key: MetaDataKey.fromValue(decode['key']),
        bump: decode['bump'],
        allowedUses: decode['allowedUses']);
  }

  @override
  StructLayout get layout => _Utils.layout;
  @override
  Map<String, dynamic> serialize() {
    return {'key': key.value, 'bump': bump, 'allowedUses': allowedUses};
  }
}
