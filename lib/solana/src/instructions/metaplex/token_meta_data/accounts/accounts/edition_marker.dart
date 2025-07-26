import 'package:blockchain_utils/helper/extensions/extensions.dart';
import 'package:blockchain_utils/layout/layout.dart';
import 'package:on_chain/solana/src/instructions/metaplex/token_meta_data/types/types.dart';

import 'package:on_chain/solana/src/borsh_serialization/program_layout.dart';

class _Utils {
  static final StructLayout layout = LayoutConst.struct([
    LayoutConst.u8(property: 'key'),
    LayoutConst.blob(31, property: 'ledger')
  ]);
}

class EditionMarker extends LayoutSerializable {
  final MetaDataKey key;
  final List<int> ledger;

  EditionMarker({required this.key, required List<int> ledger})
      : ledger = ledger.asImmutableBytes;
  factory EditionMarker.fromBuffer(List<int> data) {
    final decode =
        LayoutSerializable.decode(bytes: data, layout: _Utils.layout);
    return EditionMarker(
        key: MetaDataKey.fromValue(decode['key']),
        ledger: (decode['ledger'] as List).cast());
  }

  @override
  StructLayout get layout => _Utils.layout;
  @override
  Map<String, dynamic> serialize() {
    return {'key': key.value, 'ledger': ledger};
  }

  @override
  String toString() {
    return 'EditionMarker${serialize()}';
  }
}
