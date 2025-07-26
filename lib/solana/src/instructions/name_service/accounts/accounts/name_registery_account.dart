import 'package:blockchain_utils/blockchain_utils.dart';
import 'package:on_chain/solana/src/address/sol_address.dart';
import 'package:on_chain/solana/src/borsh_serialization/program_layout.dart';
import 'package:on_chain/solana/src/utils/layouts.dart';

class NameRegistryAccountUtils {
  static final StructLayout layout = LayoutConst.struct([
    SolanaLayoutUtils.publicKey('parentName'),
    SolanaLayoutUtils.publicKey('owner'),
    SolanaLayoutUtils.publicKey('classAccount'),
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
      : data = data = data.asImmutableBytes;
  factory NameRegistryAccount.fromBuffer(List<int> data) {
    final decode = LayoutSerializable.decode(
        bytes: data, layout: NameRegistryAccountUtils.layout);
    return NameRegistryAccount(
        parentName: decode['parentName'],
        owner: decode['owner'],
        classAccount: decode['classAccount'],
        data: data.sublist(NameRegistryAccountUtils.hiddenDataOffset));
  }

  @override
  StructLayout get layout => NameRegistryAccountUtils.layout;
  @override
  Map<String, dynamic> serialize() {
    return {
      'parentName': parentName,
      'owner': owner,
      'classAccount': classAccount
    };
  }

  @override
  List<int> toBytes() {
    return [...super.toBytes(), ...data];
  }

  @override
  String toString() {
    return 'NameRegistryAccount.${serialize()}';
  }
}
