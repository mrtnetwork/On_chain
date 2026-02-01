import 'package:blockchain_utils/layout/layout.dart';
import 'package:on_chain/solana/src/borsh_serialization/program_layout.dart';
import 'package:on_chain/solana/src/exception/exception.dart';

class MemoTransferInstruction extends BorshLayoutSerializable {
  const MemoTransferInstruction._(this.name);
  final String name;

  /// Require memos for transfers into this Account. Adds the MemoTransfer
  /// extension to the Account, if it doesn't already exist.
  static const MemoTransferInstruction enable =
      MemoTransferInstruction._('Enable');

  /// Stop requiring memos for transfers into this Account.
  static const MemoTransferInstruction disable =
      MemoTransferInstruction._('Disable');
  static const List<MemoTransferInstruction> values = [enable, disable];

  static StructLayout staticLayout = LayoutConst.struct([
    LayoutConst.rustEnum(
        values.map((e) => LayoutConst.none(property: e.name)).toList(),
        property: 'memoTransfer')
  ]);
  @override
  StructLayout get layout => staticLayout;

  @override
  Map<String, dynamic> serialize() {
    return {
      'memoTransfer': {name: null}
    };
  }

  factory MemoTransferInstruction.fromJson(Map<String, dynamic> json) {
    return fromName(json['memoTransfer']['key']);
  }
  static MemoTransferInstruction fromName(String? value) {
    return values.firstWhere(
      (element) => element.name == value,
      orElse: () => throw SolanaPluginException(
          'No MemoTransferInstruction found matching the specified value',
          details: {'value': value}),
    );
  }
}
