import 'package:on_chain/solana/src/exception/exception.dart';
import 'package:blockchain_utils/layout/layout.dart';
import 'package:on_chain/solana/src/instructions/instructions.dart';
import 'package:on_chain/solana/src/borsh_serialization/program_layout.dart';

class _Utils {
  static final StructLayout layout = LayoutConst.struct(
      [LayoutConst.boolean(property: 'requireIncomingTransferMemos')]);

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
              extensionType: ExtensionType.memoTransfer);
      return LayoutSerializable.decode(bytes: extensionBytes, layout: layout);
    } catch (e) {
      throw const SolanaPluginException('Invalid extionsion bytes');
    }
  }
}

/// Memo Transfer extension for Accounts
class MemoTransfer extends LayoutSerializable {
  /// Require transfers into this account to be accompanied by a memo
  final bool requireIncomingTransferMemos;
  const MemoTransfer({required this.requireIncomingTransferMemos});

  factory MemoTransfer.fromBuffer(List<int> extensionData) {
    final decode = _Utils.decode(extensionData);
    return MemoTransfer(
        requireIncomingTransferMemos: decode['requireIncomingTransferMemos']);
  }
  factory MemoTransfer.fromAccountBytes(List<int> accountBytes) {
    final decode = _Utils.decodeFromAccount(accountBytes);
    return MemoTransfer(
        requireIncomingTransferMemos: decode['requireIncomingTransferMemos']);
  }

  @override
  StructLayout get layout => _Utils.layout;
  @override
  Map<String, dynamic> serialize() {
    return {'requireIncomingTransferMemos': requireIncomingTransferMemos};
  }

  @override
  String toString() {
    return 'MemoTransfer${serialize()}';
  }
}
