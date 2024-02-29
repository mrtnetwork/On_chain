import 'package:blockchain_utils/blockchain_utils.dart';
import 'package:on_chain/solana/src/instructions/metaplex/token_meta_data/types/types.dart';
import 'package:on_chain/solana/src/layout/layout.dart';

class _Utils {
  static final Structure layout =
      LayoutUtils.struct([LayoutUtils.u8("key"), LayoutUtils.vecU8("ledger")]);
}

class EditionMarkerV2 extends LayoutSerializable {
  final MetaDataKey key;
  final List<int> ledger;

  EditionMarkerV2({required this.key, required List<int> ledger})
      : ledger = BytesUtils.toBytes(ledger, unmodifiable: true);
  factory EditionMarkerV2.fromBuffer(List<int> data) {
    final decode =
        LayoutSerializable.decode(bytes: data, layout: _Utils.layout);
    return EditionMarkerV2(
        key: MetaDataKey.fromValue(decode["key"]),
        ledger: (decode["ledger"] as List).cast());
  }

  @override
  Structure get layout => _Utils.layout;
  @override
  Map<String, dynamic> serialize() {
    return {"key": key.value, "ledger": ledger};
  }

  @override
  String toString() {
    return "EditionMarkerV2${serialize()}";
  }
}
