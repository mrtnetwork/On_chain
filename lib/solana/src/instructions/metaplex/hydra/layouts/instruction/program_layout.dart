import 'package:blockchain_utils/utils/utils.dart';

import 'package:on_chain/solana/src/exception/exception.dart';
import 'package:blockchain_utils/layout/layout.dart';
import 'package:on_chain/solana/src/borsh_serialization/program_layout.dart';
import 'package:on_chain/solana/src/instructions/metaplex/hydra/layouts/layouts/add_member_nft.dart';
import 'package:on_chain/solana/src/instructions/metaplex/hydra/layouts/layouts/add_member_wallet.dart';
import 'package:on_chain/solana/src/instructions/metaplex/hydra/layouts/layouts/distribute_nft.dart';
import 'package:on_chain/solana/src/instructions/metaplex/hydra/layouts/layouts/distribute_token.dart';
import 'package:on_chain/solana/src/instructions/metaplex/hydra/layouts/layouts/distribute_wallet.dart';
import 'package:on_chain/solana/src/instructions/metaplex/hydra/layouts/layouts/init.dart';
import 'package:on_chain/solana/src/instructions/metaplex/hydra/layouts/layouts/init_for_mint.dart';
import 'package:on_chain/solana/src/instructions/metaplex/hydra/layouts/layouts/remove_member.dart';
import 'package:on_chain/solana/src/instructions/metaplex/hydra/layouts/layouts/set_for_token_member_stake.dart';
import 'package:on_chain/solana/src/instructions/metaplex/hydra/layouts/layouts/set_token_member_stake.dart';
import 'package:on_chain/solana/src/instructions/metaplex/hydra/layouts/layouts/sign_metadata.dart';
import 'package:on_chain/solana/src/instructions/metaplex/hydra/layouts/layouts/transfer_shares.dart';
import 'package:on_chain/solana/src/instructions/metaplex/hydra/layouts/layouts/unstake.dart';

import 'instructions.dart';

abstract class MetaplexHydraProgramLayout extends ProgramLayout {
  const MetaplexHydraProgramLayout();
  static final StructLayout _layout =
      LayoutConst.struct([LayoutConst.blob(8, property: "instruction")]);
  @override
  abstract final MetaplexHydraProgramInstruction instruction;

  static ProgramLayout fromBytes(List<int> data) {
    final decode =
        ProgramLayout.decodeAndValidateStruct(layout: _layout, bytes: data);
    final MetaplexHydraProgramInstruction? instruction =
        MetaplexHydraProgramInstruction.getInstruction(decode["instruction"]);
    switch (instruction) {
      case MetaplexHydraProgramInstruction.processAddMemberNft:
        return MetaplexHydraAddMemberNftLayout.fromBuffer(data);
      case MetaplexHydraProgramInstruction.processAddMemberWallet:
        return MetaplexHydraAddMemberWalletLayout.fromBuffer(data);
      case MetaplexHydraProgramInstruction.processDistributeNft:
        return MetaplexHydraDistributeNftLayout.fromBuffer(data);
      case MetaplexHydraProgramInstruction.processDistributeToken:
        return MetaplexHydraDistributeTokenLayout.fromBuffer(data);
      case MetaplexHydraProgramInstruction.processDistributeWallet:
        return MetaplexHydraDistributeWalletLayout.fromBuffer(data);
      case MetaplexHydraProgramInstruction.processInit:
        return MetaplexHydraInitLayout.fromBuffer(data);
      case MetaplexHydraProgramInstruction.processInitForMint:
        return MetaplexHydraInitForMintLayout.fromBuffer(data);
      case MetaplexHydraProgramInstruction.processRemoveMember:
        return MetaplexHydraRemoveMemberLayout.fromBuffer(data);
      case MetaplexHydraProgramInstruction.processSetForTokenMemberStake:
        return MetaplexHydraSetForTokenMemberStakeLayout.fromBuffer(data);
      case MetaplexHydraProgramInstruction.processSetTokenMemberStake:
        return MetaplexHydraSetTokenMemberStakeLayout.fromBuffer(data);
      case MetaplexHydraProgramInstruction.processSignMetadata:
        return MetaplexHydraSignMetadataLayout.fromBuffer(data);
      case MetaplexHydraProgramInstruction.processTransferShares:
        return MetaplexHydraTransferSharesLayout.fromBuffer(data);
      case MetaplexHydraProgramInstruction.processUnstake:
        return MetaplexHydraUnstakeLayout.fromBuffer(data);
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
