import 'package:blockchain_utils/blockchain_utils.dart';
import 'package:on_chain/solana/solana.dart';
import 'package:test/expect.dart';
import 'package:test/scaffolding.dart';

void main() {
  group('auctionHouse layout', () {
    _purchaseReceipt();
    _listeningReceipt();
    _bidReceipt();

    _auctioneer();

    _auctionHouse();
    _delegateAuctioneer();
    _auctionHouseAccount();
    _auctioneerBuy();
    _auctioneerCancel();
    _auctioneerDeposit();
    _auctioneerExecutePartialSale();
    _auctioneerExecuteSale();
    _auctioneerPublicBuy();
    _auctioneerSell();
    _auctioneerWithdraw();
    _buy();
    _cancel();
    _cancelBidReceipt();
    _cancelListingReceipt();
    _cancelRemainingAccounts();
    _closeEscrowAccount();
    _deposit();
    _executePartialSale();
    _executeSale();
    _executeSaleRemainingAccounts();
    _printBidReceipt();
    _printListingReceipt();
    _printPurchaseReceipt();
    _publicBuy();
    _sell();
    _sellRemainingAccounts();
    _updateAuctioneer();
    _updateAuctionHouse();
    _withdraw();
    _withdrawFromFee();
    _withdrawFromTreasury();
  });
}

void _auctionHouse() {
  test('create', () {
    const layout = MetaplexAuctionHouseCreateAuctionHouseLayout(
      bump: 1,
      feePayerBump: 1,
      treasuryBump: 1,
      sellerFeeBasisPoints: 1,
      requiresSignOff: false,
      canChangeSalePrice: false,
    );
    expect(layout.toHex(), 'dd42f29ff9ce86f101010101000000');
    final decode = MetaplexAuctionHouseCreateAuctionHouseLayout.fromBuffer(
        layout.toBytes());
    expect(layout.toBytes(), decode.toBytes());
  });
  test('create_2', () {
    const layout = MetaplexAuctionHouseCreateAuctionHouseLayout(
      bump: 100,
      feePayerBump: 100,
      treasuryBump: 100,
      sellerFeeBasisPoints: 100,
      requiresSignOff: true,
      canChangeSalePrice: true,
    );
    expect(layout.toHex(), 'dd42f29ff9ce86f164646464000101');
    final decode = MetaplexAuctionHouseCreateAuctionHouseLayout.fromBuffer(
        layout.toBytes());
    expect(layout.toBytes(), decode.toBytes());
  });
  test('create_3', () {
    const layout = MetaplexAuctionHouseCreateAuctionHouseLayout(
      bump: 25,
      feePayerBump: 50,
      treasuryBump: 75,
      sellerFeeBasisPoints: 100,
      requiresSignOff: true,
      canChangeSalePrice: false,
    );
    expect(layout.toHex(), 'dd42f29ff9ce86f119324b64000100');
    final decode = MetaplexAuctionHouseCreateAuctionHouseLayout.fromBuffer(
        layout.toBytes());
    expect(layout.toBytes(), decode.toBytes());
  });
}

void _delegateAuctioneer() {
  test('delegateAuctioneer', () {
    const layout = MetaplexAuctionHouseDelegateAuctioneerLayout(scopes: [
      AuthorityScope.buy,
      AuthorityScope.deposit,
      AuthorityScope.executeSale
    ]);
    expect(layout.toHex(), '6ab20c7a4aadfbde03000000010003');
    final decode = MetaplexAuctionHouseDelegateAuctioneerLayout.fromBuffer(
        layout.toBytes());
    expect(decode.toBytes(), layout.toBytes());
  });
  test('delegateAuctioneer_2', () {
    const layout = MetaplexAuctionHouseDelegateAuctioneerLayout(scopes: []);
    expect(layout.toHex(), '6ab20c7a4aadfbde00000000');
    final decode = MetaplexAuctionHouseDelegateAuctioneerLayout.fromBuffer(
        layout.toBytes());
    expect(decode.toBytes(), layout.toBytes());
  });
  test('delegateAuctioneer_3', () {
    const layout = MetaplexAuctionHouseDelegateAuctioneerLayout(
        scopes: AuthorityScope.values);
    expect(layout.toHex(), '6ab20c7a4aadfbde0700000000010203040506');
    final decode = MetaplexAuctionHouseDelegateAuctioneerLayout.fromBuffer(
        layout.toBytes());
    expect(decode.toBytes(), layout.toBytes());
  });
}

void _auctionHouseAccount() {
  /// https://explorer.solana.com/tx/4oP3dWYAjoBqfmh7Twg2ZmUkS5bHaVKeuphU6ekxJXoq2hEv7jmYfAxzoYRynyJAcs7PfJdBKLWtyS3SHSpqTu1A?cluster=devnet#ix-2
  test('auctionHouseAccount', () {
    final List<int> programData = StringUtils.encode(
        'KGzXa9VV9TBhYdbyGKVutCAwaEF7v5udopDzn8Go/n1yo5i1Xn9tWyIU9CxmruBe7Pb4j0pc2jL4PS2XufanxbRV/wr0Y85rPQQnVo21gRdUZRhRrhtYI9UrcA/INQeCQYcasrDKUF1VSkOnuOGmDawbgAvjEPlOVfj7dBV4C3gXfD7eGqC3ygabiFf+q4GE+2h/Y0YYwDXaxDncGus7VZig8AAAAAAB9sHazIsXSxDawYe7Huf+2Bm3foRZHcGCfcOJQ6XbvXb2wdrMixdLENrBh7se5/7YGbd+hFkdwYJ9w4lDpdu9dv/+/gEAAAAAAQzeZQus/JsmBSXZ+1sE26OWX1l05ja2tewNh5iUSU6FAQEAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA',
        type: StringEncoding.base64);
    final account = AuctionHouse.fromBuffer(programData);
    expect(account.auctionHouseFeeAccount.address,
        '7Z95SWdaLeBp5hSAfoCUeyaeijtmbsVjhwnzV1cVpceN');
    expect(account.auctionHouseTreasury.address,
        '3J3PpJoToVFAzT7hpEghuFBZapm93nbZWdky2ipnH71c');
    expect(account.creator.address,
        'HcEjuQ7Eate3eyNBaZV2cwATcdAH8F7VGygVqkkoqUjf');
    expect(account.auctioneerAddress.address,
        'sEac3HrsYnHSrbqx5BUBHpiXrBmJvhXMo9pMcYE4zYL');
    expect(account.feeWithdrawalDestination.address,
        '6jwLNd4w4RfZsj5WCszKB4wKHmU2gX24JLq2DH42No5s');
    expect(account.toBytes(), programData.sublist(0, AuctionHouse.size));
  });
}

void _auctioneerBuy() {
  test('auctioneerBuy', () {
    final layout = MetaplexAuctionHouseAuctioneerBuyLayout(
      tradeStateBump: 1,
      escrowPaymentBump: 2,
      buyerPrice: BigInt.from(3),
      tokenSize: BigInt.from(4),
    );
    expect(
        layout.toHex(), '116a852ee5302dd0010203000000000000000400000000000000');

    final decode =
        MetaplexAuctionHouseAuctioneerBuyLayout.fromBuffer(layout.toBytes());
    expect(decode.toBytes(), layout.toBytes());
  });
  test('auctioneerBuy_2', () {
    final layout = MetaplexAuctionHouseAuctioneerBuyLayout(
      tradeStateBump: 255,
      escrowPaymentBump: 255,
      buyerPrice: BigInt.from(69000000),
      tokenSize: BigInt.from(850000000),
    );
    expect(
        layout.toHex(), '116a852ee5302dd0ffff40db1c040000000080f8a93200000000');

    final decode =
        MetaplexAuctionHouseAuctioneerBuyLayout.fromBuffer(layout.toBytes());
    expect(decode.toBytes(), layout.toBytes());
  });
}

void _auctioneerCancel() {
  test('auctioneerCancel', () {
    final layout = MetaplexAuctionHouseAuctioneerCancelLayout(
      buyerPrice: BigInt.from(69000000),
      tokenSize: BigInt.from(850000000),
    );
    expect(layout.toHex(), 'c56198c473cc40d740db1c040000000080f8a93200000000');

    final decode =
        MetaplexAuctionHouseAuctioneerCancelLayout.fromBuffer(layout.toBytes());
    expect(decode.toBytes(), layout.toBytes());
  });
}

void _auctioneerDeposit() {
  test('auctioneerDeposit', () {
    final layout = MetaplexAuctionHouseAuctioneerDepositLayout(
        escrowPaymentBump: 1, amount: BigInt.from(550000));
    expect(layout.toHex(), '4f7a25a278ad397f017064080000000000');

    final decode = MetaplexAuctionHouseAuctioneerDepositLayout.fromBuffer(
        layout.toBytes());
    expect(decode.toBytes(), layout.toBytes());
  });
}

void _auctioneerExecutePartialSale() {
  test('auctioneerExecutePartialSale', () {
    final layout = MetaplexAuctionHouseAuctioneerExecutePartialSaleLayout(
      escrowPaymentBump: 1,
      freeTradeStateBump: 1,
      programAsSignerBump: 1,
      buyerPrice: BigInt.from(100000),
      tokenSize: BigInt.from(100000),
    );
    expect(layout.toHex(),
        '092c2e0fa18f1536010101a086010000000000a0860100000000000000');

    final decode =
        MetaplexAuctionHouseAuctioneerExecutePartialSaleLayout.fromBuffer(
            layout.toBytes());
    expect(decode.toBytes(), layout.toBytes());
  });
  test('auctioneerExecutePartialSale_1', () {
    final layout = MetaplexAuctionHouseAuctioneerExecutePartialSaleLayout(
        escrowPaymentBump: 1,
        freeTradeStateBump: 1,
        programAsSignerBump: 1,
        buyerPrice: BigInt.from(100000),
        tokenSize: BigInt.from(100000),
        partialOrderSize: BigInt.from(150));
    expect(layout.toHex(),
        '092c2e0fa18f1536010101a086010000000000a08601000000000001960000000000000000');

    final decode =
        MetaplexAuctionHouseAuctioneerExecutePartialSaleLayout.fromBuffer(
            layout.toBytes());
    expect(decode.toBytes(), layout.toBytes());
  });
  test('auctioneerExecutePartialSale_2', () {
    final layout = MetaplexAuctionHouseAuctioneerExecutePartialSaleLayout(
        escrowPaymentBump: 1,
        freeTradeStateBump: 1,
        programAsSignerBump: 1,
        buyerPrice: BigInt.from(100000),
        tokenSize: BigInt.from(100000),
        partialOrderSize: BigInt.from(150),
        partialOrderPrice: BigInt.from(350));
    expect(layout.toHex(),
        '092c2e0fa18f1536010101a086010000000000a086010000000000019600000000000000015e01000000000000');

    final decode =
        MetaplexAuctionHouseAuctioneerExecutePartialSaleLayout.fromBuffer(
            layout.toBytes());
    expect(decode.toBytes(), layout.toBytes());
  });
}

void _auctioneerExecuteSale() {
  test('auctioneerExecuteSale', () {
    final layout = MetaplexAuctionHouseAuctioneerExecuteSaleLayout(
        escrowPaymentBump: 1,
        freeTradeStateBump: 1,
        programAsSignerBump: 1,
        buyerPrice: BigInt.from(100000),
        tokenSize: BigInt.from(100000));
    expect(layout.toHex(),
        '447d2041fb2b2335010101a086010000000000a086010000000000');

    final decode = MetaplexAuctionHouseAuctioneerExecuteSaleLayout.fromBuffer(
        layout.toBytes());
    expect(decode.toBytes(), layout.toBytes());
  });
}

void _auctioneerPublicBuy() {
  test('auctioneerPublicBuy', () {
    final layout = MetaplexAuctionHouseAuctioneerPublicBuyLayout(
      tradeStateBump: 2,
      escrowPaymentBump: 4,
      buyerPrice: BigInt.from(10000),
      tokenSize: BigInt.from(123123123),
    );
    expect(
        layout.toHex(), 'ddef63f0562ed57e02041027000000000000b3b5560700000000');

    final decode = MetaplexAuctionHouseAuctioneerPublicBuyLayout.fromBuffer(
        layout.toBytes());
    expect(decode.toBytes(), layout.toBytes());
  });
}

void _auctioneerSell() {
  test('auctioneerSell', () {
    final layout = MetaplexAuctionHouseAuctioneerSellLayout(
      tradeStateBump: 1,
      freeTradeStateBump: 233,
      programAsSignerBump: 233,
      tokenSize: BigInt.from(123123123),
    );
    expect(layout.toHex(), 'fb3c8ec379cb1ab701e9e9b3b5560700000000');

    final decode =
        MetaplexAuctionHouseAuctioneerSellLayout.fromBuffer(layout.toBytes());
    expect(decode.toBytes(), layout.toBytes());
  });
}

void _auctioneerWithdraw() {
  test('auctioneerWithdraw', () {
    final layout = MetaplexAuctionHouseAuctioneerWithdrawLayout(
        escrowPaymentBump: 255, amount: BigInt.from(12312332423));
    expect(layout.toHex(), '55a6db6ea88fb4ecff8748dfdd02000000');

    final decode = MetaplexAuctionHouseAuctioneerWithdrawLayout.fromBuffer(
        layout.toBytes());
    expect(decode.toBytes(), layout.toBytes());
  });
}

void _buy() {
  test('buy', () {
    final layout = MetaplexAuctionHouseBuyLayout(
      tradeStateBump: 255,
      escrowPaymentBump: 255,
      buyerPrice: BigInt.from(123123123),
      tokenSize: BigInt.from(345345345),
    );
    expect(
        layout.toHex(), '66063d1201daebeaffffb3b5560700000000418d951400000000');

    final decode = MetaplexAuctionHouseBuyLayout.fromBuffer(layout.toBytes());
    expect(decode.toBytes(), layout.toBytes());
  });
}

void _cancel() {
  test('cancel', () {
    final layout = MetaplexAuctionHouseCancelLayout(
      buyerPrice: BigInt.from(123123123),
      tokenSize: BigInt.from(345345345),
    );
    expect(layout.toHex(), 'e8dbdf29dbecdcbeb3b5560700000000418d951400000000');

    final decode =
        MetaplexAuctionHouseCancelLayout.fromBuffer(layout.toBytes());
    expect(decode.toBytes(), layout.toBytes());
  });
}

void _cancelBidReceipt() {
  test('cancelBidReceipt', () {
    const layout = MetaplexAuctionHouseCancelBidReceiptLayout();
    expect(layout.toHex(), 'f66c1be5dc2ab02b');

    final decode =
        MetaplexAuctionHouseCancelBidReceiptLayout.fromBuffer(layout.toBytes());
    expect(decode.toBytes(), layout.toBytes());
  });
}

void _cancelListingReceipt() {
  test('cancelListingReceipt', () {
    const layout = MetaplexAuctionHouseCancelListingReceiptLayout();
    expect(layout.toHex(), 'ab3b8a7ef6bd5b0b');

    final decode = MetaplexAuctionHouseCancelListingReceiptLayout.fromBuffer(
        layout.toBytes());
    expect(decode.toBytes(), layout.toBytes());
  });
}

void _cancelRemainingAccounts() {
  test('cancelRemainingAccounts', () {
    const layout = MetaplexAuctionHouseCancelRemainingAccountsLayout();
    expect(layout.toHex(), '6b4da1fb4681bd9c');

    final decode = MetaplexAuctionHouseCancelRemainingAccountsLayout.fromBuffer(
        layout.toBytes());
    expect(decode.toBytes(), layout.toBytes());
  });
}

void _closeEscrowAccount() {
  test('closeEscrowAccount', () {
    const layout =
        MetaplexAuctionHouseCloseEscrowAccountLayout(escrowPaymentBump: 255);
    expect(layout.toHex(), 'd12ad0b38c4e122bff');

    final decode = MetaplexAuctionHouseCloseEscrowAccountLayout.fromBuffer(
        layout.toBytes());
    expect(decode.toBytes(), layout.toBytes());
  });
}

void _deposit() {
  test('deposit', () {
    final layout = MetaplexAuctionHouseDepositLayout(
        escrowPaymentBump: 200, amount: BigInt.from(12412341324));
    expect(layout.toHex(), 'f223c68952e1f2b6c84c4cd5e302000000');

    final decode =
        MetaplexAuctionHouseDepositLayout.fromBuffer(layout.toBytes());
    expect(decode.toBytes(), layout.toBytes());
  });
}

void _executePartialSale() {
  test('executePartialSale', () {
    final layout = MetaplexAuctionHouseExecutePartialSaleLayout(
      escrowPaymentBump: 200,
      freeTradeStateBump: 200,
      programAsSignerBump: 200,
      buyerPrice: BigInt.from(200),
      tokenSize: BigInt.from(200),
    );
    expect(layout.toHex(),
        'a312239d31a4cb85c8c8c8c800000000000000c8000000000000000000');

    final decode = MetaplexAuctionHouseExecutePartialSaleLayout.fromBuffer(
        layout.toBytes());
    expect(decode.toBytes(), layout.toBytes());
  });
  test('executePartialSale_1', () {
    final layout = MetaplexAuctionHouseExecutePartialSaleLayout(
      escrowPaymentBump: 200,
      freeTradeStateBump: 200,
      programAsSignerBump: 200,
      buyerPrice: BigInt.from(200),
      tokenSize: BigInt.from(200),
      partialOrderPrice: BigInt.from(200),
    );
    expect(layout.toHex(),
        'a312239d31a4cb85c8c8c8c800000000000000c8000000000000000001c800000000000000');

    final decode = MetaplexAuctionHouseExecutePartialSaleLayout.fromBuffer(
        layout.toBytes());
    expect(decode.toBytes(), layout.toBytes());
  });
  test('executePartialSale_2', () {
    final layout = MetaplexAuctionHouseExecutePartialSaleLayout(
      escrowPaymentBump: 200,
      freeTradeStateBump: 200,
      programAsSignerBump: 200,
      buyerPrice: BigInt.from(200),
      tokenSize: BigInt.from(200),
      partialOrderPrice: BigInt.from(200),
      partialOrderSize: BigInt.from(200),
    );
    expect(layout.toHex(),
        'a312239d31a4cb85c8c8c8c800000000000000c80000000000000001c80000000000000001c800000000000000');

    final decode = MetaplexAuctionHouseExecutePartialSaleLayout.fromBuffer(
        layout.toBytes());
    expect(decode.toBytes(), layout.toBytes());
  });
}

void _executeSale() {
  test('executeSale', () {
    final layout = MetaplexAuctionHouseExecuteSaleLayout(
      escrowPaymentBump: 112,
      freeTradeStateBump: 112,
      programAsSignerBump: 112,
      buyerPrice: BigInt.from(123123123),
      tokenSize: BigInt.from(4234234234),
    );
    expect(layout.toHex(),
        '254ad99d4f312306707070b3b55607000000007a4961fc00000000');

    final decode =
        MetaplexAuctionHouseExecuteSaleLayout.fromBuffer(layout.toBytes());
    expect(decode.toBytes(), layout.toBytes());
  });
}

void _executeSaleRemainingAccounts() {
  test('executeSaleRemainingAccounts', () {
    const layout = MetaplexAuctionHouseExecuteSaleRemainingAccountsLayout();
    expect(layout.toHex(), '9f0cabfe8dc67a07');

    final decode =
        MetaplexAuctionHouseExecuteSaleRemainingAccountsLayout.fromBuffer(
            layout.toBytes());
    expect(decode.toBytes(), layout.toBytes());
  });
}

void _printBidReceipt() {
  test('printBidReceipt', () {
    const layout = MetaplexAuctionHousePrintBidReceiptLayout(receiptBump: 112);
    expect(layout.toHex(), '5ef95ae6ef4044da70');

    final decode =
        MetaplexAuctionHousePrintBidReceiptLayout.fromBuffer(layout.toBytes());
    expect(decode.toBytes(), layout.toBytes());
  });
}

void _printListingReceipt() {
  test('printListingReceipt', () {
    const layout =
        MetaplexAuctionHousePrintListingReceiptLayout(receiptBump: 112);
    expect(layout.toHex(), 'cf6b2ca04bdec31b70');

    final decode = MetaplexAuctionHousePrintListingReceiptLayout.fromBuffer(
        layout.toBytes());
    expect(decode.toBytes(), layout.toBytes());
  });
}

void _printPurchaseReceipt() {
  test('printPurchaseReceipt', () {
    const layout = MetaplexAuctionHousePrintPurchaseReceiptLayout(
        purchaseReceiptBump: 112);
    expect(layout.toHex(), 'e39afb07b438648f70');

    final decode = MetaplexAuctionHousePrintPurchaseReceiptLayout.fromBuffer(
        layout.toBytes());
    expect(decode.toBytes(), layout.toBytes());
  });
}

void _publicBuy() {
  test('printPurchaseReceipt', () {
    final layout = MetaplexAuctionHousePublicBuyLayout(
      tradeStateBump: 222,
      escrowPaymentBump: 222,
      buyerPrice: BigInt.from(23123123123),
      tokenSize: BigInt.from(23123123123),
    );
    expect(
        layout.toHex(), 'a954da232ace10abdedeb3db3e6205000000b3db3e6205000000');

    final decode =
        MetaplexAuctionHousePublicBuyLayout.fromBuffer(layout.toBytes());
    expect(decode.toBytes(), layout.toBytes());
  });
}

void _sell() {
  test('sell', () {
    final layout = MetaplexAuctionHouseSellLayout(
      tradeStateBump: 223,
      freeTradeStateBump: 223,
      programAsSignerBump: 223,
      buyerPrice: BigInt.from(1231231244324),
      tokenSize: BigInt.from(325231231),
    );
    expect(layout.toHex(),
        '33e685a4017f83addfdfdf24d819ab1e0100007fa2621300000000');

    final decode = MetaplexAuctionHouseSellLayout.fromBuffer(layout.toBytes());
    expect(decode.toBytes(), layout.toBytes());
  });
}

void _sellRemainingAccounts() {
  test('sellRemainingAccounts', () {
    const layout = MetaplexAuctionHouseSellRemainingAccountsLayout();
    expect(layout.toHex(), '7117c72919cbea1e');

    final decode = MetaplexAuctionHouseSellRemainingAccountsLayout.fromBuffer(
        layout.toBytes());
    expect(decode.toBytes(), layout.toBytes());
  });
}

void _updateAuctioneer() {
  test('updateAuctioneer', () {
    const layout = MetaplexAuctionHouseUpdateAuctioneerLayout(scopes: [
      AuthorityScope.buy,
      AuthorityScope.cancel,
      AuthorityScope.sell
    ]);
    expect(layout.toHex(), '67ff50ea5e38a8d003000000010504');

    final decode =
        MetaplexAuctionHouseUpdateAuctioneerLayout.fromBuffer(layout.toBytes());
    expect(decode.toBytes(), layout.toBytes());
  });
}

void _updateAuctionHouse() {
  test('updateAuctionHouse', () {
    const layout = MetaplexAuctionHouseUpdateAuctionHouseLayout();
    expect(layout.toHex(), '54d702acf100f5db000000');

    final decode = MetaplexAuctionHouseUpdateAuctionHouseLayout.fromBuffer(
        layout.toBytes());
    expect(decode.toBytes(), layout.toBytes());
  });
  test('updateAuctionHouse_1', () {
    const layout =
        MetaplexAuctionHouseUpdateAuctionHouseLayout(sellerFeeBasisPoints: 24);
    expect(layout.toHex(), '54d702acf100f5db0118000000');

    final decode = MetaplexAuctionHouseUpdateAuctionHouseLayout.fromBuffer(
        layout.toBytes());
    expect(decode.toBytes(), layout.toBytes());
  });
  test('updateAuctionHouse_2', () {
    const layout = MetaplexAuctionHouseUpdateAuctionHouseLayout(
      sellerFeeBasisPoints: 24,
      requiresSignOff: true,
    );
    expect(layout.toHex(), '54d702acf100f5db011800010100');

    final decode = MetaplexAuctionHouseUpdateAuctionHouseLayout.fromBuffer(
        layout.toBytes());
    expect(decode.toBytes(), layout.toBytes());
  });
  test('updateAuctionHouse_3', () {
    const layout = MetaplexAuctionHouseUpdateAuctionHouseLayout(
        sellerFeeBasisPoints: 24,
        requiresSignOff: true,
        canChangeSalePrice: false);
    expect(layout.toHex(), '54d702acf100f5db01180001010100');

    final decode = MetaplexAuctionHouseUpdateAuctionHouseLayout.fromBuffer(
        layout.toBytes());
    expect(decode.toBytes(), layout.toBytes());
  });
}

void _withdraw() {
  test('withdraw', () {
    final layout = MetaplexAuctionHouseWithdrawLayout(
        escrowPaymentBump: 100, amount: BigInt.from(213091209309));
    expect(layout.toHex(), 'b712469c946da122645dd0399d31000000');

    final decode =
        MetaplexAuctionHouseWithdrawLayout.fromBuffer(layout.toBytes());
    expect(decode.toBytes(), layout.toBytes());
  });
}

void _withdrawFromFee() {
  test('withdrawFromFee', () {
    final layout = MetaplexAuctionHouseWithdrawFromFeeLayout(
        amount: BigInt.from(213091209309));
    expect(layout.toHex(), 'b3d0be9a20b3133b5dd0399d31000000');

    final decode =
        MetaplexAuctionHouseWithdrawFromFeeLayout.fromBuffer(layout.toBytes());
    expect(decode.toBytes(), layout.toBytes());
  });
}

void _withdrawFromTreasury() {
  test('withdrawFromTreasury', () {
    final layout = MetaplexAuctionHouseWithdrawFromTreasuryLayout(
        amount: BigInt.from(213091209309));
    expect(layout.toHex(), '00a4564c38480caa5dd0399d31000000');

    final decode = MetaplexAuctionHouseWithdrawFromTreasuryLayout.fromBuffer(
        layout.toBytes());
    expect(decode.toBytes(), layout.toBytes());
  });
}

void _auctioneer() {
  test('auctioneer', () {
    const layout = Auctioneer(
        auctionHouse: SolAddress.unchecked(
            '57BYVwU1nZvkDkQZvqnNL71SE4jvegfGoEr6Eo6QgNyJ'),
        auctioneerAuthority: SolAddress.unchecked(
            'HcEjuQ7Eate3eyNBaZV2cwATcdAH8F7VGygVqkkoqUjf'),
        bump: 22);
    expect(layout.toHex(),
        '2e655c968a1ef578f6c1dacc8b174b10dac187bb1ee7fed819b77e84591dc1827dc38943a5dbbd763d0427568db5811754651851ae1b5823d52b700fc835078241871ab2b0ca505d16');
    final decode = Auctioneer.fromBuffer(layout.toBytes());
    expect(decode.toBytes(), layout.toBytes());
  });
}

void _bidReceipt() {
  const owner =
      SolAddress.unchecked('HcEjuQ7Eate3eyNBaZV2cwATcdAH8F7VGygVqkkoqUjf');
  const account1 =
      SolAddress.unchecked('57BYVwU1nZvkDkQZvqnNL71SE4jvegfGoEr6Eo6QgNyJ');
  test('bidReceipt', () {
    final layout = BidReceipt(
      tradeState: owner,
      bookkeeper: owner,
      auctionHouse: owner,
      buyer: owner,
      metadata: owner,
      // tokenAccount: undefined,
      // purchaseReceipt: undefined,
      price: BigInt.from(123123123),
      tokenSize: BigInt.from(1231231),
      bump: 23,
      tradeStateBump: 33,
      createdAt: BigInt.from(44),
      // canceledAt: undefined,
    );
    expect(layout.toHex(),
        'ba968d873b7a2763f6c1dacc8b174b10dac187bb1ee7fed819b77e84591dc1827dc38943a5dbbd76f6c1dacc8b174b10dac187bb1ee7fed819b77e84591dc1827dc38943a5dbbd76f6c1dacc8b174b10dac187bb1ee7fed819b77e84591dc1827dc38943a5dbbd76f6c1dacc8b174b10dac187bb1ee7fed819b77e84591dc1827dc38943a5dbbd76f6c1dacc8b174b10dac187bb1ee7fed819b77e84591dc1827dc38943a5dbbd760000b3b55607000000007fc912000000000017212c0000000000000000');
    final decode = BidReceipt.fromBuffer(layout.toBytes());
    expect(decode.toBytes(), layout.toBytes());
  });
  test('bidReceipt_1', () {
    final layout = BidReceipt(
      tradeState: owner,
      bookkeeper: owner,
      auctionHouse: owner,
      buyer: owner,
      metadata: owner,
      tokenAccount: account1,
      purchaseReceipt: account1,
      price: BigInt.from(123123123),
      tokenSize: BigInt.from(1231231),
      bump: 23,
      tradeStateBump: 33,
      createdAt: BigInt.from(44),
      // canceledAt: undefined,
    );
    expect(layout.toHex(),
        'ba968d873b7a2763f6c1dacc8b174b10dac187bb1ee7fed819b77e84591dc1827dc38943a5dbbd76f6c1dacc8b174b10dac187bb1ee7fed819b77e84591dc1827dc38943a5dbbd76f6c1dacc8b174b10dac187bb1ee7fed819b77e84591dc1827dc38943a5dbbd76f6c1dacc8b174b10dac187bb1ee7fed819b77e84591dc1827dc38943a5dbbd76f6c1dacc8b174b10dac187bb1ee7fed819b77e84591dc1827dc38943a5dbbd76013d0427568db5811754651851ae1b5823d52b700fc835078241871ab2b0ca505d013d0427568db5811754651851ae1b5823d52b700fc835078241871ab2b0ca505db3b55607000000007fc912000000000017212c0000000000000000');
    final decode = BidReceipt.fromBuffer(layout.toBytes());
    expect(decode.toBytes(), layout.toBytes());
  });
  test('bidReceipt_2', () {
    final layout = BidReceipt(
      tradeState: owner,
      bookkeeper: owner,
      auctionHouse: owner,
      buyer: owner,
      metadata: owner,
      tokenAccount: account1,
      purchaseReceipt: account1,
      price: BigInt.from(123123123),
      tokenSize: BigInt.from(1231231),
      bump: 23,
      tradeStateBump: 33,
      createdAt: BigInt.from(44),
      canceledAt: BigInt.from(-123123),
    );
    expect(layout.toHex(),
        'ba968d873b7a2763f6c1dacc8b174b10dac187bb1ee7fed819b77e84591dc1827dc38943a5dbbd76f6c1dacc8b174b10dac187bb1ee7fed819b77e84591dc1827dc38943a5dbbd76f6c1dacc8b174b10dac187bb1ee7fed819b77e84591dc1827dc38943a5dbbd76f6c1dacc8b174b10dac187bb1ee7fed819b77e84591dc1827dc38943a5dbbd76f6c1dacc8b174b10dac187bb1ee7fed819b77e84591dc1827dc38943a5dbbd76013d0427568db5811754651851ae1b5823d52b700fc835078241871ab2b0ca505d013d0427568db5811754651851ae1b5823d52b700fc835078241871ab2b0ca505db3b55607000000007fc912000000000017212c00000000000000010d1ffeffffffffff');
    final decode = BidReceipt.fromBuffer(layout.toBytes());
    expect(decode.toBytes(), layout.toBytes());
  });
}

void _listeningReceipt() {
  const owner =
      SolAddress.unchecked('HcEjuQ7Eate3eyNBaZV2cwATcdAH8F7VGygVqkkoqUjf');
  const account1 =
      SolAddress.unchecked('57BYVwU1nZvkDkQZvqnNL71SE4jvegfGoEr6Eo6QgNyJ');
  test('listeningReceipt', () {
    final layout = ListingReceipt(
      tradeState: owner,
      bookkeeper: owner,
      auctionHouse: owner,
      seller: owner,
      metadata: owner,
      purchaseReceipt: null,
      price: BigInt.from(12312312),
      tokenSize: BigInt.from(213123),
      bump: 12,
      tradeStateBump: 13,
      createdAt: BigInt.from(2123123),
      canceledAt: null,
    );
    expect(layout.toHex(),
        'f047e15ec84b54e7f6c1dacc8b174b10dac187bb1ee7fed819b77e84591dc1827dc38943a5dbbd76f6c1dacc8b174b10dac187bb1ee7fed819b77e84591dc1827dc38943a5dbbd76f6c1dacc8b174b10dac187bb1ee7fed819b77e84591dc1827dc38943a5dbbd76f6c1dacc8b174b10dac187bb1ee7fed819b77e84591dc1827dc38943a5dbbd76f6c1dacc8b174b10dac187bb1ee7fed819b77e84591dc1827dc38943a5dbbd7600f8debb000000000083400300000000000c0d736520000000000000');
    final decode = ListingReceipt.fromBuffer(layout.toBytes());
    expect(layout.toBytes(), decode.toBytes());
  });
  test('listeningReceipt_1', () {
    final layout = ListingReceipt(
      tradeState: owner,
      bookkeeper: owner,
      auctionHouse: owner,
      seller: owner,
      metadata: owner,
      purchaseReceipt: account1,
      price: BigInt.from(12312312),
      tokenSize: BigInt.from(213123),
      bump: 12,
      tradeStateBump: 13,
      createdAt: BigInt.from(2123123),
      canceledAt: BigInt.from(-1),
    );
    expect(layout.toHex(),
        'f047e15ec84b54e7f6c1dacc8b174b10dac187bb1ee7fed819b77e84591dc1827dc38943a5dbbd76f6c1dacc8b174b10dac187bb1ee7fed819b77e84591dc1827dc38943a5dbbd76f6c1dacc8b174b10dac187bb1ee7fed819b77e84591dc1827dc38943a5dbbd76f6c1dacc8b174b10dac187bb1ee7fed819b77e84591dc1827dc38943a5dbbd76f6c1dacc8b174b10dac187bb1ee7fed819b77e84591dc1827dc38943a5dbbd76013d0427568db5811754651851ae1b5823d52b700fc835078241871ab2b0ca505df8debb000000000083400300000000000c0d736520000000000001ffffffffffffffff');
    final decode = ListingReceipt.fromBuffer(layout.toBytes());
    expect(layout.toBytes(), decode.toBytes());
  });
}

void _purchaseReceipt() {
  const owner =
      SolAddress.unchecked('HcEjuQ7Eate3eyNBaZV2cwATcdAH8F7VGygVqkkoqUjf');
  test('purchaseReceipt', () {
    final layout = PurchaseReceipt(
      bookkeeper: owner,
      buyer: owner,
      seller: owner,
      auctionHouse: owner,
      metadata: owner,
      tokenSize: BigInt.from(3123),
      price: BigInt.from(234234),
      bump: 22,
      createdAt: BigInt.from(123423),
    );
    expect(layout.toHex(),
        '4f7fde899a839686f6c1dacc8b174b10dac187bb1ee7fed819b77e84591dc1827dc38943a5dbbd76f6c1dacc8b174b10dac187bb1ee7fed819b77e84591dc1827dc38943a5dbbd76f6c1dacc8b174b10dac187bb1ee7fed819b77e84591dc1827dc38943a5dbbd76f6c1dacc8b174b10dac187bb1ee7fed819b77e84591dc1827dc38943a5dbbd76f6c1dacc8b174b10dac187bb1ee7fed819b77e84591dc1827dc38943a5dbbd76330c000000000000fa92030000000000161fe2010000000000');
    final decode = PurchaseReceipt.fromBuffer(layout.toBytes());
    expect(decode.toBytes(), layout.toBytes());
  });
}
