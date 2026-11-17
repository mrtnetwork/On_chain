/// Hedera testnet examples (HBAR transfer, token lifecycle, threshold keys, topic).
library;

import 'package:blockchain_utils/blockchain_utils.dart';
import 'package:on_chain/on_chain.dart';
import 'package:on_chain/hedera/src/proto_messages/proto/models.dart';
import 'package:on_chain/hedera/src/transaction/signer/transaction_body_signers.dart';

import 'client.dart';

/// Use the local node (`hedera start`) instead of testnet.
const bool _local = bool.fromEnvironment('HEDERA_LOCAL');

const String _rpcUrl = _local
    ? 'http://127.0.0.1:5551'
    : 'https://testnet.mirrornode.hedera.com';
const String _grpcUrl = _local ? '127.0.0.1' : 'testnet.hedera.com';
const int _grpcPort = 50211;
const HederaNetwork _network = _local
    ? HederaNetwork.localNode
    : HederaNetwork.testnet;

/// 1 HBAR = 100_000_000 tinybars.
final BigInt _oneHbar = BigInt.from(100000000);

/// Default auto-renew period (30 days).
final HederaDuration _autoRenew = HederaDuration(
  seconds: BigInt.from(const Duration(days: 30).inSeconds),
);

/// Testnet: the pre-funded secp256k1 example account (`0.0.9959237`,
/// EVM `0xfdb9f93c…`, ~932 HBAR). Local node: the genesis operator `0.0.2`.
final HederaSecretKey _fundedKey = _local
    ? HederaEd25519SecretKey.fromBytes(
        BytesUtils.fromHexString(
          '91132178e72057a1d7528025956fe39b0b847f200ab59b2fdd367017f3087137',
        ),
      )
    : HederaSecp256k1SecretKey.fromBytes(
        BytesUtils.fromHexString(
          '3f142fca7816a90d0a1f23a5790f27a73cd69e6c7aa8ff2c7aa90359158faa0a',
        ),
      );

final HederaProvider _provider = hederaProvider(
  rpcUrl: _rpcUrl,
  grpcUrl: _grpcUrl,
  grpcPort: _grpcPort,
  tls: false,
);

/// Local node: mirror REST is not indexed for the genesis operator, so use
/// node queries (with a paid-query signer). Testnet: mirror-first.
final HederaClientSterategy _strategy = _local
    ? HederaClientSterategy(
        mirror: null,
        node: HederaApiNodeStrategyPaidQuery(
          source: (query) async => HederaPaidQuerySource(
            signer: _fundedKey,
            payer: HederaAddress('0.0.2'),
            maxQueryCost: _oneHbar,
          ),
        ),
      )
    : const HederaClientSterategy();

final DefaultHederaClient _client = DefaultHederaClient(
  // testnet/local node 0.0.3
  nodeAccountId: HederaAccountID(accountNum: BigInt.from(3)),
  internalProvider: _provider,
  network: _network,
  strategy: _strategy,
);

Future<void> main() async {
  print('Hedera ${_network.name} | mirror: $_rpcUrl');
  final funded = await _resolveFunded();
  await _ensureFunded(funded);

  await _simpleTransfer(funded);
  await _tokenLifecycle(funded);
  await _multiKeyAccount(funded);
  await _topicMessage(funded);
  print('done.');
}

/// Resolve the funded account to its on-chain `0.0.x` id.
Future<HederaAddress> _resolveFunded() async {
  final address = _local
      ? HederaAddress('0.0.2')
      : HederaAddress.fromEcdsaPublicKey(_fundedKey.toPublicKey().toBytes());
  final account = await _client.getAccount(address);
  print('funded account: ${account.account.address} '
      '(evm ${account.evmAddress ?? '-'})');
  return account.account;
}

Future<void> _ensureFunded(HederaAddress funded) async {
  final balance = await _client.getBalance(funded);
  final hbar = AmountConverter.hdra.toAmount(balance.balance);
  print('funded balance: $hbar HBAR');
  if (balance.balance < _oneHbar * BigInt.from(10)) {
    throw StateError(
      'Fund ${funded.address} on ${_network.name} before running.',
    );
  }
}

// ── 1. simple HBAR transfer ────────────────────────────────────────────────

Future<void> _simpleTransfer(HederaAddress funded) async {
  print('\n== simple HBAR transfer ==');
  final recipientKey = HederaEd25519SecretKey.random();
  final recipient = await _createAccount(
    funded,
    key: recipientKey.toPublicKey().toHederaKey(),
    initialBalance: _oneHbar,
    memo: 'on_chain simple transfer',
  );
  print('recipient: ${recipient.address}');

  final builder = HederaTransactionBuilder(_client);
  builder.transferHbar(
    from: funded,
    to: recipient,
    amount: _oneHbar ~/ BigInt.from(10),
  );
  final result = await _send(
    builder,
    payer: funded,
    accountSigners: {funded: _signer(_fundedKey)},
  );
  print('transfer tx: ${result.transactionId}');
  _explorer('transaction', result.transactionId);

  for (var i = 0; i < 10; i++) {
    final after = await _client.getBalance(recipient);
    if (after.balance >= _oneHbar) {
      print('recipient balance: '
          '${AmountConverter.hdra.toAmount(after.balance)} HBAR');
      return;
    }
    await Future<void>.delayed(const Duration(seconds: 2));
  }
  print('recipient balance: pending mirror index (transfer is final)');
}

// ── 2. token lifecycle ─────────────────────────────────────────────────────

Future<void> _tokenLifecycle(HederaAddress funded) async {
  print('\n== token lifecycle ==');
  final recipientKey = HederaEd25519SecretKey.random();
  final recipient = await _createAccount(
    funded,
    key: recipientKey.toPublicKey().toHederaKey(),
    initialBalance: _oneHbar ~/ BigInt.from(5),
    memo: 'on_chain token recipient',
  );
  final payerKey = _fundedKey.toPublicKey().toHederaKey();

  final create = HederaTransactionBuilder(_client);
  create.setTokenCreate(
    name: 'ONCHAIN EXAMPLE',
    symbol: 'ONC',
    decimals: 2,
    initialSupply: BigInt.from(1000),
    treasury: funded,
    adminKey: payerKey,
    supplyKey: payerKey,
    autoRenewPeriod: _autoRenew,
    memo: 'on_chain token',
  );
  final created = await _send(
    create,
    payer: funded,
    accountSigners: {funded: _signer(_fundedKey)},
    providedKeys: {TxSignerRole.tokenCreateTreasury: payerKey},
  );
  final tokenId = created.receipt?.tokenID;
  if (tokenId == null) throw StateError('Token create returned no token id.');
  final token = HederaAddress.fromTokenId(tokenId).address;
  print('token: $token');
  _explorer('token', token);

  final associate = HederaTransactionBuilder(_client);
  associate.setTokenAssociate(account: recipient, tokens: [tokenId]);
  await _send(
    associate,
    payer: funded,
    accountSigners: {
      funded: _signer(_fundedKey),
      recipient: _signer(recipientKey),
    },
  );

  final mint = HederaTransactionBuilder(_client);
  mint.setTokenMint(token: tokenId, amount: BigInt.from(500));
  final minted = await _send(
    mint,
    payer: funded,
    accountSigners: {funded: _signer(_fundedKey)},
    providedKeys: {TxSignerRole.tokenSupplyKey: payerKey},
  );
  print('mint tx: ${minted.transactionId}');

  final transfer = HederaTransactionBuilder(_client);
  transfer.addTokenTransfer(
    token: tokenId,
    amount: BigInt.from(100),
    account: recipient,
  );
  transfer.addTokenTransfer(
    token: tokenId,
    amount: -BigInt.from(100),
    account: funded,
  );
  final transferred = await _send(
    transfer,
    payer: funded,
    accountSigners: {funded: _signer(_fundedKey)},
    providedKeys: {TxSignerRole.cryptoTransferTokenDebit: payerKey},
  );
  print('token transfer tx: ${transferred.transactionId}');

  // Mirror indexing is asynchronous; retry until the token shows up.
  BigInt? tokenBalance;
  for (var i = 0; i < 15; i++) {
    final balances = await _client.getBalance(recipient);
    for (final entry in balances.tokens) {
      if (entry.tokenId.address == token && entry.balance > BigInt.zero) {
        tokenBalance = entry.balance;
        break;
      }
    }
    if (tokenBalance != null) break;
    await Future<void>.delayed(const Duration(seconds: 2));
  }
  print('recipient token balance: ${tokenBalance ?? 'pending mirror index'}');
}

// ── 3. multi-key account (all key types) ───────────────────────────────────

Future<void> _multiKeyAccount(HederaAddress funded) async {
  print('\n== multi-key threshold account ==');
  final ed25519 = HederaEd25519SecretKey.random();
  final secp = HederaSecp256k1SecretKey.random();
  // Hedera's HAPI key proto marks ECDSA-384 / RSA-3072 as not supported, so
  // the network only accepts ed25519 + secp256k1 here.
  final multi = HederaMultiSigAccount(
    HederaThresholdAccountPublicKey(
      publicKeys: [ed25519.toPublicKey(), secp.toPublicKey()],
      threshold: 2,
    ),
    signers: [ed25519, secp],
  );
  print('threshold key: 2-of-2 (ed25519 + secp256k1)');

  final create = HederaTransactionBuilder(_client);
  create.setCryptoCreateAccount(
    key: multi.publicKeyAccount.toHederaKey(),
    initialBalance: _oneHbar,
    autoRenewPeriod: _autoRenew,
    maxAutomaticTokenAssociations: 10,
    memo: 'on_chain multi-key',
  );
  final created = await _send(
    create,
    payer: funded,
    accountSigners: {funded: _signer(_fundedKey)},
  );
  final account = created.receipt?.accountID;
  if (account == null) throw StateError('Account create returned no id.');
  final address = HederaAddress.fromNum(
    shard: account.shardNum,
    realm: account.realmNum,
    num: account.accountNum!,
  );
  print('multi-key account: ${address.address}');
  _explorer('account', address.address);

  final transfer = HederaTransactionBuilder(_client);
  transfer.transferHbar(
    from: address,
    to: funded,
    amount: _oneHbar ~/ BigInt.from(10),
  );
  final result = await _send(
    transfer,
    payer: address,
    signers: [multi],
    providedKeys: {TxSignerRole.payer: multi.publicKeyAccount.toHederaKey()},
    transactionFee: _oneHbar,
  );
  print('multi-key transfer tx: ${result.transactionId}');
}

// ── 4. consensus topic ─────────────────────────────────────────────────────

Future<void> _topicMessage(HederaAddress funded) async {
  print('\n== consensus topic ==');
  final payerKey = _fundedKey.toPublicKey().toHederaKey();
  final create = HederaTransactionBuilder(_client);
  create.setConsensusCreateTopic(
    memo: 'on_chain topic',
    adminKey: payerKey,
    submitKey: payerKey,
    autoRenewPeriod: _autoRenew,
  );
  final created = await _send(
    create,
    payer: funded,
    accountSigners: {funded: _signer(_fundedKey)},
    providedKeys: {
      TxSignerRole.consensusCreateAdminKey: payerKey,
      TxSignerRole.consensusCreateSubmitKey: payerKey,
    },
  );
  final topicId = created.receipt?.topicID;
  if (topicId == null) throw StateError('Topic create returned no id.');
  final topic = HederaAddress.fromTopicId(topicId).address;
  print('topic: $topic');

  final submit = HederaTransactionBuilder(_client);
  submit.setConsensusSubmitMessage(
    topicID: topicId,
    message: 'hello from on_chain'.codeUnits,
  );
  final submitted = await _send(
    submit,
    payer: funded,
    accountSigners: {funded: _signer(_fundedKey)},
    providedKeys: {TxSignerRole.topicSubmitKey: payerKey},
  );
  print('submit tx: ${submitted.transactionId}');

  if (_local) {
    print('mirror disabled on local node; submit tx is final.');
    return;
  }
  // Mirror indexing is asynchronous; retry a few times.
  for (var i = 0; i < 10; i++) {
    try {
      final messages = await _client.getMirrorTopicMessages(topic);
      final list = messages.messages ?? const [];
      if (list.isNotEmpty) {
        print('mirror message: ${list.last.message} '
            '(seq ${list.last.sequenceNumber})');
        return;
      }
    } catch (_) {}
    await Future<void>.delayed(const Duration(seconds: 2));
  }
  print('mirror message not indexed yet (submit tx is final).');
}

// ── helpers ────────────────────────────────────────────────────────────────

Future<HederaAddress> _createAccount(
  HederaAddress payer, {
  required HederaKey key,
  BigInt? initialBalance,
  String? memo,
}) async {
  final builder = HederaTransactionBuilder(_client);
  builder.setCryptoCreateAccount(
    key: key,
    initialBalance: initialBalance,
    memo: memo,
    autoRenewPeriod: _autoRenew,
    maxAutomaticTokenAssociations: 10,
  );
  final result = await _send(
    builder,
    payer: payer,
    accountSigners: {payer: _signer(_fundedKey)},
  );
  final id = result.receipt?.accountID;
  if (id == null) throw StateError('Account create returned no id.');
  return HederaAddress.fromNum(
    shard: id.shardNum,
    realm: id.realmNum,
    num: id.accountNum!,
  );
}

HederaTransactionSigner _signer(HederaSecretKey key) {
  return HederaTransactionSigner(
    publicKeys: [key.toPublicKey()],
    signer: (publicKey) async => key,
  );
}

Future<HederaSubmitTransactionResult> _send(
  HederaTransactionBuilder builder, {
  required HederaAddress payer,
  Map<HederaAddress, HederaTransactionSigner> accountSigners = const {},
  Map<HederaKey, HederaTransactionSigner> keySigners = const {},
  Map<TxSignerRole, HederaKey> providedKeys = const {},
  List<HederaSigner>? signers,
  BigInt? transactionFee,
}) async {
  await builder.fillTransaction(
    params: HederaFillTransactionParams(
      payer: payer,
      feeSafetyMultiplier: 2,
      transactionFee: transactionFee,
      lockupSignerParams: TxBodySignerLookupParams(providedKeys: providedKeys),
    ),
  );
  await builder.signTransaction(
    params: HederaSignTransactionParams(
      signers: signers,
      signerCallback: ({required role, account, key}) async {
        if (account != null) return accountSigners[account];
        if (key != null) {
          for (final entry in keySigners.entries) {
            if (HederaCryptoUtils.keysEqual(entry.key, key)) return entry.value;
          }
        }
        return null;
      },
    ),
  );
  await builder.finalizeTransaction();
  final result = await builder.submit(
    params: const HederaSubmitTransactionParams(
      waitForReceipt: true,
      timeout: Duration(seconds: 90),
    ),
  );
  if (!result.success) {
    throw StateError('Transaction failed: status=${result.receipt?.status} '
        'precheck=${result.response.nodeTransactionPrecheckCode} '
        'tx=${result.transactionId}');
  }
  return result;
}

void _explorer(String kind, String id) {
  if (_local) {
    print('  local $kind: $id');
    return;
  }
  print('  https://hashscan.io/testnet/$kind/$id');
}