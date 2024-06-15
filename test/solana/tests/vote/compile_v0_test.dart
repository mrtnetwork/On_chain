import 'package:blockchain_utils/blockchain_utils.dart';
import 'package:test/test.dart';
import 'package:on_chain/solana/solana.dart';
import '../../examples/wallet.dart';

void main() {
  group("vote compile v0", () {
    _initializeAccount();
    _authorize();
    _authorizeWithSeed();
    _withdraw();
    _transferWithLookup();
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
        type: TransactionType.v0);

    final unsigned = transaction.serializeMessageString();
    transaction.sign([owner.privateKey]);
    final signed =
        transaction.serializeString(encoding: TransactionSerializeEncoding.hex);
    final decodeTransaction =
        SolanaTransaction.deserialize(transaction.serialize());
    expect(decodeTransaction.serialize(), transaction.serialize());

    expect(unsigned,
        "8001000305f6c1dacc8b174b10dac187bb1ee7fed819b77e84591dc1827dc38943a5dbbd763d0427568db5811754651851ae1b5823d52b700fc835078241871ab2b0ca505d0761481d357474bb7c4d7624ebd3bdb3d8355e73d11043fc0da353800000000006a7d517192c5c51218cc94c3d4af17f58daee089ba1fd44e3dbd98a0000000006a7d51718c774c928566398691d5eb68b5eb8a39b4b6d5c73555b2100000000e66f07ae6ad93c9ea60272507db1a2d2089bbb67540ff6e291f98bcf5df4bc89010204010304006500000000f6c1dacc8b174b10dac187bb1ee7fed819b77e84591dc1827dc38943a5dbbd763d0427568db5811754651851ae1b5823d52b700fc835078241871ab2b0ca505d3d0427568db5811754651851ae1b5823d52b700fc835078241871ab2b0ca505d0100");
    expect(signed,
        "010c92bb7e7e588fd20892a95c85785691bc92783ac266e6d64756ace06eb81264fef85c8d5368f765cea1054f6d4eacdef5384c116ff00f8f5db63c89fad3970d8001000305f6c1dacc8b174b10dac187bb1ee7fed819b77e84591dc1827dc38943a5dbbd763d0427568db5811754651851ae1b5823d52b700fc835078241871ab2b0ca505d0761481d357474bb7c4d7624ebd3bdb3d8355e73d11043fc0da353800000000006a7d517192c5c51218cc94c3d4af17f58daee089ba1fd44e3dbd98a0000000006a7d51718c774c928566398691d5eb68b5eb8a39b4b6d5c73555b2100000000e66f07ae6ad93c9ea60272507db1a2d2089bbb67540ff6e291f98bcf5df4bc89010204010304006500000000f6c1dacc8b174b10dac187bb1ee7fed819b77e84591dc1827dc38943a5dbbd763d0427568db5811754651851ae1b5823d52b700fc835078241871ab2b0ca505d3d0427568db5811754651851ae1b5823d52b700fc835078241871ab2b0ca505d0100");
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
        type: TransactionType.v0);

    final unsigned = transaction.serializeMessageString();
    transaction.sign([owner.privateKey]);
    final signed =
        transaction.serializeString(encoding: TransactionSerializeEncoding.hex);
    final decodeTransaction =
        SolanaTransaction.deserialize(transaction.serialize());
    expect(decodeTransaction.serialize(), transaction.serialize());
    expect(unsigned,
        "8002010204f6c1dacc8b174b10dac187bb1ee7fed819b77e84591dc1827dc38943a5dbbd763d0427568db5811754651851ae1b5823d52b700fc835078241871ab2b0ca505d0761481d357474bb7c4d7624ebd3bdb3d8355e73d11043fc0da353800000000006a7d51718c774c928566398691d5eb68b5eb8a39b4b6d5c73555b2100000000e66f07ae6ad93c9ea60272507db1a2d2089bbb67540ff6e291f98bcf5df4bc8901020300030128010000003d0427568db5811754651851ae1b5823d52b700fc835078241871ab2b0ca505d0100000000");
    expect(signed,
        "0232d34a9c3a9eded491a8c37de9af14e889eae6197230e5ddb091bcde065bedad08f46e961783cb3a3084502eda6d8049b1ec3f5c9fe9bb13477a893bde5d120e000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000008002010204f6c1dacc8b174b10dac187bb1ee7fed819b77e84591dc1827dc38943a5dbbd763d0427568db5811754651851ae1b5823d52b700fc835078241871ab2b0ca505d0761481d357474bb7c4d7624ebd3bdb3d8355e73d11043fc0da353800000000006a7d51718c774c928566398691d5eb68b5eb8a39b4b6d5c73555b2100000000e66f07ae6ad93c9ea60272507db1a2d2089bbb67540ff6e291f98bcf5df4bc8901020300030128010000003d0427568db5811754651851ae1b5823d52b700fc835078241871ab2b0ca505d0100000000");
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
        type: TransactionType.v0);
    final unsigned = transaction.serializeMessageString();
    transaction.sign([owner.privateKey]);
    final signed =
        transaction.serializeString(encoding: TransactionSerializeEncoding.hex);
    final decodeTransaction =
        SolanaTransaction.deserialize(transaction.serialize());
    expect(decodeTransaction.serialize(), transaction.serialize());

    expect(unsigned,
        "8001000203f6c1dacc8b174b10dac187bb1ee7fed819b77e84591dc1827dc38943a5dbbd760761481d357474bb7c4d7624ebd3bdb3d8355e73d11043fc0da353800000000006a7d51718c774c928566398691d5eb68b5eb8a39b4b6d5c73555b2100000000e66f07ae6ad93c9ea60272507db1a2d2089bbb67540ff6e291f98bcf5df4bc89010103000200580a00000001000000f6c1dacc8b174b10dac187bb1ee7fed819b77e84591dc1827dc38943a5dbbd7608000000000000006163636f756e74313d0427568db5811754651851ae1b5823d52b700fc835078241871ab2b0ca505d00");
    expect(signed,
        "01bcb793c197ff66bf08d5f5d36dc681aacef5d0b8ec429933677d1912dd87127d6a9ad4868bb4a2377aef707654128b30d200e40d6be78bc7dbbafdd8cd24a50b8001000203f6c1dacc8b174b10dac187bb1ee7fed819b77e84591dc1827dc38943a5dbbd760761481d357474bb7c4d7624ebd3bdb3d8355e73d11043fc0da353800000000006a7d51718c774c928566398691d5eb68b5eb8a39b4b6d5c73555b2100000000e66f07ae6ad93c9ea60272507db1a2d2089bbb67540ff6e291f98bcf5df4bc89010103000200580a00000001000000f6c1dacc8b174b10dac187bb1ee7fed819b77e84591dc1827dc38943a5dbbd7608000000000000006163636f756e74313d0427568db5811754651851ae1b5823d52b700fc835078241871ab2b0ca505d00");
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
        type: TransactionType.v0);

    final unsigned = transaction.serializeMessageString();
    transaction.sign([owner.privateKey]);
    final signed =
        transaction.serializeString(encoding: TransactionSerializeEncoding.hex);
    final decodeTransaction =
        SolanaTransaction.deserialize(transaction.serialize());
    expect(decodeTransaction.serialize(), transaction.serialize());
    expect(unsigned,
        "8002010103f6c1dacc8b174b10dac187bb1ee7fed819b77e84591dc1827dc38943a5dbbd763d0427568db5811754651851ae1b5823d52b700fc835078241871ab2b0ca505d0761481d357474bb7c4d7624ebd3bdb3d8355e73d11043fc0da3538000000000e66f07ae6ad93c9ea60272507db1a2d2089bbb67540ff6e291f98bcf5df4bc890102030000010c03000000a86100000000000000");
    expect(signed,
        "02c2a4f815e5dd2cc975219c2ecb6747ecdb7d2fcc8b49c685a5f0d2ac30209c8ca208be18b95645bc06918ea441c78517d8f3875edbde3c323066f08165ca7106000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000008002010103f6c1dacc8b174b10dac187bb1ee7fed819b77e84591dc1827dc38943a5dbbd763d0427568db5811754651851ae1b5823d52b700fc835078241871ab2b0ca505d0761481d357474bb7c4d7624ebd3bdb3d8355e73d11043fc0da3538000000000e66f07ae6ad93c9ea60272507db1a2d2089bbb67540ff6e291f98bcf5df4bc890102030000010c03000000a86100000000000000");
  });
}

void _transferWithLookup() {
  test("transfer with lookup", () {
    final owner = QuickWalletForTest(index: 406);

    const blockHash = "GWWy2aAev5X3TMRVwdw8W2KMN3dyVrHrQMZukGTf9R1A";
    final tableAddress =
        AddressLookupTableProgramUtils.findAddressLookupTableProgram(
            authority: owner.address, recentSlot: BigInt.from(277777145));

    final tableAccount = AddressLookupTableAccount.fromBuffer(
        accountData: StringUtils.encode(
            "AQAAAP//////////8DWPEAAAAAAAAfbB2syLF0sQ2sGHux7n/tgZt36EWR3Bgn3DiUOl2712AAD2wdrMixdLENrBh7se5/7YGbd+hFkdwYJ9w4lDpdu9dj0EJ1aNtYEXVGUYUa4bWCPVK3APyDUHgkGHGrKwylBd9sHazIsXSxDawYe7Huf+2Bm3foRZHcGCfcOJQ6XbvXY=",
            type: StringEncoding.base64),
        accountKey: tableAddress.address);

    final instractuions = tableAccount.addresses
        .map((e) => SystemProgram.transfer(
            layout:
                SystemTransferLayout(lamports: SolanaUtils.toLamports("0.001")),
            from: owner.address,
            to: e))
        .toList();
    final SolanaTransaction transaction = SolanaTransaction(
        instructions: instractuions,
        recentBlockhash: SolAddress.uncheckCurve(blockHash),
        payerKey: owner.address,
        addressLookupTableAccounts: [tableAccount],
        type: TransactionType.v0);

    final unsigned = transaction.serializeMessageString();
    transaction.sign([owner.privateKey]);
    final signed =
        transaction.serializeString(encoding: TransactionSerializeEncoding.hex);
    final decodeTransaction =
        SolanaTransaction.deserialize(transaction.serialize());
    expect(decodeTransaction.serialize(), transaction.serialize());
    expect(unsigned,
        "8001000102f6c1dacc8b174b10dac187bb1ee7fed819b77e84591dc1827dc38943a5dbbd760000000000000000000000000000000000000000000000000000000000000000e66f07ae6ad93c9ea60272507db1a2d2089bbb67540ff6e291f98bcf5df4bc8903010200000c0200000040420f0000000000010200020c0200000040420f0000000000010200000c0200000040420f0000000000010e662ddb6836d891e4d1d6d13086c47007011e0dbcc953c7f197de1c75a377bb010100");
    expect(signed,
        "014ff51b71648674316c71a4ca1fdf9414587bcde8463fab734f5f063091454d8372c1df5b5c05d21b6fed97fa8090106f05cd350932788c19e1cad0a521567f0d8001000102f6c1dacc8b174b10dac187bb1ee7fed819b77e84591dc1827dc38943a5dbbd760000000000000000000000000000000000000000000000000000000000000000e66f07ae6ad93c9ea60272507db1a2d2089bbb67540ff6e291f98bcf5df4bc8903010200000c0200000040420f0000000000010200020c0200000040420f0000000000010200000c0200000040420f0000000000010e662ddb6836d891e4d1d6d13086c47007011e0dbcc953c7f197de1c75a377bb010100");
  });
}
