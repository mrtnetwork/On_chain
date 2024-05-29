import 'package:on_chain/solana/solana.dart';
import 'package:test/test.dart';

void main() {
  group("auctioneer", () {
    _authorize();
    _buy();
    _cancel();
    _deposit();
    _executeSale();
    _sell();
    _withdraw();
    _bid();
    _listingConfig();
    _auctioneerAuthority();
  });
}

void _authorize() {
  test("authorize", () {
    const layout = MetaplexAuctioneerAuthorizeLayout();
    expect(layout.toHex(), "adc166d2db897178");
    final decode =
        MetaplexAuctioneerAuthorizeLayout.fromBuffer(layout.toBytes());
    expect(decode.toBytes(), layout.toBytes());
  });
}

void _buy() {
  test("buy", () {
    final layout = MetaplexAuctioneerBuyLayout(
        tradeStateBump: 222,
        escrowPaymentBump: 222,
        auctioneerAuthorityBump: 122,
        buyerPrice: BigInt.from(123123123123),
        tokenSize: BigInt.from(35342523));
    expect(layout.toHex(),
        "66063d1201daebeadede7ab3c3b5aa1c000000bb481b0200000000");
    final decode = MetaplexAuctioneerBuyLayout.fromBuffer(layout.toBytes());
    expect(decode.toBytes(), layout.toBytes());
  });
}

void _cancel() {
  test("cancel", () {
    final layout = MetaplexAuctioneerCancelLayout(
        auctioneerAuthorityBump: 100,
        buyerPrice: BigInt.from(123123123),
        tokenSize: BigInt.from(4324234234));
    expect(
        layout.toHex(), "e8dbdf29dbecdcbe64b3b5560700000000fa93be0101000000");
    final decode = MetaplexAuctioneerCancelLayout.fromBuffer(layout.toBytes());
    expect(decode.toBytes(), layout.toBytes());
  });
}

void _deposit() {
  test("deposit", () {
    final layout = MetaplexAuctioneerDepositLayout(
        escrowPaymentBump: 100,
        auctioneerAuthorityBump: 110,
        amount: BigInt.from(213123123123));
    expect(layout.toHex(), "f223c68952e1f2b6646eb3c7209f31000000");
    final decode = MetaplexAuctioneerDepositLayout.fromBuffer(layout.toBytes());
    expect(decode.toBytes(), layout.toBytes());
  });
}

void _executeSale() {
  test("executeSale", () {
    final layout = MetaplexAuctioneerExecuteSaleLayout(
      escrowPaymentBump: 12,
      freeTradeStateBump: 25,
      programAsSignerBump: 111,
      auctioneerAuthorityBump: 222,
      buyerPrice: BigInt.from(4234234324),
      tokenSize: BigInt.from(23423423),
    );
    expect(layout.toHex(),
        "254ad99d4f3123060c196fded44961fc00000000bf69650100000000");
    final decode =
        MetaplexAuctioneerExecuteSaleLayout.fromBuffer(layout.toBytes());
    expect(decode.toBytes(), layout.toBytes());
  });
}

void _sell() {
  test("sell", () {
    final layout = MetaplexAuctioneerSellLayout(
      tradeStateBump: 11,
      freeTradeStateBump: 12,
      programAsSignerBump: 13,
      auctioneerAuthorityBump: 14,
      tokenSize: BigInt.from(123123123),
      startTime: BigInt.from(234234234),
      endTime: BigInt.from(1234324123),
    );
    expect(layout.toHex(),
        "33e685a4017f83ad0b0c0d0eb3b55607000000007a21f60d000000009b4a9249000000000000000000");
    final decode = MetaplexAuctioneerSellLayout.fromBuffer(layout.toBytes());
    expect(decode.toBytes(), layout.toBytes());
  });

  test("sell_1", () {
    final layout = MetaplexAuctioneerSellLayout(
        tradeStateBump: 11,
        freeTradeStateBump: 12,
        programAsSignerBump: 13,
        auctioneerAuthorityBump: 14,
        tokenSize: BigInt.from(123123123),
        startTime: BigInt.from(234234234),
        endTime: BigInt.from(1234324123),
        allowHighBidCancel: true);
    expect(layout.toHex(),
        "33e685a4017f83ad0b0c0d0eb3b55607000000007a21f60d000000009b4a924900000000000000000101");
    final decode = MetaplexAuctioneerSellLayout.fromBuffer(layout.toBytes());
    expect(decode.toBytes(), layout.toBytes());
  });
  test("sell_2", () {
    final layout = MetaplexAuctioneerSellLayout(
        tradeStateBump: 11,
        freeTradeStateBump: 12,
        programAsSignerBump: 13,
        auctioneerAuthorityBump: 14,
        tokenSize: BigInt.from(123123123),
        startTime: BigInt.from(234234234),
        endTime: BigInt.from(1234324123),
        allowHighBidCancel: true,
        timeExtDelta: 12);
    expect(layout.toHex(),
        "33e685a4017f83ad0b0c0d0eb3b55607000000007a21f60d000000009b4a924900000000000000010c0000000101");
    final decode = MetaplexAuctioneerSellLayout.fromBuffer(layout.toBytes());
    expect(decode.toBytes(), layout.toBytes());
  });
  test("sell_3", () {
    final layout = MetaplexAuctioneerSellLayout(
        tradeStateBump: 11,
        freeTradeStateBump: 12,
        programAsSignerBump: 13,
        auctioneerAuthorityBump: 14,
        tokenSize: BigInt.from(123123123),
        startTime: BigInt.from(234234234),
        endTime: BigInt.from(1234324123),
        allowHighBidCancel: true,
        timeExtPeriod: 123123123,
        timeExtDelta: 12);
    expect(layout.toHex(),
        "33e685a4017f83ad0b0c0d0eb3b55607000000007a21f60d000000009b4a924900000000000001b3b55607010c0000000101");
    final decode = MetaplexAuctioneerSellLayout.fromBuffer(layout.toBytes());
    expect(decode.toBytes(), layout.toBytes());
  });
  test("sell_4", () {
    final layout = MetaplexAuctioneerSellLayout(
        tradeStateBump: 11,
        freeTradeStateBump: 12,
        programAsSignerBump: 13,
        auctioneerAuthorityBump: 14,
        tokenSize: BigInt.from(123123123),
        startTime: BigInt.from(234234234),
        endTime: BigInt.from(1234324123),
        allowHighBidCancel: true,
        minBidIncrement: BigInt.from(1223123123),
        timeExtPeriod: 123123123,
        timeExtDelta: 12);
    expect(layout.toHex(),
        "33e685a4017f83ad0b0c0d0eb3b55607000000007a21f60d000000009b4a9249000000000001b360e7480000000001b3b55607010c0000000101");
    final decode = MetaplexAuctioneerSellLayout.fromBuffer(layout.toBytes());
    expect(decode.toBytes(), layout.toBytes());
  });
  test("sell_5", () {
    final layout = MetaplexAuctioneerSellLayout(
        tradeStateBump: 11,
        freeTradeStateBump: 12,
        programAsSignerBump: 13,
        auctioneerAuthorityBump: 14,
        tokenSize: BigInt.from(123123123),
        startTime: BigInt.from(234234234),
        endTime: BigInt.from(1234324123),
        allowHighBidCancel: true,
        reservePrice: BigInt.from(11111),
        minBidIncrement: BigInt.from(1223123123),
        timeExtPeriod: 123123123,
        timeExtDelta: 12);
    expect(layout.toHex(),
        "33e685a4017f83ad0b0c0d0eb3b55607000000007a21f60d000000009b4a92490000000001672b00000000000001b360e7480000000001b3b55607010c0000000101");
    final decode = MetaplexAuctioneerSellLayout.fromBuffer(layout.toBytes());
    expect(decode.toBytes(), layout.toBytes());
  });
}

void _withdraw() {
  test("withdraw", () {
    final layout = MetaplexAuctioneerWithdrawLayout(
        escrowPaymentBump: 12,
        auctioneerAuthorityBump: 24,
        amount: BigInt.from(123123123));
    expect(layout.toHex(), "b712469c946da1220c18b3b5560700000000");
    final decode =
        MetaplexAuctioneerWithdrawLayout.fromBuffer(layout.toBytes());
    expect(decode.toBytes(), layout.toBytes());
  });
}

void _bid() {
  test("bid", () {
    final bid = Bid(
        amount: BigInt.from(123),
        buyerTradeState: const SolAddress.unchecked(
            "57BYVwU1nZvkDkQZvqnNL71SE4jvegfGoEr6Eo6QgNyJ"));
    expect(
        "007b000000000000003d0427568db5811754651851ae1b5823d52b700fc835078241871ab2b0ca505d",
        bid.toHex());
  });
}

void _listingConfig() {
  test("listingConfig", () {
    final layout = ListingConfig(
      startTime: BigInt.from(123123123),
      endTime: BigInt.from(1231231),
      bid: Bid(
        amount: BigInt.from(213123123),
        buyerTradeState: const SolAddress.unchecked(
            "57BYVwU1nZvkDkQZvqnNL71SE4jvegfGoEr6Eo6QgNyJ"),
      ),
      bump: 22,
      reservePrice: BigInt.from(123324543),
      minBidIncrement: BigInt.from(6456456),
      timeExtPeriod: 123333,
      timeExtDelta: 33333,
      allowHighBidCancel: false,
    );
    expect(layout.toHex(),
        "b7c41a29832eb87300b3b55607000000007fc9120000000000003300b40c000000003d0427568db5811754651851ae1b5823d52b700fc835078241871ab2b0ca505d167fc85907000000008884620000000000c5e101003582000000");
    final decode = ListingConfig.fromBuffer(layout.toBytes());
    expect(decode.toBytes(), layout.toBytes());
  });
}

void _auctioneerAuthority() {
  test("auctioneerAuthority", () {
    const layout = AuctioneerAuthority(bump: 22);
    expect(layout.toHex(), "e44afff56053c50c16");
    final decode = AuctioneerAuthority.fromBuffer(layout.toBytes());
    expect(layout.toBytes(), decode.toBytes());
  });
}
