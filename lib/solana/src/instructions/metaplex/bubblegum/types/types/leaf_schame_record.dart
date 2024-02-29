import 'package:blockchain_utils/blockchain_utils.dart';
import 'package:on_chain/solana/src/address/sol_address.dart';
import 'package:on_chain/solana/src/layout/layout.dart';

class LeafSchemaV1 extends LayoutSerializable {
  LeafSchemaV1({
    required this.id,
    required this.owner,
    required this.delegate,
    required this.nonce,
    required List<int> dataHash,
    required List<int> creatorHash,
  })  : dataHash = BytesUtils.toBytes(dataHash, unmodifiable: true),
        creatorHash = BytesUtils.toBytes(creatorHash, unmodifiable: true);

  factory LeafSchemaV1.fromJson(Map<String, dynamic> json) {
    return LeafSchemaV1(
        id: json["id"],
        owner: json["owner"],
        delegate: json["delegate"],
        nonce: json["nonce"],
        dataHash: json["dataHash"],
        creatorHash: json["creatorHash"]);
  }

  static const int version = 0;
  final SolAddress id;
  final SolAddress owner;
  final SolAddress delegate;
  final BigInt nonce;
  final List<int> dataHash;
  final List<int> creatorHash;
  static Structure staticLayout = LayoutUtils.struct([
    LayoutUtils.u8("version"),
    LayoutUtils.publicKey("id"),
    LayoutUtils.publicKey("owner"),
    LayoutUtils.publicKey("delegate"),
    LayoutUtils.u64("nonce"),
    LayoutUtils.blob(32, property: "dataHash"),
    LayoutUtils.blob(32, property: "creatorHash"),
  ], "leafschema");

  @override
  Structure get layout => staticLayout;

  @override
  Map<String, dynamic> serialize() {
    return {
      "version": version,
      "id": id,
      "owner": owner,
      "delegate": delegate,
      "nonce": nonce,
      "dataHash": dataHash,
      "creatorHash": creatorHash
    };
  }

  @override
  String toString() {
    return "LeafSchemaV1${serialize()}";
  }
}
