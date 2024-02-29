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

    SolanaTransaction transaction = SolanaTransaction(
        instructions: [create],
        recentBlockhash: SolAddress.uncheckCurve(
            "GWWy2aAev5X3TMRVwdw8W2KMN3dyVrHrQMZukGTf9R1A"),
        payerKey: owner.publicKey().toAddress(),
        type: TransactionType.legacy);
    final unsignedSerialize = transaction.serializeMessageString();
    transaction.sign([owner, newAccount]);
    final decodeTransaction =
        SolanaTransaction.deserialize(transaction.serialize());
    expect(decodeTransaction.serialize(), transaction.serialize());
    expect(unsignedSerialize,
        "020001033bb809f4c65f4bd79708f7b52b94f2e17a878c779d420c29d728844a83eec5bfcd54c224b4612dfabe51d71efd60f1bd4a59bb30e7b2a3dda5f929c7c92e131c0000000000000000000000000000000000000000000000000000000000000000e66f07ae6ad93c9ea60272507db1a2d2089bbb67540ff6e291f98bcf5df4bc890102020001340000000080b2e60e00000000c8000000000000000000000000000000000000000000000000000000000000000000000000000000");
    expect(
        transaction.serializeString(encoding: TransactionSerializeEncoding.hex),
        "0268944ab1881523a3ba243b6676f64f19b92d4c5f9a8ac341f307cefce7521d59c75d5e963fb7941976d4acb0d00a3d7c65617fb453206ba67827e9e9d7b5a3041efacd4725bc0447cb0d73b50237eb7d6839cf7c4980c70313953e1a7a6d9091389c8f63c097c472f5cc99bc60b34dbfc382e7f5ab8aa54c75bc2bc1dbcfdf09020001033bb809f4c65f4bd79708f7b52b94f2e17a878c779d420c29d728844a83eec5bfcd54c224b4612dfabe51d71efd60f1bd4a59bb30e7b2a3dda5f929c7c92e131c0000000000000000000000000000000000000000000000000000000000000000e66f07ae6ad93c9ea60272507db1a2d2089bbb67540ff6e291f98bcf5df4bc890102020001340000000080b2e60e00000000c8000000000000000000000000000000000000000000000000000000000000000000000000000000");
  });
}

void _systemCreateAccountWithSeed() {
  test("createWithSeed", () {
    final owner = QuickWalletForTest(index: 255);
    final String seed = "account1";
    final layout = SystemCreateWithSeedLayout(
        lamports: BigInt.from(250000000),
        programId: SystemProgramConst.programId,
        space: BigInt.from(200),
        seed: seed,
        base: owner.address);
    final blockHash = "GWWy2aAev5X3TMRVwdw8W2KMN3dyVrHrQMZukGTf9R1A";
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
        type: TransactionType.legacy);

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
        "010001033bb809f4c65f4bd79708f7b52b94f2e17a878c779d420c29d728844a83eec5bf6c92e3501cb2bcaad641f42c2a2c12fcb2db020c39c3376ee7cdb9f1c720d38f0000000000000000000000000000000000000000000000000000000000000000e66f07ae6ad93c9ea60272507db1a2d2089bbb67540ff6e291f98bcf5df4bc89010202000164030000003bb809f4c65f4bd79708f7b52b94f2e17a878c779d420c29d728844a83eec5bf08000000000000006163636f756e743180b2e60e00000000c8000000000000000000000000000000000000000000000000000000000000000000000000000000");
    expect(serhex,
        "01a993d89a9f7befa0e4cedb2b7aaa8472a363f90872a637e1877a9e86c456a3441095aee04a2b9ffe1d31997fa2067dbcbdc00e32e02f41862c12373ba9c43404010001033bb809f4c65f4bd79708f7b52b94f2e17a878c779d420c29d728844a83eec5bf6c92e3501cb2bcaad641f42c2a2c12fcb2db020c39c3376ee7cdb9f1c720d38f0000000000000000000000000000000000000000000000000000000000000000e66f07ae6ad93c9ea60272507db1a2d2089bbb67540ff6e291f98bcf5df4bc89010202000164030000003bb809f4c65f4bd79708f7b52b94f2e17a878c779d420c29d728844a83eec5bf08000000000000006163636f756e743180b2e60e00000000c8000000000000000000000000000000000000000000000000000000000000000000000000000000");
  });
}

void _transfer() {
  test("transfer", () {
    final owner = QuickWalletForTest(index: 255);
    final receiver = QuickWalletForTest(index: 257);
    final layout =
        SystemTransferLayout(lamports: SolanaUtils.toLamports("0.001"));

    final blockHash = "GWWy2aAev5X3TMRVwdw8W2KMN3dyVrHrQMZukGTf9R1A";
    final create = SystemProgram.transfer(
        from: owner.address, layout: layout, to: receiver.address);

    final SolanaTransaction transaction = SolanaTransaction(
        instructions: [create],
        recentBlockhash: SolAddress.uncheckCurve(blockHash),
        payerKey: owner.address,
        type: TransactionType.legacy);

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
        "010001033bb809f4c65f4bd79708f7b52b94f2e17a878c779d420c29d728844a83eec5bf807e1b63e7c241c72448e8f9f05e65d421ea40ceae40f47ca347f7d79c38d0e60000000000000000000000000000000000000000000000000000000000000000e66f07ae6ad93c9ea60272507db1a2d2089bbb67540ff6e291f98bcf5df4bc8901020200010c0200000040420f0000000000");
    expect(serhex,
        "019559232c8b14ee4ce2defc3d516e3d13264639c58a762a206a892b85a625c4e8f29cfc6de28bcc37334935ddc87f9817c85a32bd320c67a6923a90cf7c807e05010001033bb809f4c65f4bd79708f7b52b94f2e17a878c779d420c29d728844a83eec5bf807e1b63e7c241c72448e8f9f05e65d421ea40ceae40f47ca347f7d79c38d0e60000000000000000000000000000000000000000000000000000000000000000e66f07ae6ad93c9ea60272507db1a2d2089bbb67540ff6e291f98bcf5df4bc8901020200010c0200000040420f0000000000");
  });
}

void _transferWithSeed() {
  test("transfer with seed", () {
    final owner = QuickWalletForTest(index: 255);
    final receiver = QuickWalletForTest(index: 257);
    final String seed = "account1";

    final blockHash = "GWWy2aAev5X3TMRVwdw8W2KMN3dyVrHrQMZukGTf9R1A";
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
        type: TransactionType.legacy);

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
        "010001043bb809f4c65f4bd79708f7b52b94f2e17a878c779d420c29d728844a83eec5bf6c92e3501cb2bcaad641f42c2a2c12fcb2db020c39c3376ee7cdb9f1c720d38f807e1b63e7c241c72448e8f9f05e65d421ea40ceae40f47ca347f7d79c38d0e60000000000000000000000000000000000000000000000000000000000000000e66f07ae6ad93c9ea60272507db1a2d2089bbb67540ff6e291f98bcf5df4bc890103030100023c0b00000040420f000000000008000000000000006163636f756e74310000000000000000000000000000000000000000000000000000000000000000");
    expect(signed,
        "01afb69415169ccc1153815ac9c7eade14a2268d012125a8ef6724ba1923a9a6d98a2645526ac6302104c11916ca0fe676cdec5089ae8a791e3b9a3cbac7cd4a07010001043bb809f4c65f4bd79708f7b52b94f2e17a878c779d420c29d728844a83eec5bf6c92e3501cb2bcaad641f42c2a2c12fcb2db020c39c3376ee7cdb9f1c720d38f807e1b63e7c241c72448e8f9f05e65d421ea40ceae40f47ca347f7d79c38d0e60000000000000000000000000000000000000000000000000000000000000000e66f07ae6ad93c9ea60272507db1a2d2089bbb67540ff6e291f98bcf5df4bc890103030100023c0b00000040420f000000000008000000000000006163636f756e74310000000000000000000000000000000000000000000000000000000000000000");
  });
}

void _assign() {
  test("assign", () {
    final owner = QuickWalletForTest(index: 255);

    final blockHash = "GWWy2aAev5X3TMRVwdw8W2KMN3dyVrHrQMZukGTf9R1A";
    final layout = SystemAssignLayout(programId: SystemProgramConst.programId);

    final create = SystemProgram.assign(layout: layout, account: owner.address);

    final SolanaTransaction transaction = SolanaTransaction(
        instructions: [create],
        recentBlockhash: SolAddress.uncheckCurve(blockHash),
        payerKey: owner.address,
        type: TransactionType.legacy);

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
        "010001023bb809f4c65f4bd79708f7b52b94f2e17a878c779d420c29d728844a83eec5bf0000000000000000000000000000000000000000000000000000000000000000e66f07ae6ad93c9ea60272507db1a2d2089bbb67540ff6e291f98bcf5df4bc890101010024010000000000000000000000000000000000000000000000000000000000000000000000");
    expect(signed,
        "01d5f7674cb6461cb955e50752d014e41205e7642540195f0619c2c6f6d40fdcc58f7010b1666a5492193a6cd5f785d37174d7644658a1cc72491a5b59add20f0c010001023bb809f4c65f4bd79708f7b52b94f2e17a878c779d420c29d728844a83eec5bf0000000000000000000000000000000000000000000000000000000000000000e66f07ae6ad93c9ea60272507db1a2d2089bbb67540ff6e291f98bcf5df4bc890101010024010000000000000000000000000000000000000000000000000000000000000000000000");
  });
}

void _assingWithSeed() {
  test("assignWithSeed", () {
    final owner = QuickWalletForTest(index: 255);
    final String seed = "account1";
    final blockHash = "GWWy2aAev5X3TMRVwdw8W2KMN3dyVrHrQMZukGTf9R1A";
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
        type: TransactionType.legacy);

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
        "010001033bb809f4c65f4bd79708f7b52b94f2e17a878c779d420c29d728844a83eec5bf6c92e3501cb2bcaad641f42c2a2c12fcb2db020c39c3376ee7cdb9f1c720d38f0000000000000000000000000000000000000000000000000000000000000000e66f07ae6ad93c9ea60272507db1a2d2089bbb67540ff6e291f98bcf5df4bc890102020100540a0000003bb809f4c65f4bd79708f7b52b94f2e17a878c779d420c29d728844a83eec5bf08000000000000006163636f756e74310000000000000000000000000000000000000000000000000000000000000000");
    expect(signed,
        "01a48a3c6867e4b8c30ff37665824a1fe172c73884fb024d8bb522268a3eba24bae0e32cfb25ebb9d1b5c35eee087898c75c451e41c976e8831af4a6d054695b0e010001033bb809f4c65f4bd79708f7b52b94f2e17a878c779d420c29d728844a83eec5bf6c92e3501cb2bcaad641f42c2a2c12fcb2db020c39c3376ee7cdb9f1c720d38f0000000000000000000000000000000000000000000000000000000000000000e66f07ae6ad93c9ea60272507db1a2d2089bbb67540ff6e291f98bcf5df4bc890102020100540a0000003bb809f4c65f4bd79708f7b52b94f2e17a878c779d420c29d728844a83eec5bf08000000000000006163636f756e74310000000000000000000000000000000000000000000000000000000000000000");
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
    final blockHash = "GWWy2aAev5X3TMRVwdw8W2KMN3dyVrHrQMZukGTf9R1A";
    final create = SystemProgram.nonceInitialize(
        layout: layout, noncePubKey: nonceAccount.address);

    final SolanaTransaction transaction = SolanaTransaction(
        instructions: [newAccountInstraction, create],
        recentBlockhash: SolAddress.uncheckCurve(blockHash),
        payerKey: owner.address,
        type: TransactionType.legacy);

    final unsigned = transaction.serializeMessageString();
    transaction.sign([nonceAccount.privateKey, owner.privateKey]);
    final signed =
        transaction.serializeString(encoding: TransactionSerializeEncoding.hex);
    final decodeTransaction =
        SolanaTransaction.deserialize(transaction.serialize());
    expect(decodeTransaction.serialize(), transaction.serialize());
    expect(unsigned,
        "020003053bb809f4c65f4bd79708f7b52b94f2e17a878c779d420c29d728844a83eec5bf7baec1195335edb4e3ff6357e93e9ebac90a250da4a21413c89299bf140f07d6000000000000000000000000000000000000000000000000000000000000000006a7d517192c568ee08a845f73d29788cf035c3145b21ab344d8062ea940000006a7d517192c5c51218cc94c3d4af17f58daee089ba1fd44e3dbd98a00000000e66f07ae6ad93c9ea60272507db1a2d2089bbb67540ff6e291f98bcf5df4bc890202020001340000000000e1f5050000000050000000000000000000000000000000000000000000000000000000000000000000000000000000020301030424060000003bb809f4c65f4bd79708f7b52b94f2e17a878c779d420c29d728844a83eec5bf");
    expect(signed,
        "027c164ddb0c50865e111059d52066997bf5271038c9c51a7be4602090781f08b7b179aa7417bf43d7a21bf0e6c895b49f078bd31a6fc31a76df4cc7324cd16e0d7ab83d994f8b5d33e947fe91e4e534e62aae62acfbfc63b11010be5c414ea736dc47c45bce4499898732d614793c84697873494e8515502294728e0324608b03020003053bb809f4c65f4bd79708f7b52b94f2e17a878c779d420c29d728844a83eec5bf7baec1195335edb4e3ff6357e93e9ebac90a250da4a21413c89299bf140f07d6000000000000000000000000000000000000000000000000000000000000000006a7d517192c568ee08a845f73d29788cf035c3145b21ab344d8062ea940000006a7d517192c5c51218cc94c3d4af17f58daee089ba1fd44e3dbd98a00000000e66f07ae6ad93c9ea60272507db1a2d2089bbb67540ff6e291f98bcf5df4bc890202020001340000000000e1f5050000000050000000000000000000000000000000000000000000000000000000000000000000000000000000020301030424060000003bb809f4c65f4bd79708f7b52b94f2e17a878c779d420c29d728844a83eec5bf");
  });
}

void _nonceAdvance() {
  test("nonceAdvance", () {
    final owner = QuickWalletForTest(index: 255);
    final nonceAccount = QuickWalletForTest(index: 300);

    final blockHash = "GWWy2aAev5X3TMRVwdw8W2KMN3dyVrHrQMZukGTf9R1A";

    final program = SystemProgram.nonceAdvance(
        authorizedPubkey: owner.address, noncePubKey: nonceAccount.address);

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
        "010002043bb809f4c65f4bd79708f7b52b94f2e17a878c779d420c29d728844a83eec5bf7baec1195335edb4e3ff6357e93e9ebac90a250da4a21413c89299bf140f07d6000000000000000000000000000000000000000000000000000000000000000006a7d517192c568ee08a845f73d29788cf035c3145b21ab344d8062ea9400000e66f07ae6ad93c9ea60272507db1a2d2089bbb67540ff6e291f98bcf5df4bc890102030103000404000000");
    expect(signed,
        "01a508456ec401f7366833e1da0c6f8c181c85e60a33c5f36bd1ad7df73d7446f8ab755394b29890b113327ebe6bc9f3b053f17b5b0c8a84467c56314b80f0c707010002043bb809f4c65f4bd79708f7b52b94f2e17a878c779d420c29d728844a83eec5bf7baec1195335edb4e3ff6357e93e9ebac90a250da4a21413c89299bf140f07d6000000000000000000000000000000000000000000000000000000000000000006a7d517192c568ee08a845f73d29788cf035c3145b21ab344d8062ea9400000e66f07ae6ad93c9ea60272507db1a2d2089bbb67540ff6e291f98bcf5df4bc890102030103000404000000");
  });
}

void _nonceWithdraw() {
  test("nonceWithdraw", () {
    final owner = QuickWalletForTest(index: 255);
    final nonceAccount = QuickWalletForTest(index: 300);
    final receiver = QuickWalletForTest(index: 301);

    final blockHash = "GWWy2aAev5X3TMRVwdw8W2KMN3dyVrHrQMZukGTf9R1A";
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
        type: TransactionType.legacy);

    final unsigned = transaction.serializeMessageString();
    transaction.sign([owner.privateKey]);
    final signed =
        transaction.serializeString(encoding: TransactionSerializeEncoding.hex);
    final decodeTransaction =
        SolanaTransaction.deserialize(transaction.serialize());
    expect(decodeTransaction.serialize(), transaction.serialize());
    expect(unsigned,
        "010003063bb809f4c65f4bd79708f7b52b94f2e17a878c779d420c29d728844a83eec5bf7baec1195335edb4e3ff6357e93e9ebac90a250da4a21413c89299bf140f07d662409d344eba77c0dddb6d9f45e41745602c9fe25cd59dd285fb52805842450d000000000000000000000000000000000000000000000000000000000000000006a7d517192c568ee08a845f73d29788cf035c3145b21ab344d8062ea940000006a7d517192c5c51218cc94c3d4af17f58daee089ba1fd44e3dbd98a00000000e66f07ae6ad93c9ea60272507db1a2d2089bbb67540ff6e291f98bcf5df4bc8901030501020405000c050000008096980000000000");
    expect(signed,
        "010aa4a52671fb1e2909af22e1c180a436242b2f1c027bb286eabf595fb0f452b0f94f34b9d52a70df29509c0380c5197f56cb78d76f295db93d603125653d4503010003063bb809f4c65f4bd79708f7b52b94f2e17a878c779d420c29d728844a83eec5bf7baec1195335edb4e3ff6357e93e9ebac90a250da4a21413c89299bf140f07d662409d344eba77c0dddb6d9f45e41745602c9fe25cd59dd285fb52805842450d000000000000000000000000000000000000000000000000000000000000000006a7d517192c568ee08a845f73d29788cf035c3145b21ab344d8062ea940000006a7d517192c5c51218cc94c3d4af17f58daee089ba1fd44e3dbd98a00000000e66f07ae6ad93c9ea60272507db1a2d2089bbb67540ff6e291f98bcf5df4bc8901030501020405000c050000008096980000000000");
  });
}

void _nonceAuthorize() {
  test("nonceAuthorize", () {
    final owner = QuickWalletForTest(index: 255);
    final nonceAccount = QuickWalletForTest(index: 300);
    final blockHash = "GWWy2aAev5X3TMRVwdw8W2KMN3dyVrHrQMZukGTf9R1A";
    final layout = SystemAuthorizeNonceAccountLayout(authorized: owner.address);
    final program = SystemProgram.nonceAuthorize(
        authorizedPubkey: owner.address,
        noncePubKey: nonceAccount.address,
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
        "010001033bb809f4c65f4bd79708f7b52b94f2e17a878c779d420c29d728844a83eec5bf7baec1195335edb4e3ff6357e93e9ebac90a250da4a21413c89299bf140f07d60000000000000000000000000000000000000000000000000000000000000000e66f07ae6ad93c9ea60272507db1a2d2089bbb67540ff6e291f98bcf5df4bc89010202010024070000003bb809f4c65f4bd79708f7b52b94f2e17a878c779d420c29d728844a83eec5bf");
    expect(signed,
        "019315e92874fcd531a0501d067116a053dd80aa933d3beb138544003d109cef9573ad26b31811c048a609b283fd1c82f1aa08ad2f94c2198dfa40166523aa6209010001033bb809f4c65f4bd79708f7b52b94f2e17a878c779d420c29d728844a83eec5bf7baec1195335edb4e3ff6357e93e9ebac90a250da4a21413c89299bf140f07d60000000000000000000000000000000000000000000000000000000000000000e66f07ae6ad93c9ea60272507db1a2d2089bbb67540ff6e291f98bcf5df4bc89010202010024070000003bb809f4c65f4bd79708f7b52b94f2e17a878c779d420c29d728844a83eec5bf");
  });
}

void _allocate() {
  test("allocate", () {
    final owner = QuickWalletForTest(index: 255);
    final blockHash = "GWWy2aAev5X3TMRVwdw8W2KMN3dyVrHrQMZukGTf9R1A";
    final layout = SystemAllocateLayout(space: BigInt.from(350));
    final program =
        SystemProgram.allocate(accountPubkey: owner.address, layout: layout);

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
        "010001023bb809f4c65f4bd79708f7b52b94f2e17a878c779d420c29d728844a83eec5bf0000000000000000000000000000000000000000000000000000000000000000e66f07ae6ad93c9ea60272507db1a2d2089bbb67540ff6e291f98bcf5df4bc89010101000c080000005e01000000000000");
    expect(signed,
        "01cd89efe9ab77a0697c89a0fad3d12093a823e23bbcc5045ba68fd0cb49980fa7e2fd692c11bcec71d43725d0970098d2555c1d80f5de7fb0a0fe0b70f6cc6604010001023bb809f4c65f4bd79708f7b52b94f2e17a878c779d420c29d728844a83eec5bf0000000000000000000000000000000000000000000000000000000000000000e66f07ae6ad93c9ea60272507db1a2d2089bbb67540ff6e291f98bcf5df4bc89010101000c080000005e01000000000000");
  });
}

void _allocateWithcSeed() {
  test("allocateWithcSeed", () {
    final owner = QuickWalletForTest(index: 255);
    final blockHash = "GWWy2aAev5X3TMRVwdw8W2KMN3dyVrHrQMZukGTf9R1A";
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
        type: TransactionType.legacy);
    final unsigned = transaction.serializeMessageString();
    transaction.sign([owner.privateKey]);
    final signed =
        transaction.serializeString(encoding: TransactionSerializeEncoding.hex);
    final decodeTransaction =
        SolanaTransaction.deserialize(transaction.serialize());
    expect(decodeTransaction.serialize(), transaction.serialize());
    expect(unsigned,
        "010001033bb809f4c65f4bd79708f7b52b94f2e17a878c779d420c29d728844a83eec5bf6c92e3501cb2bcaad641f42c2a2c12fcb2db020c39c3376ee7cdb9f1c720d38f0000000000000000000000000000000000000000000000000000000000000000e66f07ae6ad93c9ea60272507db1a2d2089bbb67540ff6e291f98bcf5df4bc8901020201005c090000003bb809f4c65f4bd79708f7b52b94f2e17a878c779d420c29d728844a83eec5bf08000000000000006163636f756e74315e010000000000000000000000000000000000000000000000000000000000000000000000000000");
    expect(signed,
        "014b80314d87ee7583b013f1a53af909efc2ab870061187d871876e40137dc4d1b8e5fb4c6f11b91f5b691e2fad7346feb9b494005b4113ced53a5781d9531780e010001033bb809f4c65f4bd79708f7b52b94f2e17a878c779d420c29d728844a83eec5bf6c92e3501cb2bcaad641f42c2a2c12fcb2db020c39c3376ee7cdb9f1c720d38f0000000000000000000000000000000000000000000000000000000000000000e66f07ae6ad93c9ea60272507db1a2d2089bbb67540ff6e291f98bcf5df4bc8901020201005c090000003bb809f4c65f4bd79708f7b52b94f2e17a878c779d420c29d728844a83eec5bf08000000000000006163636f756e74315e010000000000000000000000000000000000000000000000000000000000000000000000000000");
  });
}
