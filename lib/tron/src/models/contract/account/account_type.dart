import 'package:on_chain/tron/src/models/contract/base_contract/common.dart';

/// Enum representing the different types of Tron accounts.
///
/// Each account type has a unique [value] associated with it and a [name] for identification.
/// The available account types are:
/// - [normal]: Represents a normal Tron account.
/// - [assetIssue]: Represents an account associated with asset issuance.
/// - [contract]: Represents an account associated with a contract.
///
class AccountType implements TronEnumerate {
  /// Internal constructor to create an [AccountType] instance.
  const AccountType._(this.name, this.value);

  /// Represents a normal Tron account.
  static const AccountType normal = AccountType._("Normal", 0);

  /// Represents an account associated with asset issuance.
  static const AccountType assetIssue = AccountType._("AssetIssue", 1);

  /// Represents an account associated with a contract.
  static const AccountType contract = AccountType._("Contract", 2);

  /// List of all available account types.
  static const List<AccountType> values = [normal, assetIssue, contract];
  @override
  final int value;

  /// The name associated with the account type.
  final String name;

  /// Returns the [AccountType] associated with the given [name].
  ///
  /// Returns `null` if no match is found.
  static AccountType? fromName(String? name) {
    if (name == null) return null;
    try {
      return values.firstWhere((element) => element.name == name);
    } on StateError {
      return null;
    } catch (e) {
      return null;
    }
  }

  /// Returns the [AccountType] associated with the given [value].
  ///
  /// Throws an error if no match is found.
  static AccountType fromValue(int value) {
    return values.firstWhere((element) => element.value == value);
  }
}
