import 'package:on_chain/solana/src/address/sol_address.dart';
import 'package:on_chain/solana/src/instructions/name_service/accounts/accounts/name_registery_account.dart';
import 'package:on_chain/solana/src/layout/layout.dart';

class _Utils {
  static final Structure layout = LayoutUtils.struct([
    LayoutUtils.publicKey('twitterRegistryKey'),
    LayoutUtils.string('twitterHandle'),
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
        twitterRegistryKey: decode["twitterRegistryKey"],
        twitterHandle: decode["twitterHandle"]);
  }
  factory ReverseTwitterRegistryAccount.fromAccountBytes(
      List<int> accountBytes) {
    final decode = LayoutSerializable.decode(
        bytes: accountBytes.sublist(NameRegistryAccountUtils.hiddenDataOffset),
        layout: _Utils.layout);
    return ReverseTwitterRegistryAccount(
        twitterRegistryKey: decode["twitterRegistryKey"],
        twitterHandle: decode["twitterHandle"]);
  }

  @override
  Structure get layout => _Utils.layout;
  @override
  Map<String, dynamic> serialize() {
    return {
      "twitterRegistryKey": twitterRegistryKey,
      "twitterHandle": twitterHandle
    };
  }

  @override
  String toString() {
    return "ReverseTwitterRegistryAccount.${serialize()}";
  }
}
