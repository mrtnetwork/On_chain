import 'package:blockchain_utils/blockchain_utils.dart';
import 'package:on_chain/algorand/src/address/address.dart';
import 'package:on_chain/algorand/src/rpc/core/core.dart';
import 'package:on_chain/algorand/src/rpc/methods/methods.dart';
import 'package:on_chain/algorand/src/rpc/models/types.dart';
import 'package:on_chain/algorand/src/transaction/src/fields.dart';
import 'package:on_chain/algorand/src/transaction/src/signatures.dart';
import 'package:on_chain/algorand/src/transaction/src/transaction.dart';
import 'package:test/test.dart';

import '../../utils.dart';
void algoSerializationEncodableProviderParamsTest() {
  group('Algorand/Encodable Provider Params', () {
  test('encodable provider params', () {
    final param = AlgoRestRequestAccountApplicationInformation(
      address: AlgoAddress.zero.address,
      applicationId: BigInt.from(1014),
    );
    final request = param.buildRequest(0);
    final deserialize = AlgoRequestDetails.deserialize(
      bytes: request.toCbor().encode(),
    );
    expect(deserialize.api, AlgoApi.rest);
    expect(deserialize.encodeBody(), request.encodeBody());
    expect(deserialize.successStatusCodes, request.successStatusCodes);
    expect(deserialize.errorStatusCodes, request.errorStatusCodes);
    expect(deserialize.network, BlockchainNetwork.algorand);
    expect(deserialize.responseEncoding, request.responseEncoding);
    expect(deserialize.requestMethod, request.requestMethod);
    expect(deserialize.path, request.path);
  });
  test('encodable provider params', () {
    final param = AlgoRestRequestSimulateTransaction(
      simulate: AlgoRestTypesSimulateRequest(
        txnGroups: [
          AlgoRestTypesSimulateRequestTransactionGroup(
            txns: [
              AlgoSignedTxn(
                transaction: AlgoTransaction.fromFields(
                  header: TransactionHeader(
                    sender: AlgoAddress.zero,
                    fee: BigInt.zero,
                    firstValid: BigInt.one,
                    lastValid: BigInt.two,
                    genesisHash: QuickCrypto.generateRandom(),
                  ),
                  fields: PaymentTxnFields(
                    receiver: AlgoAddress.zero,
                    amount: BigInt.from(1),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
    final request = param.buildRequest(0);
    final deserialize = AlgoRequestDetails.deserialize(
      bytes: request.toCbor().encode(),
    );
    expect(deserialize.api, AlgoApi.rest);
    expect(deserialize.requestMethod, RequestMethod.post);
    expect(deserialize.encodeBody(), request.encodeBody());
    expect(deserialize.successStatusCodes, request.successStatusCodes);
    expect(deserialize.errorStatusCodes, request.errorStatusCodes);
    expect(deserialize.network, BlockchainNetwork.algorand);
    expect(deserialize.responseEncoding, request.responseEncoding);
    expect(deserialize.requestMethod, request.requestMethod);
    expect(deserialize.path, request.path);
  });
  test('encodable provider params', () {
    final param = AlgoIndexerRequestLookupAccountAssets(
      accountId: AlgoAddress.zero.address,
    );
    final request = param.buildRequest(0);
    final deserialize = AlgoRequestDetails.deserialize(
      bytes: request.toCbor().encode(),
    );
    expect(deserialize.api, AlgoApi.indexer);
    expect(deserialize.encodeBody(), request.encodeBody());
    expect(deserialize.successStatusCodes, request.successStatusCodes);
    expect(deserialize.errorStatusCodes, request.errorStatusCodes);
    expect(deserialize.network, BlockchainNetwork.algorand);
    expect(deserialize.responseEncoding, request.responseEncoding);
    expect(deserialize.requestMethod, request.requestMethod);
    expect(deserialize.path, request.path);
  });
  });
}

void main() {
  OnChainUtilsTestApi.runTest(algoSerializationEncodableProviderParamsTest, "Encodable Provider Params");
}

