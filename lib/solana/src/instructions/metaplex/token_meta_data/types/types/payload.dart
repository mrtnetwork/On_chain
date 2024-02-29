import 'package:on_chain/solana/src/instructions/metaplex/token_meta_data/types/types/payload_type.dart';
import 'package:on_chain/solana/src/layout/layout.dart';

class Payload extends LayoutSerializable {
  final Map<String, PayloadType> map;
  const Payload({required this.map});
  factory Payload.fromJson(Map<String, dynamic> json) {
    final payload = json["payload"] as Map;
    return Payload(map: {
      for (final i in payload.entries) i.key: PayloadType.fromJson(i.value)
    });
  }
  static final Structure staticLayout = LayoutUtils.struct([
    LayoutUtils.map(LayoutUtils.string(), PayloadType.staticLayout,
        property: "payload"),
  ]);
  @override
  Structure get layout => staticLayout;

  @override
  Map<String, dynamic> serialize() {
    return {
      "payload": {for (final i in map.entries) i.key: i.value.serialize()}
    };
  }
}
