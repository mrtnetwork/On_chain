import 'package:blockchain_utils/utils/utils.dart';
import 'package:on_chain/solana/src/address/sol_address.dart';
import 'package:on_chain/solana/src/instructions/metaplex/gumdrop/layouts/instruction/instruction.dart';
import 'package:blockchain_utils/layout/layout.dart';
import 'package:on_chain/solana/src/utils/layouts.dart';

class MetaplexGumdropClaimCandyLayout extends MetaplexGumdropProgramLayout {
  final int walletBump;
  final int claimBump;
  final BigInt index;
  final BigInt amount;
  final SolAddress claimantSecret;
  final List<List<int>> proof;
  MetaplexGumdropClaimCandyLayout(
      {required this.walletBump,
      required this.claimBump,
      required this.index,
      required this.amount,
      required this.claimantSecret,
      required List<List<int>> proof})
      : proof = List<List<int>>.unmodifiable(
            proof.map((e) => BytesUtils.toBytes(e, unmodifiable: true)));

  factory MetaplexGumdropClaimCandyLayout.fromBuffer(List<int> data) {
    final decode = MetaplexGumdropProgramLayout.decodeAndValidateStruct(
        layout: _layout,
        bytes: data,
        instruction: MetaplexGumdropProgramInstruction.claimCandy.insturction);
    return MetaplexGumdropClaimCandyLayout(
        walletBump: decode["walletBump"],
        claimBump: decode["claimBump"],
        index: decode["index"],
        amount: decode["amount"],
        claimantSecret: decode["claimantSecret"],
        proof: (decode["proof"] as List).cast());
  }

  /// StructLayout layout definition.
  static final StructLayout _layout = LayoutConst.struct([
    LayoutConst.blob(8, property: "instruction"),
    LayoutConst.u8(property: "walletBump"),
    LayoutConst.u8(property: "claimBump"),
    LayoutConst.u64(property: "index"),
    LayoutConst.u64(property: "amount"),
    SolanaLayoutUtils.publicKey("claimantSecret"),
    LayoutConst.vec(LayoutConst.blob(32), property: "proof"),
  ]);

  @override
  StructLayout get layout => _layout;

  @override
  MetaplexGumdropProgramInstruction get instruction =>
      MetaplexGumdropProgramInstruction.claimCandy;

  @override
  Map<String, dynamic> serialize() {
    return {
      "walletBump": walletBump,
      "claimBump": claimBump,
      "index": index,
      "amount": amount,
      "claimantSecret": claimantSecret,
      "proof": proof
    };
  }
}
