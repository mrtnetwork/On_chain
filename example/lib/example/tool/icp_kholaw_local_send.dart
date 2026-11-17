import 'dart:io';
import 'package:blockchain_utils/blockchain_utils.dart';
import 'package:http/http.dart';
import 'package:on_chain/icp/icp.dart';

class _Http with ICPServiceProvider {
  _Http(this.url, {Client? client}) : client = client ?? Client();
  final String url;
  final Client client;
  @override
  Future<BaseServiceResponse> doRequest(ICPRequestDetails params,
      {Duration? timeout}) async {
    final r = params.requestMethod == RequestMethod.get
        ? await client
            .get(params.encodeUrl(url), headers: params.headers)
            .timeout(timeout ?? const Duration(seconds: 60))
        : await client
            .post(params.encodeUrl(url),
                headers: params.headers, body: params.encodeBody())
            .timeout(timeout ?? const Duration(seconds: 60));
    return params.toResponse(r.bodyBytes, statusCode: r.statusCode);
  }
}

Future<void> main() async {
  const mnemonic =
      'abandon abandon abandon abandon abandon abandon abandon abandon abandon abandon abandon about';
  final mode = Platform.environment['MODE'] ?? 'info';
  final seed =
      Bip39SeedGenerator(Bip39Mnemonic.fromString(mnemonic)).generate();

  // Wallet path: Bip44 coin-config routing (kholaw via TEMP experiment edit).
  final derived =
      Bip44.fromSeed(seed, Bip44Coins.internetComputer).deriveDefaultPath;
  final privBytes = List<int>.from(derived.bip32.privateKey.toBytes());
  print('KDF_TYPE ${derived.bip32.runtimeType}');
  print('PRIV_LEN ${privBytes.length}');

  // First-class kholaw key type (new ICPKeyType.ed25519Kholaw).
  final secret = ICPEd25519KholawSecretKey.fromBytes(privBytes);
  final principal = secret.toPrincipalAddress();
  print('VIA_NEW_TYPE ${principal.address}');
  final testSig = await secret.signAsync([1, 2, 3]);
  print('SELF_VERIFY ${secret.toPublicKey().verifySignature([
        1,
        2,
        3
      ], testSig)}');

  final api = ICPClientDefault(
    provider: ICPProvider(_Http('http://127.0.0.1:4943')),
    config: ICPClientConfig(
      network: ICPNetworkConfig.defaultConfig,
      // Proof run: default verification strategy (was Never during diagnosis).
      callStrategy: ICPCallStrategySigning(
          signer: (_) async => secret, address: principal),
    ),
  );

  final balance = await api.getLedgerAccountBalance(principal);
  print('BALANCE_E8S $balance');
  final acct = principal.toAccountIdentifier();
  print('ACCOUNT_ID ${BytesUtils.toHexString(acct.toBytes())}');

  if (mode == 'send') {
    final toHex = Platform.environment['TO_ACCT'] ?? '';
    if (toHex.isEmpty) {
      print('MISSING_TO_ACCT');
      exit(2);
    }
    final to = IcpAccountIdentifier.fromBytes(BytesUtils.fromHexString(toHex));
    final res = await api.ledgerTransfer(
      to: to,
      amount: BigInt.from(100000), // 0.001 test ICP
      sender: IcpPrincipalAddressWithSubId(principal),
    );
    print('TRANSFER_RESULT $res');
  }
}
