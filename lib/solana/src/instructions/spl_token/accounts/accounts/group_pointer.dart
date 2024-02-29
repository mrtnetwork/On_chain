import 'package:blockchain_utils/blockchain_utils.dart';
import 'package:on_chain/solana/src/address/sol_address.dart';
import 'package:on_chain/solana/src/instructions/instructions.dart';
import 'package:on_chain/solana/src/layout/layout.dart';

class _Utils {
  static final Structure layout = LayoutUtils.struct([
    LayoutUtils.publicKey('authority'),
    LayoutUtils.publicKey('groupAddress'),
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
              extensionType: ExtensionType.groupPointer);
      return LayoutSerializable.decode(bytes: extensionBytes, layout: layout);
    } catch (e) {
      throw MessageException("Invalid extionsion bytes");
    }
  }
}

class GroupPointer extends LayoutSerializable {
  final SolAddress? authority;
  final SolAddress? groupAddress;
  const GroupPointer({required this.authority, required this.groupAddress});

  factory GroupPointer.fromBuffer(List<int> extensionData) {
    final decode = _Utils.decode(extensionData);
    return GroupPointer(
      authority: decode["authority"] == SolAddress.defaultPubKey
          ? null
          : decode["authority"],
      groupAddress: decode["groupAddress"] == SolAddress.defaultPubKey
          ? null
          : decode["groupAddress"],
    );
  }
  factory GroupPointer.fromAccountBytes(List<int> accountBytes) {
    final decode = _Utils.decodeFromAccount(accountBytes);
    return GroupPointer(
      authority: decode["authority"] == SolAddress.defaultPubKey
          ? null
          : decode["authority"],
      groupAddress: decode["groupAddress"] == SolAddress.defaultPubKey
          ? null
          : decode["groupAddress"],
    );
  }

  @override
  Structure get layout => _Utils.layout;
  @override
  Map<String, dynamic> serialize() {
    return {
      "authority": authority ?? SolAddress.defaultPubKey,
      "groupAddress": groupAddress ?? SolAddress.defaultPubKey
    };
  }

  @override
  String toString() {
    return "GroupPointer${serialize()}";
  }
}
