import 'package:blockchain_utils/utils/utils.dart';

import 'package:on_chain/solana/src/exception/exception.dart';
import 'package:blockchain_utils/layout/layout.dart';
import 'package:on_chain/solana/src/borsh_serialization/program_layout.dart';
import 'package:on_chain/solana/src/instructions/metaplex/gumdrop/layouts/layouts/claim.dart';
import 'package:on_chain/solana/src/instructions/metaplex/gumdrop/layouts/layouts/claim_candy.dart';
import 'package:on_chain/solana/src/instructions/metaplex/gumdrop/layouts/layouts/claim_candy_proven.dart';
import 'package:on_chain/solana/src/instructions/metaplex/gumdrop/layouts/layouts/claim_edition.dart';
import 'package:on_chain/solana/src/instructions/metaplex/gumdrop/layouts/layouts/close_distributor.dart';
import 'package:on_chain/solana/src/instructions/metaplex/gumdrop/layouts/layouts/close_distributor_token_account.dart';
import 'package:on_chain/solana/src/instructions/metaplex/gumdrop/layouts/layouts/new_distributor.dart';
import 'package:on_chain/solana/src/instructions/metaplex/gumdrop/layouts/layouts/prove_claim.dart';
import 'package:on_chain/solana/src/instructions/metaplex/gumdrop/layouts/layouts/recover_update_authority.dart';

import 'instructions.dart';

abstract class MetaplexGumdropProgramLayout extends ProgramLayout {
  const MetaplexGumdropProgramLayout();
  static final StructLayout _layout =
      LayoutConst.struct([LayoutConst.blob(8, property: 'instruction')]);
  @override
  abstract final MetaplexGumdropProgramInstruction instruction;

  static ProgramLayout fromBytes(List<int> data) {
    final decode =
        ProgramLayout.decodeAndValidateStruct(layout: _layout, bytes: data);
    final MetaplexGumdropProgramInstruction? instruction =
        MetaplexGumdropProgramInstruction.getInstruction(decode['instruction']);

    switch (instruction) {
      case MetaplexGumdropProgramInstruction.claim:
        return MetaplexGumdropClaimLayout.fromBuffer(data);
      case MetaplexGumdropProgramInstruction.claimCandy:
        return MetaplexGumdropClaimCandyLayout.fromBuffer(data);
      case MetaplexGumdropProgramInstruction.claimEdition:
        return MetaplexGumdropClaimEditionLayout.fromBuffer(data);
      case MetaplexGumdropProgramInstruction.closeDistributor:
        return MetaplexGumdropCloseDistributorLayout.fromBuffer(data);
      case MetaplexGumdropProgramInstruction.closeDistributorTokenAccount:
        return MetaplexGumdropCloseDistributorTokenAccountLayout.fromBuffer(
            data);
      case MetaplexGumdropProgramInstruction.newDistributor:
        return MetaplexGumdropNewDistributorLayout.fromBuffer(data);
      case MetaplexGumdropProgramInstruction.proveClaim:
        return MetaplexGumdropProveClaimLayout.fromBuffer(data);
      case MetaplexGumdropProgramInstruction.recoverUpdateAuthority:
        return MetaplexGumdropRecoverUpdateAuthorityLayout.fromBuffer(data);
      case MetaplexGumdropProgramInstruction.claimCandyProven:
        return MetaplexGumdropClaimCandyProvenLayout.fromBuffer(data);
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
    final instcutionData = decode['instruction'];
    if (!BytesUtils.bytesEqual(instcutionData, instruction)) {
      throw SolanaPluginException('invalid instruction bytes', details: {
        'expected': BytesUtils.toHexString(instruction),
        'instruction': BytesUtils.toBinary(instcutionData)
      });
    }

    return decode;
  }
}
