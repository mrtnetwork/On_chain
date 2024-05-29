import 'package:on_chain/solana/src/address/sol_address.dart';
import 'package:on_chain/solana/src/instructions/metaplex/gumdrop/types/types/config_data.dart';
import 'package:blockchain_utils/layout/layout.dart';
import 'package:on_chain/solana/src/borsh_serialization/program_layout.dart';
import 'package:on_chain/solana/src/utils/layouts.dart';

class _Utils {
  static const List<int> discriminator = [155, 12, 170, 224, 30, 250, 204, 130];

  static final StructLayout layout = LayoutConst.struct([
    LayoutConst.blob(8, property: "discriminator"),
    SolanaLayoutUtils.publicKey("authority"),
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
  StructLayout get layout => _Utils.layout;

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
