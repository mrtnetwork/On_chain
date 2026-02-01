import 'package:on_chain/solana/src/address/sol_address.dart';
import 'package:blockchain_utils/layout/layout.dart';
import 'package:on_chain/solana/src/borsh_serialization/program_layout.dart';
import 'package:on_chain/solana/src/utils/layouts.dart';

class _Utils {
  static const List<int> discriminator = [130, 48, 247, 244, 182, 191, 30, 26];

  static StructLayout get layout => LayoutConst.struct([
        LayoutConst.blob(8, property: 'discriminator'),
        SolanaLayoutUtils.publicKey('admin'),
        LayoutConst.string(property: 'name'),
        LayoutConst.string(property: 'description'),
      ]);
}

class Store extends BorshLayoutSerializable {
  final SolAddress admin;
  final String name;
  final String description;

  const Store({
    required this.admin,
    required this.name,
    required this.description,
  });
  factory Store.fromBuffer(List<int> data) {
    final decode = BorshLayoutSerializable.decode(
        bytes: data,
        layout: _Utils.layout,
        validator: {'discriminator': _Utils.discriminator});
    return Store(
        name: decode['name'],
        admin: decode['admin'],
        description: decode['description']);
  }

  @override
  StructLayout get layout => _Utils.layout;

  @override
  Map<String, dynamic> serialize() {
    return {
      'discriminator': _Utils.discriminator,
      'description': description,
      'admin': admin,
      'name': name
    };
  }

  @override
  String toString() {
    return 'Store${serialize()}';
  }
}
