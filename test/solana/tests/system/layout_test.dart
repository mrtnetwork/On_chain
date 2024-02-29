import 'package:test/test.dart';
import 'package:on_chain/solana/solana.dart';

void main() {
  group("layouts", () {
    _create();
    _createWithSeed();
    _transfer();
    _transferWithSeed();
    _assign();
    _assignWithSeed();
    _nonceInitialize();
    _nonceAdvance();
    _nonceWithdraw();
    _nonceAuthorize();
    _allocate();
    _allocateWithSeed();
  });
}

void _create() {
  test("create", () {
    final createProgram = SystemCreateLayout(
        lamports: BigInt.from(250000000),
        programId: SystemProgramConst.programId,
        space: BigInt.from(200));
    expect(createProgram.toHex(),
        "0000000080b2e60e00000000c8000000000000000000000000000000000000000000000000000000000000000000000000000000");
    final decode = SystemCreateLayout.fromBuffer(createProgram.toBytes());
    expect(decode.toBytes(), createProgram.toBytes());
  });
}

void _createWithSeed() {
  test("createWithSeed", () {
    final String seed = "account1";
    // final blockHash = await owner.recentBlockhash();
    final layout = SystemCreateWithSeedLayout(
        lamports: BigInt.from(250000000),
        programId: SystemProgramConst.programId,
        space: BigInt.from(200),
        seed: seed,
        base: SolAddress("527pWSWfeQGLM7SoyVXjCRkrSZBtDkH6ShEBJB3nUDkA"));
    expect(layout.toHex(),
        "030000003bb809f4c65f4bd79708f7b52b94f2e17a878c779d420c29d728844a83eec5bf08000000000000006163636f756e743180b2e60e00000000c8000000000000000000000000000000000000000000000000000000000000000000000000000000");
    final decode = SystemCreateWithSeedLayout.fromBuffer(layout.toBytes());
    expect(decode.toBytes(), layout.toBytes());
  });
}

void _transfer() {
  test("transfer", () {
    final layout = SystemTransferLayout(
      lamports: SolanaUtils.toLamports("0.001"),
    );
    expect(layout.toHex(), "0200000040420f0000000000");
    final decode = SystemTransferLayout.fromBuffer(layout.toBytes());
    expect(decode.toBytes(), layout.toBytes());
  });
}

void _transferWithSeed() {
  test("transferWithSeed", () {
    final String seed = "account1";
    final layout = SystemTransferWithSeedLayout(
        lamports: SolanaUtils.toLamports("0.001"),
        seed: seed,
        programId: SystemProgramConst.programId);
    expect(layout.toHex(),
        "0b00000040420f000000000008000000000000006163636f756e74310000000000000000000000000000000000000000000000000000000000000000");
    final decode = SystemTransferWithSeedLayout.fromBuffer(layout.toBytes());
    expect(decode.toBytes(), layout.toBytes());
  });
}

void _assign() {
  test("assign", () {
    final layout = SystemAssignLayout(programId: SystemProgramConst.programId);
    expect(layout.toHex(),
        "010000000000000000000000000000000000000000000000000000000000000000000000");
    final decode = SystemAssignLayout.fromBuffer(layout.toBytes());
    expect(decode.toBytes(), layout.toBytes());
  });
}

void _assignWithSeed() {
  test("assignWithSeed", () {
    final owner = SolAddress("527pWSWfeQGLM7SoyVXjCRkrSZBtDkH6ShEBJB3nUDkA");
    final layout = SystemAssignWithSeedLayout(
        programId: SystemProgramConst.programId, base: owner, seed: "account1");
    expect(layout.toHex(),
        "0a0000003bb809f4c65f4bd79708f7b52b94f2e17a878c779d420c29d728844a83eec5bf08000000000000006163636f756e74310000000000000000000000000000000000000000000000000000000000000000");
    final decode = SystemAssignWithSeedLayout.fromBuffer(layout.toBytes());
    expect(decode.toBytes(), layout.toBytes());
  });
}

void _nonceInitialize() {
  test("nonceInitialize", () {
    final owner = SolAddress("527pWSWfeQGLM7SoyVXjCRkrSZBtDkH6ShEBJB3nUDkA");
    final layout = SystemInitializeNonceAccountLayout(authorized: owner);
    expect(layout.toHex(),
        "060000003bb809f4c65f4bd79708f7b52b94f2e17a878c779d420c29d728844a83eec5bf");
    final decode =
        SystemInitializeNonceAccountLayout.fromBuffer(layout.toBytes());
    expect(decode.toBytes(), layout.toBytes());
  });
}

void _nonceAdvance() {
  test("nonceAdvance", () {
    final layout = SystemAdvanceNonceLayout();
    expect(layout.toHex(), "04000000");
    final decode = SystemAdvanceNonceLayout.fromBuffer(layout.toBytes());
    expect(decode.toBytes(), layout.toBytes());
  });
}

void _nonceWithdraw() {
  test("nonceWithdraw", () {
    final layout = SystemWithdrawNonceLayout(lamports: BigInt.from(10000000));
    expect(layout.toHex(), "050000008096980000000000");
    final decode = SystemWithdrawNonceLayout.fromBuffer(layout.toBytes());
    expect(decode.toBytes(), layout.toBytes());
  });
}

void _nonceAuthorize() {
  test("nonceAuthorize", () {
    final owner = SolAddress("527pWSWfeQGLM7SoyVXjCRkrSZBtDkH6ShEBJB3nUDkA");
    final layout = SystemAuthorizeNonceAccountLayout(authorized: owner);
    expect(layout.toHex(),
        "070000003bb809f4c65f4bd79708f7b52b94f2e17a878c779d420c29d728844a83eec5bf");
    final decode =
        SystemAuthorizeNonceAccountLayout.fromBuffer(layout.toBytes());
    expect(decode.toBytes(), layout.toBytes());
  });
}

void _allocate() {
  test("allocate", () {
    final layout = SystemAllocateLayout(space: BigInt.from(350));
    expect(layout.toHex(), "080000005e01000000000000");
    final decode = SystemAllocateLayout.fromBuffer(layout.toBytes());
    expect(decode.toBytes(), layout.toBytes());
  });
}

void _allocateWithSeed() {
  test("allocateWithcSeed", () {
    final layout = SystemAllocateWithSeedLayout(
        space: BigInt.from(350),
        base: SolAddress("527pWSWfeQGLM7SoyVXjCRkrSZBtDkH6ShEBJB3nUDkA"),
        programId: SystemProgramConst.programId,
        seed: "account1");
    expect(layout.toHex(),
        "090000003bb809f4c65f4bd79708f7b52b94f2e17a878c779d420c29d728844a83eec5bf08000000000000006163636f756e74315e010000000000000000000000000000000000000000000000000000000000000000000000000000");
    final decode = SystemAllocateWithSeedLayout.fromBuffer(layout.toBytes());
    expect(decode.toBytes(), layout.toBytes());
  });
}
