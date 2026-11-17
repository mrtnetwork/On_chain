import 'package:on_chain/solana/src/address/sol_address.dart';
import 'package:on_chain/solana/src/models/account/account_meta.dart';

class SPLTokenUtils {
  // A static method to build a list of AccountMeta instances.
  static List<AccountMeta> buildKeys({
    required List<AccountMeta> keys, // Required list of initial keys
    required SolAddress? owner, // Required owner SolAddress
    List<SolAddress> multiSigners = const [], // Optional list of multi-signers
  }) {
    // Construct the list of keys by spreading the initial keys
    // and adding the owner as a signer or read-only key based on the presence of multiSigners.
    // Then, add each multi-signer as a signer key to the list.
    return [
      ...keys,
      if (owner != null)
        multiSigners.isEmpty ? owner.toSigner() : owner.toReadOnly(),
      ...multiSigners.map((e) => e.toSigner()),
    ];
  }
}
