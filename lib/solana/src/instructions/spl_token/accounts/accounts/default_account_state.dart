import 'package:blockchain_utils/exception/exception.dart';
import 'package:blockchain_utils/layout/layout.dart';
import 'package:on_chain/solana/src/instructions/instructions.dart';
import 'package:on_chain/solana/src/borsh_serialization/program_layout.dart';

class _Utils {
  static final StructLayout layout =
      LayoutConst.struct([LayoutConst.u8(property: 'state')]);

  static int get accountSize => layout.span;

  static Map<String, dynamic> decode(List<int> extensionData) {
    try {
      if (extensionData.length < accountSize) {
        throw MessageException("Account data length is insufficient.",
            details: {"Expected": accountSize, "length": extensionData.length});
      }
      return LayoutSerializable.decode(bytes: extensionData, layout: layout);
    } catch (e) {
      throw const MessageException("Invalid extionsion bytes");
    }
  }

  static Map<String, dynamic> decodeFromAccount(List<int> accountBytes) {
    try {
      final extensionBytes =
          SPLToken2022Utils.readExtionsionBytesFromAccountData(
              accountBytes: accountBytes,
              extensionType: ExtensionType.defaultAccountState);
      return LayoutSerializable.decode(bytes: extensionBytes, layout: layout);
    } catch (e) {
      throw const MessageException("Invalid extionsion bytes");
    }
  }
}

/// Default Account::state extension data for mints.
class DefaultAccountState extends LayoutSerializable {
  /// Default AccountState in which new Accounts should be initialized
  final AccountState accountState;
  const DefaultAccountState({required this.accountState});

  factory DefaultAccountState.fromBuffer(List<int> extensionData) {
    final decode = _Utils.decode(extensionData);
    return DefaultAccountState(
        accountState: AccountState.fromValue(decode["state"]));
  }
  factory DefaultAccountState.fromAccountBytes(List<int> accountBytes) {
    final decode = _Utils.decodeFromAccount(accountBytes);
    return DefaultAccountState(
        accountState: AccountState.fromValue(decode["state"]));
  }

  @override
  StructLayout get layout => _Utils.layout;
  @override
  Map<String, dynamic> serialize() {
    return {"state": accountState.value};
  }

  @override
  String toString() {
    return "DefaultAccountState${serialize()}";
  }
}
