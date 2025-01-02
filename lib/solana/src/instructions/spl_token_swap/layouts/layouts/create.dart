import 'package:blockchain_utils/utils/utils.dart';
import 'package:on_chain/solana/src/instructions/spl_token_swap/layouts/instruction/instruction.dart';
import 'package:on_chain/solana/src/instructions/spl_token_swap/types/types.dart';
import 'package:blockchain_utils/layout/layout.dart';
import 'package:on_chain/solana/src/borsh_serialization/program_layout.dart';

/// Initializes a new swap layout
class SPLTokenSwapInitSwapLayout extends SPLTokenSwapProgramLayout {
  /// all swap fees
  final TokenSwapFees fees;

  /// swap curve info for pool
  final SPLTokenSwapCurveType curveType;

  /// The curve parameters.
  final List<int> curveParameters;
  SPLTokenSwapInitSwapLayout({
    required this.fees,
    required this.curveType,
    required List<int> curveParameters,
  }) : curveParameters =
            BytesUtils.toBytes(curveParameters, unmodifiable: true);

  /// Constructs a [SPLTokenSwapInitSwapLayout] instance from the given byte array.
  factory SPLTokenSwapInitSwapLayout.fromBuffer(List<int> bytes) {
    final decode = ProgramLayout.decodeAndValidateStruct(
      layout: _layout,
      bytes: bytes,
      instruction: SPLTokenSwapProgramInstruction.initSwap.insturction,
    );

    return SPLTokenSwapInitSwapLayout(
      fees: TokenSwapFees.fromJson(decode['fees']),
      curveType: SPLTokenSwapCurveType.fromValue(decode['curveType']),
      curveParameters: decode['curveParameters'],
    );
  }

  /// The layout structure for creating a token swap.
  static final StructLayout _layout = LayoutConst.struct([
    LayoutConst.u8(property: 'instruction'),
    TokenSwapFees.staticLayout,
    LayoutConst.u8(property: 'curveType'),
    LayoutConst.blob(32, property: 'curveParameters'),
  ]);
  @override
  StructLayout get layout => _layout;

  @override
  SPLTokenSwapProgramInstruction get instruction =>
      SPLTokenSwapProgramInstruction.initSwap;

  @override
  Map<String, dynamic> serialize() {
    final curveParam = List<int>.filled(32, 0);
    curveParam.setAll(0, curveParameters);
    return {
      'fees': fees.serialize(),
      'curveType': curveType.value,
      'curveParameters': curveParam,
    };
  }
}
