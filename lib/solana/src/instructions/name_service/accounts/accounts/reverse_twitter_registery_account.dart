import 'package:on_chain/solana/src/address/sol_address.dart';
import 'package:on_chain/solana/src/instructions/name_service/accounts/accounts/name_registery_account.dart';
import 'package:blockchain_utils/layout/layout.dart';
import 'package:on_chain/solana/src/borsh_serialization/program_layout.dart';
import 'package:on_chain/solana/src/utils/layouts.dart';

class _Utils {
  static final StructLayout layout = LayoutConst.struct([
    SolanaLayoutUtils.publicKey('twitterRegistryKey'),
    LayoutConst.string(property: 'twitterHandle'),
  ]);
}

class ReverseTwitterRegistryAccount extends LayoutSerializable {
  final SolAddress twitterRegistryKey;
  final String twitterHandle;

  ReverseTwitterRegistryAccount(
      {required this.twitterRegistryKey, required this.twitterHandle});
  factory ReverseTwitterRegistryAccount.fromBuffer(List<int> data) {
    final decode =
        LayoutSerializable.decode(bytes: data, layout: _Utils.layout);
    return ReverseTwitterRegistryAccount(
        twitterRegistryKey: decode['twitterRegistryKey'],
        twitterHandle: decode['twitterHandle']);
  }
  factory ReverseTwitterRegistryAccount.fromAccountBytes(
      List<int> accountBytes) {
    final decode = LayoutSerializable.decode(
        bytes: accountBytes.sublist(NameRegistryAccountUtils.hiddenDataOffset),
        layout: _Utils.layout);
    return ReverseTwitterRegistryAccount(
        twitterRegistryKey: decode['twitterRegistryKey'],
        twitterHandle: decode['twitterHandle']);
  }

  @override
  StructLayout get layout => _Utils.layout;
  @override
  Map<String, dynamic> serialize() {
    return {
      'twitterRegistryKey': twitterRegistryKey,
      'twitterHandle': twitterHandle
    };
  }

  @override
  String toString() {
    return 'ReverseTwitterRegistryAccount.${serialize()}';
  }
}
