import 'package:on_chain/solana/src/address/sol_address.dart';
import 'package:on_chain/solana/src/instructions/spl_token/layouts/instruction/instruction.dart';
import 'package:on_chain/solana/src/layout/layout.dart';

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

  static final Structure _layout = LayoutUtils.struct([
    LayoutUtils.u8("instruction"),
    LayoutUtils.u8("transferFee"),
    LayoutUtils.cOptionalPublicKey(property: "transferFeeConfigAuthority"),
    LayoutUtils.cOptionalPublicKey(property: "withdrawWithheldAuthority"),
    LayoutUtils.u16("transferFeeBasisPoints"),
    LayoutUtils.u64("maximumFee")
  ]);

  factory SPLToken2022InitializeTransferFeeConfigLayout.fromBuffer(
      List<int> bytes) {
    final decode = ProgramLayout.decodeAndValidateStruct(
        layout: _layout,
        bytes: bytes,
        instruction:
            SPLTokenProgramInstruction.transferFeeExtension.insturction);
    return SPLToken2022InitializeTransferFeeConfigLayout(
        transferFeeConfigAuthority: decode["transferFeeConfigAuthority"],
        withdrawWithheldAuthority: decode["withdrawWithheldAuthority"],
        transferFeeBasisPoints: decode["transferFeeBasisPoints"],
        maximumFee: decode["maximumFee"]);
  }

  @override
  Structure get layout => _layout;

  @override
  final int instruction =
      SPLTokenProgramInstruction.transferFeeExtension.insturction;

  @override
  Map<String, dynamic> serialize() {
    return {
      "transferFee":
          TransferFeeInstructionInstruction.initializeTransferFeeConfig.value,
      "transferFeeConfigAuthority": transferFeeConfigAuthority,
      "withdrawWithheldAuthority": withdrawWithheldAuthority,
      "transferFeeBasisPoints": transferFeeBasisPoints,
      "maximumFee": maximumFee
    };
  }
}
