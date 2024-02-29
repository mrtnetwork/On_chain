import 'package:on_chain/solana/src/address/sol_address.dart';
import 'package:on_chain/solana/src/layout/layout.dart';

class _Utils {
  static const List<int> discriminator = [130, 48, 247, 244, 182, 191, 30, 26];

  static final Structure layout = LayoutUtils.struct([
    LayoutUtils.blob(8, property: "discriminator"),
    LayoutUtils.publicKey("admin"),
    LayoutUtils.string("name"),
    LayoutUtils.string("description"),
  ]);
}

class Store extends LayoutSerializable {
  final SolAddress admin;
  final String name;
  final String description;

  const Store({
    required this.admin,
    required this.name,
    required this.description,
  });
  factory Store.fromBuffer(List<int> data) {
    final decode = LayoutSerializable.decode(
        bytes: data,
        layout: _Utils.layout,
        validator: {"discriminator": _Utils.discriminator});
    return Store(
        name: decode["name"],
        admin: decode["admin"],
        description: decode["description"]);
  }

  @override
  Structure get layout => _Utils.layout;

  @override
  Map<String, dynamic> serialize() {
    return {
      "discriminator": _Utils.discriminator,
      "description": description,
      "admin": admin,
      "name": name
    };
  }

  @override
  String toString() {
    return "Store${serialize()}";
  }
}
