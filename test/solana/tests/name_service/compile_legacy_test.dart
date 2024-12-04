import 'package:test/test.dart';
import 'package:on_chain/solana/solana.dart';
import '../../examples/wallet.dart';

void main() {
  group("name service compile legacy", () {
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
    const String blockHash = "GWWy2aAev5X3TMRVwdw8W2KMN3dyVrHrQMZukGTf9R1A";

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
        type: TransactionType.legacy);
    final unsigned = transaction.serializeMessageString();
    transaction.sign([owner.privateKey]);
    final signed =
        transaction.serializeString(encoding: TransactionSerializeEncoding.hex);
    final decodeTransaction =
        SolanaTransaction.deserialize(transaction.serialize());
    expect(decodeTransaction.serialize(), transaction.serialize());
    expect(unsigned,
        "02010407f6c1dacc8b174b10dac187bb1ee7fed819b77e84591dc1827dc38943a5dbbd76ddb096e2b21ae947124270e14ea685c5c4bc0ba58fa11eaada3805b35353c3053d0427568db5811754651851ae1b5823d52b700fc835078241871ab2b0ca505d0bad51f413c1f3a99460d900d8bf2ed6927eca34d7b7842bf810a973082d1edc0000000000000000000000000000000000000000000000000000000000000000554a43a7b8e1a60dac1b800be310f94e55f8fb7415780b78177c3ede1aa0b7ca34ac616bf3f9899d94661b5359c20ca7b5caca6eb91511ddbf42851bde6daa5de66f07ae6ad93c9ea60272507db1a2d2089bbb67540ff6e291f98bcf5df4bc8901030704000205040601310020000000000000000000000000000000000000000000000000000000000000000000000000e1f505000000005e010000");
    expect(signed,
        "027e0f3e3f4c22ea9bb2bde5d3758b47006a7fdb92743d3ed90a7483bff63e9ed57216cdc1292e2bbf6eb3bb854d69a333d77a1f19827353fd47aa663c0449e0020000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000002010407f6c1dacc8b174b10dac187bb1ee7fed819b77e84591dc1827dc38943a5dbbd76ddb096e2b21ae947124270e14ea685c5c4bc0ba58fa11eaada3805b35353c3053d0427568db5811754651851ae1b5823d52b700fc835078241871ab2b0ca505d0bad51f413c1f3a99460d900d8bf2ed6927eca34d7b7842bf810a973082d1edc0000000000000000000000000000000000000000000000000000000000000000554a43a7b8e1a60dac1b800be310f94e55f8fb7415780b78177c3ede1aa0b7ca34ac616bf3f9899d94661b5359c20ca7b5caca6eb91511ddbf42851bde6daa5de66f07ae6ad93c9ea60272507db1a2d2089bbb67540ff6e291f98bcf5df4bc8901030704000205040601310020000000000000000000000000000000000000000000000000000000000000000000000000e1f505000000005e010000");
  });
}

void _update() {
  test("update", () {
    final owner = QuickWalletForTest(index: 406);
    final account1 = QuickWalletForTest(index: 405);
    const String blockHash = "GWWy2aAev5X3TMRVwdw8W2KMN3dyVrHrQMZukGTf9R1A";

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
        type: TransactionType.legacy);
    final unsigned = transaction.serializeMessageString();
    transaction.sign([owner.privateKey]);
    final signed =
        transaction.serializeString(encoding: TransactionSerializeEncoding.hex);
    final decodeTransaction =
        SolanaTransaction.deserialize(transaction.serialize());
    expect(decodeTransaction.serialize(), transaction.serialize());
    expect(unsigned,
        "01000204f6c1dacc8b174b10dac187bb1ee7fed819b77e84591dc1827dc38943a5dbbd763d0427568db5811754651851ae1b5823d52b700fc835078241871ab2b0ca505d0bad51f413c1f3a99460d900d8bf2ed6927eca34d7b7842bf810a973082d1edc34ac616bf3f9899d94661b5359c20ca7b5caca6eb91511ddbf42851bde6daa5de66f07ae6ad93c9ea60272507db1a2d2089bbb67540ff6e291f98bcf5df4bc890102030100032901d0070000200000000000000000000000000000000000000000000000000000000000000000000000");
    expect(signed,
        "014daecbb6c9d6c15e4598caf73347b969d3a274ba94bf5f010c2fd54b842dada293a8fae60d438603b2932c6f97272cc6f501a905eb0a5cbc68af7cbc8032540601000204f6c1dacc8b174b10dac187bb1ee7fed819b77e84591dc1827dc38943a5dbbd763d0427568db5811754651851ae1b5823d52b700fc835078241871ab2b0ca505d0bad51f413c1f3a99460d900d8bf2ed6927eca34d7b7842bf810a973082d1edc34ac616bf3f9899d94661b5359c20ca7b5caca6eb91511ddbf42851bde6daa5de66f07ae6ad93c9ea60272507db1a2d2089bbb67540ff6e291f98bcf5df4bc890102030100032901d0070000200000000000000000000000000000000000000000000000000000000000000000000000");
  });
}

void _transfer() {
  test("transfer", () {
    final owner = QuickWalletForTest(index: 406);
    final account1 = QuickWalletForTest(index: 405);
    final account3 = QuickWalletForTest(index: 407);
    const String blockHash = "GWWy2aAev5X3TMRVwdw8W2KMN3dyVrHrQMZukGTf9R1A";
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
        type: TransactionType.legacy);

    final unsigned = transaction.serializeMessageString();
    transaction.sign([owner.privateKey]);
    final signed =
        transaction.serializeString(encoding: TransactionSerializeEncoding.hex);
    final decodeTransaction =
        SolanaTransaction.deserialize(transaction.serialize());
    expect(decodeTransaction.serialize(), transaction.serialize());
    expect(unsigned,
        "02010205f6c1dacc8b174b10dac187bb1ee7fed819b77e84591dc1827dc38943a5dbbd76554a43a7b8e1a60dac1b800be310f94e55f8fb7415780b78177c3ede1aa0b7ca3d0427568db5811754651851ae1b5823d52b700fc835078241871ab2b0ca505d0bad51f413c1f3a99460d900d8bf2ed6927eca34d7b7842bf810a973082d1edc34ac616bf3f9899d94661b5359c20ca7b5caca6eb91511ddbf42851bde6daa5de66f07ae6ad93c9ea60272507db1a2d2089bbb67540ff6e291f98bcf5df4bc890103040200010421023d0427568db5811754651851ae1b5823d52b700fc835078241871ab2b0ca505d");
    expect(signed,
        "028455d6d06e96ee479d8def4116f2dce11719ca05ffbaa4c52e4f43dfb7523b708468aedcd2defbf7a91a5ea06f0588d94eff83c26a753de1b94f53585190cf030000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000002010205f6c1dacc8b174b10dac187bb1ee7fed819b77e84591dc1827dc38943a5dbbd76554a43a7b8e1a60dac1b800be310f94e55f8fb7415780b78177c3ede1aa0b7ca3d0427568db5811754651851ae1b5823d52b700fc835078241871ab2b0ca505d0bad51f413c1f3a99460d900d8bf2ed6927eca34d7b7842bf810a973082d1edc34ac616bf3f9899d94661b5359c20ca7b5caca6eb91511ddbf42851bde6daa5de66f07ae6ad93c9ea60272507db1a2d2089bbb67540ff6e291f98bcf5df4bc890103040200010421023d0427568db5811754651851ae1b5823d52b700fc835078241871ab2b0ca505d");
  });
}

void _delete() {
  test("delete", () {
    final owner = QuickWalletForTest(index: 406);
    final account1 = QuickWalletForTest(index: 405);
    final account6 = QuickWalletForTest(index: 410);
    const String blockHash = "GWWy2aAev5X3TMRVwdw8W2KMN3dyVrHrQMZukGTf9R1A";
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
        type: TransactionType.legacy);

    final unsigned = transaction.serializeMessageString();
    transaction.sign([owner.privateKey]);
    final signed =
        transaction.serializeString(encoding: TransactionSerializeEncoding.hex);
    final decodeTransaction =
        SolanaTransaction.deserialize(transaction.serialize());
    expect(decodeTransaction.serialize(), transaction.serialize());
    expect(unsigned,
        "01000104f6c1dacc8b174b10dac187bb1ee7fed819b77e84591dc1827dc38943a5dbbd763d0427568db5811754651851ae1b5823d52b700fc835078241871ab2b0ca505ded4b474820db73c8c296fccf275489da999d74ced22bd13a1cfa8b787857e9b30bad51f413c1f3a99460d900d8bf2ed6927eca34d7b7842bf810a973082d1edce66f07ae6ad93c9ea60272507db1a2d2089bbb67540ff6e291f98bcf5df4bc890103030100020103");
    expect(signed,
        "01c1a93f803be27e57e4b240abad359947853f60ae079bb425e06fac94150c30723b1a870ea2ff0e1406c13bc65f78b0f85cdf200eeb1af9e9e58f609bed67ad0801000104f6c1dacc8b174b10dac187bb1ee7fed819b77e84591dc1827dc38943a5dbbd763d0427568db5811754651851ae1b5823d52b700fc835078241871ab2b0ca505ded4b474820db73c8c296fccf275489da999d74ced22bd13a1cfa8b787857e9b30bad51f413c1f3a99460d900d8bf2ed6927eca34d7b7842bf810a973082d1edce66f07ae6ad93c9ea60272507db1a2d2089bbb67540ff6e291f98bcf5df4bc890103030100020103");
  });
}

void _realloc() {
  test("realloc", () {
    final owner = QuickWalletForTest(index: 406);
    final account1 = QuickWalletForTest(index: 405);
    const String blockHash = "GWWy2aAev5X3TMRVwdw8W2KMN3dyVrHrQMZukGTf9R1A";
    final initialize = NameServiceProgram.realloc(
      nameOwnerKey: owner.address,
      nameAccountKey: account1.address,
      layout: const NameServiceReallocLayout(space: 500),
      payerKey: owner.address,
      systemProgramId: SystemProgramConst.programId,
      nameProgramId: NameServiceProgramConst.programId,
    );
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
        "01000204f6c1dacc8b174b10dac187bb1ee7fed819b77e84591dc1827dc38943a5dbbd763d0427568db5811754651851ae1b5823d52b700fc835078241871ab2b0ca505d0bad51f413c1f3a99460d900d8bf2ed6927eca34d7b7842bf810a973082d1edc0000000000000000000000000000000000000000000000000000000000000000e66f07ae6ad93c9ea60272507db1a2d2089bbb67540ff6e291f98bcf5df4bc89010204030001000504f4010000");
    expect(signed,
        "0116777d56ba5bb46a19621a0b43dbe465f034c278ef88d198eae4340f8be36fd29865803b78d0169cea48598d4de4116ddc4a64573d6ee524d202246b2ba7370c01000204f6c1dacc8b174b10dac187bb1ee7fed819b77e84591dc1827dc38943a5dbbd763d0427568db5811754651851ae1b5823d52b700fc835078241871ab2b0ca505d0bad51f413c1f3a99460d900d8bf2ed6927eca34d7b7842bf810a973082d1edc0000000000000000000000000000000000000000000000000000000000000000e66f07ae6ad93c9ea60272507db1a2d2089bbb67540ff6e291f98bcf5df4bc89010204030001000504f4010000");
  });
}
