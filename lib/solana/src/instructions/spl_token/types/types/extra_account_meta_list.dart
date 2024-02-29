import 'package:on_chain/solana/src/instructions/spl_token/types/types/extra_account_meta.dart';
import 'package:on_chain/solana/src/layout/layout.dart';

class ExtraAccountMetaList extends LayoutSerializable {
  final int count;
  final List<ExtraAccountMeta> extraAccounts;
  ExtraAccountMetaList({
    required this.count,
    required List<ExtraAccountMeta> extraAccounts,
  }) : extraAccounts = List<ExtraAccountMeta>.unmodifiable(extraAccounts);

  factory ExtraAccountMetaList.fromJson(Map<String, dynamic> json) {
    return ExtraAccountMetaList(
        count: json["count"],
        extraAccounts: (json["extraAccounts"] as List)
            .map((e) => ExtraAccountMeta.fromJson(e))
            .toList());
  }

  static Structure staticLayout = LayoutUtils.struct([
    LayoutUtils.u32('count'),
    LayoutUtils.greedyArray(ExtraAccountMeta.staticLayout,
        property: "extraAccounts")
  ], "extraAccountMetaList");
  @override
  Structure get layout => staticLayout;

  @override
  Map<String, dynamic> serialize() {
    return {
      "count": count,
      "extraAccounts": extraAccounts.map((e) => e.serialize()).toList(),
    };
  }

  @override
  String toString() {
    return "ExtraAccountMetaList${serialize()}";
  }
}
