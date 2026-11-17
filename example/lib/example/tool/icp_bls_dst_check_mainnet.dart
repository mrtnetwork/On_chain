import 'package:blockchain_utils/blockchain_utils.dart';
import 'package:http/http.dart';
import 'package:on_chain/icp/icp.dart';

class _Http with ICPServiceProvider {
  _Http(this.url, {Client? client}) : client = client ?? Client();
  final String url;
  final Client client;
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

  @override
  Future<BaseServiceResponse> doRequest(
    ICPRequestDetails params, {
    Duration? timeout,
  }) =>
      doResponse(params, timeout: timeout);
}

Future<bool> verifyWithDst({
  required ICPCertificate cert,
  required List<int> keyDer,
  required List<int>? dst,
  required String label,
}) async {
  final blsKey = Bls12G2PublicKey.fromDer(keyDer);
  final rootHash = cert.tree.reconstruct();
  print('ROOTHASH_HEX ${BytesUtils.toHexString(rootHash)}');
  print('SIG_HEX ${BytesUtils.toHexString(cert.signature)}');
  final message = ICPCryptoUtils.icStateRootMessage(rootHash);
  final ok = blsKey.verify(
    Bls12G2VerifiyingParams(
      signature: Bls12G2Signature(G1Projective.fromBytes(cert.signature)),
      signingParams: Bls12SigningParams(message: message, dst: dst),
    ),
  );
  print('$label => $ok');
  return ok;
}

Future<void> main() async {
  final api = ICPClientDefault(
    provider: ICPProvider(_Http('https://ic0.app')),
    config: const ICPClientConfig(
      network: ICPNetworkConfig.defaultConfig,
      callStrategy: ICPCallStrategyDisable(),
      verificationStrategy: ICPResponseVerificationStrategyNever(),
    ),
  );
  final status = await api.status();
  final rootKey = status.rootKey!;
  print('ROOTKEY_HEX ${BytesUtils.toHexString(rootKey)}');

  final ledger = ICPNetworkConfig.defaultConfig.ledgerCanisterId;
  final cert = await api.getCanisterSubnet(ledger);
  print('HAS_DELEGATION ${cert.delegation != null}');

  // Resolve the signing key bytes (mirror _delegationKey, no verify).
  List<int> keyDer;
  ICPCertificate target = cert;
  if (cert.delegation != null) {
    final d = cert.delegation!;
    final found = d.certificate.lookup([
      'subnet'.codeUnits,
      d.subnetId.toBytes(),
      'public_key'.codeUnits,
    ]);
    if (found is! ICPLookupFound) {
      print('NO_SUBNET_KEY');
      return;
    }
    keyDer = List<int>.from(found.value);
    print('SIGNER=delegation subnet key len=${keyDer.length}');
    // Also test the delegation cert itself under the root key.
    print('-- delegation cert under root:');
    await verifyWithDst(
      cert: d.certificate,
      keyDer: rootKey,
      dst: null,
      label: 'POP ',
    );
    await verifyWithDst(
      cert: d.certificate,
      keyDer: rootKey,
      dst: BlsG2Constants.defaultBlsDst,
      label: 'NUL ',
    );
    target = cert;
  } else {
    keyDer = rootKey;
    print('SIGNER=root key');
  }
  print('-- outer cert under resolved key:');
  final pop = await verifyWithDst(
    cert: target,
    keyDer: keyDer,
    dst: null,
    label: 'POP ',
  );
  final nul = await verifyWithDst(
    cert: target,
    keyDer: keyDer,
    dst: BlsG2Constants.defaultBlsDst,
    label: 'NUL ',
  );
  print('CONCLUSION pop=$pop nul=$nul');
}
