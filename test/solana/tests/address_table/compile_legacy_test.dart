import 'package:test/test.dart';
import 'package:on_chain/solana/solana.dart';
import '../../examples/wallet.dart';

void main() {
  group("lookup table compile legacy", () {
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
        type: TransactionType.legacy);
    final unsigned = transaction.serializeMessageString();
    transaction.sign([owner.privateKey]);
    final signed =
        transaction.serializeString(encoding: TransactionSerializeEncoding.hex);
    // final decode = SolanaTransaction.decompile(transaction.serialize());

    expect(unsigned,
        "01000204f6c1dacc8b174b10dac187bb1ee7fed819b77e84591dc1827dc38943a5dbbd767e2472c5129c3b712a778535721fc7490afae188b8719897cda512071501901e0277a6af97339b7ac88d1892c90446f50002309266f62e53c1182449820000000000000000000000000000000000000000000000000000000000000000000000e66f07ae6ad93c9ea60272507db1a2d2089bbb67540ff6e291f98bcf5df4bc89010204010000030d00000000196c8e1000000000fe");
    expect(signed,
        "01d42910371b4ca851701275884e840e8dd94bcec0fc2d147bb98a95d7f055c6c35fb09efc827cd6a2fd5f63f543a2fa6cb03d129d47f8632f2302a0675c17350601000204f6c1dacc8b174b10dac187bb1ee7fed819b77e84591dc1827dc38943a5dbbd767e2472c5129c3b712a778535721fc7490afae188b8719897cda512071501901e0277a6af97339b7ac88d1892c90446f50002309266f62e53c1182449820000000000000000000000000000000000000000000000000000000000000000000000e66f07ae6ad93c9ea60272507db1a2d2089bbb67540ff6e291f98bcf5df4bc89010204010000030d00000000196c8e1000000000fe");
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
        type: TransactionType.legacy);
    final unsigned = transaction.serializeMessageString();
    transaction.sign([owner.privateKey]);
    final signed =
        transaction.serializeString(encoding: TransactionSerializeEncoding.hex);
    expect(unsigned,
        "01000103f6c1dacc8b174b10dac187bb1ee7fed819b77e84591dc1827dc38943a5dbbd760e662ddb6836d891e4d1d6d13086c47007011e0dbcc953c7f197de1c75a377bb0277a6af97339b7ac88d1892c90446f50002309266f62e53c118244982000000e66f07ae6ad93c9ea60272507db1a2d2089bbb67540ff6e291f98bcf5df4bc8901020201000401000000");
    expect(signed,
        "01902efc8328fa4336cb53e3f0a0c219d7ce6abc1e678652b4080acdcd88b3b0b99167508e18de2104c9da66bb75b3b8a72959d806abb6ad769f39bb5fbdc72d0601000103f6c1dacc8b174b10dac187bb1ee7fed819b77e84591dc1827dc38943a5dbbd760e662ddb6836d891e4d1d6d13086c47007011e0dbcc953c7f197de1c75a377bb0277a6af97339b7ac88d1892c90446f50002309266f62e53c118244982000000e66f07ae6ad93c9ea60272507db1a2d2089bbb67540ff6e291f98bcf5df4bc8901020201000401000000");
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
        type: TransactionType.legacy);

    final unsigned = transaction.serializeMessageString();
    transaction.sign([owner.privateKey]);
    final signed =
        transaction.serializeString(encoding: TransactionSerializeEncoding.hex);
    expect(unsigned,
        "01000103f6c1dacc8b174b10dac187bb1ee7fed819b77e84591dc1827dc38943a5dbbd760e662ddb6836d891e4d1d6d13086c47007011e0dbcc953c7f197de1c75a377bb0277a6af97339b7ac88d1892c90446f50002309266f62e53c118244982000000e66f07ae6ad93c9ea60272507db1a2d2089bbb67540ff6e291f98bcf5df4bc8901020201004c020000000200000000000000f6c1dacc8b174b10dac187bb1ee7fed819b77e84591dc1827dc38943a5dbbd763d0427568db5811754651851ae1b5823d52b700fc835078241871ab2b0ca505d");
    expect(signed,
        "016c48c6c7c9fbe3b7b3ed2904d818e873f7f31eedff634a862d694adbfd5e62b75dcf8ca78a7354eba16f596798c3ad071ca905c9014c78468b9efd024801380701000103f6c1dacc8b174b10dac187bb1ee7fed819b77e84591dc1827dc38943a5dbbd760e662ddb6836d891e4d1d6d13086c47007011e0dbcc953c7f197de1c75a377bb0277a6af97339b7ac88d1892c90446f50002309266f62e53c118244982000000e66f07ae6ad93c9ea60272507db1a2d2089bbb67540ff6e291f98bcf5df4bc8901020201004c020000000200000000000000f6c1dacc8b174b10dac187bb1ee7fed819b77e84591dc1827dc38943a5dbbd763d0427568db5811754651851ae1b5823d52b700fc835078241871ab2b0ca505d");
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
        type: TransactionType.legacy);

    final unsigned = transaction.serializeMessageString();
    transaction.sign([owner.privateKey]);
    final signed =
        transaction.serializeString(encoding: TransactionSerializeEncoding.hex);
    expect(unsigned,
        "01000103f6c1dacc8b174b10dac187bb1ee7fed819b77e84591dc1827dc38943a5dbbd760e662ddb6836d891e4d1d6d13086c47007011e0dbcc953c7f197de1c75a377bb0277a6af97339b7ac88d1892c90446f50002309266f62e53c118244982000000e66f07ae6ad93c9ea60272507db1a2d2089bbb67540ff6e291f98bcf5df4bc8901020201000403000000");
    expect(signed,
        "013865071bc1a045550eac4e328adb83490708933ab48aa979262c09cf16e821e0eeb66de2566e6f5459ef8cc5df5b8ce2a09e1b4db19dc10553c60ac9ed62530301000103f6c1dacc8b174b10dac187bb1ee7fed819b77e84591dc1827dc38943a5dbbd760e662ddb6836d891e4d1d6d13086c47007011e0dbcc953c7f197de1c75a377bb0277a6af97339b7ac88d1892c90446f50002309266f62e53c118244982000000e66f07ae6ad93c9ea60272507db1a2d2089bbb67540ff6e291f98bcf5df4bc8901020201000403000000");
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
        type: TransactionType.legacy);

    final unsigned = transaction.serializeMessageString();
    transaction.sign([owner.privateKey]);
    final signed =
        transaction.serializeString(encoding: TransactionSerializeEncoding.hex);
    expect(unsigned,
        "01000104f6c1dacc8b174b10dac187bb1ee7fed819b77e84591dc1827dc38943a5dbbd760e662ddb6836d891e4d1d6d13086c47007011e0dbcc953c7f197de1c75a377bb3d0427568db5811754651851ae1b5823d52b700fc835078241871ab2b0ca505d0277a6af97339b7ac88d1892c90446f50002309266f62e53c118244982000000e66f07ae6ad93c9ea60272507db1a2d2089bbb67540ff6e291f98bcf5df4bc890103030100020404000000");
    expect(signed,
        "0164144b8953ca6dcf4375ef6758fe16852cb7fe8f3a500219f6677b9dd93725d8c169cb02912586c8eb92bf8db12fa6f1503c4d57fe4a05cd22240871a6bfac0001000104f6c1dacc8b174b10dac187bb1ee7fed819b77e84591dc1827dc38943a5dbbd760e662ddb6836d891e4d1d6d13086c47007011e0dbcc953c7f197de1c75a377bb3d0427568db5811754651851ae1b5823d52b700fc835078241871ab2b0ca505d0277a6af97339b7ac88d1892c90446f50002309266f62e53c118244982000000e66f07ae6ad93c9ea60272507db1a2d2089bbb67540ff6e291f98bcf5df4bc890103030100020404000000");
  });
}
