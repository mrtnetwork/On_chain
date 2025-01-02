import 'package:on_chain/solana/src/address/sol_address.dart';
import 'package:on_chain/solana/src/instructions/spl_token/layouts/instruction/instruction.dart';
import 'package:blockchain_utils/layout/layout.dart';
import 'package:on_chain/solana/src/borsh_serialization/program_layout.dart';
import 'package:on_chain/solana/src/utils/layouts.dart';

/// Initialize a new mint with a metadata pointer layout.
class SPLToken2022InitializeMetadataPointerLayout
    extends SPLTokenProgramLayout {
  /// The public key for the account that can update the metadata address
  final SolAddress? authority;

  /// The account address that holds the metadata
  final SolAddress? metadataAddress;
  SPLToken2022InitializeMetadataPointerLayout(
      {this.authority, this.metadataAddress});

  static final StructLayout _layout = LayoutConst.struct([
    LayoutConst.u8(property: 'instruction'),
    LayoutConst.wrap(MetadataPointerInstruction.staticLayout,
        property: 'metadataPointer'),
    SolanaLayoutUtils.publicKey('authority'),
    SolanaLayoutUtils.publicKey('metadataAddress'),
  ]);

  factory SPLToken2022InitializeMetadataPointerLayout.fromBuffer(
      List<int> bytes) {
    final decode = ProgramLayout.decodeAndValidateStruct(
        layout: _layout,
        bytes: bytes,
        instruction:
            SPLTokenProgramInstruction.metadataPointerExtension.insturction);
    return SPLToken2022InitializeMetadataPointerLayout(
        authority: decode['authority'] == SolAddress.defaultPubKey
            ? null
            : decode['authority'],
        metadataAddress: decode['metadataAddress'] == SolAddress.defaultPubKey
            ? null
            : decode['metadataAddress']);
  }

  @override
  StructLayout get layout => _layout;

  @override
  final SPLTokenProgramInstruction instruction =
      SPLTokenProgramInstruction.metadataPointerExtension;

  @override
  Map<String, dynamic> serialize() {
    return {
      'metadataPointer': MetadataPointerInstruction.initialize.serialize(),
      'authority': authority ?? SolAddress.defaultPubKey,
      'metadataAddress': metadataAddress ?? SolAddress.defaultPubKey
    };
  }
}
