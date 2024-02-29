import 'package:test/test.dart';
import 'package:on_chain/solana/solana.dart';
import '../../examples/wallet.dart';

void main() {
  group("stake program compile v0", () {
    _initialize();
    _delegate();
    _authorize();
    _authorizeWithSeed();
    _split();
    _merge();
    _withdraw();
    _deactivate();
  });
}

void _initialize() {
  test("initialize", () {
    final owner = QuickWalletForTest(index: 406);
    final account1 = QuickWalletForTest(index: 405);
    final account3 = QuickWalletForTest(index: 407);
    final account5 = QuickWalletForTest(index: 408);
    String blockHash = "GWWy2aAev5X3TMRVwdw8W2KMN3dyVrHrQMZukGTf9R1A";
    final program = SystemProgram.createAccount(
        from: owner.address,
        newAccountPubKey: account5.address,
        layout: SystemCreateLayout(
            lamports: SolanaUtils.toLamports("0.1"),
            space: StakeProgramConst.stakeProgramSpace,
            programId: StakeProgramConst.programId));
    final initialize = StakeProgram.initialize(
        layout: StakeInitializeLayout(
            authorized: StakeAuthorized(
                staker: account1.address, withdrawer: account3.address)),
        stakePubkey: account5.address);
    final SolanaTransaction transaction = SolanaTransaction(
        instructions: [program, initialize],
        recentBlockhash: SolAddress.uncheckCurve(blockHash),
        payerKey: owner.address,
        type: TransactionType.v0);

    final unsigned = transaction.serializeMessageString();
    transaction.sign([owner.privateKey, account5.privateKey]);
    final signed = transaction.serializeString(
        encoding: TransactionSerializeEncoding.hex);
    final decodeTransaction =
        SolanaTransaction.deserialize(transaction.serialize());
    expect(decodeTransaction.serialize(), transaction.serialize());
    expect(unsigned,
        "8002000305f6c1dacc8b174b10dac187bb1ee7fed819b77e84591dc1827dc38943a5dbbd765119ea7dac547c8a6eaa56be1d5ecb4c6e70d653a2f41fdf495af32936429205000000000000000000000000000000000000000000000000000000000000000006a1d8179137542a983437bdfe2a7ab2557f535c8a78722b68a49dc00000000006a7d517192c5c51218cc94c3d4af17f58daee089ba1fd44e3dbd98a00000000e66f07ae6ad93c9ea60272507db1a2d2089bbb67540ff6e291f98bcf5df4bc890202020001340000000000e1f50500000000c80000000000000006a1d8179137542a983437bdfe2a7ab2557f535c8a78722b68a49dc0000000000302010474000000003d0427568db5811754651851ae1b5823d52b700fc835078241871ab2b0ca505d554a43a7b8e1a60dac1b800be310f94e55f8fb7415780b78177c3ede1aa0b7ca00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000");
    expect(signed,
        "02fbf44231fb6117eff540bc34fabd8cc506ea040de683d8dd4d4e739fd3e531d7b5b45b69d51f1c062f7310b9ce7fef93ef553a370ee3773bf4b84706713818065b338688a82545045bb89ae66981dd3b1a69d19a7c35f6628ea82cc10467e7db8c6a762c355ddfe02bec89b937ef8644901b583fb475147cae198d8d5af640018002000305f6c1dacc8b174b10dac187bb1ee7fed819b77e84591dc1827dc38943a5dbbd765119ea7dac547c8a6eaa56be1d5ecb4c6e70d653a2f41fdf495af32936429205000000000000000000000000000000000000000000000000000000000000000006a1d8179137542a983437bdfe2a7ab2557f535c8a78722b68a49dc00000000006a7d517192c5c51218cc94c3d4af17f58daee089ba1fd44e3dbd98a00000000e66f07ae6ad93c9ea60272507db1a2d2089bbb67540ff6e291f98bcf5df4bc890202020001340000000000e1f50500000000c80000000000000006a1d8179137542a983437bdfe2a7ab2557f535c8a78722b68a49dc0000000000302010474000000003d0427568db5811754651851ae1b5823d52b700fc835078241871ab2b0ca505d554a43a7b8e1a60dac1b800be310f94e55f8fb7415780b78177c3ede1aa0b7ca00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000");
  });
}

void _delegate() {
  test("delegate", () {
    final owner = QuickWalletForTest(index: 406);
    final account1 = QuickWalletForTest(index: 405);
    final account5 = QuickWalletForTest(index: 408);
    String blockHash = "GWWy2aAev5X3TMRVwdw8W2KMN3dyVrHrQMZukGTf9R1A";

    final initialize = StakeProgram.delegate(
        authorizedPubkey: owner.address,
        votePubkey: account1.address,
        stakePubkey: account5.address);
    final SolanaTransaction transaction = SolanaTransaction(
        instructions: [initialize],
        recentBlockhash: SolAddress.uncheckCurve(blockHash),
        payerKey: owner.address,
        type: TransactionType.v0);

    final unsigned = transaction.serializeMessageString();
    transaction.sign([owner.privateKey]);

    final signed = transaction.serializeString(
        encoding: TransactionSerializeEncoding.hex);
    final decodeTransaction =
        SolanaTransaction.deserialize(transaction.serialize());
    expect(decodeTransaction.serialize(), transaction.serialize());
    expect(unsigned,
        "8001000507f6c1dacc8b174b10dac187bb1ee7fed819b77e84591dc1827dc38943a5dbbd765119ea7dac547c8a6eaa56be1d5ecb4c6e70d653a2f41fdf495af3293642920506a1d8179137542a983437bdfe2a7ab2557f535c8a78722b68a49dc0000000003d0427568db5811754651851ae1b5823d52b700fc835078241871ab2b0ca505d06a7d51718c774c928566398691d5eb68b5eb8a39b4b6d5c73555b210000000006a7d517193584d0feed9bb3431d13206be544281b57b8566cc5375ff400000006a1d817a502050b680791e6ce6db88e1e5b7150f61fc6790a4eb4d100000000e66f07ae6ad93c9ea60272507db1a2d2089bbb67540ff6e291f98bcf5df4bc89010206010304050600040200000000");
    expect(signed,
        "019a55b484c36413d54b56fa2e3862eda13715a5287d6d56c52d50977b62f9f5de309d4a63f153cb3d03d18b5bccbe6d087bbe7fc5f74dba6c772d697c941da50e8001000507f6c1dacc8b174b10dac187bb1ee7fed819b77e84591dc1827dc38943a5dbbd765119ea7dac547c8a6eaa56be1d5ecb4c6e70d653a2f41fdf495af3293642920506a1d8179137542a983437bdfe2a7ab2557f535c8a78722b68a49dc0000000003d0427568db5811754651851ae1b5823d52b700fc835078241871ab2b0ca505d06a7d51718c774c928566398691d5eb68b5eb8a39b4b6d5c73555b210000000006a7d517193584d0feed9bb3431d13206be544281b57b8566cc5375ff400000006a1d817a502050b680791e6ce6db88e1e5b7150f61fc6790a4eb4d100000000e66f07ae6ad93c9ea60272507db1a2d2089bbb67540ff6e291f98bcf5df4bc89010206010304050600040200000000");
  });
}

void _authorize() {
  test("authorize", () {
    final owner = QuickWalletForTest(index: 406);

    final account1 = QuickWalletForTest(index: 405);
    final account3 = QuickWalletForTest(index: 407);
    final account5 = QuickWalletForTest(index: 408);
    String blockHash = "GWWy2aAev5X3TMRVwdw8W2KMN3dyVrHrQMZukGTf9R1A";
    final initialize = StakeProgram.authorize(
        authorizedPubkey: owner.address,
        custodianPubkey: account1.address,
        layout: StakeAuthorizeLayout(
            newAuthorized: account3.address, stakeAuthorizationType: 1),
        stakePubkey: account5.address);
    final SolanaTransaction transaction = SolanaTransaction(
        instructions: [initialize],
        recentBlockhash: SolAddress.uncheckCurve(blockHash),
        payerKey: owner.address,
        type: TransactionType.v0);
    final unsigned = transaction.serializeMessageString();
    transaction.sign([owner.privateKey]);
    final signed = transaction.serializeString(
        encoding: TransactionSerializeEncoding.hex);
    final decodeTransaction =
        SolanaTransaction.deserialize(transaction.serialize());
    expect(decodeTransaction.serialize(), transaction.serialize());
    expect(unsigned,
        "8002010105f6c1dacc8b174b10dac187bb1ee7fed819b77e84591dc1827dc38943a5dbbd763d0427568db5811754651851ae1b5823d52b700fc835078241871ab2b0ca505d5119ea7dac547c8a6eaa56be1d5ecb4c6e70d653a2f41fdf495af3293642920506a7d51718c774c928566398691d5eb68b5eb8a39b4b6d5c73555b210000000006a1d8179137542a983437bdfe2a7ab2557f535c8a78722b68a49dc000000000e66f07ae6ad93c9ea60272507db1a2d2089bbb67540ff6e291f98bcf5df4bc89010404020300012801000000554a43a7b8e1a60dac1b800be310f94e55f8fb7415780b78177c3ede1aa0b7ca0100000000");
    expect(signed,
        "027ae0afc57e5cadc8a5ff60c6c543213bc4132169ddd863e634dc6be962c1493f48960939205fe456b334fad2a07befb5f3fc48fcb2d4a97d74405f81b40d9400000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000008002010105f6c1dacc8b174b10dac187bb1ee7fed819b77e84591dc1827dc38943a5dbbd763d0427568db5811754651851ae1b5823d52b700fc835078241871ab2b0ca505d5119ea7dac547c8a6eaa56be1d5ecb4c6e70d653a2f41fdf495af3293642920506a7d51718c774c928566398691d5eb68b5eb8a39b4b6d5c73555b210000000006a1d8179137542a983437bdfe2a7ab2557f535c8a78722b68a49dc000000000e66f07ae6ad93c9ea60272507db1a2d2089bbb67540ff6e291f98bcf5df4bc89010404020300012801000000554a43a7b8e1a60dac1b800be310f94e55f8fb7415780b78177c3ede1aa0b7ca0100000000");
  });
}

void _authorizeWithSeed() {
  test("authorizeWithSeed", () {
    final owner = QuickWalletForTest(index: 406);

    final account1 = QuickWalletForTest(index: 405);
    final account3 = QuickWalletForTest(index: 407);
    final account5 = QuickWalletForTest(index: 408);

    String blockHash = "GWWy2aAev5X3TMRVwdw8W2KMN3dyVrHrQMZukGTf9R1A";
    final initialize = StakeProgram.authorizeWithSeed(
        authorityBase: owner.address,
        custodianPubkey: account1.address,
        layout: StakeAuthorizeWithSeedLayout(
            newAuthorized: account3.address,
            stakeAuthorizationType: 1,
            authoritySeed: "account1",
            authorityOwner: owner.address),
        stakePubkey: account5.address);
    final SolanaTransaction transaction = SolanaTransaction(
        instructions: [initialize],
        recentBlockhash: SolAddress.uncheckCurve(blockHash),
        payerKey: owner.address,
        type: TransactionType.v0);

    final unsigned = transaction.serializeMessageString();
    transaction.sign([owner.privateKey, account1.privateKey]);
    final signed = transaction.serializeString(
        encoding: TransactionSerializeEncoding.hex);
    final decodeTransaction =
        SolanaTransaction.deserialize(transaction.serialize());
    expect(decodeTransaction.serialize(), transaction.serialize());
    expect(unsigned,
        "8002010205f6c1dacc8b174b10dac187bb1ee7fed819b77e84591dc1827dc38943a5dbbd763d0427568db5811754651851ae1b5823d52b700fc835078241871ab2b0ca505d5119ea7dac547c8a6eaa56be1d5ecb4c6e70d653a2f41fdf495af3293642920506a1d8179137542a983437bdfe2a7ab2557f535c8a78722b68a49dc00000000006a7d51718c774c928566398691d5eb68b5eb8a39b4b6d5c73555b2100000000e66f07ae6ad93c9ea60272507db1a2d2089bbb67540ff6e291f98bcf5df4bc89010304020004015808000000554a43a7b8e1a60dac1b800be310f94e55f8fb7415780b78177c3ede1aa0b7ca0100000008000000000000006163636f756e7431f6c1dacc8b174b10dac187bb1ee7fed819b77e84591dc1827dc38943a5dbbd7600");
    expect(signed,
        "021499d1db629e7296c4f838680548c1448ba5600fc7e1a004ab16d12f226471e9520bfde36da87f90f583cf5dd7d86e5946a9915566424db527710c68fef42c05fb862e75211ad22c51fc975ffebc7e724c44bc2d581bc8ec46407adb699ef523d2290cb9695d24bf1ce5b2fd8bfb7b38c22fea48d213e551e696444260d6df0f8002010205f6c1dacc8b174b10dac187bb1ee7fed819b77e84591dc1827dc38943a5dbbd763d0427568db5811754651851ae1b5823d52b700fc835078241871ab2b0ca505d5119ea7dac547c8a6eaa56be1d5ecb4c6e70d653a2f41fdf495af3293642920506a1d8179137542a983437bdfe2a7ab2557f535c8a78722b68a49dc00000000006a7d51718c774c928566398691d5eb68b5eb8a39b4b6d5c73555b2100000000e66f07ae6ad93c9ea60272507db1a2d2089bbb67540ff6e291f98bcf5df4bc89010304020004015808000000554a43a7b8e1a60dac1b800be310f94e55f8fb7415780b78177c3ede1aa0b7ca0100000008000000000000006163636f756e7431f6c1dacc8b174b10dac187bb1ee7fed819b77e84591dc1827dc38943a5dbbd7600");
  });
}

void _split() {
  test("split", () {
    final owner = QuickWalletForTest(index: 406);
    final account5 = QuickWalletForTest(index: 408);
    final account6 = QuickWalletForTest(index: 410);
    String blockHash = "GWWy2aAev5X3TMRVwdw8W2KMN3dyVrHrQMZukGTf9R1A";

    final createAccount = SystemProgram.createAccount(
        from: owner.address,
        newAccountPubKey: account6.address,
        layout: SystemCreateLayout(
            lamports: BigInt.zero,
            programId: StakeProgramConst.programId,
            space: StakeProgramConst.stakeProgramSpace));

    final initialize = StakeProgram.split(
        authorizedPubkey: owner.address,
        splitStakePubkey: account6.address,
        layout: StakeSplitLayout(lamports: SolanaUtils.toLamports("0.1")),
        stakePubkey: account5.address);
    final SolanaTransaction transaction = SolanaTransaction(
        instructions: [createAccount, initialize],
        recentBlockhash: SolAddress.uncheckCurve(blockHash),
        payerKey: owner.address,
        type: TransactionType.v0);

    final unsigned = transaction.serializeMessageString();
    transaction.sign([owner.privateKey, account6.privateKey]);
    final signed = transaction.serializeString(
        encoding: TransactionSerializeEncoding.hex);
    final decodeTransaction =
        SolanaTransaction.deserialize(transaction.serialize());
    expect(decodeTransaction.serialize(), transaction.serialize());
    expect(unsigned,
        "8002000205f6c1dacc8b174b10dac187bb1ee7fed819b77e84591dc1827dc38943a5dbbd76ed4b474820db73c8c296fccf275489da999d74ced22bd13a1cfa8b787857e9b35119ea7dac547c8a6eaa56be1d5ecb4c6e70d653a2f41fdf495af32936429205000000000000000000000000000000000000000000000000000000000000000006a1d8179137542a983437bdfe2a7ab2557f535c8a78722b68a49dc000000000e66f07ae6ad93c9ea60272507db1a2d2089bbb67540ff6e291f98bcf5df4bc89020302000134000000000000000000000000c80000000000000006a1d8179137542a983437bdfe2a7ab2557f535c8a78722b68a49dc00000000004030201000c0300000000e1f5050000000000");
    expect(signed,
        "02a5856bb937a9941a033f1f7c509896f6815433ab70c76a5f2e5ceefec42bd0625f6a04aa3468c1b582e23e535a121e0a7e9ffd0add3c35ddc4c98c8230bd39071ce1a414a0474d56610098fc3d91b51e68c56594419f5d0e2d98f118009dbde66a76f3ebedd884c383023fa8c0e92cad9172871e842b7ac4cdf8470468de5e038002000205f6c1dacc8b174b10dac187bb1ee7fed819b77e84591dc1827dc38943a5dbbd76ed4b474820db73c8c296fccf275489da999d74ced22bd13a1cfa8b787857e9b35119ea7dac547c8a6eaa56be1d5ecb4c6e70d653a2f41fdf495af32936429205000000000000000000000000000000000000000000000000000000000000000006a1d8179137542a983437bdfe2a7ab2557f535c8a78722b68a49dc000000000e66f07ae6ad93c9ea60272507db1a2d2089bbb67540ff6e291f98bcf5df4bc89020302000134000000000000000000000000c80000000000000006a1d8179137542a983437bdfe2a7ab2557f535c8a78722b68a49dc00000000004030201000c0300000000e1f5050000000000");
  });
}

void _merge() {
  test("merge", () {
    final owner = QuickWalletForTest(index: 406);
    final account5 = QuickWalletForTest(index: 408);
    final account6 = QuickWalletForTest(index: 410);
    String blockHash = "GWWy2aAev5X3TMRVwdw8W2KMN3dyVrHrQMZukGTf9R1A";

    final initialize = StakeProgram.merge(
        authorizedPubkey: owner.address,
        sourceStakePubKey: account6.address,
        stakePubkey: account5.address);
    final SolanaTransaction transaction = SolanaTransaction(
        instructions: [initialize],
        recentBlockhash: SolAddress.uncheckCurve(blockHash),
        payerKey: owner.address,
        type: TransactionType.v0);

    final unsigned = transaction.serializeMessageString();
    transaction.sign([owner.privateKey]);

    final signed = transaction.serializeString(
        encoding: TransactionSerializeEncoding.hex);
    final decodeTransaction =
        SolanaTransaction.deserialize(transaction.serialize());
    expect(decodeTransaction.serialize(), transaction.serialize());
    expect(unsigned,
        "8001000306f6c1dacc8b174b10dac187bb1ee7fed819b77e84591dc1827dc38943a5dbbd765119ea7dac547c8a6eaa56be1d5ecb4c6e70d653a2f41fdf495af32936429205ed4b474820db73c8c296fccf275489da999d74ced22bd13a1cfa8b787857e9b306a1d8179137542a983437bdfe2a7ab2557f535c8a78722b68a49dc00000000006a7d51718c774c928566398691d5eb68b5eb8a39b4b6d5c73555b210000000006a7d517193584d0feed9bb3431d13206be544281b57b8566cc5375ff4000000e66f07ae6ad93c9ea60272507db1a2d2089bbb67540ff6e291f98bcf5df4bc890103050102040500040700000000");
    expect(signed,
        "01e851f88686e8cc816ee4f4ffbc45ce2e503825f5fe28c4fe3680f615a0cd6472c757341b67ed640409ee78a6f19bf02c8ee03f66a5bb744196a75f3826f92f0d8001000306f6c1dacc8b174b10dac187bb1ee7fed819b77e84591dc1827dc38943a5dbbd765119ea7dac547c8a6eaa56be1d5ecb4c6e70d653a2f41fdf495af32936429205ed4b474820db73c8c296fccf275489da999d74ced22bd13a1cfa8b787857e9b306a1d8179137542a983437bdfe2a7ab2557f535c8a78722b68a49dc00000000006a7d51718c774c928566398691d5eb68b5eb8a39b4b6d5c73555b210000000006a7d517193584d0feed9bb3431d13206be544281b57b8566cc5375ff4000000e66f07ae6ad93c9ea60272507db1a2d2089bbb67540ff6e291f98bcf5df4bc890103050102040500040700000000");
  });
}

void _withdraw() {
  test("withdraw", () {
    final owner = QuickWalletForTest(index: 406);
    final account5 = QuickWalletForTest(index: 408);
    final account6 = QuickWalletForTest(index: 410);
    String blockHash = "GWWy2aAev5X3TMRVwdw8W2KMN3dyVrHrQMZukGTf9R1A";
    final initialize = StakeProgram.withdraw(
        authorizedPubkey: owner.address,
        toPubkey: account6.address,
        layout: StakeWithdrawLayout(lamports: BigInt.from(1000000)),
        stakePubkey: account5.address);
    final SolanaTransaction transaction = SolanaTransaction(
        instructions: [initialize],
        recentBlockhash: SolAddress.uncheckCurve(blockHash),
        payerKey: owner.address,
        type: TransactionType.v0);
    final unsigned = transaction.serializeMessageString();
    transaction.sign([owner.privateKey]);
    final signed = transaction.serializeString(
        encoding: TransactionSerializeEncoding.hex);
    final decodeTransaction =
        SolanaTransaction.deserialize(transaction.serialize());
    expect(decodeTransaction.serialize(), transaction.serialize());
    expect(unsigned,
        "8001000306f6c1dacc8b174b10dac187bb1ee7fed819b77e84591dc1827dc38943a5dbbd765119ea7dac547c8a6eaa56be1d5ecb4c6e70d653a2f41fdf495af32936429205ed4b474820db73c8c296fccf275489da999d74ced22bd13a1cfa8b787857e9b306a1d8179137542a983437bdfe2a7ab2557f535c8a78722b68a49dc00000000006a7d51718c774c928566398691d5eb68b5eb8a39b4b6d5c73555b210000000006a7d517193584d0feed9bb3431d13206be544281b57b8566cc5375ff4000000e66f07ae6ad93c9ea60272507db1a2d2089bbb67540ff6e291f98bcf5df4bc8901030501020405000c0400000040420f000000000000");
    expect(signed,
        "01978444a62321a275998e230d16797325fcc8cc9ef0dc523dd0d4d1c449ba66cca1f635fcd67741abe50f00cae4acc0d6b68f8933f06c53d4559770237a36c2048001000306f6c1dacc8b174b10dac187bb1ee7fed819b77e84591dc1827dc38943a5dbbd765119ea7dac547c8a6eaa56be1d5ecb4c6e70d653a2f41fdf495af32936429205ed4b474820db73c8c296fccf275489da999d74ced22bd13a1cfa8b787857e9b306a1d8179137542a983437bdfe2a7ab2557f535c8a78722b68a49dc00000000006a7d51718c774c928566398691d5eb68b5eb8a39b4b6d5c73555b210000000006a7d517193584d0feed9bb3431d13206be544281b57b8566cc5375ff4000000e66f07ae6ad93c9ea60272507db1a2d2089bbb67540ff6e291f98bcf5df4bc8901030501020405000c0400000040420f000000000000");
  });
}

void _deactivate() {
  test("deactivate", () {
    final owner = QuickWalletForTest(index: 406);

    final account5 = QuickWalletForTest(index: 408);
    String blockHash = "GWWy2aAev5X3TMRVwdw8W2KMN3dyVrHrQMZukGTf9R1A";

    final initialize = StakeProgram.deactivate(
        authorizedPubkey: owner.address, stakePubkey: account5.address);
    final SolanaTransaction transaction = SolanaTransaction(
        instructions: [initialize],
        recentBlockhash: SolAddress.uncheckCurve(blockHash),
        payerKey: owner.address,
        type: TransactionType.v0);
    final unsigned = transaction.serializeMessageString();
    transaction.sign([owner.privateKey]);
    final signed = transaction.serializeString(
        encoding: TransactionSerializeEncoding.hex);
    final decodeTransaction =
        SolanaTransaction.deserialize(transaction.serialize());
    expect(decodeTransaction.serialize(), transaction.serialize());
    expect(unsigned,
        "8001000204f6c1dacc8b174b10dac187bb1ee7fed819b77e84591dc1827dc38943a5dbbd765119ea7dac547c8a6eaa56be1d5ecb4c6e70d653a2f41fdf495af3293642920506a1d8179137542a983437bdfe2a7ab2557f535c8a78722b68a49dc00000000006a7d51718c774c928566398691d5eb68b5eb8a39b4b6d5c73555b2100000000e66f07ae6ad93c9ea60272507db1a2d2089bbb67540ff6e291f98bcf5df4bc89010203010300040500000000");
    expect(signed,
        "019b1b5d5e3bc77b4374536bc93074e16231c29afcf538ddf19d04e1dfc2a1417329c28a66a22e29ca7dd3070777e7de15033036129a5b2554f6423580c87406038001000204f6c1dacc8b174b10dac187bb1ee7fed819b77e84591dc1827dc38943a5dbbd765119ea7dac547c8a6eaa56be1d5ecb4c6e70d653a2f41fdf495af3293642920506a1d8179137542a983437bdfe2a7ab2557f535c8a78722b68a49dc00000000006a7d51718c774c928566398691d5eb68b5eb8a39b4b6d5c73555b2100000000e66f07ae6ad93c9ea60272507db1a2d2089bbb67540ff6e291f98bcf5df4bc89010203010300040500000000");
  });
}
