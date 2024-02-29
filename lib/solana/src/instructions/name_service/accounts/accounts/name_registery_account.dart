import 'package:blockchain_utils/blockchain_utils.dart';
import 'package:on_chain/solana/src/address/sol_address.dart';
import 'package:on_chain/solana/src/layout/layout.dart';

class NameRegistryAccountUtils {
  static final Structure layout = LayoutUtils.struct([
    LayoutUtils.publicKey('parentName'),
    LayoutUtils.publicKey('owner'),
    LayoutUtils.publicKey('classAccount'),
  ]);
  static const int hiddenDataOffset = 96;
}

class NameRegistryAccount extends LayoutSerializable {
  final SolAddress parentName;
  final SolAddress owner;
  final SolAddress classAccount;
  final List<int> data;

  NameRegistryAccount(
      {required this.parentName,
      required this.owner,
      required this.classAccount,
      required List<int> data})
      : data = BytesUtils.toBytes(data, unmodifiable: true);
  factory NameRegistryAccount.fromBuffer(List<int> data) {
    final decode = LayoutSerializable.decode(
        bytes: data, layout: NameRegistryAccountUtils.layout);
    return NameRegistryAccount(
        parentName: decode["parentName"],
        owner: decode["owner"],
        classAccount: decode["classAccount"],
        data: data.sublist(NameRegistryAccountUtils.hiddenDataOffset));
  }

  @override
  Structure get layout => NameRegistryAccountUtils.layout;
  @override
  Map<String, dynamic> serialize() {
    return {
      "parentName": parentName,
      "owner": owner,
      "classAccount": classAccount
    };
  }

  @override
  List<int> toBytes() {
    return [...super.toBytes(), ...data];
  }

  @override
  String toString() {
    return "NameRegistryAccount.${serialize()}";
  }
}
