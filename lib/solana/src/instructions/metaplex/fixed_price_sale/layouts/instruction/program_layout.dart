import 'package:blockchain_utils/utils/utils.dart';

import 'package:on_chain/solana/src/exception/exception.dart';
import 'package:blockchain_utils/layout/layout.dart';
import 'package:on_chain/solana/src/borsh_serialization/program_layout.dart';
import 'package:on_chain/solana/src/instructions/metaplex/fixed_price_sale/layouts/layouts/buy.dart';
import 'package:on_chain/solana/src/instructions/metaplex/fixed_price_sale/layouts/layouts/buy_v2.dart';
import 'package:on_chain/solana/src/instructions/metaplex/fixed_price_sale/layouts/layouts/change_market.dart';
import 'package:on_chain/solana/src/instructions/metaplex/fixed_price_sale/layouts/layouts/claim_resource.dart';
import 'package:on_chain/solana/src/instructions/metaplex/fixed_price_sale/layouts/layouts/close_market.dart';
import 'package:on_chain/solana/src/instructions/metaplex/fixed_price_sale/layouts/layouts/create_market.dart';
import 'package:on_chain/solana/src/instructions/metaplex/fixed_price_sale/layouts/layouts/create_store.dart';
import 'package:on_chain/solana/src/instructions/metaplex/fixed_price_sale/layouts/layouts/init_selling_resource.dart';
import 'package:on_chain/solana/src/instructions/metaplex/fixed_price_sale/layouts/layouts/resume_market.dart';
import 'package:on_chain/solana/src/instructions/metaplex/fixed_price_sale/layouts/layouts/save_primary_metadata_creators.dart';
import 'package:on_chain/solana/src/instructions/metaplex/fixed_price_sale/layouts/layouts/suspend_market.dart';
import 'package:on_chain/solana/src/instructions/metaplex/fixed_price_sale/layouts/layouts/withdraw.dart';

import 'instructions.dart';

abstract class MetaplexFixedPriceSaleProgramLayout extends ProgramLayout {
  const MetaplexFixedPriceSaleProgramLayout();
  static final StructLayout _layout =
      LayoutConst.struct([LayoutConst.blob(8, property: "instruction")]);
  @override
  abstract final MetaplexFixedPriceSaleProgramInstruction instruction;
  static ProgramLayout fromBytes(List<int> data) {
    final decode =
        ProgramLayout.decodeAndValidateStruct(layout: _layout, bytes: data);
    MetaplexFixedPriceSaleProgramInstruction? instruction =
        MetaplexFixedPriceSaleProgramInstruction.getInstruction(
            decode["instruction"]);

    switch (instruction) {
      case MetaplexFixedPriceSaleProgramInstruction.buy:
        return MetaplexFixedPriceSaleBuyLayout.fromBuffer(data);
      case MetaplexFixedPriceSaleProgramInstruction.buyV2:
        return MetaplexFixedPriceSaleBuyV2Layout.fromBuffer(data);
      case MetaplexFixedPriceSaleProgramInstruction.changeMarket:
        return MetaplexFixedPriceSaleChangeMarketLayout.fromBuffer(data);
      case MetaplexFixedPriceSaleProgramInstruction.claimResource:
        return MetaplexFixedPriceSaleClaimResourceLayout.fromBuffer(data);
      case MetaplexFixedPriceSaleProgramInstruction.closeMarket:
        return MetaplexFixedPriceSaleCloseMarketLayout.fromBuffer(data);
      case MetaplexFixedPriceSaleProgramInstruction.createMarket:
        return MetaplexFixedPriceSaleCreateMarketLayout.fromBuffer(data);
      case MetaplexFixedPriceSaleProgramInstruction.createStore:
        return MetaplexFixedPriceSaleCreateStoreLayout.fromBuffer(data);
      case MetaplexFixedPriceSaleProgramInstruction.initSellingResource:
        return MetaplexFixedPriceSaleInitSellingResourceLayout.fromBuffer(data);
      case MetaplexFixedPriceSaleProgramInstruction.resumeMarket:
        return MetaplexFixedPriceSaleResumeMarketLayout.fromBuffer(data);
      case MetaplexFixedPriceSaleProgramInstruction.savePrimaryMetadataCreators:
        return MetaplexFixedPriceSaleSavePrimaryMetadataCreatorsLayout
            .fromBuffer(data);
      case MetaplexFixedPriceSaleProgramInstruction.suspendMarket:
        return MetaplexFixedPriceSaleSuspendMarketLayout.fromBuffer(data);
      case MetaplexFixedPriceSaleProgramInstruction.withdraw:
        return MetaplexFixedPriceSaleWithdrawLayout.fromBuffer(data);
      default:
        return UnknownProgramLayout(data);
    }
  }

  static Map<String, dynamic> decodeAndValidateStruct({
    required StructLayout layout,
    required List<int> bytes,
    required List<int> instruction,
  }) {
    final decode = layout.deserialize(bytes).value;
    final instcutionData = decode["instruction"];
    if (!BytesUtils.bytesEqual(instcutionData, instruction)) {
      throw SolanaPluginException("invalid instruction bytes", details: {
        "expected": BytesUtils.toHexString(instruction),
        "instruction": BytesUtils.toBinary(instcutionData)
      });
    }

    return decode;
  }
}
