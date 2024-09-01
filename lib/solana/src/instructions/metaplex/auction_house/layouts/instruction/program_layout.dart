import 'package:blockchain_utils/layout/layout.dart';
import 'package:on_chain/solana/src/borsh_serialization/program_layout.dart';
import 'package:on_chain/solana/src/instructions/metaplex/auction_house/layouts/layouts/auctioneer_buy.dart';
import 'package:on_chain/solana/src/instructions/metaplex/auction_house/layouts/layouts/auctioneer_cancel.dart';
import 'package:on_chain/solana/src/instructions/metaplex/auction_house/layouts/layouts/auctioneer_deposit.dart';
import 'package:on_chain/solana/src/instructions/metaplex/auction_house/layouts/layouts/auctioneer_execute_partial_sale.dart';
import 'package:on_chain/solana/src/instructions/metaplex/auction_house/layouts/layouts/auctioneer_execute_sale.dart';
import 'package:on_chain/solana/src/instructions/metaplex/auction_house/layouts/layouts/auctioneer_public_buy.dart';
import 'package:on_chain/solana/src/instructions/metaplex/auction_house/layouts/layouts/auctioneer_sell.dart';
import 'package:on_chain/solana/src/instructions/metaplex/auction_house/layouts/layouts/auctioneer_withdraw.dart';
import 'package:on_chain/solana/src/instructions/metaplex/auction_house/layouts/layouts/buy.dart';
import 'package:on_chain/solana/src/instructions/metaplex/auction_house/layouts/layouts/cancel.dart';
import 'package:on_chain/solana/src/instructions/metaplex/auction_house/layouts/layouts/cancel_bid_receipt.dart';
import 'package:on_chain/solana/src/instructions/metaplex/auction_house/layouts/layouts/cancel_listing_receipt.dart';
import 'package:on_chain/solana/src/instructions/metaplex/auction_house/layouts/layouts/cancel_remaining_accounts.dart';
import 'package:on_chain/solana/src/instructions/metaplex/auction_house/layouts/layouts/close_escrow_account.dart';
import 'package:on_chain/solana/src/instructions/metaplex/auction_house/layouts/layouts/create_auction_house.dart';
import 'package:on_chain/solana/src/instructions/metaplex/auction_house/layouts/layouts/delegate_auctioneer.dart';
import 'package:on_chain/solana/src/instructions/metaplex/auction_house/layouts/layouts/deposit.dart';
import 'package:on_chain/solana/src/instructions/metaplex/auction_house/layouts/layouts/execute_partial_sale.dart';
import 'package:on_chain/solana/src/instructions/metaplex/auction_house/layouts/layouts/execute_sale.dart';
import 'package:on_chain/solana/src/instructions/metaplex/auction_house/layouts/layouts/execute_sale_remaining_accounts.dart';
import 'package:on_chain/solana/src/instructions/metaplex/auction_house/layouts/layouts/print_bid_receipt.dart';
import 'package:on_chain/solana/src/instructions/metaplex/auction_house/layouts/layouts/print_listing_receipt.dart';
import 'package:on_chain/solana/src/instructions/metaplex/auction_house/layouts/layouts/print_purchase_receipt.dart';
import 'package:on_chain/solana/src/instructions/metaplex/auction_house/layouts/layouts/public_buy.dart';
import 'package:on_chain/solana/src/instructions/metaplex/auction_house/layouts/layouts/sell.dart';
import 'package:on_chain/solana/src/instructions/metaplex/auction_house/layouts/layouts/sell_remaining_accounts.dart';
import 'package:on_chain/solana/src/instructions/metaplex/auction_house/layouts/layouts/update_auction_house.dart';
import 'package:on_chain/solana/src/instructions/metaplex/auction_house/layouts/layouts/update_auctioneer.dart';
import 'package:on_chain/solana/src/instructions/metaplex/auction_house/layouts/layouts/withdraw.dart';
import 'package:on_chain/solana/src/instructions/metaplex/auction_house/layouts/layouts/withdraw_from_fee.dart';
import 'package:on_chain/solana/src/instructions/metaplex/auction_house/layouts/layouts/withdraw_from_treasury.dart';

import 'instructions.dart';

abstract class MetaplexAuctionHouseProgramLayout extends ProgramLayout {
  const MetaplexAuctionHouseProgramLayout();
  static final StructLayout _layout =
      LayoutConst.struct([LayoutConst.blob(8, property: "instruction")]);
  @override
  abstract final MetaplexAuctionHouseProgramInstruction instruction;

  static ProgramLayout fromBytes(List<int> data) {
    final decode =
        ProgramLayout.decodeAndValidateStruct(layout: _layout, bytes: data);
    MetaplexAuctionHouseProgramInstruction? instruction =
        MetaplexAuctionHouseProgramInstruction.getInstruction(
            decode["instruction"]);

    switch (instruction) {
      case MetaplexAuctionHouseProgramInstruction.auctioneerBuy:
        return MetaplexAuctionHouseAuctioneerBuyLayout.fromBuffer(data);

      case MetaplexAuctionHouseProgramInstruction.auctioneerCancel:
        return MetaplexAuctionHouseAuctioneerCancelLayout.fromBuffer(data);
      case MetaplexAuctionHouseProgramInstruction.auctioneerDeposit:
        return MetaplexAuctionHouseAuctioneerDepositLayout.fromBuffer(data);
      case MetaplexAuctionHouseProgramInstruction.auctioneerExecutePartialSale:
        return MetaplexAuctionHouseAuctioneerExecutePartialSaleLayout
            .fromBuffer(data);
      case MetaplexAuctionHouseProgramInstruction.auctioneerExecuteSale:
        return MetaplexAuctionHouseAuctioneerExecuteSaleLayout.fromBuffer(data);
      case MetaplexAuctionHouseProgramInstruction.auctioneerPublicBuy:
        return MetaplexAuctionHouseAuctioneerPublicBuyLayout.fromBuffer(data);
      case MetaplexAuctionHouseProgramInstruction.auctioneerSell:
        return MetaplexAuctionHouseAuctioneerSellLayout.fromBuffer(data);
      case MetaplexAuctionHouseProgramInstruction.auctioneerWithdraw:
        return MetaplexAuctionHouseAuctioneerWithdrawLayout.fromBuffer(data);
      case MetaplexAuctionHouseProgramInstruction.buy:
        return MetaplexAuctionHouseBuyLayout.fromBuffer(data);
      case MetaplexAuctionHouseProgramInstruction.cancel:
        return MetaplexAuctionHouseCancelLayout.fromBuffer(data);
      case MetaplexAuctionHouseProgramInstruction.cancelBidReceipt:
        return MetaplexAuctionHouseCancelBidReceiptLayout.fromBuffer(data);
      case MetaplexAuctionHouseProgramInstruction.cancelListingReceipt:
        return MetaplexAuctionHouseCancelListingReceiptLayout.fromBuffer(data);
      case MetaplexAuctionHouseProgramInstruction.cancelRemainingAccounts:
        return MetaplexAuctionHouseCancelRemainingAccountsLayout.fromBuffer(
            data);
      case MetaplexAuctionHouseProgramInstruction.closeEscrowAccount:
        return MetaplexAuctionHouseCloseEscrowAccountLayout.fromBuffer(data);
      case MetaplexAuctionHouseProgramInstruction.createAuctionHouse:
        return MetaplexAuctionHouseCreateAuctionHouseLayout.fromBuffer(data);
      case MetaplexAuctionHouseProgramInstruction.delegateAuctioneer:
        return MetaplexAuctionHouseDelegateAuctioneerLayout.fromBuffer(data);
      case MetaplexAuctionHouseProgramInstruction.deposit:
        return MetaplexAuctionHouseDepositLayout.fromBuffer(data);
      case MetaplexAuctionHouseProgramInstruction.executePartialSale:
        return MetaplexAuctionHouseExecutePartialSaleLayout.fromBuffer(data);
      case MetaplexAuctionHouseProgramInstruction.executeSale:
        return MetaplexAuctionHouseExecuteSaleLayout.fromBuffer(data);
      case MetaplexAuctionHouseProgramInstruction.executeSaleRemainingAccounts:
        return MetaplexAuctionHouseExecuteSaleRemainingAccountsLayout
            .fromBuffer(data);
      case MetaplexAuctionHouseProgramInstruction.printBidReceipt:
        return MetaplexAuctionHousePrintBidReceiptLayout.fromBuffer(data);
      case MetaplexAuctionHouseProgramInstruction.printListingReceipt:
        return MetaplexAuctionHousePrintListingReceiptLayout.fromBuffer(data);
      case MetaplexAuctionHouseProgramInstruction.printPurchaseReceipt:
        return MetaplexAuctionHousePrintPurchaseReceiptLayout.fromBuffer(data);
      case MetaplexAuctionHouseProgramInstruction.publicBuy:
        return MetaplexAuctionHousePublicBuyLayout.fromBuffer(data);
      case MetaplexAuctionHouseProgramInstruction.sell:
        return MetaplexAuctionHouseSellLayout.fromBuffer(data);
      case MetaplexAuctionHouseProgramInstruction.sellRemainingAccounts:
        return MetaplexAuctionHouseSellRemainingAccountsLayout.fromBuffer(data);
      case MetaplexAuctionHouseProgramInstruction.updateAuctioneer:
        return MetaplexAuctionHouseUpdateAuctioneerLayout.fromBuffer(data);
      case MetaplexAuctionHouseProgramInstruction.updateAuctionHouse:
        return MetaplexAuctionHouseUpdateAuctionHouseLayout.fromBuffer(data);
      case MetaplexAuctionHouseProgramInstruction.withdraw:
        return MetaplexAuctionHouseWithdrawLayout.fromBuffer(data);
      case MetaplexAuctionHouseProgramInstruction.withdrawFromFee:
        return MetaplexAuctionHouseWithdrawFromFeeLayout.fromBuffer(data);
      case MetaplexAuctionHouseProgramInstruction.withdrawFromTreasury:
        return MetaplexAuctionHouseWithdrawFromTreasuryLayout.fromBuffer(data);
      default:
        return UnknownProgramLayout(data);
    }

    // return UnknownProgramLayout(data);
  }

  static Map<String, dynamic> decodeAndValidateStruct({
    required StructLayout layout,
    required List<int> bytes,
    required List<int> instruction,
  }) {
    return LayoutSerializable.decode(
        bytes: bytes, layout: layout, validator: {"instruction": instruction});
  }
}
