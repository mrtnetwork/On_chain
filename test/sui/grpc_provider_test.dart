// gRPC provider layer tests (offline): request building, CBOR params
// round-trips, and end-to-end dispatch through a fake service.
// The JSON-RPC path is untouched (see sui_fixtures_test.dart).
import 'package:blockchain_utils/blockchain_utils.dart';
import 'package:on_chain/on_chain.dart';
import 'package:test/test.dart';

import '../utils.dart';
class _FakeSuiService with SuiServiceProvider {
  List<int>? lastGrpcBytes;
  String? lastGrpcMethod;

  @override
  Future<BaseServiceResponse> doRequest(
    BaseServiceRequestParams params, {
    Duration? timeout,
  }) {
    throw UnimplementedError();
  }

  @override
  Future<List<int>> doGrpcRequest(
    BaseGRPCServiceRequestParams params, {
    Duration? timeout,
  }) async {
    final details = params as SuiGrpcRequestDetails;
    lastGrpcBytes = details.buffer.toList();
    lastGrpcMethod = details.method();
    return SuiGetServiceInfoResponse(
      chainId: '4btiugY9r3n5ok6vhBpc1uDBHGtkyf5Q7WCUSgYoK5Yk',
    ).toBuffer().toList();
  }

  @override
  Stream<List<int>> doGrpcRequestStream(
    BaseGRPCServiceRequestParams params, {
    Duration? timeout,
  }) {
    throw UnimplementedError();
  }

  @override
  Future<Stream<List<int>>> doGrpcRequestStreamAsync(
    BaseGRPCServiceRequestParams params, {
    Duration? timeout,
  }) {
    throw UnimplementedError();
  }
}

void grpcProviderTest() {
  group('Sui/Grpc provider (offline)', () {
    test('request building carries method urls + binary payloads', () {
      final info = SuiGrpcRequestMessage(SuiGetServiceInfoRequest());
      expect(info.method, '/sui.rpc.v2.LedgerService/GetServiceInfo');
      expect(info.toBuffer(), isEmpty);

      final obj = SuiGrpcRequestMessage(
        SuiGetObjectRequest(objectId: '0x5'),
      );
      expect(obj.method, '/sui.rpc.v2.LedgerService/GetObject');
      expect(obj.toBuffer(), isNotEmpty);

      final checkpoint = SuiGrpcRequestMessage(
        SuiGetCheckpointRequest(sequenceNumber: BigInt.from(100)),
      );
      expect(checkpoint.method, '/sui.rpc.v2.LedgerService/GetCheckpoint');

      final tx = SuiGrpcRequestMessage(
        SuiGetTransactionRequest(digest: 'abcd'),
      );
      expect(tx.method, '/sui.rpc.v2.LedgerService/GetTransaction');
    });

    test('params CBOR round-trip across the union', () {
      final grpc = SuiGrpcRequestDetails(
        buffer: [1, 2, 3],
        requestMethod: '/sui.rpc.v2.LedgerService/GetObject',
      );
      final grpcBack = BaseSuiServiceRequestParams.deserialize(
        bytes: grpc.toCbor().encode(),
      );
      expect(grpcBack, isA<SuiGrpcRequestDetails>());
      expect(
        (grpcBack as SuiGrpcRequestDetails).requestMethod,
        grpc.requestMethod,
      );
      expect(grpcBack.buffer.toList(), [1, 2, 3]);

      final jsonRpc = SuiRequestGetBalance(
        owner: SuiAddress(
          '0x0000000000000000000000000000000000000000000000000000000000000000',
        ),
      ).buildRequest(7);
      final jsonBack = BaseSuiServiceRequestParams.deserialize(
        bytes: jsonRpc.toCbor().encode(),
      );
      expect(jsonBack, isA<SuiRequestDetails>());
      expect((jsonBack as SuiRequestDetails).method, 'suix_getBalance');
    });

    test('quick client dispatches grpc through a fake service', () async {
      final service = _FakeSuiService();
      final client = DefaultSuiQuickClient(
        provider: SuiProvider(service),
      );
      final chainId = await client.getChainId();
      expect(chainId, '35834a8a');
      expect(
        service.lastGrpcMethod,
        '/sui.rpc.v2.LedgerService/GetServiceInfo',
      );
      expect(service.lastGrpcBytes, isEmpty);
    });
  });
}

void main() {
  OnChainUtilsTestApi.runTest(grpcProviderTest, "Grpc Provider");
}

