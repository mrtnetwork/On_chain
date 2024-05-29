import 'package:on_chain/solana/src/instructions/spl_token/types/types/extra_account_meta.dart';
import 'package:blockchain_utils/layout/layout.dart';
import 'package:on_chain/solana/src/borsh_serialization/program_layout.dart';

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

  static StructLayout staticLayout = LayoutConst.struct([
    LayoutConst.u32(property: 'count'),
    LayoutConst.greedyArray(ExtraAccountMeta.staticLayout,
        property: "extraAccounts")
  ], property: "extraAccountMetaList");
  @override
  StructLayout get layout => staticLayout;

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
