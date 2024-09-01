import 'package:blockchain_utils/layout/layout.dart';
import 'package:on_chain/solana/src/exception/exception.dart';
import 'package:on_chain/solana/src/instructions/metaplex/nft_packs/types/types/account_type.dart';
import 'package:on_chain/solana/src/instructions/metaplex/nft_packs/types/types/clean_up_action.dart';

import 'package:on_chain/solana/src/borsh_serialization/program_layout.dart';

class _Utils {
  static StructLayout layout(int? cleanUpAction) => LayoutConst.struct([
        LayoutConst.u8(property: "accountType"),
        LayoutConst.vec(
            LayoutConst.tuple(
                [LayoutConst.u32(), LayoutConst.u32(), LayoutConst.u32()]),
            property: "weight"),
        LayoutConst.u8(property: "cleanUpAction"),
        if (cleanUpAction == 0)
          LayoutConst.tuple([
            LayoutConst.u32(),
            LayoutConst.u32(),
          ], property: "fields")
      ]);
}

class PackConfig extends LayoutSerializable {
  final NFTPacksAccountType accountType;
  final List<List<int>> weight;
  final CleanUpAction actionToDo;

  const PackConfig._(
      {required this.accountType,
      required this.weight,
      required this.actionToDo});
  factory PackConfig(
      {required NFTPacksAccountType accountType,
      required List<List<int>> weight,
      required CleanUpAction actionToDo}) {
    for (final i in weight) {
      if (i.length != 3) {
        throw const SolanaPluginException(
            "Each inner list in the weight parameter must have a length of 3");
      }
    }
    return PackConfig._(
        accountType: accountType, weight: weight, actionToDo: actionToDo);
  }

  factory PackConfig.fromBuffer(List<int> data) {
    Map<String, dynamic> decode =
        LayoutSerializable.decode(bytes: data, layout: _Utils.layout(null));
    if (decode["cleanUpAction"] == 0) {
      decode = LayoutSerializable.decode(bytes: data, layout: _Utils.layout(0));
    }
    return PackConfig(
        accountType: NFTPacksAccountType.fromValue(decode["accountType"]),
        weight:
            (decode["weight"] as List).map((e) => List<int>.from(e)).toList(),
        actionToDo: CleanUpAction.fromJson(decode));
  }

  @override
  StructLayout get layout => _Utils.layout(actionToDo.kind);
  @override
  Map<String, dynamic> serialize() {
    return {
      "accountType": accountType.value,
      "weight": weight,
      "cleanUpAction": actionToDo.kind,
      "fields": actionToDo.fields
    };
  }

  @override
  String toString() {
    return "PackConfig${serialize()}";
  }
}
