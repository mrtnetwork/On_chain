import 'package:blockchain_utils/layout/layout.dart';
import 'package:blockchain_utils/utils/utils.dart';
import 'package:on_chain/solana/src/address/sol_address.dart';
import 'package:on_chain/solana/src/borsh_serialization/program_layout.dart';
import 'package:on_chain/solana/src/exception/exception.dart';
// import 'package:on_chain/solana/src/instructions/associated_token_account/constant.dart';
import 'package:on_chain/solana/src/instructions/instructions.dart';

/// Abstract class for Borsh serializable programs.
abstract class ProgramLayout extends LayoutSerializable {
  const ProgramLayout();

  /// The layout representing the structure of the program.
  @override
  abstract final StructLayout layout;

  /// The instruction of the program.
  abstract final ProgramLayoutInstruction instruction;

  /// Serializes the program.
  @override
  Map<String, dynamic> serialize();

  /// Converts the program to bytes using Borsh serialization.
  @override
  List<int> toBytes() {
    return layout
        .serialize({"instruction": instruction.insturction, ...serialize()});
  }

  /// Converts the program to a hexadecimal string.
  @override
  String toHex() {
    return BytesUtils.toHexString(toBytes());
  }

  /// Decodes and validates Borsh serialized bytes.
  ///
  /// - [layout] : The layout representing the structure of the program.
  /// - [bytes] : The bytes to decode.
  /// - [instruction] (optional): The expected instruction index.
  /// - [discriminator] (optional): The expected discriminator.
  static Map<String, dynamic> decodeAndValidateStruct({
    required StructLayout layout,
    required List<int> bytes,
    int? instruction,
    int? discriminator,
  }) {
    final decode = layout.deserialize(bytes).value;
    if (instruction != null) {
      if (decode["instruction"] != instruction) {
        throw SolanaPluginException("invalid instruction index", details: {
          "excepted": instruction,
          "instruction": decode["instruction"]
        });
      }
    }
    if (discriminator != null) {
      if (decode["discriminator"] != discriminator) {
        throw SolanaPluginException("invalid discriminator", details: {
          "excepted": discriminator,
          "instruction": decode["discriminator"]
        });
      }
    }
    return decode;
  }

  factory ProgramLayout.fromBytes({
    required SolAddress programId,
    required List<int> instructionBytes,
  }) {
    try {
      if (programId == AddressLookupTableProgramConst.programId) {
        return AddressLookupTableProgramLayout.fromBytes(instructionBytes);
      } else if (programId == ComputeBudgetConst.programId) {
        return ComputeBudgetProgramLayout.fromBytes(instructionBytes);
      } else if (programId == Ed25519ProgramConst.programId) {
        return Ed25519ProgramLayout.fromBuffer(instructionBytes);
      } else if (programId == MemoProgramConst.programId) {
        return MemoLayout.fromBuffer(instructionBytes);
      } else if (programId == NameServiceProgramConst.programId) {
        return NameServiceProgramLayout.fromBytes(instructionBytes);
      } else if (programId == Secp256k1ProgramConst.programId) {
        return Secp256k1Layout.fromBuffer(instructionBytes);
      } else if (programId == SPLTokenProgramConst.tokenProgramId ||
          programId == SPLTokenProgramConst.token2022ProgramId) {
        try {
          return SPLTokenProgramLayout.fromBytes(instructionBytes);
        } on UnimplementedError {
          return SPLTokenMetaDataProgramLayout.fromBytes(instructionBytes);
        }
      } else if (programId == SPLTokenSwapConst.oldTokenSwapProgramId ||
          programId == SPLTokenSwapConst.tokenSwapProgramId) {
      } else if (programId == StakeProgramConst.programId) {
        return StakeProgramLayout.fromBytes(instructionBytes);
      } else if (programId == StakePoolProgramConst.programId) {
        return StakePoolProgramLayout.fromBytes(instructionBytes);
      } else if (programId == SystemProgramConst.programId) {
        return SystemProgramLayout.fromBytes(instructionBytes);
      } else if (programId == VoteProgramConst.programId) {
        return VoteProgramLayout.fromBytes(instructionBytes);
      } else if (programId == TokenLendingProgramConst.lendingProgramId) {
        return TokenLendingProgramLayout.fromBytes(instructionBytes);
      } else if (programId ==
          AssociatedTokenAccountProgramConst.associatedTokenProgramId) {
        return AssociatedTokenAccountProgramLayout.fromBytes(instructionBytes);
      } else if (programId == MetaplexAuctionHouseProgramConst.programId) {
        return MetaplexAuctionHouseProgramLayout.fromBytes(instructionBytes);
      } else if (programId == MetaplexAuctioneerProgramConst.programId) {
        return MetaplexAuctioneerProgramLayout.fromBytes(instructionBytes);
      } else if (programId == MetaplexBubblegumProgramConst.programId) {
        return MetaplexBubblegumProgramLayout.fromBytes(instructionBytes);
      } else if (programId ==
              MetaplexCandyMachineCoreProgramConst.candyMachineV3programId ||
          programId ==
              MetaplexCandyMachineCoreProgramConst.candyGuardProgramId) {
        return MetaplexCandyMachineProgramLayout.fromBytes(instructionBytes);
      } else if (programId == MetaplexFixedPriceSaleProgramConst.programId) {
        return MetaplexFixedPriceSaleProgramLayout.fromBytes(instructionBytes);
      } else if (programId == MetaplexGumdropProgramConst.programId) {
        return MetaplexGumdropProgramLayout.fromBytes(instructionBytes);
      } else if (programId == MetaplexHydraProgramConst.programId) {
        return MetaplexHydraProgramLayout.fromBytes(instructionBytes);
      } else if (programId == MetaplexNFTPacksProgramConst.programId) {
        return MetaplexNFTPacksProgramLayout.fromBytes(instructionBytes);
      } else if (programId == MetaplexTokenEntanglerProgramConst.programId) {
        return MetaplexTokenEntanglerProgramLayout.fromBytes(instructionBytes);
      } else if (programId == MetaplexTokenMetaDataProgramConst.programId) {
        return MetaplexTokenMetaDataProgramLayout.fromBytes(instructionBytes);
      }
      return UnknownProgramLayout(instructionBytes);
    } catch (e) {
      return UnknownProgramLayout(instructionBytes);
    }
  }
}
