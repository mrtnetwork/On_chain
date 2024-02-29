import 'package:on_chain/solana/src/address/sol_address.dart';
import 'package:on_chain/solana/src/layout/layout.dart';

class PayloadType extends LayoutSerializable {
  final String name;
  final int value;
  final dynamic fileds;
  const PayloadType._(this.name, this.value, this.fileds);

  factory PayloadType.fromJson(Map<String, dynamic> json) {
    final key = json["payloadType"]["key"];
    final List<dynamic> value = json["payloadType"]["value"];
    switch (key) {
      case "Pubkey":
        return PayloadType.pubKey(pubkey: value[0]);
      case "Seeds":
        return PayloadType.seeds(
            seeds: (value[0] as List).map((e) => List<int>.from(e)).toList());
      case "MerkleProof":
        return PayloadType.merkleProof(
            proof: (value[0] as List).map((e) => List<int>.from(e)).toList());

      default:
        return PayloadType.number(number: value[0]);
    }
  }
  factory PayloadType.pubKey({required SolAddress pubkey}) {
    return PayloadType._("Pubkey", 0, [pubkey]);
  }
  factory PayloadType.seeds({required List<List<int>> seeds}) {
    return PayloadType._("Seeds", 1, [seeds]);
  }
  factory PayloadType.merkleProof({required List<List<int>> proof}) {
    return PayloadType._("MerkleProof", 2, [proof]);
  }
  factory PayloadType.number({required BigInt number}) {
    return PayloadType._("Number", 3, [number]);
  }
  static Structure staticLayout = LayoutUtils.struct([
    LayoutUtils.rustEnum([
      LayoutUtils.tuple([LayoutUtils.publicKey()], property: "Pubkey"),
      LayoutUtils.tuple([LayoutUtils.vec(LayoutUtils.vecU8())],
          property: "Seeds"),
      LayoutUtils.tuple([LayoutUtils.vec(LayoutUtils.blob(32))],
          property: "MerkleProof"),
      LayoutUtils.tuple([LayoutUtils.u64()], property: "Number")
    ], LayoutUtils.u8(), property: "payloadType")
  ]);

  @override
  Structure get layout => staticLayout;

  @override
  Map<String, dynamic> serialize() {
    return {
      "payloadType": {name: fileds}
    };
  }
}
