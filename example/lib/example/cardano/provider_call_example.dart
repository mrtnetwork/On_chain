// ignore_for_file: unused_local_variable

import 'package:on_chain/ada/ada.dart';

import 'provider_example/provider.dart';

void main() async {
  final provider = BlockforestProvider(BlockforestHTTPProvider(
      url: "https://cardano-preprod.blockfrost.io/api/v0/",
      projectId: "preprodMVwzqm4PuBDBSfEULoMzoj5QZcy5o3z5"));

  final List<ADAAccountUTXOResponse> accountUtxos = await provider.request(
      BlockfrostRequestAddressUTXOs(ADAAddress.fromAddress(
          "addr_test1vp0q6wvr6y3elejn69efhnxr5akk24azaxcez3xw8m9n85gmr5qny")));
  final ADAEpochParametersResponse protocolParams =
      await provider.request(BlockfrostRequestLatestEpochProtocolParameters());

  final ADATransactionUTXOSResponse transaction = await provider.request(
      BlockfrostRequestTransactionUTXOs(
          "69edd1c1c4fdc282e3fe1d90f368a228d7702316dc33e494e5bee7db81d6183b"));
}
