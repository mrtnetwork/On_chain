import 'package:on_chain/solana/solana.dart';
import 'package:test/test.dart';

final _owner =
    SolAddress.unchecked("HcEjuQ7Eate3eyNBaZV2cwATcdAH8F7VGygVqkkoqUjf");
void main() {
  group("metaData", () {
    _createMetadataAccountV3();
    _createV1();
    _approve();
    _approveUseAuthority();
    _bubblegumSetCollectionSize();
    _burnV1();
    _delegate();
    _update();
    _updateV2();
  });
}

void _createMetadataAccountV3() {
  test("createMetadataAccountV3", () {
    final layout = MetaplexTokenMetaDataCreateMetadataAccountV3Layout(
        isMutable: true,
        metaDataV2: MetaDataV2(
          name: "mrtnetwork",
          symbol: "mrt",
          uri: "https://github.com/mrtnetwork",
          sellerFeeBasisPoints: 1,
        ));
    expect(layout.toHex(),
        "210a0000006d72746e6574776f726b030000006d72741d00000068747470733a2f2f6769746875622e636f6d2f6d72746e6574776f726b01000000000100");
    final decode =
        MetaplexTokenMetaDataCreateMetadataAccountV3Layout.fromBuffer(
            layout.toBytes());
    expect(decode.toBytes(), layout.toBytes());
  });
  test("createMetadataAccountV3_2", () {
    final layout = MetaplexTokenMetaDataCreateMetadataAccountV3Layout(
        isMutable: true,
        metaDataV2: MetaDataV2(
          name: "mrtnetwork",
          symbol: "mrt",
          uri: "https://github.com/mrtnetwork",
          sellerFeeBasisPoints: 1,
        ),
        collectionDetailsV1: CollectionDetailsV1(size: BigInt.one));
    expect(layout.toHex(),
        "210a0000006d72746e6574776f726b030000006d72741d00000068747470733a2f2f6769746875622e636f6d2f6d72746e6574776f726b01000000000101000100000000000000");
    final decode =
        MetaplexTokenMetaDataCreateMetadataAccountV3Layout.fromBuffer(
            layout.toBytes());
    expect(decode.toBytes(), layout.toBytes());
  });
  test("createMetadataAccountV3_3", () {
    final layout = MetaplexTokenMetaDataCreateMetadataAccountV3Layout(
        isMutable: true,
        metaDataV2: MetaDataV2(
            name: "mrtnetwork",
            symbol: "mrt",
            uri: "https://github.com/mrtnetwork",
            sellerFeeBasisPoints: 1),
        collectionDetailsV1: CollectionDetailsV1(size: BigInt.one));
    expect(layout.toHex(),
        "210a0000006d72746e6574776f726b030000006d72741d00000068747470733a2f2f6769746875622e636f6d2f6d72746e6574776f726b01000000000101000100000000000000");
    final decode =
        MetaplexTokenMetaDataCreateMetadataAccountV3Layout.fromBuffer(
            layout.toBytes());
    expect(decode.toBytes(), layout.toBytes());
  });
  test("createMetadataAccountV3_4", () {
    final layout = MetaplexTokenMetaDataCreateMetadataAccountV3Layout(
        isMutable: true,
        metaDataV2: MetaDataV2(
            name: "mrtnetwork",
            symbol: "mrt",
            uri: "https://github.com/mrtnetwork",
            sellerFeeBasisPoints: 1,
            collection: Collection(verified: false, key: _owner),
            uses: Uses(
                useMethod: UseMethod.burn,
                remaining: BigInt.two,
                total: BigInt.one)),
        collectionDetailsV1: CollectionDetailsV1(size: BigInt.one));
    expect(layout.toHex(),
        "210a0000006d72746e6574776f726b030000006d72741d00000068747470733a2f2f6769746875622e636f6d2f6d72746e6574776f726b0100000100f6c1dacc8b174b10dac187bb1ee7fed819b77e84591dc1827dc38943a5dbbd760100020000000000000001000000000000000101000100000000000000");
    final decode =
        MetaplexTokenMetaDataCreateMetadataAccountV3Layout.fromBuffer(
            layout.toBytes());
    expect(decode.toBytes(), layout.toBytes());
  });
  test("createMetadataAccountV3_5", () {
    final layout = MetaplexTokenMetaDataCreateMetadataAccountV3Layout(
        isMutable: true,
        metaDataV2: MetaDataV2(
            name: "mrtnetwork",
            symbol: "mrt",
            uri: "https://github.com/mrtnetwork",
            sellerFeeBasisPoints: 1,
            collection: Collection(verified: false, key: _owner),
            creators: [
              Creator(address: _owner, verified: true, share: 0),
              Creator(address: _owner, verified: false, share: 2)
            ],
            uses: Uses(
                useMethod: UseMethod.burn,
                remaining: BigInt.two,
                total: BigInt.one)),
        collectionDetailsV1: CollectionDetailsV1(size: BigInt.one));
    expect(layout.toHex(),
        "210a0000006d72746e6574776f726b030000006d72741d00000068747470733a2f2f6769746875622e636f6d2f6d72746e6574776f726b01000102000000f6c1dacc8b174b10dac187bb1ee7fed819b77e84591dc1827dc38943a5dbbd760100f6c1dacc8b174b10dac187bb1ee7fed819b77e84591dc1827dc38943a5dbbd7600020100f6c1dacc8b174b10dac187bb1ee7fed819b77e84591dc1827dc38943a5dbbd760100020000000000000001000000000000000101000100000000000000");
    final decode =
        MetaplexTokenMetaDataCreateMetadataAccountV3Layout.fromBuffer(
            layout.toBytes());
    expect(decode.toBytes(), layout.toBytes());
  });
}

void _createV1() {
  test("createV1", () {
    final layout = MetaplexTokenMetaDataCreateV1Layout(
        name: "MRT",
        symbol: "MRT",
        uri: "https://github.com/mrtnetwork",
        primarySaleHappened: false,
        isMutable: true,
        creators: [Creator(address: _owner, verified: true, share: 0)],
        tokenStandard: MetaDataTokenStandard.nonFungibleEdition,
        collection: Collection(
          verified: false,
          key: _owner,
        ),
        uses: Uses(
          useMethod: UseMethod.burn,
          remaining: BigInt.two,
          total: BigInt.one,
        ),
        collectionDetails: CollectionDetailsV1(size: BigInt.one),
        decimals: 1,
        printSupply: PrintSupply.limited(fields: [BigInt.from(25)]),
        sellerFeeBasisPoints: 0,
        ruleSet: _owner);
    expect(layout.toHex(),
        "2a00030000004d5254030000004d52541d00000068747470733a2f2f6769746875622e636f6d2f6d72746e6574776f726b00000101000000f6c1dacc8b174b10dac187bb1ee7fed819b77e84591dc1827dc38943a5dbbd7601000001030100f6c1dacc8b174b10dac187bb1ee7fed819b77e84591dc1827dc38943a5dbbd760100020000000000000001000000000000000100010000000000000001f6c1dacc8b174b10dac187bb1ee7fed819b77e84591dc1827dc38943a5dbbd76010101011900000000000000");
    final decode =
        MetaplexTokenMetaDataCreateV1Layout.fromBuffer(layout.toBytes());
    expect(decode.toBytes(), layout.toBytes());
  });
  test("createV1_2", () {
    final owner = SolAddress("91KRjTdVaXbdosGDn5AnFczYSApddsFj1SKuShbTUMEB");
    final layout = MetaplexTokenMetaDataCreateV1Layout(
        name: "mrt",
        symbol: "mrt",
        uri: "https://github.com/mrtnetwork",
        sellerFeeBasisPoints: 1,
        primarySaleHappened: true,
        isMutable: true,
        tokenStandard: MetaDataTokenStandard.fungible,
        collection: Collection(verified: false, key: owner),
        collectionDetails: CollectionDetailsV1(size: BigInt.one),
        printSupply: PrintSupply.zero,
        ruleSet: owner,
        creators: [Creator(address: owner, verified: false, share: 1)]);
    expect(layout.toHex(),
        "2a00030000006d7274030000006d72741d00000068747470733a2f2f6769746875622e636f6d2f6d72746e6574776f726b0100010100000076f25489958a097dac92ed4953a1ad36b69e7c3b2671150a4c8c4c04f2ceeb640001010102010076f25489958a097dac92ed4953a1ad36b69e7c3b2671150a4c8c4c04f2ceeb6400010001000000000000000176f25489958a097dac92ed4953a1ad36b69e7c3b2671150a4c8c4c04f2ceeb64000100");
    final decode =
        MetaplexTokenMetaDataCreateV1Layout.fromBuffer(layout.toBytes());
    expect(decode.toBytes(), layout.toBytes());
  });
}

void _approve() {
  test("apporove", () {
    final layout = MetaplexTokenMetaDataApproveCollectionAuthorityLayout();
    expect(layout.toHex(), "17");
    final decode =
        MetaplexTokenMetaDataApproveCollectionAuthorityLayout.fromBuffer(
            layout.toBytes());
    expect(decode.toBytes(), layout.toBytes());
  });
}

void _approveUseAuthority() {
  test("approveUseAuthority", () {
    final layout = MetaplexTokenMetaDataapproveUseAuthorityLayout(
        numberOfUses: BigInt.one);
    expect(layout.toHex(), "140100000000000000");
    final decode = MetaplexTokenMetaDataapproveUseAuthorityLayout.fromBuffer(
        layout.toBytes());
    expect(decode.toBytes(), layout.toBytes());
  });
}

void _bubblegumSetCollectionSize() {
  test("bubblegumSetCollectionSize", () {
    final layout =
        MetaplexTokenMetaDataBubblegumSetCollectionSizeLayout(size: BigInt.one);
    expect(layout.toHex(), "240100000000000000");
    final decode =
        MetaplexTokenMetaDataBubblegumSetCollectionSizeLayout.fromBuffer(
            layout.toBytes());
    expect(decode.toBytes(), layout.toBytes());
  });
}

void _burnV1() {
  test("burnV1", () {
    final layout = MetaplexTokenMetaDataBurnV1Layout(amount: BigInt.one);
    expect(layout.toHex(), "29000100000000000000");
    final decode =
        MetaplexTokenMetaDataBurnV1Layout.fromBuffer(layout.toBytes());
    expect(decode.toBytes(), layout.toBytes());
  });
}

void _delegate() {
  test("delegate", () {
    final layout = MetaplexTokenMetaDataDelegateCollectionV1Layout();
    expect(layout.toHex(), "2c0000");
    final decode = MetaplexTokenMetaDataDelegateCollectionV1Layout.fromBuffer(
        layout.toBytes());
    expect(layout.toBytes(), decode.toBytes());
  });
}

void _update() {
  test("updateV1", () {
    final owner = SolAddress("91KRjTdVaXbdosGDn5AnFczYSApddsFj1SKuShbTUMEB");
    final account1 = SolAddress("24sMxSzbsSHmRiheSk9v3F7Wfqc4jKxKetfyJL7QvfKP");
    final layout = MetaplexTokenMetaDataUpdateV1Layout(
      collection: CollectionToggle.set(
          collection: Collection(verified: false, key: owner)),
      collectionDetails: CollectionDetailsToggle.set(
          collection: CollectionDetailsV1(size: BigInt.two)),
      ruleSet: RuleSetToggle.set(address: owner),
      uses: UsesToggle.set(
          uses: Uses(
              useMethod: UseMethod.burn,
              remaining: BigInt.one,
              total: BigInt.one)),
      data: MetaDataData(
          name: "mrt",
          symbol: "mrtnetwork",
          uri: "https://github.com/mrtnetwork",
          sellerFeeBasisPoints: 1,
          creators: [Creator(address: account1, verified: false, share: 2)]),
      isMutable: true,
      primarySaleHappened: false,
      newUpdateAuthority: owner,
    );
    expect(layout.toHex(),
        "32000176f25489958a097dac92ed4953a1ad36b69e7c3b2671150a4c8c4c04f2ceeb6401030000006d72740a0000006d72746e6574776f726b1d00000068747470733a2f2f6769746875622e636f6d2f6d72746e6574776f726b010001010000000fd95f816f738a5f5747ea36a3ba7bee1ae5e4cffa8b34ce3f6d4514ab25813a000201000101020076f25489958a097dac92ed4953a1ad36b69e7c3b2671150a4c8c4c04f2ceeb64020002000000000000000200010000000000000001000000000000000276f25489958a097dac92ed4953a1ad36b69e7c3b2671150a4c8c4c04f2ceeb6400");
    final decode =
        MetaplexTokenMetaDataUpdateV1Layout.fromBuffer(layout.toBytes());
    expect(decode.toBytes(), layout.toBytes());
  });
  test("update_AsUpdateAuthorityV2", () {
    final owner = SolAddress("91KRjTdVaXbdosGDn5AnFczYSApddsFj1SKuShbTUMEB");
    final account1 = SolAddress("24sMxSzbsSHmRiheSk9v3F7Wfqc4jKxKetfyJL7QvfKP");
    final layout = MetaplexTokenMetaDataUpdateAsUpdateAuthorityV2Layout(
      collection: CollectionToggle.set(
          collection: Collection(verified: false, key: owner)),
      collectionDetails: CollectionDetailsToggle.set(
          collection: CollectionDetailsV1(size: BigInt.two)),
      ruleSet: RuleSetToggle.set(address: owner),
      tokenStandard: MetaDataTokenStandard.fungible,
      uses: UsesToggle.set(
          uses: Uses(
              useMethod: UseMethod.burn,
              remaining: BigInt.one,
              total: BigInt.one)),
      data: MetaDataData(
          name: "mrt",
          symbol: "mrtnetwork",
          uri: "https://github.com/mrtnetwork",
          sellerFeeBasisPoints: 1,
          creators: [Creator(address: account1, verified: false, share: 2)]),
      isMutable: true,
      primarySaleHappened: false,
      newUpdateAuthority: owner,
    );
    expect(layout.toHex(),
        "32010176f25489958a097dac92ed4953a1ad36b69e7c3b2671150a4c8c4c04f2ceeb6401030000006d72740a0000006d72746e6574776f726b1d00000068747470733a2f2f6769746875622e636f6d2f6d72746e6574776f726b010001010000000fd95f816f738a5f5747ea36a3ba7bee1ae5e4cffa8b34ce3f6d4514ab25813a000201000101020076f25489958a097dac92ed4953a1ad36b69e7c3b2671150a4c8c4c04f2ceeb64020002000000000000000200010000000000000001000000000000000276f25489958a097dac92ed4953a1ad36b69e7c3b2671150a4c8c4c04f2ceeb64010200");
    final decode =
        MetaplexTokenMetaDataUpdateAsUpdateAuthorityV2Layout.fromBuffer(
            layout.toBytes());
    expect(decode.toBytes(), layout.toBytes());
  });
  test("update_AsAuthorityItemDelegateV2", () {
    final owner = SolAddress("91KRjTdVaXbdosGDn5AnFczYSApddsFj1SKuShbTUMEB");
    final layout = MetaplexTokenMetaDataUpdateAsAuthorityItemDelegateV2Layout(
      tokenStandard: MetaDataTokenStandard.fungible,
      isMutable: true,
      primarySaleHappened: false,
      newUpdateAuthority: owner,
    );
    expect(layout.toHex(),
        "32020176f25489958a097dac92ed4953a1ad36b69e7c3b2671150a4c8c4c04f2ceeb6401000101010200");
    final decode =
        MetaplexTokenMetaDataUpdateAsAuthorityItemDelegateV2Layout.fromBuffer(
            layout.toBytes());
    expect(decode.toBytes(), layout.toBytes());
  });
  test("update_AsCollectionDelegateV2", () {
    final owner = SolAddress("91KRjTdVaXbdosGDn5AnFczYSApddsFj1SKuShbTUMEB");
    final layout = MetaplexTokenMetaDataUpdateAsCollectionDelegateV2Layout(
      collection: CollectionToggle.set(
          collection: Collection(verified: false, key: owner)),
    );
    expect(layout.toHex(),
        "3203020076f25489958a097dac92ed4953a1ad36b69e7c3b2671150a4c8c4c04f2ceeb6400");
    final decode =
        MetaplexTokenMetaDataUpdateAsCollectionDelegateV2Layout.fromBuffer(
            layout.toBytes());
    expect(decode.toBytes(), layout.toBytes());
  });
  test("updateV1_AsDataDelegateV2", () {
    final account1 = SolAddress("24sMxSzbsSHmRiheSk9v3F7Wfqc4jKxKetfyJL7QvfKP");
    final layout = MetaplexTokenMetaDataUpdateAsDataDelegateV2Layout(
      data: MetaDataData(
          name: "mrt",
          symbol: "mrtnetwork",
          uri: "https://github.com/mrtnetwork",
          sellerFeeBasisPoints: 1,
          creators: [Creator(address: account1, verified: false, share: 2)]),
    );
    expect(layout.toHex(),
        "320401030000006d72740a0000006d72746e6574776f726b1d00000068747470733a2f2f6769746875622e636f6d2f6d72746e6574776f726b010001010000000fd95f816f738a5f5747ea36a3ba7bee1ae5e4cffa8b34ce3f6d4514ab25813a000200");
    final decode = MetaplexTokenMetaDataUpdateAsDataDelegateV2Layout.fromBuffer(
        layout.toBytes());
    expect(decode.toBytes(), layout.toBytes());
  });
  test("update_AsProgrammableConfigDelegateV2", () {
    final owner = SolAddress("91KRjTdVaXbdosGDn5AnFczYSApddsFj1SKuShbTUMEB");
    final layout =
        MetaplexTokenMetaDataUpdateAsProgrammableConfigDelegateV2Layout(
      ruleSet: RuleSetToggle.set(address: owner),
    );
    expect(layout.toHex(),
        "32050276f25489958a097dac92ed4953a1ad36b69e7c3b2671150a4c8c4c04f2ceeb6400");
    final decode =
        MetaplexTokenMetaDataUpdateAsProgrammableConfigDelegateV2Layout
            .fromBuffer(layout.toBytes());
    expect(decode.toBytes(), layout.toBytes());
  });
  test("updateV1_AsDataItemDelegateV2", () {
    final account1 = SolAddress("24sMxSzbsSHmRiheSk9v3F7Wfqc4jKxKetfyJL7QvfKP");
    final layout = MetaplexTokenMetaDataUpdateAsDataItemDelegateV2Layout(
      data: MetaDataData(
          name: "mrt",
          symbol: "mrtnetwork",
          uri: "https://github.com/mrtnetwork",
          sellerFeeBasisPoints: 1,
          creators: [Creator(address: account1, verified: false, share: 2)]),
    );
    expect(layout.toHex(),
        "320601030000006d72740a0000006d72746e6574776f726b1d00000068747470733a2f2f6769746875622e636f6d2f6d72746e6574776f726b010001010000000fd95f816f738a5f5747ea36a3ba7bee1ae5e4cffa8b34ce3f6d4514ab25813a000200");
    final decode =
        MetaplexTokenMetaDataUpdateAsDataItemDelegateV2Layout.fromBuffer(
            layout.toBytes());
    expect(decode.toBytes(), layout.toBytes());
  });
  test("update_AsCollectionItemDelegateV2", () {
    final owner = SolAddress("91KRjTdVaXbdosGDn5AnFczYSApddsFj1SKuShbTUMEB");
    final layout = MetaplexTokenMetaDataUpdateAsCollectionItemDelegateV2Layout(
      collection: CollectionToggle.set(
          collection: Collection(verified: false, key: owner)),
    );
    expect(layout.toHex(),
        "3207020076f25489958a097dac92ed4953a1ad36b69e7c3b2671150a4c8c4c04f2ceeb6400");
    final decode =
        MetaplexTokenMetaDataUpdateAsCollectionItemDelegateV2Layout.fromBuffer(
            layout.toBytes());
    expect(decode.toBytes(), layout.toBytes());
  });
  test("update_AsProgrammableConfigItemDelegateV2", () {
    final owner = SolAddress("91KRjTdVaXbdosGDn5AnFczYSApddsFj1SKuShbTUMEB");
    final layout =
        MetaplexTokenMetaDataUpdateAsProgrammableConfigItemDelegateV2Layout(
      ruleSet: RuleSetToggle.set(address: owner),
    );
    expect(layout.toHex(),
        "32080276f25489958a097dac92ed4953a1ad36b69e7c3b2671150a4c8c4c04f2ceeb6400");
    final decode =
        MetaplexTokenMetaDataUpdateAsProgrammableConfigItemDelegateV2Layout
            .fromBuffer(layout.toBytes());
    expect(decode.toBytes(), layout.toBytes());
  });
}

void _updateV2() {
  test("updateV2", () {
    final owner = SolAddress("91KRjTdVaXbdosGDn5AnFczYSApddsFj1SKuShbTUMEB");
    final layout = MetaplexTokenMetaDataUpdateMetadataAccountV2Layout(
        isMutable: false,
        primarySaleHappened: true,
        newUpdateAuthority: owner,
        data: MetaDataV2(
            name: "mrtnetwork",
            symbol: "mrt",
            uri: "https://github.com/mrtnetwork",
            sellerFeeBasisPoints: 1,
            collection: Collection(verified: true, key: owner),
            creators: [Creator(address: owner, verified: false, share: 1)],
            uses: Uses(
                useMethod: UseMethod.burn,
                remaining: BigInt.one,
                total: BigInt.one)));
    expect(layout.toHex(),
        "0f010a0000006d72746e6574776f726b030000006d72741d00000068747470733a2f2f6769746875622e636f6d2f6d72746e6574776f726b0100010100000076f25489958a097dac92ed4953a1ad36b69e7c3b2671150a4c8c4c04f2ceeb640001010176f25489958a097dac92ed4953a1ad36b69e7c3b2671150a4c8c4c04f2ceeb640100010000000000000001000000000000000176f25489958a097dac92ed4953a1ad36b69e7c3b2671150a4c8c4c04f2ceeb6401010100");
    final decode =
        MetaplexTokenMetaDataUpdateMetadataAccountV2Layout.fromBuffer(
            layout.toBytes());
    expect(decode.toBytes(), layout.toBytes());
  });
}
