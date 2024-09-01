import 'package:on_chain/solana/src/address/sol_address.dart';
import 'package:on_chain/solana/src/instructions/spl_token/layouts/instruction/instruction.dart';
import 'package:blockchain_utils/layout/layout.dart';
import 'package:on_chain/solana/src/borsh_serialization/program_layout.dart';
import 'package:on_chain/solana/src/utils/layouts.dart';

/// Update the metadata pointer address layout.
class SPLToken2022UpdateMetadataPointerLayout extends SPLTokenProgramLayout {
  /// The new account address that holds the metadata
  final SolAddress? metadataAddress;
  SPLToken2022UpdateMetadataPointerLayout({required this.metadataAddress});

  static final StructLayout _layout = LayoutConst.struct([
    LayoutConst.u8(property: "instruction"),
    LayoutConst.wrap(MetadataPointerInstruction.staticLayout,
        property: "metadataPointer"),
    SolanaLayoutUtils.publicKey("metadataAddress"),
  ]);

  factory SPLToken2022UpdateMetadataPointerLayout.fromBuffer(List<int> bytes) {
    final decode = ProgramLayout.decodeAndValidateStruct(
        layout: _layout,
        bytes: bytes,
        instruction:
            SPLTokenProgramInstruction.metadataPointerExtension.insturction);
    return SPLToken2022UpdateMetadataPointerLayout(
        metadataAddress: decode["authority"] == SolAddress.defaultPubKey
            ? null
            : decode["authority"]);
  }

  @override
  StructLayout get layout => _layout;

  @override
  final SPLTokenProgramInstruction instruction =
      SPLTokenProgramInstruction.metadataPointerExtension;

  @override
  Map<String, dynamic> serialize() {
    return {
      "metadataPointer": MetadataPointerInstruction.update.serialize(),
      "metadataAddress": metadataAddress ?? SolAddress.defaultPubKey
    };
  }
}
