import 'package:blockchain_utils/exception/exception.dart';
import 'package:on_chain/solana/src/layout/layout.dart';

class MemoTransferInstruction extends LayoutSerializable {
  const MemoTransferInstruction._(this.name);
  final String name;

  /// Require memos for transfers into this Account. Adds the MemoTransfer
  /// extension to the Account, if it doesn't already exist.
  static const MemoTransferInstruction enable =
      MemoTransferInstruction._("Enable");

  /// Stop requiring memos for transfers into this Account.
  static const MemoTransferInstruction disable =
      MemoTransferInstruction._("Disable");
  static const List<MemoTransferInstruction> values = [enable, disable];

  static Structure staticLayout = LayoutUtils.struct([
    LayoutUtils.rustEnum(
        values.map((e) => LayoutUtils.none(e.name)).toList(), LayoutUtils.u8(),
        property: "memoTransfer")
  ]);
  @override
  Structure get layout => staticLayout;

  @override
  Map<String, dynamic> serialize() {
    return {
      "memoTransfer": {name: null}
    };
  }

  factory MemoTransferInstruction.fromJson(Map<String, dynamic> json) {
    return fromName(json["memoTransfer"]["key"]);
  }
  static MemoTransferInstruction fromName(String? value) {
    return values.firstWhere(
      (element) => element.name == value,
      orElse: () => throw MessageException(
          "No MemoTransferInstruction found matching the specified value",
          details: {"value": value}),
    );
  }
}
