import 'package:on_chain/solana/solana.dart';
import 'package:test/test.dart';

final List<int> _proof1 = List<int>.filled(32, 10);
final List<int> _proof2 = List<int>.filled(32, 20);
final List<int> _proof3 = List<int>.filled(32, 30);
const SolAddress _owner =
    SolAddress.unchecked("HcEjuQ7Eate3eyNBaZV2cwATcdAH8F7VGygVqkkoqUjf");
const SolAddress _account1 =
    SolAddress.unchecked("57BYVwU1nZvkDkQZvqnNL71SE4jvegfGoEr6Eo6QgNyJ");
void main() {
  group("gumdrop", () {
    _claim();
    _claimCandy();
    _claimCandyProven();
    _claimEdition();
    _closeDistributor();
    _closeDistributorTokenAccount();
    _newDistributor();
    _proveClaim();
    _recoverUpdateAuthority();
    _merkleDistributor();
    _config();
    _claimStatus();
    _candyMachine();
    _claimProof();
    _claimCount();
  });
}

void _claim() {
  test("claim", () {
    final layout = MetaplexGumdropClaimLayout(
      bump: 1,
      index: BigInt.from(222),
      amount: BigInt.from(333),
      claimantSecret: _owner,
      proof: [_proof1, _proof2, _proof3],
    );
    expect(layout.toHex(),
        "3ec6d6c1d59f6cd201de000000000000004d01000000000000f6c1dacc8b174b10dac187bb1ee7fed819b77e84591dc1827dc38943a5dbbd76030000000a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a14141414141414141414141414141414141414141414141414141414141414141e1e1e1e1e1e1e1e1e1e1e1e1e1e1e1e1e1e1e1e1e1e1e1e1e1e1e1e1e1e1e1e");
    final decode = MetaplexGumdropClaimLayout.fromBuffer(layout.toBytes());
    expect(decode.toBytes(), layout.toBytes());
  });
}

void _claimCandy() {
  test("claimCandy", () {
    final layout = MetaplexGumdropClaimCandyLayout(
      claimBump: 1,
      walletBump: 253,
      index: BigInt.from(222),
      amount: BigInt.from(333),
      claimantSecret: _owner,
      proof: [_proof1, _proof2, _proof3],
    );
    expect(layout.toHex(),
        "57b0b15a885f53f2fd01de000000000000004d01000000000000f6c1dacc8b174b10dac187bb1ee7fed819b77e84591dc1827dc38943a5dbbd76030000000a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a14141414141414141414141414141414141414141414141414141414141414141e1e1e1e1e1e1e1e1e1e1e1e1e1e1e1e1e1e1e1e1e1e1e1e1e1e1e1e1e1e1e1e");
    final decode = MetaplexGumdropClaimCandyLayout.fromBuffer(layout.toBytes());
    expect(decode.toBytes(), layout.toBytes());
  });
}

void _claimCandyProven() {
  test("claimCandyProven", () {
    final layout = MetaplexGumdropClaimCandyProvenLayout(
        claimBump: 1, walletBump: 253, index: BigInt.from(222));
    expect(layout.toHex(), "01021efc91e44391fd01de00000000000000");
    final decode =
        MetaplexGumdropClaimCandyProvenLayout.fromBuffer(layout.toBytes());
    expect(decode.toBytes(), layout.toBytes());
  });
}

void _claimEdition() {
  test("claimEdition", () {
    final layout = MetaplexGumdropClaimEditionLayout(
        claimBump: 1,
        edition: BigInt.from(2222222),
        index: BigInt.from(222),
        amount: BigInt.from(333),
        claimantSecret: _owner,
        proof: [_proof1, _proof2, _proof3]);
    expect(layout.toHex(),
        "96537cb4352390f801de000000000000004d010000000000008ee8210000000000f6c1dacc8b174b10dac187bb1ee7fed819b77e84591dc1827dc38943a5dbbd76030000000a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a14141414141414141414141414141414141414141414141414141414141414141e1e1e1e1e1e1e1e1e1e1e1e1e1e1e1e1e1e1e1e1e1e1e1e1e1e1e1e1e1e1e1e");
    final decode =
        MetaplexGumdropClaimEditionLayout.fromBuffer(layout.toBytes());
    expect(decode.toBytes(), layout.toBytes());
  });
}

void _closeDistributor() {
  test("closeDistributor", () {
    const layout =
        MetaplexGumdropCloseDistributorLayout(walletBump: 253, bump: 1);
    expect(layout.toHex(), "ca38b48f2e686a7001fd");
    final decode =
        MetaplexGumdropCloseDistributorLayout.fromBuffer(layout.toBytes());
    expect(decode.toBytes(), layout.toBytes());
  });
}

void _closeDistributorTokenAccount() {
  test("closeDistributorTokenAccount", () {
    const layout = MetaplexGumdropCloseDistributorTokenAccountLayout(bump: 1);
    expect(layout.toHex(), "9cae99786696868e01");
    final decode = MetaplexGumdropCloseDistributorTokenAccountLayout.fromBuffer(
        layout.toBytes());
    expect(decode.toBytes(), layout.toBytes());
  });
}

void _newDistributor() {
  test("newDistributor", () {
    final layout = MetaplexGumdropNewDistributorLayout(
        bump: 1, root: _proof1, temporal: _owner);
    expect(layout.toHex(),
        "208b70ab0002e19b010a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0af6c1dacc8b174b10dac187bb1ee7fed819b77e84591dc1827dc38943a5dbbd76");
    final decode =
        MetaplexGumdropNewDistributorLayout.fromBuffer(layout.toBytes());
    expect(decode.toBytes(), layout.toBytes());
  });
}

void _proveClaim() {
  test("proveClaim", () {
    final layout = MetaplexGumdropProveClaimLayout(
      claimBump: 253,
      index: BigInt.from(222),
      amount: BigInt.from(333),
      claimantSecret: _owner,
      claimPrefix: _proof2,
      resourceNonce: _proof3,
      resource: _account1,
      proof: [_proof1, _proof2, _proof3],
    );
    expect(layout.toHex(),
        "34527be0288be6b8200000001414141414141414141414141414141414141414141414141414141414141414fdde000000000000004d01000000000000f6c1dacc8b174b10dac187bb1ee7fed819b77e84591dc1827dc38943a5dbbd763d0427568db5811754651851ae1b5823d52b700fc835078241871ab2b0ca505d200000001e1e1e1e1e1e1e1e1e1e1e1e1e1e1e1e1e1e1e1e1e1e1e1e1e1e1e1e1e1e1e1e030000000a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a14141414141414141414141414141414141414141414141414141414141414141e1e1e1e1e1e1e1e1e1e1e1e1e1e1e1e1e1e1e1e1e1e1e1e1e1e1e1e1e1e1e1e");
    final decode = MetaplexGumdropProveClaimLayout.fromBuffer(layout.toBytes());
    expect(decode.toBytes(), layout.toBytes());
  });
}

void _recoverUpdateAuthority() {
  test("recoverUpdateAuthority", () {
    const layout =
        MetaplexGumdropRecoverUpdateAuthorityLayout(bump: 1, walletBump: 253);
    expect(layout.toHex(), "8efbd174576424bf01fd");
    final decode = MetaplexGumdropRecoverUpdateAuthorityLayout.fromBuffer(
        layout.toBytes());
    expect(decode.toBytes(), layout.toBytes());
  });
}

void _merkleDistributor() {
  test("MerkleDistributor", () {
    final layout = MerkleDistributor(
      base: _owner,
      bump: 1,
      root: _proof1,
      temporal: _account1,
    );
    expect(layout.toHex(),
        "4d778b4654f70c1af6c1dacc8b174b10dac187bb1ee7fed819b77e84591dc1827dc38943a5dbbd76010a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a3d0427568db5811754651851ae1b5823d52b700fc835078241871ab2b0ca505d");
    final decode = MerkleDistributor.fromBuffer(layout.toBytes());
    expect(decode.toBytes(), layout.toBytes());
  });
}

void _config() {
  test("config", () {
    final layout = GumdropConfig(
        authority: _owner,
        data: GumdropConfigData(
          uuid: "uuid",
          symbol: "MRT",
          sellerFeeBasisPoints: 1,
          creators: [],
          maxSupply: BigInt.from(1111),
          isMutable: true,
          retainAuthority: false,
          maxNumberOfLines: 11,
        ));
    expect(layout.toHex(),
        "9b0caae01efacc82f6c1dacc8b174b10dac187bb1ee7fed819b77e84591dc1827dc38943a5dbbd760400000075756964030000004d5254010000000000570400000000000001000b000000");
    final decode = GumdropConfig.fromBuffer(layout.toBytes());
    expect(decode.toBytes(), layout.toBytes());
  });
  test("config_1", () {
    final layout = GumdropConfig(
        authority: _owner,
        data: GumdropConfigData(
          uuid: "uuid",
          symbol: "MRT",
          sellerFeeBasisPoints: 1,
          creators: [
            const Creator(address: _account1, verified: false, share: 0)
          ],
          maxSupply: BigInt.from(1111),
          isMutable: true,
          retainAuthority: false,
          maxNumberOfLines: 11,
        ));
    expect(layout.toHex(),
        "9b0caae01efacc82f6c1dacc8b174b10dac187bb1ee7fed819b77e84591dc1827dc38943a5dbbd760400000075756964030000004d52540100010000003d0427568db5811754651851ae1b5823d52b700fc835078241871ab2b0ca505d0000570400000000000001000b000000");
    final decode = GumdropConfig.fromBuffer(layout.toBytes());
    expect(decode.toBytes(), layout.toBytes());
  });
}

void _claimStatus() {
  test("ClaimStatus", () {
    final layout = ClaimStatus(
      isClaimed: false,
      claimant: _owner,
      claimedAt: BigInt.from(22222),
      amount: BigInt.from(33333),
    );
    expect(layout.toHex(),
        "16b7f99df75f966000f6c1dacc8b174b10dac187bb1ee7fed819b77e84591dc1827dc38943a5dbbd76ce560000000000003582000000000000");
    final decode = ClaimStatus.fromBuffer(layout.toBytes());
    expect(decode.toBytes(), layout.toBytes());
  });
}

void _claimProof() {
  test("claimProof", () {
    final layout = ClaimProof(
      amount: BigInt.from(555),
      count: BigInt.from(6666),
      claimant: _owner,
      resource: _account1,
      resourceNonce: _proof1,
    );
    expect(layout.toHex(),
        "30adb089357428702b020000000000000a1a000000000000f6c1dacc8b174b10dac187bb1ee7fed819b77e84591dc1827dc38943a5dbbd763d0427568db5811754651851ae1b5823d52b700fc835078241871ab2b0ca505d200000000a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a");
    final decode = ClaimProof.fromBuffer(layout.toBytes());
    expect(decode.toBytes(), layout.toBytes());
  });
}

void _claimCount() {
  test("claimCount", () {
    final layout = ClaimCount(
      count: BigInt.from(111111),
      claimant: _owner,
    );
    expect(layout.toHex(),
        "4e86dcd5229866a707b2010000000000f6c1dacc8b174b10dac187bb1ee7fed819b77e84591dc1827dc38943a5dbbd76");
    final decode = ClaimCount.fromBuffer(layout.toBytes());
    expect(decode.toBytes(), layout.toBytes());
  });
}

void _candyMachine() {
  test("CandyMachine", () {
    final layout = GumdropCandyMachine(
      authority: _owner,
      wallet: _account1,
      tokenMint: null, // beet.COption < web3.PublicKey >;
      config: _account1,
      data: GumdropCandyMachineData(
        uuid: "MRT",
        price: BigInt.from(11111),
        itemsAvailable: BigInt.zero,
        goLiveDate: null,
      ), // beet.COption < beet.bignum >;),
      itemsRedeemed: BigInt.from(333333),
      bump: 12,
    );
    expect(layout.toHex(),
        "33adb17119f16dbdf6c1dacc8b174b10dac187bb1ee7fed819b77e84591dc1827dc38943a5dbbd763d0427568db5811754651851ae1b5823d52b700fc835078241871ab2b0ca505d003d0427568db5811754651851ae1b5823d52b700fc835078241871ab2b0ca505d030000004d5254672b00000000000000000000000000000015160500000000000c");
    final decode = GumdropCandyMachine.fromBuffer(layout.toBytes());
    expect(decode.toBytes(), layout.toBytes());
  });
  test("CandyMachine_1", () {
    final layout = GumdropCandyMachine(
      authority: _owner,
      wallet: _account1,
      tokenMint: _owner, // beet.COption < web3.PublicKey >;
      config: _account1,
      data: GumdropCandyMachineData(
        uuid: "MRT",
        price: BigInt.from(11111),
        itemsAvailable: BigInt.zero,
        goLiveDate: null,
      ), // beet.COption < beet.bignum >;),
      itemsRedeemed: BigInt.from(333333),
      bump: 12,
    );
    expect(layout.toHex(),
        "33adb17119f16dbdf6c1dacc8b174b10dac187bb1ee7fed819b77e84591dc1827dc38943a5dbbd763d0427568db5811754651851ae1b5823d52b700fc835078241871ab2b0ca505d01f6c1dacc8b174b10dac187bb1ee7fed819b77e84591dc1827dc38943a5dbbd763d0427568db5811754651851ae1b5823d52b700fc835078241871ab2b0ca505d030000004d5254672b00000000000000000000000000000015160500000000000c");
    final decode = GumdropCandyMachine.fromBuffer(layout.toBytes());
    expect(decode.toBytes(), layout.toBytes());
  });
  test("CandyMachine_2", () {
    final layout = GumdropCandyMachine(
      authority: _owner,
      wallet: _account1,
      tokenMint: _owner,
      config: _account1,
      data: GumdropCandyMachineData(
        uuid: "MRT",
        price: BigInt.from(11111),
        itemsAvailable: BigInt.zero,
        goLiveDate: BigInt.from(1111222),
      ),
      itemsRedeemed: BigInt.from(333333),
      bump: 12,
    );
    expect(layout.toHex(),
        "33adb17119f16dbdf6c1dacc8b174b10dac187bb1ee7fed819b77e84591dc1827dc38943a5dbbd763d0427568db5811754651851ae1b5823d52b700fc835078241871ab2b0ca505d01f6c1dacc8b174b10dac187bb1ee7fed819b77e84591dc1827dc38943a5dbbd763d0427568db5811754651851ae1b5823d52b700fc835078241871ab2b0ca505d030000004d5254672b000000000000000000000000000001b6f410000000000015160500000000000c");
    final decode = GumdropCandyMachine.fromBuffer(layout.toBytes());
    expect(decode.toBytes(), layout.toBytes());
  });
}
