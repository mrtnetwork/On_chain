// ignore_for_file: unused_local_variable

import 'package:example/example/solana/service_example/service_example.dart';
import 'package:on_chain/solana/solana.dart';

void main() async {
  /// Initialize the Solana RPC client with the devnet endpoint.
  final service =
      SolanaProvider(RPCHttpService("https://api.devnet.solana.com"));

  /// Retrieve the account information for a specific address.
  final accountModel = await service.request(const SolanaRequestGetAccountInfo(
      account: SolAddress.unchecked(
          "527pWSWfeQGLM7SoyVXjCRkrSZBtDkH6ShEBJB3nUDkA")));

  /// Retrieve the account information for a specific address with context.
  final accountModelWithContext = await service.requestWithContext(
      const SolanaRequestGetAccountInfo(
          account: SolAddress.unchecked(
              "527pWSWfeQGLM7SoyVXjCRkrSZBtDkH6ShEBJB3nUDkA")));

  /// Retrieve the account information for a specific address and return as JSON.
  final accountResponseInJson = await service.requestDynamic(
      const SolanaRequestGetAccountInfo(
          account: SolAddress.unchecked(
              "527pWSWfeQGLM7SoyVXjCRkrSZBtDkH6ShEBJB3nUDkA")));

  /// Retrieve the account information for a specific address in JSON with context.
  final accountdynamicWithContext = await service.requestDynamicWithContext(
      const SolanaRequestGetAccountInfo(
          account: SolAddress.unchecked("qweqweqwe")));
}
