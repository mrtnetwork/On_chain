import 'package:test/test.dart';
import 'package:on_chain/solana/solana.dart';
import '../../examples/wallet.dart';

void main() {
  group("lookupTable compile v0", () {
    _createLookupTable();
    _freezeLookupTable();
    _extendLookupTable();
    _deactivateLookupTable();
    _closeLookupTable();
  });
}

void _createLookupTable() {
  test("createLookupTable", () {
    final owner = QuickWalletForTest(index: 406);
    final tableAddress =
        AddressLookupTableProgramUtils.findAddressLookupTableProgram(
            authority: owner.address, recentSlot: BigInt.from(277769241));
    const blockHash = "GWWy2aAev5X3TMRVwdw8W2KMN3dyVrHrQMZukGTf9R1A";
    final layout = AddressLookupCreateLookupTableLayout(
        bumpSeed: tableAddress.bump, recentSlot: BigInt.from(277769241));
    final program = AddressLookupTableProgram.createLookupTable(
        layout: layout,
        authority: owner.address,
        payer: owner.address,
        lookupTableAddress: tableAddress.address);

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
        "8001000204f6c1dacc8b174b10dac187bb1ee7fed819b77e84591dc1827dc38943a5dbbd767e2472c5129c3b712a778535721fc7490afae188b8719897cda512071501901e0277a6af97339b7ac88d1892c90446f50002309266f62e53c1182449820000000000000000000000000000000000000000000000000000000000000000000000e66f07ae6ad93c9ea60272507db1a2d2089bbb67540ff6e291f98bcf5df4bc89010204010000030d00000000196c8e1000000000fe00");
    expect(signed,
        "013d9f019c1189ba8ef9971877cafdd7542a1b832696ce3b9a085de16b470a2736766f35fd3038c2612a7dfda02d43a7005915886666633784010116f9b635e1038001000204f6c1dacc8b174b10dac187bb1ee7fed819b77e84591dc1827dc38943a5dbbd767e2472c5129c3b712a778535721fc7490afae188b8719897cda512071501901e0277a6af97339b7ac88d1892c90446f50002309266f62e53c1182449820000000000000000000000000000000000000000000000000000000000000000000000e66f07ae6ad93c9ea60272507db1a2d2089bbb67540ff6e291f98bcf5df4bc89010204010000030d00000000196c8e1000000000fe00");
  });
}

void _freezeLookupTable() {
  test("freezeLookupTable", () {
    final owner = QuickWalletForTest(index: 406);
    const blockHash = "GWWy2aAev5X3TMRVwdw8W2KMN3dyVrHrQMZukGTf9R1A";
    final tableAddress =
        AddressLookupTableProgramUtils.findAddressLookupTableProgram(
            authority: owner.address, recentSlot: BigInt.from(277777145));
    final program = AddressLookupTableProgram.freezeLookupTable(
        authority: owner.address, lookupTable: tableAddress.address);
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
        "8001000103f6c1dacc8b174b10dac187bb1ee7fed819b77e84591dc1827dc38943a5dbbd760e662ddb6836d891e4d1d6d13086c47007011e0dbcc953c7f197de1c75a377bb0277a6af97339b7ac88d1892c90446f50002309266f62e53c118244982000000e66f07ae6ad93c9ea60272507db1a2d2089bbb67540ff6e291f98bcf5df4bc890102020100040100000000");
    expect(signed,
        "018341d4da47358c283aba2539276dd574a6d6ecf104b139fe2f4ddfa8861fb92fc364a48ddc6f5f0ee6ab03820cec7e5f0505d3811d5cb21fd993b759f5686b008001000103f6c1dacc8b174b10dac187bb1ee7fed819b77e84591dc1827dc38943a5dbbd760e662ddb6836d891e4d1d6d13086c47007011e0dbcc953c7f197de1c75a377bb0277a6af97339b7ac88d1892c90446f50002309266f62e53c118244982000000e66f07ae6ad93c9ea60272507db1a2d2089bbb67540ff6e291f98bcf5df4bc890102020100040100000000");
  });
}

void _extendLookupTable() {
  test("extendLookupTable", () {
    final owner = QuickWalletForTest(index: 406);
    final account1 = QuickWalletForTest(index: 405);

    const blockHash = "GWWy2aAev5X3TMRVwdw8W2KMN3dyVrHrQMZukGTf9R1A";
    final tableAddress =
        AddressLookupTableProgramUtils.findAddressLookupTableProgram(
            authority: owner.address, recentSlot: BigInt.from(277777145));
    final layout = AddressExtendLookupTableLayout(
        addresses: [owner.address, account1.address]);

    final program = AddressLookupTableProgram.extendLookupTable(
        authority: owner.address,
        lookupTable: tableAddress.address,
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
    expect(unsigned,
        "8001000103f6c1dacc8b174b10dac187bb1ee7fed819b77e84591dc1827dc38943a5dbbd760e662ddb6836d891e4d1d6d13086c47007011e0dbcc953c7f197de1c75a377bb0277a6af97339b7ac88d1892c90446f50002309266f62e53c118244982000000e66f07ae6ad93c9ea60272507db1a2d2089bbb67540ff6e291f98bcf5df4bc8901020201004c020000000200000000000000f6c1dacc8b174b10dac187bb1ee7fed819b77e84591dc1827dc38943a5dbbd763d0427568db5811754651851ae1b5823d52b700fc835078241871ab2b0ca505d00");
    expect(signed,
        "0126fdd06f78ce01b77769f94ac428630914670dc16bd9ca14e79c616bf3d983727a6cb23fed22cbf729ae287a641ec0c6bb0dd6b28090020bafaf4913fde57a008001000103f6c1dacc8b174b10dac187bb1ee7fed819b77e84591dc1827dc38943a5dbbd760e662ddb6836d891e4d1d6d13086c47007011e0dbcc953c7f197de1c75a377bb0277a6af97339b7ac88d1892c90446f50002309266f62e53c118244982000000e66f07ae6ad93c9ea60272507db1a2d2089bbb67540ff6e291f98bcf5df4bc8901020201004c020000000200000000000000f6c1dacc8b174b10dac187bb1ee7fed819b77e84591dc1827dc38943a5dbbd763d0427568db5811754651851ae1b5823d52b700fc835078241871ab2b0ca505d00");
  });
}

void _deactivateLookupTable() {
  test("deactivateLookupTable", () {
    final owner = QuickWalletForTest(index: 406);
    const blockHash = "GWWy2aAev5X3TMRVwdw8W2KMN3dyVrHrQMZukGTf9R1A";
    final tableAddress =
        AddressLookupTableProgramUtils.findAddressLookupTableProgram(
            authority: owner.address, recentSlot: BigInt.from(277777145));

    final program = AddressLookupTableProgram.deactivateLookupTable(
        authority: owner.address, lookupTable: tableAddress.address);

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
        "8001000103f6c1dacc8b174b10dac187bb1ee7fed819b77e84591dc1827dc38943a5dbbd760e662ddb6836d891e4d1d6d13086c47007011e0dbcc953c7f197de1c75a377bb0277a6af97339b7ac88d1892c90446f50002309266f62e53c118244982000000e66f07ae6ad93c9ea60272507db1a2d2089bbb67540ff6e291f98bcf5df4bc890102020100040300000000");
    expect(signed,
        "01176c702274331cb1b7a4d8c7b12e9b56d5c6a02df7ddd3ea94a1d7bc7322ed286c7748c71b1f992929b5bc97427d403ea7f7b74264bb874a5dce69389a3147058001000103f6c1dacc8b174b10dac187bb1ee7fed819b77e84591dc1827dc38943a5dbbd760e662ddb6836d891e4d1d6d13086c47007011e0dbcc953c7f197de1c75a377bb0277a6af97339b7ac88d1892c90446f50002309266f62e53c118244982000000e66f07ae6ad93c9ea60272507db1a2d2089bbb67540ff6e291f98bcf5df4bc890102020100040300000000");
  });
}

void _closeLookupTable() {
  test("closeLookupTable", () {
    final owner = QuickWalletForTest(index: 406);
    final account1 = QuickWalletForTest(index: 405);
    const blockHash = "GWWy2aAev5X3TMRVwdw8W2KMN3dyVrHrQMZukGTf9R1A";
    final tableAddress =
        AddressLookupTableProgramUtils.findAddressLookupTableProgram(
            authority: owner.address, recentSlot: BigInt.from(277777145));

    final program = AddressLookupTableProgram.closeLookupTable(
        authority: owner.address,
        lookupTable: tableAddress.address,
        recipient: account1.address);

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
        "8001000104f6c1dacc8b174b10dac187bb1ee7fed819b77e84591dc1827dc38943a5dbbd760e662ddb6836d891e4d1d6d13086c47007011e0dbcc953c7f197de1c75a377bb3d0427568db5811754651851ae1b5823d52b700fc835078241871ab2b0ca505d0277a6af97339b7ac88d1892c90446f50002309266f62e53c118244982000000e66f07ae6ad93c9ea60272507db1a2d2089bbb67540ff6e291f98bcf5df4bc89010303010002040400000000");
    expect(signed,
        "018bbee3600d167f7fd47236e0ed4ef43ea4f73e13fcc8677bb58a019a68ff34192f87f72ddbadb2070185f9336c099faec160e7b314a086fdbe463258e7771d028001000104f6c1dacc8b174b10dac187bb1ee7fed819b77e84591dc1827dc38943a5dbbd760e662ddb6836d891e4d1d6d13086c47007011e0dbcc953c7f197de1c75a377bb3d0427568db5811754651851ae1b5823d52b700fc835078241871ab2b0ca505d0277a6af97339b7ac88d1892c90446f50002309266f62e53c118244982000000e66f07ae6ad93c9ea60272507db1a2d2089bbb67540ff6e291f98bcf5df4bc89010303010002040400000000");
  });
}
