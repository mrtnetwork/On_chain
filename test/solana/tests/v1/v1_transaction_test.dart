import 'package:blockchain_utils/blockchain_utils.dart';
import 'package:test/test.dart';
import 'package:on_chain/solana/solana.dart';
import '../utils.dart';

import '../../../utils.dart';

void compiledMessageV1Test() {
  group('Solana/V1 Config', () {
    _configMask();
    _configRoundTrip();
    _configValidation();
  });
  group('Solana/V1 Message', () {
    _v1Transfer();
    _v1TransferWithConfig();
    _v1RejectsLookupTables();
    _v1RejectsDuplicates();
    _v1FromBufferDispatch();
    _v1FromJson();
  });
  group('Solana/V1 RPC', () {
    _rpcMaxVersion();
  });
}

void main() {
  OnChainUtilsTestApi.runTest(compiledMessageV1Test, 'Compiled Message V1');
}

void _configMask() {
  test('mask encoding', () {
    expect(const TransactionV1Config.empty().mask, 0);
    expect(
      const TransactionV1Config(
        priorityFeeLamports: null,
        computeUnitLimit: 20000,
        loadedAccountsDataSizeLimit: 65536,
      ).mask,
      0x0C,
    );
    expect(
      TransactionV1Config(priorityFeeLamports: BigInt.from(5000)).mask,
      0x03,
    );
    expect(
      TransactionV1Config(
        priorityFeeLamports: BigInt.from(5000),
        computeUnitLimit: 20000,
        loadedAccountsDataSizeLimit: 65536,
        heapSize: 65536,
      ).mask,
      0x1F,
    );
    expect(const TransactionV1Config.empty().encodeValues(), isEmpty);
    final feeOnly =
        TransactionV1Config(
          priorityFeeLamports: BigInt.from(5000),
        ).encodeValues();
    expect(feeOnly.length, 8);
    // 5000 LE u64.
    expect(feeOnly, [0x88, 0x13, 0, 0, 0, 0, 0, 0]);
  });
}

void _configRoundTrip() {
  test('mask/values round-trip', () {
    const config = TransactionV1Config(
      computeUnitLimit: 20000,
      loadedAccountsDataSizeLimit: 65536,
      heapSize: 65536,
    );
    final mask = config.mask;
    expect(mask, 0x1C);
    final values = config.encodeValues();
    expect(values.length, 12);
    final back = TransactionV1Config.fromMaskAndValues(mask, values);
    expect(back, config);

    final fee = TransactionV1Config(
      priorityFeeLamports: BigInt.parse('18446744073709551615'),
    );
    final feeBack = TransactionV1Config.fromMaskAndValues(
      fee.mask,
      fee.encodeValues(),
    );
    expect(feeBack, fee);
  });

  test('rejects partial fee bits and unknown bits', () {
    expect(
      () => TransactionV1Config.fromMaskAndValues(0x01, [1, 2, 3, 4]),
      throwsA(isA<BuError>()),
    );
    expect(
      () => TransactionV1Config.fromMaskAndValues(0x20, [1, 2, 3, 4]),
      throwsA(isA<BuError>()),
    );
  });
}

void _configValidation() {
  test('heap validation', () {
    expect(
      () => const TransactionV1Config(heapSize: 1000).validate(),
      throwsA(isA<BuError>()),
    );
    expect(
      () => const TransactionV1Config(heapSize: 32 * 1024 - 1024).validate(),
      throwsA(isA<BuError>()),
    );
    expect(
      () => const TransactionV1Config(heapSize: 256 * 1024 + 1024).validate(),
      throwsA(isA<BuError>()),
    );
    // Valid boundaries do not throw.
    const TransactionV1Config(heapSize: 32 * 1024).validate();
    const TransactionV1Config(heapSize: 256 * 1024).validate();
  });
}

SolanaTransaction _buildV1Transfer({
  TransactionV1Config config = const TransactionV1Config.empty(),
}) {
  final owner = QuickWalletForTest(index: 255);
  final receiver = QuickWalletForTest(index: 257);
  const blockHash = 'GWWy2aAev5X3TMRVwdw8W2KMN3dyVrHrQMZukGTf9R1A';
  final ix = SystemProgram.transfer(
    from: owner.address,
    layout: SystemTransferLayout(lamports: SolanaUtils.toLamports('0.001')),
    to: receiver.address,
  );
  return SolanaTransaction(
    instructions: [ix],
    recentBlockhash: SolAddress.uncheckCurve(blockHash),
    payerKey: owner.address,
    type: TransactionType.v1,
    config: config,
  );
}

void _v1Transfer() {
  test('transfer empty config', () {
    final tx = _buildV1Transfer();
    expect(tx.type, TransactionType.v1);
    final msg = tx.message;
    expect(msg, isA<MessageV1>());
    final bytes = tx.serializeMessage();
    // Version byte at offset zero, legacy header follows.
    expect(bytes[0], 0x81);
    expect(bytes.sublist(1, 4), [1, 0, 1]);
    // Mask = 0 LE.
    expect(bytes.sublist(4, 8), [0, 0, 0, 0]);
    // numIx=1, numAddr=3 after 32-byte lifetime.
    expect(bytes[8 + 32], 1);
    expect(bytes[8 + 32 + 1], 3);
    // Round-trip without signatures.
    final back = SolanaTransaction.deserialize(tx.serialize());
    expect(back.serialize(), tx.serialize());
    // Sign + verify + tail signatures (no count prefix).
    final owner = QuickWalletForTest(index: 255);
    tx.sign([owner.privateKey]);
    expect(tx.areSignaturesReady(), isTrue);
    final wire = tx.serialize();
    expect(wire[0], 0x81);
    expect(wire.length, bytes.length + 64);
    expect(wire.sublist(0, bytes.length), bytes);
    final verified = SolanaTransaction.deserialize(
      wire,
      verifySignatures: true,
    );
    expect(verified.serialize(), wire);
    expect(verified.type, TransactionType.v1);
  });
}

void _v1TransferWithConfig() {
  test('transfer with full config', () {
    final config = TransactionV1Config(
      priorityFeeLamports: BigInt.from(5000),
      computeUnitLimit: 20000,
      loadedAccountsDataSizeLimit: 65536,
      heapSize: 65536,
    );
    final tx = _buildV1Transfer(config: config);
    final bytes = tx.serializeMessage();
    expect(bytes[0], 0x81);
    // Mask 0x1F LE.
    expect(bytes.sublist(4, 8), [0x1F, 0, 0, 0]);
    // Config values sit after 3 addrs: fee(8) + cu(4) + loaded(4) + heap(4).
    final valuesOffset = 1 + 3 + 4 + 32 + 1 + 1 + 3 * 32;
    expect(bytes.sublist(valuesOffset, valuesOffset + 20), [
      0x88, 0x13, 0, 0, 0, 0, 0, 0, // 5000
      0x20, 0x4E, 0, 0, // 20000
      0, 0, 1, 0, // 65536
      0, 0, 1, 0, // 65536
    ]);
    // Instruction header: program 2, 2 accounts, 12 data bytes LE.
    final ixHeaderOffset = valuesOffset + 20;
    expect(bytes.sublist(ixHeaderOffset, ixHeaderOffset + 4), [2, 2, 0x0C, 0]);
    final back = SolanaTransaction.deserialize(tx.serialize());
    expect(back.serialize(), tx.serialize());
    final v1 = back.message as MessageV1;
    expect(v1.config, config);
  });
}

void _v1RejectsLookupTables() {
  test('rejects address lookup tables', () {
    final owner = QuickWalletForTest(index: 255);
    final receiver = QuickWalletForTest(index: 257);
    final ix = SystemProgram.transfer(
      from: owner.address,
      layout: SystemTransferLayout(lamports: SolanaUtils.toLamports('0.001')),
      to: receiver.address,
    );
    final table = AddressLookupTableAccount(
      key: owner.address,
      addresses: [receiver.address],
      lastExtendedSlot: BigInt.zero,
      lastExtendedStartIndex: 0,
      deactivationSlot: BigInt.from(-1),
      authority: null,
    );
    expect(
      () => SolanaTransaction(
        instructions: [ix],
        recentBlockhash: owner.address,
        payerKey: owner.address,
        type: TransactionType.v1,
        addressLookupTableAccounts: [table],
      ),
      throwsA(isA<BuError>()),
    );
  });
}

void _v1RejectsDuplicates() {
  test('rejects duplicate inline addresses', () {
    final owner = QuickWalletForTest(index: 255);
    final header = const MessageHeader(
      numRequiredSignatures: 1,
      numReadonlySignedAccounts: 0,
      numReadonlyUnsignedAccounts: 1,
    );
    final dup = MessageV1(
      header: header,
      accountKeys: [owner.address, owner.address],
      recentBlockhash: owner.address,
      compiledInstructions: const [],
    );
    expect(() => dup.serialize(), throwsA(isA<BuError>()));
  });
}

void _v1FromBufferDispatch() {
  test('fromBuffer dispatches 0x81 to MessageV1', () {
    final tx = _buildV1Transfer();
    final msg = VersionedMessage.fromBuffer(tx.serializeMessage());
    expect(msg, isA<MessageV1>());
    expect(msg.version, TransactionType.v1);
    final legacy = VersionedMessage.fromBuffer(
      SolanaTransaction(
        instructions: [
          SystemProgram.transfer(
            from: QuickWalletForTest(index: 255).address,
            layout: SystemTransferLayout(
              lamports: SolanaUtils.toLamports('0.001'),
            ),
            to: QuickWalletForTest(index: 257).address,
          ),
        ],
        recentBlockhash: SolAddress.uncheckCurve(
          'GWWy2aAev5X3TMRVwdw8W2KMN3dyVrHrQMZukGTf9R1A',
        ),
        payerKey: QuickWalletForTest(index: 255).address,
        type: TransactionType.legacy,
      ).serializeMessage(),
    );
    expect(legacy, isA<Message>());
    expect(
      () => VersionedMessage.fromBuffer([0x82, 0, 0, 0]),
      throwsA(isA<BuError>()),
    );
  });
}

void _v1FromJson() {
  test('fromJson with transactionConfig', () {
    final tx = _buildV1Transfer(
      config: const TransactionV1Config(
        computeUnitLimit: 20000,
        loadedAccountsDataSizeLimit: 65536,
      ),
    );
    final v1 = tx.message as MessageV1;
    Map<String, dynamic> enc(List<int> b) => {
      'data': Base58Encoder.encode(b),
      'encoding': 'base58',
    };
    final json = {
      'header': v1.header.toJson(),
      'accountKeys': v1.accountKeys.map((a) => a.address).toList(),
      'recentBlockhash': v1.recentBlockhash.address,
      'instructions':
          v1.compiledInstructions
              .map(
                (c) => {
                  'programIdIndex': c.programIdIndex,
                  'accounts': c.accounts,
                  ...enc(c.data),
                },
              )
              .toList(),
      'transactionConfig': {
        'computeUnitLimit': 20000,
        'loadedAccountsDataSizeLimit': 65536,
      },
    };
    final msg = VersionedMessage.fromJson(json, type: TransactionType.v1);
    expect(msg, isA<MessageV1>());
    expect(
      (msg as MessageV1).config,
      const TransactionV1Config(
        computeUnitLimit: 20000,
        loadedAccountsDataSizeLimit: 65536,
      ),
    );
  });
}

void _rpcMaxVersion() {
  test('requests carry maxSupportedTransactionVersion 1', () {
    const getTx = SolanaRequestGetTransaction(
      transactionSignature: 'x',
      maxSupportedTransactionVersion: 1,
    );
    expect((getTx.toJson()[1] as Map)['maxSupportedTransactionVersion'], 1);
    const getBlock = SolanaRequestGetBlock(slot: 1);
    expect(getBlock.maxSupportedTransactionVersion, 1);
    expect((getBlock.toJson()[1] as Map)['maxSupportedTransactionVersion'], 1);
  });
}
