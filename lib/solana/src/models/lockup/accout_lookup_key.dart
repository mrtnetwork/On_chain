import 'package:on_chain/solana/src/address/sol_address.dart';

/// Class representing the keys used for account lookup.
class AccountLookupKeys {
  /// Constructor to create an AccountLookupKeys instance.
  AccountLookupKeys({
    required List<SolAddress> readonly,
    required List<SolAddress> writable,
  })   // Ensure readonly and writable lists are unmodifiable.
  : readonly = List.unmodifiable(readonly),
        writable = List.unmodifiable(writable);

  factory AccountLookupKeys.fromJson(Map<String, dynamic> json) {
    return AccountLookupKeys(
        readonly: (json["readonly"] as List)
            .map((e) => SolAddress.uncheckCurve(e))
            .toList(),
        writable: (json["writable"] as List)
            .map((e) => SolAddress.uncheckCurve(e))
            .toList());
  }

  /// List of readonly keys for account lookup.
  final List<SolAddress> readonly;

  /// List of writable keys for account lookup.
  final List<SolAddress> writable;
}
