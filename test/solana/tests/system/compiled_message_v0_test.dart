import 'package:test/test.dart';
import 'package:on_chain/solana/solana.dart';
import '../../examples/wallet.dart';

void main() {
  group("system", () {
    _systemCreateAccount();
    _systemCreateAccountWithSeed();
    _transfer();
    _transferWithSeed();
    _assign();
    _assingWithSeed();
    _nonceInitialize();
    _nonceAdvance();
    _nonceWithdraw();
    _nonceAuthorize();
    _allocate();
    _allocateWithcSeed();
  });
}

void _systemCreateAccount() {
  test("create", () {
    final owner = SolanaPrivateKey.fromSeedHex(
        "4e27902b3df33d7857dc9d218a3b34a6550e9c7621a6d601d06240a517d22017");
    final newAccount = SolanaPrivateKey.fromSeedHex(
        "180924a2160def1027f68a5e5ddf2cde42772491d4b7ac95c91ffe9c0b701368");
    final create = SystemProgram.createAccount(
        from: owner.publicKey().toAddress(),
        newAccountPubKey: newAccount.publicKey().toAddress(),
        layout: SystemCreateLayout(
            lamports: BigInt.from(250000000),
            programId: SystemProgramConst.programId,
            space: BigInt.from(200)));

    final SolanaTransaction transaction = SolanaTransaction(
        instructions: [create],
        recentBlockhash: SolAddress.uncheckCurve(
            "GWWy2aAev5X3TMRVwdw8W2KMN3dyVrHrQMZukGTf9R1A"),
        payerKey: owner.publicKey().toAddress(),
        type: TransactionType.v0);
    final unsignedSerialize = transaction.serializeMessageString();
    transaction.sign([owner, newAccount]);
    final decodeTransaction =
        SolanaTransaction.deserialize(transaction.serialize());
    expect(decodeTransaction.serialize(), transaction.serialize());
    expect(unsignedSerialize,
        "80020001033bb809f4c65f4bd79708f7b52b94f2e17a878c779d420c29d728844a83eec5bfcd54c224b4612dfabe51d71efd60f1bd4a59bb30e7b2a3dda5f929c7c92e131c0000000000000000000000000000000000000000000000000000000000000000e66f07ae6ad93c9ea60272507db1a2d2089bbb67540ff6e291f98bcf5df4bc890102020001340000000080b2e60e00000000c800000000000000000000000000000000000000000000000000000000000000000000000000000000");
    expect(
        transaction.serializeString(encoding: TransactionSerializeEncoding.hex),
        "0212314b7d40d8c0fdd03eef9349d6334fa65855107f82c2092992f346892ff9ed9fa77443f2738cc9bc916870d38ef3be47c4e9270a4fc0b6d871eb29537fac06bc066548bc64e851a612a6bdf875aa31e7a0d638f244c478cea3fc83e7c63182a85bdca0708541762a218cf2801551ae7856f1c4281b13a20fb480545e36e20580020001033bb809f4c65f4bd79708f7b52b94f2e17a878c779d420c29d728844a83eec5bfcd54c224b4612dfabe51d71efd60f1bd4a59bb30e7b2a3dda5f929c7c92e131c0000000000000000000000000000000000000000000000000000000000000000e66f07ae6ad93c9ea60272507db1a2d2089bbb67540ff6e291f98bcf5df4bc890102020001340000000080b2e60e00000000c800000000000000000000000000000000000000000000000000000000000000000000000000000000");
  });
}

void _systemCreateAccountWithSeed() {
  test("createAccountWithSeeed", () {
    final owner = QuickWalletForTest(index: 255);
    const String seed = "account1";
    final layout = SystemCreateWithSeedLayout(
        lamports: BigInt.from(250000000),
        programId: SystemProgramConst.programId,
        space: BigInt.from(200),
        seed: seed,
        base: owner.address);
    const blockHash = "GWWy2aAev5X3TMRVwdw8W2KMN3dyVrHrQMZukGTf9R1A";
    final create = SystemProgram.createAccountWithSeed(
        from: owner.address,
        baseAccount: owner.address,
        newAccount: SolAddress.withSeed(
            fromPublicKey: owner.address,
            seed: seed,
            programId: SystemProgramConst.programId),
        layout: layout);

    final SolanaTransaction transaction = SolanaTransaction(
        instructions: [create],
        recentBlockhash: SolAddress.uncheckCurve(blockHash),
        payerKey: owner.address,
        type: TransactionType.v0);
    final unsignedV0 = transaction.serializeMessageString();
    final ownerSignature =
        owner.privateKey.sign(transaction.serializeMessage());
    transaction.addSignature(owner.address, ownerSignature);
    final serhex =
        transaction.serializeString(encoding: TransactionSerializeEncoding.hex);
    final decodeTransaction =
        SolanaTransaction.deserialize(transaction.serialize());
    expect(decodeTransaction.serialize(), transaction.serialize());
    expect(unsignedV0,
        "80010001033bb809f4c65f4bd79708f7b52b94f2e17a878c779d420c29d728844a83eec5bf6c92e3501cb2bcaad641f42c2a2c12fcb2db020c39c3376ee7cdb9f1c720d38f0000000000000000000000000000000000000000000000000000000000000000e66f07ae6ad93c9ea60272507db1a2d2089bbb67540ff6e291f98bcf5df4bc89010202000164030000003bb809f4c65f4bd79708f7b52b94f2e17a878c779d420c29d728844a83eec5bf08000000000000006163636f756e743180b2e60e00000000c800000000000000000000000000000000000000000000000000000000000000000000000000000000");
    expect(serhex,
        "01a49a3b6799264910d52eef4c118071a60d546941f34fa0eb2a9d4485ddbbc71ea0da52161666e2d01943869dd1d1cf0139ab28e8f4e4cc4d1616f2ede8571b0e80010001033bb809f4c65f4bd79708f7b52b94f2e17a878c779d420c29d728844a83eec5bf6c92e3501cb2bcaad641f42c2a2c12fcb2db020c39c3376ee7cdb9f1c720d38f0000000000000000000000000000000000000000000000000000000000000000e66f07ae6ad93c9ea60272507db1a2d2089bbb67540ff6e291f98bcf5df4bc89010202000164030000003bb809f4c65f4bd79708f7b52b94f2e17a878c779d420c29d728844a83eec5bf08000000000000006163636f756e743180b2e60e00000000c800000000000000000000000000000000000000000000000000000000000000000000000000000000");
  });
}

void _transfer() {
  test("transfer", () {
    final owner = QuickWalletForTest(index: 255);
    final receiver = QuickWalletForTest(index: 257);
    final layout = SystemTransferLayout(
      lamports: SolanaUtils.toLamports("0.001"),
    );
    const blockHash = "GWWy2aAev5X3TMRVwdw8W2KMN3dyVrHrQMZukGTf9R1A";
    final create = SystemProgram.transfer(
        from: owner.address, layout: layout, to: receiver.address);

    final SolanaTransaction transaction = SolanaTransaction(
        instructions: [create],
        recentBlockhash: SolAddress.uncheckCurve(blockHash),
        payerKey: owner.address,
        type: TransactionType.v0);

    final unsigned = transaction.serializeMessageString();
    final ownerSignature =
        owner.privateKey.sign(transaction.serializeMessage());
    transaction.addSignature(owner.address, ownerSignature);
    final serhex =
        transaction.serializeString(encoding: TransactionSerializeEncoding.hex);
    final decodeTransaction =
        SolanaTransaction.deserialize(transaction.serialize());
    expect(decodeTransaction.serialize(), transaction.serialize());
    expect(unsigned,
        "80010001033bb809f4c65f4bd79708f7b52b94f2e17a878c779d420c29d728844a83eec5bf807e1b63e7c241c72448e8f9f05e65d421ea40ceae40f47ca347f7d79c38d0e60000000000000000000000000000000000000000000000000000000000000000e66f07ae6ad93c9ea60272507db1a2d2089bbb67540ff6e291f98bcf5df4bc8901020200010c0200000040420f000000000000");
    expect(serhex,
        "01291275a7bf5a77b7f6296d7ea2eeea174179f47b5ebd87988638fc7a750b7c5035cdc922c1a77943fa760bc2de16d870b0b7ff46ae8dcac03df503e175074e0580010001033bb809f4c65f4bd79708f7b52b94f2e17a878c779d420c29d728844a83eec5bf807e1b63e7c241c72448e8f9f05e65d421ea40ceae40f47ca347f7d79c38d0e60000000000000000000000000000000000000000000000000000000000000000e66f07ae6ad93c9ea60272507db1a2d2089bbb67540ff6e291f98bcf5df4bc8901020200010c0200000040420f000000000000");
  });
}

void _transferWithSeed() {
  test("transferWithSeed", () {
    final owner = QuickWalletForTest(index: 255);
    final receiver = QuickWalletForTest(index: 257);
    const String seed = "account1";

    const blockHash = "GWWy2aAev5X3TMRVwdw8W2KMN3dyVrHrQMZukGTf9R1A";
    final layout = SystemTransferWithSeedLayout(
        lamports: SolanaUtils.toLamports("0.001"),
        seed: seed,
        programId: SystemProgramConst.programId);

    final create = SystemProgram.transferWithSeed(
        from: SolAddress.withSeed(
            fromPublicKey: owner.address,
            seed: seed,
            programId: SystemProgramConst.programId),
        layout: layout,
        to: receiver.address,
        baseAccount: owner.address);

    final SolanaTransaction transaction = SolanaTransaction(
        instructions: [create],
        recentBlockhash: SolAddress.uncheckCurve(blockHash),
        payerKey: owner.address,
        type: TransactionType.v0);

    final unsigned = transaction.serializeMessageString();
    final ownerSignature =
        owner.privateKey.sign(transaction.serializeMessage());

    transaction.addSignature(owner.address, ownerSignature);

    final serhex =
        transaction.serializeString(encoding: TransactionSerializeEncoding.hex);
    final decodeTransaction =
        SolanaTransaction.deserialize(transaction.serialize());
    expect(decodeTransaction.serialize(), transaction.serialize());
    expect(unsigned,
        "80010001043bb809f4c65f4bd79708f7b52b94f2e17a878c779d420c29d728844a83eec5bf6c92e3501cb2bcaad641f42c2a2c12fcb2db020c39c3376ee7cdb9f1c720d38f807e1b63e7c241c72448e8f9f05e65d421ea40ceae40f47ca347f7d79c38d0e60000000000000000000000000000000000000000000000000000000000000000e66f07ae6ad93c9ea60272507db1a2d2089bbb67540ff6e291f98bcf5df4bc890103030100023c0b00000040420f000000000008000000000000006163636f756e7431000000000000000000000000000000000000000000000000000000000000000000");
    expect(serhex,
        "01f3428027829097f9fe2c3d63ff81a50d62e7d52deadca755c6ca15c8f802c402bc46e2a5de930b08ddd07ffcbf79ca49e56a80d27d4d71463e114c91fa0bec0480010001043bb809f4c65f4bd79708f7b52b94f2e17a878c779d420c29d728844a83eec5bf6c92e3501cb2bcaad641f42c2a2c12fcb2db020c39c3376ee7cdb9f1c720d38f807e1b63e7c241c72448e8f9f05e65d421ea40ceae40f47ca347f7d79c38d0e60000000000000000000000000000000000000000000000000000000000000000e66f07ae6ad93c9ea60272507db1a2d2089bbb67540ff6e291f98bcf5df4bc890103030100023c0b00000040420f000000000008000000000000006163636f756e7431000000000000000000000000000000000000000000000000000000000000000000");
  });
}

void _assign() {
  test("assign", () {
    final owner = QuickWalletForTest(index: 255);

    const blockHash = "GWWy2aAev5X3TMRVwdw8W2KMN3dyVrHrQMZukGTf9R1A";
    const layout = SystemAssignLayout(programId: SystemProgramConst.programId);

    final create = SystemProgram.assign(layout: layout, account: owner.address);

    final SolanaTransaction transaction = SolanaTransaction(
        instructions: [create],
        recentBlockhash: SolAddress.uncheckCurve(blockHash),
        payerKey: owner.address,
        type: TransactionType.v0);

    final unsigned = transaction.serializeMessageString();
    final ownerSignature =
        owner.privateKey.sign(transaction.serializeMessage());

    transaction.addSignature(owner.address, ownerSignature);
    final signed =
        transaction.serializeString(encoding: TransactionSerializeEncoding.hex);
    final decodeTransaction =
        SolanaTransaction.deserialize(transaction.serialize());
    expect(decodeTransaction.serialize(), transaction.serialize());
    expect(unsigned,
        "80010001023bb809f4c65f4bd79708f7b52b94f2e17a878c779d420c29d728844a83eec5bf0000000000000000000000000000000000000000000000000000000000000000e66f07ae6ad93c9ea60272507db1a2d2089bbb67540ff6e291f98bcf5df4bc89010101002401000000000000000000000000000000000000000000000000000000000000000000000000");
    expect(signed,
        "01fa5905cc5330e4535b01e2a28bcce8739ffbc01d234c9a4842c7e30fab9f8f5e1674e756a9af095dc42e7d670653b7f31afdf449ee7e580d11ad4e02674db00c80010001023bb809f4c65f4bd79708f7b52b94f2e17a878c779d420c29d728844a83eec5bf0000000000000000000000000000000000000000000000000000000000000000e66f07ae6ad93c9ea60272507db1a2d2089bbb67540ff6e291f98bcf5df4bc89010101002401000000000000000000000000000000000000000000000000000000000000000000000000");
  });
}

void _assingWithSeed() {
  test("assignWithSeed", () {
    final owner = QuickWalletForTest(index: 255);
    const String seed = "account1";
    const blockHash = "GWWy2aAev5X3TMRVwdw8W2KMN3dyVrHrQMZukGTf9R1A";
    final layout = SystemAssignWithSeedLayout(
        programId: SystemProgramConst.programId,
        base: owner.address,
        seed: seed);

    final create = SystemProgram.assignWithSeed(
        layout: layout,
        account: SolAddress.withSeed(
            fromPublicKey: owner.address,
            seed: seed,
            programId: SystemProgramConst.programId));

    final SolanaTransaction transaction = SolanaTransaction(
        instructions: [create],
        recentBlockhash: SolAddress.uncheckCurve(blockHash),
        payerKey: owner.address,
        type: TransactionType.v0);

    final unsigned = transaction.serializeMessageString();
    final ownerSignature =
        owner.privateKey.sign(transaction.serializeMessage());
    transaction.addSignature(owner.address, ownerSignature);
    final signed =
        transaction.serializeString(encoding: TransactionSerializeEncoding.hex);
    final decodeTransaction =
        SolanaTransaction.deserialize(transaction.serialize());
    expect(decodeTransaction.serialize(), transaction.serialize());
    expect(unsigned,
        "80010001033bb809f4c65f4bd79708f7b52b94f2e17a878c779d420c29d728844a83eec5bf6c92e3501cb2bcaad641f42c2a2c12fcb2db020c39c3376ee7cdb9f1c720d38f0000000000000000000000000000000000000000000000000000000000000000e66f07ae6ad93c9ea60272507db1a2d2089bbb67540ff6e291f98bcf5df4bc890102020100540a0000003bb809f4c65f4bd79708f7b52b94f2e17a878c779d420c29d728844a83eec5bf08000000000000006163636f756e7431000000000000000000000000000000000000000000000000000000000000000000");
    expect(signed,
        "016760becdcee1f5e79a55127cc14146e201b2beb4d0ba92c1bf41b3fbb1407291076806e676752ebef466c72637fb458d5e53ecc0dbc5864c79b461f1b8e2720c80010001033bb809f4c65f4bd79708f7b52b94f2e17a878c779d420c29d728844a83eec5bf6c92e3501cb2bcaad641f42c2a2c12fcb2db020c39c3376ee7cdb9f1c720d38f0000000000000000000000000000000000000000000000000000000000000000e66f07ae6ad93c9ea60272507db1a2d2089bbb67540ff6e291f98bcf5df4bc890102020100540a0000003bb809f4c65f4bd79708f7b52b94f2e17a878c779d420c29d728844a83eec5bf08000000000000006163636f756e7431000000000000000000000000000000000000000000000000000000000000000000");
  });
}

void _nonceInitialize() {
  test("nonceInitialize", () {
    final owner = QuickWalletForTest(index: 255);
    final nonceAccount = QuickWalletForTest(index: 300);
    final layout =
        SystemInitializeNonceAccountLayout(authorized: owner.address);
    final newAccountInstraction = SystemProgram.createAccount(
        from: owner.address,
        newAccountPubKey: nonceAccount.address,
        layout: SystemCreateLayout(
            lamports: SolanaUtils.toLamports("0.1"),
            space: BigInt.from(80),
            programId: SystemProgramConst.programId));
    const blockHash = "GWWy2aAev5X3TMRVwdw8W2KMN3dyVrHrQMZukGTf9R1A";
    final create = SystemProgram.nonceInitialize(
        layout: layout, noncePubKey: nonceAccount.address);

    final SolanaTransaction transaction = SolanaTransaction(
        instructions: [newAccountInstraction, create],
        recentBlockhash: SolAddress.uncheckCurve(blockHash),
        payerKey: owner.address,
        type: TransactionType.v0);

    final unsigned = transaction.serializeMessageString();
    transaction.sign([nonceAccount.privateKey, owner.privateKey]);
    final signed =
        transaction.serializeString(encoding: TransactionSerializeEncoding.hex);
    final decodeTransaction =
        SolanaTransaction.deserialize(transaction.serialize());
    expect(decodeTransaction.serialize(), transaction.serialize());
    expect(unsigned,
        "80020003053bb809f4c65f4bd79708f7b52b94f2e17a878c779d420c29d728844a83eec5bf7baec1195335edb4e3ff6357e93e9ebac90a250da4a21413c89299bf140f07d6000000000000000000000000000000000000000000000000000000000000000006a7d517192c568ee08a845f73d29788cf035c3145b21ab344d8062ea940000006a7d517192c5c51218cc94c3d4af17f58daee089ba1fd44e3dbd98a00000000e66f07ae6ad93c9ea60272507db1a2d2089bbb67540ff6e291f98bcf5df4bc890202020001340000000000e1f5050000000050000000000000000000000000000000000000000000000000000000000000000000000000000000020301030424060000003bb809f4c65f4bd79708f7b52b94f2e17a878c779d420c29d728844a83eec5bf00");
    expect(signed,
        "02c2ad787561dbb000d23f5613d83915113350fff3259425b850dac78ff711fbe9242403c800d474906ca82ee1091e81f0feae5b9c9785c1474ba31336db32a909d3353bc7372a93378475dedac97e22f29140d02aa71bfd3ffd925da87c0c47e8588dabc090283ac19bf71c6c800fe1341f4821ac9b7622b2e513b08ba3bfd00b80020003053bb809f4c65f4bd79708f7b52b94f2e17a878c779d420c29d728844a83eec5bf7baec1195335edb4e3ff6357e93e9ebac90a250da4a21413c89299bf140f07d6000000000000000000000000000000000000000000000000000000000000000006a7d517192c568ee08a845f73d29788cf035c3145b21ab344d8062ea940000006a7d517192c5c51218cc94c3d4af17f58daee089ba1fd44e3dbd98a00000000e66f07ae6ad93c9ea60272507db1a2d2089bbb67540ff6e291f98bcf5df4bc890202020001340000000000e1f5050000000050000000000000000000000000000000000000000000000000000000000000000000000000000000020301030424060000003bb809f4c65f4bd79708f7b52b94f2e17a878c779d420c29d728844a83eec5bf00");
  });
}

void _nonceAdvance() {
  test("nonceAdvance", () {
    final owner = QuickWalletForTest(index: 255);
    final nonceAccount = QuickWalletForTest(index: 300);

    const blockHash = "GWWy2aAev5X3TMRVwdw8W2KMN3dyVrHrQMZukGTf9R1A";

    final program = SystemProgram.nonceAdvance(
        authorizedPubkey: owner.address, noncePubKey: nonceAccount.address);

    final SolanaTransaction transaction = SolanaTransaction(
        instructions: [program],
        recentBlockhash: SolAddress.uncheckCurve(blockHash),
        payerKey: owner.address,
        type: TransactionType.v0);

    final unsigned = transaction.serializeMessageString();
    transaction.sign([owner.privateKey]);
    final signed =
        transaction.serializeString(encoding: TransactionSerializeEncoding.hex);
    expect(unsigned,
        "80010002043bb809f4c65f4bd79708f7b52b94f2e17a878c779d420c29d728844a83eec5bf7baec1195335edb4e3ff6357e93e9ebac90a250da4a21413c89299bf140f07d6000000000000000000000000000000000000000000000000000000000000000006a7d517192c568ee08a845f73d29788cf035c3145b21ab344d8062ea9400000e66f07ae6ad93c9ea60272507db1a2d2089bbb67540ff6e291f98bcf5df4bc89010203010300040400000000");
    expect(signed,
        "018eb1bb9eb0902b508715e754d4b8b44e7f849989e4a19705c74af75d5db572e4f7ceb12cec86a603422cff51b1650674790c65b37e63bad6eb87f0cb5745810380010002043bb809f4c65f4bd79708f7b52b94f2e17a878c779d420c29d728844a83eec5bf7baec1195335edb4e3ff6357e93e9ebac90a250da4a21413c89299bf140f07d6000000000000000000000000000000000000000000000000000000000000000006a7d517192c568ee08a845f73d29788cf035c3145b21ab344d8062ea9400000e66f07ae6ad93c9ea60272507db1a2d2089bbb67540ff6e291f98bcf5df4bc89010203010300040400000000");
  });
}

void _nonceWithdraw() {
  test("nonceWithdraw", () {
    final owner = QuickWalletForTest(index: 255);
    final nonceAccount = QuickWalletForTest(index: 300);
    final receiver = QuickWalletForTest(index: 301);

    const blockHash = "GWWy2aAev5X3TMRVwdw8W2KMN3dyVrHrQMZukGTf9R1A";
    final layout = SystemWithdrawNonceLayout(lamports: BigInt.from(10000000));

    final program = SystemProgram.nonceWithdraw(
        authorizedPubkey: owner.address,
        noncePubKey: nonceAccount.address,
        layout: layout,
        toPubKey: receiver.address);

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
        "80010003063bb809f4c65f4bd79708f7b52b94f2e17a878c779d420c29d728844a83eec5bf7baec1195335edb4e3ff6357e93e9ebac90a250da4a21413c89299bf140f07d662409d344eba77c0dddb6d9f45e41745602c9fe25cd59dd285fb52805842450d000000000000000000000000000000000000000000000000000000000000000006a7d517192c568ee08a845f73d29788cf035c3145b21ab344d8062ea940000006a7d517192c5c51218cc94c3d4af17f58daee089ba1fd44e3dbd98a00000000e66f07ae6ad93c9ea60272507db1a2d2089bbb67540ff6e291f98bcf5df4bc8901030501020405000c05000000809698000000000000");
    expect(signed,
        "0172c0100e192ac6ae237c11a152462f5aeb7a7fb4394a34f22b62a1c9237eb0e0e917c9cfcc9f8bb20fb11729a40d1f4c76046b7ac30418122efdd2fc1206320180010003063bb809f4c65f4bd79708f7b52b94f2e17a878c779d420c29d728844a83eec5bf7baec1195335edb4e3ff6357e93e9ebac90a250da4a21413c89299bf140f07d662409d344eba77c0dddb6d9f45e41745602c9fe25cd59dd285fb52805842450d000000000000000000000000000000000000000000000000000000000000000006a7d517192c568ee08a845f73d29788cf035c3145b21ab344d8062ea940000006a7d517192c5c51218cc94c3d4af17f58daee089ba1fd44e3dbd98a00000000e66f07ae6ad93c9ea60272507db1a2d2089bbb67540ff6e291f98bcf5df4bc8901030501020405000c05000000809698000000000000");
  });
}

void _nonceAuthorize() {
  test("nonceAuthorize", () {
    final owner = QuickWalletForTest(index: 255);
    final nonceAccount = QuickWalletForTest(index: 300);
    const blockHash = "GWWy2aAev5X3TMRVwdw8W2KMN3dyVrHrQMZukGTf9R1A";
    final layout = SystemAuthorizeNonceAccountLayout(authorized: owner.address);
    final program = SystemProgram.nonceAuthorize(
        authorizedPubkey: owner.address,
        noncePubKey: nonceAccount.address,
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
        "80010001033bb809f4c65f4bd79708f7b52b94f2e17a878c779d420c29d728844a83eec5bf7baec1195335edb4e3ff6357e93e9ebac90a250da4a21413c89299bf140f07d60000000000000000000000000000000000000000000000000000000000000000e66f07ae6ad93c9ea60272507db1a2d2089bbb67540ff6e291f98bcf5df4bc89010202010024070000003bb809f4c65f4bd79708f7b52b94f2e17a878c779d420c29d728844a83eec5bf00");
    expect(signed,
        "01e7cb7925ae107c646e38fa507d32cbb9ea7792d8ff2467c9c4f86111b7429ad52a71ddecd764610f9d40ee17d7e5d88dfe6469104a27eab36a8686d28fc7740a80010001033bb809f4c65f4bd79708f7b52b94f2e17a878c779d420c29d728844a83eec5bf7baec1195335edb4e3ff6357e93e9ebac90a250da4a21413c89299bf140f07d60000000000000000000000000000000000000000000000000000000000000000e66f07ae6ad93c9ea60272507db1a2d2089bbb67540ff6e291f98bcf5df4bc89010202010024070000003bb809f4c65f4bd79708f7b52b94f2e17a878c779d420c29d728844a83eec5bf00");
  });
}

void _allocate() {
  test("allocate", () {
    final owner = QuickWalletForTest(index: 255);
    const blockHash = "GWWy2aAev5X3TMRVwdw8W2KMN3dyVrHrQMZukGTf9R1A";
    final layout = SystemAllocateLayout(space: BigInt.from(350));
    final program =
        SystemProgram.allocate(accountPubkey: owner.address, layout: layout);

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
        "80010001023bb809f4c65f4bd79708f7b52b94f2e17a878c779d420c29d728844a83eec5bf0000000000000000000000000000000000000000000000000000000000000000e66f07ae6ad93c9ea60272507db1a2d2089bbb67540ff6e291f98bcf5df4bc89010101000c080000005e0100000000000000");
    expect(signed,
        "01483a7897d12c9fe400e3d3da0ec75b5e4baa502ea3ba12f8b0017d0ee05ee3f2374e501013c41e5479c22ff99a6f773a4998e5c58d547ddae5c63c118cafdf0c80010001023bb809f4c65f4bd79708f7b52b94f2e17a878c779d420c29d728844a83eec5bf0000000000000000000000000000000000000000000000000000000000000000e66f07ae6ad93c9ea60272507db1a2d2089bbb67540ff6e291f98bcf5df4bc89010101000c080000005e0100000000000000");
  });
}

void _allocateWithcSeed() {
  test("allocateWithcSeed", () {
    final owner = QuickWalletForTest(index: 255);
    const blockHash = "GWWy2aAev5X3TMRVwdw8W2KMN3dyVrHrQMZukGTf9R1A";
    final layout = SystemAllocateWithSeedLayout(
        space: BigInt.from(350),
        base: owner.address,
        programId: SystemProgramConst.programId,
        seed: "account1");
    final program = SystemProgram.allocateWithcSeed(
        accountPubkey: SolAddress.withSeed(
            fromPublicKey: owner.address,
            seed: "account1",
            programId: SystemProgramConst.programId),
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
        "80010001033bb809f4c65f4bd79708f7b52b94f2e17a878c779d420c29d728844a83eec5bf6c92e3501cb2bcaad641f42c2a2c12fcb2db020c39c3376ee7cdb9f1c720d38f0000000000000000000000000000000000000000000000000000000000000000e66f07ae6ad93c9ea60272507db1a2d2089bbb67540ff6e291f98bcf5df4bc8901020201005c090000003bb809f4c65f4bd79708f7b52b94f2e17a878c779d420c29d728844a83eec5bf08000000000000006163636f756e74315e01000000000000000000000000000000000000000000000000000000000000000000000000000000");
    expect(signed,
        "01a79ac9296f4033af759dc43928bc02e2c49861c552826eb33275c4838d0929b359d3cca369806ec5f2106fe7e71250b5ab31fb53fad6bdad7c5476c5c4e8dc0280010001033bb809f4c65f4bd79708f7b52b94f2e17a878c779d420c29d728844a83eec5bf6c92e3501cb2bcaad641f42c2a2c12fcb2db020c39c3376ee7cdb9f1c720d38f0000000000000000000000000000000000000000000000000000000000000000e66f07ae6ad93c9ea60272507db1a2d2089bbb67540ff6e291f98bcf5df4bc8901020201005c090000003bb809f4c65f4bd79708f7b52b94f2e17a878c779d420c29d728844a83eec5bf08000000000000006163636f756e74315e01000000000000000000000000000000000000000000000000000000000000000000000000000000");
  });
}
