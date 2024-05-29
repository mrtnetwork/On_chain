import 'package:test/test.dart';
import 'package:on_chain/solana/solana.dart';
import '../../examples/wallet.dart';

void main() {
  group("vote compile legacy", () {
    _initializeAccount();
    _authorize();
    _authorizeWithSeed();
    _withdraw();
  });
}

void _initializeAccount() {
  test("initializeAccount", () {
    final owner = QuickWalletForTest(index: 406);
    final account1 = QuickWalletForTest(index: 405);
    const blockHash = "GWWy2aAev5X3TMRVwdw8W2KMN3dyVrHrQMZukGTf9R1A";
    final layout = VoteProgramInitializeAccountLayout(
        authorizedVoter: account1.address,
        authorizedWithdrawer: account1.address,
        commission: 1,
        nodePubkey: owner.address);

    final program = VoteProgram.initializeAccount(
        nodePubKey: owner.address,
        votePubKey: account1.address,
        layout: layout);

    final SolanaTransaction transaction = SolanaTransaction(
        instructions: [program],
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
        "01000305f6c1dacc8b174b10dac187bb1ee7fed819b77e84591dc1827dc38943a5dbbd763d0427568db5811754651851ae1b5823d52b700fc835078241871ab2b0ca505d0761481d357474bb7c4d7624ebd3bdb3d8355e73d11043fc0da353800000000006a7d517192c5c51218cc94c3d4af17f58daee089ba1fd44e3dbd98a0000000006a7d51718c774c928566398691d5eb68b5eb8a39b4b6d5c73555b2100000000e66f07ae6ad93c9ea60272507db1a2d2089bbb67540ff6e291f98bcf5df4bc89010204010304006500000000f6c1dacc8b174b10dac187bb1ee7fed819b77e84591dc1827dc38943a5dbbd763d0427568db5811754651851ae1b5823d52b700fc835078241871ab2b0ca505d3d0427568db5811754651851ae1b5823d52b700fc835078241871ab2b0ca505d01");
    expect(signed,
        "01f41df50f4b9fdc90f58c1fbad2c555f60b8f91704699588ed1c4b4548fb0662d785ffffa99297f563ba85c700e3c72029f431b53f583767353b6e8f6d01a2f0301000305f6c1dacc8b174b10dac187bb1ee7fed819b77e84591dc1827dc38943a5dbbd763d0427568db5811754651851ae1b5823d52b700fc835078241871ab2b0ca505d0761481d357474bb7c4d7624ebd3bdb3d8355e73d11043fc0da353800000000006a7d517192c5c51218cc94c3d4af17f58daee089ba1fd44e3dbd98a0000000006a7d51718c774c928566398691d5eb68b5eb8a39b4b6d5c73555b2100000000e66f07ae6ad93c9ea60272507db1a2d2089bbb67540ff6e291f98bcf5df4bc89010204010304006500000000f6c1dacc8b174b10dac187bb1ee7fed819b77e84591dc1827dc38943a5dbbd763d0427568db5811754651851ae1b5823d52b700fc835078241871ab2b0ca505d3d0427568db5811754651851ae1b5823d52b700fc835078241871ab2b0ca505d01");
  });
}

void _authorize() {
  test("authorize", () {
    final owner = QuickWalletForTest(index: 406);
    final account1 = QuickWalletForTest(index: 405);
    const blockHash = "GWWy2aAev5X3TMRVwdw8W2KMN3dyVrHrQMZukGTf9R1A";
    final layout = VoteProgramAuthorizeLayout(
        newAuthorized: account1.address, voteAuthorizationType: 1);
    final program = VoteProgram.authorize(
        authorizedPubkey: account1.address,
        votePubkey: owner.address,
        layout: layout);

    final SolanaTransaction transaction = SolanaTransaction(
        instructions: [program],
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
        "02010204f6c1dacc8b174b10dac187bb1ee7fed819b77e84591dc1827dc38943a5dbbd763d0427568db5811754651851ae1b5823d52b700fc835078241871ab2b0ca505d0761481d357474bb7c4d7624ebd3bdb3d8355e73d11043fc0da353800000000006a7d51718c774c928566398691d5eb68b5eb8a39b4b6d5c73555b2100000000e66f07ae6ad93c9ea60272507db1a2d2089bbb67540ff6e291f98bcf5df4bc8901020300030128010000003d0427568db5811754651851ae1b5823d52b700fc835078241871ab2b0ca505d01000000");
    expect(signed,
        "02f4d756812fdd8e16d6719eaac1a5795c12c899f06f5439a726bda8487e94a6e3cedb19a39aa3ff42ee3811411d3564cac11fa108a946b1d40f9b0faadf4bd0080000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000002010204f6c1dacc8b174b10dac187bb1ee7fed819b77e84591dc1827dc38943a5dbbd763d0427568db5811754651851ae1b5823d52b700fc835078241871ab2b0ca505d0761481d357474bb7c4d7624ebd3bdb3d8355e73d11043fc0da353800000000006a7d51718c774c928566398691d5eb68b5eb8a39b4b6d5c73555b2100000000e66f07ae6ad93c9ea60272507db1a2d2089bbb67540ff6e291f98bcf5df4bc8901020300030128010000003d0427568db5811754651851ae1b5823d52b700fc835078241871ab2b0ca505d01000000");
  });
}

void _authorizeWithSeed() {
  test("authorizeWithSeed", () {
    final owner = QuickWalletForTest(index: 406);

    final account1 = QuickWalletForTest(index: 405);

    const blockHash = "GWWy2aAev5X3TMRVwdw8W2KMN3dyVrHrQMZukGTf9R1A";
    final layout = VoteProgramAuthorizeWithSeedLayout(
        newAuthorized: account1.address,
        voteAuthorizationType: 1,
        currentAuthorityDerivedKeySeed: "account1",
        currentAuthorityDerivedKeyOwnerPubkey: owner.address);
    final program = VoteProgram.authorizeWithSeed(
        currentAuthorityDerivedKeyBasePubkey: owner.address,
        votePubkey: owner.address,
        layout: layout);

    final SolanaTransaction transaction = SolanaTransaction(
        instructions: [program],
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
        "01000203f6c1dacc8b174b10dac187bb1ee7fed819b77e84591dc1827dc38943a5dbbd760761481d357474bb7c4d7624ebd3bdb3d8355e73d11043fc0da353800000000006a7d51718c774c928566398691d5eb68b5eb8a39b4b6d5c73555b2100000000e66f07ae6ad93c9ea60272507db1a2d2089bbb67540ff6e291f98bcf5df4bc89010103000200580a00000001000000f6c1dacc8b174b10dac187bb1ee7fed819b77e84591dc1827dc38943a5dbbd7608000000000000006163636f756e74313d0427568db5811754651851ae1b5823d52b700fc835078241871ab2b0ca505d");
    expect(signed,
        "01921e02c6df76c7059de56766f09aa3d9027ad79cb09361994e8e0980c6d1da26b8ea18046ca8897776f121dc32c41769f4219e948dd0e8824055ec988964ba0b01000203f6c1dacc8b174b10dac187bb1ee7fed819b77e84591dc1827dc38943a5dbbd760761481d357474bb7c4d7624ebd3bdb3d8355e73d11043fc0da353800000000006a7d51718c774c928566398691d5eb68b5eb8a39b4b6d5c73555b2100000000e66f07ae6ad93c9ea60272507db1a2d2089bbb67540ff6e291f98bcf5df4bc89010103000200580a00000001000000f6c1dacc8b174b10dac187bb1ee7fed819b77e84591dc1827dc38943a5dbbd7608000000000000006163636f756e74313d0427568db5811754651851ae1b5823d52b700fc835078241871ab2b0ca505d");
  });
}

void _withdraw() {
  test("withdraw", () {
    final owner = QuickWalletForTest(index: 406);
    final account1 = QuickWalletForTest(index: 405);
    const blockHash = "GWWy2aAev5X3TMRVwdw8W2KMN3dyVrHrQMZukGTf9R1A";
    final layout = VoteProgramWithdrawLayout(lamports: BigInt.from(25000));
    final program = VoteProgram.withdraw(
        authorizedWithdrawerPubkey: account1.address,
        toPubkey: owner.address,
        votePubkey: owner.address,
        layout: layout);
    final SolanaTransaction transaction = SolanaTransaction(
        instructions: [program],
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
        "02010103f6c1dacc8b174b10dac187bb1ee7fed819b77e84591dc1827dc38943a5dbbd763d0427568db5811754651851ae1b5823d52b700fc835078241871ab2b0ca505d0761481d357474bb7c4d7624ebd3bdb3d8355e73d11043fc0da3538000000000e66f07ae6ad93c9ea60272507db1a2d2089bbb67540ff6e291f98bcf5df4bc890102030000010c03000000a861000000000000");
    expect(signed,
        "021acc840e4a4a3d350d8f124308258f2fc725b91fc7044d2f06778bea4ab100067b870dd890ed0f8d064316335bd14529fc194b5ba5f8ec59ff16740df004ae0d0000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000002010103f6c1dacc8b174b10dac187bb1ee7fed819b77e84591dc1827dc38943a5dbbd763d0427568db5811754651851ae1b5823d52b700fc835078241871ab2b0ca505d0761481d357474bb7c4d7624ebd3bdb3d8355e73d11043fc0da3538000000000e66f07ae6ad93c9ea60272507db1a2d2089bbb67540ff6e291f98bcf5df4bc890102030000010c03000000a861000000000000");
  });
}
