import 'package:on_chain/solana/src/address/sol_address.dart';

/// An address table lookup used to load additional accounts.
class AddressTableLookup {
  /// The key of the account associated with the lookup table.
  final SolAddress accountKey;

  /// List of indexes corresponding to writable accounts in the table.
  final List<int> writableIndexes;

  /// List of indexes corresponding to readonly accounts in the table.
  final List<int> readonlyIndexes;

  /// Number of accounts represented in the table (computed property).
  late final int numberOfAccounts =
      readonlyIndexes.length + writableIndexes.length;

  /// Constructor to create an AddressTableLookup instance.
  AddressTableLookup({
    required this.accountKey,
    required List<int> writableIndexes,
    required List<int> readonlyIndexes,
  })   // Ensure writableIndexes and readonlyIndexes are unmodifiable.
  : writableIndexes = List<int>.unmodifiable(writableIndexes),
        readonlyIndexes = List<int>.unmodifiable(readonlyIndexes);

  factory AddressTableLookup.fromJson(Map<String, dynamic> json) {
    return AddressTableLookup(
        accountKey: SolAddress.uncheckCurve(json['accountKey']),
        writableIndexes: (json['writableIndexes'] as List).cast(),
        readonlyIndexes: (json['readonlyIndexes'] as List).cast());
  }

  /// Override the toString method to provide a string representation of the object.
  @override
  String toString() {
    return 'AddressTableLookup{accountKey: $accountKey, writableIndexes: $writableIndexes, readonlyIndexes: $readonlyIndexes}';
  }
}
