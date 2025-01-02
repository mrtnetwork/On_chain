import 'package:blockchain_utils/layout/layout.dart';
import 'package:on_chain/solana/src/borsh_serialization/program_layout.dart';
import 'package:on_chain/solana/src/instructions/metaplex/auctioneer/layouts/layouts/authorize.dart';
import 'package:on_chain/solana/src/instructions/metaplex/auctioneer/layouts/layouts/buy.dart';
import 'package:on_chain/solana/src/instructions/metaplex/auctioneer/layouts/layouts/cancel.dart';
import 'package:on_chain/solana/src/instructions/metaplex/auctioneer/layouts/layouts/deposit.dart';
import 'package:on_chain/solana/src/instructions/metaplex/auctioneer/layouts/layouts/execute_sale.dart';
import 'package:on_chain/solana/src/instructions/metaplex/auctioneer/layouts/layouts/sell.dart';
import 'package:on_chain/solana/src/instructions/metaplex/auctioneer/layouts/layouts/withdraw.dart';

import 'instructions.dart';

abstract class MetaplexAuctioneerProgramLayout extends ProgramLayout {
  const MetaplexAuctioneerProgramLayout();
  static final StructLayout _layout =
      LayoutConst.struct([LayoutConst.blob(8, property: 'instruction')]);
  @override
  abstract final MetaplexAuctioneerProgramInstruction instruction;
  static ProgramLayout fromBytes(List<int> data) {
    final decode =
        ProgramLayout.decodeAndValidateStruct(layout: _layout, bytes: data);
    final MetaplexAuctioneerProgramInstruction? instruction =
        MetaplexAuctioneerProgramInstruction.getInstruction(
            decode['instruction']);

    switch (instruction) {
      case MetaplexAuctioneerProgramInstruction.authorize:
        return MetaplexAuctioneerAuthorizeLayout.fromBuffer(data);
      case MetaplexAuctioneerProgramInstruction.buy:
        return MetaplexAuctioneerBuyLayout.fromBuffer(data);
      case MetaplexAuctioneerProgramInstruction.cancel:
        return MetaplexAuctioneerCancelLayout.fromBuffer(data);
      case MetaplexAuctioneerProgramInstruction.deposit:
        return MetaplexAuctioneerDepositLayout.fromBuffer(data);
      case MetaplexAuctioneerProgramInstruction.executeSale:
        return MetaplexAuctioneerExecuteSaleLayout.fromBuffer(data);
      case MetaplexAuctioneerProgramInstruction.sell:
        return MetaplexAuctioneerSellLayout.fromBuffer(data);
      case MetaplexAuctioneerProgramInstruction.withdraw:
        return MetaplexAuctioneerWithdrawLayout.fromBuffer(data);
      default:
        return UnknownProgramLayout(data);
    }
  }

  static Map<String, dynamic> decodeAndValidateStruct({
    required StructLayout layout,
    required List<int> bytes,
    required List<int> instruction,
  }) {
    return LayoutSerializable.decode(
        bytes: bytes, layout: layout, validator: {'instruction': instruction});
  }
}
