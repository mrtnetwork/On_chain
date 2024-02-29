import 'package:test/test.dart';
import 'package:on_chain/solana/solana.dart';
import '../../examples/wallet.dart';

void main() {
  group("stake program compile legacy", () {
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
        type: TransactionType.legacy);

    final unsigned = transaction.serializeMessageString();
    transaction.sign([owner.privateKey, account5.privateKey]);
    final signed =
        transaction.serializeString(encoding: TransactionSerializeEncoding.hex);
    final decodeTransaction =
        SolanaTransaction.deserialize(transaction.serialize());
    expect(decodeTransaction.serialize(), transaction.serialize());
    expect(unsigned,
        "02000305f6c1dacc8b174b10dac187bb1ee7fed819b77e84591dc1827dc38943a5dbbd765119ea7dac547c8a6eaa56be1d5ecb4c6e70d653a2f41fdf495af32936429205000000000000000000000000000000000000000000000000000000000000000006a1d8179137542a983437bdfe2a7ab2557f535c8a78722b68a49dc00000000006a7d517192c5c51218cc94c3d4af17f58daee089ba1fd44e3dbd98a00000000e66f07ae6ad93c9ea60272507db1a2d2089bbb67540ff6e291f98bcf5df4bc890202020001340000000000e1f50500000000c80000000000000006a1d8179137542a983437bdfe2a7ab2557f535c8a78722b68a49dc0000000000302010474000000003d0427568db5811754651851ae1b5823d52b700fc835078241871ab2b0ca505d554a43a7b8e1a60dac1b800be310f94e55f8fb7415780b78177c3ede1aa0b7ca000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000");
    expect(signed,
        "020ec91ea144f8d2ca75bf74aec82de68012413fd4321a9c418577b97e1f65183be665d74cf53605308055bb9d9b742b5ff863ac9fed8021b62495396c7e9b350cc84c62facd17aa0dd84c86e48f92fc8b847f9b63fb5298a129606dfb4265215cd512f8693a04fd863554ebf665cc424aa2efef82eeaaf6cddf80b1bcbae2ce0802000305f6c1dacc8b174b10dac187bb1ee7fed819b77e84591dc1827dc38943a5dbbd765119ea7dac547c8a6eaa56be1d5ecb4c6e70d653a2f41fdf495af32936429205000000000000000000000000000000000000000000000000000000000000000006a1d8179137542a983437bdfe2a7ab2557f535c8a78722b68a49dc00000000006a7d517192c5c51218cc94c3d4af17f58daee089ba1fd44e3dbd98a00000000e66f07ae6ad93c9ea60272507db1a2d2089bbb67540ff6e291f98bcf5df4bc890202020001340000000000e1f50500000000c80000000000000006a1d8179137542a983437bdfe2a7ab2557f535c8a78722b68a49dc0000000000302010474000000003d0427568db5811754651851ae1b5823d52b700fc835078241871ab2b0ca505d554a43a7b8e1a60dac1b800be310f94e55f8fb7415780b78177c3ede1aa0b7ca000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000");
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
        type: TransactionType.legacy);

    final unsigned = transaction.serializeMessageString();
    transaction.sign([owner.privateKey]);

    final signed =
        transaction.serializeString(encoding: TransactionSerializeEncoding.hex);
    final decodeTransaction =
        SolanaTransaction.deserialize(transaction.serialize());
    expect(decodeTransaction.serialize(), transaction.serialize());
    expect(unsigned,
        "01000507f6c1dacc8b174b10dac187bb1ee7fed819b77e84591dc1827dc38943a5dbbd765119ea7dac547c8a6eaa56be1d5ecb4c6e70d653a2f41fdf495af3293642920506a1d8179137542a983437bdfe2a7ab2557f535c8a78722b68a49dc0000000003d0427568db5811754651851ae1b5823d52b700fc835078241871ab2b0ca505d06a7d51718c774c928566398691d5eb68b5eb8a39b4b6d5c73555b210000000006a7d517193584d0feed9bb3431d13206be544281b57b8566cc5375ff400000006a1d817a502050b680791e6ce6db88e1e5b7150f61fc6790a4eb4d100000000e66f07ae6ad93c9ea60272507db1a2d2089bbb67540ff6e291f98bcf5df4bc890102060103040506000402000000");
    expect(signed,
        "01b7efde56c77250912ab0ad0a51fc24bfb1a6bbd4235cef2b661f944f059c50612bee23864562cc457ab6f66e3a214c2cf4a5231c7f30ae57274bf6b35f2c240401000507f6c1dacc8b174b10dac187bb1ee7fed819b77e84591dc1827dc38943a5dbbd765119ea7dac547c8a6eaa56be1d5ecb4c6e70d653a2f41fdf495af3293642920506a1d8179137542a983437bdfe2a7ab2557f535c8a78722b68a49dc0000000003d0427568db5811754651851ae1b5823d52b700fc835078241871ab2b0ca505d06a7d51718c774c928566398691d5eb68b5eb8a39b4b6d5c73555b210000000006a7d517193584d0feed9bb3431d13206be544281b57b8566cc5375ff400000006a1d817a502050b680791e6ce6db88e1e5b7150f61fc6790a4eb4d100000000e66f07ae6ad93c9ea60272507db1a2d2089bbb67540ff6e291f98bcf5df4bc890102060103040506000402000000");
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
        type: TransactionType.legacy);
    final unsigned = transaction.serializeMessageString();
    transaction.sign([owner.privateKey]);
    final signed =
        transaction.serializeString(encoding: TransactionSerializeEncoding.hex);
    final decodeTransaction =
        SolanaTransaction.deserialize(transaction.serialize());
    expect(decodeTransaction.serialize(), transaction.serialize());
    expect(unsigned,
        "02010105f6c1dacc8b174b10dac187bb1ee7fed819b77e84591dc1827dc38943a5dbbd763d0427568db5811754651851ae1b5823d52b700fc835078241871ab2b0ca505d5119ea7dac547c8a6eaa56be1d5ecb4c6e70d653a2f41fdf495af3293642920506a7d51718c774c928566398691d5eb68b5eb8a39b4b6d5c73555b210000000006a1d8179137542a983437bdfe2a7ab2557f535c8a78722b68a49dc000000000e66f07ae6ad93c9ea60272507db1a2d2089bbb67540ff6e291f98bcf5df4bc89010404020300012801000000554a43a7b8e1a60dac1b800be310f94e55f8fb7415780b78177c3ede1aa0b7ca01000000");
    expect(signed,
        "024ed75dce0d25d29f63ded139325a7ec2a001b9d2a3a6d92c1e118db629549c9de12bd9576d04b350b44427af1439b92a1d2463bcdc802531c92fc1dcb883250f0000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000002010105f6c1dacc8b174b10dac187bb1ee7fed819b77e84591dc1827dc38943a5dbbd763d0427568db5811754651851ae1b5823d52b700fc835078241871ab2b0ca505d5119ea7dac547c8a6eaa56be1d5ecb4c6e70d653a2f41fdf495af3293642920506a7d51718c774c928566398691d5eb68b5eb8a39b4b6d5c73555b210000000006a1d8179137542a983437bdfe2a7ab2557f535c8a78722b68a49dc000000000e66f07ae6ad93c9ea60272507db1a2d2089bbb67540ff6e291f98bcf5df4bc89010404020300012801000000554a43a7b8e1a60dac1b800be310f94e55f8fb7415780b78177c3ede1aa0b7ca01000000");
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
        type: TransactionType.legacy);

    final unsigned = transaction.serializeMessageString();
    transaction.sign([owner.privateKey, account1.privateKey]);
    final signed =
        transaction.serializeString(encoding: TransactionSerializeEncoding.hex);
    final decodeTransaction =
        SolanaTransaction.deserialize(transaction.serialize());
    expect(decodeTransaction.serialize(), transaction.serialize());
    expect(unsigned,
        "02010205f6c1dacc8b174b10dac187bb1ee7fed819b77e84591dc1827dc38943a5dbbd763d0427568db5811754651851ae1b5823d52b700fc835078241871ab2b0ca505d5119ea7dac547c8a6eaa56be1d5ecb4c6e70d653a2f41fdf495af3293642920506a1d8179137542a983437bdfe2a7ab2557f535c8a78722b68a49dc00000000006a7d51718c774c928566398691d5eb68b5eb8a39b4b6d5c73555b2100000000e66f07ae6ad93c9ea60272507db1a2d2089bbb67540ff6e291f98bcf5df4bc89010304020004015808000000554a43a7b8e1a60dac1b800be310f94e55f8fb7415780b78177c3ede1aa0b7ca0100000008000000000000006163636f756e7431f6c1dacc8b174b10dac187bb1ee7fed819b77e84591dc1827dc38943a5dbbd76");
    expect(signed,
        "02e25e826c81eb224f65c9cc92350b3bd2400681ff3c6bcad7fdc5c8fa3bbc9e9b8090a5a2cd3b8e7fe2c6f19eef464b4f418780e36543656da8c9a5d61973230ccb8325ecdfd253f2757f0dba7d0fc5217fbcf4879679e833c3382d1a2b8612b3abd606c01d5a8da1d0ca2314605b48c80ef1ebd667c9a6ec5f59493a9974a00402010205f6c1dacc8b174b10dac187bb1ee7fed819b77e84591dc1827dc38943a5dbbd763d0427568db5811754651851ae1b5823d52b700fc835078241871ab2b0ca505d5119ea7dac547c8a6eaa56be1d5ecb4c6e70d653a2f41fdf495af3293642920506a1d8179137542a983437bdfe2a7ab2557f535c8a78722b68a49dc00000000006a7d51718c774c928566398691d5eb68b5eb8a39b4b6d5c73555b2100000000e66f07ae6ad93c9ea60272507db1a2d2089bbb67540ff6e291f98bcf5df4bc89010304020004015808000000554a43a7b8e1a60dac1b800be310f94e55f8fb7415780b78177c3ede1aa0b7ca0100000008000000000000006163636f756e7431f6c1dacc8b174b10dac187bb1ee7fed819b77e84591dc1827dc38943a5dbbd76");
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
        type: TransactionType.legacy);

    final unsigned = transaction.serializeMessageString();
    transaction.sign([owner.privateKey, account6.privateKey]);
    final signed =
        transaction.serializeString(encoding: TransactionSerializeEncoding.hex);
    final decodeTransaction =
        SolanaTransaction.deserialize(transaction.serialize());
    expect(decodeTransaction.serialize(), transaction.serialize());
    expect(unsigned,
        "02000205f6c1dacc8b174b10dac187bb1ee7fed819b77e84591dc1827dc38943a5dbbd76ed4b474820db73c8c296fccf275489da999d74ced22bd13a1cfa8b787857e9b35119ea7dac547c8a6eaa56be1d5ecb4c6e70d653a2f41fdf495af32936429205000000000000000000000000000000000000000000000000000000000000000006a1d8179137542a983437bdfe2a7ab2557f535c8a78722b68a49dc000000000e66f07ae6ad93c9ea60272507db1a2d2089bbb67540ff6e291f98bcf5df4bc89020302000134000000000000000000000000c80000000000000006a1d8179137542a983437bdfe2a7ab2557f535c8a78722b68a49dc00000000004030201000c0300000000e1f50500000000");
    expect(signed,
        "02276635328351964b63357fc8c1e8c2b8217b34b98acca67e8e9910187de30f2f989f51217d7f44f25b416369151faf79757ed5ee831bec8ab018c40854a65c0fcf2db180e179d217a2c4e216683ba653afa55998f8249a866a4ebf3a0b9d5834d87231c52339b8dc34a5b714fdb31e2c5cde338e58f387b1ad145a6bcdb95a0502000205f6c1dacc8b174b10dac187bb1ee7fed819b77e84591dc1827dc38943a5dbbd76ed4b474820db73c8c296fccf275489da999d74ced22bd13a1cfa8b787857e9b35119ea7dac547c8a6eaa56be1d5ecb4c6e70d653a2f41fdf495af32936429205000000000000000000000000000000000000000000000000000000000000000006a1d8179137542a983437bdfe2a7ab2557f535c8a78722b68a49dc000000000e66f07ae6ad93c9ea60272507db1a2d2089bbb67540ff6e291f98bcf5df4bc89020302000134000000000000000000000000c80000000000000006a1d8179137542a983437bdfe2a7ab2557f535c8a78722b68a49dc00000000004030201000c0300000000e1f50500000000");
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
        type: TransactionType.legacy);

    final unsigned = transaction.serializeMessageString();
    transaction.sign([owner.privateKey]);

    final signed =
        transaction.serializeString(encoding: TransactionSerializeEncoding.hex);
    final decodeTransaction =
        SolanaTransaction.deserialize(transaction.serialize());
    expect(decodeTransaction.serialize(), transaction.serialize());
    expect(unsigned,
        "01000306f6c1dacc8b174b10dac187bb1ee7fed819b77e84591dc1827dc38943a5dbbd765119ea7dac547c8a6eaa56be1d5ecb4c6e70d653a2f41fdf495af32936429205ed4b474820db73c8c296fccf275489da999d74ced22bd13a1cfa8b787857e9b306a1d8179137542a983437bdfe2a7ab2557f535c8a78722b68a49dc00000000006a7d51718c774c928566398691d5eb68b5eb8a39b4b6d5c73555b210000000006a7d517193584d0feed9bb3431d13206be544281b57b8566cc5375ff4000000e66f07ae6ad93c9ea60272507db1a2d2089bbb67540ff6e291f98bcf5df4bc8901030501020405000407000000");
    expect(signed,
        "0189bcebf9eaa533d7bef1b93e181c77e144f099fec2abac62305e7119d4eecdd5c815867379f033e5e37c5a71bbaa1bfecc23a1aab56e63926a9d5fa000ba970601000306f6c1dacc8b174b10dac187bb1ee7fed819b77e84591dc1827dc38943a5dbbd765119ea7dac547c8a6eaa56be1d5ecb4c6e70d653a2f41fdf495af32936429205ed4b474820db73c8c296fccf275489da999d74ced22bd13a1cfa8b787857e9b306a1d8179137542a983437bdfe2a7ab2557f535c8a78722b68a49dc00000000006a7d51718c774c928566398691d5eb68b5eb8a39b4b6d5c73555b210000000006a7d517193584d0feed9bb3431d13206be544281b57b8566cc5375ff4000000e66f07ae6ad93c9ea60272507db1a2d2089bbb67540ff6e291f98bcf5df4bc8901030501020405000407000000");
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
        type: TransactionType.legacy);
    final unsigned = transaction.serializeMessageString();
    transaction.sign([owner.privateKey]);
    final signed =
        transaction.serializeString(encoding: TransactionSerializeEncoding.hex);
    final decodeTransaction =
        SolanaTransaction.deserialize(transaction.serialize());
    expect(decodeTransaction.serialize(), transaction.serialize());
    expect(unsigned,
        "01000306f6c1dacc8b174b10dac187bb1ee7fed819b77e84591dc1827dc38943a5dbbd765119ea7dac547c8a6eaa56be1d5ecb4c6e70d653a2f41fdf495af32936429205ed4b474820db73c8c296fccf275489da999d74ced22bd13a1cfa8b787857e9b306a1d8179137542a983437bdfe2a7ab2557f535c8a78722b68a49dc00000000006a7d51718c774c928566398691d5eb68b5eb8a39b4b6d5c73555b210000000006a7d517193584d0feed9bb3431d13206be544281b57b8566cc5375ff4000000e66f07ae6ad93c9ea60272507db1a2d2089bbb67540ff6e291f98bcf5df4bc8901030501020405000c0400000040420f0000000000");
    expect(signed,
        "0121e0cf0f6b587707758f0fccad08a04d94d00ca68b23b6d019199c116c3f6bdabd808f8b5403243ba7eaa9a69a1bd7706a9fe75304235732feb6b3284fece40d01000306f6c1dacc8b174b10dac187bb1ee7fed819b77e84591dc1827dc38943a5dbbd765119ea7dac547c8a6eaa56be1d5ecb4c6e70d653a2f41fdf495af32936429205ed4b474820db73c8c296fccf275489da999d74ced22bd13a1cfa8b787857e9b306a1d8179137542a983437bdfe2a7ab2557f535c8a78722b68a49dc00000000006a7d51718c774c928566398691d5eb68b5eb8a39b4b6d5c73555b210000000006a7d517193584d0feed9bb3431d13206be544281b57b8566cc5375ff4000000e66f07ae6ad93c9ea60272507db1a2d2089bbb67540ff6e291f98bcf5df4bc8901030501020405000c0400000040420f0000000000");
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
        type: TransactionType.legacy);
    final unsigned = transaction.serializeMessageString();
    transaction.sign([owner.privateKey]);
    final signed =
        transaction.serializeString(encoding: TransactionSerializeEncoding.hex);
    final decodeTransaction =
        SolanaTransaction.deserialize(transaction.serialize());
    expect(decodeTransaction.serialize(), transaction.serialize());
    expect(unsigned,
        "01000204f6c1dacc8b174b10dac187bb1ee7fed819b77e84591dc1827dc38943a5dbbd765119ea7dac547c8a6eaa56be1d5ecb4c6e70d653a2f41fdf495af3293642920506a1d8179137542a983437bdfe2a7ab2557f535c8a78722b68a49dc00000000006a7d51718c774c928566398691d5eb68b5eb8a39b4b6d5c73555b2100000000e66f07ae6ad93c9ea60272507db1a2d2089bbb67540ff6e291f98bcf5df4bc890102030103000405000000");
    expect(signed,
        "018c1a382abe683a101b181ba5e0fe2a94d440357dbf783c04bdcd5cb4dba86d1e67183f098c32e9fb590f6afaf6255135280fd12d164458db95ac35eed10df00c01000204f6c1dacc8b174b10dac187bb1ee7fed819b77e84591dc1827dc38943a5dbbd765119ea7dac547c8a6eaa56be1d5ecb4c6e70d653a2f41fdf495af3293642920506a1d8179137542a983437bdfe2a7ab2557f535c8a78722b68a49dc00000000006a7d51718c774c928566398691d5eb68b5eb8a39b4b6d5c73555b2100000000e66f07ae6ad93c9ea60272507db1a2d2089bbb67540ff6e291f98bcf5df4bc890102030103000405000000");
  });
}
