import 'package:on_chain/aptos/src/api/impl/encrypted.dart';
import 'package:on_chain/aptos/src/api/impl/provider.dart';
import 'package:on_chain/aptos/src/api/impl/signing.dart';
import 'package:on_chain/aptos/src/api/impl/transfer.dart';
import 'package:on_chain/aptos/src/provider/provider/provider.dart';

export 'package:on_chain/aptos/src/api/types/types.dart';

/// A high-level API class that provides quick access to core Aptos functionalities,
/// including account management, transaction signing, and transaction handling.
///
/// This class combines multiple helper mixins:
/// - [AptosQuickApiProviderHelper] for provider-related utilities (e.g., fetching account data).
/// - [AptosQuickApiSigningHelper] for signing transactions.
/// - [AptosQuickApiTransactionHelper] for building and submitting transactions.
/// - [AptosQuickApiEncryptedHelper] for AIP-144 encrypted-mempool transactions.
///
/// Encrypted transactions are optional and cost more (min 200 Octas/gas +
/// 375 decryption units). Any entry function works, no contract changes needed.
/// Keyless / federated keyless / account-abstraction signers cannot sign them.
class AptosQuickApi
    with
        AptosQuickApiProviderHelper,
        AptosQuickApiSigningHelper,
        AptosQuickApiTransactionHelper,
        AptosQuickApiEncryptedHelper {
  /// The Aptos provider used for making network requests.
  @override
  final AptosProvider provider;

  /// Creates an instance of [AptosQuickApi].
  ///
  /// - [provider]: The Aptos provider instance required for blockchain interactions.
  const AptosQuickApi({required this.provider});
}
