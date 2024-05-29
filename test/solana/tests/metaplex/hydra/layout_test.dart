import 'package:on_chain/solana/solana.dart';
import 'package:test/test.dart';

const _owner =
    SolAddress.unchecked("HcEjuQ7Eate3eyNBaZV2cwATcdAH8F7VGygVqkkoqUjf");
void main() {
  group("hydra", () {
    _addMemberNft();
    _addMemberWallet();
    _distributeNft();
    _distributeToken();
    _distributeWallet();
    _init();
    _initForMint();
    _removeMember();
    _setForTokenMemberStake();
    _setTokenMemberStake();
    _signMetadata();
    _transferShares();
    _unstake();
    _fanout();
    _fanoutMembershipVoucher();
    _fanoutMembershipMintVoucher();
    _fanoutMint();
  });
}

void _addMemberNft() {
  test("addMemberNft", () {
    final layout = MetaplexHydraAddMemberNftLayout(shares: BigInt.one);
    expect(layout.toHex(), "5cff69d1192903070100000000000000");
    final decode = MetaplexHydraAddMemberNftLayout.fromBuffer(layout.toBytes());
    expect(decode.toBytes(), layout.toBytes());
  });
}

void _addMemberWallet() {
  test("addMemberWallet", () {
    final layout = MetaplexHydraAddMemberWalletLayout(shares: BigInt.one);
    expect(layout.toHex(), "c9093b804575dceb0100000000000000");
    final decode =
        MetaplexHydraAddMemberWalletLayout.fromBuffer(layout.toBytes());
    expect(decode.toBytes(), layout.toBytes());
  });
}

void _distributeNft() {
  test("distributeNft", () {
    const layout = MetaplexHydraDistributeNftLayout(distributeForMint: true);
    expect(layout.toHex(), "6cf0445190533a9901");
    final decode =
        MetaplexHydraDistributeNftLayout.fromBuffer(layout.toBytes());
    expect(decode.toBytes(), layout.toBytes());
  });
}

void _distributeToken() {
  test("distributeToken", () {
    const layout = MetaplexHydraDistributeTokenLayout(distributeForMint: true);
    expect(layout.toHex(), "7e692e871c2475d401");
    final decode =
        MetaplexHydraDistributeTokenLayout.fromBuffer(layout.toBytes());
    expect(decode.toBytes(), layout.toBytes());
  });
}

void _distributeWallet() {
  test("distributeWallet", () {
    const layout = MetaplexHydraDistributeWalletLayout(distributeForMint: true);
    expect(layout.toHex(), "fca8a74228c9b6a301");
    final decode =
        MetaplexHydraDistributeWalletLayout.fromBuffer(layout.toBytes());
    expect(decode.toBytes(), layout.toBytes());
  });
}

void _init() {
  test("init", () {
    final layout = MetaplexHydraInitLayout(
        bumpSeed: 1,
        nativeAccountBumpSeed: 12,
        name: "mrt",
        totalShares: BigInt.from(1111),
        membershipModel: MembershipModel.nft);
    expect(
        layout.toHex(), "ac05a58f569f32ed010c030000006d7274570400000000000002");
    final decode = MetaplexHydraInitLayout.fromBuffer(layout.toBytes());
    expect(decode.toBytes(), layout.toBytes());
  });
}

void _initForMint() {
  test("initForMint", () {
    const layout = MetaplexHydraInitForMintLayout(bumpSeed: 1);
    expect(layout.toHex(), "8c96e8c35ddb23aa01");
    final decode = MetaplexHydraInitForMintLayout.fromBuffer(layout.toBytes());
    expect(decode.toBytes(), layout.toBytes());
  });
}

void _removeMember() {
  test("removeMember", () {
    const layout = MetaplexHydraRemoveMemberLayout();
    expect(layout.toHex(), "092d24a3f5289655");
    final decode = MetaplexHydraRemoveMemberLayout.fromBuffer(layout.toBytes());
    expect(decode.toBytes(), layout.toBytes());
  });
}

void _setForTokenMemberStake() {
  test("setForTokenMemberStake", () {
    final layout =
        MetaplexHydraSetForTokenMemberStakeLayout(shares: BigInt.one);
    expect(layout.toHex(), "d22806fe02509a6d0100000000000000");
    final decode =
        MetaplexHydraSetForTokenMemberStakeLayout.fromBuffer(layout.toBytes());
    expect(decode.toBytes(), layout.toBytes());
  });
}

void _setTokenMemberStake() {
  test("setTokenMemberStake", () {
    final layout = MetaplexHydraSetTokenMemberStakeLayout(shares: BigInt.one);
    expect(layout.toHex(), "a71d0c1e2cc1f98e0100000000000000");
    final decode =
        MetaplexHydraSetTokenMemberStakeLayout.fromBuffer(layout.toBytes());
    expect(decode.toBytes(), layout.toBytes());
  });
}

void _signMetadata() {
  test("signMetadata", () {
    const layout = MetaplexHydraSignMetadataLayout();
    expect(layout.toHex(), "bc43a33100963f59");
    final decode = MetaplexHydraSignMetadataLayout.fromBuffer(layout.toBytes());
    expect(decode.toBytes(), layout.toBytes());
  });
}

void _transferShares() {
  test("transferShares", () {
    final layout = MetaplexHydraTransferSharesLayout(shares: BigInt.one);
    expect(layout.toHex(), "c3af243265161c570100000000000000");
    final decode =
        MetaplexHydraTransferSharesLayout.fromBuffer(layout.toBytes());
    expect(decode.toBytes(), layout.toBytes());
  });
}

void _unstake() {
  test("unstake", () {
    const layout = MetaplexHydraUnstakeLayout();
    expect(layout.toHex(), "d9a088ae953e4f85");
    final decode = MetaplexHydraUnstakeLayout.fromBuffer(layout.toBytes());
    expect(decode.toBytes(), layout.toBytes());
  });
}

void _fanout() {
  test("fanout", () {
    final layout = Fanout(
      name: "mrtnetwork",
      accountKey: _owner,
      authority: _owner,
      totalShares: BigInt.from(111),
      totalMembers: BigInt.from(22222),
      totalInflow: BigInt.from(333),
      lastSnapshotAmount: BigInt.from(444),
      bumpSeed: 1,
      accountOwnerBumpSeed: 2,
      totalAvailableShares: BigInt.from(5555),
      membershipModel: MembershipModel.nft,
    );
    expect(layout.toHex(),
        "a465d25cde0e4b9cf6c1dacc8b174b10dac187bb1ee7fed819b77e84591dc1827dc38943a5dbbd760a0000006d72746e6574776f726bf6c1dacc8b174b10dac187bb1ee7fed819b77e84591dc1827dc38943a5dbbd766f00000000000000ce560000000000004d01000000000000bc010000000000000102b315000000000000020000");
    final decode = Fanout.fromBuffer(layout.toBytes());
    expect(decode.toBytes(), layout.toBytes());
  });
  test("fanout_1", () {
    final layout = Fanout(
        name: "mrtnetwork",
        accountKey: _owner,
        authority: _owner,
        totalShares: BigInt.from(111),
        totalMembers: BigInt.from(22222),
        totalInflow: BigInt.from(333),
        lastSnapshotAmount: BigInt.from(444),
        bumpSeed: 1,
        accountOwnerBumpSeed: 2,
        totalAvailableShares: BigInt.from(5555),
        membershipModel: MembershipModel.nft,
        membershipMint: _owner);
    expect(layout.toHex(),
        "a465d25cde0e4b9cf6c1dacc8b174b10dac187bb1ee7fed819b77e84591dc1827dc38943a5dbbd760a0000006d72746e6574776f726bf6c1dacc8b174b10dac187bb1ee7fed819b77e84591dc1827dc38943a5dbbd766f00000000000000ce560000000000004d01000000000000bc010000000000000102b3150000000000000201f6c1dacc8b174b10dac187bb1ee7fed819b77e84591dc1827dc38943a5dbbd7600");
    final decode = Fanout.fromBuffer(layout.toBytes());
    expect(decode.toBytes(), layout.toBytes());
  });
  test("fanout_2", () {
    final layout = Fanout(
        name: "mrtnetwork",
        accountKey: _owner,
        authority: _owner,
        totalShares: BigInt.from(111),
        totalMembers: BigInt.from(22222),
        totalInflow: BigInt.from(333),
        lastSnapshotAmount: BigInt.from(444),
        bumpSeed: 1,
        accountOwnerBumpSeed: 2,
        totalAvailableShares: BigInt.from(5555),
        membershipModel: MembershipModel.nft,
        membershipMint: _owner,
        totalStakedShares: BigInt.from(232323));
    expect(layout.toHex(),
        "a465d25cde0e4b9cf6c1dacc8b174b10dac187bb1ee7fed819b77e84591dc1827dc38943a5dbbd760a0000006d72746e6574776f726bf6c1dacc8b174b10dac187bb1ee7fed819b77e84591dc1827dc38943a5dbbd766f00000000000000ce560000000000004d01000000000000bc010000000000000102b3150000000000000201f6c1dacc8b174b10dac187bb1ee7fed819b77e84591dc1827dc38943a5dbbd7601838b030000000000");
    final decode = Fanout.fromBuffer(layout.toBytes());
    expect(decode.toBytes(), layout.toBytes());
  });
}

void _fanoutMembershipMintVoucher() {
  test("fanoutMembershipMintVoucher", () {
    final layout = FanoutMembershipMintVoucher(
      fanout: _owner,
      fanoutMint: _owner,
      lastInflow: BigInt.from(1111111),
      bumpSeed: 244,
    );
    expect(layout.toHex(),
        "b92176ad93727eb5f6c1dacc8b174b10dac187bb1ee7fed819b77e84591dc1827dc38943a5dbbd76f6c1dacc8b174b10dac187bb1ee7fed819b77e84591dc1827dc38943a5dbbd7647f4100000000000f4");
    final decode = FanoutMembershipMintVoucher.fromBuffer(layout.toBytes());
    expect(decode.toBytes(), layout.toBytes());
  });
}

void _fanoutMembershipVoucher() {
  test("fanoutMembershipVoucher", () {
    final layout = FanoutMembershipVoucher(
      fanout: _owner,
      totalInflow: BigInt.one,
      lastInflow: BigInt.two,
      bumpSeed: 3,
      membershipKey: _owner,
      shares: BigInt.from(4),
    );
    expect(layout.toHex(),
        "b93e4a3c699eb27df6c1dacc8b174b10dac187bb1ee7fed819b77e84591dc1827dc38943a5dbbd760100000000000000020000000000000003f6c1dacc8b174b10dac187bb1ee7fed819b77e84591dc1827dc38943a5dbbd760400000000000000");
    final decode = FanoutMembershipVoucher.fromBuffer(layout.toBytes());
    expect(decode.toBytes(), layout.toBytes());
  });
}

void _fanoutMint() {
  test("fanoutMint", () {
    final layout = FanoutMint(
      mint: _owner,
      fanout: _owner,
      tokenAccount: _owner,
      totalInflow: BigInt.one,
      lastSnapshotAmount: BigInt.two,
      bumpSeed: 3,
    );
    expect(layout.toHex(),
        "32a42a6c5ac9fad8f6c1dacc8b174b10dac187bb1ee7fed819b77e84591dc1827dc38943a5dbbd76f6c1dacc8b174b10dac187bb1ee7fed819b77e84591dc1827dc38943a5dbbd76f6c1dacc8b174b10dac187bb1ee7fed819b77e84591dc1827dc38943a5dbbd760100000000000000020000000000000003");
    final decode = FanoutMint.fromBuffer(layout.toBytes());
    expect(decode.toBytes(), layout.toBytes());
  });
}
