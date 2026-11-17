import 'package:on_chain/hedera/src/address/src/address.dart';
import 'package:on_chain/hedera/src/crypto/utils/utils.dart';
import 'package:on_chain/hedera/src/proto_messages/proto/models.dart';
import 'package:on_chain/hedera/src/transaction/signer/transaction_body_signers.dart';
import 'package:test/test.dart';

import 'client.dart';
import 'fake_keys.dart';

import '../../../utils.dart';

// /// Lightweight assert helper (no flutter_test dependency).
// void expect(bool cond, [String? msg]) {
//   if (!cond) {
//     throw StateError(msg ?? 'expectation failed');
//   }
// }

void expectEq(Object? a, Object? b, [String? msg]) {
  if (a != b) {
    throw StateError(msg ?? 'expected $b, got $a');
  }
}

void signerDectionsTest() {
  group('Hedera/Signer detection', () {
    test(
      "Detect signers local crypto transfer",
      testDetectSignersLocalCryptoTransfer,
    );
    test(
      "Detect signers local token create",
      testDetectSignersLocalTokenCreate,
    );
    test(
      "Detect signers local threshold admin key",
      testDetectSignersLocalThresholdAdminKey,
    );
    test("Provided keys avoids missing", testProvidedKeysAvoidsMissing);
  });
}

void main() {
  OnChainUtilsTestApi.runTest(signerDectionsTest, "Signer Detection");
}

HederaAddress _acct(int num) => HederaAddress.fromNum(num: BigInt.from(num));

HederaTokenID _token(int num) => HederaTokenID(
  shardNum: BigInt.zero,
  realmNum: BigInt.zero,
  tokenNum: BigInt.from(num),
);

Future<void> testDetectSignersLocalCryptoTransfer() async {
  final from = _acct(1001);
  final to = _acct(1002);
  final body = HederaTransactionBody(
    transactionID: HederaTransactionID(
      accountID: from.toAccoutId(),
      transactionValidStart: HederaTimestamp(seconds: BigInt.from(1), nanos: 0),
    ),
    cryptoTransfer: HederaCryptoTransferTransactionBody(
      transfers: HederaTransferList(
        accountAmounts: [
          HederaAccountAmount(
            accountID: from.toAccoutId(),
            amount: BigInt.from(-10),
          ),
          HederaAccountAmount(
            accountID: to.toAccoutId(),
            amount: BigInt.from(10),
          ),
        ],
      ),
    ),
  );

  final s = body.detectSignersLocal();
  expect(
    s.accounts.contains(from),
    isTrue,
    reason: 'payer/from should be required',
  );
  expect(
    s.missingKeys.isEmpty,
    isTrue,
    reason: 'local path has no missingKeys',
  );
  expectEq(s.bodyType, 'cryptoTransfer');
}

Future<void> testDetectSignersLocalTokenCreate() async {
  final treasury = _acct(2001);
  final admin = FakeHederaKeys.ed25519(11);
  final supply = FakeHederaKeys.ed25519(12);
  final body = HederaTransactionBody(
    tokenCreation: HederaTokenCreateTransactionBody(
      name: 'T',
      symbol: 'T',
      treasury: treasury.toAccoutId(),
      adminKey: admin,
      supplyKey: supply,
      initialSupply: BigInt.zero,
      decimals: 0,
    ),
  );
  final s = body.detectSignersLocal();
  expect(
    s.accounts.any((a) => a.toString().contains('2001')),
    isTrue,
    reason: 'treasury',
  );
  expect(s.keys.length >= 2, isTrue, reason: 'admin+supply keys on body');
  expect(s.missingKeys.isEmpty, isTrue);
}

Future<void> testDetectSignersLocalThresholdAdminKey() async {
  final multi = FakeHederaKeys.threshold(threshold: 2, count: 3, seed: 40);
  final body = HederaTransactionBody(
    cryptoCreateAccount: HederaCryptoCreateTransactionBody(
      key: multi,
      initialBalance: BigInt.zero,
      receiverSigRequired: true,
    ),
  );
  final s = body.detectSignersLocal();
  expect(s.keys.isNotEmpty, isTrue, reason: 'threshold key present');
  final flat = <Object>[];
  for (final k in s.keys) {
    flat.addAll(HederaCryptoUtils.flattenHederaKey(k));
  }
  expect(
    flat.length == 3,
    isTrue,
    reason: 'threshold 2-of-3 flattens to 3 primitives, got ${flat.length}',
  );
}

Future<void> testStateKeysMissingWhenOffline() async {
  final client = FakeHederaClient();
  final body = HederaTransactionBody(
    tokenMint: HederaTokenMintTransactionBody(
      token: _token(55),
      amount: BigInt.from(1),
    ),
  );
  final s = await body.detectSigners(
    client: client,
    lookup: const TxBodySignerLookupParams(resolveStateKeys: true),
  );
  expect(
    s.missingKeys.contains(TxSignerRole.tokenSupplyKey),
    'offline client must report missing supplyKey, got ${s.missingKeys}',
  );
  expect(s.hasMissingKeys, isTrue);
}

Future<void> testProvidedKeysAvoidsMissing() async {
  final client = FakeHederaClient();
  final supply = FakeHederaKeys.ed25519(99);
  final body = HederaTransactionBody(
    tokenMint: HederaTokenMintTransactionBody(
      token: _token(55),
      amount: BigInt.from(1),
    ),
  );
  final s = await body.detectSigners(
    client: client,
    lookup: TxBodySignerLookupParams(
      resolveStateKeys: true,
      providedKeys: {TxSignerRole.tokenSupplyKey: supply},
    ),
  );
  expect(
    !s.missingKeys.contains(TxSignerRole.tokenSupplyKey),
    isTrue,
    reason: 'providedKeys should satisfy supplyKey',
  );
  expect(s.keys.isNotEmpty, isTrue, reason: 'provided key listed');
}
