import 'package:on_chain/solana/src/address/sol_address.dart';
import 'package:on_chain/solana/src/instructions/name_service/layouts/instruction/instruction.dart';
import 'package:on_chain/solana/src/layout/layout.dart';

/// Transfer ownership of a name record
class NameServiceTransferLayout extends NameServiceProgramLayout {
  /// The new owner key for the name service entry.
  final SolAddress newOwnerKey;

  /// Constructs a NameServiceTransferLayout instance with the specified new owner key.
  const NameServiceTransferLayout({required this.newOwnerKey});

  /// Creates a NameServiceTransferLayout instance from buffer data.
  factory NameServiceTransferLayout.fromBuffer(List<int> data) {
    final decode = ProgramLayout.decodeAndValidateStruct(
      layout: _layout,
      bytes: data,
      instruction: NameServiceProgramInstruction.transfer.insturction,
    );
    return NameServiceTransferLayout(newOwnerKey: decode["newOwnerKey"]);
  }

  /// The layout structure.
  static final Structure _layout = LayoutUtils.struct([
    LayoutUtils.u8("instruction"),
    LayoutUtils.publicKey("newOwnerKey"),
  ]);

  /// The layout structure.
  @override
  Structure get layout => _layout;

  /// The instruction associated with the layout.
  @override
  int get instruction => NameServiceProgramInstruction.transfer.insturction;

  /// Serializes the layout data.
  @override
  Map<String, dynamic> serialize() {
    return {"newOwnerKey": newOwnerKey};
  }
}
