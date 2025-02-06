import 'package:http/http.dart';
import 'package:on_chain/on_chain.dart';

class AptosHttpService implements AptosServiceProvider {
  AptosHttpService(this.url,
      {Client? client, this.defaultTimeOut = const Duration(seconds: 30)})
      : client = client ?? Client();

  final String url;
  final Client client;
  final Duration defaultTimeOut;
  @override
  Future<AptosServiceResponse<T>> doRequest<T>(AptosRequestDetails params,
      {Duration? timeout}) async {
    final url = params.toUri(this.url);
    final defaultTimeOut = timeout ?? this.defaultTimeOut;
    if (params.type.isPostRequest) {
      final response = await client
          .post(url, headers: params.headers, body: params.body())
          .timeout(defaultTimeOut);
      return params.parseResponse(response.bodyBytes, response.statusCode);
    }
    final response =
        await client.get(url, headers: params.headers).timeout(defaultTimeOut);
    return params.parseResponse(response.bodyBytes, response.statusCode);
  }
}

void main() async {
  /// Provider examples

  /// Initialize the AptosProvider with the Testnet HTTP service endpoint
  final AptosProvider provider =
      AptosProvider(AptosHttpService("https://api.testnet.aptoslabs.com/"));

  /// Define an Aptos address to interact with
  final address = AptosAddress(
      "0x89dd43dcedf165f975202fae5f8aecf03013ebc14bb3c09a1431313b4ee52b02");

  /// Request account details for the specified address
  await provider.request(AptosRequestGetAccount(address: address));

  /// Fetch the transaction history for the specified address
  await provider.request(AptosRequestGetAccountTransactions(address: address));

  /// Retrieve all recent transactions from the Aptos network
  await provider.request(AptosRequestGetTransactions());

  /// Execute a view function from the 'aptos_governance' module to get remaining voting power
  await provider.request(AptosRequestExecuteViewFunctionOfaModule.bcs(
      entry: AptosTransactionEntryFunction(
          moduleId: AptosModuleId(
              address: AptosAddress("0x1"),
              name: "aptos_governance"), // Governance module
          functionName: "get_remaining_voting_power", // Function to execute
          args: [
        // Address to check voting power for
        AptosAddress(
            "0xba08cec00a8cfa1deff6c9212dda8d198c8fa6ee1992f3ada76d645f99e3402b"),
        MoveU64(BigInt.one) // Argument representing the proposal ID or context
      ])));

  final dynamicResult =
      await provider.requestDynamic(AptosRequestGetAccount(address: address));
  // ignore: unused_local_variable
  final authentication = dynamicResult["authentication_key"];

  /// ...
}
