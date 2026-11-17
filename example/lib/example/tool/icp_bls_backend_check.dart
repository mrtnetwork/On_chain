import 'package:blockchain_utils/blockchain_utils.dart';
import 'package:blockchain_utils/crypto/crypto/keys/bls12_381/api/src/dart.dart';
import 'package:http/http.dart';
import 'package:on_chain/icp/icp.dart';

class _Http with ICPServiceProvider {
  _Http(this.url, {Client? client}) : client = client ?? Client();
  final String url;
  final Client client;
  @override
  Future<BaseServiceResponse> doRequest(
    ICPRequestDetails params, {
    Duration? timeout,
  }) =>
      doResponse(params, timeout: timeout);
  Future<BaseServiceResponse> doResponse(
    ICPRequestDetails params, {
    Duration? timeout,
  }) async {
    final r = params.requestMethod == RequestMethod.get
        ? await client
            .get(params.encodeUrl(url), headers: params.headers)
            .timeout(timeout ?? const Duration(seconds: 60))
        : await client
            .post(
              params.encodeUrl(url),
              headers: params.headers,
              body: params.encodeBody(),
            )
            .timeout(timeout ?? const Duration(seconds: 60));
    return params.toResponse(r.bodyBytes, statusCode: r.statusCode);
  }
}

Future<void> main() async {
  final api = ICPClientDefault(
    provider: ICPProvider(_Http('http://127.0.0.1:4943')),
    config: const ICPClientConfig(
      network: ICPNetworkConfig.defaultConfig,
      callStrategy: ICPCallStrategyDisable(),
      verificationStrategy: ICPResponseVerificationStrategyNever(),
    ),
  );
  final rootKey = (await api.status()).rootKey!;
  final cert = await api.getCanisterSubnet(
    ICPNetworkConfig.defaultConfig.ledgerCanisterId,
  );
  final blsKey = Bls12G2PublicKey.fromDer(rootKey);
  final message = ICPCryptoUtils.icStateRootMessage(cert.tree.reconstruct());
  final sig = Bls12G2Signature(G1Projective.fromBytes(cert.signature));
  print('BACKEND ${blockchainUtils.api.signing.bls.runtimeType}');
  print(
    'PUB_ROUNDTRIP ${BytesUtils.bytesEqual(blsKey.toBytes(), rootKey.sublist(rootKey.length - 96))}',
  );
  final sigRt = G1Projective.fromBytes(cert.signature).toBytes();
  print(
    'SIG_ROUNDTRIP ${BytesUtils.bytesEqual(List<int>.from(sigRt), cert.signature)}',
  );
  print('TIME_LOOKUP ${cert.lookup(["time".codeUnits])}');

  // 1. Pure-Dart backend, explicit NUL.
  const dart = DartBlsSigningApi();
  final dartNul = dart.verifyMinSig(
    pk: blsKey.toBytes(),
    message: message,
    signature: sig,
    dst: BlsG1Constants.defaultDst,
  );
  print('DART_BACKEND NUL => $dartNul');
  final dartPop = dart.verifyMinSig(
    pk: blsKey.toBytes(),
    message: message,
    signature: sig,
    dst: BlsG1Constants.popDst,
  );
  print('DART_BACKEND POP => $dartPop');

  // 2. Default-path (production path), null vs explicit.
  final defNull = blsKey.verify(
    Bls12G2VerifiyingParams(
      signature: sig,
      signingParams: Bls12SigningParams(message: message),
    ),
  );
  print('DEFAULT_PATH null-dst => $defNull');
}
