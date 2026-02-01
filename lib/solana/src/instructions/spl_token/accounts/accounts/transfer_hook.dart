import 'package:on_chain/solana/src/exception/exception.dart';
import 'package:blockchain_utils/layout/layout.dart';
import 'package:on_chain/solana/src/address/sol_address.dart';
import 'package:on_chain/solana/src/instructions/instructions.dart';
import 'package:on_chain/solana/src/borsh_serialization/program_layout.dart';
import 'package:on_chain/solana/src/utils/layouts.dart';

class _Utils {
  static StructLayout get layout => LayoutConst.struct([
        SolanaLayoutUtils.publicKey('authority'),
        SolanaLayoutUtils.publicKey('programId')
      ]);

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
              extensionType: ExtensionType.transferHook);
      return BorshLayoutSerializable.decode(
          bytes: extensionBytes, layout: layout);
    } catch (e) {
      throw const SolanaPluginException('Invalid extionsion bytes');
    }
  }
}

class TransferHook extends BorshLayoutSerializable {
  static int get size => _Utils.accountSize;
  final SolAddress authority;
  final SolAddress programId;
  const TransferHook({required this.authority, required this.programId});

  factory TransferHook.fromBuffer(List<int> extensionData) {
    final decode = _Utils.decode(extensionData);
    return TransferHook(
        authority: decode['authority'], programId: decode['programId']);
  }
  factory TransferHook.fromAccountBytes(List<int> accountBytes) {
    final decode = _Utils.decodeFromAccount(accountBytes);
    return TransferHook(
        authority: decode['authority'], programId: decode['programId']);
  }

  @override
  StructLayout get layout => _Utils.layout;
  @override
  Map<String, dynamic> serialize() {
    return {'authority': authority, 'programId': programId};
  }

  @override
  String toString() {
    return 'TransferHook${serialize()}';
  }
}
