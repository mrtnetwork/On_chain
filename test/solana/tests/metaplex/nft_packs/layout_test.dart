import 'package:on_chain/solana/solana.dart';
import 'package:test/test.dart';

final _owner =
    SolAddress.unchecked("HcEjuQ7Eate3eyNBaZV2cwATcdAH8F7VGygVqkkoqUjf");
void main() {
  group("nftPacks", () {
    _requestCardForRedeem();
    _activate();
    _addCardToPack();
    _addVoucherToPack();
    _claimPack();
    _cleanUp();
    _closePack();
    _deactivate();
    _deletePack();
    _deletePackCard();
    _deletePackConfig();
    _deletePackVoucher();
    _editPack();
    _initPack();
    _transferPackAuthority();
    _provingProcess();
    _packVoucher();
    _packSet();
    _packConfig();
    _packcard();
  });
}

void _activate() {
  test("activate", () {
    final layout = MetaplexNFTPacksActivateLayout();
    expect(layout.toHex(), "03");
    final decode = MetaplexNFTPacksActivateLayout.fromBuffer(layout.toBytes());
    expect(layout.toBytes(), decode.toBytes());
  });
}

void _addCardToPack() {
  test("addCardToPack", () {
    final layout = MetaplexNFTPacksAddCardToPackLayout(
        addCardToPack: AddCardToPack(
      maxSupply: 1,
      weight: 0,
      index: 3,
    ));
    expect(layout.toHex(), "0101000000000003000000");
    final decode =
        MetaplexNFTPacksAddCardToPackLayout.fromBuffer(layout.toBytes());
    expect(layout.toBytes(), decode.toBytes());
  });
}

void _addVoucherToPack() {
  test("addVoucherToPack", () {
    final layout = MetaplexNFTPacksAddVoucherToPackLayout();
    expect(layout.toHex(), "02");
    final decode =
        MetaplexNFTPacksAddVoucherToPackLayout.fromBuffer(layout.toBytes());
    expect(layout.toBytes(), decode.toBytes());
  });
}

void _claimPack() {
  test("claimPack", () {
    final layout = MetaplexNFTPacksClaimPackLayout(index: 1);
    expect(layout.toHex(), "0601000000");
    final decode = MetaplexNFTPacksClaimPackLayout.fromBuffer(layout.toBytes());
    expect(layout.toBytes(), decode.toBytes());
  });
}

void _cleanUp() {
  test("cleanUp", () {
    final layout = MetaplexNFTPacksCleanUpLayout();
    expect(layout.toHex(), "0d");
    final decode = MetaplexNFTPacksCleanUpLayout.fromBuffer(layout.toBytes());
    expect(layout.toBytes(), decode.toBytes());
  });
}

void _closePack() {
  test("closePack", () {
    final layout = MetaplexNFTPacksClosePackLayout();
    expect(layout.toHex(), "05");
    final decode = MetaplexNFTPacksClosePackLayout.fromBuffer(layout.toBytes());
    expect(layout.toBytes(), decode.toBytes());
  });
}

void _deactivate() {
  test("deactivate", () {
    final layout = MetaplexNFTPacksDeactivateLayout();
    expect(layout.toHex(), "04");
    final decode =
        MetaplexNFTPacksDeactivateLayout.fromBuffer(layout.toBytes());
    expect(layout.toBytes(), decode.toBytes());
  });
}

void _deletePack() {
  test("deletePack", () {
    final layout = MetaplexNFTPacksDeletePackLayout();
    expect(layout.toHex(), "08");
    final decode =
        MetaplexNFTPacksDeletePackLayout.fromBuffer(layout.toBytes());
    expect(layout.toBytes(), decode.toBytes());
  });
}

void _deletePackCard() {
  test("deletePackCard", () {
    final layout = MetaplexNFTPacksDeletePackCardLayout();
    expect(layout.toHex(), "09");
    final decode =
        MetaplexNFTPacksDeletePackCardLayout.fromBuffer(layout.toBytes());
    expect(layout.toBytes(), decode.toBytes());
  });
}

void _deletePackConfig() {
  test("deletePackConfig", () {
    final layout = MetaplexNFTPacksDeletePackConfigLayout();
    expect(layout.toHex(), "0e");
    final decode =
        MetaplexNFTPacksDeletePackConfigLayout.fromBuffer(layout.toBytes());
    expect(layout.toBytes(), decode.toBytes());
  });
}

void _deletePackVoucher() {
  test("deletePackVoucher", () {
    final layout = MetaplexNFTPacksDeletePackVoucherLayout();
    expect(layout.toHex(), "0a");
    final decode =
        MetaplexNFTPacksDeletePackVoucherLayout.fromBuffer(layout.toBytes());
    expect(layout.toBytes(), decode.toBytes());
  });
}

void _editPack() {
  test("editPack", () {
    final layout = MetaplexNFTPacksEditPackLayout();
    expect(layout.toHex(), "0b00000000");
    final decode = MetaplexNFTPacksEditPackLayout.fromBuffer(layout.toBytes());
    expect(layout.toBytes(), decode.toBytes());
  });
  test("editPack_1", () {
    final layout =
        MetaplexNFTPacksEditPackLayout(name: List<int>.filled(32, 10));
    expect(layout.toHex(),
        "0b010a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a000000");
    final decode = MetaplexNFTPacksEditPackLayout.fromBuffer(layout.toBytes());
    expect(layout.toBytes(), decode.toBytes());
  });
  test("editPack_2", () {
    final layout = MetaplexNFTPacksEditPackLayout(
        name: List<int>.filled(32, 10), desciption: "mrtnetwork");
    expect(layout.toHex(),
        "0b010a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a010a0000006d72746e6574776f726b0000");
    final decode = MetaplexNFTPacksEditPackLayout.fromBuffer(layout.toBytes());
    expect(layout.toBytes(), decode.toBytes());
  });
  test("editPack_3", () {
    final layout = MetaplexNFTPacksEditPackLayout(
        name: List<int>.filled(32, 10),
        desciption: "mrtnetwork",
        uri: "mrtnetwork");
    expect(layout.toHex(),
        "0b010a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a010a0000006d72746e6574776f726b010a0000006d72746e6574776f726b00");
    final decode = MetaplexNFTPacksEditPackLayout.fromBuffer(layout.toBytes());
    expect(layout.toBytes(), decode.toBytes());
  });
  test("editPack_4", () {
    final layout = MetaplexNFTPacksEditPackLayout(
        name: List<int>.filled(32, 10),
        desciption: "mrtnetwork",
        uri: "mrtnetwork",
        mutable: true);
    expect(layout.toHex(),
        "0b010a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a010a0000006d72746e6574776f726b010a0000006d72746e6574776f726b0101");
    final decode = MetaplexNFTPacksEditPackLayout.fromBuffer(layout.toBytes());
    expect(layout.toBytes(), decode.toBytes());
  });
}

void _initPack() {
  test("initPack", () {
    final layout = MetaplexNFTPacksInitPackLayout(
      name: List.filled(32, 10),
      description: "mrtnetwork",
      uri: "https://github.com/mrtnetwork",
      mutable: false,
      packDistributionType: PackDistributionType.fixed,
      allowedAmountToRedeem: 1,
    );
    expect(layout.toHex(),
        "000a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0000006d72746e6574776f726b1d00000068747470733a2f2f6769746875622e636f6d2f6d72746e6574776f726b0001010000000000");
    final decode = MetaplexNFTPacksInitPackLayout.fromBuffer(layout.toBytes());
    expect(layout.toBytes(), decode.toBytes());
  });
  test("initPack_1", () {
    final layout = MetaplexNFTPacksInitPackLayout(
        name: List.filled(32, 10),
        description: "mrtnetwork",
        uri: "https://github.com/mrtnetwork",
        mutable: false,
        packDistributionType: PackDistributionType.fixed,
        allowedAmountToRedeem: 1,
        redeemStartDate: BigInt.from(222222));
    expect(layout.toHex(),
        "000a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0000006d72746e6574776f726b1d00000068747470733a2f2f6769746875622e636f6d2f6d72746e6574776f726b000101000000010e6403000000000000");
    final decode = MetaplexNFTPacksInitPackLayout.fromBuffer(layout.toBytes());
    expect(layout.toBytes(), decode.toBytes());
  });
  test("initPack_2", () {
    final layout = MetaplexNFTPacksInitPackLayout(
        name: List.filled(32, 10),
        description: "mrtnetwork",
        uri: "https://github.com/mrtnetwork",
        mutable: false,
        packDistributionType: PackDistributionType.fixed,
        allowedAmountToRedeem: 1,
        redeemStartDate: BigInt.from(222222),
        redeemEndDate: BigInt.from(33333));
    expect(layout.toHex(),
        "000a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0000006d72746e6574776f726b1d00000068747470733a2f2f6769746875622e636f6d2f6d72746e6574776f726b000101000000010e64030000000000013582000000000000");
    final decode = MetaplexNFTPacksInitPackLayout.fromBuffer(layout.toBytes());
    expect(layout.toBytes(), decode.toBytes());
  });
}

void _requestCardForRedeem() {
  test("requestCardForRedeem", () {
    final layout = MetaplexNFTPacksRequestCardForRedeemLayout(index: 12);
    expect(layout.toHex(), "0c0c000000");
    final decode =
        MetaplexNFTPacksRequestCardForRedeemLayout.fromBuffer(layout.toBytes());
    expect(layout.toBytes(), decode.toBytes());
  });
}

void _transferPackAuthority() {
  test("transferPackAuthority", () {
    final layout = MetaplexNFTPacksTransferPackAuthorityLayout();
    expect(layout.toHex(), "07");
    final decode = MetaplexNFTPacksTransferPackAuthorityLayout.fromBuffer(
        layout.toBytes());
    expect(layout.toBytes(), decode.toBytes());
  });
}

void _provingProcess() {
  test("ProvingProcess", () {
    final layout = ProvingProcess(
        accountType: NFTPacksAccountType.packCard,
        walletKey: _owner,
        isExhausted: false,
        voucherMint: _owner,
        packSet: _owner,
        cardsRedeemed: 2,
        cardsToRedeem: {1: 10, 2: 20, 3: 30});

    expect(layout.toHex(),
        "02f6c1dacc8b174b10dac187bb1ee7fed819b77e84591dc1827dc38943a5dbbd7600f6c1dacc8b174b10dac187bb1ee7fed819b77e84591dc1827dc38943a5dbbd76f6c1dacc8b174b10dac187bb1ee7fed819b77e84591dc1827dc38943a5dbbd760200000003000000010000000a0000000200000014000000030000001e000000");
    final decode = ProvingProcess.fromBuffer(layout.toBytes());
    expect(decode.toBytes(), layout.toBytes());
  });
  // test("ProvingProcess_1", () {
  //   final layout = ProvingProcess(
  //       accountType: NFTPacksAccountType.packCard,
  //       walletKey: _owner,
  //       isExhausted: false,
  //       voucherMint: _owner,
  //       packSet: _owner,
  //       cardsRedeemed: 2,
  //       cardsToRedeem: {});

  //   expect(layout.toHex(),
  //       "02f6c1dacc8b174b10dac187bb1ee7fed819b77e84591dc1827dc38943a5dbbd7600f6c1dacc8b174b10dac187bb1ee7fed819b77e84591dc1827dc38943a5dbbd76f6c1dacc8b174b10dac187bb1ee7fed819b77e84591dc1827dc38943a5dbbd760200000000000000");
  //   final decode = ProvingProcess.fromBuffer(layout.toBytes());
  //   expect(decode.toBytes(), layout.toBytes());
  // });
}

void _packVoucher() {
  test("PackVoucher", () {
    final layout = PackVoucher(
      accountType: NFTPacksAccountType.packSet,
      packSet: _owner,
      master: _owner,
      metadata: _owner,
    );

    expect(layout.toHex(),
        "01f6c1dacc8b174b10dac187bb1ee7fed819b77e84591dc1827dc38943a5dbbd76f6c1dacc8b174b10dac187bb1ee7fed819b77e84591dc1827dc38943a5dbbd76f6c1dacc8b174b10dac187bb1ee7fed819b77e84591dc1827dc38943a5dbbd76");
    final decode = PackVoucher.fromBuffer(layout.toBytes());
    expect(decode.toBytes(), layout.toBytes());
  });
}

void _packSet() {
  test("packset", () {
    final layout = PackSet(
      accountType: NFTPacksAccountType.packSet,
      store: _owner,
      authority: _owner,
      description: "MRTNETWORK",
      uri: "https://github.com/mrtnetwork",
      name: List<int>.filled(32, 10),
      packCards: 1,
      packVouchers: 2,
      totalWeight: BigInt.from(33333),
      totalEditions: BigInt.from(44444),
      mutable: true,
      packState: PackSetState.activated,
      distributionType: PackDistributionType.fixed,
      allowedAmountToRedeem: 0,
      redeemStartDate: BigInt.from(11111),
    );
    expect(layout.toHex(),
        "01f6c1dacc8b174b10dac187bb1ee7fed819b77e84591dc1827dc38943a5dbbd76f6c1dacc8b174b10dac187bb1ee7fed819b77e84591dc1827dc38943a5dbbd760a0000004d52544e4554574f524b1d00000068747470733a2f2f6769746875622e636f6d2f6d72746e6574776f726b0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a010000000200000035820000000000009cad00000000000001010100000000672b00000000000000");
    final decode = PackSet.fromBuffer(layout.toBytes());
    expect(decode.toBytes(), layout.toBytes());
  });
  test("packset_2", () {
    final layout = PackSet(
        accountType: NFTPacksAccountType.packSet,
        store: _owner,
        authority: _owner,
        description: "MRTNETWORK",
        uri: "https://github.com/mrtnetwork",
        name: List<int>.filled(32, 10),
        packCards: 1,
        packVouchers: 2,
        totalWeight: BigInt.from(33333),
        totalEditions: BigInt.from(44444),
        mutable: true,
        packState: PackSetState.activated,
        distributionType: PackDistributionType.fixed,
        allowedAmountToRedeem: 0,
        redeemStartDate: BigInt.from(11111),
        redeemEndDate: BigInt.from(2222222));
    expect(layout.toHex(),
        "01f6c1dacc8b174b10dac187bb1ee7fed819b77e84591dc1827dc38943a5dbbd76f6c1dacc8b174b10dac187bb1ee7fed819b77e84591dc1827dc38943a5dbbd760a0000004d52544e4554574f524b1d00000068747470733a2f2f6769746875622e636f6d2f6d72746e6574776f726b0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a010000000200000035820000000000009cad00000000000001010100000000672b000000000000018ee8210000000000");
    final decode = PackSet.fromBuffer(layout.toBytes());
    expect(decode.toBytes(), layout.toBytes());
  });
}

void _packConfig() {
  test("packConfig", () {
    final layout = PackConfig(
        accountType: NFTPacksAccountType.packSet,
        weight: [
          [1, 2, 3],
          [2, 3, 4]
        ],
        actionToDo: CleanUpAction.change([1, 3]));
    expect(layout.toHex(),
        "0102000000010000000200000003000000020000000300000004000000000100000003000000");
    final decode = PackConfig.fromBuffer(layout.toBytes());
    expect(layout.toBytes(), decode.toBytes());
  });
  test("packConfig_1", () {
    final layout = PackConfig(
        accountType: NFTPacksAccountType.packSet,
        weight: [],
        actionToDo: CleanUpAction.change([1, 3]));
    expect(layout.toHex(), "0100000000000100000003000000");
    final decode = PackConfig.fromBuffer(layout.toBytes());
    expect(layout.toBytes(), decode.toBytes());
  });
  test("packConfig_2", () {
    final layout = PackConfig(
        accountType: NFTPacksAccountType.packSet,
        weight: [],
        actionToDo: CleanUpAction.sort());
    expect(layout.toHex(), "010000000001");
    final decode = PackConfig.fromBuffer(layout.toBytes());
    expect(layout.toBytes(), decode.toBytes());
  });
  test("packConfig_3", () {
    final layout = PackConfig(
        accountType: NFTPacksAccountType.packSet,
        weight: [
          [1, 2, 3],
          [2, 3, 4]
        ],
        actionToDo: CleanUpAction.none());
    expect(layout.toHex(),
        "010200000001000000020000000300000002000000030000000400000002");
    final decode = PackConfig.fromBuffer(layout.toBytes());
    expect(layout.toBytes(), decode.toBytes());
  });
}

void _packcard() {
  test("packcard", () {
    final layout = PackCard(
      accountType: NFTPacksAccountType.packSet,
      packSet: _owner,
      master: _owner,
      metadata: _owner,
      tokenAccount: _owner,
      maxSupply: 0,
      weight: 0,
    );

    expect(layout.toHex(),
        "01f6c1dacc8b174b10dac187bb1ee7fed819b77e84591dc1827dc38943a5dbbd76f6c1dacc8b174b10dac187bb1ee7fed819b77e84591dc1827dc38943a5dbbd76f6c1dacc8b174b10dac187bb1ee7fed819b77e84591dc1827dc38943a5dbbd76f6c1dacc8b174b10dac187bb1ee7fed819b77e84591dc1827dc38943a5dbbd76000000000000");
    final decode = PackCard.fromBuffer(layout.toBytes());
    expect(decode.toBytes(), layout.toBytes());
  });
}
