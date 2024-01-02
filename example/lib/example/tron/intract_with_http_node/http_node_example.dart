// ignore_for_file: unused_local_variable

import 'package:example/example/tron/provider_service/provider_service.dart';
import 'package:on_chain/on_chain.dart';

void main() async {
  /// Tron Provider Initialization
  final rpc = TronProvider(TronHTTPProvider(url: "https://api.trongrid.io"));
// Initialize a Tron Provider using an HTTP endpoint to interact with the Tron blockchain.

  /// Get Account Information
  final accountInfo = await rpc.request(TronRequestGetAccount(
      address: TronAddress("TMcbQBuj5ATtm9feRiMp6QRd587hT7HHyU")));
// Request detailed account information for the specified Tron address.

  /// Get Account Resource Information
  final accountResource = await rpc.request(TronRequestGetAccountResource(
      address: TronAddress("TMcbQBuj5ATtm9feRiMp6QRd587hT7HHyU")));
// Retrieve resource-related information for the specified Tron address.

  /// Get Chain Parameters
  final chainParameters = await rpc.request(TronRequestGetChainParameters());
// Fetch parameters specific to the Tron blockchain.

  /// Get Latest Block Information
  final block = await rpc.request(TronRequestGetNowBlock());
// Retrieve information about the latest block on the Tron blockchain.

  /// Extensive Tron Interaction
  /// Explore over 90 classes to interact with the Tron HTTP node,
  /// covering a wide range of functionalities. Find them in the package:on_chain/tron/provider/provider/provider.dart file.
}
