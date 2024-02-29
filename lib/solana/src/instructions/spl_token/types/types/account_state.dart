import 'package:blockchain_utils/exception/exception.dart';
import 'package:on_chain/solana/src/layout/layout.dart';

/// Account state.
class AccountState extends LayoutSerializable {
  final String name;
  final int value;

  const AccountState._(this.name, this.value);

  /// Account is not yet initialized
  static const AccountState uninitialized = AccountState._("Uninitialized", 0);

  /// Account is initialized; the account owner and/or delegate may perform
  /// permitted operations on this account
  static const AccountState initialized = AccountState._("Initialized", 1);

  /// Account has been frozen by the mint freeze authority. Neither the
  /// account owner nor the delegate are able to perform operations on
  /// this account.
  static const AccountState frozen = AccountState._("Frozen", 2);
  static const List<AccountState> values = [uninitialized, initialized, frozen];

  static Structure staticLayout = LayoutUtils.struct([
    LayoutUtils.rustEnum(
        values.map((e) => LayoutUtils.none(e.name)).toList(), LayoutUtils.u8(),
        property: "accountState")
  ]);
  @override
  Structure get layout => staticLayout;

  @override
  Map<String, dynamic> serialize() {
    return {
      "accountState": {name: null}
    };
  }

  factory AccountState.fromJson(Map<String, dynamic> json) {
    return fromName(json["accountState"]["key"]);
  }
  static AccountState fromName(String? value) {
    return values.firstWhere(
      (element) => element.name == value,
      orElse: () => throw MessageException(
          "No AccountState found matching the specified value",
          details: {"value": value}),
    );
  }

  static AccountState fromValue(int? value) {
    return values.firstWhere(
      (element) => element.value == value,
      orElse: () => throw MessageException(
          "No AccountState found matching the specified value",
          details: {"value": value}),
    );
  }

  @override
  String toString() {
    return "AccountState${serialize()}";
  }
}
