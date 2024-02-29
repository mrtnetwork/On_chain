import 'package:blockchain_utils/exception/exception.dart';
import 'package:on_chain/solana/src/address/sol_address.dart';
import 'package:on_chain/solana/src/instructions/spl_token/spl_token.dart';
import 'package:on_chain/solana/src/instructions/spl_token_meta_data/types/types/additional_metadata.dart';
import 'package:on_chain/solana/src/layout/layout.dart';

class _Utils {
  static final Structure layout = LayoutUtils.struct([
    LayoutUtils.publicKey('updateAuthority'),
    LayoutUtils.publicKey('mint'),
    LayoutUtils.string("name"),
    LayoutUtils.string("symbol"),
    LayoutUtils.string("uri"),
    LayoutUtils.vec(AdditionalMetadata.staticLayout,
        property: "additionalMetadatas")
  ]);
  static Map<String, dynamic> decode(List<int> extensionData) {
    try {
      return LayoutSerializable.decode(bytes: extensionData, layout: layout);
    } catch (e) {
      throw MessageException("Invalid extionsion bytes");
    }
  }

  static Map<String, dynamic> decodeFromAccount(List<int> accountDataBytes) {
    try {
      final extensionBytes =
          SPLToken2022Utils.readExtionsionBytesFromAccountData(
              accountBytes: accountDataBytes,
              extensionType: ExtensionType.tokenMetadata,
              type: SolanaTokenAccountType.mint);
      return LayoutSerializable.decode(bytes: extensionBytes, layout: layout);
    } catch (e) {
      throw MessageException("Invalid extionsion bytes");
    }
  }
}

/// Data struct for all token-metadata, stored in a TLV entry
///
/// The type and length parts must be handled by the TLV library, and not stored
/// as part of this struct.
class SPLTokenMetaDataAccount extends LayoutSerializable {
  /// The authority that can sign to update the metadata
  final SolAddress? updateAuthority;

  /// The associated mint, used to counter spoofing to be sure that metadata
  /// belongs to a particular mint
  final SolAddress mint;

  /// The longer name of the token
  final String name;

  /// The shortened symbol for the token
  final String symbol;

  /// The URI pointing to richer metadata
  final String uri;

  /// Any additional metadata about the token as key-value pairs. The program
  /// must avoid storing the same key twice.
  final List<AdditionalMetadata> additionalMetadata;

  const SPLTokenMetaDataAccount(
      {required this.updateAuthority,
      required this.mint,
      required this.name,
      required this.symbol,
      required this.uri,
      required this.additionalMetadata});
  factory SPLTokenMetaDataAccount.fromBuffer(List<int> data) {
    final decode = _Utils.decode(data);
    return SPLTokenMetaDataAccount(
        updateAuthority: decode["updateAuthority"] == SolAddress.defaultPubKey
            ? null
            : decode["updateAuthority"],
        mint: decode["mint"],
        name: decode["name"],
        symbol: decode["symbol"],
        uri: decode["uri"],
        additionalMetadata: (decode["additionalMetadatas"] as List)
            .map((e) => AdditionalMetadata.fromJson(e))
            .toList());
  }
  factory SPLTokenMetaDataAccount.fromAccountDataBytes(List<int> data) {
    final decode = _Utils.decodeFromAccount(data);
    return SPLTokenMetaDataAccount(
        updateAuthority: decode["updateAuthority"] == SolAddress.defaultPubKey
            ? null
            : decode["updateAuthority"],
        mint: decode["mint"],
        name: decode["name"],
        symbol: decode["symbol"],
        uri: decode["uri"],
        additionalMetadata: (decode["additionalMetadatas"] as List)
            .map((e) => AdditionalMetadata.fromJson(e))
            .toList());
  }

  @override
  Structure get layout => _Utils.layout;
  @override
  Map<String, dynamic> serialize() {
    return {
      "updateAuthority": updateAuthority ?? SolAddress.defaultPubKey,
      "mint": mint,
      "name": name,
      "symbol": symbol,
      "uri": uri,
      "additionalMetadatas":
          additionalMetadata.map((e) => e.serialize()).toList()
    };
  }

  @override
  String toString() {
    return "SPLTokenMetaDataAccount.${serialize()}";
  }
}
