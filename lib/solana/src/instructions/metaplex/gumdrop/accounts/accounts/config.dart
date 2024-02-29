import 'package:on_chain/solana/src/address/sol_address.dart';
import 'package:on_chain/solana/src/instructions/metaplex/gumdrop/types/types/config_data.dart';
import 'package:on_chain/solana/src/layout/layout.dart';

class _Utils {
  static const List<int> discriminator = [155, 12, 170, 224, 30, 250, 204, 130];

  static final Structure layout = LayoutUtils.struct([
    LayoutUtils.blob(8, property: "discriminator"),
    LayoutUtils.publicKey("authority"),
    GumdropConfigData.staticLayout
  ]);
}

class GumdropConfig extends LayoutSerializable {
  final SolAddress authority;
  final GumdropConfigData data;

  GumdropConfig({required this.authority, required this.data});
  factory GumdropConfig.fromBuffer(List<int> data) {
    final decode = LayoutSerializable.decode(
        bytes: data,
        layout: _Utils.layout,
        validator: {"discriminator": _Utils.discriminator});
    return GumdropConfig(
        authority: decode["authority"],
        data: GumdropConfigData.fromJson(decode["configData"]));
  }

  @override
  Structure get layout => _Utils.layout;

  @override
  Map<String, dynamic> serialize() {
    return {
      "discriminator": _Utils.discriminator,
      "authority": authority,
      "configData": data.serialize()
    };
  }

  @override
  String toString() {
    return "GumdropConfig${serialize()}";
  }
}
