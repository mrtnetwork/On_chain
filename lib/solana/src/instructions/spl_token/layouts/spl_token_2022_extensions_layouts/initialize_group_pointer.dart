import 'package:on_chain/solana/src/address/sol_address.dart';
import 'package:on_chain/solana/src/instructions/spl_token/layouts/instruction/instruction.dart';
import 'package:on_chain/solana/src/layout/layout.dart';

/// Initialize the group pointer extension for the given mint account layout.
class SPLToken2022InitializeGroupPointerLayout extends SPLTokenProgramLayout {
  /// Authority that can set the group address
  final SolAddress? authority;

  /// Account address that holds the group
  final SolAddress? groupAddress;

  SPLToken2022InitializeGroupPointerLayout({this.authority, this.groupAddress});

  factory SPLToken2022InitializeGroupPointerLayout.fromBuffer(List<int> bytes) {
    final decode = ProgramLayout.decodeAndValidateStruct(
      layout: _layout,
      bytes: bytes,
      instruction: SPLTokenProgramInstruction.groupPointerExtension.insturction,
    );
    return SPLToken2022InitializeGroupPointerLayout(
      authority: decode["authority"] == SolAddress.defaultPubKey
          ? null
          : decode["authority"],
      groupAddress: decode["groupAddress"] == SolAddress.defaultPubKey
          ? null
          : decode["groupAddress"],
    );
  }
  static final Structure _layout = LayoutUtils.struct([
    LayoutUtils.u8("instruction"),
    LayoutUtils.wrap(GroupPointerInstruction.staticLayout,
        property: "groupPointer"),
    LayoutUtils.publicKey("authority"),
    LayoutUtils.publicKey("groupAddress"),
  ]);

  /// Returns the layout structure.
  @override
  Structure get layout => _layout;

  /// Instruction associated with the layout.
  @override
  final int instruction =
      SPLTokenProgramInstruction.groupPointerExtension.insturction;

  /// Serializes the layout data.
  @override
  Map<String, dynamic> serialize() {
    return {
      "groupPointer": GroupPointerInstruction.initialize.serialize(),
      "groupAddress": groupAddress ?? SolAddress.defaultPubKey,
      "authority": authority ?? SolAddress.defaultPubKey
    };
  }
}
