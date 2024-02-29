import 'package:blockchain_utils/blockchain_utils.dart';
import 'package:on_chain/solana/src/instructions/metaplex/token_meta_data/types/types.dart';
import 'package:on_chain/solana/src/layout/layout.dart';

class _Utils {
  static final Structure layout = LayoutUtils.struct(
      [LayoutUtils.u8("key"), LayoutUtils.blob(31, property: "ledger")]);
}

class EditionMarker extends LayoutSerializable {
  final MetaDataKey key;
  final List<int> ledger;

  EditionMarker({required this.key, required List<int> ledger})
      : ledger = BytesUtils.toBytes(ledger, unmodifiable: true);
  factory EditionMarker.fromBuffer(List<int> data) {
    final decode =
        LayoutSerializable.decode(bytes: data, layout: _Utils.layout);
    return EditionMarker(
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
    return "EditionMarker${serialize()}";
  }
}
