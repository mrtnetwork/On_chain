// Sui PTB builder tests: helpers, phases, gas flow (stub client), full
// offline signing with a real ed25519 key.
import 'package:blockchain_utils/blockchain_utils.dart';
import 'package:on_chain/on_chain.dart';
import 'package:on_chain/transaction/transaction.dart';
import 'package:test/test.dart';

import '../utils.dart';
class _StubClient with SuiQuickClientApi {
  @override
  IGrpcProvider<IServiceProvider, BaseSuiServiceRequestParams,
          BaseGRPCServiceRequestParams>
      get provider => throw UnimplementedError();

  SuiObject _coin(String id, BigInt balance) {
    return SuiObject(
      objectId: id,
      version: BigInt.one,
      digest: 'H2X7JDw1H1AcGP5aqXRBQeycdvg5gDx9ZVQpeg5vCMu3',
      objectType:
          '0x0000000000000000000000000000000000000000000000000000000000000002::coin::Coin<${SuiTransactionConst.suiTypeArgs}>',
      balance: balance,
      previousTransaction: 'EyM6UgsUnA4gRkUa4CxKawoV9xD8158sK7qzcyPYhVTo',
    );
  }

  @override
  Future<BigInt> getGasPrice() async => BigInt.from(1000);

  @override
  Stream<List<SuiObject>> watchAccountCoins(
    SuiAddress address, {
    String? coinType,
  }) async* {
    yield [
      _coin(
        '0x1111111111111111111111111111111111111111111111111111111111111111',
        BigInt.from(100000000),
      ),
      _coin(
        '0x2222222222222222222222222222222222222222222222222222222222222222',
        BigInt.from(50000000),
      ),
    ];
  }

  @override
  Future<SuiSimulateTransactionResponse> simulateTransaction(
    String txBytes,
  ) async => SuiSimulateTransactionResponse(
    transaction: SuiExecutedTransaction(
      digest: '',
      effects: SuiTransactionEffects(
        status: SuiExecutionStatus(success: true),
        epoch: BigInt.zero,
        gasUsed: SuiGasCostSummary(
          computationCost: BigInt.from(2000000),
          nonRefundableStorageFee: BigInt.zero,
          storageCost: BigInt.from(100000),
          storageRebate: BigInt.zero,
        ),
      ),
    ),
  );

  @override
  Future<SuiExecuteTransactionResponse> executeTransaction({
    required String txBytes,
    required List<SuiBaseSignature> signatures,
  }) async => SuiExecuteTransactionResponse(
    transaction: SuiExecutedTransaction(
      digest: 'CCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCC=',
    ),
  );
}

SuiEd25519Account _testAccount() {
  final seed = List<int>.generate(32, (i) => i + 1);
  return SuiEd25519Account(SuiED25519PrivateKey.fromBytes(seed));
}

void transactionBuilderTest() {

  group('Sui/Transaction builder', () {
    test('command helpers index inputs and results', () {
      final b = SuiTransactionBuilder();
      final addr = b.pureAddress(
        SuiAddress(
          '0x0000000000000000000000000000000000000000000000000000000000000001',
        ),
      );
      expect(addr.input, 0);
      final amount = b.pureU64(BigInt.from(100));
      expect(amount.input, 1);
      final r = b.moveCall(
        package: SuiAddress(
          '0x0000000000000000000000000000000000000000000000000000000000000002',
        ),
        module: 'coin',
        function: 'transfer',
        arguments: [addr, amount],
      );
      expect(r.result, 0);
      b.transferObjects([r], addr);
      // Split into two coins; each reference must be a distinct NestedResult
      // so the parts can be used individually (e.g. transfer only #2).
      final splits = b.splitCoins(r, [BigInt.from(10), BigInt.from(20)]);
      expect(splits.length, 2);
      expect(splits[0], isA<SuiArgumentNestedResult>());
      expect(splits[1], isA<SuiArgumentNestedResult>());
      expect((splits[0] as SuiArgumentNestedResult).commandIndex, 2);
      expect((splits[0] as SuiArgumentNestedResult).resultIndex, 0);
      expect((splits[1] as SuiArgumentNestedResult).commandIndex, 2);
      expect((splits[1] as SuiArgumentNestedResult).resultIndex, 1);
      b.transferObjects([splits[1]], addr);
      b.mergeCoins(r, [splits[0]]);
      expect(b.phase, TxBuilderPhase.building);
    });

    test('staking and coin one-shots build correct commands', () async {
      final b = SuiTransactionBuilder();
      final validator = SuiAddress(
        '0x0000000000000000000000000000000000000000000000000000000000000003',
      );
      final recipient = b.pureAddress(
        SuiAddress(
          '0x0000000000000000000000000000000000000000000000000000000000000002',
        ),
      );
      final stake = b.requestAddStake(
        stakeCoin: SuiArgumentGasCoin(),
        validator: validator,
      );
      expect(stake, isA<SuiArgumentResult>());
      final withdraw = b.requestWithdrawStake(stakedSui: stake);
      expect(withdraw, isA<SuiArgumentResult>());
      b.transferSui(recipient: recipient);
      b.transferSui(recipient: recipient, amount: BigInt.from(5));
      final other = b.pureAddress(
        SuiAddress(
          '0x0000000000000000000000000000000000000000000000000000000000000004',
        ),
      );
      b.pay(
        coins: [SuiArgumentGasCoin()],
        recipients: [recipient, other],
        amounts: [BigInt.one, BigInt.two],
      );
      expect(
        () => b.pay(coins: [], recipients: [], amounts: []),
        throwsA(isA<BuError>()),
      );
      expect(
        () => b.pay(
          coins: [SuiArgumentGasCoin()],
          recipients: [recipient],
          amounts: [BigInt.one, BigInt.two],
        ),
        throwsA(isA<BuError>()),
      );
      b.setSender(
        SuiAddress(
          '0x0000000000000000000000000000000000000000000000000000000000000001',
        ),
      );
      final tx = await b.getTransaction();
      final ptb =
          (tx.data.kind as SuiTransactionKindProgrammableTransaction)
              .transaction;
      SuiProgrammableMoveCall moveCallAt(int i) =>
          (ptb.commands[i] as SuiCommandMoveCall).moveCall;
      // 0: stake, 1: unstake, 2: transfer whole gas, 3: split, 4: transfer
      // part, 5: split (pay), 6-7: transfers (pay).
      expect(moveCallAt(0).function, 'request_add_stake');
      expect(moveCallAt(0).module, 'sui_system');
      expect(moveCallAt(0).arguments.length, 3);
      expect(moveCallAt(1).function, 'request_withdraw_stake');
      expect(moveCallAt(1).arguments.length, 2);
      expect(ptb.commands[2], isA<SuiCommandTransferObjects>());
      expect(ptb.commands[3], isA<SuiCommandSplitCoins>());
      expect(ptb.commands[4], isA<SuiCommandTransferObjects>());
      final split = ptb.commands[3] as SuiCommandSplitCoins;
      expect(split.amounts.length, 1);
      final paySplit = ptb.commands[5] as SuiCommandSplitCoins;
      expect(paySplit.amounts.length, 2);
      expect(ptb.commands[6], isA<SuiCommandTransferObjects>());
      expect(ptb.commands[7], isA<SuiCommandTransferObjects>());
    });

    test('getTransaction requires sender', () {
      final b = SuiTransactionBuilder();
      b.moveCall(
        package: SuiAddress(
          '0x0000000000000000000000000000000000000000000000000000000000000002',
        ),
        module: 'm',
        function: 'f',
        arguments: [],
      );
      expect(
        () => b.getTransaction(),
        throwsA(isA<BuError>()),
      );
      b.setSender(
        SuiAddress(
          '0x0000000000000000000000000000000000000000000000000000000000000001',
        ),
      );
      expect(b.getTransaction(), completes);
    });

    test('selectGasCoins greedy + insufficient', () {
      final coins = [
        SuiObject(
          objectId:
              '0x1111111111111111111111111111111111111111111111111111111111111111',
          version: BigInt.one,
          digest: '',
          objectType:
              '0x2::coin::Coin<${SuiTransactionConst.suiTypeArgs}>',
          balance: BigInt.from(10),
          previousTransaction: '',
        ),
        SuiObject(
          objectId:
              '0x2222222222222222222222222222222222222222222222222222222222222222',
          version: BigInt.one,
          digest: '',
          objectType:
              '0x2::coin::Coin<${SuiTransactionConst.suiTypeArgs}>',
          balance: BigInt.from(100),
          previousTransaction: '',
        ),
      ];
      final selected = SuiTransactionBuilder.selectGasCoins(
        coins,
        BigInt.from(50),
      );
      expect(selected.length, 2); // 10 + 100 greedy
      expect(
        () => SuiTransactionBuilder.selectGasCoins(coins, BigInt.from(1000)),
        throwsA(isA<BuError>()),
      );
    });

    test('phase guards', () {
      final b = SuiTransactionBuilder();
      expect(
        b.signTransaction(
          params: SuiSignTransactionParams(signers: [_testAccount()]),
        ),
        throwsA(isA<BuError>()),
      );
      expect(b.finalizeTransaction(), throwsA(isA<Exception>()));
      expect(b.submit(), throwsA(isA<Exception>()));
    });

    test('full fill-sign-finalize-submit flow', () async {
      final sender = SuiAddress(
        '0x0000000000000000000000000000000000000000000000000000000000000001',
      );
      final b = SuiTransactionBuilder(client: _StubClient());
      b.setSender(sender);
      b.moveCall(
        package: SuiAddress(
          '0x0000000000000000000000000000000000000000000000000000000000000002',
        ),
        module: 'coin',
        function: 'transfer',
        arguments: [b.gasCoin(), b.pureAddress(sender)],
      );
      final filled = await b.fillTransaction(
        params: SuiFillTransactionParams(sender: sender),
      );
      expect(b.phase, TxBuilderPhase.filled);
      expect(filled.gasPrice, BigInt.from(1000));
      expect(filled.budget, greaterThan(BigInt.zero));
      expect(filled.gasCoins, isNotEmpty);
      // (2M + 100k) * 1.2 + 1000 = 2521000
      expect(filled.budget, BigInt.from(2521000));

      final signed = await b.signTransaction(
        params: SuiSignTransactionParams(signers: [_testAccount()]),
      );
      expect(b.phase, TxBuilderPhase.signed);
      expect(signed.txBytes, isNotEmpty);
      expect(signed.digest, isNotEmpty);

      final finalized = await b.finalizeTransaction();
      expect(b.phase, TxBuilderPhase.finalized);
      expect(finalized.txBytes, signed.txBytes);

      final submitted = await b.submit();
      expect(submitted.response.transaction?.digest, isNotEmpty);
    });

    test('explicit budget skips simulation', () async {
      final sender = SuiAddress(
        '0x0000000000000000000000000000000000000000000000000000000000000001',
      );
      final b = SuiTransactionBuilder(client: _StubClient());
      b.setSender(sender);
      b.moveCall(
        package: SuiAddress(
          '0x0000000000000000000000000000000000000000000000000000000000000002',
        ),
        module: 'm',
        function: 'f',
        arguments: [],
      );
      final filled = await b.fillTransaction(
        params: SuiFillTransactionParams(
          sender: sender,
          budget: BigInt.from(5000000),
          gasPrice: BigInt.from(1000),
        ),
      );
      expect(filled.budget, BigInt.from(5000000));
    });

    test('sponsor sets gas owner', () async {
      final sender = SuiAddress(
        '0x0000000000000000000000000000000000000000000000000000000000000001',
      );
      final sponsor = SuiAddress(
        '0x0000000000000000000000000000000000000000000000000000000000000003',
      );
      final b = SuiTransactionBuilder(client: _StubClient());
      b.setSender(sender);
      b.moveCall(
        package: SuiAddress(
          '0x0000000000000000000000000000000000000000000000000000000000000002',
        ),
        module: 'm',
        function: 'f',
        arguments: [],
      );
      final filled = await b.fillTransaction(
        params: SuiFillTransactionParams(sender: sender, sponsor: sponsor),
      );
      expect(filled.gasOwner, sponsor);
    });
  });
}

void main() {
  OnChainUtilsTestApi.runTest(transactionBuilderTest, "Transaction Builder");
}

