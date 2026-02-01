import 'package:on_chain/solana/src/instructions/metaplex/token_meta_data/types/types/payload_type.dart';
import 'package:blockchain_utils/layout/layout.dart';
import 'package:on_chain/solana/src/borsh_serialization/program_layout.dart';

class Payload extends BorshLayoutSerializable {
  final Map<String, PayloadType> map;
  const Payload({required this.map});
  factory Payload.fromJson(Map<String, dynamic> json) {
    final payload = json['payload'] as Map;
    return Payload(map: {
      for (final i in payload.entries) i.key: PayloadType.fromJson(i.value)
    });
  }
  static StructLayout get staticLayout => LayoutConst.struct([
        LayoutConst.map(LayoutConst.string(), PayloadType.staticLayout,
            property: 'payload'),
      ]);
  @override
  StructLayout get layout => staticLayout;

  @override
  Map<String, dynamic> serialize() {
    return {
      'payload': {for (final i in map.entries) i.key: i.value.serialize()}
    };
  }
}
