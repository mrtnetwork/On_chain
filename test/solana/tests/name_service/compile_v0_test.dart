import 'package:test/test.dart';
import 'package:on_chain/solana/solana.dart';
import '../../examples/wallet.dart';

void main() {
  group("name service compile v0", () {
    _create();
    _update();
    _transfer();
    _delete();
    _realloc();
  });
}

void _create() {
  test("create", () {
    final owner = QuickWalletForTest(index: 406);

    final account1 = QuickWalletForTest(index: 405);
    final account3 = QuickWalletForTest(index: 407);
    String blockHash = "GWWy2aAev5X3TMRVwdw8W2KMN3dyVrHrQMZukGTf9R1A";

    final initialize = NameServiceProgram.create(
        layout: NameServiceCreateLayout(
            hashedName: List<int>.filled(32, 0),
            lamports: BigInt.from(100000000),
            space: 350),
        nameProgramId: NameServiceProgramConst.programId,
        systemProgramId: SystemProgramConst.programId,
        nameKey: account1.address,
        nameOwnerKey: account3.address,
        payerKey: owner.address,
        nameClassKey: null,
        nameParent: NameServiceProgramConst.twitterRootPrentRegisteryKey,
        nameParentOwner: NameServiceProgramConst.twitterVerificationAuthority);
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
        "8002010407f6c1dacc8b174b10dac187bb1ee7fed819b77e84591dc1827dc38943a5dbbd76ddb096e2b21ae947124270e14ea685c5c4bc0ba58fa11eaada3805b35353c3053d0427568db5811754651851ae1b5823d52b700fc835078241871ab2b0ca505d0bad51f413c1f3a99460d900d8bf2ed6927eca34d7b7842bf810a973082d1edc0000000000000000000000000000000000000000000000000000000000000000554a43a7b8e1a60dac1b800be310f94e55f8fb7415780b78177c3ede1aa0b7ca34ac616bf3f9899d94661b5359c20ca7b5caca6eb91511ddbf42851bde6daa5de66f07ae6ad93c9ea60272507db1a2d2089bbb67540ff6e291f98bcf5df4bc8901030704000205040601310020000000000000000000000000000000000000000000000000000000000000000000000000e1f505000000005e01000000");
    expect(signed,
        "02d83436c751e6fc56a1220ad5a0a9406a7641f12b641188118e48c1f6c6164c1a8aeaf7ec9ee53a7e7429c7b659dcbb5af2b1a9a2fb062438ebd2143ba12b930f000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000008002010407f6c1dacc8b174b10dac187bb1ee7fed819b77e84591dc1827dc38943a5dbbd76ddb096e2b21ae947124270e14ea685c5c4bc0ba58fa11eaada3805b35353c3053d0427568db5811754651851ae1b5823d52b700fc835078241871ab2b0ca505d0bad51f413c1f3a99460d900d8bf2ed6927eca34d7b7842bf810a973082d1edc0000000000000000000000000000000000000000000000000000000000000000554a43a7b8e1a60dac1b800be310f94e55f8fb7415780b78177c3ede1aa0b7ca34ac616bf3f9899d94661b5359c20ca7b5caca6eb91511ddbf42851bde6daa5de66f07ae6ad93c9ea60272507db1a2d2089bbb67540ff6e291f98bcf5df4bc8901030704000205040601310020000000000000000000000000000000000000000000000000000000000000000000000000e1f505000000005e01000000");
  });
}

void _update() {
  test("update", () {
    final owner = QuickWalletForTest(index: 406);
    final account1 = QuickWalletForTest(index: 405);
    String blockHash = "GWWy2aAev5X3TMRVwdw8W2KMN3dyVrHrQMZukGTf9R1A";

    final initialize = NameServiceProgram.update(
      layout: NameServiceUpdateLayout(
          inputData: List<int>.filled(32, 0), offset: 2000),
      nameAccountKey: account1.address,
      nameUpdateSigner: owner.address,
      parentNameKey: NameServiceProgramConst.twitterRootPrentRegisteryKey,
      nameProgramId: NameServiceProgramConst.programId,
    );
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
        "8001000204f6c1dacc8b174b10dac187bb1ee7fed819b77e84591dc1827dc38943a5dbbd763d0427568db5811754651851ae1b5823d52b700fc835078241871ab2b0ca505d0bad51f413c1f3a99460d900d8bf2ed6927eca34d7b7842bf810a973082d1edc34ac616bf3f9899d94661b5359c20ca7b5caca6eb91511ddbf42851bde6daa5de66f07ae6ad93c9ea60272507db1a2d2089bbb67540ff6e291f98bcf5df4bc890102030100032901d007000020000000000000000000000000000000000000000000000000000000000000000000000000");
    expect(signed,
        "0169530f98495030daeefb18fb7d6896eb4c5680d797ff66cd34bda5f6d4c1693d3628ca766a5d4a2315690b2663fda547f38cf95b9a8118e1cafd353f052a09088001000204f6c1dacc8b174b10dac187bb1ee7fed819b77e84591dc1827dc38943a5dbbd763d0427568db5811754651851ae1b5823d52b700fc835078241871ab2b0ca505d0bad51f413c1f3a99460d900d8bf2ed6927eca34d7b7842bf810a973082d1edc34ac616bf3f9899d94661b5359c20ca7b5caca6eb91511ddbf42851bde6daa5de66f07ae6ad93c9ea60272507db1a2d2089bbb67540ff6e291f98bcf5df4bc890102030100032901d007000020000000000000000000000000000000000000000000000000000000000000000000000000");
  });
}

void _transfer() {
  test("transfer", () {
    final owner = QuickWalletForTest(index: 406);
    final account1 = QuickWalletForTest(index: 405);
    final account3 = QuickWalletForTest(index: 407);
    String blockHash = "GWWy2aAev5X3TMRVwdw8W2KMN3dyVrHrQMZukGTf9R1A";
    final initialize = NameServiceProgram.transfer(
      layout: NameServiceTransferLayout(newOwnerKey: account1.address),
      nameAccountKey: account1.address,
      currentNameOwnerKey: owner.address,
      nameClassKey: account3.address,
      nameParent: NameServiceProgramConst.twitterRootPrentRegisteryKey,
      nameProgramId: NameServiceProgramConst.programId,
    );
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
        "8002010205f6c1dacc8b174b10dac187bb1ee7fed819b77e84591dc1827dc38943a5dbbd76554a43a7b8e1a60dac1b800be310f94e55f8fb7415780b78177c3ede1aa0b7ca3d0427568db5811754651851ae1b5823d52b700fc835078241871ab2b0ca505d0bad51f413c1f3a99460d900d8bf2ed6927eca34d7b7842bf810a973082d1edc34ac616bf3f9899d94661b5359c20ca7b5caca6eb91511ddbf42851bde6daa5de66f07ae6ad93c9ea60272507db1a2d2089bbb67540ff6e291f98bcf5df4bc890103040200010421023d0427568db5811754651851ae1b5823d52b700fc835078241871ab2b0ca505d00");
    expect(signed,
        "02e8b0808c39eef61457c3649f3e2b451e60191ef33e2fd7d79ee9a05b609c6b8fc78994b4f0e4269e879e0d8e18be2b8703d900ad260ef138c65725412b538003000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000008002010205f6c1dacc8b174b10dac187bb1ee7fed819b77e84591dc1827dc38943a5dbbd76554a43a7b8e1a60dac1b800be310f94e55f8fb7415780b78177c3ede1aa0b7ca3d0427568db5811754651851ae1b5823d52b700fc835078241871ab2b0ca505d0bad51f413c1f3a99460d900d8bf2ed6927eca34d7b7842bf810a973082d1edc34ac616bf3f9899d94661b5359c20ca7b5caca6eb91511ddbf42851bde6daa5de66f07ae6ad93c9ea60272507db1a2d2089bbb67540ff6e291f98bcf5df4bc890103040200010421023d0427568db5811754651851ae1b5823d52b700fc835078241871ab2b0ca505d00");
  });
}

void _delete() {
  test("delete", () {
    final owner = QuickWalletForTest(index: 406);
    final account1 = QuickWalletForTest(index: 405);
    final account6 = QuickWalletForTest(index: 410);
    String blockHash = "GWWy2aAev5X3TMRVwdw8W2KMN3dyVrHrQMZukGTf9R1A";
    final initialize = NameServiceProgram.delete(
      nameOwnerKey: owner.address,
      nameAccountKey: account1.address,
      refundTargetKey: account6.address,
      nameProgramId: NameServiceProgramConst.programId,
    );
    final SolanaTransaction transaction = SolanaTransaction(
        instructions: [initialize],
        recentBlockhash: SolAddress.uncheckCurve(blockHash),
        payerKey: owner.address,
        type: TransactionType.v0);

    final unsigned = transaction.serializeMessageString();
    transaction.sign([owner.privateKey]);
    final signed = transaction.serializeString(
        encoding: TransactionSerializeEncoding.hex);
    expect(unsigned,
        "8001000104f6c1dacc8b174b10dac187bb1ee7fed819b77e84591dc1827dc38943a5dbbd763d0427568db5811754651851ae1b5823d52b700fc835078241871ab2b0ca505ded4b474820db73c8c296fccf275489da999d74ced22bd13a1cfa8b787857e9b30bad51f413c1f3a99460d900d8bf2ed6927eca34d7b7842bf810a973082d1edce66f07ae6ad93c9ea60272507db1a2d2089bbb67540ff6e291f98bcf5df4bc89010303010002010300");
    expect(signed,
        "01d98716a374645c731424af9861d4517d4d4b04d9719232ab4bcd04361d7d11b3aa8492522395e5c9ad2dbf044c674b4667769c0f19c6e5000604a6e9f6134a0b8001000104f6c1dacc8b174b10dac187bb1ee7fed819b77e84591dc1827dc38943a5dbbd763d0427568db5811754651851ae1b5823d52b700fc835078241871ab2b0ca505ded4b474820db73c8c296fccf275489da999d74ced22bd13a1cfa8b787857e9b30bad51f413c1f3a99460d900d8bf2ed6927eca34d7b7842bf810a973082d1edce66f07ae6ad93c9ea60272507db1a2d2089bbb67540ff6e291f98bcf5df4bc89010303010002010300");
  });
}

void _realloc() {
  test("realloc", () {
    final owner = QuickWalletForTest(index: 406);
    final account1 = QuickWalletForTest(index: 405);
    String blockHash = "GWWy2aAev5X3TMRVwdw8W2KMN3dyVrHrQMZukGTf9R1A";
    final initialize = NameServiceProgram.realloc(
      nameOwnerKey: owner.address,
      nameAccountKey: account1.address,
      layout: NameServiceReallocLayout(space: 500),
      payerKey: owner.address,
      systemProgramId: SystemProgramConst.programId,
      nameProgramId: NameServiceProgramConst.programId,
    );
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
        "8001000204f6c1dacc8b174b10dac187bb1ee7fed819b77e84591dc1827dc38943a5dbbd763d0427568db5811754651851ae1b5823d52b700fc835078241871ab2b0ca505d0bad51f413c1f3a99460d900d8bf2ed6927eca34d7b7842bf810a973082d1edc0000000000000000000000000000000000000000000000000000000000000000e66f07ae6ad93c9ea60272507db1a2d2089bbb67540ff6e291f98bcf5df4bc89010204030001000504f401000000");
    expect(signed,
        "013467d4d58df575c6a511b74b363f7c1cf9b0fb94a30b4b4e59444515c74612c30b9225fb4b82b5319eaafa67b9c2fbb1be3bcd68aec9555aeffb88e3ce9df90f8001000204f6c1dacc8b174b10dac187bb1ee7fed819b77e84591dc1827dc38943a5dbbd763d0427568db5811754651851ae1b5823d52b700fc835078241871ab2b0ca505d0bad51f413c1f3a99460d900d8bf2ed6927eca34d7b7842bf810a973082d1edc0000000000000000000000000000000000000000000000000000000000000000e66f07ae6ad93c9ea60272507db1a2d2089bbb67540ff6e291f98bcf5df4bc89010204030001000504f401000000");
  });
}
