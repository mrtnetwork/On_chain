import 'package:on_chain/solana/src/exception/exception.dart';
import 'package:blockchain_utils/layout/layout.dart';
import 'package:on_chain/solana/src/address/sol_address.dart';
import 'package:on_chain/solana/src/instructions/instructions.dart';
import 'package:on_chain/solana/src/borsh_serialization/program_layout.dart';
import 'package:on_chain/solana/src/utils/layouts.dart';

class _Utils {
  static final StructLayout layout = LayoutConst.struct([
    SolanaLayoutUtils.publicKey('authority'),
    SolanaLayoutUtils.publicKey('memberAddress'),
  ]);

  static int get accountSize => layout.span;

  static Map<String, dynamic> decode(List<int> extensionData) {
    try {
      if (extensionData.length < accountSize) {
        throw SolanaPluginException('Account data length is insufficient.',
            details: {'Expected': accountSize, 'length': extensionData.length});
      }
      return LayoutSerializable.decode(bytes: extensionData, layout: layout);
    } catch (e) {
      throw const SolanaPluginException('Invalid extionsion bytes');
    }
  }

  static Map<String, dynamic> decodeFromAccount(List<int> accountBytes) {
    try {
      final extensionBytes =
          SPLToken2022Utils.readExtionsionBytesFromAccountData(
              accountBytes: accountBytes,
              extensionType: ExtensionType.groupMemberPointer);
      return LayoutSerializable.decode(bytes: extensionBytes, layout: layout);
    } catch (e) {
      throw const SolanaPluginException('Invalid extionsion bytes');
    }
  }
}

class GroupMemberPointer extends LayoutSerializable {
  final SolAddress? authority;
  final SolAddress? memberAddress;
  const GroupMemberPointer(
      {required this.authority, required this.memberAddress});

  factory GroupMemberPointer.fromBuffer(List<int> extensionData) {
    final decode = _Utils.decode(extensionData);
    return GroupMemberPointer(
      authority: decode['authority'] == SolAddress.defaultPubKey
          ? null
          : decode['authority'],
      memberAddress: decode['memberAddress'] == SolAddress.defaultPubKey
          ? null
          : decode['memberAddress'],
    );
  }
  factory GroupMemberPointer.fromAccountBytes(List<int> accountBytes) {
    final decode = _Utils.decodeFromAccount(accountBytes);
    return GroupMemberPointer(
      authority: decode['authority'] == SolAddress.defaultPubKey
          ? null
          : decode['authority'],
      memberAddress: decode['memberAddress'] == SolAddress.defaultPubKey
          ? null
          : decode['memberAddress'],
    );
  }

  @override
  StructLayout get layout => _Utils.layout;
  @override
  Map<String, dynamic> serialize() {
    return {
      'authority': authority ?? SolAddress.defaultPubKey,
      'memberAddress': memberAddress ?? SolAddress.defaultPubKey
    };
  }

  @override
  String toString() {
    return 'GroupMemberPointer${serialize()}';
  }
}
