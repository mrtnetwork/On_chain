import 'package:blockchain_utils/layout/constant/constant.dart';
import 'package:blockchain_utils/layout/core/types/struct.dart';
import 'package:on_chain/solana/src/borsh_serialization/program_layout.dart';
import 'package:on_chain/solana/src/instructions/metaplex/nft_packs/layouts/layouts/activate.dart';
import 'package:on_chain/solana/src/instructions/metaplex/nft_packs/layouts/layouts/add_card_to_pack.dart';
import 'package:on_chain/solana/src/instructions/metaplex/nft_packs/layouts/layouts/add_voucher_to_pack.dart';
import 'package:on_chain/solana/src/instructions/metaplex/nft_packs/layouts/layouts/claim_pack.dart';
import 'package:on_chain/solana/src/instructions/metaplex/nft_packs/layouts/layouts/clean_up.dart';
import 'package:on_chain/solana/src/instructions/metaplex/nft_packs/layouts/layouts/close_pack.dart';
import 'package:on_chain/solana/src/instructions/metaplex/nft_packs/layouts/layouts/deactivate.dart';
import 'package:on_chain/solana/src/instructions/metaplex/nft_packs/layouts/layouts/delete_pack.dart';
import 'package:on_chain/solana/src/instructions/metaplex/nft_packs/layouts/layouts/delete_pack_card.dart';
import 'package:on_chain/solana/src/instructions/metaplex/nft_packs/layouts/layouts/delete_pack_config.dart';
import 'package:on_chain/solana/src/instructions/metaplex/nft_packs/layouts/layouts/delete_pack_voucher.dart';
import 'package:on_chain/solana/src/instructions/metaplex/nft_packs/layouts/layouts/edit_pack.dart';
import 'package:on_chain/solana/src/instructions/metaplex/nft_packs/layouts/layouts/init_pack.dart';
import 'package:on_chain/solana/src/instructions/metaplex/nft_packs/layouts/layouts/request_card_for_redeem.dart';
import 'package:on_chain/solana/src/instructions/metaplex/nft_packs/layouts/layouts/transfer_pack_authority.dart';

import 'instructions.dart';

abstract class MetaplexNFTPacksProgramLayout extends ProgramLayout {
  const MetaplexNFTPacksProgramLayout();
  static final StructLayout _layout =
      LayoutConst.struct([LayoutConst.u8(property: "instruction")]);
  @override
  abstract final MetaplexNFTPacksProgramInstruction instruction;
  static ProgramLayout fromBytes(List<int> data) {
    final decode =
        ProgramLayout.decodeAndValidateStruct(layout: _layout, bytes: data);
    final MetaplexNFTPacksProgramInstruction? instruction =
        MetaplexNFTPacksProgramInstruction.getInstruction(
            decode["instruction"]);

    switch (instruction) {
      case MetaplexNFTPacksProgramInstruction.activate:
        return MetaplexNFTPacksActivateLayout.fromBuffer(data);
      case MetaplexNFTPacksProgramInstruction.addCardToPack:
        return MetaplexNFTPacksAddCardToPackLayout.fromBuffer(data);
      case MetaplexNFTPacksProgramInstruction.addVoucherToPack:
        return MetaplexNFTPacksAddVoucherToPackLayout.fromBuffer(data);
      case MetaplexNFTPacksProgramInstruction.claimPack:
        return MetaplexNFTPacksClaimPackLayout.fromBuffer(data);
      case MetaplexNFTPacksProgramInstruction.cleanUp:
        return MetaplexNFTPacksCleanUpLayout.fromBuffer(data);
      case MetaplexNFTPacksProgramInstruction.closePack:
        return MetaplexNFTPacksClosePackLayout.fromBuffer(data);
      case MetaplexNFTPacksProgramInstruction.deactivate:
        return MetaplexNFTPacksDeactivateLayout.fromBuffer(data);
      case MetaplexNFTPacksProgramInstruction.deletePack:
        return MetaplexNFTPacksDeletePackLayout.fromBuffer(data);
      case MetaplexNFTPacksProgramInstruction.deletePackCard:
        return MetaplexNFTPacksDeletePackCardLayout.fromBuffer(data);
      case MetaplexNFTPacksProgramInstruction.deletePackConfig:
        return MetaplexNFTPacksDeletePackConfigLayout.fromBuffer(data);
      case MetaplexNFTPacksProgramInstruction.deletePackVoucher:
        return MetaplexNFTPacksDeletePackVoucherLayout.fromBuffer(data);
      case MetaplexNFTPacksProgramInstruction.editPack:
        return MetaplexNFTPacksEditPackLayout.fromBuffer(data);
      case MetaplexNFTPacksProgramInstruction.initPack:
        return MetaplexNFTPacksInitPackLayout.fromBuffer(data);
      case MetaplexNFTPacksProgramInstruction.requestCardForRedeem:
        return MetaplexNFTPacksRequestCardForRedeemLayout.fromBuffer(data);
      case MetaplexNFTPacksProgramInstruction.transferPackAuthority:
        return MetaplexNFTPacksTransferPackAuthorityLayout.fromBuffer(data);
      default:
        return UnknownProgramLayout(data);
    }
  }
}
