import 'package:blockchain_utils/utils/utils.dart';
import 'package:blockchain_utils/layout/layout.dart';
import 'package:on_chain/solana/src/address/sol_address.dart';
import 'package:on_chain/solana/src/instructions/metaplex/gumdrop/layouts/instruction/instruction.dart';
import 'package:on_chain/solana/src/utils/layouts.dart';

class MetaplexGumdropClaimLayout extends MetaplexGumdropProgramLayout {
  final int bump;
  final BigInt index;
  final BigInt amount;
  final SolAddress claimantSecret;
  final List<List<int>> proof;
  MetaplexGumdropClaimLayout(
      {required this.bump,
      required this.index,
      required this.amount,
      required this.claimantSecret,
      required List<List<int>> proof})
      : proof = List<List<int>>.unmodifiable(
            proof.map((e) => BytesUtils.toBytes(e, unmodifiable: true)));

  factory MetaplexGumdropClaimLayout.fromBuffer(List<int> data) {
    final decode = MetaplexGumdropProgramLayout.decodeAndValidateStruct(
        layout: _layout,
        bytes: data,
        instruction: MetaplexGumdropProgramInstruction.claim.insturction);
    return MetaplexGumdropClaimLayout(
        bump: decode["bump"],
        index: decode["index"],
        amount: decode["amount"],
        claimantSecret: decode["claimantSecret"],
        proof: (decode["proof"] as List).cast());
  }

  /// StructLayout layout definition.
  static final StructLayout _layout = LayoutConst.struct([
    LayoutConst.blob(8, property: "instruction"),
    LayoutConst.u8(property: "bump"),
    LayoutConst.u64(property: "index"),
    LayoutConst.u64(property: "amount"),
    SolanaLayoutUtils.publicKey("claimantSecret"),
    LayoutConst.vec(LayoutConst.blob(32), property: "proof"),
  ]);

  @override
  StructLayout get layout => _layout;

  @override
  MetaplexGumdropProgramInstruction get instruction =>
      MetaplexGumdropProgramInstruction.claim;

  @override
  Map<String, dynamic> serialize() {
    return {
      "bump": bump,
      "index": index,
      "amount": amount,
      "claimantSecret": claimantSecret,
      "proof": proof
    };
  }
}
