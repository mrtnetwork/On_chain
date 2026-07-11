import 'package:blockchain_utils/blockchain_utils.dart';
import 'package:on_chain/on_chain.dart';
import 'package:test/test.dart';

void main() {
  test('encodable provider params', () {
    final param = SuiRequestGetCoins(
      owner: SuiAddress.one,
      coinType: "coin1",
      pagination: SuiApiRequestPagination(
        cursor: QuickCrypto.generateRandomHex(),
        limit: 12,
      ),
    );
    final request = param.buildRequest(0);
    final deserialize = SuiRequestDetails.deserialize(
      bytes: request.toCbor().encode(),
    );
    expect(deserialize.path, request.path);
    expect(deserialize.encodeBody(), request.encodeBody());
    expect(deserialize.successStatusCodes, request.successStatusCodes);
    expect(deserialize.errorStatusCodes, request.errorStatusCodes);
    expect(deserialize.network, BlockchainNetwork.sui);
    expect(deserialize.responseEncoding, request.responseEncoding);
    expect(deserialize.requestMethod, request.requestMethod);
  });
}
