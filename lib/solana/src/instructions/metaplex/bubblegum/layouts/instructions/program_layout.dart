import 'package:blockchain_utils/utils/utils.dart';
import 'package:on_chain/solana/src/exception/exception.dart';
import 'package:blockchain_utils/layout/layout.dart';
import 'package:on_chain/solana/src/borsh_serialization/program_layout.dart';
import 'package:on_chain/solana/src/instructions/metaplex/bubblegum/layouts/layouts/burn.dart';
import 'package:on_chain/solana/src/instructions/metaplex/bubblegum/layouts/layouts/cancel_redeem.dart';
import 'package:on_chain/solana/src/instructions/metaplex/bubblegum/layouts/layouts/create_tree.dart';
import 'package:on_chain/solana/src/instructions/metaplex/bubblegum/layouts/layouts/decompress_v1.dart';
import 'package:on_chain/solana/src/instructions/metaplex/bubblegum/layouts/layouts/delegate.dart';
import 'package:on_chain/solana/src/instructions/metaplex/bubblegum/layouts/layouts/mint_to_collection_v1.dart';
import 'package:on_chain/solana/src/instructions/metaplex/bubblegum/layouts/layouts/mint_v1.dart';
import 'package:on_chain/solana/src/instructions/metaplex/bubblegum/layouts/layouts/redeem.dart';
import 'package:on_chain/solana/src/instructions/metaplex/bubblegum/layouts/layouts/set_and_verify_collection.dart';
import 'package:on_chain/solana/src/instructions/metaplex/bubblegum/layouts/layouts/set_decompressible_state.dart';
import 'package:on_chain/solana/src/instructions/metaplex/bubblegum/layouts/layouts/set_tree_delegate.dart';
import 'package:on_chain/solana/src/instructions/metaplex/bubblegum/layouts/layouts/transfer.dart';
import 'package:on_chain/solana/src/instructions/metaplex/bubblegum/layouts/layouts/unverify_collection.dart';
import 'package:on_chain/solana/src/instructions/metaplex/bubblegum/layouts/layouts/unverify_creator.dart';
import 'package:on_chain/solana/src/instructions/metaplex/bubblegum/layouts/layouts/update_metadata.dart';
import 'package:on_chain/solana/src/instructions/metaplex/bubblegum/layouts/layouts/verify_collection.dart';
import 'package:on_chain/solana/src/instructions/metaplex/bubblegum/layouts/layouts/verify_creator.dart';
import 'package:on_chain/solana/src/instructions/metaplex/bubblegum/layouts/layouts/verify_leaf.dart';

import 'instructions.dart';

abstract class MetaplexBubblegumProgramLayout extends ProgramLayout {
  const MetaplexBubblegumProgramLayout();
  static final StructLayout _layout =
      LayoutConst.struct([LayoutConst.blob(8, property: "instruction")]);
  @override
  abstract final MetaplexBubblegumProgramInstruction instruction;

  static ProgramLayout fromBytes(List<int> data) {
    final decode =
        ProgramLayout.decodeAndValidateStruct(layout: _layout, bytes: data);
    MetaplexBubblegumProgramInstruction? instruction =
        MetaplexBubblegumProgramInstruction.getInstruction(
            decode["instruction"]);
    switch (instruction) {
      case MetaplexBubblegumProgramInstruction.burn:
        return MetaplexBubblegumBurnLayout.fromBuffer(data);
      case MetaplexBubblegumProgramInstruction.cancelRedeem:
        return MetaplexBubblegumCancelRedeemLayout.fromBuffer(data);
      case MetaplexBubblegumProgramInstruction.createTreeConfig:
        return MetaplexBubblegumCreateTreeLayout.fromBuffer(data);
      case MetaplexBubblegumProgramInstruction.decompressV1:
        return MetaplexBubblegumDecompressV1Layout.fromBuffer(data);
      case MetaplexBubblegumProgramInstruction.delegate:
        return MetaplexBubblegumDelegateLayout.fromBuffer(data);
      case MetaplexBubblegumProgramInstruction.mintToCollectionV1:
        return MetaplexBubblegumMintToCollectionV1Layout.fromBuffer(data);
      case MetaplexBubblegumProgramInstruction.mintV1:
        return MetaplexBubblegumMintV1Layout.fromBuffer(data);
      case MetaplexBubblegumProgramInstruction.redeem:
        return MetaplexBubblegumRedeemLayout.fromBuffer(data);
      case MetaplexBubblegumProgramInstruction.setAndVerifyCollection:
        return MetaplexBubblegumSetAndVerifyCollectionLayout.fromBuffer(data);
      case MetaplexBubblegumProgramInstruction.setDecompressibleState:
        return MetaplexBubblegumSetDecompressibleStateLayout.fromBuffer(data);
      case MetaplexBubblegumProgramInstruction.setTreeDelegate:
        return MetaplexBubblegumSetTreeDelegateLayout.fromBuffer(data);
      case MetaplexBubblegumProgramInstruction.transfer:
        return MetaplexBubblegumTransferLayout.fromBuffer(data);
      case MetaplexBubblegumProgramInstruction.unverifyCollection:
        return MetaplexBubblegumUnverifyCollectionLayout.fromBuffer(data);
      case MetaplexBubblegumProgramInstruction.unverifyCreator:
        return MetaplexBubblegumUnverifyCreatorLayout.fromBuffer(data);
      case MetaplexBubblegumProgramInstruction.updateMetadata:
        return MetaplexBubblegumUpdateMetadataLayout.fromBuffer(data);
      case MetaplexBubblegumProgramInstruction.verifyCollection:
        return MetaplexBubblegumVerifyCollectionLayout.fromBuffer(data);
      case MetaplexBubblegumProgramInstruction.verifyCreator:
        return MetaplexBubblegumVerifyCreatorLayout.fromBuffer(data);
      case MetaplexBubblegumProgramInstruction.verifyLeaf:
        return MetaplexBubblegumVerifyLeafLayout.fromBuffer(data);
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
