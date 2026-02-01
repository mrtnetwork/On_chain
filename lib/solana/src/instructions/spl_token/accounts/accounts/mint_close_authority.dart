import 'package:on_chain/solana/src/exception/exception.dart';
import 'package:blockchain_utils/layout/layout.dart';
import 'package:on_chain/solana/src/address/sol_address.dart';
import 'package:on_chain/solana/src/instructions/instructions.dart';
import 'package:on_chain/solana/src/borsh_serialization/program_layout.dart';
import 'package:on_chain/solana/src/utils/layouts.dart';

class _Utils {
  static StructLayout get layout => LayoutConst.struct([
        SolanaLayoutUtils.publicKey('delegate'),
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
              extensionType: ExtensionType.mintCloseAuthority,
              type: SolanaTokenAccountType.mint);
      return BorshLayoutSerializable.decode(
          bytes: extensionBytes, layout: layout);
    } catch (e) {
      throw const SolanaPluginException('Invalid extionsion bytes');
    }
  }
}

class MintCloseAuthority extends BorshLayoutSerializable {
  final SolAddress closeAuthority;
  static int get size => _Utils.accountSize;
  const MintCloseAuthority({required this.closeAuthority});

  factory MintCloseAuthority.fromBuffer(List<int> extensionData) {
    final decode = _Utils.decode(extensionData);
    return MintCloseAuthority(closeAuthority: decode['closeAuthority']);
  }
  factory MintCloseAuthority.fromAccountBytes(List<int> accountBytes) {
    final decode = _Utils.decodeFromAccount(accountBytes);
    return MintCloseAuthority(closeAuthority: decode['closeAuthority']);
  }

  @override
  StructLayout get layout => _Utils.layout;
  @override
  Map<String, dynamic> serialize() {
    return {'delegate': closeAuthority};
  }

  @override
  String toString() {
    return 'MintCloseAuthority${serialize()}';
  }
}
