import 'package:on_chain/solana/src/address/sol_address.dart';
import 'package:on_chain/solana/src/models/lockup/table_lookup.dart';

/// Class representing the extracted table lookup with associated readable and writable addresses.
class ExtractTableLookup {
  /// Constructor to create an ExtractTableLookup instance.
  ExtractTableLookup({
    required List<SolAddress> readable,
    required List<SolAddress> writable,
    required this.lookup,
  })   // Ensure readable and writable lists are unmodifiable.
  : readable = List<SolAddress>.unmodifiable(readable),
        writable = List<SolAddress>.unmodifiable(writable);

  /// List of readable addresses associated with the lookup.
  final List<SolAddress> readable;

  /// List of writable addresses associated with the lookup.
  final List<SolAddress> writable;

  /// The address table lookup object.
  final AddressTableLookup lookup;
}
