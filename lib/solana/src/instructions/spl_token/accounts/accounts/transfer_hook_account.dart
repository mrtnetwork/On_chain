import 'package:on_chain/solana/src/exception/exception.dart';
import 'package:blockchain_utils/layout/layout.dart';
import 'package:on_chain/solana/src/instructions/instructions.dart';
import 'package:on_chain/solana/src/borsh_serialization/program_layout.dart';

class _Utils {
  static StructLayout get layout =>
      LayoutConst.struct([LayoutConst.boolean(property: 'transferring')]);

  static int get accountSize => layout.span;

  static Map<String, dynamic> decode(List<int> extensionData) {
    try {
      if (extensionData.length < accountSize) {
        throw SolanaPluginException('Account data length is insufficient.',
            details: {'Expected': accountSize, 'length': extensionData.length});
      }
      return BorshLayoutSerializable.decode(
          bytes: extensionData, layout: layout);
    } catch (e) {
      throw const SolanaPluginException('Invalid extionsion bytes');
    }
  }

  static Map<String, dynamic> decodeFromAccount(List<int> accountBytes) {
    try {
      final extensionBytes =
          SPLToken2022Utils.readExtionsionBytesFromAccountData(
              accountBytes: accountBytes,
              extensionType: ExtensionType.transferHookAccount);
      return BorshLayoutSerializable.decode(
          bytes: extensionBytes, layout: layout);
    } catch (e) {
      throw const SolanaPluginException('Invalid extionsion bytes');
    }
  }
}

/// Indicates that the tokens from this account belong to a mint with a transfer
/// hook
class TransferHookAccount extends BorshLayoutSerializable {
  static int get size => _Utils.accountSize;

  /// Flag to indicate that the account is in the middle of a transfer
  final bool transferring;
  const TransferHookAccount({required this.transferring});

  factory TransferHookAccount.fromBuffer(List<int> extensionData) {
    final decode = _Utils.decode(extensionData);
    return TransferHookAccount(transferring: decode['transferring']);
  }
  factory TransferHookAccount.fromAccountBytes(List<int> accountBytes) {
    final decode = _Utils.decodeFromAccount(accountBytes);
    return TransferHookAccount(transferring: decode['transferring']);
  }

  @override
  StructLayout get layout => _Utils.layout;
  @override
  Map<String, dynamic> serialize() {
    return {'transferring': transferring};
  }

  @override
  String toString() {
    return 'TransferHookAccount${serialize()}';
  }
}
