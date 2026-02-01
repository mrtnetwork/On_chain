import 'package:on_chain/solana/src/exception/exception.dart';
import 'package:blockchain_utils/layout/layout.dart';
import 'package:on_chain/solana/src/borsh_serialization/program_layout.dart';

class DefaultAccountStateInstruction extends BorshLayoutSerializable {
  const DefaultAccountStateInstruction._(this.name);
  final String name;

  /// Initialize a new mint with the default state for new Accounts.
  static const DefaultAccountStateInstruction initialize =
      DefaultAccountStateInstruction._('Initialize');

  /// Update the default state for new Accounts. Only supported for mints that
  /// include the [DefaultAccountState] extension.
  static const DefaultAccountStateInstruction update =
      DefaultAccountStateInstruction._('Update');
  static const List<DefaultAccountStateInstruction> values = [
    initialize,
    update
  ];

  static StructLayout staticLayout = LayoutConst.struct([
    LayoutConst.rustEnum(
        values.map((e) => LayoutConst.none(property: e.name)).toList(),
        property: 'defaultAccountState')
  ]);
  @override
  StructLayout get layout => staticLayout;

  @override
  Map<String, dynamic> serialize() {
    return {
      'defaultAccountState': {name: null}
    };
  }

  factory DefaultAccountStateInstruction.fromJson(Map<String, dynamic> json) {
    return fromName(json['defaultAccountState']['key']);
  }
  static DefaultAccountStateInstruction fromName(String? value) {
    return values.firstWhere(
      (element) => element.name == value,
      orElse: () => throw SolanaPluginException(
          'No DefaultAccountState found matching the specified value',
          details: {'value': value}),
    );
  }

  @override
  String toString() {
    return 'DefaultAccountState${serialize()}';
  }
}
