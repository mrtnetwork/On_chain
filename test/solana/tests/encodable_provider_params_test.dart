import 'package:blockchain_utils/blockchain_utils.dart';
import 'package:on_chain/on_chain.dart';
import 'package:test/test.dart';

void main() {
  test('encodable provider params', () {
    final param = SolanaRequestGetAccountInfo(
      account: SolAddress.defaultPubKey,
      commitment: Commitment.confirmed,
      dataSlice: RPCDataSliceConfig(length: 1, offset: 3),
    );
    final request = param.buildRequest(0);
    final deserialize = SolanaRequestDetails.deserialize(
      bytes: request.toCbor().encode(),
    );
    expect(deserialize.encodeBody(), request.encodeBody());
    expect(deserialize.successStatusCodes, request.successStatusCodes);
    expect(deserialize.errorStatusCodes, request.errorStatusCodes);
    expect(deserialize.network, BlockchainNetwork.solana);
    expect(deserialize.responseEncoding, request.responseEncoding);
    expect(deserialize.requestMethod, request.requestMethod);
    expect(deserialize.path, null);
  });
}
