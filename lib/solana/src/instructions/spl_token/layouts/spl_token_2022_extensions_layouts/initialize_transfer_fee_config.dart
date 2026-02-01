import 'package:on_chain/solana/src/address/sol_address.dart';
import 'package:on_chain/solana/src/instructions/spl_token/layouts/instruction/instruction.dart';
import 'package:blockchain_utils/layout/layout.dart';
import 'package:on_chain/solana/src/borsh_serialization/program_layout.dart';
import 'package:on_chain/solana/src/utils/layouts.dart';

/// Initialize the transfer fee on a new mint layout.
class SPLToken2022InitializeTransferFeeConfigLayout
    extends SPLTokenProgramLayout {
  /// Pubkey that may update the fees
  final SolAddress? transferFeeConfigAuthority;

  /// Withdraw instructions must be signed by this key
  final SolAddress? withdrawWithheldAuthority;

  /// Amount of transfer collected as fees, expressed as basis points of
  /// the transfer amount
  final int transferFeeBasisPoints;

  /// Maximum fee assessed on transfers
  final BigInt maximumFee;
  SPLToken2022InitializeTransferFeeConfigLayout(
      {this.transferFeeConfigAuthority,
      this.withdrawWithheldAuthority,
      required this.transferFeeBasisPoints,
      required this.maximumFee});

  static StructLayout get _layout => LayoutConst.struct([
        LayoutConst.u8(property: 'instruction'),
        LayoutConst.u8(property: 'transferFee'),
        SolanaLayoutUtils.cOptionPubkey(property: 'transferFeeConfigAuthority'),
        SolanaLayoutUtils.cOptionPubkey(property: 'withdrawWithheldAuthority'),
        LayoutConst.u16(property: 'transferFeeBasisPoints'),
        LayoutConst.u64(property: 'maximumFee')
      ]);

  factory SPLToken2022InitializeTransferFeeConfigLayout.fromBuffer(
      List<int> bytes) {
    final decode = ProgramLayout.decodeAndValidateStruct(
        layout: _layout,
        bytes: bytes,
        instruction:
            SPLTokenProgramInstruction.transferFeeExtension.insturction);
    return SPLToken2022InitializeTransferFeeConfigLayout(
        transferFeeConfigAuthority: decode['transferFeeConfigAuthority'],
        withdrawWithheldAuthority: decode['withdrawWithheldAuthority'],
        transferFeeBasisPoints: decode['transferFeeBasisPoints'],
        maximumFee: decode['maximumFee']);
  }

  @override
  StructLayout get layout => _layout;

  @override
  final SPLTokenProgramInstruction instruction =
      SPLTokenProgramInstruction.transferFeeExtension;

  @override
  Map<String, dynamic> serialize() {
    return {
      'transferFee':
          TransferFeeInstructionInstruction.initializeTransferFeeConfig.value,
      'transferFeeConfigAuthority': transferFeeConfigAuthority,
      'withdrawWithheldAuthority': withdrawWithheldAuthority,
      'transferFeeBasisPoints': transferFeeBasisPoints,
      'maximumFee': maximumFee
    };
  }
}
