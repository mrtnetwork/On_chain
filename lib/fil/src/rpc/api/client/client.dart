import 'package:blockchain_utils/service/models/params.dart';
import 'package:on_chain/fil/src/rpc/api/api/quick_api.dart';
import 'package:on_chain/fil/src/rpc/api/api/quick_evm_api.dart';
import 'package:on_chain/fil/src/rpc/api/api/quick_multisig_api.dart';
import 'package:on_chain/fil/src/rpc/api/api/quick_paych_api.dart';
import 'package:on_chain/fil/src/types/types.dart';

/// Default high-level Filecoin client.
///
/// Combines the quick-API mixins:
/// - [FilQuickApi] – balance, gas estimation, generic send, wait-for-result
/// - [FilQuickMultisigApi] – create / propose / approve / manage multisigs
/// - [FilQuickPaychApi] – create / update / settle / collect payment channels
/// - [FilQuickEvmApi] – FEVM token reads, probes, scans and calldata
///
/// Example:
/// ```dart
/// final client = DefaultFilClient(provider);
///
/// // Simple transfer
/// await client.buildAndSendMessage(
///   to: recipient,
///   from: myAddress,
///   signer: mySigner,
///   value: BigInt.from(1e18), // 1 FIL
/// );
///
/// // Create a 2-of-3 multisig
/// final created = await client.multisigCreate(
///   from: myAddress,
///   signers: [a, b, c],
///   threshold: BigInt.two,
///   signer: mySigner,
/// );
/// ```
class DefaultFilClient
    with FilQuickApi, FilQuickMultisigApi, FilQuickPaychApi, FilQuickEvmApi {
  /// Network configuration (actor CIDs, address prefix, …).
  @override
  final FilNetworkConfig network;

  /// Low-level RPC provider used for all Lotus JSON-RPC calls.
  @override
  final IProvider<IServiceProvider, BaseServiceRequestParams> provider;

  /// Creates a client bound to [provider].
  const DefaultFilClient(this.provider, {required this.network});
}
