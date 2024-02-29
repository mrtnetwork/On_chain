import 'package:blockchain_utils/blockchain_utils.dart';
import 'package:on_chain/solana/src/address/sol_address.dart';
import 'package:on_chain/solana/src/instructions/instructions.dart';
import 'package:on_chain/solana/src/layout/layout.dart';

class _Utils {
  static final Structure layout = LayoutUtils.struct([
    LayoutUtils.publicKey('authority'),
    LayoutUtils.publicKey('metadataAddress'),
  ]);

  static int get accountSize => layout.span;

  static Map<String, dynamic> decode(List<int> extensionData) {
    try {
      if (extensionData.length < accountSize) {
        throw MessageException("Account data length is insufficient.",
            details: {"Expected": accountSize, "length": extensionData.length});
      }
      return LayoutSerializable.decode(bytes: extensionData, layout: layout);
    } catch (e) {
      throw MessageException("Invalid extionsion bytes");
    }
  }

  static Map<String, dynamic> decodeFromAccount(List<int> accountBytes) {
    try {
      final extensionBytes =
          SPLToken2022Utils.readExtionsionBytesFromAccountData(
              accountBytes: accountBytes,
              extensionType: ExtensionType.metadataPointer);
      return LayoutSerializable.decode(bytes: extensionBytes, layout: layout);
    } catch (e) {
      throw MessageException("Invalid extionsion bytes");
    }
  }
}

/// Metadata pointer extension data for mints.
class MetadataPointer extends LayoutSerializable {
  /// Authority that can set the metadata address
  final SolAddress? authority;

  /// Account address that holds the metadata
  final SolAddress? metadataAddress;
  const MetadataPointer({this.authority, this.metadataAddress});

  factory MetadataPointer.fromBuffer(List<int> extensionData) {
    final decode = _Utils.decode(extensionData);
    return MetadataPointer(
        authority: decode["authority"] == SolAddress.defaultPubKey
            ? null
            : decode["authority"],
        metadataAddress: decode["metadataAddress"] == SolAddress.defaultPubKey
            ? null
            : decode["metadataAddress"]);
  }
  factory MetadataPointer.fromAccountBytes(List<int> accountBytes) {
    final decode = _Utils.decodeFromAccount(accountBytes);
    return MetadataPointer(
        authority: decode["authority"] == SolAddress.defaultPubKey
            ? null
            : decode["authority"],
        metadataAddress: decode["metadataAddress"] == SolAddress.defaultPubKey
            ? null
            : decode["metadataAddress"]);
  }

  @override
  Structure get layout => _Utils.layout;
  @override
  Map<String, dynamic> serialize() {
    return {
      "authority": authority ?? SolAddress.defaultPubKey,
      "metadataAddress": metadataAddress ?? SolAddress.defaultPubKey
    };
  }

  @override
  String toString() {
    return "MetadataPointer${serialize()}";
  }
}
