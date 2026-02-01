import 'package:blockchain_utils/blockchain_utils.dart';
import 'package:on_chain/solana/src/address/sol_address.dart';
import 'package:on_chain/solana/src/borsh_serialization/program_layout.dart';
import 'package:on_chain/solana/src/utils/layouts.dart';

class LeafSchemaV1 extends BorshLayoutSerializable {
  LeafSchemaV1({
    required this.id,
    required this.owner,
    required this.delegate,
    required this.nonce,
    required List<int> dataHash,
    required List<int> creatorHash,
  })  : dataHash = dataHash.asImmutableBytes,
        creatorHash = creatorHash.asImmutableBytes;

  factory LeafSchemaV1.fromJson(Map<String, dynamic> json) {
    return LeafSchemaV1(
        id: json['id'],
        owner: json['owner'],
        delegate: json['delegate'],
        nonce: json['nonce'],
        dataHash: json['dataHash'],
        creatorHash: json['creatorHash']);
  }

  static const int version = 0;
  final SolAddress id;
  final SolAddress owner;
  final SolAddress delegate;
  final BigInt nonce;
  final List<int> dataHash;
  final List<int> creatorHash;
  static StructLayout staticLayout = LayoutConst.struct([
    LayoutConst.u8(property: 'version'),
    SolanaLayoutUtils.publicKey('id'),
    SolanaLayoutUtils.publicKey('owner'),
    SolanaLayoutUtils.publicKey('delegate'),
    LayoutConst.u64(property: 'nonce'),
    LayoutConst.blob(32, property: 'dataHash'),
    LayoutConst.blob(32, property: 'creatorHash'),
  ], property: 'leafschema');

  @override
  StructLayout get layout => staticLayout;

  @override
  Map<String, dynamic> serialize() {
    return {
      'version': version,
      'id': id,
      'owner': owner,
      'delegate': delegate,
      'nonce': nonce,
      'dataHash': dataHash,
      'creatorHash': creatorHash
    };
  }

  @override
  String toString() {
    return 'LeafSchemaV1${serialize()}';
  }
}
