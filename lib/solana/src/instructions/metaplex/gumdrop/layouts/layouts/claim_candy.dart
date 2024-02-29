import 'package:blockchain_utils/binary/binary.dart';
import 'package:on_chain/solana/src/address/sol_address.dart';
import 'package:on_chain/solana/src/instructions/metaplex/gumdrop/layouts/instruction/instruction.dart';
import 'package:on_chain/solana/src/layout/layout.dart';

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

  /// Structure layout definition.
  static final Structure _layout = LayoutUtils.struct([
    LayoutUtils.blob(8, property: "instruction"),
    LayoutUtils.u8("walletBump"),
    LayoutUtils.u8("claimBump"),
    LayoutUtils.u64("index"),
    LayoutUtils.u64("amount"),
    LayoutUtils.publicKey("claimantSecret"),
    LayoutUtils.vec(LayoutUtils.blob(32), property: "proof"),
  ]);

  @override
  Structure get layout => _layout;

  @override
  List<int> get instruction =>
      MetaplexGumdropProgramInstruction.claimCandy.insturction;

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
