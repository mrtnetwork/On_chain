import 'package:on_chain/solana/src/exception/exception.dart';
import 'package:blockchain_utils/layout/layout.dart';
import 'package:on_chain/solana/src/address/sol_address.dart';
import 'package:on_chain/solana/src/borsh_serialization/program_layout.dart';
import 'package:on_chain/solana/src/utils/layouts.dart';

class EscrowAuthority extends LayoutSerializable {
  final String name;
  final dynamic fields;
  const EscrowAuthority._(this.name, this.fields);
  static const EscrowAuthority tokenOwner =
      EscrowAuthority._('TokenOwner', null);
  factory EscrowAuthority.creator({required SolAddress creator}) {
    return EscrowAuthority._('Creator', [creator]);
  }
  factory EscrowAuthority.fromJson(Map<String, dynamic> json) {
    final name = json['escrowAuthority']['key'];
    final value = json['escrowAuthority']['value'];
    if (name != 'Creator' && name != 'TokenOwner') {}
    switch (name) {
      case 'TokenOwner':
        return tokenOwner;
      case 'Creator':
        return EscrowAuthority.creator(creator: (value as List)[0]);
      default:
        throw const SolanaPluginException('Invalid escrowAuthority version');
    }
  }
  static StructLayout staticLayout = LayoutConst.struct([
    LayoutConst.rustEnum([
      LayoutConst.none(property: 'TokenOwner'),
      LayoutConst.tuple([SolanaLayoutUtils.publicKey()], property: 'Creator')
    ], property: 'escrowAuthority')
  ]);

  @override
  StructLayout get layout => staticLayout;
  @override
  Map<String, dynamic> serialize() {
    return {
      'escrowAuthority': {name: fields}
    };
  }
}
