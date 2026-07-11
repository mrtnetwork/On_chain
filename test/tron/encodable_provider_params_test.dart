import 'package:blockchain_utils/blockchain_utils.dart';
import 'package:on_chain/on_chain.dart';
import 'package:test/test.dart';

void main() {
  test('encodable provider params', () {
    final param = TronRequestBroadcastHex(
      transaction: QuickCrypto.generateRandomHex(),
    );
    final request = param.buildRequest(0);
    final deserialize = TronRequestDetails.deserialize(
      bytes: request.toCbor().encode(),
    );
    expect(deserialize.encodeBody(), request.encodeBody());
    expect(deserialize.successStatusCodes, request.successStatusCodes);
    expect(deserialize.errorStatusCodes, request.errorStatusCodes);
    expect(deserialize.network, BlockchainNetwork.tron);
    expect(deserialize.responseEncoding, request.responseEncoding);
    expect(deserialize.requestMethod, request.requestMethod);
    expect(deserialize.path, request.path);
  });
}
