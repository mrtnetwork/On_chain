/// Cardano Preprod examples through `AdaQuickClient` (needs a Blockfrost project id).
library;

import 'package:blockchain_utils/blockchain_utils.dart';
import 'package:on_chain/ada/ada.dart';

import 'provider_example/provider.dart';

/// Blockfrost Preprod base URL and a public project id.
const String _blockfrostUrl = 'https://cardano-preprod.blockfrost.io/api/v0/';
const String _blockfrostProjectId = 'preprodMVwzqm4PuBDBSfEULoMzoj5QZcy5o3z5';

/// BIP32 path used by the Cardano examples (CIP-1852, role 0 = external).
const String _derivationPath = "1852'/1815'/0'/0/";

/// One ADA in lovelace.
final BigInt _oneAda = BigInt.from(1000000);

/// Builds the Blockfrost-backed provider for Preprod.
BlockFrostProvider preprodProvider() => BlockFrostProvider(
      BlockFrostHTTPProvider(
        url: _blockfrostUrl,
        projectId: _blockfrostProjectId,
      ),
    );

/// The single QuickClient used by every example.
///
/// `AdaQuickClient` owns the provider and exposes one unified method per top
/// request, so the examples never build `BlockfrostRequest*` objects by hand.
final AdaQuickClient quick = DefaultAdaQuickClient(
  provider: preprodProvider(),
);

/// Deterministic demo wallet: a seed + a BIP32 path -> key + enterprise address.
class DemoAccount {
  DemoAccount(this.bip32, this.index) : path = '$_derivationPath$index';

  final CardanoIcarusBip32 bip32;
  final int index;
  final String path;

  late final AdaPrivateKey privateKey = AdaPrivateKey.fromBytes(
    bip32.derivePath(path).privateKey.toBytes(),
  );

  late final ADAEnterpriseAddress address = ADAEnterpriseAddress.fromPublicKey(
    pubkeyBytes: privateKey.publicKey().toBytes32(),
    network: ADANetwork.testnetPreprod,
  );

  /// A vkey witness over [digest] for this account.
  Vkeywitness witness(List<int> digest) =>
      privateKey.createSignatureWitness(digest);
}

/// Shared seed for every example account (deterministic + reproducible).
final CardanoIcarusBip32 _seed = CardanoIcarusBip32.fromSeed(
  List<int>.filled(20, 12),
);

/// The funded account (index 0 holds the faucet balance on Preprod).
DemoAccount get faucet => DemoAccount(_seed, 0);

/// Recipient accounts used by the examples.
DemoAccount get alice => DemoAccount(_seed, 1);
DemoAccount get bob => DemoAccount(_seed, 2);

/// All UTXOs of [address], collected from the QuickClient's paginated stream.
Future<List<ADAAccountUTXOResponse>> utxosOf(ADAAddress address) async {
  final pages = await quick.watchAccountUtxos(address).toList();
  return pages.expand((page) => page).toList();
}

/// Total lovelace held by [address] (0 when the address is unknown).
Future<BigInt> balanceOf(ADAAddress address) => quick.getBalance(address);

/// Resolves [utxos] (from Blockfrost) into builder-ready UTXOs.
List<TransactionUnspentOutput> toUnspentOutputs(
  Iterable<ADAAccountUTXOResponse> utxos,
) {
  return utxos
      .map(
        (u) => TransactionUnspentOutput(
          input: u.input,
          output: TransactionOutput(
            address: u.toAdddress,
            amount: Value(
              coin: u.sumOflovelace,
              multiAsset: u.haveAsset ? u.multiAsset : null,
            ),
          ),
        ),
      )
      .toList();
}

/// Picks UTXOs from [utxos] until [target] lovelace is covered.
///
/// UTXOs are considered largest-first so that a single big UTXO is preferred
/// and the number of stale (recently spent) inputs is minimized.
List<TransactionUnspentOutput> selectUtxos(
  List<TransactionUnspentOutput> utxos,
  BigInt target,
) {
  final sorted = [...utxos]
    ..sort((a, b) => b.output.amount.coin.compareTo(a.output.amount.coin));
  final selected = <TransactionUnspentOutput>[];
  BigInt covered = BigInt.zero;
  for (final u in sorted) {
    selected.add(u);
    covered += u.output.amount.coin;
    if (covered >= target) break;
  }
  if (covered < target) {
    throw StateError('not enough lovelace: have $covered, need $target');
  }
  return selected;
}

/// Builds, finalizes (fee + change), signs and submits a transaction.
///
/// [outputs] are the payment outputs (without change); the change goes back to
/// [changeAddress]. [signers] maps each required signer address to its witness
/// factory. [utxos] is fetched fresh on every attempt and must exclude the
/// input keys in [exclude] (Blockfrost can lag behind the chain tip and keep
/// returning already-spent UTXOs); on a UTxO error the failed inputs are added
/// to [exclude] and the call is retried up to [maxAttempts] times.
Future<String> buildSignSubmit({
  required Future<List<TransactionUnspentOutput>> Function(Set<String> exclude)
      utxos,
  required List<TransactionOutput> outputs,
  required ADAAddress changeAddress,
  required Map<ADAAddress,
          List<ADABaseTransactionWitness> Function(List<int> digest)>
      signers,
  List<ADAMinsBuilder> mints = const [],
  NativeScripts? nativeScripts,
  GeneralTransactionMetadata? metadata,
  int maxAttempts = 5,
}) async {
  final params = await quick.latestEpochProtocolParameters();
  final feeParameters = ADAFeeParameters.fromProtocolParameters(params);

  final excluded = <String>{};
  Object? lastError;
  for (var attempt = 0; attempt < maxAttempts; attempt++) {
    final attemptUtxos = await utxos(excluded);
    if (attemptUtxos.isEmpty) {
      throw StateError('no usable utxos left after $attempt attempts');
    }
    final builder = ADATransactionBuilderV2(
      utxos: attemptUtxos,
      outputs: outputs,
      mints: mints,
      nativeScripts: nativeScripts,
      metadata: metadata,
    );

    final finalized = builder.finalize(
      changeAddress: changeAddress,
      feeParameters: feeParameters,
    );

    final transaction = finalized.sign(({
      required BuBytes digest,
      required List<ADAAddress> addresses,
    }) {
      final witnesses = <ADAAddress, List<ADABaseTransactionWitness>>{};
      for (final address in addresses) {
        final sign = signers[address];
        if (sign == null) continue;
        witnesses[address] = sign(digest);
      }
      return witnesses;
    });

    try {
      final txId = await quick.submitTransaction(transaction.serialize());
      await quick.trackTransaction(transactionId: txId);
      return txId;
    } on RPCError catch (e) {
      final message = e.message.toLowerCase();
      final spent = message.contains('all inputs are spent') ||
          message.contains('already been included') ||
          message.contains('badinputnutxo') ||
          message.contains('nonemptyset') ||
          message.contains('value not conserved') ||
          message.contains('utxowfailure');
      lastError = e;
      if (!spent || attempt == maxAttempts - 1) break;
      // Drop every input we just tried so the next attempt cannot reuse it.
      for (final u in attemptUtxos) {
        excluded.add('${u.input.txIdHex}:${u.input.index}');
      }
      await Future<void>.delayed(const Duration(seconds: 4));
    }
  }
  throw lastError ?? StateError('transaction submit failed');
}

/// Ensures [address] holds at least [minLovelace], topping up from [faucet].
Future<void> ensureFunded(ADAAddress address, {BigInt? minLovelace}) async {
  final target = minLovelace ?? _oneAda * BigInt.from(5);
  if (address == faucet.address) return;
  final balance = await balanceOf(address);
  if (balance >= target) {
    print(
      '  [fund] ${address.address} already has ${balance ~/ _oneAda} ADA',
    );
    return;
  }
  final deficit = target - balance;
  print('  [fund] sending ${deficit ~/ _oneAda} ADA to ${address.address}');
  await exampleSimplePaymentTo(address, deficit);
}

/// Internal helper: faucet pays [amount] to [receiver] (used by ensureFunded).
Future<void> exampleSimplePaymentTo(
  ADAAddress receiver,
  BigInt amount,
) async {
  await buildSignSubmit(
    utxos: (exclude) =>
        faucetUtxosFor(exclude, amount + _oneAda * BigInt.from(2)),
    outputs: [
      TransactionOutput(address: receiver, amount: Value(coin: amount)),
    ],
    changeAddress: faucet.address,
    signers: {
      faucet.address: (digest) => [
            faucet.privateKey.createSignatureWitness(digest),
          ],
    },
  );
}

/// True when [u]'s input key is in [excluded].
bool excludedHas(Set<String> excluded, TransactionUnspentOutput u) =>
    excluded.contains('${u.input.txIdHex}:${u.input.index}');

/// Fetches fresh faucet UTXOs, drops [excluded] input keys, and selects enough
/// to cover [target] lovelace.
Future<List<TransactionUnspentOutput>> faucetUtxosFor(
  Set<String> excluded,
  BigInt target,
) async {
  final all = toUnspentOutputs(await utxosOf(faucet.address));
  final usable = all.where((u) => !excludedHas(excluded, u)).toList();
  return selectUtxos(usable, target);
}

/// 1. QuickClient tour: every read/status helper on the faucet account.
Future<void> exampleQuickClientTour() async {
  print('\n== 1. QuickClient tour ==');

  final height = await quick.getBlockHeight();
  print('  block height:            ${height ?? 'unknown'}');

  final params = await quick.latestEpochProtocolParameters();
  print(
    '  protocol:                minFeeA=${params.minFeeA} minFeeB=${params.minFeeB}',
  );

  print(
      '  faucet balance:          ${await balanceOf(faucet.address)} lovelace');
  print(
      '  alice balance:           ${await balanceOf(alice.address)} lovelace');

  final utxos = await utxosOf(faucet.address);
  print('  faucet utxos:            ${utxos.length}');

  if (utxos.isNotEmpty) {
    final first = utxos.first;
    print(
        '  first utxo:              ${first.input.txIdHex}:${first.input.index}');

    // Resolve a spent output straight from the QuickClient.
    final resolved = await quick.getUtxosOutputs([first.input]);
    print('  resolved outputs:        ${resolved.length}');
  }
}

/// 2. Simple payment: faucet sends 2 ADA to Alice.
Future<void> exampleSimplePayment() async {
  print('\n== 2. Simple payment (faucet -> alice, 2 ADA) ==');
  await ensureFunded(alice.address, minLovelace: _oneAda * BigInt.from(5));

  final before = await balanceOf(alice.address);
  final amount = _oneAda * BigInt.from(2);

  final txId = await buildSignSubmit(
    utxos: (exclude) =>
        faucetUtxosFor(exclude, amount + _oneAda * BigInt.from(2)),
    outputs: [
      TransactionOutput(address: alice.address, amount: Value(coin: amount)),
    ],
    changeAddress: faucet.address,
    signers: {
      faucet.address: (digest) => [
            faucet.privateKey.createSignatureWitness(digest),
          ],
    },
  );
  await Future<void>.delayed(const Duration(seconds: 6));
  final after = await balanceOf(alice.address);

  print('  txid:  $txId');
  print('  status: ${await quick.getTransactionStatus(txId)}');
  print('  alice: ${before ~/ _oneAda} -> ${after ~/ _oneAda} ADA');
  print('  explorer: https://preprod.cardanoscan.io/transaction/$txId');
}

/// 3. Multi-output payment: faucet pays Alice and Bob in one transaction.
Future<void> exampleMultiOutputPayment() async {
  print('\n== 3. Multi-output payment (faucet -> alice + bob) ==');
  await ensureFunded(alice.address, minLovelace: _oneAda * BigInt.from(5));
  await ensureFunded(bob.address, minLovelace: _oneAda * BigInt.from(5));

  final amount = _oneAda; // 1 ADA each

  final txId = await buildSignSubmit(
    utxos: (exclude) => faucetUtxosFor(
      exclude,
      amount * BigInt.from(2) + _oneAda * BigInt.from(2),
    ),
    outputs: [
      TransactionOutput(address: alice.address, amount: Value(coin: amount)),
      TransactionOutput(address: bob.address, amount: Value(coin: amount)),
    ],
    changeAddress: faucet.address,
    signers: {
      faucet.address: (digest) => [
            faucet.privateKey.createSignatureWitness(digest),
          ],
    },
  );

  print('  txid:  $txId');
  print('  alice: ${await balanceOf(alice.address) ~/ _oneAda} ADA');
  print('  bob:   ${await balanceOf(bob.address) ~/ _oneAda} ADA');
  print('  explorer: https://preprod.cardanoscan.io/transaction/$txId');
}

/// 4. Mint a native asset (NFT) under a native-script policy and keep it.
Future<void> exampleMintNativeAsset() async {
  print('\n== 4. Mint a native asset (NFT) ==');
  await ensureFunded(faucet.address);

  final keyHash = Ed25519KeyHash.fromPubkey(
    faucet.privateKey.publicKey().toBytes32(),
  );
  // Allow minting only while the faucet key signs; no time lock keeps it simple.
  final mintScript = NativeScriptScriptPubkey(keyHash);
  final policyId = PolicyID(mintScript.toHash().data);
  final assetName = AssetName('CARDEX'.codeUnits);

  final mint = ADAMinsBuilder(
    minterScript: mintScript,
    owner: faucet.address,
    mintingAssets: Assets({assetName: BigInt.one}),
  );

  final txId = await buildSignSubmit(
    utxos: (exclude) async {
      // Only spend pure-lovelace UTXOs: spending an input that holds assets
      // from another policy would require that policy's native script witness.
      final all = toUnspentOutputs(await utxosOf(faucet.address));
      final usable = all
          .where((u) => !excludedHas(exclude, u))
          .where((u) => u.output.amount.multiAsset == null)
          .toList();
      return selectUtxos(usable, _oneAda * BigInt.from(3));
    },
    outputs: [
      TransactionOutput(
        address: faucet.address,
        amount: Value(
          coin: _oneAda * BigInt.from(2),
          multiAsset: MultiAsset({policyId: mint.mintingAssets}),
        ),
      ),
    ],
    changeAddress: faucet.address,
    mints: [mint],
    nativeScripts: NativeScripts([mintScript]),
    signers: {
      faucet.address: (digest) => [
            faucet.privateKey.createSignatureWitness(digest),
          ],
    },
  );

  print('  policy: ${policyId.toHex()}');
  print('  asset:  ${policyId.toHex()}${assetName.toHex()}');
  print('  txid:   $txId');
  print('  explorer: https://preprod.cardanoscan.io/transaction/$txId');
}

Future<void> main() async {
  final height = await quick.getBlockHeight();
  final params = await quick.latestEpochProtocolParameters();
  final faucetBalance = await balanceOf(faucet.address);

  print('Cardano Preprod TestNet (QuickClient)');
  print('  block:    ${height ?? 'unknown'}');
  print('  minFeeA:  ${params.minFeeA}  minFeeB: ${params.minFeeB}');
  print('  faucet:   ${faucet.address.address}');
  print('  alice:    ${alice.address.address}');
  print('  bob:      ${bob.address.address}');
  print('  faucet:   ${faucetBalance ~/ _oneAda} ADA');
  if (faucetBalance < _oneAda * BigInt.from(20)) {
    print(
      '\nFaucet is low. Fund this Preprod address from '
      'https://docs.cardano.org/cardano-testnet/tools/faucet/ and re-run:',
    );
    print('  ${faucet.address.address}');
    return;
  }

  await exampleQuickClientTour();
  await exampleSimplePayment();
  await exampleMultiOutputPayment();
  await exampleMintNativeAsset();

  print('\nAll Cardano examples completed.');
}
