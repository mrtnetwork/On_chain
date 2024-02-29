import 'package:on_chain/solana/src/address/sol_address.dart';
import 'package:on_chain/solana/src/instructions/spl_token/layouts/instruction/instruction.dart';
import 'package:on_chain/solana/src/layout/layout.dart';

/// Initialize a new mint with a metadata pointer layout.
class SPLToken2022InitializeMetadataPointerLayout
    extends SPLTokenProgramLayout {
  /// The public key for the account that can update the metadata address
  final SolAddress? authority;

  /// The account address that holds the metadata
  final SolAddress? metadataAddress;
  SPLToken2022InitializeMetadataPointerLayout(
      {this.authority, this.metadataAddress});

  static final Structure _layout = LayoutUtils.struct([
    LayoutUtils.u8("instruction"),
    LayoutUtils.wrap(MetadataPointerInstruction.staticLayout,
        property: "metadataPointer"),
    LayoutUtils.publicKey("authority"),
    LayoutUtils.publicKey("metadataAddress"),
  ]);

  factory SPLToken2022InitializeMetadataPointerLayout.fromBuffer(
      List<int> bytes) {
    final decode = ProgramLayout.decodeAndValidateStruct(
        layout: _layout,
        bytes: bytes,
        instruction:
            SPLTokenProgramInstruction.metadataPointerExtension.insturction);
    return SPLToken2022InitializeMetadataPointerLayout(
        authority: decode["authority"] == SolAddress.defaultPubKey
            ? null
            : decode["authority"],
        metadataAddress: decode["metadataAddress"] == SolAddress.defaultPubKey
            ? null
            : decode["metadataAddress"]);
  }

  @override
  Structure get layout => _layout;

  @override
  final int instruction =
      SPLTokenProgramInstruction.metadataPointerExtension.insturction;

  @override
  Map<String, dynamic> serialize() {
    return {
      "metadataPointer": MetadataPointerInstruction.initialize.serialize(),
      "authority": authority ?? SolAddress.defaultPubKey,
      "metadataAddress": metadataAddress ?? SolAddress.defaultPubKey
    };
  }
}
