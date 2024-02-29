import 'package:on_chain/solana/src/address/sol_address.dart';
import 'package:on_chain/solana/src/instructions/spl_token_meta_data/layouts/instruction/instruction.dart';
import 'package:on_chain/solana/src/layout/layout.dart';

/// Updates the token-metadata authority layout.
class SPLTokenMetaDataUpdateAuthorityLayout
    extends SPLTokenMetaDataProgramLayout {
  /// New authority for the token metadata, or unset if `null`
  final SolAddress? newAuthority;

  /// Constructs a new instance of [SPLTokenMetaDataUpdateAuthorityLayout] with the provided new authority.
  const SPLTokenMetaDataUpdateAuthorityLayout({this.newAuthority});

  /// Decodes the provided byte array to extract the new authority information.
  factory SPLTokenMetaDataUpdateAuthorityLayout.fromBuffer(List<int> bytes) {
    // Decode the provided byte array and validate the structure.
    final decode = SPLTokenMetaDataProgramLayout.decodeAndValidateStruct(
        layout: _layout,
        bytes: bytes,
        instructionBytes:
            SPLTokenMetaDataProgramSplDiscriminate.updateAuthority.insturction);
    // Extract the new authority from the decoded data.
    final SolAddress newAuthority = decode["new_authority"];
    // Return a new instance of [SPLTokenMetaDataUpdateAuthorityLayout].
    return SPLTokenMetaDataUpdateAuthorityLayout(
      // If the new authority is zero, set it to null, else set it to the extracted value.
      newAuthority:
          newAuthority == SolAddress.defaultPubKey ? null : newAuthority,
    );
  }

  /// The layout structure of the update authority instruction.
  static final Structure _layout = LayoutUtils.struct([
    LayoutUtils.blob(8, property: "instruction"),
    // Define the layout for the new authority public key.
    LayoutUtils.publicKey("new_authority"),
  ]);

  /// Gets the layout structure of this update authority instruction.
  @override
  Structure get layout => _layout;

  /// Gets the instruction bytes for the update authority instruction.
  @override
  List<int> get instruction =>
      SPLTokenMetaDataProgramSplDiscriminate.updateAuthority.insturction;

  /// Serializes the update authority data for transmission.
  @override
  Map<String, dynamic> serialize() {
    return {"new_authority": newAuthority ?? SolAddress.defaultPubKey};
  }
}
