import 'package:on_chain/solana/src/instructions/spl_token_swap/layouts/instruction/instruction.dart';
import 'package:blockchain_utils/layout/layout.dart';
import 'package:on_chain/solana/src/borsh_serialization/program_layout.dart';

/// Withdraw one token type from the pool layout.
class SPLTokenSwapWithdrawSingleTokenLayout extends SPLTokenSwapProgramLayout {
  /// Amount of token A or B to receive
  final BigInt destinationTokenAmount;

  /// Maximum amount of pool tokens to burn. User receives an output of token
  /// A or B based on the percentage of the pool tokens that are returned.
  final BigInt maximumPoolTokenAmount;

  /// Constructs a [SPLTokenSwapWithdrawSingleTokenLayout] instance with the given parameters.
  const SPLTokenSwapWithdrawSingleTokenLayout({
    required this.destinationTokenAmount,
    required this.maximumPoolTokenAmount,
  });

  /// Constructs a [SPLTokenSwapWithdrawSingleTokenLayout] instance from the given byte array.
  factory SPLTokenSwapWithdrawSingleTokenLayout.fromBuffer(List<int> bytes) {
    final decode = ProgramLayout.decodeAndValidateStruct(
      layout: _layout,
      bytes: bytes,
      instruction:
          SPLTokenSwapProgramInstruction.withdrawSingleToken.insturction,
    );

    return SPLTokenSwapWithdrawSingleTokenLayout(
      destinationTokenAmount: decode["destinationTokenAmount"],
      maximumPoolTokenAmount: decode["maximumPoolTokenAmount"],
    );
  }

  /// The layout structure for withdrawing a single token.
  static final StructLayout _layout = LayoutConst.struct([
    LayoutConst.u8(property: 'instruction'),
    LayoutConst.u64(property: 'destinationTokenAmount'),
    LayoutConst.u64(property: 'maximumPoolTokenAmount'),
  ]);

  @override
  StructLayout get layout => _layout;

  @override
  int get instruction =>
      SPLTokenSwapProgramInstruction.withdrawSingleToken.insturction;

  @override
  Map<String, dynamic> serialize() {
    return {
      "destinationTokenAmount": destinationTokenAmount,
      "maximumPoolTokenAmount": maximumPoolTokenAmount,
    };
  }
}
