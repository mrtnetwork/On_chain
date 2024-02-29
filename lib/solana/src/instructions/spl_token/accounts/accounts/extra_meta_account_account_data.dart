import 'package:on_chain/solana/src/instructions/spl_token/types/types.dart';
import 'package:on_chain/solana/src/layout/layout.dart';

class _Utils {
  static Structure layout = LayoutUtils.struct([
    LayoutUtils.u64('instructionDiscriminator'),
    LayoutUtils.u32("length"),
    ExtraAccountMetaList.staticLayout,
  ], "extraAccountMetaList");
}

class ExtraAccountMetaAccountData extends LayoutSerializable {
  ExtraAccountMetaAccountData({
    required this.instructionDiscriminator,
    required this.length,
    required this.extraAccountMetaList,
  });
  final BigInt instructionDiscriminator;
  final int length;
  final ExtraAccountMetaList extraAccountMetaList;
  factory ExtraAccountMetaAccountData.fromBuffer(List<int> accountBytes) {
    final decode =
        LayoutSerializable.decode(bytes: accountBytes, layout: _Utils.layout);
    return ExtraAccountMetaAccountData(
        instructionDiscriminator: decode["instructionDiscriminator"],
        length: decode["length"],
        extraAccountMetaList:
            ExtraAccountMetaList.fromJson(decode["extraAccountMetaList"]));
  }

  @override
  Structure get layout => _Utils.layout;

  @override
  Map<String, dynamic> serialize() {
    return {
      "instructionDiscriminator": instructionDiscriminator,
      "length": length,
      "extraAccountMetaList": extraAccountMetaList.serialize(),
    };
  }

  @override
  String toString() {
    return "ExtraAccountMetaAccountData${serialize()}";
  }

  List<ExtraAccountMeta> get extraAccountMetas {
    return extraAccountMetaList.extraAccounts
        .sublist(0, extraAccountMetaList.count);
  }
}
