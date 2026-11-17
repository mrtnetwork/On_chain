import 'package:blockchain_utils/blockchain_utils.dart';
import 'package:on_chain/on_chain.dart';

import 'client.dart';

/// Shadownet (long-running Tezos testnet).
const String rpcUrl = 'https://rpc.shadownet.teztnets.com';

/// Deterministic example keys, one per supported curve.
///
/// ed25519 / secp256k1 / secp256r1 use the same 32-byte seed (12), the BLS key
/// is the fixed example key from the old transfer example. All four accounts
/// are funded from the Shadownet faucet.
final TezosEd25519SecretKey ed25519Key = TezosEd25519SecretKey.fromBytes(
  List<int>.filled(32, 12),
);
final TezosSecp256k1SecretKey secp256k1Key = TezosSecp256k1SecretKey.fromBytes(
  List<int>.filled(32, 12),
);
final TezosSecp256r1SecretKey secp256r1Key = TezosSecp256r1SecretKey.fromBytes(
  List<int>.filled(32, 12),
);
final TezosBlsSecretKey blsKey = TezosBlsSecretKey.fromBytes(
  BytesUtils.fromHexString(
    '29e85c46f9f8614153a6b5ad4f90e4eafa8250fc2089b8e89730061a2737fb1f',
  ),
);

class ExampleAccount {
  const ExampleAccount(this.name, this.key);
  final String name;
  final TezosSecretKey key;

  TezosAddress get address => key.toPublicKey().toAddress();
  TezosOperationSource get source =>
      DefaultTezosOperationSource.fromPublicKey(
        publicKey: key.toPublicKey(),
        signer: (_) async => key,
      );
}

final List<ExampleAccount> exampleAccounts = [
  ExampleAccount('ed25519 (tz1)', ed25519Key),
  ExampleAccount('secp256k1 (tz2)', secp256k1Key),
  ExampleAccount('secp256r1 (tz3)', secp256r1Key),
  ExampleAccount('bls (tz4)', blsKey),
];

DefaultTezosClient createClient({String? url}) {
  return DefaultTezosClient(
    provider: octezProvider(url: url ?? rpcUrl),
    config: const TezosClientConfig(
      chain: 'main',
      version: '1',
      confirmationTimeout: Duration(minutes: 3),
    ),
  );
}

String explorerOp(String hash) => 'https://shadownet.tzkt.io/op/$hash';

String explorerContract(TezosAddress address) =>
    'https://shadownet.tzkt.io/${address.address}';