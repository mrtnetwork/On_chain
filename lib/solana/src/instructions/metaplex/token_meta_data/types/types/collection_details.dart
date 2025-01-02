import 'package:on_chain/solana/src/exception/exception.dart';
import 'package:blockchain_utils/layout/layout.dart';
import 'package:on_chain/solana/src/borsh_serialization/program_layout.dart';

class CollectionDetailsV1 extends LayoutSerializable {
  final BigInt size;
  const CollectionDetailsV1({required this.size});
  factory CollectionDetailsV1.fromJson(Map<String, dynamic> json) {
    if (json['kind'] != 0) {
      throw const SolanaPluginException(
          'invalid or unknown CollectionDetailsV1');
    }
    return CollectionDetailsV1(size: json['size']);
  }

  static StructLayout staticLayout = LayoutConst.struct([
    LayoutConst.u8(property: 'kind'),
    LayoutConst.u64(property: 'size'),
  ], property: 'collectionDetails');

  @override
  StructLayout get layout => staticLayout;

  @override
  Map<String, dynamic> serialize() {
    return {'kind': 0, 'size': size};
  }
}
