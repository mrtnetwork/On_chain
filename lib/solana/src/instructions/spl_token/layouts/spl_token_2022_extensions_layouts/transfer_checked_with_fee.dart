import 'package:on_chain/solana/src/instructions/spl_token/layouts/instruction/instruction.dart';
import 'package:blockchain_utils/layout/layout.dart';
import 'package:on_chain/solana/src/borsh_serialization/program_layout.dart';

/// Transfer, providing expected mint information and fees layout.
class SPLToken2022TransferCheckedWithFeeLayout extends SPLTokenProgramLayout {
  /// /// The amount of tokens to transfer.
  final BigInt amount;

  /// Expected number of base 10 digits to the right of the decimal place.
  final int decimals;

  /// Expected fee assessed on this transfer, calculated off-chain based
  /// on the transfer_fee_basis_points and maximum_fee of the
  /// mint.
  final BigInt fee;

  SPLToken2022TransferCheckedWithFeeLayout(
      {required this.amount, required this.decimals, required this.fee});

  factory SPLToken2022TransferCheckedWithFeeLayout.fromBuffer(List<int> bytes) {
    final decode = ProgramLayout.decodeAndValidateStruct(
        layout: _layout,
        bytes: bytes,
        instruction:
            SPLTokenProgramInstruction.transferFeeExtension.insturction);
    return SPLToken2022TransferCheckedWithFeeLayout(
        amount: decode["amount"],
        decimals: decode["decimals"],
        fee: decode["fee"]);
  }

  static final StructLayout _layout = LayoutConst.struct([
    LayoutConst.u8(property: "instruction"),
    LayoutConst.u8(property: "transferFee"),
    LayoutConst.u64(property: "amount"),
    LayoutConst.u8(property: "decimals"),
    LayoutConst.u64(property: "fee"),
  ]);

  @override
  StructLayout get layout => _layout;

  @override
  final int instruction =
      SPLTokenProgramInstruction.transferFeeExtension.insturction;

  @override
  Map<String, dynamic> serialize() {
    return {
      "transferFee":
          TransferFeeInstructionInstruction.transferCheckedWithFee.value,
      "amount": amount,
      "decimals": decimals,
      "fee": fee
    };
  }
}
