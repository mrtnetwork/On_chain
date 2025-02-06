import 'package:on_chain/aptos/src/api/impl/provider.dart';
import 'package:on_chain/aptos/src/api/impl/signing.dart';
import 'package:on_chain/aptos/src/api/impl/transfer.dart';
import 'package:on_chain/aptos/src/provider/provider/provider.dart';

/// A high-level API class that provides quick access to core Aptos functionalities,
/// including account management, transaction signing, and transaction handling.
///
/// This class combines multiple helper mixins:
/// - [AptosQuickApiProviderHelper] for provider-related utilities (e.g., fetching account data).
/// - [AptosQuickApiSigningHelper] for signing transactions.
/// - [AptosQuickApiTransactionHelper] for building and submitting transactions.
///
class AptosQuickApi
    with
        AptosQuickApiProviderHelper,
        AptosQuickApiSigningHelper,
        AptosQuickApiTransactionHelper {
  /// The Aptos provider used for making network requests.
  @override
  final AptosProvider provider;

  /// Creates an instance of [AptosQuickApi].
  ///
  /// - [provider]: The Aptos provider instance required for blockchain interactions.
  const AptosQuickApi({required this.provider});
}
