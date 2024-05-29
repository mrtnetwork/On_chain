import 'package:on_chain/solana/solana.dart';
import 'package:test/test.dart';

void main() {
  group("fixedPriceSale", () {
    _withdraw();
    _suspendMarket();
    _buy();
    _changeMarket();
    _claimResource();
    _closeMarket();
    _createMarket();
    _resumeMarket();
    _createStore();
    _initSellingResource();
    _savePrimaryMetadataCreators();
    _payoutTicket();
    _market();
    _primaryMetadataCreators();
    _sellingResource();
    _store();
    _tradeHistory();
  });
}

void _buy() {
  test("buy", () {
    const layout = MetaplexFixedPriceSaleBuyLayout(
      tradeHistoryBump: 255,
      vaultOwnerBump: 1,
    );
    expect(layout.toHex(), "66063d1201daebeaff01");
    final decode = MetaplexFixedPriceSaleBuyLayout.fromBuffer(layout.toBytes());
    expect(layout.toBytes(), decode.toBytes());
  });
}

void _changeMarket() {
  test("changeMarket", () {
    final layout = MetaplexFixedPriceSaleChangeMarketLayout();
    expect(layout.toHex(), "823b6d6555e225580000000000");
    final decode =
        MetaplexFixedPriceSaleChangeMarketLayout.fromBuffer(layout.toBytes());
    expect(layout.toBytes(), decode.toBytes());
  });
  test("changeMarket_1", () {
    final layout = MetaplexFixedPriceSaleChangeMarketLayout(
      newName: "MRT",
      newDescription: "MRTNETWORK.com",
    );
    expect(layout.toHex(),
        "823b6d6555e2255801030000004d5254010e0000004d52544e4554574f524b2e636f6d000000");
    final decode =
        MetaplexFixedPriceSaleChangeMarketLayout.fromBuffer(layout.toBytes());
    expect(layout.toBytes(), decode.toBytes());
  });
  test("changeMarket_2", () {
    final layout = MetaplexFixedPriceSaleChangeMarketLayout(
      newName: "MRT",
      newDescription: "MRTNETWORK.com",
      mutable: true,
      newPrice: BigInt.from(123123123),
    );
    expect(layout.toHex(),
        "823b6d6555e2255801030000004d5254010e0000004d52544e4554574f524b2e636f6d010101b3b556070000000000");
    final decode =
        MetaplexFixedPriceSaleChangeMarketLayout.fromBuffer(layout.toBytes());
    expect(layout.toBytes(), decode.toBytes());
  });
  test("changeMarket_3", () {
    final layout = MetaplexFixedPriceSaleChangeMarketLayout(
        newName: "MRT",
        newDescription: "MRTNETWORK.com",
        mutable: true,
        newPrice: BigInt.from(123123123),
        newPiecesInOneWallet: BigInt.from(123));
    expect(layout.toHex(),
        "823b6d6555e2255801030000004d5254010e0000004d52544e4554574f524b2e636f6d010101b3b5560700000000017b00000000000000");
    final decode =
        MetaplexFixedPriceSaleChangeMarketLayout.fromBuffer(layout.toBytes());
    expect(layout.toBytes(), decode.toBytes());
  });
}

void _claimResource() {
  test("claimResource", () {
    final layout =
        MetaplexFixedPriceSaleClaimResourceLayout(vaultOwnerBump: 123);
    expect(layout.toHex(), "00a0a460ed764a1b7b");
    final decode =
        MetaplexFixedPriceSaleClaimResourceLayout.fromBuffer(layout.toBytes());
    expect(layout.toBytes(), decode.toBytes());
  });
}

void _closeMarket() {
  test("closeMarket", () {
    final layout = MetaplexFixedPriceSaleCloseMarketLayout();
    expect(layout.toHex(), "589af8ba300e7bf4");
    final decode =
        MetaplexFixedPriceSaleCloseMarketLayout.fromBuffer(layout.toBytes());
    expect(layout.toBytes(), decode.toBytes());
  });
}

void _createMarket() {
  test("createMarket", () {
    final layout = MetaplexFixedPriceSaleCreateMarketLayout(
      treasuryOwnerBump: 123,
      name: "MRT",
      description: "MRTNETWOK",
      mutable: false,
      price: BigInt.from(123123123),
      startDate: BigInt.from(123123),
    );
    expect(layout.toHex(),
        "67e261ebc8bcfbfe7b030000004d5254090000004d52544e4554574f4b00b3b556070000000000f3e00100000000000000");
    final decode =
        MetaplexFixedPriceSaleCreateMarketLayout.fromBuffer(layout.toBytes());
    expect(layout.toBytes(), decode.toBytes());
  });
  test("createMarket_1", () {
    final layout = MetaplexFixedPriceSaleCreateMarketLayout(
      treasuryOwnerBump: 123,
      name: "MRT",
      description: "MRTNETWOK",
      mutable: false,
      piecesInOneWallet: BigInt.from(123123123432),
      price: BigInt.from(123123123),
      startDate: BigInt.from(123123),
    );
    expect(layout.toHex(),
        "67e261ebc8bcfbfe7b030000004d5254090000004d52544e4554574f4b00b3b556070000000001e8c4b5aa1c000000f3e00100000000000000");
    final decode =
        MetaplexFixedPriceSaleCreateMarketLayout.fromBuffer(layout.toBytes());
    expect(layout.toBytes(), decode.toBytes());
  });
  test("createMarket_2", () {
    final layout = MetaplexFixedPriceSaleCreateMarketLayout(
        treasuryOwnerBump: 123,
        name: "MRT",
        description: "MRTNETWOK",
        mutable: false,
        piecesInOneWallet: BigInt.from(123123123432),
        price: BigInt.from(123123123),
        startDate: BigInt.from(123123),
        endDate: BigInt.from(124678678));
    expect(layout.toHex(),
        "67e261ebc8bcfbfe7b030000004d5254090000004d52544e4554574f4b00b3b556070000000001e8c4b5aa1c000000f3e00100000000000116726e070000000000");
    final decode =
        MetaplexFixedPriceSaleCreateMarketLayout.fromBuffer(layout.toBytes());
    expect(layout.toBytes(), decode.toBytes());
  });
  test("createMarket_3", () {
    final layout = MetaplexFixedPriceSaleCreateMarketLayout(
        treasuryOwnerBump: 123,
        name: "MRT",
        description: "MRTNETWOK",
        mutable: false,
        piecesInOneWallet: BigInt.from(123123123432),
        price: BigInt.from(123123123),
        startDate: BigInt.from(123123),
        endDate: BigInt.from(124678678),
        gatingConfig: const GatingConfig(
            collection: SolAddress.unchecked(
                "HcEjuQ7Eate3eyNBaZV2cwATcdAH8F7VGygVqkkoqUjf"),
            expireOnUse: true));
    expect(layout.toHex(),
        "67e261ebc8bcfbfe7b030000004d5254090000004d52544e4554574f4b00b3b556070000000001e8c4b5aa1c000000f3e00100000000000116726e070000000001f6c1dacc8b174b10dac187bb1ee7fed819b77e84591dc1827dc38943a5dbbd760100");
    final decode =
        MetaplexFixedPriceSaleCreateMarketLayout.fromBuffer(layout.toBytes());
    expect(layout.toBytes(), decode.toBytes());
  });
  test("createMarket_4", () {
    final layout = MetaplexFixedPriceSaleCreateMarketLayout(
        treasuryOwnerBump: 123,
        name: "MRT",
        description: "MRTNETWOK",
        mutable: false,
        piecesInOneWallet: BigInt.from(123123123432),
        price: BigInt.from(123123123),
        startDate: BigInt.from(123123),
        endDate: BigInt.from(124678678),
        gatingConfig: GatingConfig(
            collection: const SolAddress.unchecked(
                "HcEjuQ7Eate3eyNBaZV2cwATcdAH8F7VGygVqkkoqUjf"),
            expireOnUse: true,
            gatingTime: BigInt.from(11111)));
    expect(layout.toHex(),
        "67e261ebc8bcfbfe7b030000004d5254090000004d52544e4554574f4b00b3b556070000000001e8c4b5aa1c000000f3e00100000000000116726e070000000001f6c1dacc8b174b10dac187bb1ee7fed819b77e84591dc1827dc38943a5dbbd760101672b000000000000");
    final decode =
        MetaplexFixedPriceSaleCreateMarketLayout.fromBuffer(layout.toBytes());
    expect(layout.toBytes(), decode.toBytes());
  });
}

void _createStore() {
  test("createStore", () {
    final layout = MetaplexFixedPriceSaleCreateStoreLayout(
      name: "MRT",
      description: "MRTNETWOK",
    );
    expect(layout.toHex(),
        "8498091b70135f53030000004d5254090000004d52544e4554574f4b");
    final decode =
        MetaplexFixedPriceSaleCreateStoreLayout.fromBuffer(layout.toBytes());
    expect(layout.toBytes(), decode.toBytes());
  });
}

void _initSellingResource() {
  test("initSellingResource", () {
    final layout = MetaplexFixedPriceSaleInitSellingResourceLayout(
      masterEditionBump: 21,
      vaultOwnerBump: 33,
    );
    expect(layout.toHex(), "380fded393cd0491152100");
    final decode = MetaplexFixedPriceSaleInitSellingResourceLayout.fromBuffer(
        layout.toBytes());
    expect(layout.toBytes(), decode.toBytes());
  });
  test("initSellingResource_1", () {
    final layout = MetaplexFixedPriceSaleInitSellingResourceLayout(
      masterEditionBump: 21,
      vaultOwnerBump: 33,
      maxSupply: BigInt.from(12312380192),
    );
    expect(layout.toHex(), "380fded393cd04911521012003e0dd02000000");
    final decode = MetaplexFixedPriceSaleInitSellingResourceLayout.fromBuffer(
        layout.toBytes());
    expect(layout.toBytes(), decode.toBytes());
  });
}

void _resumeMarket() {
  test("resumeMarket", () {
    final layout = MetaplexFixedPriceSaleResumeMarketLayout();
    expect(layout.toHex(), "c67868572c676c8f");
    final decode =
        MetaplexFixedPriceSaleResumeMarketLayout.fromBuffer(layout.toBytes());
    expect(layout.toBytes(), decode.toBytes());
  });
}

void _savePrimaryMetadataCreators() {
  const owner =
      SolAddress.unchecked("HcEjuQ7Eate3eyNBaZV2cwATcdAH8F7VGygVqkkoqUjf");
  const account1 =
      SolAddress.unchecked("57BYVwU1nZvkDkQZvqnNL71SE4jvegfGoEr6Eo6QgNyJ");
  test("savePrimaryMetadataCreators", () {
    final layout = MetaplexFixedPriceSaleSavePrimaryMetadataCreatorsLayout(
        primaryMetadataCreatorsBump: 1,
        creators: [
          const Creator(address: owner, verified: false, share: 13),
          const Creator(address: account1, verified: true, share: 14),
        ]);
    expect(layout.toHex(),
        "42f0d52eb93cc0fe0102000000f6c1dacc8b174b10dac187bb1ee7fed819b77e84591dc1827dc38943a5dbbd76000d3d0427568db5811754651851ae1b5823d52b700fc835078241871ab2b0ca505d010e");
    final decode =
        MetaplexFixedPriceSaleSavePrimaryMetadataCreatorsLayout.fromBuffer(
            layout.toBytes());
    expect(layout.toBytes(), decode.toBytes());
  });
}

void _suspendMarket() {
  test("suspendMarket", () {
    final layout = MetaplexFixedPriceSaleSuspendMarketLayout();
    expect(layout.toHex(), "f61b812e0ac4a576");
    final decode =
        MetaplexFixedPriceSaleSuspendMarketLayout.fromBuffer(layout.toBytes());
    expect(layout.toBytes(), decode.toBytes());
  });
}

void _withdraw() {
  test("initSellingResource", () {
    final layout = MetaplexFixedPriceSaleWithdrawLayout(
        treasuryOwnerBump: 1, payoutTicketBump: 2);
    expect(layout.toHex(), "b712469c946da1220102");
    final decode =
        MetaplexFixedPriceSaleWithdrawLayout.fromBuffer(layout.toBytes());
    expect(layout.toBytes(), decode.toBytes());
  });
}

void _market() {
  const owner =
      SolAddress.unchecked("HcEjuQ7Eate3eyNBaZV2cwATcdAH8F7VGygVqkkoqUjf");
  test("market", () {
    final layout = Market(
      store: owner,
      sellingResource: owner,
      treasuryMint: owner,
      treasuryHolder: owner,
      treasuryOwner: owner,
      owner: owner,
      name: "MRT",
      description: "MRTNETWORK",
      mutable: true,
      price: BigInt.from(213123123),
      startDate: BigInt.from(123123),
      marketState: MarketState.active,
      fundsCollected: BigInt.from(1111),
    );
    expect(layout.toHex(),
        "dbbed53700e3c69af6c1dacc8b174b10dac187bb1ee7fed819b77e84591dc1827dc38943a5dbbd76f6c1dacc8b174b10dac187bb1ee7fed819b77e84591dc1827dc38943a5dbbd76f6c1dacc8b174b10dac187bb1ee7fed819b77e84591dc1827dc38943a5dbbd76f6c1dacc8b174b10dac187bb1ee7fed819b77e84591dc1827dc38943a5dbbd76f6c1dacc8b174b10dac187bb1ee7fed819b77e84591dc1827dc38943a5dbbd76f6c1dacc8b174b10dac187bb1ee7fed819b77e84591dc1827dc38943a5dbbd76030000004d52540a0000004d52544e4554574f524b013300b40c0000000000f3e00100000000000003570400000000000000");
    final decode = Market.fromBuffer(layout.toBytes());
    expect(decode.toBytes(), layout.toBytes());
  });
  test("market_1", () {
    final layout = Market(
      store: owner,
      sellingResource: owner,
      treasuryMint: owner,
      treasuryHolder: owner,
      treasuryOwner: owner,
      owner: owner,
      name: "MRT",
      description: "MRTNETWORK",
      mutable: true,
      price: BigInt.from(213123123),
      piecesInOneWallet: BigInt.from(11111), //beet.COption < beet.bignum >;
      startDate: BigInt.from(123123),
      marketState: MarketState.active,
      fundsCollected: BigInt.from(1111),
    );
    expect(layout.toHex(),
        "dbbed53700e3c69af6c1dacc8b174b10dac187bb1ee7fed819b77e84591dc1827dc38943a5dbbd76f6c1dacc8b174b10dac187bb1ee7fed819b77e84591dc1827dc38943a5dbbd76f6c1dacc8b174b10dac187bb1ee7fed819b77e84591dc1827dc38943a5dbbd76f6c1dacc8b174b10dac187bb1ee7fed819b77e84591dc1827dc38943a5dbbd76f6c1dacc8b174b10dac187bb1ee7fed819b77e84591dc1827dc38943a5dbbd76f6c1dacc8b174b10dac187bb1ee7fed819b77e84591dc1827dc38943a5dbbd76030000004d52540a0000004d52544e4554574f524b013300b40c0000000001672b000000000000f3e00100000000000003570400000000000000");

    final decode = Market.fromBuffer(layout.toBytes());
    expect(decode.toBytes(), layout.toBytes());
  });
  test("market_2", () {
    final layout = Market(
        store: owner,
        sellingResource: owner,
        treasuryMint: owner,
        treasuryHolder: owner,
        treasuryOwner: owner,
        owner: owner,
        name: "MRT",
        description: "MRTNETWORK",
        mutable: true,
        price: BigInt.from(213123123),
        piecesInOneWallet: BigInt.from(11111), //beet.COption < beet.bignum >;
        startDate: BigInt.from(123123),
        marketState: MarketState.active,
        fundsCollected: BigInt.from(1111),
        endDate: BigInt.from(112233));
    expect(layout.toHex(),
        "dbbed53700e3c69af6c1dacc8b174b10dac187bb1ee7fed819b77e84591dc1827dc38943a5dbbd76f6c1dacc8b174b10dac187bb1ee7fed819b77e84591dc1827dc38943a5dbbd76f6c1dacc8b174b10dac187bb1ee7fed819b77e84591dc1827dc38943a5dbbd76f6c1dacc8b174b10dac187bb1ee7fed819b77e84591dc1827dc38943a5dbbd76f6c1dacc8b174b10dac187bb1ee7fed819b77e84591dc1827dc38943a5dbbd76f6c1dacc8b174b10dac187bb1ee7fed819b77e84591dc1827dc38943a5dbbd76030000004d52540a0000004d52544e4554574f524b013300b40c0000000001672b000000000000f3e00100000000000169b601000000000003570400000000000000");

    final decode = Market.fromBuffer(layout.toBytes());
    expect(decode.toBytes(), layout.toBytes());
  });
  test("market_3", () {
    final layout = Market(
        store: owner,
        sellingResource: owner,
        treasuryMint: owner,
        treasuryHolder: owner,
        treasuryOwner: owner,
        owner: owner,
        name: "MRT",
        description: "MRTNETWORK",
        mutable: true,
        price: BigInt.from(213123123),
        piecesInOneWallet: BigInt.from(11111), //beet.COption < beet.bignum >;
        startDate: BigInt.from(123123),
        marketState: MarketState.active,
        fundsCollected: BigInt.from(1111),
        endDate: BigInt.from(112233),
        gatekeeper: GatingConfig(
            collection: owner, expireOnUse: false, gatingTime: BigInt.one));
    expect(layout.toHex(),
        "dbbed53700e3c69af6c1dacc8b174b10dac187bb1ee7fed819b77e84591dc1827dc38943a5dbbd76f6c1dacc8b174b10dac187bb1ee7fed819b77e84591dc1827dc38943a5dbbd76f6c1dacc8b174b10dac187bb1ee7fed819b77e84591dc1827dc38943a5dbbd76f6c1dacc8b174b10dac187bb1ee7fed819b77e84591dc1827dc38943a5dbbd76f6c1dacc8b174b10dac187bb1ee7fed819b77e84591dc1827dc38943a5dbbd76f6c1dacc8b174b10dac187bb1ee7fed819b77e84591dc1827dc38943a5dbbd76030000004d52540a0000004d52544e4554574f524b013300b40c0000000001672b000000000000f3e00100000000000169b601000000000003570400000000000001f6c1dacc8b174b10dac187bb1ee7fed819b77e84591dc1827dc38943a5dbbd7600010100000000000000");

    final decode = Market.fromBuffer(layout.toBytes());
    expect(decode.toBytes(), layout.toBytes());
  });
}

void _payoutTicket() {
  test("PayoutTicket", () {
    const layout = PayoutTicket(used: true);
    expect(layout.toHex(), "99de34d8c098af5001");
    final decode = PayoutTicket.fromBuffer(layout.toBytes());
    expect(decode.toBytes(), layout.toBytes());
  });
}

void _primaryMetadataCreators() {
  test("PrimaryMetadataCreators", () {
    const owner =
        SolAddress.unchecked("HcEjuQ7Eate3eyNBaZV2cwATcdAH8F7VGygVqkkoqUjf");
    const layout = PrimaryMetadataCreators(
        creators: [Creator(address: owner, verified: true, share: 0)]);
    expect(layout.toHex(),
        "428330246482b10b01000000f6c1dacc8b174b10dac187bb1ee7fed819b77e84591dc1827dc38943a5dbbd760100");

    final decode = PrimaryMetadataCreators.fromBuffer(layout.toBytes());
    expect(decode.toHex(), layout.toHex());
  });
  test("PrimaryMetadataCreators_1", () {
    const layout = PrimaryMetadataCreators(creators: []);
    expect(layout.toHex(), "428330246482b10b00000000");

    final decode = PrimaryMetadataCreators.fromBuffer(layout.toBytes());
    expect(decode.toHex(), layout.toHex());
  });
  test("PrimaryMetadataCreators_2", () {
    const owner =
        SolAddress.unchecked("HcEjuQ7Eate3eyNBaZV2cwATcdAH8F7VGygVqkkoqUjf");
    const account1 =
        SolAddress.unchecked("57BYVwU1nZvkDkQZvqnNL71SE4jvegfGoEr6Eo6QgNyJ");
    const layout = PrimaryMetadataCreators(creators: [
      Creator(address: owner, verified: true, share: 0),
      Creator(address: account1, verified: false, share: 1)
    ]);
    expect(layout.toHex(),
        "428330246482b10b02000000f6c1dacc8b174b10dac187bb1ee7fed819b77e84591dc1827dc38943a5dbbd7601003d0427568db5811754651851ae1b5823d52b700fc835078241871ab2b0ca505d0001");

    final decode = PrimaryMetadataCreators.fromBuffer(layout.toBytes());
    expect(decode.toHex(), layout.toHex());
  });
}

void _sellingResource() {
  test("sellingResource", () {
    const owner =
        SolAddress.unchecked("HcEjuQ7Eate3eyNBaZV2cwATcdAH8F7VGygVqkkoqUjf");
    final layout = SellingResource(
      store: owner,
      owner: owner,
      resource: owner,
      vault: owner,
      vaultOwner: owner,
      supply: BigInt.from(1111),
      // maxSupply: undefined, // beet.COption < beet.bignum >;
      sellingResourceState: SellingResourceState.inUse,
    );
    expect(layout.toHex(),
        "0f2045ebf92712a7f6c1dacc8b174b10dac187bb1ee7fed819b77e84591dc1827dc38943a5dbbd76f6c1dacc8b174b10dac187bb1ee7fed819b77e84591dc1827dc38943a5dbbd76f6c1dacc8b174b10dac187bb1ee7fed819b77e84591dc1827dc38943a5dbbd76f6c1dacc8b174b10dac187bb1ee7fed819b77e84591dc1827dc38943a5dbbd76f6c1dacc8b174b10dac187bb1ee7fed819b77e84591dc1827dc38943a5dbbd7657040000000000000002");

    final decode = SellingResource.fromBuffer(layout.toBytes());
    expect(decode.toBytes(), layout.toBytes());
  });
  test("sellingResource_1", () {
    const owner =
        SolAddress.unchecked("HcEjuQ7Eate3eyNBaZV2cwATcdAH8F7VGygVqkkoqUjf");
    final layout = SellingResource(
      store: owner,
      owner: owner,
      resource: owner,
      vault: owner,
      vaultOwner: owner,
      supply: BigInt.from(1111),
      maxSupply: BigInt.from(1111),
      sellingResourceState: SellingResourceState.inUse,
    );
    expect(layout.toHex(),
        "0f2045ebf92712a7f6c1dacc8b174b10dac187bb1ee7fed819b77e84591dc1827dc38943a5dbbd76f6c1dacc8b174b10dac187bb1ee7fed819b77e84591dc1827dc38943a5dbbd76f6c1dacc8b174b10dac187bb1ee7fed819b77e84591dc1827dc38943a5dbbd76f6c1dacc8b174b10dac187bb1ee7fed819b77e84591dc1827dc38943a5dbbd76f6c1dacc8b174b10dac187bb1ee7fed819b77e84591dc1827dc38943a5dbbd76570400000000000001570400000000000002");

    final decode = SellingResource.fromBuffer(layout.toBytes());
    expect(decode.toBytes(), layout.toBytes());
  });
}

void _store() {
  test("store", () {
    const owner =
        SolAddress.unchecked("HcEjuQ7Eate3eyNBaZV2cwATcdAH8F7VGygVqkkoqUjf");
    const layout = Store(admin: owner, name: "mrt", description: "mrtnetwork");
    expect(layout.toHex(),
        "8230f7f4b6bf1e1af6c1dacc8b174b10dac187bb1ee7fed819b77e84591dc1827dc38943a5dbbd76030000006d72740a0000006d72746e6574776f726b");

    final decode = Store.fromBuffer(layout.toBytes());
    expect(decode.toBytes(), layout.toBytes());
  });
}

void _tradeHistory() {
  test("tradeHistory", () {
    const owner =
        SolAddress.unchecked("HcEjuQ7Eate3eyNBaZV2cwATcdAH8F7VGygVqkkoqUjf");
    final layout = TradeHistory(
      market: owner,
      wallet: owner,
      alreadyBought: BigInt.from(3333333333),
    );
    expect(layout.toHex(),
        "be75da7242703829f6c1dacc8b174b10dac187bb1ee7fed819b77e84591dc1827dc38943a5dbbd76f6c1dacc8b174b10dac187bb1ee7fed819b77e84591dc1827dc38943a5dbbd7655a1aec600000000");

    final decode = TradeHistory.fromBuffer(layout.toBytes());
    expect(decode.toHex(), layout.toHex());
  });
}
